#Persistent

; Initial state
isActive := false

; Create GUI
Gui, +AlwaysOnTop
Gui, Add, Button, gToggleLoop1 vButton1 w150 h100, Rotation without haste
Gui, Add, Button, gToggleLoop2 vButton2 w150 h100, Rotation WITH HASTE
Gui, Add, Text, vStatusText, Pick something!
Gui, Show, w175 h300, ENCHANTBOT!


; Functions to toggle the loops with buttons
ToggleLoop1() {
    global isActive
    isActive := !isActive

    if (isActive) {
        SetTimer, AttackingLoopNoHaste, 1000
        GuiControl,, Button1, !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		GuiControl,, StatusText, Running
    } else {
       	SetTimer, AttackingLoopNoHaste, Off
		GuiControl,, Button1, Rotation without haste
		GuiControl,, StatusText, Pick something!
        }
}

ToggleLoop2() {
    global isActive
    isActive := !isActive

    if (isActive) {
        SetTimer, AttackingLoopHaste, 1000
        GuiControl,, Button2, !!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		GuiControl,, StatusText, Running
	} else {
        SetTimer, AttackingLoopHaste, Off
		GuiControl,, Button2, Rotation WITH HASTE
		GuiControl,, StatusText, Pick something!
		}
}

AttackingLoopNoHaste:
		Counter1 := 0
		Counter2 := 0
		Send, 3
		Sleep, 4000										; 4 sec in between buff casts always
		Send, 4
		Sleep, 4000
		Send, 5
		Sleep, 4000
		Loop {										    ; Looping this 16 times is 120 seconds
			if (!isActive) || (Counter1 > 15) {
				break
			} else {
				Send, 1
				Sleep 2500									; 2.5 sec delay
				Send, {Tab}
				Send, 1
				Sleep 2500	
				Send, {Tab}
				Send, 2
				Sleep 2500	
				Send, {Tab}			
				Counter1++									
				
		}
	}	
return
		
		
AttackingLoopHaste:	
		Counter1 := 0
		Counter2 := 0
		Send, 3
		Sleep, 4000										; 4 sec in between buff casts always
		Send, 4
		Sleep, 4000
		Send, 5
		Sleep, 4000
		Loop {											; Looping this 20 times is 120 seconds
			if (!isActive) || (Counter1 > 19) {
					break
			} else {
				Send, 1
				Sleep 2000									; 2 sec delay instead
				Send, {Tab}
				Send, 1
				Sleep 2000	
				Send, {Tab}
				Send, 2
				Sleep 2000	
				Send, {Tab}								
				Counter2++									
		}
	}	
return



; Handle GUI close event
GuiClose:
ExitApp