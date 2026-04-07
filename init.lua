local baseUrl = "https://raw.githubusercontent.com/0sole/traning/refs/heads/main/"

-- HttpGet ile güvenli yükleme
local function safeLoadFromGithub(filename)
    local success, result = pcall(function()
        return game:HttpGet(baseUrl .. filename)
    end)
    if not success then
        error("Hata: " .. filename .. " yüklenemedi!")
    end
    return result
end

-- Kütüphaneyi çek ve global yap
local libraryCode = safeLoadFromGithub("Library.lua")
getgenv().Library = loadstring(libraryCode)()

-- Main scripti çalıştır
local mainCode = safeLoadFromGithub("main.lua")
loadstring(mainCode)()