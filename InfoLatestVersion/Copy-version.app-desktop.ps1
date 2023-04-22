if (-not $PSScriptRoot) {
    $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}

$solutionDir = Join-Path $PSScriptRoot "../.."

$assembly = Join-Path $solutionDir "KSP3.DesktopApp\Properties\AssemblyInfo.cs";
$file = Join-Path $solutionDir "KSP3_Application\InfoLatestVersion\ApplicationLastestVersion.xml";

$version = (Get-Content $assembly | Select-String -Pattern 'AssemblyVersion\("(\d+\.\d+\.\d+\.\d+)"\)').Matches.Groups[1].Value;
if($version){
    $newContent = (Get-Content $file) -replace '<version>(\d+\.\d+\.\d+\.\d+)</version>' , ('<version>'+$version+'</version>')
    Write-Output $newContent
    Set-Content -Path $file -Value $newContent
}
else{
     Write-Output ('Not found version in file ' + $assembly)
}