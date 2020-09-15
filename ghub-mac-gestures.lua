--[[
Based on: https://github.com/mark-vandenberg/g-hub-mouse-gestures

- B4 + Left 	move right a space 	(Control+Right-Arrow)
- B4 + Right 	move left a space 	(Control+Left-Arrow)
- B5 + Left 	next page 			(Command+Right-Bracket)
- B5 + Right 	previous page 		(Command+Left-Bracket)
- B6 + Right 	mission control 	(Control+Up-Arrow)
]]--
 
-- Bottom thumb button
gestureButtonNumber = 4;

-- Top thumb button
navigationButtonNumber = 5;

-- DPI button
dpiButtonNumber = 6;

-- The minimal horizontal/vertical distance your mouse needs to be moved for the gesture to recognize in pixels
minimalHorizontalMovement = 10;
minimalVerticalMovement = 10;

-- Default values for 
horizontalStartingPosistion = 0;
verticalStartingPosistion = 0;
horizontalEndingPosistion = 0;
verticalEndingPosistion = 0;

-- Delay between keypresses in millies
delay = 20

-- Here you can enable/disable features of the script
dpiMissionControlEnabled = true
moveBetweenSpacesEnabled = true
browserNavigationEnabled = true

-- Toggles debugging messages
debuggingEnabeld = true

-- Event detection
function OnEvent(event, arg, family)
	if event == "MOUSE_BUTTON_PRESSED" and (arg == gestureButtonNumber or arg == navigationButtonNumber) then
		if debuggingEnabeld then OutputLogMessage("\nEvent: " .. event .. " for button: " .. arg .. "\n") end
		
		-- Get stating mouse posistion
		horizontalStartingPosistion, verticalStartingPosistion = GetMousePosition()
		
		if debuggingEnabeld then 
			OutputLogMessage("Horizontal starting posistion: " .. horizontalStartingPosistion .. "\n") 
			OutputLogMessage("Vertical starting posistion: " .. verticalStartingPosistion .. "\n") 
		end
	end

	if event == "MOUSE_BUTTON_RELEASED" and (arg == gestureButtonNumber or arg == navigationButtonNumber or arg == dpiButtonNumber) then
		if debuggingEnabeld then OutputLogMessage("\nEvent: " .. event .. " for button: " .. arg .. "\n") end
		
		-- Get ending mouse posistion
		horizontalEndingPosistion, verticalEndingPosistion = GetMousePosition()
		
		if debuggingEnabeld then 
			OutputLogMessage("Horizontal ending posistion: " .. horizontalEndingPosistion .. "\n") 
			OutputLogMessage("Vertical ending posistion: " .. verticalEndingPosistion .. "\n") 
		end

		-- Calculate difference in starting and ending mouse positions
		horizontalDifference = horizontalStartingPosistion - horizontalEndingPosistion
		verticalDifference = verticalStartingPosistion - verticalEndingPosistion

		if arg == dpiButtonNumber then
			performMissionControlGesture()
		else
			if horizontalDifference > minimalHorizontalMovement then mouseMovedLeft(arg) end
			if horizontalDifference < -minimalHorizontalMovement then mouseMovedRight(arg) end
		end
	end
end

function mouseMovedLeft(buttonNumber)
	if debuggingEnabeld then OutputLogMessage("mouseMovedLeft\n") end
	
	if buttonNumber == gestureButtonNumber and moveBetweenSpacesEnabled then 
		performSwipeLeftGesture()
	end
	if buttonNumber == navigationButtonNumber and browserNavigationEnabled then 
		performNextPageGesture()
	end
end

function mouseMovedRight(buttonNumber)
	if debuggingEnabeld then OutputLogMessage("mouseMovedRight\n") end
	
	if buttonNumber == gestureButtonNumber and moveBetweenSpacesEnabled then 
		performSwipeRightGesture()
	end
	if buttonNumber == navigationButtonNumber and browserNavigationEnabled then 
		performPreviousPageGesture()
	end
end

function performMissionControlGesture()
	if debuggingEnabeld then OutputLogMessage("performMissionControlGesture\n") end
	firstKey = "lctrl"
	secondKey = "up"
	pressTwoKeys(firstKey, secondKey)
end

function performSwipeLeftGesture()
	if debuggingEnabeld then OutputLogMessage("performSwipeRightGesture\n") end
	firstKey = "lctrl"
	secondKey = "left"
	pressTwoKeys(firstKey, secondKey)
end

function performSwipeRightGesture()
	if debuggingEnabeld then OutputLogMessage("performSwipeLeftGesture\n") end
	firstKey = "lctrl"
	secondKey = "right"
	pressTwoKeys(firstKey, secondKey)
end

function performNextPageGesture()
	if debuggingEnabeld then OutputLogMessage("performPreviousPageGesture\n") end
	firstKey = "lgui"
	secondKey = "lbracket"
	pressTwoKeys(firstKey, secondKey)
end

function performPreviousPageGesture()
	if debuggingEnabeld then OutputLogMessage("performNextPageGesture\n") end
	firstKey = "lgui"
	secondKey = "rbracket"
	pressTwoKeys(firstKey, secondKey)
end

function pressTwoKeys(firstKey, secondKey)
	PressKey(firstKey)
	Sleep(delay)
	PressKey(secondKey)
	Sleep(delay)
	ReleaseKey(firstKey)
	ReleaseKey(secondKey)
end
