local theme = _G.DragoTheme
local TweenService = game:GetService("TweenService")
local Elements = {}

-- Ortak Kart Yapısı
local function CreateCard(parent, text)
    local card = Instance.new("Frame", parent)
    card.Size = UDim2.new(1, -10, 0, 45)
    card.BackgroundColor3 = theme.bg_element
    card.BorderColor3 = Color3.fromRGB(35, 35, 35)
    card.BorderSizePixel = 1
    
    local label = Instance.new("TextLabel", card)
    label.Text = text
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
    label.TextColor3 = theme.text_dark
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    
    -- Hover Animasyonu
    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2), {BorderColor3 = theme.accent_main}):Play()
    end)
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2), {BorderColor3 = Color3.fromRGB(35, 35, 35)}):Play()
    end)
    
    return card
end

function Elements.CreateButton(parent, text, callback)
    local card = CreateCard(parent, text)
    
    local btn = Instance.new("TextButton", card)
    btn.Size = UDim2.new(0, 100, 0, 28)
    btn.Position = UDim2.new(1, -110, 0.5, -14)
    btn.BackgroundColor3 = theme.accent_main
    btn.Text = "EXECUTE"
    btn.TextColor3 = theme.text_main
    btn.Font = Enum.Font.SourceSansBold
    btn.BorderSizePixel = 0
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 2)

    btn.MouseButton1Click:Connect(function()
        -- Click Efekti
        btn.BackgroundColor3 = theme.accent_glow
        task.wait(0.1)
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = theme.accent_main}):Play()
        callback()
    end)
end

function Elements.CreateKeybind(parent, text, defaultKey, callback)
    local card = CreateCard(parent, text)
    local listening = false
    local currentKey = defaultKey.Name

    local bindBtn = Instance.new("TextButton", card)
    bindBtn.Size = UDim2.new(0, 80, 0, 25)
    bindBtn.Position = UDim2.new(1, -90, 0.5, -12)
    bindBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    bindBtn.Text = currentKey:upper()
    bindBtn.TextColor3 = theme.accent_glow
    bindBtn.BorderColor3 = theme.accent_main
    
    bindBtn.MouseButton1Click:Connect(function()
        listening = true
        bindBtn.Text = "..."
        local connection
        connection = game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                currentKey = input.KeyCode.Name
                bindBtn.Text = currentKey:upper()
                listening = false
                callback(input.KeyCode)
                connection:Disconnect()
            end
        end)
    end)
end

return Elements