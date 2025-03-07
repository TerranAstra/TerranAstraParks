$openAiKey = "MY_KEY"
$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer $openAiKey"
}

# TASK - Change this to instead get OUR assistants, as callable model names
function Get-OpenAiModels {
    $modelsUrl = "https://api.openai.com/v1/models"
    $headers = @{
        "Content-Type" = "application/json"
        "Authorization" = "Bearer $openAiKey"
    }
    Invoke-RestMethod -Uri $modelsUrl -Headers $headers
}

$customModel = "CORRECT THIS - ALSO ENSURE It's being referenced correctly"
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
    # Task: Correct the URL, if applicable 
    #$url = "https://api.openai.com/v1/engines/$model/completions"

    $body = @{
        model = $model
        messages = @(
            @{
                role = "system"
                content = "you are the Terran Astra Concieerge: asst_KrF1Idtkc0ZUtDr4HsfgSFhS"
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

    $headers = @{
        "Content-Type" = "application/json"
        "Authorization" = "Bearer $openAiKey"
    }

    $restMethodResult = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body
    $chatMessages = $restMethodResult.choices[0].message
    $maxMessages = 20
    if ($chatMessages.Count -gt $maxMessages) {
        $chatMessages = $chatMessages[0..($maxMessages-1)]
    }
    foreach ($message in $chatMessages) {
        $roleX = $message.role
        $contentX = $message.content
        Write-Host "Role: $roleX, Content: $contentX"
    }
}

InvokeGpt4 `
    -prompt "please tell me about our pods" `
    -maxTokens 250 `
    -model "gpt-4"

