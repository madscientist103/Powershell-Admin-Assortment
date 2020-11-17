echo "Check who is logged in!"

$computer = Read-Host -Prompt 'Input the computer name'

if (Test-Connection -Computername $computer -BufferSize 16 -Count 1 -Quiet) {

    "$computer is Alive"

    get-wmiobject -computername $computer -class win32_computersystem | select-object username

}

else {

"It's Dead"

}