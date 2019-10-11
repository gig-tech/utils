 'Set your settings
    Basedir = "C:\virtio"
    strFileURL = "http://ftp.gig.tech:8000/win2003x64.zip"
    strHDLocation = "C:\virtio\virtio.zip"

   ' Fetch the file

    Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP")

    objXMLHTTP.open "GET", strFileURL, false
    objXMLHTTP.send()

    If objXMLHTTP.Status = 200 Then
      Set objADOStream = CreateObject("ADODB.Stream")
      objADOStream.Open
      objADOStream.Type = 1 'adTypeBinary

      objADOStream.Write objXMLHTTP.ResponseBody
      objADOStream.Position = 0    'Set the stream position to the start
      'If the extraction location does not exist create it.  
      Set fso = CreateObject("Scripting.FileSystemObject")
      If NOT fso.FolderExists(Basedir) Then
      fso.CreateFolder(Basedir)
      End If
      Set fso = Nothing
      Set objFSO = Createobject("Scripting.FileSystemObject")
        If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation
      Set objFSO = Nothing

      objADOStream.SaveToFile strHDLocation
      objADOStream.Close
      Set objADOStream = Nothing
    End if

    Set objXMLHTTP = Nothing


ZipFile="C:\virtio\virtio.Zip"
'The folder the contents should be extracted to.
ExtractTo="C:\virtio"

'If the extraction location does not exist create it.
Set fso = CreateObject("Scripting.FileSystemObject")
If NOT fso.FolderExists(ExtractTo) Then
   fso.CreateFolder(ExtractTo)
End If

'Extract the contants of the zip file.
set objShell = CreateObject("Shell.Application")
set FilesInZip=objShell.NameSpace(ZipFile).items
objShell.NameSpace(ExtractTo).CopyHere(FilesInZip)
Set fso = Nothing
Set objShell = Nothing



set objShell = CreateObject("Wscript.shell")

objShell.CurrentDirectory = "c:\virtio\win2003x64"
objShell.run("CMD /K .\devcon.exe install viostor\viostor.inf ""PCI\VEN_1AF4&DEV_1001&SUBSYS_00021AF4&REV_00"" ")
Set objShell = Nothing


