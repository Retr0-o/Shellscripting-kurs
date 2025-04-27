# _____ Firewall _____
Get-NetFirewallProfile  # Plockar nuvarande inställningar för brandväggsprofilerna (Domän, Privat och Publik)
Set-NetFirewallProfile  # Ändrar inställningar i brandväggen, t.ex stänga av eller sätta på en regel.
New-NetFirewallRule     # Skapar ny brandväggsregel, t.ex blockera specifik trafik.

# _____ Defender _____
Get-MpComputerStatus    # Visar status för MS Defender.
Update-MpSignature      # Uppdaterar MS Defender.
Start-MpScan            # Kör en skanning av systemet med Defender.

# _____ Användare _____
Get-LocalGroupMember    #  
Remove-LocalGroupMember #
Get-LocalUser
Disable-LocalUser

# _____ Protokoll _____
Get-ItemProperty
Set-ItemProperty

# _____ Tjänster _____
Get-Service
Stop-Service
Set-Service

# _____ Disk _____
Get-Volume
Move-Item
New-Item

# _____ Bitlocker _____
Get-BitLockerVolume
Enable-BitLocker

# _____ Loggning & struktur _____
Get-Date
Out-File
Write-Host
Write-Error
Write-Warning
Where-Object
ForEach-Object
Get-Content
Test-Path
Get-Member
Select-Object