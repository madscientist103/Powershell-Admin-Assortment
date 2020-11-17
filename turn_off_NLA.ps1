echo "Turn Off Network Level Authentication on a target pc!"

$computer = Read-Host -Prompt 'Input the computer name'

if (Test-Connection -Computername $computer -BufferSize 16 -Count 1 -Quiet) {

   invoke-command -computername $computer  -scriptblock {

       set-itemproperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\Winstations\RDP-TCP\' -Name "UserAuthentication" -Value 0 
                
    } 

}

else {

"It's Dead"

}