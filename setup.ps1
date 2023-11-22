##########
# Win10 setup script
# Author: Ceynri <ceynri@gmail.com>
# Version: v1.0, 2021-06-06
# Source: https://github.com/ceynri/win10-setup
##########

##########
# App list
##########

$msftBloats = @(
    "Microsoft.Wallet",
    "Microsoft.Messaging",
    "Microsoft.People",
    "Microsoft.GetHelp",
    "Microsoft.Getstarted",

    "Microsoft.SkypeApp",
    "Microsoft.BingNews",
    "Microsoft.BingMaps",
    "Microsoft.BingSports",
    "Microsoft.ZuneMusic",
    "Microsoft.ZuneVideo",
    "Microsoft.MicrosoftStickyNotes",

    "Microsoft.Print3D",
    "Microsoft.3DBuilder",
    "Microsoft.Microsoft3DViewer",
    "Microsoft.OneConnect",
    "Microsoft.WindowsMaps",
    "Microsoft.Windows.Cortana",
    "Microsoft.MixedReality.Portal",
    "Microsoft.MicrosoftSolitaireCollection",

    "Microsoft.WindowsFeedbackHub",
    "Microsoft.MicrosoftOfficeHub",
    "Microsoft.Office.OneNote"
    "microsoft.windowscommunicationsapps",
    "Microsoft.Advertising.Xaml"
)
$wingetApps = @(
    "Qv2ray.Qv2ray",
    # "7zip.7zip",
    # "nomacs.nomacs",
    "Bandisoft.Bandizip -v 6.29", # the old version without ads
    "Bandisoft.Honeyview",

    "Microsoft.VisualStudioCode",
    

    "Git.Git",
    "Lexikos.AutoHotkey",

    "VideoLAN.VLC", # seems that the download is slow, and easy to report errors？
    # "OBSProject.OBSStudio",
    "c0re100.qBittorrent-Enhanced-Edition",
    "SyncTrayzor.SyncTrayzor",
    "Microsoft.WindowsTerminal",
    "Anaconda.Anaconda3",

    # Browsers
    "Google.Chrome",
    "Microsoft.Edge",
    "Mozilla.Firefox",
    "Brave.Brave",

    "Readdle.Spark",
    "Python",
    "Microsoft.PowerToys",
    "tailscale.tailscale",
    "AntibodySoftware.WizTree",
    "RARLab.WinRAR",
    
    # Music
    "Spotify.Spotify",
    "9NBLGGH1RRH1", # jio saavn
    "Shabinder.SpotiFlyer",

    "9NKSQGP7F2NH", # Whatsapp
    "ProtonTechnologies.ProtonVPN",
    
    "Docker.DockerDesktop",
    "HandBrake.HandBrake",
    "Safing.Portmaster",
    "Appest.TickTick",
    "drakkan.SFTPGo",
    "Google.GoogleDrive",
    "Nvidia.GeForceExperience" ,
    "Nvidia.PhysX",
    "Famatech.AdvancedIPScanner",

    "GlassWire.GlassWire"
)
$chocoApps = @(
    "v2ray",
    "traffic-monitor",
    "nvm.portable",
    "aria2",
    # "ffmpeg",
    "freefilesync"
    # "setpoint",
)
$npmPackages = @(
    # "whistle"
)
$gitRepos = @(
    "awesome-ahk"
)

# add -url can download by wget
# Do not add extra spaces to separate app name
$notInstalledApps = @(
    "WSL"
)

##########
# Command list
##########

# import .psm1 module
Import-Module -Name "./setup.psm1" -ErrorAction Stop

# system settings
RequireAdmin
CreateTmpDir
# ActivateWin10
RenameComputerName
setPowerSettings
executeTweaks("Tweaks")

# application management
UninstallMsftBloat($msftBloats)

# install by winget
ProxyWarning
InstallWinget
InstallAppByWinget($wingetApps)
RefreshEnv

# install by choco
ChocoProxyWarning
InstallChoco
InstallAppByChoco($chocoApps)
RefreshEnv

# others
ManualInstallApp($notInstalledApps)
WaitForKey

# environment settings
SetGitNameAndEmail
# EnableGitProxy(10809)
EnableNpmRegistry
# InstallWindowsBuildTools

# others download
InstallNpmPackage($npmPackages)
CreateWorkspaceDir
CloneGitRepos($gitRepos)

# end
RemoveTmpCheck
RestartTips
