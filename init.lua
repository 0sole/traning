-- GitHub Kullanıcı Bilgilerin
local baseUrl = "https://raw.githubusercontent.com/0sole/traning/refs/heads/main/init.lua"

local function fetch(file)
    return game:HttpGet(baseUrl .. file)
end

-- 1. Sanal bir klasör oluştur (require'ın çalışması için)
local VirtualProject = Instance.new("Folder")
VirtualProject.Name = "MyProject"
VirtualProject.Parent = game:GetService("CoreGui") -- Gizli tutmak için

-- 2. Library Dosyasını Yükle
local LibraryScript = Instance.new("ModuleScript")
LibraryScript.Name = "Library"
LibraryScript.Source = fetch("Library.lua")
LibraryScript.Parent = VirtualProject

-- 3. Main Dosyasını Yükle
local MainScript = Instance.new("ModuleScript")
MainScript.Name = "main"
MainScript.Source = fetch("main.lua")
MainScript.Parent = VirtualProject

-- 4. Çalıştır
local MainModule = require(MainScript)
if MainModule.Initialize then
    MainModule:Initialize()
else
    -- Eğer main.lua direkt çalışıyorsa:
    loadstring(MainScript.Source)()
end

print("Proje başarıyla yüklendi!")