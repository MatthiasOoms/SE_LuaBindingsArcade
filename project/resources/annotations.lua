--- @meta
--- This file provides type annotations for Lua scripts interacting with C++ via SOL2.

---@alias DWORD integer @An unsigned 32-bit integer (0 to 4,294,967,295)

--- -------------------------------------
--- Type Table
--- -------------------------------------
--- @class Type
--- Table mapping string identifiers to specific C++ enum values.
--- Provides a Lua-accessible interface to types defined in the C++ backend.

--- Type table definition
--- @type table<string, integer>
Type = {}

--- Represents a text box element.
--- @type integer
Type.text_box = nil

--- Represents a button element.
--- @type integer
Type.button = nil

--- Represents a timer.
--- @type integer
Type.timer = nil

--- Represents an audio element.
--- @type integer
Type.audio = nil

--- Represents a video element.
--- @type integer
Type.video = nil

--- -------------------------------------
--- Shape Table
--- -------------------------------------
--- @class Shape
--- Table mapping string identifiers to specific C++ enum values.
--- Provides a Lua-accessible interface to types defined in the C++ backend.

--- Shape table definition
--- @type table<string, integer>
Shape = {}

--- Represents a text box element.
--- @type integer
Shape.ellipse = nil

--- Represents a button element.
--- @type integer
Shape.rectangle = nil

--- -------------------------------------
--- RECT Class
--- -------------------------------------
--- @class RECT
RECT = {}

--- New RECT
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return RECT
function RECT.new(left, top, right, bottom) end

--- -------------------------------------
--- POINT Class
--- -------------------------------------
--- @class POINT
POINT = {}

--- New POINT
--- @param x integer
--- @param y integer
--- @return POINT
function POINT.new(x, y) end

--- -------------------------------------
--- SIZE Class
--- -------------------------------------
--- @class SIZE
SIZE = {}

--- New SIZE
--- @param cx integer
--- @param cy integer
--- @return SIZE
function SIZE.new(cx, cy) end

--- -------------------------------------
--- Font Class
--- -------------------------------------
--- @class Font
Font = {}

--- New Font
--- @param path string
--- @param bold boolean
--- @param italic boolean
--- @param underline boolean
--- @param size integer
--- @return Font
function Font.new(path, bold, italic, underline, size) end

--- -------------------------------------
--- Callable Class
--- -------------------------------------
--- @class Callable
Callable = {}

--- Call Action
--- @param caller Caller
--- @return nil
function Callable:call_action(caller) end
    
--- Predefined Callable
--- @type Callable
CALLABLE = Callable

--- -------------------------------------
--- Caller Class
--- -------------------------------------
--- @class Caller
Caller = {}

--- Add Action Listener
--- @param targetPtr Callable
--- @return boolean
function Caller:add_action_listener(targetPtr) end

--- Remove Action Listener
--- @param targetPtr Callable
--- @return boolean
function Caller:remove_action_listener(targetPtr) end

--- -------------------------------------
--- Button Class
--- -------------------------------------
--- @class Button
Button = {}

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
--- @return Type
function Button:get_type() end

--- Add Action Listener
--- @param targetPtr Callable
--- @return boolean
function Button:add_action_listener(targetPtr) end

--- Remove Action Listener
--- @param targetPtr Callable
--- @return boolean
function Button:remove_action_listener(targetPtr) end

--- -------------------------------------
--- Timer Class
--- -------------------------------------
--- @class Timer
Timer = {}

--- New Timer
--- @param msec integer
--- @param callable Callable
--- @param loop bool
--- @return Timer
function Timer.new(msec, callable, loop) end

--- Show
--- @return nil
function Timer:start() end

--- Hide
--- @return nil
function Timer:stop() end

--- Set Bounds
--- @param msec integer
--- @return nil
function Timer:set_delay(msec) end

--- Set Enabled
--- @param loop boolean
--- @return nil
function Timer:set_repeat(loop) end

--- Get Text
--- @return boolean
function Timer:is_running() end

--- Get delay
--- @return integer
function Timer:get_delay() end

