#Persistent

; Initial state
isActive := false
PauseScript := 0

; Create GUI
Gui, +AlwaysOnTop
Gui, Add, Button, gToggleLoop1 vButton1 w150 h90, No chords
Gui, Add, Button, gToggleLoop2 vButton2 w150 h90, Using chords
Gui, Add, Button, gToggleLoop3 vButton3 w150 h90, Bellow build
Gui, Add, Text, vStatusText, Pick something!
Gui, Show, w175 h350, BARDBOT


; Function to toggle the loop
ToggleLoop1() {
    global isActive
    isActive := !isActive

    if (isActive) {
        SetTimer, SendKeysNoChords, 1000
        GuiControl,, Button1, !!!!!!!!!!!!!!!!!!!!!!!!		; This just makes it look visually more obvious
        GuiControl,, StatusText, No chords
	} else {
        SetTimer, SendKeysNoChords, Off
        GuiControl,, Button1, No chords
        GuiControl,, StatusText, Pick something!
	}
}

ToggleLoop2() {
    global isActive
    isActive := !isActive

    if (isActive) {
        SetTimer, SendKeysChords, 1000
        GuiControl,, Button2, !!!!!!!!!!!!!!!!!!!!!!!!
        GuiControl,, StatusText, Using chords
	} else {
        SetTimer, SendKeysChords, Off
        GuiControl,, Button2, Using chords
        GuiControl,, StatusText, Pick something!
		}
}

ToggleLoop3() {
    global isActive
    isActive := !isActive	
	
    if (isActive) {
        SetTimer, SendKeysBellow, 1000
        GuiControl,, Button3, !!!!!!!!!!!!!!!!!!!!!!!!
        GuiControl,, StatusText, Bellow build
	} else {
        SetTimer, SendKeysBellow, Off
        GuiControl,, Button3, Bellow build
        GuiControl,, StatusText, Pick something!
		}
}

; Define the loop function
SendKeysNoChords:
	if (PauseScript = 0) {
		numberList := [7, 7, 7, 7, 7, 7, 7, 8, 8, 8]            ; Use as many numbers here as you want frequency in rotation.  
		Send, 134625                                            ; Always casts these when up, and in this order, so fix skills in this order
		Random, randomIndex, 1, % numberList.MaxIndex()
		randomNumber := numberList[randomIndex]
		Send, %randomNumber%
		Send, {Tab}
		Sleep 500
	} else {
		Sleep 100
		}
return

SendKeysChords:
	if (PauseScript = 0) {
		numberList := [7, 7, 7, 7, 7, 7, 8, 8, 9, 9]            ; This is the same logic as above but with a different distribution, this -includes- Chords as 9.  Use if we have a Templar to speed cast
		Send, 134625
		Random, randomIndex, 1, % numberList.MaxIndex()
		randomNumber := numberList[randomIndex]
		Send, %randomNumber%
		Send, {Tab}
		Sleep 500
	} else {
		Sleep 100	
		}	
return

SendKeysBellow:
	if (PauseScript = 0) {
		numberList := [7, 7, 7, 7, 7, 7, 8, 8, 9, 9]            ; This is the same logic as above but with a different distribution, this -includes- Chords as 9.
		Send, =134625								            
		Random, randomIndex, 1, % numberList.MaxIndex()
		randomNumber := numberList[randomIndex]
		Send, %randomNumber%
		Send, {Tab}
		Sleep 500
	} else {
		Sleep 100
		}
return

; Handle GUI close event
GuiClose:
ExitApp