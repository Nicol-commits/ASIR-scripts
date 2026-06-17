Clear-Host
$numeros = [System.Collections.ArrayList]::new()

do {
    Write-Host "---------"
    Write-Host "Opcion 1: Introduce numeros enteros (0 para salir)"
    Write-Host "Opcion 2: Calcula el mayor, menor y la media de los numeros"
    Write-Host "Opcion 3: Salir"
    Write-Host "---------"

    [int]$opcion = Read-Host "Elige una opcion"

    switch ($opcion) {
        1 {
            do {
                [int]$var = Read-Host "Inserte un numero entero (0 para salir)"
                if ($var -ne 0) {
                    [void]$numeros.Add($var)
                }
            } while ($var -ne 0)
        }

        2 {
            if ($numeros.Count -eq 0) {
                Write-Host "No hay numeros introducidos todavia"
            } else {
                $mayor = $numeros[0]
                $menor = $numeros[0]
                $suma  = 0

                foreach ($n in $numeros) {
                    if ($n -gt $mayor) { $mayor = $n }
                    if ($n -lt $menor) { $menor = $n }
                    $suma += $n
                }

                [float]$media = $suma / $numeros.Count

                Write-Host "El mayor es $mayor"
                Write-Host "El menor es $menor"
                Write-Host "La media es $media"
            }
        }

        3 {
            Write-Host "Saliendo..."
        }

        default {
            Write-Host "Opcion no valida"
        }
    }

} while ($opcion -ne 3)