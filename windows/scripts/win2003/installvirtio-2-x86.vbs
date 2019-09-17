
set objShell = CreateObject("Wscript.shell")
objShell.CurrentDirectory = "c:\virtio\win2003x86"
objShell.run("CMD /K .\devcon.exe install netkvm\netkvm.inf ""PCI\VEN_1AF4&DEV_1000&SUBSYS_00011AF4&REV_00"" ")
Set objShell = Nothing


