--- Variables
local player = {}
player.__index = player

local Ball = {}
Ball.__index = Ball

local Block = {}
Block.__index = Block

--- -------------------------------------
--- player Class
--- -------------------------------------

--- player Constructor
--- @param x integer
--- @param y integer
--- @param velocityX integer
--- @param color string
--- @param width integer
--- @param height integer
--- @return player
function player:new(x, y, velocityX, color, width, height)
	--print("player:new called")

	local self = setmetatable({}, player)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.velocityX = velocityX
	self.color = color
	self.score = 0
	return self
end

--- player tick
--- Apply movement to player
function player:tick()
	--print("player:tick called")

    self.x = self.x + self.velocityX
	
    local screenWidth = GAME_ENGINE:get_width()
	
    -- Clamp playerX
	if self.x < 0 then
        self.x = 0
    elseif self.x + self.width > screenWidth then
        self.x = screenWidth - self.width
    end
end

--- player draw
--- draw player on screen
function player:draw()
	--print("player:draw called")

    GAME_ENGINE:set_color(tonumber(self.color, 16))
    GAME_ENGINE:fill_rect(self.x, self.y, self.x + self.width, self.y + self.height)
end

--- -------------------------------------
--- Ball Class
--- -------------------------------------

--- Ball Constructor
--- @param x integer
--- @param y integer
--- @param radius integer
--- @param color string
--- @param velocityX integer
--- @param velocityY integer
--- @param speed integer
--- @return Ball
function Ball:new(x,y,radius, color,velocityX,velocityY, speed)
	--print("Ball:new called")

	local self = setmetatable({}, Ball)
	self.x = x
	self.y = y
	self.radius = radius
	self.color = color
	self.velocityX = velocityX
	self.velocityY = velocityY
	self.speed = speed
	return self
end

--- Move Ball in Window
function Ball:tick()
	--print("Ball:tick called")

	self.x = self.x + self.velocityX
	self.y = self.y + self.velocityY
end

-- Set Ball speed
function Ball:set_speed(speed)
	--print("Ball:set_speed called")

	self.speed = speed
end

--- draw Ball
function Ball:draw()
	--print("Ball:draw called")

	GAME_ENGINE:set_color(tonumber(self.color, 16))
	GAME_ENGINE:fill_oval(self.x - self.radius, self.y - self.radius, self.x + self.radius, self.y + self.radius)
end

--- Clamb Ball to bounds, returns false if the ball touches the bottom of the screen
--- @return boolean
function Ball:clamp_to_bounds()
	--print("Ball:clamp_to_bounds called")

	-- Clamp X
	if self.x - self.radius < 0 then
		self.x = self.radius
		self.velocityX = -self.velocityX
	elseif self.x + self.radius > GAME_ENGINE:get_width() then
		self.x = GAME_ENGINE:get_width() - self.radius
		self.velocityX = -self.velocityX
	end

	-- Clamp Y
	if self.y - self.radius < 0 then
		self.y = self.radius
		self.velocityY = -self.velocityY
	elseif self.y + self.radius > GAME_ENGINE:get_height() then
		return false
	end

	return true
end

--- Check player Collision
--- @param player player
function Ball:bounce(player)
	--print("Ball:bounce called")

	-- Step 1: Find the closest point on the block to the ball
    local closest_x = math.max(player.x, math.min(self.x, player.x + player.width))
    local closest_y = math.max(player.y, math.min(self.y, player.y + player.height))

    -- Step 2: Calculate the distance from the ball's center to the closest point
    local distance_x = self.x - closest_x
    local distance_y = self.y - closest_y

    -- Step 3: Check if there is a collision
    if (distance_x^2 + distance_y^2) <= (self.radius^2) then
        -- Step 4: Determine the collision side
        if math.abs(distance_x) > math.abs(distance_y) then
			-- Side, flip velocityX
            self.velocityX = -self.velocityX
        else
			-- To or bottom, flip velocityY and use angle
			-- Get hit x position [-1, 1]
			local hitX = (self.x - (player.x + player.width / 2)) / (player.width / 2)
			
			if hitX == 0 then -- 0 makes the ball go left and right
				hitX = 0.001
			end
			
			-- Calculate angle based on location of hit
			local angle = hitX * math.pi

			-- Apply new speed based on angle (ceil to stay away from 0 and make float into number)
			self.velocityX = math.ceil(self.speed * math.cos(angle))

			-- If the ball hit the left side and is going right
			if hitX < 0 and self.velocityX > 0 then
				-- Flip x direction
				self.velocityX = -self.velocityX
			-- If the ball hit the right side and is going left
			elseif hitX > 0 and self.velocityX < 0 then
				-- Flip x direction
				self.velocityX = -self.velocityX
			end

			-- Move ball out of player
			self.y = player.y - self.radius - 1

			-- Apply new speed based on angle (ceil to stay away from 0 and make float into number)
			self.velocityY = -math.ceil(self.speed * math.abs(math.sin(angle)))
        end
    end
