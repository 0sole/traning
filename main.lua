local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- [ AYARLAR VE KAYIT SİSTEMİ ]
local HttpService = game:GetService("HttpService")
local FileName = "0sole_Items.json"
local AddedItems = {}

-- Dosyadan itemleri yükleme fonksiyonu
local function LoadSavedItems()
    if isfile(FileName) then
        local success, data = pcall(function() return HttpService:JSONDecode(readfile(FileName)) end)
        if success then return data end
    end
    return {}
end

-- İtemleri dosyaya kaydetme fonksiyonu
local function SaveItems()
    writefile(FileName, HttpService:JSONEncode(AddedItems))
end

-- [ PENCERE KURULUMU ]
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

-- [ ITEMS SEKMESİ ]
local ListSection = Tabs.Items:AddSection("Eklenen Eşyalar")
local ItemNameInput = ""

-- İtem ekleme ana fonksiyonu
local function CreateItemUI(name)
    ListSection:AddToggle("item_" .. name, {
        Title = "🔵 " .. name,
        Default = false,
        Callback = function(Value)
            print(name .. " durumu: " .. tostring(Value))
        end
    })
end

Tabs.Items:AddInput("ItemInput", {
    Title = "Eşya İsmi",
    Default = "",
    Placeholder = "İsim yazın...",
    Callback = function(Value) ItemNameInput = Value end
})

Tabs.Items:AddButton({
    Title = "Ekle (Add)",
    Description = "Listeye kaydeder ve kalıcı hale getirir.",
    Callback = function()
        if ItemNameInput == "" or table.find(AddedItems, ItemNameInput) then return end
        
        table.insert(AddedItems, ItemNameInput)
        SaveItems() -- Listeyi dosyaya yaz
        CreateItemUI(ItemNameInput) -- Arayüze ekle
        
        Fluent:Notify({Title = "Başarılı", Content = ItemNameInput .. " eklendi ve kaydedildi.", Duration = 2})
    end
})

-- Sayfa açıldığında kayıtlı itemleri yükle
AddedItems = LoadSavedItems()
for _, name in ipairs(AddedItems) do
    CreateItemUI(name)
end

-- [ MISC SEKMESİ ]
local MiscSection = Tabs.Misc:AddSection("Arayüz Ayarları")

MiscSection:AddKeybind("MenuKeybind", {
    Title = "Menü Kapatma Tuşu",
    Mode = "Toggle", 
    Default = "LeftControl",
    ChangedCallback = function(New)
        Window:SetMinimizeKey(New) -- Doğru kullanım budur
    end
})

-- Kütüphane Yöneticileri
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"ItemInput", "MenuKeybind"})
InterfaceManager:BuildInterfaceSection(Tabs.Misc)
SaveManager:BuildConfigSection(Tabs.Misc)

Window:SelectTab(1)

Fluent:Notify({
    Title = "Hazır!",
    Content = "Kayıtlı " .. #AddedItems .. " eşya yüklendi.",
    Duration = 3
})