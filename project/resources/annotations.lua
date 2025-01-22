--- @meta
--- This file provides type annotations for Lua scripts interacting with C++ via SOL2.

--- -------------------------------------
--- Callable Variable
--- -------------------------------------
--- @class Callable
CALLER = {}

--- Call Action
--- @param caller Caller*
--- @return nil
function CALLER:call_action(caller) end

--- -------------------------------------
--- Caller Class + Variable
--- -------------------------------------
--- @class Caller
CALLER = {}

--- Add Action Listener
--- @param targetPtr Callable*
--- @return boolean
function CALLER:add_action_listener(targetPtr) end

--- Remove Action Listener
--- @param targetPtr Callable*
--- @return boolean
function CALLER:remove_action_listener(targetPtr) end

--- -------------------------------------
--- Button Class
--- -------------------------------------
--- @class Button

--- New Button
--- @param str string
--- @return Button
function Button.new(str) end

--- New Button
--- @return Button
function Button.new() end

--- Show
--- @return nil
function Button:show() end

--- Hide
--- @return nil
function Button:hide() end

--- Set Bounds
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return nil
function Button:set_bounds(left, top, right, bottom) end

--- Set Enabled
--- @param enable boolean
--- @return nil
function Button:set_enabled(enable) end

--- Set Text
--- @param text string
--- @return nil
function Button:set_text(text) end

--- Set Font
--- @param font_name string
--- @param bold boolean
--- @param italic boolean
--- @param underline boolean
--- @param size integer
--- @return nil
function Button:set_font(font_name, bold, italic, underline, size) end

--- Get Bounds
--- @return RECT
function Button:get_bounds() end

--- Get Text
--- @return string
function Button:get_text() end

--- Get type
--- @return Caller::Type
function Button:get_type() end

--- Add Action Listener
--- @param targetPtr Callable*
--- @return boolean
function Button:add_action_listener(targetPtr) end

--- Remove Action Listener
--- @param targetPtr Callable*
--- @return boolean
function Button:remove_action_listener(targetPtr) end

--- -------------------------------------
--- Audio Class
--- -------------------------------------
--- @class Audio

--- New Audio
--- @param file_name string
--- @return Audio
function Audio.new(file_name) end

--- Tick
--- @return nil
function Audio:tick() end

--- Play
--- @param msecStart integer
--- @param msecStop integer
--- @return nil
function Audio:play(msecStart, msecStop) end

--- Pause
--- @return nil
function Audio:pause() end

--- Stop
--- @return nil
function Audio:stop() end

--- Set Volume
--- @param volume integer
--- @return nil
function Audio:set_volume(volume) end

--- Set Repeat
--- @param set_repeat boolean
--- @return nil
function Audio:set_repeat(set_repeat) end

-- Get Name
--- @return string
function Audio:get_name() end

--- Get Alias
--- @return string
function Audio:get_alias() end

--- Get Duration
--- @return integer
function Audio:get_duration() end

--- Is Playing
--- @return boolean
function Audio:is_playing() end

--- Is Paused
--- @return boolean
function Audio:is_paused() end

--- Get Repeat
--- @return boolean
function Audio:get_repeat() end

--- Exists
--- @return boolean
function Audio:exists() end

--- Get Volume
--- @return integer
function Audio:get_volume() end

--- Get Type
--- @return Caller::Type
function Audio:get_type() end

--- Add Action Listener
--- @param targetPtr Callable*
--- @return boolean
function Audio:add_action_listener(targetPtr) end

--- Remove Action Listener
--- @param targetPtr Callable*
--- @return boolean
function Audio:remove_action_listener(targetPtr) end

--- -------------------------------------
--- Game Engine Class
--- -------------------------------------
--- @class GameEngine
GAME_ENGINE = {}

--- GameEngine Setters

--- Sets Window Title
--- @param title string
--- @return nil
function GAME_ENGINE:set_title(title) end

--- Set Window position
--- @param left integer
--- @param top integer
--- @return nil
function GAME_ENGINE:set_window_position(left, top) end
    
--- Set Window Region
--- @param region HitRegion
--- @return boolean
function GAME_ENGINE:set_window_region(region) end
    
--- Set Key Listener
--- @param key_list string
--- @return nil
function GAME_ENGINE:set_key_list(key_list) end
        
--- Sets Window Frame Rate
--- @param frameRate integer
--- @return nil
function GAME_ENGINE:set_frame_rate(frameRate) end

--- Sets Window Width
--- @param width integer
--- @return nil
function GAME_ENGINE:set_width(width) end

--- Sets Window Height
--- @param height integer
--- @return nil
function GAME_ENGINE:set_height(height) end

--- GameEngine General Functions

--- Sets Window Full Screen
--- @return boolean
function GAME_ENGINE:go_fullscreen() end

--- Sets Window Windowed Mode
--- @return boolean
function GAME_ENGINE:go_windowed_mode() end

--- Shows Mouse Pointer
--- @param value boolean
--- @return nil
function GAME_ENGINE:show_mouse_pointer(value) end

--- Quit Game
--- @return nil
function GAME_ENGINE:quit() end

--- Return if Window is Full Screen
--- @return boolean
function GAME_ENGINE:is_fullscreen() end

--- Check What Key is Pressed
--- @param key integer
--- @return boolean
function GAME_ENGINE:is_key_down(key) end

--- Show Message Box
--- @param message string
--- @return nil
function GAME_ENGINE:message_box(message) end
    
--- Show Message Box
--- @param message TCHAR*
--- @return nil
function GAME_ENGINE:message_box(message) end

--- Show Message Continue Box
--- @param message string
--- @return boolean
function GAME_ENGINE:message_continue(message) end

