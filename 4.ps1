[int]$var=Read-Host "Inserte un numero"
for ($i=1;$i -le 10;$i++) {
  [int]$resul = $var * $i
  Write-Host "$varx$i=$resul"
}
