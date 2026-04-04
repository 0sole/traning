local T   = _G.DragoTheme
local TS  = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local E   = {}

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
    s.Color       = color or T.border_color
    s.Thickness   = thick or 1
    s.Transparency = trans or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return s
end

-- ── Ortak Kart ───────────────────────────────────────────────────────────────

local function Card(parent, text, height)
    local card = Instance.new("Frame", parent)
    card.Size            = UDim2.new(1, -12, 0, height or 46)
    card.BackgroundColor3 = T.bg_element
    card.BorderSizePixel = 0
    corner(card, 3)
    local s = stroke(card, T.border_color, 1, 0)

    local bar = Instance.new("Frame", card)
    bar.Size            = UDim2.new(0, 2, 0.6, 0)
    bar.Position        = UDim2.new(0, 0, 0.2, 0)
    bar.BackgroundColor3 = T.accent_dim
    bar.BorderSizePixel = 0

    local lbl = Instance.new("TextLabel", card)
    lbl.Text             = text
    lbl.Size             = UDim2.new(0.55, 0, 1, 0)
    lbl.Position         = UDim2.new(0, 14, 0, 0)
    lbl.TextColor3       = T.text_dark
    lbl.TextXAlignment   = Enum.TextXAlignment.Left
    lbl.BackgroundTransparency = 1
    lbl.Font             = Enum.Font.SourceSans
    lbl.TextSize         = 13

    card.MouseEnter:Connect(function()
        tween(card, 0.15, {BackgroundColor3 = T.bg_element_h}):Play()
        tween(s,    0.15, {Color = T.border_glow, Transparency = 0.3}):Play()
        tween(bar,  0.15, {BackgroundColor3 = T.accent_glow}):Play()
        tween(lbl,  0.15, {TextColor3 = T.text_main}):Play()
    end)
    card.MouseLeave:Connect(function()
        tween(card, 0.2, {BackgroundColor3 = T.bg_element}):Play()
        tween(s,    0.2, {Color = T.border_color, Transparency = 0}):Play()
        tween(bar,  0.2, {BackgroundColor3 = T.accent_dim}):Play()
        tween(lbl,  0.2, {TextColor3 = T.text_dark}):Play()
    end)

    return card
end

-- ── Button ───────────────────────────────────────────────────────────────────

