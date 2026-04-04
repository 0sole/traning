local theme = {
    -- Renkler (HTML'deki Hex kodlarının karşılığı)
    bg_deep = Color3.fromRGB(5, 5, 5),        -- #050505
    bg_sidebar = Color3.fromRGB(10, 0, 0),     -- #0a0000
    bg_element = Color3.fromRGB(17, 17, 17),   -- #111111
    accent_main = Color3.fromRGB(136, 0, 0),   -- #880000
    accent_glow = Color3.fromRGB(255, 0, 0),   -- #ff0000
    text_main = Color3.fromRGB(255, 255, 255),
    text_dark = Color3.fromRGB(136, 136, 136),
    border_color = Color3.fromRGB(42, 0, 0),   -- #2a0000
    
    -- Ayarlar
    window_size = UDim2.new(0, 620, 0, 390),
    transition_speed = 0.3 -- HTML'deki 0.3s cubic-bezier
}
return theme
