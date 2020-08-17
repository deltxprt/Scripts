#code editor
$VScode="https://code.visualstudio.com/Download#"
$atom="https://atom.io/download/windows_x64"
$pycharm="https://www.jetbrains.com/pycharm/download/download-thanks.html?platform=windows&code=PCC"
$npp="https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v7.8.9/npp.7.8.9.Installer.exe"

#web browser
$firefox="https://www.mozilla.org/en-US/firefox/download/thanks/"
$edge="https://go.microsoft.com/fwlink/?linkid=2108834&Channel=Stable&language=en"
$chrome="http://dl.google.com/chrome/install/375.126/chrome_installer.exe"

#Game Launcher
$rockstar="https://gamedownloads.rockstargames.com/public/installer/Rockstar-Games-Launcher.exe"
$gog="https://webinstallers.gog-statics.com/download/GOG_Galaxy_2.0.exe"
$discord="https://discord.com/api/download?platform=win"
$blizzard="https://www.battle.net/download/getInstallerForGame?os=win&locale=enUS&version=LIVE&gameProgram=BATTLENET_APP"
$steam="https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe"
$origin="https://www.dm.origin.com/download"
$uplay="http://ubi.li/4vxt9"

#utilities
$geforce="https://us.download.nvidia.com/GFE/GFEClient/3.20.4.14/GeForce_Experience_v3.20.4.14.exe"
$proton=""
$mailbird="https://www.getmailbird.com/downloading/?page-type=regular_download"
$streamdeck="https://edge.elgato.com/egc/windows/sd/Stream_Deck_4.8.1.13027.msi"
$ghub="https://download01.logi.com/web/ftp/pub/techsupport/gaming/lghub_installer.exe"

#Main Menu
function Show-Menu {
    param (
        [string]$Title = 'Software installations'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' for Code Editor."
    Write-Host "2: Press '2' for Web Browser."
    Write-Host "3: Press '3' for Game Launcher."
    Write-Host "4: Press '4' for Utilities."
    Write-Host "Q: Press 'Q' to quit."
}
do
 {
     Show-Menu
     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
         '1' {Show-Menu1} 
         '2' {Show-MenuWB} 
         '3' {Show-MenuGL} 
         '4' {Show-MenuUT}
     }
     pause
 }
 until ($selection -eq 'q')
 #Code Editor Menu
 function Show-Menu1 {
    param (
        [string]$Title = 'Code Editors'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' for Visual Studio Code."
    Write-Host "2: Press '2' for Atom."
    Write-Host "3: Press '3' for PyCharm."
    Write-Host "4: Press '4' for Notepad ++"
    Write-Host "Q: Press 'Q' to quit."
}
do
 {
     Show-Menu1
     $selection = Read-Host "Please make a selection"
     switch ($selection)
     {
        '1' {'Downloading VS Code'; Invoke-WebRequest -uri $VScode -OutFile $env:TEMP; Invoke-Expression VSCode*.exe} 
        '2' {'Downloading Atom'; Invoke-WebRequest -uri $atom -OutFile $env:TEMP; Invoke-Expression Atom*.exe} 
        '3' {'Downloading Pycharm'; Invoke-WebRequest -uri $pycharm -OutFile $env:TEMP; Invoke-Expression pycharm*.exe} 
        '4' {'Downloading Notepad ++'; Invoke-WebRequest -uri $npp -OutFile $env:TEMP; Invoke-Expression npp*.exe}
     }
     pause
 }
 until ($selection -eq 'q')

 #Web Browser Menu
function Show-MenuWB {
    param (
        [string]$Title = 'Web Browser'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' for Firefox."
    Write-Host "2: Press '2' for Edge."
    Write-Host "3: Press '3' for Chrome."
    Write-Host "Q: Press 'Q' to quit."
}

#Game Launcher
 function Show-MenuGL {
    param (
        [string]$Title = 'Game Launcher'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' for Rockstar."
    Write-Host "2: Press '2' for GOG Galaxy."
    Write-Host "3: Press '3' for Blizzard."
    Write-Host "4: Press '4' for Uplay."
    Write-Host "5: Press '5' for Steam."
    Write-Host "6: Press '6' for Origin."
    Write-Host "Q: Press 'Q' to quit."
}

#Utilities
function Show-MenuUT {
    param (
        [string]$Title = 'Utilities'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' for GeForce Experience."
    Write-Host "2: Press '2' for Proton."
    Write-Host "3: Press '3' for Mailbird."
    Write-Host "4: Press '4' for StreamDeck."
    Write-Host "5: Press '5' for Ghub."
    Write-Host "Q: Press 'Q' to quit."
}