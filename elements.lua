local theme = require("theme")
local Elements = {}

function Elements.drawButton(x, y, text)
    -- Kart (Arka plan)
    love.graphics.setColor(0.1, 0.1, 0.1, 0.5)
    love.graphics.rectangle("fill", x, y, 400, 45)
    
    -- Buton
    love.graphics.setColor(theme.accent_main)
    love.graphics.rectangle("fill", x + 280, y + 10, 100, 25)
    
    love.graphics.setColor(theme.text_main)
    love.graphics.print(text, x + 10, y + 15)
end

return Elements
