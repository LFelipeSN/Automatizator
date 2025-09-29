function painel_detalhado {
    Clear-Host
    Write-Host ""
    Write-Host "  =================================================================================" -ForegroundColor Cyan
    Write-Host "       _____  _____  _____ ___  ___ _____  ______  ___  ______  _____ ______      "
    Write-Host "      |  _  ||_   _||_   _||  \/  ||_   _||___  / / _ \ |  _  \|  _  || ___ \     "
    Write-Host "      | | | |  | |    | |  | .  . |  | |     / / / /_\ \| | | || | | || |_/ /     "
    Write-Host "      | | | |  | |    | |  | |\/| |  | |    / /  |  _  || | | || | | ||    /      "
    Write-Host "      \ \_/ /  | |   _| |_ | |  | | _| |_ ./ /___| | | || |/ / \ \_/ /| |\ \      "
    Write-Host "       \___/   \_/   \___/ \_|  |_/ \___/ \_____/\_| |_/|___/   \___/ \_| \_|     "
    Write-Host "                                 created by LUIZF" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   1 - Otimizar Computador -" 
    write-Host "    Ajusta o plano de energia, desabilita o SysMain e abre janelas para configurar aparência e inicialização.`n" -ForegroundColor Gray
    Write-Host "   2 - Verificar Informações da Máquina -" 
    write-Host "    Exibe informações do computador como usuário, processador, memória, disco e sistema operacional.`n" -ForegroundColor Gray
    Write-Host "   3 - Atualizar Servidor de Hora -" 
    write-Host "    Configura e sincroniza o servidor de hora do Windows.`n" -ForegroundColor Gray
    Write-Host "   4 - Desfragmentação e Limpeza de disco -" 
    write-Host "    Executa desfragmentação do disco e abre a ferramenta de limpeza.`n" -ForegroundColor Gray
    Write-Host "   5 - Instalar Certificados SSL -" 
    write-Host "    Importa certificados SSL da pasta 'certificado(s)'.`n" -ForegroundColor Gray
    Write-Host "   6 - resumir painel -" 
    write-Host "    recolhe a descrição das opções.`n" -ForegroundColor Gray
    Write-Host ""

    write-Host "Selecione uma opção: "
    $opcao = [System.Console]::ReadKey($true).KeyChar
    write-Host "   Opcao $opcao"    
    return $opcao
}

function painel_resumido {
    Clear-Host
    Write-Host ""
    Write-Host "  =================================================================================" -ForegroundColor Cyan
    Write-Host "       _____  _____  _____ ___  ___ _____  ______  ___  ______  _____ ______      "
    Write-Host "      |  _  ||_   _||_   _||  \/  ||_   _||___  / / _ \ |  _  \|  _  || ___ \     "
    Write-Host "      | | | |  | |    | |  | .  . |  | |     / / / /_\ \| | | || | | || |_/ /     "
    Write-Host "      | | | |  | |    | |  | |\/| |  | |    / /  |  _  || | | || | | ||    /      "
    Write-Host "      \ \_/ /  | |   _| |_ | |  | | _| |_ ./ /___| | | || |/ / \ \_/ /| |\ \      "
    Write-Host "       \___/   \_/   \___/ \_|  |_/ \___/ \_____/\_| |_/|___/   \___/ \_| \_|     "
    Write-Host "                                 created by LUIZF" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "   1 - Otimizar Computador"
    Write-Host "   2 - Verificar Informações da Máquina"
    Write-Host "   3 - Atualizar Servidor de Hora"
    Write-Host "   4 - Desfragmentação e Limpeza de disco"
    Write-Host "   5 - Instalar Certificados SSL"
    Write-Host "   6 - expandir painel"
    Write-Host ""
    
    write-Host "Selecione uma opção: "
    $opcao = [System.Console]::ReadKey($true).KeyChar
    write-Host "   Opcao $opcao"
    return $opcao
}