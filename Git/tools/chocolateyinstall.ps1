# ===============================================
# PARTE 1: Instalación Supersilenciosa de Git
# ===============================================

$packageName = 'Git'
$fileType = 'exe'
$fileInstaller = 'Git-2.52.0-64-bit.exe' 

# Argumentos SILENCIOSOS de Git para instalación sin interfaz:
# /SILENT: Instala sin interfaz de usuario.
# /NOCRC: Salta la comprobación CRC (opcional).
$silentArgs = "/SILENT /NOCRC" 

$filePath = Join-Path $toolsDir $fileInstaller

Write-Host "Iniciando instalación supersilenciosa de Git v2.52.0..."

# Ejecuta la instalación
Install-ChocolateyInstallPackage $packageName $fileType $filePath $silentArgs

# ===============================================
# PARTE 2: Creación del Acceso Directo (LNK)
# ===============================================

# La ruta de instalación por defecto de Git
$targetExe = "C:\Program Files\Git\git-bash.exe"

# Ruta para el acceso directo en el escritorio del usuario actual
$shortcutPath = Join-Path $env:USERPROFILE "Desktop\Git Bash.lnk"

# Esperamos un momento para asegurarnos de que la instalación haya finalizado y el archivo exista
Start-Sleep -Seconds 5 

if (Test-Path $targetExe) {
    
    # Crear el objeto Shell de Windows
    $shell = New-Object -ComObject WScript.Shell

    # Crear el objeto Shortcut
    $shortcut = $shell.CreateShortcut($shortcutPath)

    # Definir la ruta del programa y descripción
    $shortcut.TargetPath = $targetExe
    $shortcut.Description = "Lanzar Git Bash"

    # Guardar el acceso directo
    $shortcut.Save()

    Write-Host "✅ Acceso directo a Git Bash creado exitosamente en el Escritorio."

} else {
    Write-Warning "El ejecutable de Git no se encontró en $targetExe. La instalación pudo haber fallado o la ruta ha cambiado."
}