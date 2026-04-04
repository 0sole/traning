-- DRAGO ENO LOADER
local baseUrl = "https://raw.githubusercontent.com/0sole/traning/main/"

local function fast_require(file)
    local content = game:HttpGet(baseUrl .. file .. ".lua")
    return loadstring(content)()
end

-- Tüm modülleri belleğe al
local DragoLib = {}
DragoLib.Theme = fast_require("theme")
DragoLib.Elements = fast_require("elements")
DragoLib.Menu = fast_require("menu")

-- Kullanıcıya ana objeyi döndür
return DragoLib.Menu
