//-----------------------------------------------------------------
// Main Game File
// C++ Source - Game.cpp - version v8_01
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// Include Files
//-----------------------------------------------------------------
#include "Game.h"

//-----------------------------------------------------------------
// Game Member Functions																				
//-----------------------------------------------------------------

Game::Game()
{
	// nothing to create
}

Game::~Game()
{
	// nothing to destroy
}

void Game::Initialize()
{
	// Code that needs to execute (once) at the start of the game, before the game window is created
	AbstractGame::Initialize();

	// Loads all libraries at once
	m_Lua.open_libraries(sol::lib::base);
	m_Lua.open_libraries(sol::lib::math);
	m_Lua.open_libraries(sol::lib::table);
	m_Lua.open_libraries(sol::lib::string);

	// Get path to lua script dragged onto the .exe
	std::string luaPath = GetCommandLineA();
	size_t lastQuote{ luaPath.find_last_of('\"') };
	size_t firstQuote{ luaPath.find_first_of('\"') };

	std::string resourcePath{ "resources\\" };

	if (firstQuote != std::string::npos || lastQuote != std::string::npos)
	{
		resourcePath = luaPath.substr(firstQuote + 1, lastQuote - (firstQuote + 1));

		// File path looks like this ..\..\..\project\SE_Arcade.exe
		// I need to get to the project folder
		size_t lastSlash{ resourcePath.find_last_of('\\') };
		resourcePath = resourcePath.substr(0, lastSlash + 1);
		resourcePath += "resources\\";
	}

	luaPath = luaPath.substr(lastQuote + 2);

	// If path containst spaces, complain
	if (luaPath.find(' ') != std::string::npos)
	{
		luaPath = "brickbreak.lua";
#ifdef _DEBUG
		std::cout << "Path to Lua script file contains spaces" << std::endl;
		std::cout << "Using default script fileL " << luaPath << std::endl;
#endif
	}

	// Check if path is a valid .lua file
	if (luaPath.find(".lua") == std::string::npos)
	{
		luaPath = "brickbreak.lua";
#ifdef _DEBUG
		std::cout << "Invalid Lua script file" << std::endl;
		std::cout << "Using default script file: " << luaPath << std::endl;
#endif
	}
	else
	{
#ifdef _DEBUG
		std::cout << "Using Lua script file: " << luaPath << std::endl;
#endif
	}

	// Load the Lua script
	m_Lua.script_file(luaPath);

	// Bind types
	m_Lua.new_usertype<RECT>("RECT",
		sol::constructors<RECT(LONG, LONG, LONG, LONG)>(),
		"left", &RECT::left,
		"top", &RECT::top,
		"right", &RECT::right,
		"bottom", &RECT::bottom
	);

	m_Lua.new_usertype<POINT>("POINT",
		sol::constructors<POINT(LONG, LONG)>(),
		"x", &POINT::x,
		"y", &POINT::y
	);

	m_Lua.new_usertype<SIZE>("SIZE",
		sol::constructors<SIZE(LONG, LONG)>(),
		"cx", &SIZE::cx,
		"cy", &SIZE::cy
	);

	m_Lua.new_usertype<Font>("Font",
		sol::constructors<Font(const tstring&, bool, bool, bool, int)>(),
		"get_handle", &Font::GetHandle
	);

	// Bind GameEngine class
	m_Lua.new_usertype<GameEngine>("GameEngine",
		"set_title", &GameEngine::SetTitle,
		"set_window_position", &GameEngine::SetWindowPosition,
		"set_window_region", &GameEngine::SetWindowRegion,
		"set_key_list", &GameEngine::SetKeyList,
		"set_frame_rate", &GameEngine::SetFrameRate,
		"set_width", &GameEngine::SetWidth,
		"set_height", &GameEngine::SetHeight,
		"go_fullscreen", &GameEngine::GoFullscreen,
		"go_windowed_mode", &GameEngine::GoWindowedMode,
		"show_mouse_pointer", &GameEngine::ShowMousePointer,
		"quit", &GameEngine::Quit,
		"is_fullscreen", &GameEngine::IsFullscreen,
		"is_key_down", &GameEngine::IsKeyDown,
		"message_box", sol::overload(
			static_cast<void(GameEngine::*)(const tstring&) const>(&GameEngine::MessageBox),
			static_cast<void(GameEngine::*)(const TCHAR*) const>(&GameEngine::MessageBox)
		),
		"message_continue", &GameEngine::MessageContinue,
		"calculate_text_dimensions", sol::overload(
			static_cast<SIZE(GameEngine::*)(const tstring&, const Font*) const>(&GameEngine::CalculateTextDimensions),
			static_cast<SIZE(GameEngine::*)(const tstring&, const Font*, RECT rect) const>(&GameEngine::CalculateTextDimensions)
		),
		"set_color", &GameEngine::SetColor,
		"set_font", &GameEngine::SetFont,
		// Draw
		"fill_window_rect", &GameEngine::FillWindowRect,
		"draw_line", &GameEngine::DrawLine,
		"draw_rect", &GameEngine::DrawRect,
		"draw_round_rect", &GameEngine::DrawRoundRect,
		"fill_round_rect", &GameEngine::FillRoundRect,
		"fill_rect", sol::overload(
			static_cast<bool(GameEngine::*)(int, int, int, int) const>(&GameEngine::FillRect),
			static_cast<bool(GameEngine::*)(int, int, int, int, int) const>(&GameEngine::FillRect)
		),
		"draw_oval", &GameEngine::DrawOval,
		"fill_oval", sol::overload(
			static_cast<bool(GameEngine::*)(int, int, int, int) const>(&GameEngine::FillOval),
			static_cast<bool(GameEngine::*)(int, int, int, int, int) const>(&GameEngine::FillOval)
		),
		"draw_arc", &GameEngine::DrawArc,
		"fill_arc", &GameEngine::FillArc,
		"draw_string", sol::overload(
			static_cast<int(GameEngine::*)(const tstring&, int, int) const>(&GameEngine::DrawString),
			static_cast<int(GameEngine::*)(const tstring&, int, int, int, int) const>(&GameEngine::DrawString)
		),
		"draw_bitmap", sol::overload(
			static_cast<bool(GameEngine::*)(const Bitmap*, int, int) const>(&GameEngine::DrawBitmap),
			static_cast<bool(GameEngine::*)(const Bitmap*, int, int, RECT) const>(&GameEngine::DrawBitmap)
		),
		"draw_polygon", sol::overload(
			static_cast<bool(GameEngine::*)(const POINT[], int) const>(&GameEngine::DrawPolygon),
			static_cast<bool(GameEngine::*)(const POINT[], int, bool) const>(&GameEngine::DrawPolygon)
		),
		"fill_polygon", sol::overload(
			static_cast<bool(GameEngine::*)(const POINT[], int) const>(&GameEngine::FillPolygon),
			static_cast<bool(GameEngine::*)(const POINT[], int, bool) const>(&GameEngine::FillPolygon)
		),
		"get_draw_color", &GameEngine::GetDrawColor,
		"repaint", &GameEngine::Repaint,
		// Getters
		"get_title", &GameEngine::GetTitle,
		"get_width", &GameEngine::GetWidth,
		"get_height", &GameEngine::GetHeight,
		"get_frame_rate", &GameEngine::GetFrameRate,
		"get_frame_delay", &GameEngine::GetFrameDelay,
		"get_window_position", &GameEngine::GetWindowPosition,
		"has_window_region", &GameEngine::HasWindowRegion
	);

	m_Lua.new_usertype<Callable>("Callable",
		"call_action", &Callable::CallAction
	);

	m_Lua.create_named_table("Type",
		"text_box", Caller::Type::TextBox,
		"button", Caller::Type::Button,
		"timer", Caller::Type::Timer,
		"audio", Caller::Type::Audio,
		"video", Caller::Type::Video
	);

	m_Lua.new_usertype<Caller>("Caller",
		// Methods
		"add_action_listener", &Caller::AddActionListener,
		"remove_action_listener", &Caller::RemoveActionListener
	);

	m_Lua.new_usertype<Timer>("Timer",
		sol::constructors<Timer(int, Callable*, bool)>(),
		sol::base_classes, sol::bases<Caller>(),
		"start", &Timer::Start,
		"stop", &Timer::Stop,
		"set_delay", &Timer::SetDelay,
		"set_repeat", &Timer::SetRepeat,
		"is_running", &Timer::IsRunning,
		"get_delay", &Timer::GetDelay,
		"get_type", &Timer::GetType
	);

	m_Lua.new_usertype<TextBox>("TextBox",
		sol::constructors<TextBox(const tstring&), TextBox()>(),
		sol::base_classes, sol::bases<Caller>(),
		// Setters
		"set_bounds", &TextBox::SetBounds,
		"set_text", &TextBox::SetText,
		"set_font", &TextBox::SetFont,
		"set_backcolor", &TextBox::SetBackcolor,
		"set_forecolor", &TextBox::SetForecolor,
		"set_enabled", &TextBox::SetEnabled,
		// Functions
		"show", &TextBox::Show,
		"hide", &TextBox::Hide,
		// Read only functions
		"get_bounds", &TextBox::GetBounds,
		"get_text", &TextBox::GetText,
		"get_forecolor", &TextBox::GetForecolor,
		"get_backcolor", &TextBox::GetBackcolor,
		"get_backcolor_brush", &TextBox::GetBackcolorBrush,
		"get_type", &TextBox::GetType
	);

	m_Lua.new_usertype<Button>("Button",
		sol::constructors<Button(const tstring&), Button()>(),
		sol::base_classes, sol::bases<Caller>(),
		// Functions
		"show", &Button::Show,
		"hide", &Button::Hide,
		// Setters
		"set_bounds", &Button::SetBounds,
		"set_enabled", &Button::SetEnabled,
		"set_text", &Button::SetText,
		"set_font", &Button::SetFont,
		// Read only functions
		"get_bounds", &Button::GetBounds,
		"get_text", &Button::GetText,
		"get_type", &Button::GetType,
		// Other functions
		"add_action_listener", &Button::AddActionListener,
		"remove_action_listener", &Button::RemoveActionListener
	);

	m_Lua.new_usertype<Audio>("Audio",
		sol::constructors<Audio(const tstring&)>(),
		sol::base_classes, sol::bases<Caller>(),
		// Functions
		"tick", &Audio::Tick,
		"play", &Audio::Play,
		"pause", &Audio::Pause,
		"stop", &Audio::Stop,
		// Setters
		"set_volume", &Audio::SetVolume,
		"set_repeat", &Audio::SetRepeat,
		// Getters
		"get_name", &Audio::GetName,
		"get_alias", &Audio::GetAlias,
		"get_duration", &Audio::GetDuration,
		"is_playing", &Audio::IsPlaying,
		"is_paused", &Audio::IsPaused,
		"get_repeat", &Audio::GetRepeat,
		"exists", &Audio::Exists,
		"get_volume", &Audio::GetVolume,
		"get_type", &Audio::GetType,
		"add_action_listener", &Audio::AddActionListener,
		"remove_action_listener", &Audio::RemoveActionListener
	);

	m_Lua.new_usertype<Game>("Game",
		"initialize", &Game::Initialize,
		"start", &Game::Start,
		"end_game", &Game::End,
		"paint", &Game::Paint,
		"tick", &Game::Tick,
		"mouse_button_action", &Game::MouseButtonAction,
		"mouse_wheel_action", &Game::MouseWheelAction,
		"mouse_move", &Game::MouseMove,
		"check_keyboard", &Game::CheckKeyboard,
		"key_pressed", &Game::KeyPressed,
		"call_action", &Game::CallAction
	);

	m_Lua.new_usertype<Bitmap>("Bitmap",
		sol::constructors<Bitmap(const tstring&)>(),
		"set_transparency_color", &Bitmap::SetTransparencyColor,
		"set_opacity", &Bitmap::SetOpacity,
		"exists", &Bitmap::Exists,
		"get_width", &Bitmap::GetWidth,
		"get_height", &Bitmap::GetHeight,
		"get_transparency_color", &Bitmap::GetTransparencyColor,
		"get_opacity", &Bitmap::GetOpacity,
		"has_alpha_channel", &Bitmap::HasAlphaChannel,
		"save_to_file", &Bitmap::SaveToFile,
		"get_handle", &Bitmap::GetHandle
	);

	m_Lua.create_named_table("Shape",
		"ellipse", HitRegion::Shape::Ellipse,
		"rectangle", HitRegion::Shape::Rectangle
	);

	m_Lua.new_usertype<HitRegion>("HitRegion",
		sol::constructors<HitRegion(HitRegion::Shape, int, int, int, int), HitRegion(const POINT*, int), HitRegion(const Bitmap*, COLORREF, COLORREF)>(),
		"move", &HitRegion::Move,
		"hit_test", sol::overload(
			static_cast<bool(HitRegion::*)(int, int) const>(&HitRegion::HitTest),
			static_cast<bool(HitRegion::*)(const HitRegion*) const>(&HitRegion::HitTest)
		),
		"collision_test", &HitRegion::CollisionTest,
		"get_bounds", &HitRegion::GetBounds,
		"exists", &HitRegion::Exists,
		"get_handle", &HitRegion::GetHandle
	);

	m_Lua["RESOURCEPATH"] = resourcePath;

	m_Lua["GAME_ENGINE"] = GAME_ENGINE;

	m_Lua["CALLABLE"] = dynamic_cast<Callable*>(this);

	m_Lua["initialize"]();

	// Set the keys that the game needs to listen to
	//tstringstream buffer;
	//buffer << _T("KLMO");
	//buffer << (char) VK_LEFT;
	//buffer << (char) VK_RIGHT;
	//GAME_ENGINE->SetKeyList(buffer.str());
}

