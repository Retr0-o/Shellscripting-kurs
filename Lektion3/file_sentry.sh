#!/bin/bash
# file_sentry.sh - Övervakar en katalog för misstänkta filer
# Skapat av: Hugo Backe, April 2025

# Globala variablar.
readonly LOG_FILE="C:\Users\Hugo\Documents\GitHub\Shellscripting-kurs\Lektion3\defender_log.txt"    #Loggfil i min lektions folder.
readonly TEMP_FILE="C:\Users\Hugo\Documents\GitHub\Shellscripting-kurs\Lektion3\temp_file_sentry$$.txt"    #Temporär fil i min lektions folder.
readonly SIZE_THRESHOLD=1048576     # 1MB i bytes.
readonly TARGET_DIR="$1"    # Första argumentet är katalogen.


set -e      # Avslutar vid error. Om ett kommando failar avslutas skriptet direkt.
set -u      # Avslutar skripet om odefinierade variabler används. 
trap 'echo "Skript avbrutet"; rm -f "$TEMP_FILE"; exit 1'  
# Reagerar med "set" kommandon. Avslutar skripet på ett rent sätt, meddelar användaren, tar bort .temp filen och stänger med error koden 1.


log_message() {     # Funktion som ska logga meddelanden. Skriver tidstämplar och nivåer i loggfilen, bra för spårbarhet.
    local level="$1"    # Lokal variabel. Med dom olika nivåerna: Info, Warning och Error.
    local message="$2"
    printf "%s [%s] %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$level" "$message" >> "$LOG_FILE"
    # Skriver exempelvis ut: "2025-04-07 14:30:45 [INFO] File monitoring started." till log filen.
}

