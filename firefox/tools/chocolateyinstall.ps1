# ===============================================
# PARTE 1: Instalación Supersilenciosa de Firefox
# ===============================================

$packageName = 'firefox'
$fileType = 'exe'
$fileInstaller = 'Firefox Setup 130.0.exe' # <<-- Nombre del EXE

# Argumento silencioso estándar de Mozilla
$silentArgs = "/S" 

$filePath = Join-Path $toolsDir $fileInstaller

Write-Host "Iniciando instalación supersilenciosa de Firefox v130.0..."

# Ejecuta la instalación
Install-ChocolateyInstallPackage $packageName $fileType $filePath $silentArgs

# ===============================================
# PARTE 2: Creación del Acceso Directo
# ===============================================

# La ruta de instalación por defecto (32-bit o 64-bit). 
# Usaremos una verificación simple.
$targetExe = "C:\Program Files\Mozilla Firefox\firefox.exe"
if (-not (Test-Path $targetExe)) {
    $targetExe = "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
}

# Ruta para el acceso directo en el escritorio del usuario actual
$shortcutPath = Join-Path $env:USERPROFILE "Desktop\Mozilla Firefox.lnk"

# Esperamos 10 segundos para asegurarnos de que el instalador haya terminado (Firefox es más lento)
Start-Sleep -Seconds 10 

if (Test-Path $targetExe) {

    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)

    $shortcut.TargetPath = $targetExe
    $shortcut.Description = "Lanzar Mozilla Firefox"

    $shortcut.Save()

    Write-Host "✅ Acceso directo a Mozilla Firefox creado exitosamente en el Escritorio."

} else {
    Write-Warning "El ejecutable de Firefox no se encontró. No se pudo crear el acceso directo."
}