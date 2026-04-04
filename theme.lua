local theme = {
    -- Ana Renkler
    bg_deep       = Color3.fromRGB(3, 3, 3),        -- #030303 - tam siyah zemin
    bg_sidebar    = Color3.fromRGB(8, 0, 0),         -- #080000 - sidebar arka plan
    bg_element    = Color3.fromRGB(14, 14, 14),      -- #0e0e0e - element arka plan
    bg_element_h  = Color3.fromRGB(22, 5, 5),        -- hover versiyonu
    bg_topbar     = Color3.fromRGB(6, 0, 0),         -- üst bar

    accent_main   = Color3.fromRGB(160, 0, 0),       -- #a00000 - ana kırmızı
    accent_glow   = Color3.fromRGB(255, 30, 30),     -- #ff1e1e - parlayan kırmızı
    accent_dim    = Color3.fromRGB(80, 0, 0),        -- #500000 - soluk kırmızı

    text_main     = Color3.fromRGB(245, 245, 245),
    text_dark     = Color3.fromRGB(120, 120, 120),
    text_accent   = Color3.fromRGB(255, 80, 80),

    border_color  = Color3.fromRGB(35, 5, 5),        -- #230505
    border_glow   = Color3.fromRGB(100, 0, 0),       -- hover border

    -- Ayarlar
    window_size      = UDim2.new(0, 640, 0, 400),
    sidebar_width    = 175,
    transition_speed = 0.25,
    glow_speed       = 0.4,
}

return theme