; Global variable to keep track of whether the function is running
Running := false

; Array of X, Y coordinates (replace these values with your actual coordinates)
; This relates to 1920 by 1080 resolution

Coords := [[789, 722], [787, 722], [788, 722], [789, 723], [787, 723], [788, 723], [789, 724], [787, 724], [788, 724]]

; Create the GUI with a Start and Stop button
Gui, +AlwaysOnTop
Gui, Add, Button, gStartMonitoring, Start
Gui, Add, Button, gStopMonitoring, Stop
Gui, Show, w300 h100, Legendary Monitor

return ; End of auto-execute section, waits for user input

; Start button event
StartMonitoring:
    if (Running)
    {
        MsgBox, The function is already running!
        return
    }
    Running := true
    SetTimer, CheckPixels, 20000 ; Set the timer to check every 20 seconds
    MsgBox, Monitoring started!
return

; Stop button event
StopMonitoring:
    if (!Running)
    {
        MsgBox, The function is already stopped!
        return
    }
    Running := false
    SetTimer, CheckPixels, Off ; Stop the timer
    MsgBox, Monitoring stopped!
return

; Timer function that checks the pixels every 30 seconds
CheckPixels:
    if (!Running)
    {
        return ; Do nothing if not running
    }
    
    ; Set to false, will turn true if any pixel matches the color
    ColorFound := false
    
    ; Loop through all sets of coordinates
    for each, coord in Coords
    {
        X := coord[1]
        Y := coord[2]
        
        ; Get the pixel color at (X, Y)
        CoordMode, Pixel, Screen
		PixelGetColor, color, X, Y, RGB
        
        ; Check if the color is FF7700 (RGB format)
        if (color = 0xFF7700)								; This is the color "Orange" for legendaries
        {
            ColorFound := true
            break ; Exit the loop if we find the color
        }
    }

    ; If the color was found, send the "\" key, otherwise send "Del"
    if (ColorFound)
    {
        Send, \
    }
    else
    {
        Send, {Del}
    }
return

; Close the GUI properly
GuiClose:
    ExitApp
return