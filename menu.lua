local theme = _G.DragoTheme
local elements = _G.DragoElements
local Menu = {}

function Menu:CreateWindow(config)
    local sgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    
    -- Ana Pencere
    local main = Instance.new("Frame", sgui)
    main.Size = theme.window_size
    main.Position = UDim2.new(0.5, -310, 0.5, -195)
    main.BackgroundColor3 = theme.bg_deep
    main.ClipsDescendants = true

    -- Üstteki Parlayan Çizgi (Ejderha Gözü Hattı)
    local topLine = Instance.new("Frame", main)
    topLine.Size = UDim2.new(1, 0, 0, 2)
    topLine.BackgroundColor3 = theme.accent_glow
    Instance.new("UIGradient", topLine).Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 1)
    })

    -- Sidebar
    local sidebar = Instance.new("Frame", main)
    sidebar.Size = UDim2.new(0, 170, 1, 0)
    sidebar.BackgroundColor3 = theme.bg_sidebar
    sidebar.BorderSizePixel = 0

    local title = Instance.new("TextLabel", sidebar)
    title.Text = "DRAGO ENO"
    title.Size = UDim2.new(1, 0, 0, 60)
    title.TextColor3 = theme.accent_glow
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 18

    -- İçerik Alanı
    local container = Instance.new("ScrollingFrame", main)
    container.Position = UDim2.new(0, 180, 0, 30)
    container.Size = UDim2.new(1, -190, 1, -40)
    container.BackgroundTransparency = 1
    container.ScrollBarThickness = 2
    
    local layout = Instance.new("UIListLayout", container)
    layout.Padding = UDim.new(0, 10)

    local window = {}
    function window:CreateTab(name)
        local tab = {}
        -- Sidebar Butonu (tab-link)
        local tBtn = Instance.new("TextButton", sidebar)
        tBtn.Size = UDim2.new(1, -20, 0, 35)
        tBtn.Position = UDim2.new(0, 10, 0, 70 + (#sidebar:GetChildren()*40))
        tBtn.Text = name
        tBtn.BackgroundColor3 = theme.accent_main
        tBtn.BackgroundTransparency = 0.9

        function tab:CreateButton(btnName, callback)
            elements.CreateButton(container, btnName, callback)
        end
        return tab
    end
    return window
end

return Menu
