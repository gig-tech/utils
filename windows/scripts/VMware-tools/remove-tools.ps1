
Write-Host "`n`nRemoving VMware tools from your VM machine`n`n" -ForegroundColor red -BackgroundColor white

function removevmtools {
    
    $product = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "VMware Tools"}
    $AppGUID = $product.properties["IdentifyingNumber"].value.toString()
    
    if ( $AppGUID.count -eq 0 ) {

      Write-Host  "`n`nVMware Tools not found`n`n" -ForegroundColor red -BackgroundColor white
      Write-Host "`n`nPlease Shtudown The VM and Export it as OVA`n`n" -ForegroundColor red -BackgroundColor white

    } else {

    MsiExec.exe /norestart /q /x $AppGUID REMOVE=ALL
    Write-Host  "`n`nVMware Tools Has Been Uninstalled`n`n" -ForegroundColor red -BackgroundColor white
    Write-Host "`n`nPlease Shtudown The VM and Export it as OVA`n`n" -ForegroundColor red -BackgroundColor white

    }
}

removevmtools