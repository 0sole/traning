local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- [ VERİ YÖNETİMİ ]
local HttpService = game:GetService("HttpService")
local FileName = "0sole_Config.json"
local AddedItems = {}
local ToggleObjects = {} -- UI objelerini saklamak için

local function SaveData()
    writefile(FileName, HttpService:JSONEncode(AddedItems))
end

local function LoadData()
    if isfile(FileName) then
        local s, data = pcall(function() return HttpService:JSONDecode(readfile(FileName)) end)
        if s then return data end
    end
    return {}
end

-- [ PENCERE ]
local Window = Fluent:CreateWindow({
    Title = "Proje v2",
    SubTitle = "by 0sole",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Items = Window:AddTab({ Title = "Eşya Ekle", Icon = "plus-circle" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
}

local ListSection = Tabs.Items:AddSection("Eklenen Eşyalar")
local ItemNameInput = ""

-- [ GLOW VE TOGGLE FONKSİYONU ]
local function CreateItemUI(name)
    -- Fluent'te Glow etkisi: Toggle Mavi olduğunda "parlar"
    local Tgl = ListSection:AddToggle("item_" .. name, {
        Title = "🔵 " .. name,
        Description = "Otomatik aranıyor...",
        Default = false,
        Callback = function(Value) end -- Manuel müdahaleye gerek yok, loop halledecek
    })
    ToggleObjects[name] = Tgl
end

Tabs.Items:AddInput("ItemInput", {
    Title = "Eşya İsmi",
    Default = "",
    Placeholder = "Örn: Goggles",
    Callback = function(Value) ItemNameInput = Value end
})

Tabs.Items:AddButton({
    Title = "Ekle (Add)",
    Description = "Mavi parlamalı listeye ekler.",
    Callback = function()
        if ItemNameInput == "" or table.find(AddedItems, ItemNameInput) then return end
        table.insert(AddedItems, ItemNameInput)
        SaveData()
        CreateItemUI(ItemNameInput)
        Fluent:Notify({Title = "Sistem", Content = ItemNameInput .. " eklendi.", Duration = 2})
    end
})

-- [ 0.5 SN OTOMATİK KONTROL ]
task.spawn(function()
    while task.wait(0.5) do
        local player = game.Players.LocalPlayer
        local char = player.Character
        local backpack = player.Backpack

        for _, name in ipairs(AddedItems) do
            local found = (char and char:FindFirstChild(name)) or (backpack and backpack:FindFirstChild(name))
            
            if ToggleObjects[name] then
                if found and not ToggleObjects[name].Value then
                    ToggleObjects[name]:SetValue(true) -- Mavi Glow AÇIK
                elseif not found and ToggleObjects[name].Value then
                    ToggleObjects[name]:SetValue(false) -- Glow KAPALI
                end
            end
        end
    end
end)

-- Kayıtlıları yükle
AddedItems = LoadData()
for _, n in ipairs(AddedItems) do CreateItemUI(n) end

-- [ MISC - HATALARI DÜZELTİLMİŞ ]
local MiscSection = Tabs.Misc:AddSection("Arayüz")

MiscSection:AddKeybind("MenuKey", {
    Title = "Menü Tuşu",
    Mode = "Toggle", 
    Default = "LeftControl",
    ChangedCallback = function(New)
        Window:SetMinimizeKey(New) -- Boolean hatasını çözen doğru komut
    end
})

Window:SelectTab(1)