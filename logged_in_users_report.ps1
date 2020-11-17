
# edit computers to reflect your AD naming convention
#$computers = get-adcomputer -Filter "Name -like '*whatever you name your workstations*'"

foreach ($computer in $computers) {

   if (Test-Connection -Computername $computer.name -BufferSize 16 -Count 1 -Quiet) {

        "$computer.name is alive!"

        get-wmiobject -computername $computer.name -class win32_computersystem | select-object username

    }

    else {

    "$computer.name is Dead"

    }

}
