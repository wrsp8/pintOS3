@echo off

set dockerid="C:\Users\oscar barrios\Desktop\Galileo\CCVII\flujo-trabajo-github\.container-id"

if not exist "C:\Users\oscar barrios\Desktop\Galileo\CCVII\flujo-trabajo-github\.container-id" (docker create -t -i -v "C:\Users\oscar barrios\Desktop\Galileo\CCVII\flujo-trabajo-github":/root/pintos -v "C:\Users\oscar barrios\Desktop\Galileo\CCVII\flujo-trabajo-github\pintos-docker":/root/host --cidfile %dockerid% "gbenm/pintos:latest")

set /p dockerid=<%dockerid%

for /f %%g in ('docker container list --no-trunc -q') do (set target=%%g)

echo %target% | findstr %dockerid%

if errorlevel 1 (
    echo Iniciando contenedor
    docker start -i %dockerid%
) else (
    echo Ejecutando nueva terminal
    docker exec -it %dockerid% bash
)

pause