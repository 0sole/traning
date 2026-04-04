local T   = _G.DragoTheme
local TS  = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Drago = {}

-- ── Yardımcılar ──────────────────────────────────────────────────────────────

local function tween(obj, t, props, style, dir)
    return TS:Create(obj,
        TweenInfo.new(t, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out),
        props)
end

local function corner(obj, r)
    local c = Instance.new("UICorner", obj)
    c.CornerRadius = UDim.new(0, r or 3)
    return c
end

local function stroke(obj, color, thick, trans)
    local s = Instance.new("UIStroke", obj)
    s.Color        = color or T.border_color
    s.Thickness    = thick or 1
    s.Transparency = trans or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return s
end

-- ── Loading Screen ───────────────────────────────────────────────────────────

local function Loading(gui, onDone)
    local overlay = Instance.new("Frame", gui)
    overlay.Size            = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BorderSizePixel = 0
    overlay.ZIndex          = 100

    local box = Instance.new("Frame", overlay)
    box.Size            = UDim2.new(0, 280, 0, 140)
    box.Position        = UDim2.new(0.5, -140, 0.5, -70)
    box.BackgroundColor3 = T.bg_deep
    box.BorderSizePixel = 0
    box.ZIndex          = 101
    corner(box, 4)
    stroke(box, T.accent_main, 1, 0)

    -- Üst kırmızı süpürme çizgisi
    local topLine = Instance.new("Frame", box)
    topLine.Size            = UDim2.new(0, 0, 0, 2)
    topLine.BackgroundColor3 = T.accent_glow
    topLine.BorderSizePixel = 0
    topLine.ZIndex          = 102
    tween(topLine, 0.5, {Size = UDim2.new(1, 0, 0, 2)}, Enum.EasingStyle.Expo):Play()

    -- Köşe çerçeve süsü
    local corners = {
        {UDim2.new(0,0,0,0),     UDim2.new(0,14,0,1)},
        {UDim2.new(0,0,0,0),     UDim2.new(0,1,0,14)},
        {UDim2.new(1,-14,0,0),   UDim2.new(0,14,0,1)},
        {UDim2.new(1,-1,0,0),    UDim2.new(0,1,0,14)},
        {UDim2.new(0,0,1,-1),    UDim2.new(0,14,0,1)},
        {UDim2.new(0,0,1,-14),   UDim2.new(0,1,0,14)},
        {UDim2.new(1,-14,1,-1),  UDim2.new(0,14,0,1)},
        {UDim2.new(1,-1,1,-14),  UDim2.new(0,1,0,14)},
    }
    for _, d in ipairs(corners) do
        local c = Instance.new("Frame", box)
        c.Position        = d[1]; c.Size = d[2]
        c.BackgroundColor3 = T.accent_glow
        c.BorderSizePixel = 0; c.ZIndex = 103
    end

    -- Logo
    local logo = Instance.new("TextLabel", box)
    logo.Text            = "DRAGO ENO"
    logo.Size            = UDim2.new(1, 0, 0, 38)
    logo.Position        = UDim2.new(0, 0, 0, 18)
    logo.TextColor3      = T.accent_glow
    logo.Font            = Enum.Font.SourceSansBold
    logo.TextSize        = 24
    logo.BackgroundTransparency = 1
    logo.ZIndex          = 102

    local sub = Instance.new("TextLabel", box)
    sub.Size             = UDim2.new(1, 0, 0, 18)
    sub.Position         = UDim2.new(0, 0, 0, 56)
    sub.Text             = "INITIALIZING..."
    sub.TextColor3       = T.text_dark
    sub.Font             = Enum.Font.SourceSans
    sub.TextSize         = 11
    sub.BackgroundTransparency = 1
    sub.ZIndex           = 102

    -- Progress
    local track = Instance.new("Frame", box)
    track.Size            = UDim2.new(1, -40, 0, 3)
    track.Position        = UDim2.new(0, 20, 0, 90)
    track.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    track.BorderSizePixel = 0
    track.ZIndex          = 102
    corner(track, 2)

    local bar = Instance.new("Frame", track)
    bar.Size            = UDim2.new(0, 0, 1, 0)
    bar.BackgroundColor3 = T.accent_main
    bar.BorderSizePixel = 0
    bar.ZIndex          = 103
    corner(bar, 2)

    local dot = Instance.new("Frame", track)
    dot.Size            = UDim2.new(0, 8, 0, 8)
    dot.Position        = UDim2.new(0, -4, 0.5, -4)
    dot.BackgroundColor3 = T.accent_glow
    dot.BorderSizePixel = 0
    dot.ZIndex          = 104
    corner(dot, 4)

    local ver = Instance.new("TextLabel", box)
    ver.Size             = UDim2.new(1, 0, 0, 16)
    ver.Position         = UDim2.new(0, 0, 0, 112)
    ver.Text             = "DRAGO ENO  ·  v2.0"
    ver.TextColor3       = T.accent_dim
    ver.Font             = Enum.Font.SourceSans
    ver.TextSize         = 10
    ver.BackgroundTransparency = 1
    ver.ZIndex           = 102

    -- Progress sekansı
    local steps = {"LOADING MODULES...", "BUILDING INTERFACE...", "APPLYING THEME...", "READY."}
    task.delay(0.3, function()
        for i, msg in ipairs(steps) do
            task.delay((i - 1) * 0.32, function()
                sub.Text = msg
                local pct = i / #steps
                tween(bar, 0.28, {Size = UDim2.new(pct, 0, 1, 0)}):Play()
                tween(dot, 0.28, {Position = UDim2.new(pct, -4, 0.5, -4)}):Play()
                if pct == 1 then
                    tween(bar, 0.2, {BackgroundColor3 = T.accent_glow}):Play()
                end
            end)
        end
    end)

    -- Bitiş: overlay kapat → callback
    task.delay(1.7, function()
        tween(overlay, 0.35, {BackgroundTransparency = 1}):Play()
        task.delay(0.35, function()
            overlay:Destroy()
            onDone()
        end)
    end)