end

--- -------------------------------------
--- Block Class
--- -------------------------------------

--- Block Constructor
--- @param x integer
--- @param y integer
--- @param color string
--- @param score integer
--- @param width integer
--- @param height integer
--- @return Block
function Block.new(x, y, color, score, width, height)
	--print("Block.new called")

	local self = setmetatable({}, Block)
	self.x = x
	self.y = y
	self.color = color
	self.score = score
	self.width = width
	self.height = height
	return self
end

--- draw Block
function Block:draw()
	--print("Block:draw called")

	GAME_ENGINE:set_color(tonumber(self.color, 16))
	GAME_ENGINE:fill_rect(self.x, self.y, self.x + self.width, self.y + self.height)

	GAME_ENGINE:set_color(tonumber("000000", 16))
    GAME_ENGINE:draw_rect(self.x, self.y, self.x + self.width, self.y + self.height)
end

--- Check Collision with Ball
--- @param ball Ball
--- @return integer
function Block:handle_overlap(ball)
	--print ("Block:IsOverlappingBall called")
    -- Step 1: Find the closest point on the block to the ball
    local closest_x = math.max(self.x, math.min(ball.x, self.x + self.width))
    local closest_y = math.max(self.y, math.min(ball.y, self.y + self.height))

    -- Step 2: Calculate the distance from the ball's center to the closest point
    local distance_x = ball.x - closest_x
    local distance_y = ball.y - closest_y

    -- Step 3: Check if there is a collision
    if (distance_x^2 + distance_y^2) <= (ball.radius^2) then
        -- Step 4: Determine the collision side
        if math.abs(distance_x) > math.abs(distance_y) then
            if distance_x > 0 then
				ball.velocityX = -ball.velocityX
                return self.score   -- Ball hit the left side of the block
            else
				ball.velocityX = -ball.velocityX
                return self.score  -- Ball hit the right side of the block
            end
        else
            if distance_y > 0 then
				ball.velocityY = -ball.velocityY
                return self.score    -- Ball hit the top side of the block
            else
				ball.velocityY = -ball.velocityY
                return self.score -- Ball hit the bottom side of the block
            end
        end
    end

    -- No collision
    return 0
end



-------------------------------------
------------ Game Logic -------------
-------------------------------------

--- Variables
local WINDOWHEIGHT = 600
local WINDOWWIDTH = 800
local BASESPEED = 4
local backgroundColor = "000000"
local isAlive = true
local highscore = 0
local hitSound = nil
local musicSound = nil
local deathSound = nil

local player = player:new(350, 550, 0, "BB0000", 100, 20)
local ball = Ball:new(400, 500, 5, "FFFFFF", BASESPEED, -BASESPEED, BASESPEED)
local blocks = {}

--- Setting game engine properties
function initialize()
	--print("initialize function called")

	GAME_ENGINE:set_title("Breakout Lua")
	GAME_ENGINE:set_width(WINDOWWIDTH)
	GAME_ENGINE:set_height(WINDOWHEIGHT)
	GAME_ENGINE:set_frame_rate(60)

	GAME_ENGINE:set_key_list("ad")

	initialize_variables()
end

-- initialize variables for game, mainly used as a Reset()
function initialize_variables()
	--print("initialize_variables function called")

	isAlive = true

	player.x = 350
	player.y = 550
	player.velocityX = 0
	player.score = 0

	ball.x = 395
	ball.y = 500
	ball.velocityX = BASESPEED
	ball.velocityY = -BASESPEED
	ball.speed = BASESPEED

	local rows = 8
	local cols = 14
	blocks = create_blocks(rows, cols)

	start_variables()
end

