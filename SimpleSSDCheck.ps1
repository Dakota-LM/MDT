$TSEnv = New-Object -COMObject Microsoft.SMS.TSEnvironment

$CurrentDisk = $TSEnv.Value('OSDDiskIndex')

try{
	$TSEnv.Value('OSDDiskIndex') = Get-PhysicalDisk | Where MediaType -eq 'SSD' | Select -ExpandProperty DeviceID -ErrorAction Continue
	Write-Host "An SSD was found among the installed drives, updating OSDDiskIndex variable..."
	Write-Warning "OSDDiskIndex Task Sequence Variable has been changed to:    Disk " + $TSEnv.Value('OSDDiskIndex')
}catch{
	Write-Warning $_
	Write-Warning "No SSD available, continuing with disk $CurrentDisk as default..."
}