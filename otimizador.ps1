#lendo arquivos de configuracao
$diretorioAtual = $PSScriptRoot
. "$diretorioAtual\fonte\config.ps1"
. "$diretorioAtual\fonte\display.ps1"
. "$diretorioAtual\fonte\core.ps1"

#verificando a execucao como admin
if( -not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)){
    Write-Host "[Error]: O arquivo não foi executado como Administrador!" -ForegroundColor Red
    pause
    exit 1
}

while ($true) {
    $opcao = & $painel_escolhido

    switch ($opcao) {
        '1' { otimizar }
        '2' { informacoesMaquina }
        '3' { atualizaServidorHora }
        '4' { desfragmentacaoELimpeza }
        '5' { instalarCertificadosSSL }
        '6' { trocarExibicaoPainel }
        default { Write-Host "Opcao inválida, tente novamente!" -ForegroundColor Red }
    }
}