function E.CreateButton(parent, text, callback)
    local card = Card(parent, text)

    local btn = Instance.new("TextButton", card)
    btn.Size            = UDim2.new(0, 88, 0, 26)
    btn.Position        = UDim2.new(1, -96, 0.5, -13)
    btn.BackgroundColor3 = T.accent_main
    btn.Text            = "EXECUTE"
    btn.TextColor3      = T.text_main
    btn.Font            = Enum.Font.SourceSansBold
    btn.TextSize        = 11
    btn.BorderSizePixel = 0
    corner(btn, 2)
    local bs = stroke(btn, T.accent_glow, 1, 0.7)

    btn.MouseEnter:Connect(function()
        tween(btn, 0.15, {BackgroundColor3 = T.accent_glow}):Play()
        tween(bs,  0.15, {Transparency = 0.2}):Play()
    end)
    btn.MouseLeave:Connect(function()
        tween(btn, 0.2, {BackgroundColor3 = T.accent_main}):Play()
        tween(bs,  0.2, {Transparency = 0.7}):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        tween(btn, 0.08, {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
        task.delay(0.15, function()
            tween(btn, 0.2, {BackgroundColor3 = T.accent_main}):Play()
        end)
        task.spawn(callback)
    end)
end

-- ── Toggle ───────────────────────────────────────────────────────────────────

function E.CreateToggle(parent, text, default, callback)
    local card    = Card(parent, text)
    local enabled = default or false

    local track = Instance.new("Frame", card)
    track.Size            = UDim2.new(0, 42, 0, 20)
    track.Position        = UDim2.new(1, -52, 0.5, -10)
    track.BackgroundColor3 = enabled and T.accent_main or Color3.fromRGB(30, 30, 30)
    track.BorderSizePixel = 0
    corner(track, 10)
    local ts = stroke(track, T.accent_glow, 1, enabled and 0.4 or 1)

    local knob = Instance.new("Frame", track)
    knob.Size            = UDim2.new(0, 14, 0, 14)
    knob.Position        = enabled and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    knob.BorderSizePixel = 0
    corner(knob, 7)

    local function refresh()
        tween(knob,  0.2, {Position = enabled and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7)}):Play()
        tween(track, 0.2, {BackgroundColor3 = enabled and T.accent_main or Color3.fromRGB(30,30,30)}):Play()
        tween(ts,    0.2, {Transparency = enabled and 0.4 or 1}):Play()
    end

    local hit = Instance.new("TextButton", card)
    hit.Size               = UDim2.new(1, 0, 1, 0)
    hit.BackgroundTransparency = 1
    hit.Text               = ""
    hit.MouseButton1Click:Connect(function()
        enabled = not enabled
        refresh()
        task.spawn(callback, enabled)
    end)
end

-- ── Slider ───────────────────────────────────────────────────────────────────

function E.CreateSlider(parent, text, min, max, default, callback)
    local card = Card(parent, text, 58)

    local valLbl = Instance.new("TextLabel", card)
    valLbl.Size            = UDim2.new(0, 40, 0, 16)
    valLbl.Position        = UDim2.new(1, -48, 0, 6)
    valLbl.BackgroundTransparency = 1
    valLbl.TextColor3      = T.accent_glow
    valLbl.Font            = Enum.Font.SourceSansBold
    valLbl.TextSize        = 12
    valLbl.Text            = tostring(default)
    valLbl.TextXAlignment  = Enum.TextXAlignment.Right

    local track = Instance.new("Frame", card)
    track.Size            = UDim2.new(1, -28, 0, 3)
    track.Position        = UDim2.new(0, 14, 0, 38)
    track.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    track.BorderSizePixel = 0
    corner(track, 2)

    local fill = Instance.new("Frame", track)
    fill.Size            = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = T.accent_main
    fill.BorderSizePixel = 0
    corner(fill, 2)

    local handle = Instance.new("Frame", track)
    local pct0   = (default - min) / (max - min)
    handle.Size            = UDim2.new(0, 10, 0, 10)
    handle.Position        = UDim2.new(pct0, -5, 0.5, -5)
    handle.BackgroundColor3 = T.accent_glow
    handle.BorderSizePixel = 0
    corner(handle, 5)
    stroke(handle, T.accent_glow, 2, 0.3)

    local dragging = false
    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local abs = track.AbsolutePosition
            local sz  = track.AbsoluteSize
            local rel = math.clamp((i.Position.X - abs.X) / sz.X, 0, 1)
            local val = math.floor(min + rel * (max - min))
            fill.Size     = UDim2.new(rel, 0, 1, 0)
            handle.Position = UDim2.new(rel, -5, 0.5, -5)
            valLbl.Text   = tostring(val)
            task.spawn(callback, val)
        end
    end)
end

-- ── Keybind ──────────────────────────────────────────────────────────────────

function E.CreateKeybind(parent, text, defaultKey, callback)
    local card      = Card(parent, text)
    local listening = false
    local curKey    = defaultKey.Name

    local btn = Instance.new("TextButton", card)
    btn.Size            = UDim2.new(0, 76, 0, 24)
    btn.Position        = UDim2.new(1, -84, 0.5, -12)
    btn.BackgroundColor3 = Color3.fromRGB(18, 5, 5)
    btn.Text            = "[" .. curKey:upper() .. "]"
    btn.TextColor3      = T.accent_glow
    btn.Font            = Enum.Font.SourceSansBold
    btn.TextSize        = 11
    btn.BorderSizePixel = 0
    corner(btn, 2)
    local bs = stroke(btn, T.accent_main, 1, 0)

    btn.MouseButton1Click:Connect(function()
        if listening then return end
        listening = true
        btn.Text  = "[ · · · ]"
        tween(bs, 0.2, {Color = T.accent_glow}):Play()

        local conn
        conn = UIS.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.UserInputType == Enum.UserInputType.Keyboard then
                curKey   = input.KeyCode.Name
                btn.Text = "[" .. curKey:upper() .. "]"
                tween(bs, 0.2, {Color = T.accent_main}):Play()
                listening = false
                conn:Disconnect()
                task.spawn(callback, input.KeyCode)
            end
        end)
    end)
