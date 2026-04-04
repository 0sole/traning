local theme = _G.DragoTheme
local TweenService = game:GetService("TweenService")
local Elements = {}

-- ─────────────────────────────────────────────
-- Yardımcı: Glow Efekti (UIStroke simülasyonu)
-- ─────────────────────────────────────────────
local function AddGlow(obj, color, thickness)
    local stroke = Instance.new("UIStroke", obj)
    stroke.Color = color or theme.accent_glow
    stroke.Thickness = thickness or 1
    stroke.Transparency = 0.6
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return stroke
end

local function PulseGlow(stroke, fast)
    local speed = fast and 0.6 or 1.2
    local function loop()
        TweenService:Create(stroke, TweenInfo.new(speed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
            {Transparency = 0.0}):Play()
    end
    loop()
end

-- ─────────────────────────────────────────────
-- Ortak Kart
-- ─────────────────────────────────────────────
local function CreateCard(parent, text)
    local card = Instance.new("Frame", parent)
    card.Size = UDim2.new(1, -12, 0, 46)
    card.BackgroundColor3 = theme.bg_element
    card.BorderSizePixel = 0
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 3)

    local stroke = AddGlow(card, theme.border_color, 1)
    stroke.Transparency = 0.0

    -- Sol Aksan Çizgisi
    local leftBar = Instance.new("Frame", card)
    leftBar.Size = UDim2.new(0, 2, 0.6, 0)
    leftBar.Position = UDim2.new(0, 0, 0.2, 0)
    leftBar.BackgroundColor3 = theme.accent_dim
    leftBar.BorderSizePixel = 0

    local label = Instance.new("TextLabel", card)
    label.Text = text
    label.Size = UDim2.new(0.55, 0, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.TextColor3 = theme.text_dark
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.SourceSans
    label.TextSize = 13

    -- Hover Animasyonu
    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.18), {BackgroundColor3 = theme.bg_element_h}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.18), {Color = theme.border_glow, Transparency = 0.3}):Play()
        TweenService:Create(leftBar, TweenInfo.new(0.18), {BackgroundColor3 = theme.accent_glow}):Play()
        TweenService:Create(label, TweenInfo.new(0.18), {TextColor3 = theme.text_main}):Play()
    end)
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.25), {BackgroundColor3 = theme.bg_element}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.25), {Color = theme.border_color, Transparency = 0.0}):Play()
        TweenService:Create(leftBar, TweenInfo.new(0.25), {BackgroundColor3 = theme.accent_dim}):Play()
        TweenService:Create(label, TweenInfo.new(0.25), {TextColor3 = theme.text_dark}):Play()
    end)

    return card
end

-- ─────────────────────────────────────────────
-- Button
-- ─────────────────────────────────────────────
function Elements.CreateButton(parent, text, callback)
    local card = CreateCard(parent, text)

    local btn = Instance.new("TextButton", card)
    btn.Size = UDim2.new(0, 88, 0, 26)
    btn.Position = UDim2.new(1, -96, 0.5, -13)
    btn.BackgroundColor3 = theme.accent_main
    btn.Text = "EXECUTE"
    btn.TextColor3 = theme.text_main
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 2)

    -- Glow stroke on button
    local btnStroke = AddGlow(btn, theme.accent_glow, 1)
    btnStroke.Transparency = 0.7

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = theme.accent_glow}):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.15), {Transparency = 0.2}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = theme.accent_main}):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.7}):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        -- Click flash efekti
        TweenService:Create(btn, TweenInfo.new(0.08), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.08), {Transparency = 0.0}):Play()
        task.delay(0.12, function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = theme.accent_main}):Play()
            TweenService:Create(btnStroke, TweenInfo.new(0.2), {Transparency = 0.7}):Play()
        end)
        task.spawn(callback)
    end)
end

