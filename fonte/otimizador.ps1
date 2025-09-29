#carregando parametros de inicializacao
pwd
$configuracao = @()
Get-Content ".\config.ini" | ForEach-Object {
    $linha = ($_.Trim()) -split "=",2
    $configuracoes[$linha[0]] = $linha[1]
}
Write-host $configuracao
pause
#lendo arquivos de configuracao
. $configuracao['caminho_config']
. $configuracao['caminho_display']
. $configuracao['caminho_core']

#verificando a execucao como admin
if( -not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){
    Write-Host "[Error]: O arquivo não foi executado como Administrador!" -ForegroundColor Red
    pause
    exit 1
}

while ($true) {
    $opcao = painel_resumido

    switch ($opcao) {
        '1' { otimizar }
        '2' { informacoesMaquina }
        '3' { atualizaServidorHora }
        '4' { desfragmentacaoELimpeza }
        '5' { instalarCertificadosSSL }
        '6' { trocarExibicaoPainel }
        default { Write-Host "Opcao inválida, tente novamente!" -ForegroundColor Red }
    }
    Pause
}

#funcioes desnecessarias retiradas, aplicacao de try catch, e mudança de bat para pshel, separacao em arquivos,
