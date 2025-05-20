@echo off
:: Verifica se está sendo executado como administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo [ERRO] Execute este script como Administrador.
    pause
    exit /b
)

echo ---------------------------------------
echo Otimizacao do Windows Iniciada...
echo ---------------------------------------

:: Limpeza de arquivos temporários
echo Limpando arquivos temporarios do sistema...
del /s /f /q %TEMP%\* >nul 2>&1
del /s /f /q C:\Windows\Temp\* >nul 2>&1

:: Parar e desativar o spooler de impressao (se nao for usado)
echo Desabilitando o servico de impressao (Spooler)...
sc stop spooler >nul 2>&1
sc config spooler start= disabled >nul 2>&1

:: Desabilitar efeitos visuais (modo performance)
echo Ajustando efeitos visuais para melhor desempenho...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Control Panel\Performance" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul

:: Ajustar plano de energia para alto desempenho
echo Alterando plano de energia para Alto Desempenho...
powercfg -setactive SCHEME_MIN

:: Limpar cache do Windows Update
echo Limpando cache do Windows Update...
net stop wuauserv >nul 2>&1
del /s /f /q C:\Windows\SoftwareDistribution\Download\* >nul 2>&1
net start wuauserv >nul 2>&1

echo.
echo ---------------------------------------
echo ✅ Otimizacao concluida com sucesso!
echo ---------------------------------------
pause
