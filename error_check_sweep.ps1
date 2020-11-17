# edit computers variable to match your AD structure

# ﻿$computers = get-adcomputer -Filter "Name -like '*whatever you name your workstations*'"

foreach ($computer in $computers) {

   if (Test-Connection -Computername $computer.name -BufferSize 16 -Count 1 -Quiet) {
   
    $disk = Get-WmiObject Win32_LogicalDisk -ComputerName $computer.name -Filter "DeviceID='C:'" | Select-Object Size,FreeSpace
    $a = [Math]::Round($Disk.Freespace / 1GB)
    $b = [Math]::Round($Disk.size / 1GB)
    $c = $b - $a
    $computer.name
    $c 
    'out of' 
    $b
    $d = $c / $b
    $d = [Math]::Round($d, 2) 
    $d 
    if ($d -gt .8) {"Too High"}   
        
        
    invoke-command -computername $computer.name -scriptblock {

            Get-EventLog -LogName System -Source Disk -Newest 5 -Erroraction silentlycontinue
            "`n"
        }

    

    }
}
