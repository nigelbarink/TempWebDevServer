# 
# Simple script to start an nginx webserver in the current workingdirectory
# Copyright © Nigel Barink 2022
# 

Write-Host 'Make sure Docker is running on your system.'
Read-Host 'Press a key to continue...'

$server_name = Read-Host 'What would you like to call the server'
$port = Read-Host 'What port would you like to expose ?'

Write-Host 'Starting server... Port:' $port

docker run --rm  --name $server_name -d -p $($port + ":80") -v ${pwd}:/usr/share/nginx/html nginx 2> error.txt

if ($? -le 0) {
  Write-Host "Starting server failed" -BackgroundColor Red -ForegroundColor White
  Write-Host ("Check " + $(${pwd}).ToString() + " for error.txt to see whats wrong!") -BackgroundColor Red -ForegroundColor White
} else {

  Write-Host 'Dont forget to stop the container when you exit this script!' -BackgroundColor White -ForegroundColor Red

  docker logs -f $server_name 
  
  
}

Write-Host 'Script stopped...'
