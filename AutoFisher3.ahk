#SingleInstance Force

global positions := Map()

ShowMainMenu()

targetColor1 := 0xFFFFFF
targetColor2 := 0xFF8585

q:: {
        Loop
	{
	    ToolTip("Casting", 1200, 900)
            Cast()

	    ToolTip("Hook", 1200, 900)
            if !Hooked()
	    {
		continue
	    }
                Sleep(50)

	    ToolTip("Catching", 1200, 900)
            while Catching()
                Sleep(100)

	    ToolTip("Dropping", 1200, 900)
            Sleep(500)
            Click()
            Sleep(200)
        }
}

Cast() {
    Sleep(200)
    Click()
    Sleep(900)
    Click()
    Sleep(1000)
}

Hooked() 
{
    global targetX1, targetY1, targetColor1
    global targetX2, targetY2
    global targetX3, targetY3
    global targetX4, targetY4
    global targetX5, targetY5, targetColor2
    global targetX6, targetY6
    global targetX7, targetY7
    global targetX8, targetY8

    startTime := A_TickCount
    timeout := 40000

    while (A_TickCount - startTime <= timeout) {
        color1 := PixelGetColor(targetX1, targetY1, "RGB")
        color2 := PixelGetColor(targetX2, targetY2, "RGB")
        color3 := PixelGetColor(targetX3, targetY3, "RGB")
    	color4 := PixelGetColor(targetX4, targetY4, "RGB")
	color5 := PixelGetColor(targetX5, targetY5, "RGB")
	color6 := PixelGetColor(targetX6, targetY6, "RGB")
	color7 := PixelGetColor(targetX7, targetY7, "RGB")
	color8 := PixelGetColor(targetX8, targetY8, "RGB")

        if (color1 = targetColor1 || color2 = targetColor1 || color3 = targetColor1 || color4 = targetColor1 || color5 = targetColor2 || color6 = targetColor2
 	    || color7 = targetColor2 || color8 = targetColor2)
            return true

        Sleep(50)
    }

    return false
}
Catching() {
    static switched := false
    static disappearedAt := 0

	color1 := PixelGetColor(targetX1, targetY1, "RGB")
	color2 := PixelGetColor(targetX2, targetY2, "RGB")
	color3 := PixelGetColor(targetX3, targetY3, "RGB")
	color4 := PixelGetColor(targetX4, targetY4, "RGB")
	color5 := PixelGetColor(targetX5, targetY5, "RGB")
	color6 := PixelGetColor(targetX6, targetY6, "RGB")
	color7 := PixelGetColor(targetX7, targetY7, "RGB")
	color8 := PixelGetColor(targetX8, targetY8, "RGB")

    if (color1 = targetColor1 || color2 = targetColor1 || color3 = targetColor1 || color4 = targetColor1 || color5 = targetColor2 || color6 = targetColor2 || color7 = targetColor2 || color8 = targetColor2) 
    {
        disappearedAt := 0
        switched := true

        if (color1 == targetColor1 || color5 == targetColor2)
	{
    		Send("d")
	}
	else
	{
		if (color2 == targetColor1 || color6 == targetColor2)
		{
			Send("a")
		}
		else
		{
			if (color3 == targetColor1 || color7 != targetColor2)
			{
				Send("s")
			}
			else
			{
				if (color4 == targetColor1 || color8 != targetColor2)
				{
					Send("w")
				}
			}
		}
	}

        return true
    }

    if (switched) 
    {
        if (!disappearedAt)
            disappearedAt := A_TickCount

        if (A_TickCount - disappearedAt >= 200) 
	{
            switched := false
            disappearedAt := 0
            return false
        }
    }

    return true
}

ShowMainMenu() 
{
    mainGui := Gui("+AlwaysOnTop", "Select Input Method")
    mainGui.Add("Text", , "Escape to cancel")
    mainGui.Add("Text", , "Choose how you would like to input positions of the areas.`n- Manual: click to record positions.`n- Position Code: enter saved coordinates.`n(For first-time setup, choose Manual.)")
    mainGui.Add("Button", "w100 vManualBtn", "Manual").OnEvent("Click", (*) => DoManual(mainGui))
    mainGui.Add("Button", "w100 vCodeBtn", "Position Code").OnEvent("Click", (*) => DoCode(mainGui))
    mainGui.Show("AutoSize Center")
}

