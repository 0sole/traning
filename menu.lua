local theme = _G.DragoTheme
local elements = _G.DragoElements
local Menu = {}

function Menu:CreateWindow(name)
    local sgui = Instance.new("ScreenGui", game.CoreGui)
    
    local mainFrame = Instance.new("Frame", sgui)
    mainFrame.Size = UDim2.new(0, 620, 0, 390) --
    mainFrame.Position = UDim2.new(0.5, -310, 0.5, -195)
    mainFrame.BackgroundColor3 = theme.bg_deep
    
    local sidebar = Instance.new("Frame", mainFrame)
    sidebar.Size = UDim2.new(0, 170, 1, 0) --
    sidebar.BackgroundColor3 = theme.bg_sidebar
    
    local container = Instance.new("ScrollingFrame", mainFrame)
    container.Position = UDim2.new(0, 180, 0, 20)
    container.Size = UDim2.new(1, -190, 1, -40)
    container.BackgroundTransparency = 1

    local window = {}
    function window:CreateTab(tabName)
        local tab = {}
        function tab:CreateButton(config)
            elements.CreateButton(container, config.Name, config.Callback)
        end
        return tab
    end
    return window
end

return Menu
