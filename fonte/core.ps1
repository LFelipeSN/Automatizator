function resposta_sucesso($comando) {
    $mensagemSucesso = "Sucesso ao $comando!"
    Write-Host ""
    Write-Host "$mensagemSucesso" -ForegroundColor Green  
}

function otimizar {
    try{
        # Coloca o plano de energia no alto desempenho
        powercfg /setactive SCHEME_MIN
        resposta_sucesso -comando "mudar plano de energia para alto desempenho"
        
        #Para e desabilita o SysMain
        Stop-Service -Name "SysMain" -ErrorAction Stop 
        Set-Service -Name "SysMain" -StartupType Disabled -ErrorAction Stop        
        resposta_sucesso -comando "parar e desabilitar o SysMain!"

        #configurar aparencia do windows
        [System.Windows.MessageBox]::Show('Agora configure a Aparencia, o recomendado é marcar [usar fontes de tela com canto arredondado] e [mostrar miniaturas em vez de ícone]. DÚVIDAS LER HELP.txt', 'Dica', [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Information)
        Write-Host "Aguarde enquanto janela carrega..."
        SystemPropertiesPerformance
        resposta_sucesso -comando "configurar aparência do Windows!"
        Pause

        #configurar aplicativos de inicilização do Windows
        [System.Windows.MessageBox]::Show('Vá na aba inicialização e desabilite os aplicativos desnecessários, ex: onedrive. DÚVIDAS LER HELP.txt DÚVIDAS LER HELP.txt', 'Dica', [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Information)
        Start-Process taskmgr
        resposta_sucesso -comando "configurar aplicativos de inicilização do Windows!"

    }catch [System.Exception]{
        Write-Host ""
        Write-Host "[Error]: $($_.Exception.Message)" -ForegroundColor Red
    }
    Pause
}

function informacoesMaquina {
    write-host "aguarde..."
    
    write-host "Usuário: " -NoNewline -ForegroundColor Green
    write-host $env:USERNAME -ForegroundColor Yellow
    
    write-host "Computador: " -NoNewline -ForegroundColor Green
    write-host $env:COMPUTERNAME -ForegroundColor Yellow
    
    write-host "Processador: " -NoNewline -ForegroundColor Green
    write-host (Get-WmiObject Win32_Processor).Name -ForegroundColor Yellow
    
    write-host "Velocidade Ram(separado por | ): " -NoNewline -ForegroundColor Green
    write-host ((Get-WmiObject Win32_PhysicalMemory).Speed -join " mhz|") "mhz" -ForegroundColor Yellow
    
    write-host "Capacidade Ram(separado por | ): " -NoNewline -ForegroundColor Green
    write-host ((Get-WmiObject Win32_PhysicalMemory | ForEach-Object {[math]::round($_.Capacity / 1GB, 0)}) -join " GB|")"GB" -ForegroundColor Yellow
    
    write-host "Capacidade dos discos(separado por | ): " -NoNewline -ForegroundColor Green
    write-host ((Get-WmiObject Win32_DiskDrive | ForEach-Object {[math]::round($_.Size / 1GB, 0)}) -join " GB|") "GB" -ForegroundColor Yellow

    $velocidadeLeituraDisco = (winsat disk -seq -read -drive c | Select-String "Read" -CaseSensitive) -split '\s+'
    $velocidadeEscritaDisco = (winsat disk -seq -write -drive c | Select-String "Write" -CaseSensitive) -split '\s+'
    write-host "Velocidade de leitura/escrita disco(separado por | ): " -NoNewline -ForegroundColor Green
    write-host $velocidadeLeituraDisco[5] "MB/s |" $velocidadeEscritaDisco[5] "MB/s" -ForegroundColor Yellow
    
    write-host "Sistema Operacional: " -NoNewline -ForegroundColor Green
    write-host ((Get-WmiObject -class Win32_OperatingSystem).Caption) -ForegroundColor Yellow

    Pause
}

function atualizaServidorHora {    
    try{
        #inicia serviço w32time
        net start w32time
        resposta_sucesso -comando "iniciar serviço w32time"

        set-Service -Name w32time -StartupType Automatic
        resposta_sucesso -comando "mudar inicialização do serviço w32time para automático"        

        w32tm /config /manualpeerlist:"time.windows.com" /syncfromflags:manual /update /reliable:yes
        resposta_sucesso -comando "mudar servidor de hora"     

        w32tm /resync
    }catch [System.Exception]{
        Write-Host ""
        Write-Host "[Error]: $($_.Exception.Message)" -ForegroundColor Red
    }

    Pause
}

function desfragmentacaoELimpeza {
    defrag C: /O
    pause

    [System.Windows.MessageBox]::Show('Selecione as abas na qual deseja fazer uma limpeza', 'Dica', [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Information)
    cleanmgr /d C: /lowdisk

    Pause
}

function instalarCertificadosSSL {
    cd "certificado(s)"

    Get-ChildItem -Path . -Filter '*.crt' -File | ForEach-Object {
        $nomeArquivo = $_.FullName
        try {
            Import-Certificate -FilePath $nomeArquivo -CertStoreLocation 'Cert:\LocalMachine\CA' -ErrorAction Stop
            Write-Host "Importado: $($_.Name)"
        }catch [System.Exception]{
            Write-Host ""
            Write-Host "[Error]: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
    Write-host 'Os certificados foram instalados na pasta "Autoridades de Certificação Intermediárias", mova-os para a pasta "Autoridades de certificação Raiz Confiáveis"!'
    [System.Windows.MessageBox]::Show('Os certificados foram instalados na pasta "Autoridades de Certificação Intermediárias", mova-os para a pasta "Autoridades de certificação Raiz Confiáveis"!', 'Dica', [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Information)
    certmgr.msc

    Pause
}

function trocarExibicaoPainel {
    try {
        if ($global:painel_escolhido -eq "painel_resumido") { 
            $global:painel_escolhido = "painel_detalhado" 
            $global:rawUI.WindowSize = $size_large
            
        } else {
            $global:painel_escolhido ="painel_resumido"
            $global:rawUI.WindowSize = $size_small        
        }
    }catch [System.Exception]{
        Write-Host ""
        Write-Host "[Error]: Parece que ocorreu um erro ao modificar o tamanho da tela, não se preocupe é apenas visual" -ForegroundColor Red
    }
}