DoManual(gui) 
{
    gui.Destroy()
    MsgBox "You will now be prompted to click 4 positions (left, right, top, bottom)."
global currentCaptureIndex := 1
global manualCaptureActive := true
Hotkey("g", CapturePosition, "On")
ToolTip("Start fishing`nwhen the game pops up`nposition mouse on the fishes head when its facing left`nPress g on the tip of the area", 1400, 750)
}


DoCode(RemoveGui) 
{
    RemoveGui.Destroy()
    codeGui := Gui("+AlwaysOnTop", "Enter Saved Coordinates")
    codeGui.Add("Text", , "Paste your saved coordinates below:")
    codeGui.Add("Text", , "Format: x1,y1,x2,y2,x3,y3,x4,y4")
    inputEdit := codeGui.Add("Edit", "w300 vCoordInput")
    codeGui.Add("Button", "w100", "Submit").OnEvent("Click", (*) => SaveCoords(codeGui, inputEdit))
    codeGui.Show("AutoSize Center")
}

SaveCoords(gui, editControl) {
    global targetX1, targetY1, targetX2, targetY2, targetX3, targetY3, targetX4, targetY4
    global targetX5, targetY5, targetX6, targetY6, targetX7, targetY7, targetX8, targetY8

    coords := editControl.Value
    values := StrSplit(coords, ",")

    if (values.Length != 8) {
        MsgBox "Invalid input. Please enter 8 comma-separated numbers (x1,y1,x2,y2,x3,y3,x4,y4)."
        return
    }

    targetX1 := values[1], targetY1 := values[2]
    targetX2 := values[3], targetY2 := values[4]
    targetX3 := values[5], targetY3 := values[6]
    targetX4 := values[7], targetY4 := values[8]

    targetX5 := targetX1, targetY5 := targetY1
    targetX6 := targetX2, targetY6 := targetY2
    targetX7 := targetX3, targetY7 := targetY3
    targetX8 := targetX4, targetY8 := targetY4

    gui.Destroy()
    ToolTip("Coordinates loaded. Press q to start fishing.", 1200, 900)
}

CapturePosition(*) 
{
    global currentCaptureIndex, manualCaptureActive
    global targetX1, targetY1, targetX2, targetY2, targetX3, targetY3, targetX4, targetY4
    global targetX5, targetY5, targetX6, targetY6, targetX7, targetY7, targetX8, targetY8

    if !manualCaptureActive || currentCaptureIndex > 4
        return

    MouseGetPos &x, &y

    switch currentCaptureIndex {
        case 1:
	    ToolTip("Fish again`nposition mouse on the fishes head when its facing right`nPress g on the tip of the area", 1400, 750)
            targetX1 := x, targetY1 := y
        case 2:
	     ToolTip("Get a rare fish`nposition mouse on the fishes head when its facing up`nPress g on the tip of the area", 1400, 750)
            targetX2 := x, targetY2 := y
        case 3:
	    ToolTip("Get a rare fish`nposition mouse on the fishes head when its facing down`nPress g on the tip of the area", 1400, 750)
            targetX3 := x, targetY3 := y
        case 4:
            targetX4 := x, targetY4 := y
    }

    currentCaptureIndex++

    if (currentCaptureIndex > 4) {
        manualCaptureActive := false
        ; Now safe to copy to other vars
        targetX5 := targetX1, targetY5 := targetY1
        targetX6 := targetX2, targetY6 := targetY2
        targetX7 := targetX3, targetY7 := targetY3
        targetX8 := targetX4, targetY8 := targetY4

	coords := targetX1 "," targetY1 "," targetX2 "," targetY2 "," targetX3 "," targetY3 "," targetX4 "," targetY4
	ShowCoordsGui(coords)

        ToolTip("All 4 positions recorded. Press q to start fishing.", 1200, 900)
    }
}

ShowCoordsGui(coords) {
    CoordsGui := Gui("+AlwaysOnTop", "Coordinates")
    CoordsGui.Add("Text", , "Copy these and paste them during next use")
    edit := CoordsGui.Add("Edit", "ReadOnly", coords)
    CoordsGui.Show("AutoSize Center")
}


Esc::ExitApp()
