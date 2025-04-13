#!/bin/bash
# file_sentry.sh - Övervakar en katalog för misstänkta filer
# Skapat av: Hugo Backe, April 2025

#set -x      # Visar allt som händer när skriptet körs. Bra för debugging.
set -e      # Avslutar vid error. Om ett kommando failar avslutas skriptet direkt.
set -u      # Avslutar skripet om odefinierade variabler används. 
trap 'echo "Skript avbrutet"; rm -f "$TEMP_FILE"; exit 1' INT TERM
# Reagerar med "set" kommandon. Avslutar skripet på ett rent sätt, meddelar användaren, tar bort .temp filen och stänger med error koden 1.

# Globala variablar.
readonly LOG_FILE="/c/Users/Hugo/Documents/GitHub/Shellscripting-kurs/Lektion3/defender_log.txt"    #Loggfil i min lektions folder.
readonly TEMP_FILE="/c/Users/Hugo/Documents/GitHub/Shellscripting-kurs/Lektion3/temp_file_sentry$$.txt"    #Temporär fil i min lektions folder.
readonly SIZE_THRESHOLD="${2:-1048576}"  # Justerbar storlekströskel, standardvärde på 1MB om inget annat anges.
readonly TARGET_DIR="${1:-}"    # Första argumentet är katalogen. Användningen blir då ./file_sentry.sh <katalog> där "katalog" blir $1. Om inget värde sätts här så defaultar den till tom.

# Variabelnummer för sammanfattning.
#large_file_count=0
#executable_file_count=0

# Funktion för sammanfattning.
#summarize_results() {
 #   echo "Sammanfattning"
  # echo "Antal körbara filer: $executable_file_count"
   # log_message "INFO" "Sammanfattning: $large_file_count stora filer. $executable_file_count körbara filer"
#}


# Funktion som ska logga meddelanden. Skriver tidstämplar och nivåer i loggfilen, bra för spårbarhet.
log_message() {     
    local level="$1"    # Lokal variabel. Med dom olika nivåerna: Info, Warning och Error.
    local message="$2"  # Lokal variabel. Innehåller meddelandet.
    # $1 och $2 är det första och andra argumentet som blir tillagt efter att jag kallat på denna funktionen.

    printf "%s [%s] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$level" "$message" >> "$LOG_FILE"
    # Om jag kallar denna funktionen med kommandot: "log_message "INFO" "File monitoring started."...
    # ... så skriver den exempelvis ut: "2025-04-07 14:30:45 [INFO] File monitoring started." till log filen.
}


# Loop för att validera indata. Den börjar med att kolla OM (if) argumentet (allt inom hakparanteserna) stämmer. 
# Argumentet den kollar efter är om den valda variabeln ($TARGET_DIR) är tom (-z).
# Om den är det är det så fortsätter loopen med resterade kommandon inom loopen.
if [[ -z "$TARGET_DIR" ]]; then
    log_message "ERROR" "Ingen katalog angiven, använd följande kommando för att välja katalog: ./file_sentry.sh <Katalog>"
    # ^Skriver i loggfilen att ingen katalog angavs följt av instruktioner till hur man använder scriptet korrekt. 
    # Exempelvis: "2025-04-07 14:30:45 [ERROR] Ingen katalog angiven, använd följande kommando för att välja katalog: ./file_sentry.sh <Katalog>"

    echo "Fel: Ange en katalog" >&2       
    # Skriver i terminalen att användaren behöver ange en katalog. 
    # ">&2" Gör så att utdatan skickas till standard error stream (stderr).
    exit 1      #Avslutar med felkod 1.
fi

# Liknande loop men denna kollar så att "$TARGET_DIR" ÄR en katalog (-d). Utropstecknet omvänder argumentets resultat. 
if [[ ! -d "$TARGET_DIR" ]]; then
    log_message "ERROR" "$TARGET_DIR är inte en katalog."
    echo "Fel: $TARGET_DIR finns inte eller är inte en katalog." >&2
    exit 1
fi


# Skriver info i loggfilen att skriptet arbetar.
log_message "INFO" "Skannar $TARGET_DIR för misstänkta filer..."

# Hittar filer och sparar storlek och rättigheter till .temp filen. Skriver ett felmeddelande i logg filen om den inte kunde köra kommandot.
if ! find "$TARGET_DIR" -type f -exec stat -c "%s %A %n" {} \; > "$TEMP_FILE"; then
    log_message "ERROR" "Kunde inte köra 'find' i $TARGET_DIR."
    exit 1
fi


# Analyserar varje fil för storlek och rättigheter och skriver till loggfilen samt i terminalen.
while read -r size perms name; do
    # Kontrollerar storlek
    if (( size > SIZE_THRESHOLD )); then
        log_message "WARNING" "Stor fil: $name ($size bytes)"
        echo "Varning: $name är över $SIZE_THRESHOLD bytes!" >&2
        #((large_file_count++))  # Ökar värdet på filräknaren.
    fi
 
    # Kontrollerar körbara rättigheter
    if [[ "$perms" =~ x ]]; then
        log_message "WARNING" "Körbar fil: $name ($perms)"
        echo "Varning: $name är körbar!" >&2
        #((executable_file_count++))  # Ökar värdet på filräknaren.
    fi
done < "$TEMP_FILE"
# Läser från .temp filen.

# Kallar på sammanfattningsfunktionen.
#summarize_results

log_message "INFO" "Skanning klar."
echo "Skanning klar. Se logg för mer info."
rm -f "$TEMP_FILE"