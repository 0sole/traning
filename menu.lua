local theme = require("theme")
local Menu = {}
Menu.list = {}
Menu.activeTab = 1

function Menu.createMenu(id, name)
    Menu.list[id] = {
        id = id,
        name = name,
        elements = {} -- Bu menüye ait butonlar, checkboxlar vs.
    }
end

function Menu.draw()
    -- 1. Ana Pencere Arka Planı
    love.graphics.setColor(theme.bg_deep)
    love.graphics.rectangle("fill", 100, 100, theme.window_w, theme.window_h)
    
    -- 2. Sidebar Arka Planı
    love.graphics.setColor(theme.bg_sidebar)
    love.graphics.rectangle("fill", 100, 100, theme.sidebar_w, theme.window_h)
    
    -- 3. Üst Kırmızı Çizgi (Ejderha Gözü Efekti)
    love.graphics.setColor(theme.accent_glow)
    love.graphics.rectangle("fill", 100, 100, theme.window_w, 2)

    -- 4. Logo / Başlık
    love.graphics.print("DRAGO ENO", 125, 120)

    -- 5. Tabları (Menüleri) Listele
    for i, m in pairs(Menu.list) do
        if Menu.activeTab == i then
            love.graphics.setColor(theme.accent_glow)
            love.graphics.rectangle("fill", 100, 150 + (i*30), 3, 20) -- Aktif çizgi
        end
        love.graphics.setColor(Menu.activeTab == i and theme.text_main or theme.text_dark)
        love.graphics.print(m.name, 120, 150 + (i*30))
    end
end

return Menu
