#codification 
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

#color 
$rawUI = $Host.UI.RawUI
$rawUI.BackgroundColor = "Black"
$rawUI.ForegroundColor = "Blue"

#titulo 
$rawUI.WindowTitle = "Otimizador"

#window size
$size_large = $rawUI.WindowSize
$size_large.Width  = 110
$size_large.Height = 30

$size_small = $rawUI.WindowSize
$size_small.Width  = 85
$size_small.Height = 30
$rawUI.WindowSize = $size_small
$rawUI.BufferSize = $size_large 

#interface de pop-up
Add-Type -AssemblyName PresentationFramework

#painel
$painel_escolhido = "painel_resumido"

Clear-Host