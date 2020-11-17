echo "Enable LocalAccountTokenFilterPolicy on a target pc!"

$computer = Read-Host -Prompt 'Input the computer name'

if (Test-Connection -Computername $computer -BufferSize 16 -Count 1 -Quiet) {

   invoke-command -computername $computer  -scriptblock {

        New-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name LocalAccountTokenFilterPolicy -Value 1 -PropertyType "DWord"
                
    } 

}

else {

"It's Dead"

}
