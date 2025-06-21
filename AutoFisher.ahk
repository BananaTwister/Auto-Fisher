#SingleInstance Force

; targetX1 := 840, targetY1 := 580, targetColor1 := 0xFFFFFF
; targetX2 := 1080, targetY2 := 585, targetColor2 := 0xFFFFFF
; targetX3 := 960, targetY3 := 580, targetColor3 := 0xFFFFFF

targetX1 := 920, targetY1 := 546, targetColor1 := 0xFFFFFF
targetX2 := 986, targetY2 := 546, targetColor2 := 0xFFFFFF
targetX3 := 960, targetY3 := 580, targetColor3 := 0xFFFFFF
targetX4 := 960, targetY4 := 506, targetColor4 := 0xFFFFFF
targetX5 := 960, targetY5 := 621, targetColor5 := 0xFFFFFF
targetX6 := 960, targetY6 := 540, targetColor6 := 0xFFFFFF

targetX7 := 920, targetY7 := 546, targetColor7 := 0xFF8585
targetX8 := 986, targetY8 := 546, targetColor8 := 0xFF8585
targetX9:= 960, targetY9 := 506, targetColor9 := 0xFF8585
targetX10 := 960, targetY10 := 621, targetColor10 := 0xFF8585
targetX11 := 960, targetY11 := 540, targetColor11 := 0xFF8585
targetX12 := 960, targetY12 := 580, targetColor12 := 0xFF8585

ToolTip("Press q to start", 1200, 900)
q:: {
    Loop {
	ToolTip("Dune", 1200, 900)
        Dune()

	ToolTip("Casting", 1200, 900)
        Send("2")

        Loop 4 {
	    ToolTip("Casting", 1200, 900)
            Cast()

	    ToolTip("Hook", 1200, 900)
            if !Hooked()
	    {
		Break
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
	ToolTip("Waiting", 1200, 900)
	Sleep(65000)
    }
}

Dune() {
    Send("1")
    Sleep(200)
    Click()
    Sleep(1200)
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
    global targetX2, targetY2, targetColor2
    global targetX3, targetY3, targetColor3
    global targetX4, targetY4, targetColor4
    global targetX5, targetY5, targetColor5
    global targetX6, targetY6, targetColor6
    global targetX7, targetY7, targetColor7
    global targetX8, targetY8, targetColor8
    global targetX9, targetY9, targetColor9
    global targetX10, targetY10, targetColor10
    global targetX11, targetY11, targetColor11
    global targetX12, targetY12, targetColor12

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
	color9 := PixelGetColor(targetX9, targetY9, "RGB")
	color10 := PixelGetColor(targetX10, targetY10, "RGB")
	color11 := PixelGetColor(targetX11, targetY11, "RGB")
	color12 := PixelGetColor(targetX12, targetY12, "RGB")

        if (color1 = targetColor1 || color2 = targetColor2 || color3 = targetColor3 || color4 = targetColor4 || color5 = targetColor5 || color6 = targetColor6
 	    || color7 = targetColor7 || color8 = targetColor8 || color9 = targetColor9 || color10 = targetColor10 || color11 = targetColor11 || color12 = targetColor12)
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
	color9 := PixelGetColor(targetX9, targetY9, "RGB")
	color10 := PixelGetColor(targetX10, targetY10, "RGB")
	color11 := PixelGetColor(targetX11, targetY11, "RGB")
	color12 := PixelGetColor(targetX12, targetY12, "RGB")

    if (color1 = targetColor1 || color2 = targetColor2 || color3 = targetColor3 || color4 = targetColor4 || color5 = targetColor5 || color6 = targetColor6 || color7 = targetColor7 || color8 = targetColor8 || color9 = targetColor9 || color10 = targetColor11 || color12 = targetColor12) 
    {
        disappearedAt := 0
        switched := true

        if (color2 == targetColor2 || color8 == targetColor8)
	{
    		Send("a")
	}
	else if (color4 != targetColor4 && color9 != targetColor9)
	{
    		Send("d")
	}
	else if (color4 == targetColor4 || color9 == targetColor9)
	{
    		Send("s")
	}
	else if (color2 != targetColor2 && color8 != targetColor8)
	{
    		Send("w")
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

Esc::ExitApp()