--- Get type
--- @return Type
function Timer:get_type() end

--- Add Action Listener
--- @param targetPtr Callable
--- @return boolean
function Timer:add_action_listener(targetPtr) end

--- Remove Action Listener
--- @param targetPtr Callable
--- @return boolean
function Timer:remove_action_listener(targetPtr) end

--- -------------------------------------
--- TextBox Class
--- -------------------------------------
--- @class TextBox
TextBox = {}

--- New TextBox
--- @param str string
--- @return TextBox
function TextBox.new(str) end

--- New TextBox
--- @return TextBox
function TextBox.new() end

--- Show
--- @return nil
function TextBox:show() end

--- Hide
--- @return nil
function TextBox:hide() end

--- Set Bounds
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return nil
function TextBox:set_bounds(left, top, right, bottom) end

--- Set Enabled
--- @param enable boolean
--- @return nil
function TextBox:set_enabled(enable) end

--- Set Text
--- @param text string
--- @return nil
function TextBox:set_text(text) end

--- Set Font
--- @param font_name string
--- @param bold boolean
--- @param italic boolean
--- @param underline boolean
--- @param size integer
--- @return nil
function TextBox:set_font(font_name, bold, italic, underline, size) end

--- Get Bounds
--- @return RECT
function TextBox:get_bounds() end

--- Get Text
--- @return string
function TextBox:get_text() end

--- Get Forecolor
--- @return DWORD
function TextBox:get_forecolor() end

--- Get Backcolor
--- @return DWORD
function TextBox:get_backcolor() end

--- Get Backcolor Brush
--- @return HBRUSH
function TextBox:get_backcolor_brush() end

--- Get type
--- @return Type
function TextBox:get_type() end

--- Add Action Listener
--- @param targetPtr Callable
--- @return boolean
function TextBox:add_action_listener(targetPtr) end

--- Remove Action Listener
--- @param targetPtr Callable
--- @return boolean
function TextBox:remove_action_listener(targetPtr) end
    
--- -------------------------------------
--- Bitmap Class
--- -------------------------------------
--- @class Bitmap
Bitmap = {}

--- New Bitmap
--- @param file_name string
--- @return Bitmap
function Bitmap.new(file_name) end

--- Set Transparency Color
--- @param color DWORD
--- @return nil
function Bitmap:set_transparency_color(color) end

--- Set Opacity
--- @param opacity integer
--- @return nil
function Bitmap:set_opacity(opacity) end

--- Exists
--- @return boolean
function Bitmap:exists() end

--- Get Width
--- @return integer
function Bitmap:get_width() end

--- Get Height
--- @return integer
function Bitmap:get_height() end

--- Get Transparency Color
--- @return DWORD
function Bitmap:get_transparency_color() end

--- Get Opacity
--- @return integer
function Bitmap:get_opacity() end

--- Has Alpha Channel
--- @return boolean
function Bitmap:has_alpha_channel() end

--- Save To File
--- @param fileName string
--- @return boolean
function Bitmap:save_to_file(fileName) end

--- Get Handle
--- @return HBITMAP
function Bitmap:get_handle() end

--- -------------------------------------
--- Audio Class
--- -------------------------------------
--- @class Audio
Audio = {}

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
--- @return Type
function Audio:get_type() end

--- Add Action Listener
--- @param targetPtr Callable
--- @return boolean
function Audio:add_action_listener(targetPtr) end

--- Remove Action Listener
--- @param targetPtr Callable
--- @return boolean
function Audio:remove_action_listener(targetPtr) end

--- -------------------------------------
--- HitRegion Class
--- -------------------------------------
--- @class HitRegion
HitRegion = {}

--- New HitRegion
--- @param shape Shape
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return HitRegion
function HitRegion.new(shape, left, top, right, bottom) end

--- New HitRegion
--- @param points POINT
--- @param num_points integer
--- @return HitRegion
function HitRegion.new(points, num_points) end

--- New HitRegion
--- @param bitmap Bitmap
--- @param transparent_color DWORD
--- @param tolerance DWORD
--- @return HitRegion
function HitRegion.new(bitmap, transparent_color, tolerance) end

