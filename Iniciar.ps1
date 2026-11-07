[CmdletBinding()]
param([switch]$DownloadOnly)
$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'
[Net.ServicePointManager]::SecurityProtocol=[Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
$version='v0.1.0'
$url='https://github.com/teushz87-design/cnz-scarne-download/releases/download/'+$version+'/CNZScarne-win-x64.zip'
$expectedHash='6e1334c805444f060280ae0008af23e96fd6bc5a44b899125b63a19639644397'
$installRoot=Join-Path $env:LOCALAPPDATA 'CNZScarne\releases'
$installDir=Join-Path $installRoot ($version+'-'+[guid]::NewGuid().ToString('N'))
$null=New-Item -ItemType Directory -Path $installDir -Force
$archive=Join-Path $installDir 'CNZScarne-win-x64.zip'
Write-Output 'Baixando CNZ Scarne do GitHub...'
Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile $archive
if((Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash -ine $expectedHash){throw 'SHA-256 divergente. O aplicativo não será aberto.'}
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip=[IO.Compression.ZipFile]::OpenRead($archive)
try {
    $prefix=[IO.Path]::GetFullPath($installDir)+[IO.Path]::DirectorySeparatorChar
    foreach($entry in $zip.Entries){
        if($entry.FullName.Contains(':') -or [IO.Path]::IsPathRooted($entry.FullName)){throw 'Caminho inválido no pacote.'}
        $destination=[IO.Path]::GetFullPath((Join-Path $installDir $entry.FullName))
        if(!$destination.StartsWith($prefix,[StringComparison]::OrdinalIgnoreCase)){throw 'Caminho fora da pasta de instalação.'}
    }
} finally {$zip.Dispose()}
Expand-Archive -LiteralPath $archive -DestinationPath $installDir
$exe=Join-Path $installDir 'CNZScarne.exe'
if(!(Test-Path -LiteralPath $exe) -or !(Test-Path -LiteralPath (Join-Path $installDir 'rules\indicators.json'))){throw 'Pacote incompleto.'}
Write-Output "CNZ Scarne disponível em: $installDir"
if(!$DownloadOnly){ & $exe }
