# edit computer value or use an input method as found in other scripts in this repo

#﻿$computer = "target host"

$Reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey('LocalMachine',$computer)
$RegKey= $Reg.OpenSubKey("SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters")
$description = $RegKey.GetValue("srvcomment")
$computer
$description
pause
