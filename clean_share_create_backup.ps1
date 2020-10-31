#delete items older than 90 days but leave "test" programs alone, repalce test with anything #you want to leave in perpetuity
Get-ChildItem –Path "\\path\to\your\share" -Recurse | 
Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-90))} |
Where {$_ -notlike 'Test*'} |
Where {$_ -notlike 'Another_Test*'} | 
sort length -Descending |
Remove-Item -force -Recurse

$root = "\\path\to\your\share"

#iterate a few times to ensure all empty folders are deleted
for ($i=0; $i -le 3; $i++)
{

    
    # Get each item under the current directory recursively
    foreach($childItem in (Get-ChildItem $root -Recurse))
    {
	    # if it's a folder AND does not have child items of its own
	    if( ($childItem.PSIsContainer) -and (!(Get-ChildItem -Recurse -Path $childItem.FullName)))
	    {
		    # Delete it
		    Remove-Item $childItem.FullName -Confirm:$false
        }
    }
}
# copy from share to backup_share but leave existing files in backup_share
Robocopy "\\path\to\your\share" "\\path\to\your\backups" /XX /mir
