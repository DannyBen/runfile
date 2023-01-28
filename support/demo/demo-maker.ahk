; --------------------------------------------------
; This script generates the demo svg
; NOTE: Run in the project root folder
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 30

Return

Type(Command, Delay=2000) {
  Send % Command
  Sleep 500
  Send {Enter}
  Sleep Delay
}

F12::
  Type("{#} Press F11 to abort at any time")
  Type("cd ./support/demo")
  Type("rm cast.json {;} asciinema rec cast.json")

  Type("run")

  Type("run new")
  Type("vimcat runfile", 4000)
  ; Type(":exit", 500)

  ; Type("{#} Generate the bash script", 500)
  ; Type("bashly generate")
  
  ; Type("{#} Run the bash script", 500)
  ; Type("./cli")
  ; Type("./cli --help")
  ; Type("./cli download -h")
  ; Type("./cli download")
  ; Type("./cli download somefile")
  ; Type("./cli download somefile --force")

  Type("exit")
  Type("agg --font-size 20 cast.json cast.gif")
  Sleep 400
  Type("cd ../../")
  Type("{#} Done")
Return

^F12::
  Reload
return

F11::
  ExitApp
return
