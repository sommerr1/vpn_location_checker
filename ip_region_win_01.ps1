Write-Host "HELLO WORLD — скрипт запущен!"

# Получаем внешний IP
$ip = (Invoke-WebRequest -Uri "https://api.ipify.org").Content

# Получаем регион
$geo = Invoke-WebRequest -Uri "http://ip-api.com/json/$ip?fields=status,country,countryCode,regionName,city,isp,query" | ConvertFrom-Json

if ($geo.status -ne "success") {
    Write-Host "error getting geodata"
    exit
}

Write-Host "==============================="
Write-Host "   IP / REGION INFORMATION"
Write-Host "==============================="
Write-Host "IP:          $($geo.query)"
Write-Host "Country:     $($geo.country) ($($geo.countryCode))"
Write-Host "Region:      $($geo.regionName)"
Write-Host "City:        $($geo.city)"
Write-Host "ISP:         $($geo.isp)"
Write-Host ""

# Функция проверки доступности сервиса
function Test-Service {
    param(
        [string]$Name,
        [string]$Url,
        [int]$TimeoutSec = 4
    )

    try {
        $req = Invoke-WebRequest -Uri $Url -TimeoutSec $TimeoutSec -ErrorAction Stop
        return "✔️"
    }
    catch {
        return "❌"
    }
}

Write
