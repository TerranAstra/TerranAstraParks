$openAiKey = "sk-zzz"
$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer $openAiKey"
}

# we want to list our custom assistants, instead
function Get-OpenAiModels {
    $modelsUrl = "https://api.openai.com/v1/models"
    Invoke-RestMethod -Uri $modelsUrl -Headers $headers
}


function Get-OpenAssistantModels {
    $modelsUrl = "https://api.openai.com/v1/your_endpoint_here"
    Invoke-RestMethod -Uri $modelsUrl -Headers $headers
}

# Replace 'CORRECT THIS' with your actual custom assistant's name
$customModel = "asst_KrF1Idtkc0ZUtDr4HsfgSFhS"  #asst_KrF1Idtkc0ZUtDr4HsfgSFhS
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

    # Use the correct URL for invoking the chat model
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
