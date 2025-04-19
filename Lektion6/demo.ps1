# KOM IHÅG!!!!! Använd Get-Command och Get-Help
# Get-Help Get-Process

# ------ Variabler -------

# Deklarationsprocess
$name = "Ludwig" # Enkel Variabel
Write-Output "Hej $name!" # Enkel printfunktion

# Objektbaserad Variabel
$files = Get-ChildItem C:\TestDir
$files
$files.Name

# ----- Objekt och Egenskaper ----
$process = Get-Process # Process sväljer innehållet av Get-kommandot
$process # Kallar jag på alla den outputen
$process.Name # Kallar jag på all output, men bara med namnen
$process.CPU 
$process | Select-Object Name, CPU, ID
$process | Get-Member # Visar alla egenskaper och metoder

# ----- Powershell Pipeline Command ------
Get-ChildItem C:\TestDir | Where-Object {$_.Extension -eq ".txt"} | Select-Object Name
Get-Process | Where-Object {$_.CPU -gt 100} | Select-Object Name, CPU

# ----- Villkor / Conditionals ----------
$disk = Get-Disk
if ($disk.Size -gt 100GB) {
    Write-Output "Disken är större än 100GB"
} else {
    Write-Output "Disken är mindre än 100GB"
}

# ------ Loopar ----------------------
# ForEach-Object Loop
Get-ChildItem C:\TestDir | ForEach-Object {
    Write-Output "Fil: $($_.Name), Storlek: $($_.Length)"
}

# Foreach Loop
$files = Get-ChildItem C:\TestDir
foreach ($file in $files) {
    Write-Output "Fil: $file"
}

# ------ Funktioner ---------------
function Write-Log {
    param (
        [string]$Level,
        [string]$Message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp [$Level] $Message" | Out-File -FilePath C:\TestDir\log.txt -Append
}
Write-Log -Level "INFO" -Message "Testar min logg"

# ----------- Felhantering -----------
try {
    Get-ChildItem C:\FakeDir -ErrorAction Stop
    Write-Output "Katalogen finns!"
} catch {
    Write-Output "Fel: $($_.Exception.Message)"
}