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

	// Get path to lua script dragged onto the .exe
	std::string path = GetCommandLineA();
	path = path.substr(path.find_last_of('\"') + 2);

	// Check if path is a valid .lua file
	if (path.find(".lua") == std::string::npos)
	{
		std::cerr << "Invalid Lua script file" << std::endl;
		std::cerr << "Using default script file" << std::endl;
		path = "brickbreak.lua"; 
	}
	else
	{
		std::cout << "\nUsing Lua script file: " << path << std::endl;
	}

	// Load the Lua script
	m_Lua.script_file(path);

	// Bind GameEngine class
	m_Lua.new_usertype<GameEngine>("GameEngine",
		"SetTitle", &GameEngine::SetTitle,
		"SetWidth", &GameEngine::SetWidth,
		"SetHeight", &GameEngine::SetHeight,
		"SetFrameRate", &GameEngine::SetFrameRate,
		"IsKeyDown", &GameEngine::IsKeyDown,
		"SetColor", &GameEngine::SetColor,
		"GetWidth", &GameEngine::GetWidth,
		"GetHeight", &GameEngine::GetHeight,
		// Draw
		"FillRect", sol::overload(
			static_cast<bool(GameEngine::*)(int, int, int, int) const>(&GameEngine::FillRect),
			static_cast<bool(GameEngine::*)(int, int, int, int, int) const>(&GameEngine::FillRect)
		),
		"FillOval", sol::overload(
			static_cast<bool(GameEngine::*)(int, int, int, int) const>(&GameEngine::FillOval),
			static_cast<bool(GameEngine::*)(int, int, int, int, int) const>(&GameEngine::FillOval)
		),
		"DrawString", sol::overload(
			static_cast<int(GameEngine::*)(const tstring&, int, int) const>(&GameEngine::DrawString),
			static_cast<int(GameEngine::*)(const tstring&, int, int, int, int) const>(&GameEngine::DrawString)
		),
		"FillWindowRect", & GameEngine::FillWindowRect
	);

	m_Lua.new_usertype<Callable>("Callable",
		"CallAction", &Callable::CallAction
	);

	m_Lua.new_usertype<Caller>("Caller",
		// Methods
		"AddActionListener", &Caller::AddActionListener,
		"RemoveActionListener", &Caller::RemoveActionListener
	);

	m_Lua.new_usertype<Button>(
		"Button",
		sol::constructors<Button(const tstring&)>(),
		sol::base_classes, sol::bases<Caller>(),
		// Functions
		"Show", &Button::Show,
		"Hide", &Button::Hide,
		"AddActionListener", &Button::AddActionListener,
		// Setters
		"SetBounds", &Button::SetBounds, 
		"SetEnabled", &Button::SetEnabled,
		"SetText", [this](Button& btn, const tstring& text)
		{
			btn.SetText(text);
		},
		"SetFont", [this](Button& btn, const tstring& fontName, bool bold, bool italic, bool underline, int size)
		{
			btn.SetFont(fontName, bold, italic, underline, size);
		},
		// Read only functions
		"GetBounds", sol::readonly_property(&Button::GetBounds),
		"GetText", sol::readonly_property([this](Button& btn) -> std::string
			{
				tstring string = btn.GetText();
				return std::string(string.begin(), string.end());
			}),
		"GetType", sol::readonly_property(&Button::GetType)
	);

	m_Lua["GAME_ENGINE"] = GAME_ENGINE;

	m_Lua.new_usertype<Game>("Game",
		"Initialize", &Game::Initialize,
		"Start", &Game::Start,
		"End", &Game::End,
		"Paint", &Game::Paint,
		"Tick", &Game::Tick,
		"MouseButtonAction", &Game::MouseButtonAction,
		"MouseWheelAction", &Game::MouseWheelAction,
		"MouseMove", &Game::MouseMove,
		"CheckKeyboard", &Game::CheckKeyboard,
		"KeyPressed", &Game::KeyPressed,
		"CallAction", &Game::CallAction
	);

	m_Lua["GAME"] = this;

	m_Lua["CALLER"] = dynamic_cast<Callable*>(this);

	m_Lua["Initialize"]();

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
	m_Lua["Start"]();
}

void Game::End()
{
	// Insert code that needs to execute when the game ends
	m_Lua["End"]();
}

void Game::Paint(RECT rect) const
{
	// Insert paint code 
	m_Lua["Paint"]();
}

void Game::Tick()
{
	// Insert non-paint code that needs to execute each tick 
	m_Lua["Tick"]();
}

void Game::MouseButtonAction(bool isLeft, bool isDown, int x, int y, WPARAM wParam)
{	
	// Insert code for a mouse button action

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
}

void Game::MouseMove(int x, int y, WPARAM wParam)
{	
	// Insert code that needs to execute when the mouse pointer moves across the game window

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
	m_Lua["CallAction"](callerPtr);
}