-- Create a table of blocks
-- @param rows integer
-- @param cols integer
-- @return table
function create_blocks(rows, cols)
	-- Set up blocks
	local blockTable = {}

	local windowSpacing = (GAME_ENGINE:get_height() // 6)
	local blockWidth = GAME_ENGINE:get_width() // cols
	local blockHeight = windowSpacing // rows

	-- Generate 8 rows of blocks, with 14 blocks
	for row = 1, rows do
		for col = 1, cols do
			-- Caluclate position of block
			local x = (col - 1) * (blockWidth)
			local y = (row - 1) * (blockHeight) + windowSpacing
	
			-- Create new block & insert in table
			local blockColor = "0000FF"
			local blockScore = 7
	
			if row > 2 then
				blockColor = "00AAFF"
				blockScore = 5
			end
			if row > 4 then
				blockColor = "00FF00"
				blockScore = 3
			end
			if row > 6 then
				blockColor = "00FFFF"
				blockScore = 1
			end
	
			local block = Block.new(x, y, blockColor, blockScore, blockWidth, blockHeight)
			table.insert(blockTable,block)
		end
	end

	return blockTable
end

function start()
	--print("start function called")
	
	hitSound = Audio.new("resources/hitSound.mp3")
	hitSound:add_action_listener(CALLER)
	musicSound = Audio.new("resources/musicSound.mp3")
	musicSound:add_action_listener(CALLER)
	deathSound = Audio.new("resources/deathSound.mp3")
	deathSound:add_action_listener(CALLER)

	start_variables()

	--myButton = Button.new("PLAY")
	--myButton:SetBounds(350, 150, 450, 250)
	--myButton:Show()
	--myButton:add_action_listener(CALLER)

end

-- start for game variables
function start_variables()
	--print("start_variables function called")

	musicSound:play(0, -1)
	musicSound:set_volume(50)
	musicSound:set_repeat(true)

	hitSound:set_volume(50)
	hitSound:set_repeat(false)

	deathSound:set_volume(50)
	deathSound:set_repeat(false)
end

function tick()
	--print("tick function called")

	musicSound:tick()
	deathSound:tick()
	hitSound:tick()

	if isAlive == true then
		player:tick()
		ball:tick()
		
		-- Check ball collision
		if ball:clamp_to_bounds() == false then
			game_over()
		end
		ball:bounce(player)
		
		-- Set ball speed based on score
		ball:set_speed(BASESPEED + (player.score // 20))
		
		local count = 0

		-- Check block collision
		for i, block in ipairs(blocks) do
			count = count + 1
			
			local overlappedScore = block:handle_overlap(ball)
			player.score = player.score + overlappedScore
			
			if overlappedScore > 0 then
				hitSound:play(0, -1)
				table.remove(blocks, i)
			end
		end

		if count == 0 then
			-- On win Reset game
			initialize_variables()
		end
	else
		if deathSound:is_playing() == false then
			initialize_variables()
		end
	end
end

function game_over()
	-- print("game_over function called")

	isAlive = false
	musicSound:stop()
	hitSound:stop()

	deathSound:play(0, -1)
end

function paint()
	--print("paint function called")
	
	--- Clear the window with background color
	GAME_ENGINE:fill_window_rect(tonumber(backgroundColor, 16))

	--- draw a rectangle
	player:draw()
	ball:draw()
	
	-- draw score
	draw_score(player.score)
	draw_high_score(player.score)

	-- draw Blocks
	for _, block in ipairs(blocks) do
		block:draw()
	end
end

function draw_score(score)
	--print("draw_score function called")

	GAME_ENGINE:set_color(tonumber("FFFFFF", 16))
	GAME_ENGINE:draw_string("Score: " .. score, 10, 10)
end

function draw_high_score(score)
	--print("draw_score function called")
	if score > highscore then
		highscore = score
	end

	GAME_ENGINE:set_color(tonumber("FFFFFF", 16))
	GAME_ENGINE:draw_string("Highscore: " .. highscore, GAME_ENGINE:get_width() - 100, 10)
end

function key_pressed(key)
	--print("key_pressed function called")

	if key == "A" then
		player.velocityX = 0
	elseif key == "D" then
		player.velocityX = 0
	end
end

function check_keyboard()
	--print("check_keyboard function called")

	if GAME_ENGINE:is_key_down(string.byte('A')) then
		player.velocityX = -BASESPEED
	end
	if GAME_ENGINE:is_key_down(string.byte('D')) then
		player.velocityX = BASESPEED
	end

end

function mouse_button_action(isLeft, isDown, x, y)
	--print("mouse_button_action function called")

	if isLeft and isDown then
		-- Mouse click logic in case needed
	end
end

function call_action(callerPtr)
	--print("call_action function called")

	--if callerPtr == myButton then
		--myButton:SetBounds(200, 200, 250, 250)
	--end
end