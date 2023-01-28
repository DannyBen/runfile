; --------------------------------------------------
; This script generates the demo svg
; NOTE: Run in the project root folder
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 50

Return

Type(Command, Delay=2000) {
  Send % Command
  Sleep 500
  Send {Enter}
  Sleep Delay
}

F12::
  ; Setup
  Type("{#} Press F11 to abort at any time")
  Type("cd ./support/demo")
  Type("rm runfile server.runfile")
  Type("rm cast.json {;} asciinema rec cast.json")

  ; Create runfile
  Type("run")
  Type("{#} Create a new runfile", 500)
  Type("run new")
  Type("vi runfile", 4000)
  Type(":exit", 500)

  ; Run it
  Type("run")
  Type("run hello")
  Type("run hello Luke --shout")

  ; Create a more advanced runfile
  Type("{#} Runfiles can import other runfiles", 500)
  Type("rm runfile")
  Type("run example multiple-runfiles")
  Type("vi runfile", 1000)  
  Send {Down 3}
  Sleep 500
  Send {End}
  Sleep 3000
  Type(":exit", 500)
  Type("vi server.runfile", 4000)
  Type(":exit", 500)
  
  ; Run it
  Type("run")
  Type("run --help")
  Type("run server")
  Type("run server start")
  
  ; Teardown
  Type("exit")
  Type("agg --font-size 20 cast.json ../cast.gif")
  Sleep 400
  Type("cd ../../")
  Type("{#} Done")
  ExitApp
Return

^F12::
  Reload
return

F11::
  ExitApp
return
