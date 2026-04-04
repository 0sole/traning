-- DRAGO ENO UI Library
-- Kullanım: local Drago = loadstring(game:HttpGet("RAW_URL/init.lua"))()

local base = "https://raw.githubusercontent.com/0sole/traning/main/"

_G.DragoTheme    = loadstring(game:HttpGet(base .. "theme.lua"))()
_G.DragoElements = loadstring(game:HttpGet(base .. "elements.lua"))()

return loadstring(game:HttpGet(base .. "menu.lua"))()