--- Text Dimensions
--- @param text string
--- @param font Font*
--- @return nill
function GAME_ENGINE:calculate_text_dimensions(text, font) end

--- Text Dimensions
--- @param text string
--- @param font Font*
--- @param rect RECT
--- @return nill
function GAME_ENGINE:calculate_text_dimensions(text, font, rect) end

--- Set Color
--- @param color DWORD
--- @return nil
function GAME_ENGINE:set_color(color) end

--- Set font
--- @param font Font*
--- @return nil
function GAME_ENGINE:set_font(font) end

--- GameEngine Draw Functions

--- Fill Window Rectangle
--- @param color DWORD
--- @return boolean
function GAME_ENGINE:fill_window_rect(color) end

--- Draw Line
--- @param x1 integer
--- @param y1 integer
--- @param x2 integer
--- @param y2 integer
--- @return boolean
function GAME_ENGINE:draw_line(x1, y1, x2, y2) end

--- Draw Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GAME_ENGINE:draw_rect(left, top, right, bottom) end

--- Draw Round Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param radius integer
--- @return boolean
function GAME_ENGINE:draw_round_rect(left, top, right, bottom, radius) end

--- Draw Filled Round Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param radius integer
--- @return boolean
function GAME_ENGINE:fill_round_rect(left, top, right, bottom, radius) end

--- Draw Filled Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GAME_ENGINE:fill_rect(left, top, right, bottom) end

--- Draw Filled Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param opacity integer
--- @return boolean
function GAME_ENGINE:fill_rect(left, top, right, bottom, opacity) end

--- Draw Oval
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GAME_ENGINE:draw_oval(left, top, right, bottom) end

--- Draw Filled Oval
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GAME_ENGINE:fill_oval(left, top, right, bottom) end

--- Draw Filled Oval
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param opacity integer
--- @return boolean
function GAME_ENGINE:fill_oval(left, top, right, bottom, opacity) end

--- Draw Arc
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param start_degree integer
--- @param angle integer
--- @return boolean
function GAME_ENGINE:draw_arc(left, top, right, bottom, start_degree, angle) end

--- Draw Filled Arc
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param start_degree integer
--- @param angle integer
--- @return boolean
function GAME_ENGINE:fill_arc(left, top, right, bottom, start_degree, angle) end

--- Draw String
--- @param text string
--- @param left integer
--- @param top integer
--- @return integer
function GAME_ENGINE:draw_string(text, left, top) end

--- Draw String
--- @param text string
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return integer
function GAME_ENGINE:draw_string(text, left, top, right, bottom) end

--- Draw Bitmap
--- @param bit_map Bitmap*
--- @param left integer
--- @param top integer
--- @return boolean
function GAME_ENGINE:draw_bitmap(bit_map, left, top) end

--- Draw Bitmap
--- @param bit_map Bitmap*
--- @param left integer
--- @param top integer
--- @param rect RECT
--- @return boolean
function GAME_ENGINE:draw_bitmap(bit_map, left, top, rect) end

--- Draw Polygon
--- @param points POINT*
--- @param num_points integer
--- @return boolean
function GAME_ENGINE:draw_polygon(points, num_points) end

--- Draw Polygon
--- @param points POINT*
--- @param num_points integer
--- @param close boolean
--- @return boolean
function GAME_ENGINE:draw_polygon(points, num_points, close) end

--- Draw Filled Polygon
--- @param points POINT*
--- @param num_points integer
--- @return boolean
function GAME_ENGINE:fill_polygon(points, num_points) end

--- Draw Filled Polygon
--- @param points POINT*
--- @param num_points integer
--- @param close boolean
--- @return boolean
function GAME_ENGINE:fill_polygon(points, num_points, close) end

--- Gets Draw Color
--- @return DWORD
function GAME_ENGINE:get_draw_color() end

--- Repaint
--- @return boolean
function GAME_ENGINE:repaint() end

--- Accessor Member Functions

--- Get Screen Width
--- @return integer
function GAME_ENGINE:get_title() end

--- Get Screen Height
--- @return integer
function GAME_ENGINE:get_width() end

--- Get Screen Height
--- @return integer
function GAME_ENGINE:get_height() end

--- Get Frame Rate
--- @return integer
function GAME_ENGINE:get_frame_rate() end

--- Get Frame Delay
--- @return integer
function GAME_ENGINE:get_frame_delay() end
    
--- Get Window Position
--- @return POINT
function GAME_ENGINE:get_window_position() end

--- Has Window Region
--- @return boolean
function GAME_ENGINE:has_window_region() end

--- Predefined Game Engine
--- @type GameEngine
GAME_ENGINE.GAME_ENGINE = GAME_ENGINE

--- -------------------------------------
--- Game Class
--- -------------------------------------
--- @class GAME

--- Initialize
--- @return nil
function GAME:initialize() end

--- Start
--- @return nil
function GAME:start() end
    
--- End
--- @return nil
function GAME:end() end

--- Paints
--- @return nil
function GAME:paint() end

--- Tick
--- @return nil
function GAME:tick() end

--- Mouse Button Action
--- @param isLeft boolean
--- @param isDown boolean
--- @param x integer
--- @param y integer
--- @return nil
function GAME:mouse_button_action(isLeft, isDown, x, y) end

--- Mouse Wheel Action
--- @param x integer
--- @param y integer
--- @param distance integer
--- @return nil
function GAME:mouse_wheel_action(x, y, distance) end

--- Mouse Move
--- @param x integer
--- @param y integer
--- @return nil
function GAME:mouse_move(x, y) end

--- Check Keyboard
--- @return nil
function GAME:check_keyboard() end

--- Key Pressed
--- @param key string
--- @return nil
function GAME:key_pressed(key) end

--- Call Action
--- @param caller Caller
--- @return nil
function GAME:call_action(caller) end