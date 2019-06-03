$Date = Get-Date
$drivers_dir = "C:\Windows\drivers"
Set-Location -Path $drivers_dir

Write-Host "`n`nWelcome To Windows VirtIO Drivers installation Utility`n`n"   -ForegroundColor red -BackgroundColor white



Write-Host "please select your windows version

( 1 )  - windows 2012 
( 2 )  - window 2012 R2
( 3 )  - windows 2016 


"

$choice = Read-Host -Prompt 'Input your Choice Please'


function removevmtools {

try {
$product = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "VMware Tools"}
$AppGUID = $product.properties["IdentifyingNumber"].value.toString()
if ( $AppGUID.count -eq 0 )
{

  Write-Host  "`n`n VMware Tools not found`n`n"   -ForegroundColor red -BackgroundColor white
  Write-Host "`n`nVirtIo Drivers Successfully Installed  please Shtudown The VM and Export it as OVA`n`n"   -ForegroundColor red -BackgroundColor white

}

else {

MsiExec.exe /norestart /q/x $AppGUID REMOVE=ALL
Start-Sleep -s 5
Write-Host  "`n`n VMware Tools Has Been Uninstalled`n`n"   -ForegroundColor red -BackgroundColor white
Write-Host "`n`nVirtIo Drivers Successfully Installed  please Shtudown The VM and Export it as OVA`n`n"   -ForegroundColor red -BackgroundColor white
}


}
catch{
 Write-Host  "`n`n VMware Tools not found`n`n"   -ForegroundColor red -BackgroundColor white
 Write-Host "`n`nVirtIo Drivers Successfully Installed  please Shtudown The VM and Export it as OVA`n`n"   -ForegroundColor red -BackgroundColor white
  
}
}


function cleanup {

Remove-Item -Path $drivers_dir\*.cat
Remove-Item -Path $drivers_dir\*.inf
Remove-Item -Path $drivers_dir\*.sys
Remove-Item -Path $drivers_dir\*.zip
Remove-Item -Path $drivers_dir\*.exe
Remove-Item -Path $drivers_dir\*.reg
}


Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}






function drv-install

{
  Set-Location -Path $drivers_dir
  certutil.exe -addstore TrustedPublisher virtiocert.cer
  .\devcon.exe install viostor.inf "PCI\VEN_1AF4&DEV_1001&SUBSYS_00021AF4&REV_00"
  Start-Sleep -s 3
  .\devcon.exe install vioscsi.inf "PCI\VEN_1AF4&DEV_1004&SUBSYS_00081AF4&REV_00"
  Start-Sleep -s 3
  pnputil.exe -i -a netkvm.inf
  Start-Sleep -s 3
  reg.exe import virtio.reg *>&1 | Out-Null

}


function download_files

{


if ( $choice -eq 1)
{
  $version = "win2012"
  $devconurl = "ftp://pub:pub1234@ftp.gig.tech/Windows/virtio-drivers/devcon.exe"
  $output_dir2 = "$drivers_dir\devcon.exe"
  (new-object System.Net.Webclient).DownloadFile($devconurl,$output_dir2)
  $url = "ftp://pub:pub1234@ftp.gig.tech/Windows/virtio-drivers/$version/$version.zip"
  $output_dir = "$drivers_dir\$version.zip"
  (new-object System.Net.Webclient).DownloadFile($url,$output_dir)
  $certpath = "$drivers_dir\virtiocert.cer"
  $certurl = "ftp://pub:pub1234@ftp.gig.tech/Windows/virtiocert.cer"
  (new-object System.Net.Webclient).DownloadFile($certurl,$certpath)
  Unzip $output_dir $drivers_dir
}

elseif ($choice -eq 2)

{

  $version = "win2012R2"
  $devconurl = "ftp://pub:pub1234@ftp.gig.tech/Windows/virtio-drivers/devcon.exe"
  $output_dir2 = "$drivers_dir\devcon.exe"
  (new-object System.Net.Webclient).DownloadFile($devconurl,$output_dir2)
  $url = "ftp://pub:pub1234@ftp.gig.tech/Windows/virtio-drivers/$version/$version.zip"
  $output_dir = "$drivers_dir\$version.zip"
  (new-object System.Net.Webclient).DownloadFile($url,$output_dir)
  $certpath = "$drivers_dir\virtiocert.cer"
  $certurl = "ftp://pub:pub1234@ftp.gig.tech/Windows/virtiocert.cer"
  (new-object System.Net.Webclient).DownloadFile($certurl,$certpath)
  Unzip $output_dir $drivers_dir
}

elseif ($choice -eq 3)
{
  $version = "win2016"
  $devconurl = "ftp://pub:pub1234@ftp.gig.tech/Windows/virtio-drivers/devcon.exe"
  $output_dir2 = "$drivers_dir\devcon.exe"
  (new-object System.Net.Webclient).DownloadFile($devconurl,$output_dir2)
  $url = "ftp://pub:pub1234@ftp.gig.tech/Windows/virtio-drivers/$version/$version.zip"
  $output_dir = "$drivers_dir\$version.zip"
  (new-object System.Net.Webclient).DownloadFile($url,$output_dir)
  $certpath = "$drivers_dir\virtiocert.cer"
  $certurl = "ftp://pub:pub1234@ftp.gig.tech/Windows/virtiocert.cer"
  (new-object System.Net.Webclient).DownloadFile($certurl,$certpath)
  Unzip $output_dir $drivers_dir
}

else
{

  echo " your input is invalid please chose 1 or 2 or3 "
  Write-Host "You input server incorrect  on '$Date'"
  exit 
 
}



}



cleanup

download_files

drv-install

removevmtools
