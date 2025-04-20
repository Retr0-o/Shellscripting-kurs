# LogMonitor.ps1 - Övervakar loggfiler för misstänkta nyckelord.
# Skapat av: Hugo Backe, April 2025.
# Syfte: Skanna loggar, logga resultat och varna om problem.

# _______ Parametrar _______
param (
    [Parameter(Mandatory=$true)][string]$LogDir,  # Gör $LogDir till en parameter som måste anges vid körning.
    [string]$OutputLog = "C:\Users\Hugo\Documents\GitHub\Shellscripting-kurs\Lektion6\monitor.log" # Standardvärde för $OutputLog. Går att ändra vid körning av skript.
)

# _______ Variabler _______
# $LogDir = "C:\Users\Hugo\Documents\GitHub\Shellscripting-kurs\Lektion6\Logs"                 # Mapp för loggar som ska analyseras. Används ej med valbar sökväg (linje 7)
# $OutputLog = "C:\Users\Hugo\Documents\GitHub\Shellscripting-kurs\Lektion6\monitor.log"       # Fil där info om loggarna ska skrivas till. Används ej, flyttad till linje 8.
$Keywords = @("error","failed","warning")         # Nyckelord för filanalyseringen.

# _______ Funktioner _______
function Write-Log {        # Funktion för att skriva info om loggar till en fil. 
    param (
        [Parameter(Mandatory=$true)][string]$Level,         # Lokal variabel för att sätta en nivå på logg meddelandet. "[string]" säkerställer att de är text.
        [Parameter(Mandatory=$true)][string]$Message        # Valbart meddelande för att väljas och användas när man ska köra denna funktion.
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"     # Variabel för att plocka tid och datum. "-Format" gör så att man kan välja tidsformatet själv.
    "$timestamp [$Level] $Message" | Out-File -FilePath $OutputLog -Append        # Funktionens huvudlogik. Tar variablerna och sätter ihop dom till ett meddelande som sedan skrivs till $OutputLog filen.
}                                                                                 # "-Append" gör så att ny text läggs till på redan existerande text, inte byter ut.

# _______ Validering _______
Write-Log -Level "INFO" -Message "Startar loggövervakning..."   # Användning av funktionen "Write-Log" och inmatning av parametrar.
if (-not(Test-Path $LogDir)) {       # Testar så att sökvägen för $LogDir finns och är en mapp.
    Write-Log -Level "ERROR" -Message "Katalogen $LogDir finns inte."
    Write-Error "Katalogen finns inte"
    exit 1
}

# _______ Huvudlogik _______        # Huvudlogiken i detta skript. För varje loggfil så kollar den igenom efter specifika nyckelord. 
try {
    $files = Get-ChildItem -Path $LogDir -File -ErrorAction Stop
    foreach ($file in $files) {
        $content = Get-Content $file.FullName -ErrorAction Stop
        foreach ($line in $content) {
            foreach ($keyword in $Keywords) {
                if ($line -match $keyword) {
                    $Message = "Hittade '$keyword' i $($file.Name): $line"
                    Write-Log -Level "WARNING" -Message $Message
                    Write-Warning $Message
                }
            }
        }
    }
    Write-Log -Level "INFO" -Message "Skanning klar."
} catch {
    Write-Log -Level "INFO" -Message "Fel: $($.Exception.Message)"
    Write-Error "Fel vid skanning: $($.Exception.Message)"
    exit 1
}