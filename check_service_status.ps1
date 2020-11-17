$service_name = 'remote registry'

$my_service = Get-Service -Name remoteregistry

if ($my_service.Status -eq 'Running') {

echo $my_service.Name ' is running' 

}

else {

echo $my_service.Name ' is not running'

}