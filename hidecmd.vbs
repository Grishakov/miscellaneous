Set objShell = WScript.CreateObject("WScript.Shell")
objShell.Run "command one", 0, True
objShell.Run "command two", 0, True

'or - CreateObject("Wscript.Shell").Run "prog.cmd",0,True
