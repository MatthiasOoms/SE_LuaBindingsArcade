print("Lua script loaded")

--- Setting game engine properties
function Initialize()
	--print("Initialize function called")

	backgroundColor = "000000"
	left = 50

	GAME_ENGINE:SetTitle("BrickBreak Lua")
	GAME_ENGINE:SetWidth(800)
	GAME_ENGINE:SetHeight(600)
	GAME_ENGINE:SetFrameRate(60)
end

function Start()
	--print("Start function called")

	myButton = Button.new("TEST")
	myButton:SetText("CLICK ME")
	myButton:SetBounds(100, 100, 150, 150)
	myButton:Show()
	myButton:AddActionListener(CALLER)
end

function Tick()
	--print("Tick function called")

	left = left + 1
end

function Paint()
	--print("Paint function called")

	GAME_ENGINE:FillWindowRect(tonumber(backgroundColor, 16))

	--- Setting the color of rectangle
	GAME_ENGINE:SetColor(tonumber("FFFFFF", 16))

	--- Draw a rectangle
	local top = 100
	local right = 200
	local bottom = 200
	GAME_ENGINE:FillRect(left, top, right, bottom)
end

function CallAction(callerPtr)
	--print("CallAction function called")
	myButton:SetBounds(200, 200, 250, 250)
end