-- ╔══════════════════════════════════════════╗
-- ║        DRAGO ENO  -  Kullanım Örneği    ║
-- ╚══════════════════════════════════════════╝

local Drago = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/0sole/traning/main/init.lua"
))()

-- Pencere oluştur
local Window = Drago:CreateWindow({
    Name          = "DRAGO ENO",          -- Başlık
    HideKey       = Enum.KeyCode.RightControl, -- Gizle/Göster tuşu
    DestroyKey    = Enum.KeyCode.Delete,       -- Tamamen yok et (opsiyonel)
    LoadingScreen = true,                      -- Yükleme ekranı (default: true)
})

-- ── Tab 1 ───────────────────────────────────
local Main = Window:CreateTab("Main")

Main:CreateLabel("Combat")

Main:CreateButton("Aimbot Toggle", function()
    print("Aimbot!")
end)

Main:CreateToggle("Silent Aim", false, function(state)
    print("Silent Aim:", state)
end)

Main:CreateSlider("Smoothness", 1, 100, 50, function(val)
    print("Smoothness:", val)
end)

Main:CreateSeparator()

Main:CreateLabel("Keybinds")

Main:CreateKeybind("Menu Tuşu", Enum.KeyCode.RightControl, function(key)
    print("Yeni tuş:", key.Name)
end)

-- ── Tab 2 ───────────────────────────────────
local Visuals = Window:CreateTab("Visuals")

Visuals:CreateLabel("ESP")

Visuals:CreateToggle("ESP", false, function(state)
    print("ESP:", state)
end)

Visuals:CreateDropdown("ESP Renk", {"Kırmızı", "Beyaz", "Mavi"}, function(val)
    print("Renk:", val)
end)

Visuals:CreateSlider("ESP Mesafe", 50, 2000, 500, function(val)
    print("Mesafe:", val)
end)

-- ── Tab 3 ───────────────────────────────────
local Misc = Window:CreateTab("Misc")

Misc:CreateButton("Gizle", function()
    Window:Hide()
end)

Misc:CreateButton("Yok Et", function()
    Window:Destroy()
end)