end

-- ── CreateWindow ─────────────────────────────────────────────────────────────

function Drago:CreateWindow(cfg)
    cfg = cfg or {}
    local title      = cfg.Name       or "DRAGO ENO"
    local hideKey    = cfg.HideKey    or Enum.KeyCode.RightControl
    local destroyKey = cfg.DestroyKey or nil
    local loadAnim   = cfg.LoadingScreen ~= false  -- default true

    -- ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name           = "DragoEno"
    gui.ResetOnSpawn   = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local ok = pcall(function() gui.Parent = game:GetService("CoreGui") end)
    if not ok then
        gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end

    -- Main frame
    local Main = Instance.new("Frame", gui)
    Main.Size            = T.window_size
    Main.Position        = UDim2.new(0.5, -(T.window_size.X.Offset/2), 0.5, -(T.window_size.Y.Offset/2))
    Main.BackgroundColor3 = T.bg_deep
    Main.BorderSizePixel = 0
    Main.Visible         = false
    corner(Main, 4)
    stroke(Main, T.border_color, 1, 0)

    -- Dış glow pulse
    local outerGlow = stroke(Main, T.accent_main, 3, 0.75)
    TS:Create(outerGlow,
        TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {Transparency = 0.35}):Play()

    -- Üst kırmızı çizgi
    local topLine = Instance.new("Frame", Main)
    topLine.Size            = UDim2.new(1, 0, 0, 2)
    topLine.BackgroundColor3 = T.accent_glow
    topLine.BorderSizePixel = 0

    -- TopBar
    local TopBar = Instance.new("Frame", Main)
    TopBar.Size            = UDim2.new(1, 0, 0, 28)
    TopBar.Position        = UDim2.new(0, 0, 0, 2)
    TopBar.BackgroundColor3 = T.bg_topbar
    TopBar.BorderSizePixel = 0

    local TitleLbl = Instance.new("TextLabel", TopBar)
    TitleLbl.Text          = title
    TitleLbl.Size          = UDim2.new(0.6, 0, 1, 0)
    TitleLbl.Position      = UDim2.new(0, 14, 0, 0)
    TitleLbl.TextColor3    = T.text_main
    TitleLbl.Font          = Enum.Font.SourceSansBold
    TitleLbl.TextSize      = 13
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    TitleLbl.BackgroundTransparency = 1

    local HintLbl = Instance.new("TextLabel", TopBar)
    HintLbl.Text          = "[" .. hideKey.Name .. "] GİZLE"
    HintLbl.Size          = UDim2.new(0.4, -10, 1, 0)
    HintLbl.Position      = UDim2.new(0.6, 0, 0, 0)
    HintLbl.TextColor3    = T.accent_dim
    HintLbl.Font          = Enum.Font.SourceSans
    HintLbl.TextSize      = 10
    HintLbl.TextXAlignment = Enum.TextXAlignment.Right
    HintLbl.BackgroundTransparency = 1

    -- Sürükleme
    local dragging, dragStart, startPos = false, nil, nil
    TopBar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging  = true
            dragStart = i.Position
            startPos  = Main.Position
        end
    end)
    TopBar.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = i.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X,
                                      startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)

    -- Sidebar
    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size            = UDim2.new(0, T.sidebar_width, 1, -30)
    Sidebar.Position        = UDim2.new(0, 0, 0, 30)
    Sidebar.BackgroundColor3 = T.bg_sidebar
    Sidebar.BorderSizePixel = 0

    local sideEdge = Instance.new("Frame", Sidebar)
    sideEdge.Size            = UDim2.new(0, 1, 1, 0)
    sideEdge.Position        = UDim2.new(1, -1, 0, 0)
    sideEdge.BackgroundColor3 = T.border_color
    sideEdge.BorderSizePixel = 0

    local LogoLbl = Instance.new("TextLabel", Sidebar)
    LogoLbl.Text          = "DRAGO"
    LogoLbl.Size          = UDim2.new(1, 0, 0, 34)
    LogoLbl.Position      = UDim2.new(0, 0, 0, 12)
    LogoLbl.TextColor3    = T.accent_glow
    LogoLbl.Font          = Enum.Font.SourceSansBold
    LogoLbl.TextSize      = 22
    LogoLbl.BackgroundTransparency = 1

    local LogoSub = Instance.new("TextLabel", Sidebar)
    LogoSub.Text          = "ENO  ·  UI LIBRARY"
    LogoSub.Size          = UDim2.new(1, 0, 0, 14)
    LogoSub.Position      = UDim2.new(0, 0, 0, 44)
    LogoSub.TextColor3    = T.accent_dim
    LogoSub.Font          = Enum.Font.SourceSans
    LogoSub.TextSize      = 9
    LogoSub.BackgroundTransparency = 1

    local sideDiv = Instance.new("Frame", Sidebar)
    sideDiv.Size            = UDim2.new(0.7, 0, 0, 1)
    sideDiv.Position        = UDim2.new(0.15, 0, 0, 63)
    sideDiv.BackgroundColor3 = T.border_color
    sideDiv.BorderSizePixel = 0

    local TabBtnContainer = Instance.new("Frame", Sidebar)
    TabBtnContainer.Position = UDim2.new(0, 0, 0, 70)
    TabBtnContainer.Size     = UDim2.new(1, 0, 1, -78)
    TabBtnContainer.BackgroundTransparency = 1
    local TBLayout = Instance.new("UIListLayout", TabBtnContainer)
    TBLayout.Padding = UDim.new(0, 2)

    -- Content
    local Content = Instance.new("Frame", Main)
    Content.Position        = UDim2.new(0, T.sidebar_width + 6, 0, 35)
    Content.Size            = UDim2.new(1, -(T.sidebar_width + 16), 1, -45)
    Content.BackgroundTransparency = 1
    Content.ClipsDescendants = true

    -- Gizle / Göster
    local visible = true
    local conns   = {}

    local ShowBtn = Instance.new("TextButton", gui)
    ShowBtn.Size            = UDim2.new(0, 128, 0, 28)
    ShowBtn.Position        = UDim2.new(0, 12, 0.5, -14)
    ShowBtn.BackgroundColor3 = T.bg_deep
    ShowBtn.Text            = "▶  " .. title
    ShowBtn.TextColor3      = T.accent_glow
    ShowBtn.Font            = Enum.Font.SourceSansBold
    ShowBtn.TextSize        = 11
    ShowBtn.BorderSizePixel = 0
    ShowBtn.Visible         = false
    corner(ShowBtn, 3)
    stroke(ShowBtn, T.accent_main, 1, 0)
    local showGlow = stroke(ShowBtn, T.accent_glow, 2, 0.5)
    TS:Create(showGlow, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {Transparency = 0}):Play()

    local function hide()
        if not visible then return end
        visible = false
        tween(Main, 0.2, {Size = UDim2.new(0, T.window_size.X.Offset, 0, 0)},
            Enum.EasingStyle.Quad, Enum.EasingDirection.In):Play()
        task.delay(0.18, function()
            tween(Main, 0.12, {BackgroundTransparency = 1}):Play()
            task.delay(0.12, function()
                Main.Visible  = false
                ShowBtn.Visible = true
            end)
        end)
    end

    local function show()
        if visible then return end
        visible     = true
        ShowBtn.Visible = false
        Main.Visible  = true
        Main.BackgroundTransparency = 1
        Main.Size     = UDim2.new(0, T.window_size.X.Offset, 0, 10)
        tween(Main, 0.05, {BackgroundTransparency = 0}):Play()
        tween(Main, 0.3, {Size = T.window_size}, Enum.EasingStyle.Back, Enum.EasingDirection.Out):Play()
    end

    ShowBtn.MouseButton1Click:Connect(show)

    table.insert(conns, UIS.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == hideKey then
            if visible then hide() else show() end
        end
        if destroyKey and input.KeyCode == destroyKey then
            tween(Main, 0.3, {BackgroundTransparency = 1,
                Size = UDim2.new(0, 0, 0, 0)}):Play()
            task.delay(0.35, function()
                for _, c in ipairs(conns) do c:Disconnect() end
                gui:Destroy()
            end)
        end
    end))

    -- Window nesnesi
    local Window = {}

    function Window:Destroy()
        tween(Main, 0.3, {BackgroundTransparency = 1,
            Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.delay(0.35, function()
            for _, c in ipairs(conns) do c:Disconnect() end
            gui:Destroy()
        end)
    end

    function Window:Hide() hide() end
    function Window:Show() show() end

    function Window:CreateTab(tabName)
        -- Sayfa
        local Page = Instance.new("ScrollingFrame", Content)
        Page.Size             = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.Visible          = false
        Page.CanvasSize       = UDim2.new(0, 0, 0, 0)
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = T.accent_main
        Page.BorderSizePixel  = 0
        Page.ClipsDescendants = true

        local pageLayout = Instance.new("UIListLayout", Page)
        pageLayout.Padding = UDim.new(0, 6)
        pageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        pageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, pageLayout.AbsoluteContentSize.Y + 10)
        end)

        local pad = Instance.new("UIPadding", Page)
        pad.PaddingTop = UDim.new(0, 6)

        -- Tab butonu
        local TabBtn = Instance.new("TextButton", TabBtnContainer)
        TabBtn.Size            = UDim2.new(1, 0, 0, 36)
        TabBtn.BackgroundColor3 = Color3.fromRGB(12, 0, 0)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text            = ""
        TabBtn.BorderSizePixel = 0

        local TabLbl = Instance.new("TextLabel", TabBtn)
        TabLbl.Text          = "  ▸  " .. tabName
        TabLbl.Size          = UDim2.new(1, 0, 1, 0)
        TabLbl.TextColor3    = T.text_dark
        TabLbl.TextXAlignment = Enum.TextXAlignment.Left
        TabLbl.Font          = Enum.Font.SourceSans
        TabLbl.TextSize      = 13
        TabLbl.BackgroundTransparency = 1

        local GlowLine = Instance.new("Frame", TabBtn)
        GlowLine.Size            = UDim2.new(0, 2, 0.65, 0)
        GlowLine.Position        = UDim2.new(0, 0, 0.175, 0)
        GlowLine.BackgroundColor3 = T.accent_glow
        GlowLine.BorderSizePixel = 0
        GlowLine.Visible         = false

        local glowTw
        local function setActive()
            for _, v in pairs(Content:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            for _, v in pairs(TabBtnContainer:GetChildren()) do
                if v:IsA("TextButton") then
                    tween(v, 0.15, {BackgroundTransparency = 1}):Play()
                    local l = v:FindFirstChildWhichIsA("TextLabel")
                    if l then
                        tween(l, 0.15, {TextColor3 = T.text_dark}):Play()
                        l.Text = "  ▸  " .. l.Text:gsub("^%s*▸%s*", ""):gsub("^%s*▶%s*", "")
                    end
                    local g = v:FindFirstChildWhichIsA("Frame")
                    if g then g.Visible = false end
                end
            end

            Page.Position = UDim2.new(0, 18, 0, 0)
            Page.Visible  = true
            tween(Page, T.transition_speed, {Position = UDim2.new(0, 0, 0, 0)}):Play()
            tween(TabBtn, 0.15, {BackgroundTransparency = 0.85}):Play()
            tween(TabLbl, 0.15, {TextColor3 = T.accent_glow}):Play()
            TabLbl.Text  = "  ▶  " .. tabName
            GlowLine.Visible = true

            if glowTw then glowTw:Cancel() end
            glowTw = TS:Create(GlowLine,
                TweenInfo.new(0.85, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
                {BackgroundColor3 = T.accent_main})
            glowTw:Play()
        end

        TabBtn.MouseEnter:Connect(function()
            if not Page.Visible then
                tween(TabBtn, 0.15, {BackgroundTransparency = 0.92}):Play()
                tween(TabLbl, 0.15, {TextColor3 = Color3.fromRGB(180, 180, 180)}):Play()
            end
        end)
        TabBtn.MouseLeave:Connect(function()
            if not Page.Visible then
                tween(TabBtn, 0.15, {BackgroundTransparency = 1}):Play()
                tween(TabLbl, 0.15, {TextColor3 = T.text_dark}):Play()
            end
        end)
        TabBtn.MouseButton1Click:Connect(setActive)

        -- İlk tab otomatik aktif
        if #TabBtnContainer:GetChildren() <= 2 then
            task.defer(setActive)
        end

        -- Tab API
        local Tab = {}
        local E   = _G.DragoElements

        function Tab:CreateButton(text, cb)     E.CreateButton(Page, text, cb)               end
        function Tab:CreateToggle(text, def, cb) E.CreateToggle(Page, text, def, cb)         end
        function Tab:CreateSlider(text, mn, mx, def, cb) E.CreateSlider(Page, text, mn, mx, def, cb) end
        function Tab:CreateKeybind(text, def, cb) E.CreateKeybind(Page, text, def, cb)       end
        function Tab:CreateDropdown(text, opts, cb) E.CreateDropdown(Page, text, opts, cb)   end
        function Tab:CreateLabel(text)          E.CreateLabel(Page, text)                     end
        function Tab:CreateSeparator()          E.CreateSeparator(Page)                       end

        return Tab
    end

    -- Loading ekranını başlat
    if loadAnim then
        Loading(gui, function()
            Main.Size    = UDim2.new(0, 0, 0, 0)
            Main.Visible = true
            tween(Main, 0.35, {Size = T.window_size},
                Enum.EasingStyle.Back, Enum.EasingDirection.Out):Play()
        end)
    else
        Main.Visible = true
    end

    return Window
end

return Drago