
$orgName = "Charon Software"
$orgId = "org-1b2c3d4e5f6g7h8i9j0"

$openAiKey = "our_api_key"

$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer $openAiKey"
}

function Get-OpenAiModels {
    $modelsUrl = "https://api.openai.com/v1/models"
    Invoke-RestMethod -Uri $modelsUrl -Headers $headers
}

# we want to list our custom assistants - the ones we've created by using the tools at https://platform.openai.com/assistants
function Get-OpenAssistantModels {
    # $modelsUrl = "https://api.openai.com/v1/models" # not this URL - correct it so it enumerates our custom assistants
    $modelsUrl = "https://api.openai.com/v1/CUSTOM_ASSISTANTS_URL" # CORRECT THIS
    Invoke-RestMethod -Uri $modelsUrl -Headers $headers
}

$customModel = "asst_KrF1Idtkc0ZUtDr4HsfgSFhS"  
function InvokeGpt4 {
    param (
        [string]$prompt,
        [int]$maxTokens = 1024,
        [int]$temperature = 1.1,
        [int]$topP = 1,
        [int]$frequencyPenalty = 0,
        [int]$presencePenalty = 0,
        [string]$model = $customModel 
    )

    $url = "https://api.openai.com/v1/chat/completions" 

    $body = @{
        model = $model
        messages = @(
            @{
                role = "system"
                content = "You are the concierge for Terran Astra, handling inquiries about pods, parks, mobility units, and the Lingua Franca project."
            },
            @{
                role = "user"
                content = $prompt
            }
        )
        max_tokens = $maxTokens
        temperature = $temperature
        top_p = $topP
        frequency_penalty = $frequencyPenalty
        presence_penalty = $presencePenalty
    } | ConvertTo-Json

    $restMethodResult = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body
    $chatMessages = $restMethodResult.choices[0].message
    $maxMessages = 20
    if ($chatMessages.Count -gt $maxMessages) {
        $chatMessages = $chatMessages[0..($maxMessages-1)]
    }
    foreach ($message in $chatMessages) {
        $roleX = $message.role
        $contentX = $message.content
        Write-Host $roleX + " : " + $contentX
    }
}

# Prompt now correctly calls the InvokeGpt4 function with the custom model.
InvokeGpt4 `
    -prompt "please tell me about our pods" `
    -maxTokens 250 `
    -temperature 0.7  # Changed to a more typical temperature for coherent responses
    -topP 1
    -frequencyPenalty 0
    -presencePenalty 0 
    -model $customModel  # Using the custom model you assigned earlier
