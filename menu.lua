local theme = _G.DragoTheme
local TweenService = game:GetService("TweenService")
local Menu = { Tabs = {}, ActiveTab = nil }

function Menu:CreateWindow(name)
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Name = "DragoEno_UI"

    -- Main Window
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = theme.window_size
    MainFrame.Position = UDim2.new(0.5, -310, 0.5, -195)
    MainFrame.BackgroundColor3 = theme.bg_deep
    MainFrame.BorderSizePixel = 1
    MainFrame.BorderColor3 = theme.border_color
    
    -- HTML'deki Kırmızı Üst Çizgi (::before efekti)
    local TopLine = Instance.new("Frame", MainFrame)
    TopLine.Size = UDim2.new(1, 0, 0, 2)
    TopLine.BackgroundColor3 = theme.accent_glow
    TopLine.BorderSizePixel = 0

    -- Sidebar
    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 170, 1, 0)
    Sidebar.BackgroundColor3 = theme.bg_sidebar
    Sidebar.BorderColor3 = theme.border_color

    local LibTitle = Instance.new("TextLabel", Sidebar)
    LibTitle.Text = "DRAGO ENO"
    LibTitle.Size = UDim2.new(1, 0, 0, 60)
    LibTitle.TextColor3 = theme.accent_glow
    LibTitle.Font = Enum.Font.SourceSansBold
    LibTitle.TextSize = 18
    LibTitle.BackgroundTransparency = 1

    local TabButtonsContainer = Instance.new("Frame", Sidebar)
    TabButtonsContainer.Position = UDim2.new(0, 10, 0, 70)
    TabButtonsContainer.Size = UDim2.new(1, -20, 1, -80)
    TabButtonsContainer.BackgroundTransparency = 1
    local Layout = Instance.new("UIListLayout", TabButtonsContainer)
    Layout.Padding = UDim.new(0, 5)

    -- Content Area
    local ContentFrame = Instance.new("Frame", MainFrame)
    ContentFrame.Position = UDim2.new(0, 175, 0, 25)
    ContentFrame.Size = UDim2.new(1, -185, 1, -35)
    ContentFrame.BackgroundTransparency = 1

    local Window = { Main = MainFrame, Content = ContentFrame, TabsContainer = TabButtonsContainer }

    function Window:CreateTab(tabName)
        local Page = Instance.new("ScrollingFrame", ContentFrame)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.CanvasSize = UDim2.new(0,0,0,0)
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = theme.accent_main
        
        local PageLayout = Instance.new("UIListLayout", Page)
        PageLayout.Padding = UDim.new(0, 8)

        -- Tab Button
        local TabBtn = Instance.new("TextButton", TabButtonsContainer)
        TabBtn.Size = UDim2.new(1, 0, 0, 35)
        TabBtn.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = "  " .. tabName
        TabBtn.TextColor3 = theme.text_dark
        TabBtn.TextXAlignment = Enum.TextXAlignment.Left
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.TextSize = 14

        -- Aktif Çizgi (HTML active::before)
        local GlowLine = Instance.new("Frame", TabBtn)
        GlowLine.Size = UDim2.new(0, 3, 0.7, 0)
        GlowLine.Position = UDim2.new(0, 0, 0.15, 0)
        GlowLine.BackgroundColor3 = theme.accent_glow
        GlowLine.BorderSizePixel = 0
        GlowLine.Visible = false

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(ContentFrame:GetChildren()) do v.Visible = false end
            for _, v in pairs(TabButtonsContainer:GetChildren()) do 
                if v:IsA("TextButton") then 
                    TweenService:Create(v, TweenInfo.new(0.2), {TextColor3 = theme.text_dark, BackgroundTransparency = 1}):Play()
                    if v:FindFirstChild("Frame") then v.Frame.Visible = false end
                end 
            end

            -- Sayfa Animasyonu (dragoPageIn)
            Page.Visible = true
            Page.Position = UDim2.new(0, 15, 0, 0) -- Sağdan başla
            Page.GroupTransparency = 1 -- CanvasGroup gerektirir (alternatif olarak elemanları tweenle)
            
            TweenService:Create(Page, TweenInfo.new(theme.transition_speed), {Position = UDim2.new(0,0,0,0)}):Play()
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {TextColor3 = theme.accent_glow, BackgroundTransparency = 0.85}):Play()
            GlowLine.Visible = true
        end)

        return {
            CreateButton = function(_, text, cb) return _G.DragoElements.CreateButton(Page, text, cb) end,
            CreateKeybind = function(_, text, def, cb) return _G.DragoElements.CreateKeybind(Page, text, def, cb) end
        }
    end

    return Window
end

return Menu