$customModel = "text-davinci-003" 
$openAiKey = "sk-zzz"
$url = "https://api.openai.com/v1/completions" # Correct URL for invoking the model
$custAsst = "asst_KrF1Izzz"
$headers = @{
    "Content-Type" = "application/json"
    "Authorization" = "Bearer $openAiKey"
}
function Get-OpenAiModels {
    $modelsUrl = "https://api.openai.com/v1/models"
    Invoke-RestMethod -Uri $modelsUrl -Headers $headers
}
function Get-OpenAssistantModels {
    $assistantsUrl = "https://api.openai.com/v1/assistants/" # This is a placeholder URL
    Invoke-RestMethod -Uri $assistantsUrl -Headers $headers
}
function InvokeGpt4 {
    param (
        [string]$prompt,
        [int]$maxTokens = 1024,
        [int]$temperature = 0.7,
        [int]$topP = 1,
        [int]$frequencyPenalty = 0,
        [int]$presencePenalty = 0,
        [string]$model = $customModel 
    )
    
    $body = @{
        model = $model
        prompt = $prompt
        max_tokens = $maxTokens
        temperature = $temperature
        top_p = $topP
        frequency_penalty = $frequencyPenalty
        presence_penalty = $presencePenalty
    } | ConvertTo-Json
    $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body
    $response.choices[0].text
}
Get-OpenAssistantModels
# InvokeGpt4 -prompt "please tell me about our pods"