void Game::Start()
{
	// Insert code that needs to execute (once) at the start of the game, after the game window is created
	m_Lua["start"]();
}

void Game::End()
{
	// Insert code that needs to execute when the game ends
	m_Lua["end_game"]();
}

void Game::Paint(RECT rect) const
{
	// Insert paint code 
	m_Lua["paint"]();
}

void Game::Tick()
{
	// Insert non-paint code that needs to execute each tick 
	m_Lua["tick"]();
}

void Game::MouseButtonAction(bool isLeft, bool isDown, int x, int y, WPARAM wParam)
{	
	// Insert code for a mouse button action
	m_Lua["mouse_button_action"](isLeft, isDown, x, y);

	/* Example:
	if (isLeft == true && isDown == true) // is it a left mouse click?
	{
		if ( x > 261 && x < 261 + 117 ) // check if click lies within x coordinates of choice
		{
			if ( y > 182 && y < 182 + 33 ) // check if click also lies within y coordinates of choice
			{
				GAME_ENGINE->MessageBox(_T("Clicked."));
			}
		}
	}
	*/
}

void Game::MouseWheelAction(int x, int y, int distance, WPARAM wParam)
{	
	// Insert code for a mouse wheel action
	m_Lua["mouse_wheel_action"](x, y, distance);
}

