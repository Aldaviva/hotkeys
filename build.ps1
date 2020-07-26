$ahk_install_dir = "C:\Programs\Utilities\AutoHotkey"
$reshacker_install_dir = "C:\Programs\Utilities\Resource Hacker"
$project_dir = Split-Path $script:MyInvocation.MyCommand.Path
$source_dir = "$project_dir\src"
$output_dir = "$project_dir\bin"
$intermediate_dir = "$project_dir\obj"

New-Item -Path $output_dir -ItemType Directory -Force > $null
New-Item -Path $intermediate_dir -ItemType Directory -Force > $null

Write-Output "Compiling AutoHotkey script to EXE"
Start-Process -FilePath "$ahk_install_dir\Compiler\Ahk2Exe.exe" -ArgumentList "/in `"$source_dir\hotkeys.ahk`" /out `"$output_dir\hotkeys.exe`" /icon `"$source_dir\icon.ico`" /bin `"$ahk_install_dir\Compiler\ANSI 32-bit.bin`"" -Wait

Write-Output "Compiling resource file"
Start-Process -FilePath "$reshacker_install_dir\ResourceHacker.exe" -ArgumentList "-open `"$source_dir\resources.rc`" -save `"$intermediate_dir\resources.res`" -action compile" -Wait

Write-Output "Merging resource file into EXE"
Start-Process -FilePath "$reshacker_install_dir\ResourceHacker.exe" -ArgumentList "-open `"$output_dir\hotkeys.exe`" -save `"$output_dir\hotkeys.exe`" -action addoverwrite -resource `"$intermediate_dir\resources.res`"" -Wait

Write-Output "Merging manifest into EXE"
Start-Process -FilePath "$reshacker_install_dir\ResourceHacker.exe" -ArgumentList "-open `"$output_dir\hotkeys.exe`" -save `"$output_dir\hotkeys.exe`" -action addoverwrite -resource `"$source_dir\manifest.manifest`" -mask MANIFEST,1," -Wait

Write-Output "Done"