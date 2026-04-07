local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Proje v2",
    SubTitle = "by 0sole",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Sekmeler
local Tabs = {
    Items = Window:AddTab({ Title = "Eşya Ekle", Icon = "plus-circle" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
}

-- Değişkenler
local ItemNameInput = ""

-- [ ITEMS SEKMESİ ]
local InputSection = Tabs.Items:AddSection("Yeni Eşya Oluştur")

local ItemInput = InputSection:AddInput("ItemName", {
    Title = "Eşya İsmi",
    Default = "",
    Placeholder = "İsim yazın...",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        ItemNameInput = Value
    end
})

-- Eşyaların ekleneceği liste alanı
local ListSection = Tabs.Items:AddSection("Eklenen Eşyalar")

InputSection:AddButton({
    Title = "Ekle (Add)",
    Description = "Yazdığınız ismi listeye mavi parlamayla ekler.",
    Callback = function()
        if ItemNameInput == "" then 
            Fluent:Notify({Title = "Hata", Content = "Lütfen bir isim girin!", Duration = 3})
            return 
        end

        -- Yeni İtem Toggle Olarak Ekleniyor (Mavi parlamalı/temalı)
        ListSection:AddToggle(ItemNameInput, {
            Title = "🔵 " .. ItemNameInput, 
            Default = false,
            Callback = function(State)
                print(ItemNameInput .. " durumu: " .. tostring(State))
                -- Buraya item açıldığında ne olmasını istiyorsan o kodu yazabilirsin
            end
        })

        Fluent:Notify({
            Title = "Başarılı",
            Content = ItemNameInput .. " listeye eklendi.",
            Duration = 2
        })
    end
})

-- [ MISC SEKMESİ ]
local MiscSection = Tabs.Misc:AddSection("Genel Ayarlar")

-- Menü Gizleme Tuşu (Keybind)
MiscSection:AddKeybind("MenuKey", {
    Title = "Menü Kapatma Tuşu",
    Mode = "Toggle",
    Default = "LeftControl",
    Callback = function(Value)
        print("Menü tuşu değiştirildi: " .. Value)
    end,
    ChangedCallback = function(New)
        Window.MinimizeKey = New
    end
})

-- PANIC BUTTON (Her şeyi siler)
MiscSection:AddButton({
    Title = "PANIC BUTTON",
    Description = "Tüm arayüzü yok eder ve scripti durdurur.",
    Callback = function()
        Window:Destroy()
        Fluent:Notify({
            Title = "Panic!",
            Content = "Tüm sistemler kapatıldı.",
            Duration = 5
        })
    end
})

-- Config Ayarları (Fluent standardı)
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:BuildInterfaceSection(Tabs.Misc)
SaveManager:BuildConfigSection(Tabs.Misc)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Hazır!",
    Content = "Script başarıyla yüklendi.",
    Duration = 3
})