local baseUrl = "https://raw.githubusercontent.com/0sole/traning/main/"

_G.DragoTheme = loadstring(game:HttpGet(baseUrl .. "theme.lua"))()
_G.DragoElements = loadstring(game:HttpGet(baseUrl .. "elements.lua"))()
local menu = loadstring(game:HttpGet(baseUrl .. "menu.lua"))()

return menu
