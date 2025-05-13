<#
  .SYNOPSIS
  Wyświetla podstawowe dane i listę otwartych portów dla podanego adresu IP

  .DESCRIPTION
  Skrypt pobiera adres IP od użytkownika ,wysyła zapytanie do API Shodan i wyświetla podstawowe dane urządzenia oraz liczbę otwartych portow na urządzeniu 

  .PARAMETER kluczAPI
  Parametr określa klucz API Shodan

  .PARAMETER adresIP
  Parametr określa adres IP podany przez użytkownika 
  
  .EXAMPLE
#>

#Klucz API Shodan
$kluczAPI = 'jZ9BrDGYt6Q7wsP1tSrybnJlVwJXfq9W'

#Pobieranie adresu IP od użytkownika
$adresIP = Read-Host "Podaj adres IP do sprawdzenia"

#Składamy URL zapytania do API Shodan
$url = "https://api.shodan.io/shodan/host/$adresIP?key=$kluczAPI"

#Wysyłamy zapytanie do API Shodan
try {
    $odpowiedz = Invoke-RestMethod -Uri $url -Method Get

    #Wyświetlamy podstawowe dane o urządzeniu z podanym adresem IP
    Write-Host "`nInformacje o hoście $adresIP :" -ForegroundColor Cyan
    Write-Host "IP         : $($odpowiedz.ip_str)"
    Write-Host "Kraj       : $($odpowiedz.country_name)"
    Write-Host "Miasto     : $($odpowiedz.city)"
    Write-Host "Organizacja: $($odpowiedz.org)"
    Write-Host "ISP        : $($odpowiedz.isp)"
    Write-Host "Hostnames  : $($odpowiedz.hostnames -join ', ')"

    #Lista otwartych portów
    Write-Host "`nOtwartych portów: "
    foreach ($port in $odpowiedz.ports) {
        Write-Host " - Port: $port"
    }
}
#Wyświetlanie wiadomości o błęndach , jeśli coś pojdzie nie tak
catch {
    Write-Host "Błąd podczas pobierania danych z Shodan. Sprawdź adres IP lub klucz API." -ForegroundColor Red
}