end

-- ── Dropdown ─────────────────────────────────────────────────────────────────

function E.CreateDropdown(parent, text, options, callback)
    local card   = Card(parent, text)
    local open   = false
    local chosen = options[1] or "Select"

    local selBtn = Instance.new("TextButton", card)
    selBtn.Size            = UDim2.new(0, 110, 0, 26)
    selBtn.Position        = UDim2.new(1, -118, 0.5, -13)
    selBtn.BackgroundColor3 = Color3.fromRGB(18, 5, 5)
    selBtn.Text            = chosen .. "  ▾"
    selBtn.TextColor3      = T.accent_glow
    selBtn.Font            = Enum.Font.SourceSans
    selBtn.TextSize        = 11
    selBtn.BorderSizePixel = 0
    corner(selBtn, 2)
    stroke(selBtn, T.accent_main, 1, 0)

    -- Dropdown listesi (parent frame içinde aşağı açılır)
    local list = Instance.new("Frame", card)
    list.Size            = UDim2.new(0, 110, 0, 0)
    list.Position        = UDim2.new(1, -118, 1, 2)
    list.BackgroundColor3 = Color3.fromRGB(12, 3, 3)
    list.BorderSizePixel = 0
    list.ClipsDescendants = true
    list.ZIndex          = 10
    corner(list, 3)
    stroke(list, T.accent_main, 1, 0)

    local listLayout = Instance.new("UIListLayout", list)
    listLayout.Padding = UDim.new(0, 1)

    for _, opt in ipairs(options) do
        local optBtn = Instance.new("TextButton", list)
        optBtn.Size            = UDim2.new(1, 0, 0, 26)
        optBtn.BackgroundColor3 = Color3.fromRGB(16, 4, 4)
        optBtn.Text            = opt
        optBtn.TextColor3      = T.text_dark
        optBtn.Font            = Enum.Font.SourceSans
        optBtn.TextSize        = 11
        optBtn.BorderSizePixel = 0
        optBtn.ZIndex          = 11

        optBtn.MouseEnter:Connect(function()
            tween(optBtn, 0.1, {BackgroundColor3 = Color3.fromRGB(30, 8, 8), TextColor3 = T.accent_glow}):Play()
        end)
        optBtn.MouseLeave:Connect(function()
            tween(optBtn, 0.1, {BackgroundColor3 = Color3.fromRGB(16, 4, 4), TextColor3 = T.text_dark}):Play()
        end)
        optBtn.MouseButton1Click:Connect(function()
            chosen       = opt
            selBtn.Text  = opt .. "  ▾"
            open         = false
            tween(list, 0.2, {Size = UDim2.new(0, 110, 0, 0)}):Play()
            task.spawn(callback, opt)
        end)
    end

    selBtn.MouseButton1Click:Connect(function()
        open = not open
        local targetH = open and (#options * 27) or 0
        tween(list, 0.2, {Size = UDim2.new(0, 110, 0, targetH)}):Play()
    end)
end

-- ── Label / Section ──────────────────────────────────────────────────────────

function E.CreateLabel(parent, text)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size               = UDim2.new(1, -12, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text               = "  " .. text:upper()
    lbl.TextColor3         = T.accent_dim
    lbl.Font               = Enum.Font.SourceSansBold
    lbl.TextSize           = 10
    lbl.TextXAlignment     = Enum.TextXAlignment.Left
end

-- ── Separator ────────────────────────────────────────────────────────────────

function E.CreateSeparator(parent)
    local sep = Instance.new("Frame", parent)
    sep.Size            = UDim2.new(1, -12, 0, 1)
    sep.BackgroundColor3 = T.border_color
    sep.BorderSizePixel = 0
end

return E