@echo off
net stop spooler
echo Aguarde um momento enquanto o Spooler de Impressão é encerrado...
ping 127.0.0.1 -n 5 > nul
net start spooler
echo O Spooler de Impressão foi reiniciado com sucesso.
pause