void Game::MouseMove(int x, int y, WPARAM wParam)
{	
	// Insert code that needs to execute when the mouse pointer moves across the game window
	m_Lua["mouse_move"](x, y);

	/* Example:
	if ( x > 261 && x < 261 + 117 ) // check if mouse position is within x coordinates of choice
	{
		if ( y > 182 && y < 182 + 33 ) // check if mouse position also is within y coordinates of choice
		{
			GAME_ENGINE->MessageBox("Mouse move.");
		}
	}
	*/
}

void Game::CheckKeyboard()
{	
	// Here you can check if a key is pressed down
	// Is executed once per frame 
	m_Lua["check_keyboard"]();

	/* Example:
	if (GAME_ENGINE->IsKeyDown(_T('K'))) xIcon -= xSpeed;
	if (GAME_ENGINE->IsKeyDown(_T('L'))) yIcon += xSpeed;
	if (GAME_ENGINE->IsKeyDown(_T('M'))) xIcon += xSpeed;
	if (GAME_ENGINE->IsKeyDown(_T('O'))) yIcon -= ySpeed;
	*/
}

void Game::KeyPressed(TCHAR key)
{	
	// DO NOT FORGET to use SetKeyList() !!
	m_Lua["key_pressed"](key);

	// Insert code that needs to execute when a key is pressed
	// The function is executed when the key is *released*
	// You need to specify the list of keys with the SetKeyList() function

	/* Example:
	switch (key)
	{
	case _T('K'): case VK_LEFT:
		GAME_ENGINE->MessageBox("Moving left.");
		break;
	case _T('L'): case VK_DOWN:
		GAME_ENGINE->MessageBox("Moving down.");
		break;
	case _T('M'): case VK_RIGHT:
		GAME_ENGINE->MessageBox("Moving right.");
		break;
	case _T('O'): case VK_UP:
		GAME_ENGINE->MessageBox("Moving up.");
		break;
	case VK_ESCAPE:
		GAME_ENGINE->MessageBox("Escape menu.");
	}
	*/
}

void Game::CallAction(Caller* callerPtr)
{
	// Insert the code that needs to execute when a Caller (= Button, TextBox, Timer, Audio) executes an action
	m_Lua["call_action"](callerPtr);
}
