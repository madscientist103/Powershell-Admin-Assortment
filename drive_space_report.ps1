# edit computer variable ip range 
# $computers = start_int..end_int | % {"192.168.0.$_"}

foreach ($computer in $computers) {

if (Test-Connection -Computername $computer -BufferSize 16 -Count 1 -Quiet)
{
$disk = Get-WmiObject Win32_LogicalDisk -ComputerName $computer -Filter "DeviceID='C:'" | Select-Object Size,FreeSpace
$a = [Math]::Round($Disk.Freespace / 1GB)
$b = [Math]::Round($Disk.size / 1GB)
$c = $b - $a
$computer
$c 
'out of' 
$b
$d = $c / $b
$d = [Math]::Round($d, 2) 
$d
if ($d -gt .8) {"Too High"}
"`n"
}
}
