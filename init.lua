local baseUrl = "https://raw.githubusercontent.com/0sole/traning/refs/heads/main/"

local function fetch(file)
    return game:HttpGet(baseUrl .. file)
end

-- Dosyaların birbirini bulabilmesi için sanal bir yapı oluşturuyoruz
local VirtualProject = Instance.new("Folder")
VirtualProject.Name = "MyProject"
VirtualProject.Parent = game:GetService("CoreGui")

-- 1. Library.lua dosyasını yükle
local LibraryScript = Instance.new("ModuleScript")
LibraryScript.Name = "Library"
LibraryScript.Source = fetch("Library.lua")
LibraryScript.Parent = VirtualProject

-- 2. main.lua dosyasını yükle
local MainScript = Instance.new("ModuleScript")
MainScript.Name = "main"
MainScript.Source = fetch("main.lua")
MainScript.Parent = VirtualProject

-- 3. Projeyi başlat
local success, MainModule = pcall(function()
    return require(MainScript)
end)

if success and MainModule.Initialize then
    MainModule:Initialize()
    print("Proje başarıyla yüklendi!")
else
    -- Eğer main.lua bir tablo döndürmüyorsa direkt çalıştır
    loadstring(MainScript.Source)()
end