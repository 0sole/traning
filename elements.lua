local theme = _G.DragoTheme -- Loader'dan gelecek
local Elements = {}

function Elements.CreateButton(parent, text, callback)
    local btnFrame = Instance.new("Frame")
    btnFrame.Size = UDim2.new(0, 400, 0, 45) --
    btnFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btnFrame.Parent = parent

    local textLabel = Instance.new("TextLabel")
    textLabel.Text = text
    textLabel.Size = UDim2.new(0, 200, 1, 0)
    textLabel.TextColor3 = theme.text_main
    textLabel.BackgroundTransparency = 1
    textLabel.Parent = btnFrame

    local realBtn = Instance.new("TextButton")
    realBtn.Size = UDim2.new(0, 100, 0, 25) --
    realBtn.Position = UDim2.new(0, 280, 0, 10) --
    realBtn.BackgroundColor3 = theme.accent_main
    realBtn.Text = "Click"
    realBtn.Parent = btnFrame

    realBtn.MouseButton1Click:Connect(callback)
end

return Elements
