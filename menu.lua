local theme       = _G.DragoTheme
local TweenService = game:GetService("TweenService")
local UIS          = game:GetService("UserInputService")
local Menu         = {}

-- ═══════════════════════════════════════════════════════════
-- YARDIMCI FONKSİYONLAR
-- ═══════════════════════════════════════════════════════════
local function MakeTween(obj, t, props, style, dir)
    style = style or Enum.EasingStyle.Quad
    dir   = dir   or Enum.EasingDirection.Out
    return TweenService:Create(obj, TweenInfo.new(t, style, dir), props)
end

local function AddCorner(obj, rad)
    local c = Instance.new("UICorner", obj)
    c.CornerRadius = UDim.new(0, rad or 3)
    return c
end

local function AddStroke(obj, color, thick, trans)
    local s = Instance.new("UIStroke", obj)
    s.Color = color or theme.border_color
    s.Thickness = thick or 1
    s.Transparency = trans or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return s
end

-- ═══════════════════════════════════════════════════════════
-- LOADING SCREEN
-- ═══════════════════════════════════════════════════════════
local function CreateLoadingScreen(screenGui)
    local overlay = Instance.new("Frame", screenGui)
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 100
    overlay.Name = "LoadingOverlay"

    -- Merkez kutu
    local box = Instance.new("Frame", overlay)
    box.Size = UDim2.new(0, 280, 0, 140)
    box.Position = UDim2.new(0.5, -140, 0.5, -70)
    box.BackgroundColor3 = theme.bg_deep
    box.BorderSizePixel = 0
    box.ZIndex = 101
    AddCorner(box, 4)
    local boxStroke = AddStroke(box, theme.accent_main, 1, 0)
    boxStroke.ZIndex = 101

    -- Üst kırmızı çizgi
    local topLine = Instance.new("Frame", box)
    topLine.Size = UDim2.new(0, 0, 0, 2)
    topLine.BackgroundColor3 = theme.accent_glow
    topLine.BorderSizePixel = 0
    topLine.ZIndex = 102

    -- Logo yazısı
    local logo = Instance.new("TextLabel", box)
    logo.Size = UDim2.new(1, 0, 0, 40)
    logo.Position = UDim2.new(0, 0, 0, 20)
    logo.Text = "DRAGO ENO"
    logo.TextColor3 = theme.accent_glow
    logo.Font = Enum.Font.SourceSansBold
    logo.TextSize = 24
    logo.BackgroundTransparency = 1
    logo.ZIndex = 102

    -- Alt yazı
    local sub = Instance.new("TextLabel", box)
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.Position = UDim2.new(0, 0, 0, 58)
    sub.Text = "INITIALIZING..."
    sub.TextColor3 = theme.text_dark
    sub.Font = Enum.Font.SourceSans
    sub.TextSize = 11
    sub.BackgroundTransparency = 1
    sub.ZIndex = 102

    -- Progress track
    local track = Instance.new("Frame", box)
    track.Size = UDim2.new(1, -40, 0, 3)
    track.Position = UDim2.new(0, 20, 0, 90)
    track.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    track.BorderSizePixel = 0
    track.ZIndex = 102
    AddCorner(track, 2)

    local bar = Instance.new("Frame", track)
    bar.Size = UDim2.new(0, 0, 1, 0)
    bar.BackgroundColor3 = theme.accent_main
    bar.BorderSizePixel = 0
    bar.ZIndex = 103
    AddCorner(bar, 2)

    -- Glow dot
    local dot = Instance.new("Frame", track)
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(0, -4, 0.5, -4)
    dot.BackgroundColor3 = theme.accent_glow
    dot.BorderSizePixel = 0
    dot.ZIndex = 104
    AddCorner(dot, 4)
    AddStroke(dot, theme.accent_glow, 2, 0.3)

    -- Version
    local ver = Instance.new("TextLabel", box)
    ver.Size = UDim2.new(1, 0, 0, 16)
    ver.Position = UDim2.new(0, 0, 0, 112)
    ver.Text = "v2.0 | SYSTEM CHECK"
    ver.TextColor3 = theme.accent_dim
    ver.Font = Enum.Font.SourceSans
    ver.TextSize = 10
    ver.BackgroundTransparency = 1
    ver.ZIndex = 102

    -- Köşe süslemeler
    local corners = {
        {UDim2.new(0, 0, 0, 0), UDim2.new(0, 12, 0, 1)},      -- sol üst yatay
        {UDim2.new(0, 0, 0, 0), UDim2.new(0, 1, 0, 12)},       -- sol üst dikey
        {UDim2.new(1, -12, 0, 0), UDim2.new(0, 12, 0, 1)},     -- sağ üst yatay
        {UDim2.new(1, -1, 0, 0), UDim2.new(0, 1, 0, 12)},      -- sağ üst dikey
        {UDim2.new(0, 0, 1, -1), UDim2.new(0, 12, 0, 1)},      -- sol alt yatay
        {UDim2.new(0, 0, 1, -12), UDim2.new(0, 1, 0, 12)},     -- sol alt dikey
        {UDim2.new(1, -12, 1, -1), UDim2.new(0, 12, 0, 1)},    -- sağ alt yatay
        {UDim2.new(1, -1, 1, -12), UDim2.new(0, 1, 0, 12)},    -- sağ alt dikey
    }
    for _, d in ipairs(corners) do
        local c = Instance.new("Frame", box)
        c.Position = d[1]; c.Size = d[2]
        c.BackgroundColor3 = theme.accent_glow
        c.BorderSizePixel = 0; c.ZIndex = 103
    end

    -- Animasyon Sekansı
    MakeTween(topLine, 0.6, {Size = UDim2.new(1, 0, 0, 2)}, Enum.EasingStyle.Expo):Play()
    task.delay(0.2, function()
        -- Progress bar dolumu
        local messages = {"LOADING MODULES...", "BUILDING UI...", "APPLYING THEME...", "READY."}
        for i, msg in ipairs(messages) do
            task.delay((i-1) * 0.35, function()
                sub.Text = msg
                local pct = i / #messages
                MakeTween(bar, 0.3, {Size = UDim2.new(pct, 0, 1, 0)}):Play()
                MakeTween(dot, 0.3, {Position = UDim2.new(pct, -4, 0.5, -4)}):Play()
                if pct == 1 then
                    MakeTween(bar, 0.2, {BackgroundColor3 = theme.accent_glow}):Play()
                end
            end)
        end
    end)

    -- Toplam süre ~1.7s sonra overlay kapat
    local function Dismiss(mainFrame)
        task.delay(1.7, function()
            MakeTween(box, 0.3, {Position = UDim2.new(0.5, -140, 0.5, -60), BackgroundTransparency = 1}):Play()
            MakeTween(logo, 0.3, {TextTransparency = 1}):Play()
            task.delay(0.25, function()
                MakeTween(overlay, 0.4, {BackgroundTransparency = 1}):Play()
                -- Ana pencere giriş animasyonu
                if mainFrame then
                    mainFrame.Position = UDim2.new(0.5, -320, 0.5, -185)
                    mainFrame.Size = UDim2.new(0, 0, 0, 0)
                    mainFrame.Visible = true
                    MakeTween(mainFrame, 0.35, {
                        Size = theme.window_size,
                        Position = UDim2.new(0.5, -(theme.window_size.X.Offset/2), 0.5, -(theme.window_size.Y.Offset/2))
                    }, Enum.EasingStyle.Back, Enum.EasingDirection.Out):Play()
                end
                task.delay(0.5, function()
                    overlay:Destroy()
                end)
            end)
        end)
    end

    return Dismiss
