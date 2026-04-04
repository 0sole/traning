-- DRAGO ENO UI Library - Kullanım Örneği
_G.DragoTheme    = require(script.Parent.theme)
_G.DragoElements = require(script.Parent.elements)
local Drago      = require(script.Parent.menu)

-- Pencereyi oluştur
-- HideKey: GUI'yi gizle/göster tuşu (default: RightControl)
-- DestroyKey: GUI'yi tamamen yok et (opsiyonel)
local Window = Drago:CreateWindow("DRAGO ENO", {
    HideKey    = Enum.KeyCode.RightControl,
    DestroyKey = Enum.KeyCode.Delete,  -- Delete tuşuyla tam yok etme
})

-- ── MAIN SETTINGS TAB ──────────────────────────
local MainTab = Window:CreateTab("Main Settings")

MainTab:CreateLabel("Combat")

MainTab:CreateButton("Aimbot Toggle", function()
    print("Aimbot Aktif!")
end)

MainTab:CreateToggle("Silent Aim", false, function(state)
    print("Silent Aim:", state)
end)

MainTab:CreateLabel("Smoothness")

MainTab:CreateSlider("Aim Smoothness", 1, 100, 50, function(val)
    print("Smoothness:", val)
end)

MainTab:CreateKeybind("Menu Bind", Enum.KeyCode.RightControl, function(key)
    print("Yeni tuş:", key.Name)
end)

-- ── VISUALS TAB ────────────────────────────────
local VisualsTab = Window:CreateTab("Visuals")

VisualsTab:CreateLabel("ESP Settings")

VisualsTab:CreateToggle("ESP Aktif", false, function(state)
    print("ESP:", state)
end)

VisualsTab:CreateToggle("Box ESP", true, function(state)
    print("Box ESP:", state)
end)

VisualsTab:CreateSlider("ESP Uzaklık", 50, 2000, 500, function(val)
    print("ESP Distance:", val)
end)

-- ── MISC TAB ───────────────────────────────────
local MiscTab = Window:CreateTab("Misc")

MiscTab:CreateLabel("Utility")

MiscTab:CreateButton("Destroy GUI", function()
    Window:Destroy()
end)

MiscTab:CreateButton("Hide GUI", function()
    Window:Hide()
end)

-- Window metodları:
-- Window:Hide()     → GUI'yi gizler (tuşla geri açılabilir)
-- Window:Show()     → GUI'yi gösterir
-- Window:Destroy()  → GUI'yi tamamen yok eder, tüm bağlantılar kesilir