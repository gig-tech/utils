Write-Host "`n`nRemoving VMware Tools from your VM`n`n" -ForegroundColor red -BackgroundColor white

function removevmtools {

  $product = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "VMware Tools"}
  $AppGUID = $product.properties["IdentifyingNumber"].value.toString()
  
  if ( $AppGUID.count -eq 0 ) {

    Write-Host  "`n`nVMware Tools are not found`n`n" -ForegroundColor red -BackgroundColor white
    Write-Host "`n`nPlease shutdown The VM and export it as OVA`n`n" -ForegroundColor red -BackgroundColor white

  } else {

    MsiExec.exe /norestart /q /x $AppGUID REMOVE=ALL
    Write-Host  "`n`nVMware Tools have been uninstalled`n`n" -ForegroundColor red -BackgroundColor white
    Write-Host "`n`nPlease shutdown The VM and export it as OVA`n`n" -ForegroundColor red -BackgroundColor white

  }
}

removevmtools