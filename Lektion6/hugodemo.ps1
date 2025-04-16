#Get-help och Get-[Valfritt]

$name = "Hugo"      #Variabel
Write-Output "Hej $name"   #Printfunktion med användning av en variabel.



$process = Get-Process -Name chrome    #Sätter variablens "värde" för namnet av chrome i detta exempel
$process    #Kallar på variablen
$process.Name   #Kallar på variablen, MEN bara namnet
$process.CPU    #Kallar på variablen, MEN bara hur mycket CPU den drar
$process | Select-Object Name, CPU, ID    #Samma sak som dom två ovanför, men man plockar flera åt gången.
$process | Get-Member   #Visar alla egenskaper och metoder