--- Move
--- @param delta_x integer
--- @param delta_y integer
--- @return nil
function HitRegion:move(delta_x, delta_y) end

--- Hit Test
--- @param x integer
--- @param y integer
--- @return boolean
function HitRegion:hit_test(x, y) end

--- Hit Test
--- @param hit_region HitRegion
--- @return boolean
function HitRegion:hit_test(hit_region) end

--- Collision Test
--- @param hit_region HitRegion
--- @return boolean
function HitRegion:collision_test(hit_region) end

--- Get Bounds
--- @return RECT
function HitRegion:get_bounds() end

--- Exists
--- @return boolean
function HitRegion:exists() end

--- Get Handle
--- @return HRGN
function HitRegion:get_handle() end

--- -------------------------------------
--- Game Engine Class
--- -------------------------------------
--- @class GameEngine
GameEngine = {}

--- GameEngine Setters

--- Sets Window Title
--- @param title string
--- @return nil
function GameEngine:set_title(title) end

--- Set Window position
--- @param left integer
--- @param top integer
--- @return nil
function GameEngine:set_window_position(left, top) end
    
--- Set Window Region
--- @param region HitRegion
--- @return boolean
function GameEngine:set_window_region(region) end
    
--- Set Key Listener
--- @param key_list string
--- @return nil
function GameEngine:set_key_list(key_list) end
        
--- Sets Window Frame Rate
--- @param frameRate integer
--- @return nil
function GameEngine:set_frame_rate(frameRate) end

--- Sets Window Width
--- @param width integer
--- @return nil
function GameEngine:set_width(width) end

--- Sets Window Height
--- @param height integer
--- @return nil
function GameEngine:set_height(height) end

--- GameEngine General Functions

--- Sets Window Full Screen
--- @return boolean
function GameEngine:go_fullscreen() end

--- Sets Window Windowed Mode
--- @return boolean
function GameEngine:go_windowed_mode() end

--- Shows Mouse Pointer
--- @param value boolean
--- @return nil
function GameEngine:show_mouse_pointer(value) end

--- Quit Game
--- @return nil
function GameEngine:quit() end

--- Return if Window is Full Screen
--- @return boolean
function GameEngine:is_fullscreen() end

--- Check What Key is Pressed
--- @param key integer
--- @return boolean
function GameEngine:is_key_down(key) end

--- Show Message Box
--- @param message string
--- @return nil
function GameEngine:message_box(message) end

--- Show Message Continue Box
--- @param message string
--- @return boolean
function GameEngine:message_continue(message) end

--- Text Dimensions
--- @param text string
--- @param font Font
--- @return nill
function GameEngine:calculate_text_dimensions(text, font) end

--- Text Dimensions
--- @param text string
--- @param font Font
--- @param rect RECT
--- @return nill
function GameEngine:calculate_text_dimensions(text, font, rect) end

--- Set Color
--- @param color DWORD
--- @return nil
function GameEngine:set_color(color) end

--- Set font
--- @param font Font
--- @return nil
function GameEngine:set_font(font) end

--- GameEngine Draw Functions

--- Fill Window Rectangle
--- @param color DWORD
--- @return boolean
function GameEngine:fill_window_rect(color) end

--- Draw Line
--- @param x1 integer
--- @param y1 integer
--- @param x2 integer
--- @param y2 integer
--- @return boolean
function GameEngine:draw_line(x1, y1, x2, y2) end

--- Draw Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GameEngine:draw_rect(left, top, right, bottom) end

--- Draw Round Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param radius integer
--- @return boolean
function GameEngine:draw_round_rect(left, top, right, bottom, radius) end

--- Draw Filled Round Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param radius integer
--- @return boolean
function GameEngine:fill_round_rect(left, top, right, bottom, radius) end

--- Draw Filled Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GameEngine:fill_rect(left, top, right, bottom) end

--- Draw Filled Rectangle
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param opacity integer
--- @return boolean
function GameEngine:fill_rect(left, top, right, bottom, opacity) end

