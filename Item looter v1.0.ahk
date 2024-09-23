; Global variables for selected option and coordinates
SetBatchLines -1						; found suggestion
SelectedOption := ""
X1 := 0
Y1 := 0
X2 := 0
Y2 := 0
Countdown := 30

; Create the GUI with a dropdown menu for 6 options and a Start/Stop button
Gui, +AlwaysOnTop
Gui, Add, Text,, Choose an NGO resolution:
Gui, Add, DropDownList, vSelectedOption gUpdateCoordinates, 1920x1080 res|1824x1026 res|1600x900 res|1440x810 res|1366x768 res|1280x720 res
Gui, Add, Button, gStartMonitoring, Start Monitoring
Gui, Add, Button, gStopMonitoring, Stop Monitoring
Gui, Add, Text, vStatusText, Next scan in: %Countdown% seconds
Gui, Show, w250 h200, Loot search

; Array of image file paths (replace these with actual file paths)
ImageList := ["D:\AHK Images\IDscroll.png", "D:\AHK Images\elsetamulet\elsetamulet0.png", "D:\AHK Images\elsetamulet\elsetamulet1.png", "D:\AHK Images\elsetamulet\elsetamulet2.png", "D:\AHK Images\elsetamulet\elsetamulet3.png", "D:\AHK Images\elsetamulet\elsetamulet4.png", "D:\AHK Images\elsetamulet\elsetamulet5.png", "D:\AHK Images\elsetamulet\elsetamulet6.png", "D:\AHK Images\elsetamulet\elsetamulet7.png", "D:\AHK Images\elunamulet\elunamulet0.png", "D:\AHK Images\elunamulet\elunamulet1.png", "D:\AHK Images\elunamulet\elunamulet2.png", "D:\AHK Images\elunamulet\elunamulet3.png", "D:\AHK Images\elunamulet\elunamulet4.png", "D:\AHK Images\elunamulet\elunamulet5.png", "D:\AHK Images\elunamulet\elunamulet6.png", "D:\AHK Images\elunamulet\elunamulet7.png", "D:\AHK Images\elsetring\elsetring0.png", "D:\AHK Images\elsetring\elsetring1.png", "D:\AHK Images\elsetring\elsetring2.png", "D:\AHK Images\elsetring\elsetring3.png", "D:\AHK Images\elsetring\elsetring4.png", "D:\AHK Images\elsetring\elsetring5.png", "D:\AHK Images\elsetring\elsetring6.png", "D:\AHK Images\elsetring\elsetring7.png", "D:\AHK Images\elunring\elunring0.png", "D:\AHK Images\elunring\elunring1.png", "D:\AHK Images\elunring\elunring2.png", "D:\AHK Images\elunring\elunring3.png", "D:\AHK Images\elunring\elunring4.png", "D:\AHK Images\elunring\elunring5.png", "D:\AHK Images\elunring\elunring6.png", "D:\AHK Images\elunring\elunring7.png"]

Running := false

; Function to update the search area (coordinates) based on selected option
UpdateCoordinates:
	Global X1, Y1, X2, Y2
    Gui, Submit, NoHide ; Update the variable SelectedOption with the chosen dropdown value

    ; Update coordinates based on the selected option		; 65x65
    if (SelectedOption = "1920x1080 res") {
		X1 := 777, Y1 := 748, X2 := 842, Y2 := 813			
	} else if (SelectedOption = "1824x1026 res") {
		X1 := 0, Y1 := 670, X2 := 790, Y2 := 740 
	} else if (SelectedOption = "1600x900 res") {
		X1 := 0, Y1 := 610, X2 := 680, Y2 := 680 
	} else if (SelectedOption = "1440x810 res") {
		X1 := -, Y1 := 540, X2 := 600, Y2 := 600 
	} else if (SelectedOption = "1366x768 res") {
		X1 := 0, Y1 := 520, X2 := 590, Y2 := 580 
	} else if (SelectedOption = "1280x720 res") {
		X1 := 0, Y1 := 480, X2 := 540, Y2 := 540
	}
return

; Start button event
StartMonitoring:
    if (Running)
    {
        MsgBox, The function is already running!
        return
    }
    Running := true
	Countdown := 30 ; Reset countdown
    SetTimer, UpdateCountdown, 1000 ; Start countdown timer (1 second intervals)
    SetTimer, CheckImages, 30000 ; Set the timer to check every 15 seconds
    MsgBox,, 3, Monitoring started!
return

; Stop button event
StopMonitoring:
    if (!Running)
    {
        MsgBox, The function is already stopped!
        return
    }
    Running := false
	Countdown := 30 ; Reset countdown
    SetTimer, UpdateCountdown, Off ; Stop countdown timer (1 second intervals)
    SetTimer, CheckImages, Off ; Stop the timer
    GuiControl,, StatusText, Next scan in: %Countdown% seconds
	MsgBox,, 3, Monitoring stopped!
return

; Timer function that checks the images every 15 seconds
CheckImages:
	; Turns off CheckImages function timer
	SetTimer, CheckImages, Off												
	
    if (!Running)
    {
        return ; Do nothing if not running
    }

    ; Loop through the list of images
    FoundImage := false
    for each, imagePath in ImageList
    {
        ; Perform an image search in the specified area
        ImageSearch, FoundX, FoundY, X1, Y1, X2, Y2, *100 %imagePath%		; scale of 25 (0-255) for color variation
		Sleep, 100
		
        ; If image is found, set flag and break the loop
        if !ErrorLevel        {
            FoundImage := true
				break
			;} else if (ErrorLevel = 1) {
			;	MsgBox, 1, Scanned %imagePath% and image not found in the specified area.
			;} else if (ErrorLevel = 2) {
			;	MsgBox, There was a problem with the search (possibly invalid coordinates or file path).
			
        }
    }

    ; If image was found, click the Loot button, otherwise click the trash button
    if (FoundImage)
    {
        Send, \
    }

	; Reset CheckImages function timer
	SetTimer, CheckImages, 30000										; Turns back on after searches
	
return

; Countdown timer function
UpdateCountdown:
    Countdown -= 1
    if (Countdown <= 0)
    {
        Countdown := 30 ; Reset the countdown after reaching 0
    }
    GuiControl,, StatusText, Next scan in: %Countdown% seconds ; Update status text
return

; Close the GUI properly
GuiClose:
    ExitApp
return
