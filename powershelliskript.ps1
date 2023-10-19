
Enable-PSRemoting -Force

Get-Service rpcss
Get-Service -Name RpcSs
Start-Service -Name RpcSs



Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force



$computerName = Read-Host "Sisesta arvuti nimi"

$user = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $computerName | Select-Object -ExpandProperty UserName

$os = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computerName | Select-Object -ExpandProperty Caption

$lastLogon = (Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computerName).ConvertToDateTime((Get-WmiObject -Class Win32_OperatingSystem -ComputerName $computerName).LastBootUpTime).ToString("dd-MM-yyyy")


 
# Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object LastBootUpTime


#Uptime kalkuleeirimine ja valja sorteerimine paevadeks, tunddeks ja minutiteks
$uptime = (Get-Date) - [Management.ManagementDateTimeConverter]::ToDateTime((Get-WmiObject Win32_OperatingSystem -ComputerName $computerName).LastBootUpTime)

$days = [math]::Floor($uptime.TotalDays)
$hours = $uptime.Hours
$minutes = $uptime.Minutes




#Get-PSDrive C | Select-Object @{ E={$_.Used/1GB}; L='Used' }, @{ E={$_.Free/1GB}; L='Free' }
Write-Host "_________________________________________________________________________ "

Write-Host " "

Write-Host "Saadud andmed:"

Write-Host " "

Write-Host "Arvuti nimi: $computerName"

Write-Host " "

Write-Host "Kasutaja : $user"

Write-Host " "

Write-Host "OS versioon: $os"

Write-Host " "

Write-Host "Last logon: $lastLogon"

Write-Host " "

Write-Host "uptime on: $days päeva, $hours tundi, $minutes minutit"

Write-Host " "

Write-Host "Mälu andmed:"

get-WmiObject win32_logicaldisk -Computername $computerName


Write-Host "_________________________________________________________________________ "