end

-- ═══════════════════════════════════════════════════════════
-- ANA PENCERE
-- ═══════════════════════════════════════════════════════════
function Menu:CreateWindow(name, options)
    options = options or {}
    local hideKey   = options.HideKey or Enum.KeyCode.RightControl
    local destroyKey = options.DestroyKey  -- opsiyonel, destroy için

    -- ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "DragoEno_UI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- CoreGui'ye yerleştirmeyi dene, aksi halde PlayerGui
    local ok = pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    if not ok then
        ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end

    -- Main Frame (başta gizli, loading sonrası açılır)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = theme.window_size
    MainFrame.Position = UDim2.new(0.5, -(theme.window_size.X.Offset/2), 0.5, -(theme.window_size.Y.Offset/2))
    MainFrame.BackgroundColor3 = theme.bg_deep
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = false
    AddCorner(MainFrame, 4)
    AddStroke(MainFrame, theme.border_color, 1, 0)

    -- Dış glow efekti (UIStroke blur simülasyonu)
    local outerGlow = AddStroke(MainFrame, theme.accent_main, 3, 0.7)

    -- Pulse glow animasyonu
    TweenService:Create(outerGlow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {Transparency = 0.4}):Play()

    -- Üst Kırmızı Çizgi
    local TopLine = Instance.new("Frame", MainFrame)
    TopLine.Size = UDim2.new(1, 0, 0, 2)
    TopLine.BackgroundColor3 = theme.accent_glow
    TopLine.BorderSizePixel = 0

    -- ── TOPBAR ──────────────────────────────────────
    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.Size = UDim2.new(1, 0, 0, 28)
    TopBar.Position = UDim2.new(0, 0, 0, 2)
    TopBar.BackgroundColor3 = theme.bg_topbar
    TopBar.BorderSizePixel = 0

    local TitleLabel = Instance.new("TextLabel", TopBar)
    TitleLabel.Text = name or "DRAGO ENO"
    TitleLabel.Size = UDim2.new(0.5, 0, 1, 0)
    TitleLabel.Position = UDim2.new(0, 14, 0, 0)
    TitleLabel.TextColor3 = theme.text_main
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.TextSize = 13
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.BackgroundTransparency = 1

    -- Sağ üst bilgi
    local HintLabel = Instance.new("TextLabel", TopBar)
    HintLabel.Text = "[" .. hideKey.Name .. "] GİZLE"
    HintLabel.Size = UDim2.new(0.5, -10, 1, 0)
    HintLabel.Position = UDim2.new(0.5, 0, 0, 0)
    HintLabel.TextColor3 = theme.accent_dim
    HintLabel.Font = Enum.Font.SourceSans
    HintLabel.TextSize = 10
    HintLabel.TextXAlignment = Enum.TextXAlignment.Right
    HintLabel.BackgroundTransparency = 1

    -- Drag desteği
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    TopBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- ── SIDEBAR ─────────────────────────────────────
    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, theme.sidebar_width, 1, -30)
    Sidebar.Position = UDim2.new(0, 0, 0, 30)
    Sidebar.BackgroundColor3 = theme.bg_sidebar
    Sidebar.BorderSizePixel = 0

    -- Sidebar sağ kenar çizgisi
    local sideEdge = Instance.new("Frame", Sidebar)
    sideEdge.Size = UDim2.new(0, 1, 1, 0)
    sideEdge.Position = UDim2.new(1, -1, 0, 0)
    sideEdge.BackgroundColor3 = theme.border_color
    sideEdge.BorderSizePixel = 0

    local LogoArea = Instance.new("Frame", Sidebar)
    LogoArea.Size = UDim2.new(1, 0, 0, 65)
    LogoArea.BackgroundTransparency = 1

    local LogoLabel = Instance.new("TextLabel", LogoArea)
    LogoLabel.Text = "DRAGO"
    LogoLabel.Size = UDim2.new(1, 0, 0, 36)
    LogoLabel.Position = UDim2.new(0, 0, 0, 12)
    LogoLabel.TextColor3 = theme.accent_glow
    LogoLabel.Font = Enum.Font.SourceSansBold
    LogoLabel.TextSize = 22
    LogoLabel.BackgroundTransparency = 1

    local LogoSub = Instance.new("TextLabel", LogoArea)
    LogoSub.Text = "ENO  ·  UI LIBRARY"
    LogoSub.Size = UDim2.new(1, 0, 0, 16)
    LogoSub.Position = UDim2.new(0, 0, 0, 44)
    LogoSub.TextColor3 = theme.accent_dim
    LogoSub.Font = Enum.Font.SourceSans
    LogoSub.TextSize = 9
    LogoSub.BackgroundTransparency = 1

    -- Logo alt çizgisi
    local logoLine = Instance.new("Frame", Sidebar)
    logoLine.Size = UDim2.new(0.7, 0, 0, 1)
    logoLine.Position = UDim2.new(0.15, 0, 0, 65)
    logoLine.BackgroundColor3 = theme.border_color
    logoLine.BorderSizePixel = 0

    -- Tab buton container
    local TabButtonsContainer = Instance.new("Frame", Sidebar)
    TabButtonsContainer.Position = UDim2.new(0, 0, 0, 72)
    TabButtonsContainer.Size = UDim2.new(1, 0, 1, -80)
    TabButtonsContainer.BackgroundTransparency = 1
    local TBLayout = Instance.new("UIListLayout", TabButtonsContainer)
    TBLayout.Padding = UDim.new(0, 2)

    -- ── CONTENT ─────────────────────────────────────
    local ContentFrame = Instance.new("Frame", MainFrame)
    ContentFrame.Position = UDim2.new(0, theme.sidebar_width + 6, 0, 35)
    ContentFrame.Size = UDim2.new(1, -(theme.sidebar_width + 16), 1, -45)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ClipsDescendants = true

    -- ── GİZLE / GÖSTER SİSTEMİ ─────────────────────
    local isVisible = true
    local connections = {}

    -- Küçük overlay butonu (gizliyken göster)
    local ShowBtn = Instance.new("TextButton", ScreenGui)
    ShowBtn.Size = UDim2.new(0, 120, 0, 28)
    ShowBtn.Position = UDim2.new(0, 12, 0.5, -14)
    ShowBtn.BackgroundColor3 = theme.bg_deep
    ShowBtn.Text = "▶  DRAGO ENO"
    ShowBtn.TextColor3 = theme.accent_glow
    ShowBtn.Font = Enum.Font.SourceSansBold
    ShowBtn.TextSize = 11
    ShowBtn.BorderSizePixel = 0
    ShowBtn.Visible = false
    AddCorner(ShowBtn, 3)
    AddStroke(ShowBtn, theme.accent_main, 1, 0)
    -- Glow pulse on show button
    local showBtnStroke = AddStroke(ShowBtn, theme.accent_glow, 2, 0.5)
    TweenService:Create(showBtnStroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {Transparency = 0.0}):Play()

    local function HideGUI()
        if not isVisible then return end
        isVisible = false
        MakeTween(MainFrame, 0.25, {Size = UDim2.new(0, theme.window_size.X.Offset, 0, 0)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In):Play()
        task.delay(0.2, function()
            MakeTween(MainFrame, 0.15, {BackgroundTransparency = 1}):Play()
            task.delay(0.15, function()
                MainFrame.Visible = false
                ShowBtn.Visible = true
                MakeTween(ShowBtn, 0.2, {Position = UDim2.new(0, 12, 0.5, -14)}):Play()
            end)
        end)
    end

    local function ShowGUI()
        if isVisible then return end
        isVisible = true
        ShowBtn.Visible = false
        MainFrame.Visible = true
        MainFrame.BackgroundTransparency = 1
        MainFrame.Size = UDim2.new(0, theme.window_size.X.Offset, 0, 10)
        MakeTween(MainFrame, 0.05, {BackgroundTransparency = 0}):Play()
        MakeTween(MainFrame, 0.3, {Size = theme.window_size}, Enum.EasingStyle.Back, Enum.EasingDirection.Out):Play()
    end

    ShowBtn.MouseButton1Click:Connect(ShowGUI)

    -- Klavye gizle/göster
    table.insert(connections, UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == hideKey then
            if isVisible then HideGUI() else ShowGUI() end
        end
        if destroyKey and input.KeyCode == destroyKey then
            -- DESTROY: tüm UI yok et
            MakeTween(MainFrame, 0.3, {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)}):Play()
            task.delay(0.35, function()
                for _, c in ipairs(connections) do c:Disconnect() end
                ScreenGui:Destroy()
            end)
        end
    end))

    -- ── WINDOW OBJESİ ───────────────────────────────
    local Window = {
        Main = MainFrame,
        Content = ContentFrame,
        TabsContainer = TabButtonsContainer,
        ScreenGui = ScreenGui,
        _connections = connections,
        _visible = true,
    }

    -- Destroy metodu
    function Window:Destroy()
        MakeTween(MainFrame, 0.3, {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.delay(0.35, function()
            for _, c in ipairs(connections) do c:Disconnect() end
            ScreenGui:Destroy()
        end)
    end

    -- Hide/Show metotları
    function Window:Hide() HideGUI() end
    function Window:Show() ShowGUI() end

    -- ── TAB OLUŞTUR ─────────────────────────────────
    function Window:CreateTab(tabName)
        local Page = Instance.new("ScrollingFrame", ContentFrame)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = theme.accent_main
        Page.BorderSizePixel = 0
        Page.ClipsDescendants = true

        local PageLayout = Instance.new("UIListLayout", Page)
        PageLayout.Padding = UDim.new(0, 6)
        PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
        end)

        local UIPad = Instance.new("UIPadding", Page)
        UIPad.PaddingTop = UDim.new(0, 6)

        -- ── TAB BUTONU ──────────────────────────────
        local TabBtn = Instance.new("TextButton", TabButtonsContainer)
        TabBtn.Size = UDim2.new(1, 0, 0, 36)
        TabBtn.BackgroundColor3 = Color3.fromRGB(12, 0, 0)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = ""
        TabBtn.BorderSizePixel = 0

        local TabBtnLabel = Instance.new("TextLabel", TabBtn)
        TabBtnLabel.Text = "  ▸  " .. tabName
        TabBtnLabel.Size = UDim2.new(1, 0, 1, 0)
        TabBtnLabel.TextColor3 = theme.text_dark
        TabBtnLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabBtnLabel.Font = Enum.Font.SourceSans
        TabBtnLabel.TextSize = 13
        TabBtnLabel.BackgroundTransparency = 1

        -- Aktif sol çizgi
        local GlowLine = Instance.new("Frame", TabBtn)
        GlowLine.Size = UDim2.new(0, 2, 0.65, 0)
        GlowLine.Position = UDim2.new(0, 0, 0.175, 0)
        GlowLine.BackgroundColor3 = theme.accent_glow
        GlowLine.BorderSizePixel = 0
        GlowLine.Visible = false
        -- Pulse on glow line
        local glowTween

        local function SetActive()
            -- Diğer tabları kapat
            for _, v in pairs(ContentFrame:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            for _, v in pairs(TabButtonsContainer:GetChildren()) do
                if v:IsA("TextButton") then
                    MakeTween(v, 0.15, {BackgroundTransparency = 1}):Play()
                    local lbl = v:FindFirstChildWhichIsA("TextLabel")
                    if lbl then
                        MakeTween(lbl, 0.15, {TextColor3 = theme.text_dark}):Play()
                        lbl.Text = "  ▸  " .. lbl.Text:gsub("  ▸  ", ""):gsub("  ▶  ", "")
                    end
                    local gl = v:FindFirstChildWhichIsA("Frame")
                    if gl then gl.Visible = false end
                end
            end

            -- Sayfa animasyonu
            Page.Position = UDim2.new(0, 20, 0, 0)
            Page.Visible = true
            MakeTween(Page, theme.transition_speed, {Position = UDim2.new(0, 0, 0, 0)}, Enum.EasingStyle.Quad):Play()

            -- Aktif tab stili
            MakeTween(TabBtn, 0.15, {BackgroundTransparency = 0.85}):Play()
            MakeTween(TabBtnLabel, 0.15, {TextColor3 = theme.accent_glow}):Play()
            TabBtnLabel.Text = "  ▶  " .. tabName
            GlowLine.Visible = true

            -- Pulse glow line
            if glowTween then glowTween:Cancel() end
            glowTween = TweenService:Create(GlowLine, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                {BackgroundColor3 = theme.accent_main})
            glowTween:Play()
        end

        TabBtn.MouseEnter:Connect(function()
            if not Page.Visible then
                MakeTween(TabBtn, 0.15, {BackgroundTransparency = 0.92}):Play()
                MakeTween(TabBtnLabel, 0.15, {TextColor3 = Color3.fromRGB(180, 180, 180)}):Play()
            end
        end)
        TabBtn.MouseLeave:Connect(function()
            if not Page.Visible then
                MakeTween(TabBtn, 0.15, {BackgroundTransparency = 1}):Play()
                MakeTween(TabBtnLabel, 0.15, {TextColor3 = theme.text_dark}):Play()
            end
        end)

        TabBtn.MouseButton1Click:Connect(SetActive)

        -- İlk tab otomatik açık
        if #TabButtonsContainer:GetChildren() <= 2 then -- UIListLayout + ilk btn
            task.defer(SetActive)
        end

        -- Tab API
        local Tab = {}
        function Tab:CreateButton(text, cb) return _G.DragoElements.CreateButton(Page, text, cb) end
        function Tab:CreateToggle(text, def, cb) return _G.DragoElements.CreateToggle(Page, text, def, cb) end
        function Tab:CreateSlider(text, min, max, def, cb) return _G.DragoElements.CreateSlider(Page, text, min, max, def, cb) end
        function Tab:CreateKeybind(text, def, cb) return _G.DragoElements.CreateKeybind(Page, text, def, cb) end
        function Tab:CreateLabel(text) return _G.DragoElements.CreateLabel(Page, text) end
        return Tab
    end

    -- Loading screen başlat
    local Dismiss = CreateLoadingScreen(ScreenGui)
    Dismiss(MainFrame)

    return Window
end

return Menu