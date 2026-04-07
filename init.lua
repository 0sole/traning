local baseUrl = "https://raw.githubusercontent.com/0sole/traning/refs/heads/main/"

local function safeLoad(filename)
    local success, result = pcall(function()
        return game:HttpGet(baseUrl .. filename)
    end)
    if not success then return nil end
    return result
end

-- Sadece main.lua'yı yükle, Fluent zaten main içinde çağrılıyor
local mainCode = safeLoad("main.lua")
if mainCode then
    loadstring(mainCode)()
else
    warn("Main script yüklenemedi!")
end