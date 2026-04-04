local theme = require("theme")
local Menu = {}

-- Ana Kütüphane Fonksiyonu
function Menu:CreateWindow(config)
    local Window = {
        Title = config.Name or "Drago Eno",
        Tabs = {},
        ActiveTab = nil
    }

    -- Tab oluşturma fonksiyonu (Window objesine bağlı)
    function Window:CreateTab(name, icon)
        local Tab = {
            Name = name,
            Elements = {},
            Parent = Window
        }
        
        -- Buton oluşturma (Tab objesine bağlı)
        function Tab:CreateButton(btnConfig)
            local Button = {
                Name = btnConfig.Name,
                Callback = btnConfig.Callback
            }
            table.insert(self.Elements, Button)
            return Button
        end

        table.insert(Window.Tabs, Tab)
        if not Window.ActiveTab then Window.ActiveTab = Tab end
        return Tab
    end

    return Window
end

return Menu
