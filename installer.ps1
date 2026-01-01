# Geo-Phone Setup Wizard (Windows)
# Version: 1.2
# Author: evilfeonix
# Converted to PowerShell

$INFO = "[+] "
$ERR  = "[-] "

$LIB = @(
    "urllib3",
    "requests",
    "opencage",
    "countryinfo",
    "phonenumbers"
)

function Slow($text, $color="White") {
    foreach ($c in $text.ToCharArray()) {
        Write-Host -NoNewline $c -ForegroundColor $color
        Start-Sleep -Milliseconds 5
    }
    Write-Host ""
}

function Load($text, $color="White") {
    Slow $text $color
    foreach ($i in 1..3) {
        Write-Host -NoNewline "."
        Start-Sleep -Seconds 1
    }
    Write-Host ""
}

function Banner {
    Clear-Host
    $ban = @"
_________               ______________          v2.0.3
__/ ____/__________     ___/ __ \__/ /___________________
_/ / __ _/ _ \  __ \______/ /_/ /_/ __ \  __ \  __ \  _ \
/ /_/ / /  __/ /_/ /_____/  ___/_/ / / / /_/ // / / /  __/
\____/  \___/\____/     /_/     /_/ /_/\____//_/ /_/\___/
"@
    Slow $ban "Magenta"
}

function Check-Internet {
    try {
        Invoke-WebRequest -Uri "https://google.com" -UseBasicParsing -TimeoutSec 5 | Out-Null
        return $true
    } catch {
        return $false
    }
}

function SetupEnv {
    Load " Setting Up Your Environment" "Green"

    foreach ($lib in $LIB) {
        pip install $lib
    }

    Slow " Installation Successfully Finished." "Green"
    Read-Host " Press ENTER to continue"
}

function Usage {
@"
Usage: python phone.py [OPTION...]

OPTIONS:
  -u     Update script
  -a     About tool
  -c     Country code (without +)
  -p     Phone number

EXAMPLES:
  python phone.py -u
  python phone.py -a
  python phone.py -c 234 -p 7000000000
"@
}

# MAIN
Banner

if (-not (Check-Internet)) {
    Slow " Status: Offline." "Red"
    Slow " Please check your internet connection" "Red"
    exit
}

Slow " Status: Online." "Green"

SetupEnv
Clear-Host
Usage

