do{
write-Host "------------Gestion  de Usuarios---------------"
Write-Host  "1.Crear Usuarios"
write-Host  "2.Borrar ususarios"
write-Host  "3.Dar informacion de los usuarios"
write-Host  "4.Listar a los usuarios por grupo del Sistema"
Write-Host  "5.Salir"
write-Host "-----------------------------------------------"
[int]$var=Read-Host "Introduce una opcion"
 switch($var){
  1{#Pedimos fichero y validamos el tipo de fichero .var 
    do{
      $csvPath=Read-Host "Introduce la ruta del fichero"
         if (-not $csvPath.EndsWith(".csv")) {
           Write-Host "Error:El fichero debe de ser .csv"
         }elseif(-not (Test-Path $csvPath)) {
          Write-Host "Error:El fichero no existe."
         }
        }While(-not $csvPath.EndsWith(".csv") -or -not (Test-Path $csvPath))
        $User= Import-Csv -Path $csvPath -Delimiter ";"
            foreach($i in $User){
                $inicial=$i.nombre.Substring(0,1)
                $id=$inicial+"_"+$i.apellido
               if(-not (Get-LocalGroup -Name $i.puesto -ErrorAction SilentlyContinue)){
                   New-LocalGroup -Name $i.puesto
                   Write-Host "El grupo $($i.puesto) ha sido creado"
               }else{
                   Write-Host "El usuario $($i.puesto) ya existe"
               }

               if (-not (Get-LocalUser -Name $id  -ErrorAction SilentlyContinue )){
                $password=ConvertTo-SecureString "Halamadrid15@" -AsPlainText -Force
                New-LocalUser -Name $id `
                -Password $password `
                -FullName "$($i.nombre) $($i.apellido)" `
                -Description $i.puesto `
                -PasswordNeverExpires:$true `
                -AccountNeverExpires:$true
                Write-Host "Usuario $id creado "
    } else {
        Write-Host "Usuario $id ya existe "
    }
        Add-LocalGroupMember -Group $i.puesto -Member $id
        Write-Host "Usuario $id añadido al grupo $($i.puesto)"      
        
    }
        }  

  2{
    do{
      $csvPath=Read-Host "Introduce la ruta del fichero"
         if (-not $csvPath.EndsWith(".csv")) {
           Write-Host "Error:El fichero debe de ser .csv"
         } elseif(-not (Test-Path $csvPath)) {
          Write-Host "Error:El fichero no existe."
         }
        }While(-not $csvPath.EndsWith(".csv") -or -not (Test-Path $csvPath))
        $User= Import-Csv -Path $csvPath -Delimiter ";"
            foreach($i in $User){
                $inicial=$i.nombre.Substring(0,1)
                $id=$inicial+"_"+$i.apellido
            if(Get-LocalUser  -Name $id  -ErrorAction SilentlyContinue){
                Remove-LocalUser -Name $id 
                Write-Host "El usuario $id ha sido borrado correctamente"
            }else{
                Write-Host "No existen usuarios que borrar"
            }
            }
   }
  3{#Listar informacion de los usuarios
    $id = Read-Host "Introduce el nombre del usuario"
    
    $info = Get-LocalUser -Name $id -ErrorAction SilentlyContinue
    
    if ($info) {
        Write-Host "Nombre:      $($info.Name)"
        Write-Host "Descripcion: $($info.Description)"
        Write-Host "Activo:      $($info.Enabled)"
    } else {
        Write-Host "El usuario $id no existe ⚠️"
    }
   }
  4{
    $grupo = Read-Host "Introduce el nombre del grupo"
    
    $miembros = Get-LocalGroupMember -Group $grupo -ErrorAction SilentlyContinue
    
    if ($miembros) {
        Write-Host "Usuarios del grupo $grupo :"
        foreach ($m in $miembros) {
            Write-Host "  - $($m.Name)"
        }
    } else {
        Write-Host "El grupo $grupo no existe o esta vacio ⚠️"
    }  
   }
  5{Write-Host "Saliendo"}
 }
}While($var -ne 5)