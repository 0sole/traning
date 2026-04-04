local theme = _G.DragoTheme
local Menu = {}

function Menu:CreateWindow(name)
    -- 1. Ana Ekran (ScreenGui)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DragoLib"
    ScreenGui.Parent = game:GetService("CoreGui") -- Exploitler için en iyisi budur
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- 2. Ana Pencere (Main Frame)
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = theme.window_size
    MainFrame.Position = UDim2.new(0.5, -310, 0.5, -195)
    MainFrame.BackgroundColor3 = theme.bg_deep
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    -- Köşeleri yuvarla
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = MainFrame

    -- Elemanların ekleneceği bir konteyner (Container)
    local ElementContainer = Instance.new("ScrollingFrame")
    ElementContainer.Name = "Container"
    ElementContainer.Size = UDim2.new(1, -20, 1, -50)
    ElementContainer.Position = UDim2.new(0, 10, 0, 40)
    ElementContainer.BackgroundTransparency = 1
    ElementContainer.Parent = MainFrame

    local Window = {
        Instance = MainFrame,
        Container = ElementContainer
    }

    -- Tab oluşturma fonksiyonu
    function Window:CreateTab(tabName)
        local Tab = {
            Name = tabName,
            ParentWindow = Window
        }

        -- Buton oluşturma fonksiyonunu bağla
        function Tab:CreateButton(text, callback)
            -- elements.lua'daki fonksiyonu çağırıyoruz
            return _G.DragoElements.CreateButton(ElementContainer, text, callback)
        end

        return Tab
    end

    return Window
end

return Menu
