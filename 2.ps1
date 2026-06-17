[int]$numero1 = Read-Host "Introduce el primer numero"
[int]$numero2 = Read-Host "Introduce el segundo numero"

[int]$suma = $numero1+$numero2
[int]$resta = $numero1-$numero2
[int]$mul= $numero1*$numero2
[float]$div= $numero1/$numero2
 
Write-Host "La suma es $suma ,la resta es $resta,la multiplicacion es $mul y la division es $div"