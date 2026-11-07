# CNZ Scarne — download

Distribuição do aplicativo para **Windows 10/11 x64**. Este repositório contém apenas o inicializador e as instruções; o código-fonte do aplicativo não está publicado aqui.

## Abrir pelo PowerShell

Não precisa de conta GitHub, Git, compilador ou administrador. Cole no PowerShell:

```powershell
$p = Join-Path $env:TEMP ('CNZ-' + [guid]::NewGuid().ToString('N') + '.ps1'); Invoke-WebRequest -UseBasicParsing 'https://github.com/teushz87-design/cnz-scarne-download/releases/latest/download/Iniciar.ps1' -OutFile $p; if (Test-Path -LiteralPath $p) { powershell -NoProfile -ExecutionPolicy Bypass -File $p }
```

O comando baixa um script visível neste repositório. Esse script baixa o pacote da versão especificada, verifica seu SHA-256, extrai em uma pasta nova dentro de `%LOCALAPPDATA%\CNZScarne\releases` e abre a janela. Nenhuma análise começa sem consentimento na interface. O parâmetro `-DownloadOnly` do inicializador permite testar o download sem abrir o aplicativo. O ajuste de ExecutionPolicy vale somente para esse processo, sem alterar a configuração permanente do Windows.

## Download manual

Abra a [última release](https://github.com/teushz87-design/cnz-scarne-download/releases/latest), baixe `CNZScarne-win-x64.zip`, extraia todos os arquivos e execute `CNZScarne.exe`. Mantenha a pasta `rules` junto ao executável.

## Uso e limites

- **Rápido:** processos, inicialização, serviços e eventos.
- **Completo:** também percorre os arquivos das unidades locais selecionadas, respeitando permissões, exclusões e limites.
- Dados e relatórios permanecem locais. Sem upload ou banimentos automáticos.
- Indicadores e heurísticas exigem análise humana; não comprovam trapaça.
- Não acompanha uma base real de cheats. Regras demonstrativas vêm desativadas.
- Prefetch, tarefas agendadas e comparação histórica não estão implementados.

Os binários públicos podem ser baixados e copiados. O aplicativo não se apaga automaticamente e não remove relatórios salvos pelo usuário. O pacote inclui as licenças das dependências.
