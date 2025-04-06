#!/bin/bash
#Skript av Hugo Backe, 2 april 2025. Skriptet analyserar loggfiler och genererar en rapport.

#Sökvägen till loggfilen.
LOG_FILE="C:\Users\Hugo\Downloads\test_log.txt"

#Sökvägen till rapportfilen.
REPORT_FILE="C:\Users\Hugo\Downloads\log_report.txt"

#Skriver ut ett meddelande till användaren som kommer ta emot inmatning om max antal rader.
echo "Ange max antal rader att analysera: "

#Läser användarens inmatning för max antal rader. Detta låter användaren bestämma hur många rader av loggfilen som ska analyseras.
read MAX_LINES

#Kontrollerar om loggfilen finns och är läsbar.
if [ ! -r "$LOG_FILE" ]; then
#Skriver ut att filen inte hittades eller är läsbar och avslutar skriptet med felkoden 1.
    echo "Loggfilen finns inte eller är inte läsbar."
    exit 1
fi
#"fi" används för att avsluta denna raden, eller villkorssats som de kallas.

#Dubbelkollar så att MAX_LINES är ett positivt heltal större än noll.
if ! [[ "$MAX_LINES" =~ ^[0-9]+$ ]] || [ "$MAX_LINES" -le 0 ]; then
    echo "Ogiltigt antal rader, ange ett positivt heltal."
    exit 1
fi


#Läser LOG_FILE rad för rad efter den efterfrågade mängden enligt MAX_LINES.
ERROR_COUNT=0
head -n "$MAX_LINES" "$LOG_FILE" | while read -r line; do
#Loopar igenom de första MAX_LINES raderna i loggfilen

#Räknar fel i loopen. Skriver också vart.
    ERROR_COUNT=$((ERROR_COUNT + $(echo "$line" | grep -c "error")))
done


#Funktion som genererar en rapport baserat på analysen. Allt i funktionen skrivs inom "{}".
generate_report() {

#Skapar rapportfilen "REPORT_FILE".
> "$REPORT_FILE"

#Skriver en rubrik till rapportfilen.
echo "Logganalysrapport - $(date)" >> "$REPORT_FILE"

#Skriver antalet fel till rapportfilen.
echo "Antal felmeddelanden: $ERROR_COUNT" >> "$REPORT_FILE"
}

#Anropar rapportfunktionen.
generate_report

#Gör en sammanfattnin till användaren.
echo "Analysen är klar. $ERROR_COUNT fel hittades. Rapport sparad i $REPORT_FILE"