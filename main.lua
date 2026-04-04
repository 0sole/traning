local menu = require("menu")
local elements = require("elements")

function love.load()
    -- HTML'deki Tab 1, Tab 2 gibi oluşturuyoruz
    menu.createMenu(1, "MAIN SETTINGS")
    menu.createMenu(2, "VISUALS")
    menu.createMenu(3, "MISC")
end

function love.draw()
    menu.draw()
    
    -- Eğer 1. tab aktifse onun elemanlarını çiz
    if menu.activeTab == 1 then
        elements.drawButton(280, 150, "Aimbot Toggle")
        elements.drawButton(280, 205, "Trigger Bot")
    end
end

function love.keypressed(key)
    -- Tablar arası geçiş testi
    if key == "down" then
        menu.activeTab = math.min(menu.activeTab + 1, 3)
    elseif key == "up" then
        menu.activeTab = math.max(menu.activeTab - 1, 1)
    end
end
