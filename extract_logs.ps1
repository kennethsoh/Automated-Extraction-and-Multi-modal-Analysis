# Define the output file
$outputFile = "C:\Users\vagrant\Desktop\\event_logs.txt"

# Clear the output file if it already exists
Clear-Content -Path $outputFile -ErrorAction SilentlyContinue

# Function to write logs to the output file
function Write-Log {
    param (
        [string]$logName
    )
    $events = Get-EventLog -LogName $logName -Newest 1000
    foreach ($event in $events) {
        Add-Content -Path $outputFile -Value "===== $logName Log ====="
        Add-Content -Path $outputFile -Value "Event ID: $($event.InstanceId)"
        Add-Content -Path $outputFile -Value "Entry Type: $($event.EntryType)"
        Add-Content -Path $outputFile -Value "Message: $($event.Message)"
        Add-Content -Path $outputFile -Value "Source: $($event.Source)"
        Add-Content -Path $outputFile -Value "Time Generated: $($event.TimeGenerated)"
        Add-Content -Path $outputFile -Value "================================="
        Add-Content -Path $outputFile -Value ""
    }
}

# Extract logs from System, Application, and Security event logs
Write-Log -logName "System"
Write-Log -logName "Application"
Write-Log -logName "Security"

Write-Host "Logs have been extracted to $outputFile."
