[int]$var1=Read-Host "Escribe un numero"
if ($var1 -eq 0){
 "Es cero"
}elseif($var1 -gt 0){
 "Es positivo"
 }else{
 "Es negativo"
 }