-- ─────────────────────────────────────────────
-- Toggle
-- ─────────────────────────────────────────────
function Elements.CreateToggle(parent, text, default, callback)
    local card = CreateCard(parent, text)
    local enabled = default or false

    local track = Instance.new("Frame", card)
    track.Size = UDim2.new(0, 42, 0, 20)
    track.Position = UDim2.new(1, -52, 0.5, -10)
    track.BackgroundColor3 = enabled and theme.accent_main or Color3.fromRGB(30, 30, 30)
    track.BorderSizePixel = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
    local trackStroke = AddGlow(track, theme.accent_glow, 1)
    trackStroke.Transparency = enabled and 0.4 or 1.0

    local knob = Instance.new("Frame", track)
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = enabled and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
    knob.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
    knob.BorderSizePixel = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local function refresh()
        local targetPos = enabled and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
        local targetColor = enabled and theme.accent_main or Color3.fromRGB(30, 30, 30)
        TweenService:Create(knob, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = targetPos}):Play()
        TweenService:Create(track, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
        TweenService:Create(trackStroke, TweenInfo.new(0.2), {Transparency = enabled and 0.4 or 1.0}):Play()
    end

    local clickable = Instance.new("TextButton", card)
    clickable.Size = UDim2.new(1, 0, 1, 0)
    clickable.BackgroundTransparency = 1
    clickable.Text = ""
    clickable.MouseButton1Click:Connect(function()
        enabled = not enabled
        refresh()
        task.spawn(callback, enabled)
    end)
end

-- ─────────────────────────────────────────────
-- Slider
-- ─────────────────────────────────────────────
function Elements.CreateSlider(parent, text, min, max, default, callback)
    local card = CreateCard(parent, text)
    card.Size = UDim2.new(1, -12, 0, 56)

    local valLabel = Instance.new("TextLabel", card)
    valLabel.Size = UDim2.new(0, 40, 0, 16)
    valLabel.Position = UDim2.new(1, -48, 0, 6)
    valLabel.BackgroundTransparency = 1
    valLabel.TextColor3 = theme.accent_glow
    valLabel.Font = Enum.Font.SourceSansBold
    valLabel.TextSize = 12
    valLabel.Text = tostring(default)
    valLabel.TextXAlignment = Enum.TextXAlignment.Right

    local track = Instance.new("Frame", card)
    track.Size = UDim2.new(1, -28, 0, 3)
    track.Position = UDim2.new(0, 14, 0, 36)
    track.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    track.BorderSizePixel = 0
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", track)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = theme.accent_main
    fill.BorderSizePixel = 0
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local handle = Instance.new("Frame", track)
    local pct = (default - min) / (max - min)
    handle.Size = UDim2.new(0, 10, 0, 10)
    handle.Position = UDim2.new(pct, -5, 0.5, -5)
    handle.BackgroundColor3 = theme.accent_glow
    handle.BorderSizePixel = 0
    Instance.new("UICorner", handle).CornerRadius = UDim.new(1, 0)
    AddGlow(handle, theme.accent_glow, 2)

    local dragging = false
    local UIS = game:GetService("UserInputService")

    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local trackAbs = track.AbsolutePosition
            local trackSz  = track.AbsoluteSize
            local rel = math.clamp((i.Position.X - trackAbs.X) / trackSz.X, 0, 1)
            local val = math.floor(min + rel * (max - min))
            fill.Size = UDim2.new(rel, 0, 1, 0)
            handle.Position = UDim2.new(rel, -5, 0.5, -5)
            valLabel.Text = tostring(val)
            task.spawn(callback, val)
        end
    end)
end

-- ─────────────────────────────────────────────
-- Keybind
-- ─────────────────────────────────────────────
function Elements.CreateKeybind(parent, text, defaultKey, callback)
    local card = CreateCard(parent, text)
    local listening = false
    local currentKey = defaultKey.Name

    local bindBtn = Instance.new("TextButton", card)
    bindBtn.Size = UDim2.new(0, 76, 0, 24)
    bindBtn.Position = UDim2.new(1, -84, 0.5, -12)
    bindBtn.BackgroundColor3 = Color3.fromRGB(18, 5, 5)
    bindBtn.Text = "[" .. currentKey:upper() .. "]"
    bindBtn.TextColor3 = theme.accent_glow
    bindBtn.Font = Enum.Font.SourceSansBold
    bindBtn.TextSize = 11
    bindBtn.BorderSizePixel = 0
    Instance.new("UICorner", bindBtn).CornerRadius = UDim.new(0, 2)
    local bStroke = AddGlow(bindBtn, theme.accent_main, 1)

    bindBtn.MouseButton1Click:Connect(function()
        if listening then return end
        listening = true
        bindBtn.Text = "[ ··· ]"
        TweenService:Create(bStroke, TweenInfo.new(0.2), {Color = theme.accent_glow}):Play()

        local conn
        conn = game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.UserInputType == Enum.UserInputType.Keyboard then
                currentKey = input.KeyCode.Name
                bindBtn.Text = "[" .. currentKey:upper() .. "]"
                TweenService:Create(bStroke, TweenInfo.new(0.2), {Color = theme.accent_main}):Play()
                listening = false
                conn:Disconnect()
                task.spawn(callback, input.KeyCode)
            end
        end)
    end)
end

-- ─────────────────────────────────────────────
-- Label / Section
-- ─────────────────────────────────────────────
function Elements.CreateLabel(parent, text)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(1, -12, 0, 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = "  " .. text:upper()
    lbl.TextColor3 = theme.accent_dim
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 10
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

return Elements