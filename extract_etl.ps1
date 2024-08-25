# Define the name for your ETW session
$sessionName = "LogExtractionSession"

try {
    # Stop the trace session
    Stop-Trace -SessionName $sessionName

    Write-Host "Trace session stopped. ETL file generated at: $etlFilePath"
}
catch {
    Write-Error "An error occurred: $_"
}
