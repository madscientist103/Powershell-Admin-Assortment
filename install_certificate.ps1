echo "Install Cert on a target!"

$computer = Read-Host -Prompt 'Input the computer name'

if (Test-Connection -Computername $computer -BufferSize 16 -Count 1 -Quiet) {

    "$computer is Alive"
    
    
   # edit the path to cert and cert store location
   get-childitem -path c:\path\to\cert.cer | import-certificate -certstorelocation cert:\localmachine\root 

}

else {

"$computer is Dead"

}
