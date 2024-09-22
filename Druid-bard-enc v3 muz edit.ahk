#Persistent

; Initial state
isActive := false

; Create GUI
Gui, +AlwaysOnTop
Gui, Add, Button, gToggleLoop vButton1 w150 h90, Bard
Gui, Add, Button, gToggleLoop2 vButton2 w150 h90, Druid
Gui, Add, Button, gToggleLoop3 vButton3 w150 h90, Enchanter
Gui, Add, Text, vStatusText, Pick something!
Gui, Show, w200 h250, Dbe2


; Function to toggle the loop
ToggleLoop() {
    global isActive
    isActive := !isActive

    if (isActive) {
        SetTimer, SendBard, 500
        GuiControl,, Button1, !!!!!!!!!!!!!!!!!!!!!!!!        ; This just makes it look visually more obvious
        GuiControl,, StatusText, No chords
    } else {
        SetTimer, SendBard, Off
        GuiControl,, Button1, Bard
        GuiControl,, StatusText, Pick something!
    }
}

ToggleLoop2() {
    global isActive
    isActive := !isActive

    if (isActive) {
        SetTimer, SendDruid, 500
        GuiControl,, Button2, !!!!!!!!!!!!!!!!!!!!!!!!
        GuiControl,, StatusText, Druid
    } else {
        SetTimer, SendDruid, Off
        GuiControl,, Button2, Druid
        GuiControl,, StatusText, Pick something!
        }
}
ToggleLoop3() {
    global isActive
    isActive := !isActive

    if (isActive) {
        SetTimer, SendEnc, 500
        SetTimer, TheBuffLoop, 600
        GuiControl,, Button3, !!!!!!!!!!!!!!!!!!!!!!!!        ; This just makes it look visually more obvious
        GuiControl,, StatusText, No chords
    } else {
        SetTimer, SendEnc, Off
        SetTimer, TheBuffLoop, Off
        GuiControl,, Button3, Enchanter
        GuiControl,, StatusText, Pick something!
    }
}
; Define the loop function
SendBard:
    numberList := [7, 7, 7, 7, 7, 8, 8, 9, 9, 0]             ; This is the same logic as above but with a different distribution, this -includes- Chords as 9 
    Send, 1346254897
    Random, randomIndex, 1, % numberList.MaxIndex()
    randomNumber := numberList[randomIndex]
    Send, %randomNumber%
    Send, {Tab}
    Sleep 250
return

SendDruid:
    numberList := [0]             ; This is the same logic as above but with a different distribution, this -includes- Chords as 9 
    Send, 152
    Random, randomIndex, 1, % numberList.MaxIndex()
    randomNumber := numberList[randomIndex]
    Send, %randomNumber%
    Send, {Tab}
    Sleep 250
return


SendEnc:
		Counter1 := 0
		Sleep, 4000
		Send, 7
		Sleep, 4000										; 4 sec in between buff casts always
		Send, 8
		Sleep, 4000
		Send, 9
		Sleep, 4000
		Loop {										    ; Looping this 16 times is 120 seconds
			if (!isActive) || (Counter1 > 15) {
				break
			} else {
				Send, 1
				Sleep 2500									; 2.5 sec delay
				Send, {Tab}
				Send, 2
				Sleep 2500	
				Send, {Tab}
				Send, 3
				Sleep 2500	
				Send, {Tab}			
				Counter1++									
				
		}
	}	
return

; Handle GUI close event
GuiClose:
ExitApp