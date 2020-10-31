net use e: \\path\to\windows\iso
Mount-DiskImage -ImagePath "e:\windows.iso"
set-variable drive -value (Get-DiskImage "E:\windows.iso" | Get-Volume).DriveLetter
cd ${drive}:
cmd setup.exe /auto upgrade /quiet
