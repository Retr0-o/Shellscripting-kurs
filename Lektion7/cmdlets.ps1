# Powershell cmdlets 
# Skriven av Hugo Backe April 2025
# Används för kursen "Shellscripting"
# Innehåller info och användning exempel om Microsofts Powershell "cmdlets".

# _____

# cmdlets skrivs med verbet för vad som ska hända först, följt av valt användningsområde/program. 
# Exempelvis: Get-NetFirewallProfile, "Get" blir verbet/vad som ska hända, "NetFirewallProfile" är området som kommandot ska köras på.
# Kommandot kommer då att plocka info (Get = get information) från brandväggen (NetFirewallProfile = Network Firewall Profile).

# "Get-..." kommandot har ofta funktionen att plocka info om en vald tjänst, objekt, användare eller liknande på systemet.
# "Set-..." kommandot har ofta funktionen att modifiera, ändra egenskaper eller inställningar av en vald tjänst, objekt, användare eller liknande på systemet

# Varje cmdlets kan också köras med "Get-Help" kommandot som kommer visa användningen av en vald cmdlet. Glöm inte "Update-Help" om lite/ingen info kommer fram.
# "Get-Help" kommandot kan också användas med "-Examples"(visar användningsexempel) eller "-Full"(visar allt om kommandot) attribut som visar ännu mer info om användning av kommando.
# Exempelvis: "Get-Help Get-Service -Examples" som då kommer visa hur man använder kommandot och några exempel.

# _____

# 32st cmdlets som ska täcka slutuppgiften i Shellscripting kursen.

# _____ Firewall _____
Get-NetFirewallProfile  # Plockar nuvarande inställningar för brandväggsprofilerna (Domän, Privat och Publik)
Set-NetFirewallProfile  # Ändrar inställningar i brandväggen, t.ex stänga av eller sätta på en regel.
New-NetFirewallRule     # Skapar ny brandväggsregel, t.ex blockera specifik trafik.

# _____ Defender _____
Get-MpComputerStatus    # Visar status för MS Defender.
Update-MpSignature      # Uppdaterar MS Defender.
Start-MpScan            # Kör en skanning av systemet med Defender.

# _____ Användare _____
Get-LocalGroupMember    # Visar alla användare i den lokala gruppen.
Remove-LocalGroupMember # Tar bort användare i en lokal grupp.
Get-LocalUser           # Visar info om en lokal användare.
Disable-LocalUser       # Stänger av en lokal användare.

# _____ Protokoll _____
Get-ItemProperty        # Visar info om ett objekt, t.ex egenskaperna av en systemfil.
Set-ItemProperty        # Modifiera egenskaper av ett objekt, t.ex ändra en fil från "read/write" till "read only".

# _____ Tjänster _____
Get-Service             # Visar info om tjänster på systemet.
Stop-Service            # Stoppar en vald tjänst eller flera tjänster.
Set-Service             # Ändrar en tjänsts egenskaper.

# _____ Disk _____
Get-Volume              # Visar info om diskar på systemet.
Move-Item               # Flyttar filer eller mappar till ny plats.
New-Item                # Skapar nya filer, mappar eller liknande.

# _____ Bitlocker _____
Get-BitLockerVolume     # Visar info om diskar med BitLocker aktiverat på.
Enable-BitLocker        # Aktiverar BitLocker på en vald disk.

# _____ Loggning & struktur _____
Get-Date                # Plockar nuvarande tid och datum.
Out-File                # Skriver till en fil.
Write-Host              # Skriver text direkt i konsollen.
Write-Error             # Skriver ett felmeddelande till "error stream". Används vid felsökning osv.
Write-Warning           # Skriver ett varningsmeddelande till "warning stream". Används vid felsökning osv.
Where-Object            # Filtrerar efter objekt. 
ForEach-Object          # Gör en vald operation per objekt i en samling, t.ex för varje fil i en mapp så ska den leta efter vissa nyckelord och sedan skriva till en textfil.
Get-Content             # Plockar innehållet från en fil.
Test-Path               # Kollar ifall en filsökväg faktiskt existerar.
Get-Member              # Visar egenskaper och metoder om ett objekt. Används oftast i en "pipeline".
Select-Object           # Väljer ett objekt eller ett objekts egenskaper för vidare användning, oftast i en "pipeline".