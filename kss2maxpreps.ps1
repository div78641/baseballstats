param ($fileName)

if (-not $fileName)
{
    Write-Host "USAGE: .\kss2maxpreps.ps1 [-fileName] xml-file-name"
    exit;
}

trap [Exception]
{
    Write-Host $_.Exception;
}

$kss = Resolve-Path ("input\" + $fileName + ".kss");
$textOutput = $PSScriptRoot + "\output\" + $fileName + ".txt";
$xslFile = Resolve-Path "Kss2MaxPrepsImport.xsl";

$xslt = New-Object System.Xml.Xsl.XslCompiledTransform;
$xslt.Load($xslFile);

$xslt.Transform($kss, $textOutput);

Write-Host "generated" $textOutput;