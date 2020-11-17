echo "Enable Remote Registry on a target pc!"

$computer = Read-Host -Prompt 'Input the computer name'

if (Test-Connection -Computername $computer -BufferSize 16 -Count 1 -Quiet) {

   invoke-command -computername $computer  -scriptblock {

        set-service remoteregistry -StartupType Automatic

        start-service remoteregistry
                
    } 

}

else {

"It's Dead"

}