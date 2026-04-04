local theme = _G.DragoTheme
local Elements = {}

function Elements.CreateButton(parent, text, callback)
    -- Element Kartı (drago-element-card)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, -10, 0, 45)
    card.BackgroundColor3 = theme.bg_element
    card.BorderSizePixel = 1
    card.BorderColor3 = Color3.fromRGB(42, 0, 0) -- --border-color
    card.Parent = parent

    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 2)

    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.TextColor3 = theme.text_dark
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = card

    -- Drago Button (drago-btn)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 0, 25)
    btn.Position = UDim2.new(1, -110, 0.5, -12)
    btn.BackgroundColor3 = theme.accent_main
    btn.Text = "EXECUTE"
    btn.TextColor3 = theme.text_main
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = card

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 2)

    btn.MouseButton1Click:Connect(function()
        -- HTML'deki :active efekti için küçük bir görsel geri bildirim
        btn.BackgroundColor3 = theme.accent_glow
        task.wait(0.1)
        btn.BackgroundColor3 = theme.accent_main
        callback()
    end)
end

return Elements
