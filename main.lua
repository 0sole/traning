local Drago = require(script.Parent.menu)
_G.DragoTheme = require(script.Parent.theme)
_G.DragoElements = require(script.Parent.elements)

local Window = Drago:CreateWindow("DRAGO ENO")

local MainTab = Window:CreateTab("Main Settings")
local VisualsTab = Window:CreateTab("Visuals")

MainTab:CreateButton("Aimbot Toggle", function()
    print("Aimbot Aktif Edildi!")
end)

MainTab:CreateKeybind("Menu Bind", Enum.KeyCode.RightShift, function(key)
    print("Yeni tuş: " .. key.Name)
end)