--- Draw Oval
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GameEngine:draw_oval(left, top, right, bottom) end

--- Draw Filled Oval
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return boolean
function GameEngine:fill_oval(left, top, right, bottom) end

--- Draw Filled Oval
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param opacity integer
--- @return boolean
function GameEngine:fill_oval(left, top, right, bottom, opacity) end

--- Draw Arc
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param start_degree integer
--- @param angle integer
--- @return boolean
function GameEngine:draw_arc(left, top, right, bottom, start_degree, angle) end

--- Draw Filled Arc
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @param start_degree integer
--- @param angle integer
--- @return boolean
function GameEngine:fill_arc(left, top, right, bottom, start_degree, angle) end

--- Draw String
--- @param text string
--- @param left integer
--- @param top integer
--- @return integer
function GameEngine:draw_string(text, left, top) end

--- Draw String
--- @param text string
--- @param left integer
--- @param top integer
--- @param right integer
--- @param bottom integer
--- @return integer
function GameEngine:draw_string(text, left, top, right, bottom) end

--- Draw Bitmap
--- @param bit_map Bitmap
--- @param left integer
--- @param top integer
--- @return boolean
function GameEngine:draw_bitmap(bit_map, left, top) end

--- Draw Bitmap
--- @param bit_map Bitmap
--- @param left integer
--- @param top integer
--- @param rect RECT
--- @return boolean
function GameEngine:draw_bitmap(bit_map, left, top, rect) end

--- Draw Polygon
--- @param points POINT
--- @param num_points integer
--- @return boolean
function GameEngine:draw_polygon(points, num_points) end

--- Draw Polygon
--- @param points POINT
--- @param num_points integer
--- @param close boolean
--- @return boolean
function GameEngine:draw_polygon(points, num_points, close) end

--- Draw Filled Polygon
--- @param points POINT
--- @param num_points integer
--- @return boolean
function GameEngine:fill_polygon(points, num_points) end

--- Draw Filled Polygon
--- @param points POINT
--- @param num_points integer
--- @param close boolean
--- @return boolean
function GameEngine:fill_polygon(points, num_points, close) end

--- Gets Draw Color
--- @return DWORD
function GameEngine:get_draw_color() end

--- Repaint
--- @return boolean
function GameEngine:repaint() end

--- Accessor Member Functions

--- Get Screen Width
--- @return integer
function GameEngine:get_title() end

--- Get Screen Height
--- @return integer
function GameEngine:get_width() end

--- Get Screen Height
--- @return integer
function GameEngine:get_height() end

--- Get Frame Rate
--- @return integer
function GameEngine:get_frame_rate() end

--- Get Frame Delay
--- @return integer
function GameEngine:get_frame_delay() end
    
--- Get Window Position
--- @return POINT
function GameEngine:get_window_position() end

--- Has Window Region
--- @return boolean
function GameEngine:has_window_region() end

--- Predefined Game Engine
--- @type GameEngine
GAME_ENGINE = GameEngine

--- -------------------------------------
--- Game Class
--- -------------------------------------
--- @class Game
Game = {}

--- Initialize
--- @return nil
function Game:initialize() end

--- Start
--- @return nil
function Game:start() end
    
--- End
--- @return nil
function Game:end() end

--- Paints
--- @return nil
function Game:paint() end

--- Tick
--- @return nil
function Game:tick() end

--- Mouse Button Action
--- @param isLeft boolean
--- @param isDown boolean
--- @param x integer
--- @param y integer
--- @return nil
function Game:mouse_button_action(isLeft, isDown, x, y) end

--- Mouse Wheel Action
--- @param x integer
--- @param y integer
--- @param distance integer
--- @return nil
function Game:mouse_wheel_action(x, y, distance) end

--- Mouse Move
--- @param x integer
--- @param y integer
--- @return nil
function Game:mouse_move(x, y) end

--- Check Keyboard
--- @return nil
function Game:check_keyboard() end

--- Key Pressed
--- @param key string
--- @return nil
function Game:key_pressed(key) end

--- Call Action
--- @param caller Caller
--- @return nil
function Game:call_action(caller) end