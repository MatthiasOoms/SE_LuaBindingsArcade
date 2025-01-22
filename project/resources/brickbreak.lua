--- Variables
local Player = {}
Player.__index = Player

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
--- @param velocity_x integer
--- @param color string
--- @param width integer
--- @param height integer
--- @return Player
function Player:new(x, y, velocity_x, color, width, height)
	--print("player:new called")

	local self = setmetatable({}, Player)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.velocity_x = velocity_x
	self.color = color
	self.score = 0
	return self
end

--- player tick
--- Apply movement to player
function Player:tick()
	--print("player:tick called")

    self.x = self.x + self.velocity_x
	
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
function Player:draw()
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
--- @param velocity_x integer
--- @param velocity_y integer
--- @param speed integer
--- @return Ball
function Ball:new(x,y,radius, color,velocity_x,velocity_y, speed)
	--print("Ball:new called")

	local self = setmetatable({}, Ball)
	self.x = x
	self.y = y
	self.radius = radius
	self.color = color
	self.velocity_x = velocity_x
	self.velocity_y = velocity_y
	self.speed = speed
	return self
end

--- Move Ball in Window
function Ball:tick()
	--print("Ball:tick called")

	self.x = self.x + self.velocity_x
	self.y = self.y + self.velocity_y
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
		self.velocity_x = -self.velocity_x
	elseif self.x + self.radius > GAME_ENGINE:get_width() then
		self.x = GAME_ENGINE:get_width() - self.radius
		self.velocity_x = -self.velocity_x
	end

	-- Clamp Y
	if self.y - self.radius < 0 then
		self.y = self.radius
		self.velocity_y = -self.velocity_y
	elseif self.y + self.radius > GAME_ENGINE:get_height() then
		return false
	end

	return true
end

--- Check player Collision
--- @param player Player
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
			-- Side, flip velocity_x
            self.velocity_x = -self.velocity_x
        else
			-- To or bottom, flip velocity_y and use angle
			-- Get hit x position [-1, 1]
			local hitX = (self.x - (player.x + player.width / 2)) / (player.width / 2)
			
			if hitX == 0 then -- 0 makes the ball go left and right
				hitX = 0.001
			end
			
			-- Calculate angle based on location of hit
			local angle = hitX * math.pi

			-- Apply new speed based on angle (ceil to stay away from 0 and make float into number)
			self.velocity_x = math.ceil(self.speed * math.cos(angle))

			-- If the ball hit the left side and is going right
			if hitX < 0 and self.velocity_x > 0 then
				-- Flip x direction
				self.velocity_x = -self.velocity_x
			-- If the ball hit the right side and is going left
			elseif hitX > 0 and self.velocity_x < 0 then
				-- Flip x direction
				self.velocity_x = -self.velocity_x
			end

			-- Move ball out of player
			self.y = player.y - self.radius - 1

			-- Apply new speed based on angle (ceil to stay away from 0 and make float into number)
			self.velocity_y = -math.ceil(self.speed * math.abs(math.sin(angle)))
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
				ball.x = self.x - ball.radius - 1
				ball.velocity_x = -ball.velocity_x
                return self.score   -- Ball hit the left side of the block
            else
				ball.x = self.x + self.width + ball.radius + 1
				ball.velocity_x = -ball.velocity_x
                return self.score  -- Ball hit the right side of the block
            end
        else
            if distance_y > 0 then
				ball.y = self.y - ball.radius - 1
				ball.velocity_y = -ball.velocity_y
                return self.score    -- Ball hit the top side of the block
            else
				ball.y = self.y + self.height + ball.radius + 1
				ball.velocity_y = -ball.velocity_y
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
local background_color = "000000"
local is_alive = true
local highscore = 0
local hit_sound = nil
local music_sound = nil
local death_sound = nil

local player = Player:new(350, 550, 0, "BB0000", 100, 20)
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

	is_alive = true

	player.x = 350
	player.y = 550
	player.velocity_x = 0
	player.score = 0

	ball.x = 395
	ball.y = 500
	ball.velocity_x = BASESPEED
	ball.velocity_y = -BASESPEED
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
	local block_table = {}

	local window_spacing = (GAME_ENGINE:get_height() // 6)
	local block_width = GAME_ENGINE:get_width() // cols
	local block_height = window_spacing // rows

	-- Generate 8 rows of blocks, with 14 blocks
	for row = 1, rows do
		for col = 1, cols do
			-- Caluclate position of block
			local x = (col - 1) * (block_width)
			local y = (row - 1) * (block_height) + window_spacing
	
			-- Create new block & insert in table
			local block_color = "0000FF"
			local block_score = 7
	
			if row > 2 then
				block_color = "00AAFF"
				block_score = 5
			end
			if row > 4 then
				block_color = "00FF00"
				block_score = 3
			end
			if row > 6 then
				block_color = "00FFFF"
				block_score = 1
			end
	
			local block = Block.new(x, y, block_color, block_score, block_width, block_height)
			table.insert(block_table, block)
		end
	end

	return block_table
end

function start()
	--print("start function called")
	
	hit_sound = Audio.new("resources/hitSound.mp3")
	hit_sound:add_action_listener(CALLABLE)
	music_sound = Audio.new("resources/musicSound.mp3")
	music_sound:add_action_listener(CALLABLE)
	death_sound = Audio.new("resources/deathSound.mp3")
	death_sound:add_action_listener(CALLABLE)

	start_variables()

	--myButton = Button.new("PLAY")
	--myButton:SetBounds(350, 150, 450, 250)
	--myButton:Show()
	--myButton:add_action_listener(CALLABLE)

end

-- start for game variables
function start_variables()
	--print("start_variables function called")

	music_sound:play(0, -1)
	music_sound:set_volume(50)
	music_sound:set_repeat(true)

	hit_sound:set_volume(50)
	hit_sound:set_repeat(false)

	death_sound:set_volume(50)
	death_sound:set_repeat(false)
end

function tick()
	--print("tick function called")

	music_sound:tick()
	death_sound:tick()
	hit_sound:tick()

	if is_alive == true then
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
			
			local overlapped_score = block:handle_overlap(ball)
			player.score = player.score + overlapped_score
			
			if overlapped_score > 0 then
				hit_sound:play(0, -1)
				table.remove(blocks, i)
			end
		end

		if count == 0 then
			-- On win Reset game
			initialize_variables()
		end
	else
		if death_sound:is_playing() == false then
			initialize_variables()
		end
	end
end

function game_over()
	-- print("game_over function called")

	is_alive = false
	music_sound:stop()
	hit_sound:stop()

	death_sound:play(0, -1)
end

function paint()
	--print("paint function called")
	
	--- Clear the window with background color
	GAME_ENGINE:fill_window_rect(tonumber(background_color, 16))

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
		player.velocity_x = 0
	elseif key == "D" then
		player.velocity_x = 0
	end
end

function check_keyboard()
	--print("check_keyboard function called")

	if GAME_ENGINE:is_key_down(string.byte('A')) then
		player.velocity_x = -BASESPEED
	end
	if GAME_ENGINE:is_key_down(string.byte('D')) then
		player.velocity_x = BASESPEED
	end

end

function mouse_button_action(is_left, is_down, x, y)
	--print("mouse_button_action function called")

	if is_left and is_down then
		-- Mouse click logic in case needed
	end
end

function call_action(caller_ptr)
	--print("call_action function called")

	--if caller_ptr == myButton then
		--myButton:SetBounds(200, 200, 250, 250)
	--end
end