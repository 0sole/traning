local Library = getgenv().Library or {}
local CoreGui = game:GetService('CoreGui')

-- İtem listesi
local Items = {
    {
        Name = "Goggles",
        Description = "Parlayan gözlük",
        Icon = "🕶️",
        Glow = true,
        Color = Color3.fromRGB(0, 150, 255)
    }
}

-- Ana GUI çerçevesi
local MainFrame = Instance.new('Frame')
MainFrame.Name = "MenuFrame"
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Library.BackgroundColor or Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Library.OutlineColor or Color3.fromRGB(50, 50, 50)
MainFrame.Parent = Library.ScreenGui or CoreGui:WaitForChild('RobloxGui')

-- Sol panel (Items başlığı)
local LeftPanel = Instance.new('Frame')
LeftPanel.Name = "LeftPanel"
LeftPanel.Size = UDim2.new(0, 150, 1, 0)
LeftPanel.BackgroundColor3 = Library.MainColor or Color3.fromRGB(28, 28, 28)
LeftPanel.BorderSizePixel = 0
LeftPanel.Parent = MainFrame

-- "Items" başlığı
local ItemsLabel = Instance.new('TextLabel')
ItemsLabel.Name = "ItemsLabel"
ItemsLabel.Size = UDim2.new(1, 0, 0, 40)
ItemsLabel.BackgroundColor3 = Library.AccentColor or Color3.fromRGB(0, 85, 255)
ItemsLabel.TextColor3 = Library.FontColor or Color3.fromRGB(255, 255, 255)
ItemsLabel.TextSize = 16
ItemsLabel.Font = Library.Font or Enum.Font.Code
ItemsLabel.Text = "Items"
ItemsLabel.BorderSizePixel = 0
ItemsLabel.Parent = LeftPanel

-- Sağ panel (İtem listesi)
local RightPanel = Instance.new('Frame')
RightPanel.Name = "RightPanel"
RightPanel.Size = UDim2.new(1, -150, 1, 0)
RightPanel.Position = UDim2.new(0, 150, 0, 0)
RightPanel.BackgroundColor3 = Library.BackgroundColor or Color3.fromRGB(20, 20, 20)
RightPanel.BorderSizePixel = 0
RightPanel.Parent = MainFrame

-- ScrollingFrame for items
local ItemsContainer = Instance.new('ScrollingFrame')
ItemsContainer.Name = "ItemsContainer"
ItemsContainer.Size = UDim2.new(1, -10, 1, -50)
ItemsContainer.Position = UDim2.new(0, 5, 0, 40)
ItemsContainer.BackgroundTransparency = 1
ItemsContainer.BorderSizePixel = 0
ItemsContainer.ScrollBarThickness = 8
ItemsContainer.Parent = RightPanel

-- İtemler ekle
for index, item in ipairs(Items) do
    local ItemFrame = Instance.new('Frame')
    ItemFrame.Name = item.Name .. "Frame"
    ItemFrame.Size = UDim2.new(1, -10, 0, 70)
    ItemFrame.Position = UDim2.new(0, 5, 0, (index - 1) * 75)
    ItemFrame.BackgroundColor3 = item.Glow and item.Color or (Library.MainColor or Color3.fromRGB(28, 28, 28))
    ItemFrame.BorderColor3 = item.Glow and item.Color or (Library.OutlineColor or Color3.fromRGB(50, 50, 50))
    ItemFrame.BorderSizePixel = 2
    ItemFrame.Parent = ItemsContainer
    
    -- Işıltı efekti (Glow)
    if item.Glow then
        local UICorner = Instance.new('UICorner')
        UICorner.CornerRadius = UDim.new(0, 8)
        UICorner.Parent = ItemFrame
    end
    
    -- İtem başlığı
    local ItemTitle = Instance.new('TextLabel')
    ItemTitle.Name = "ItemTitle"
    ItemTitle.Size = UDim2.new(1, -10, 0, 25)
    ItemTitle.Position = UDim2.new(0, 5, 0, 5)
    ItemTitle.BackgroundTransparency = 1
    ItemTitle.TextColor3 = Library.FontColor or Color3.fromRGB(255, 255, 255)
    ItemTitle.TextSize = 14
    ItemTitle.Font = Library.Font or Enum.Font.Code
    ItemTitle.Text = item.Icon .. " " .. item.Name
    ItemTitle.TextXAlignment = Enum.TextXAlignment.Left
    ItemTitle.Parent = ItemFrame
    
    -- Açma butonu (Open Button - sağ tarafta)
    local OpenButton = Instance.new('TextButton')
    OpenButton.Name = "OpenButton"
    OpenButton.Size = UDim2.new(0, 50, 0, 25)
    OpenButton.Position = UDim2.new(1, -60, 0, 5)
    OpenButton.BackgroundColor3 = Library.AccentColor or Color3.fromRGB(0, 85, 255)
    OpenButton.TextColor3 = Library.FontColor or Color3.fromRGB(255, 255, 255)
    OpenButton.TextSize = 12
    OpenButton.Font = Library.Font or Enum.Font.Code
    OpenButton.Text = "Aç"
    OpenButton.BorderSizePixel = 0
    OpenButton.Parent = ItemFrame
    
    -- Tanım
    local ItemDesc = Instance.new('TextLabel')
    ItemDesc.Name = "ItemDesc"
    ItemDesc.Size = UDim2.new(1, -10, 0, 35)
    ItemDesc.Position = UDim2.new(0, 5, 0, 30)
    ItemDesc.BackgroundTransparency = 1
    ItemDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
    ItemDesc.TextSize = 11
    ItemDesc.Font = Library.Font or Enum.Font.Code
    ItemDesc.Text = item.Description
    ItemDesc.TextWrapped = true
    ItemDesc.TextXAlignment = Enum.TextXAlignment.Left
    ItemDesc.TextYAlignment = Enum.TextYAlignment.Top
    ItemDesc.Parent = ItemFrame
    
    -- Buton tıklanma olayı
    OpenButton.MouseButton1Click:Connect(function()
        print("Açılıyor: " .. item.Name)
    end)
end

-- ScrollingFrame boyutunu güncelle
ItemsContainer.CanvasSize = UDim2.new(0, 0, 0, #Items * 75)

-- Kapatma butonu (sağ üst köşe)
local CloseButton = Instance.new('TextButton')
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Library.FontColor or Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Library.Font or Enum.Font.Code
CloseButton.Text = "✕"
CloseButton.BorderSizePixel = 0
CloseButton.Parent = RightPanel

CloseButton.MouseButton1Click:Connect(function()
    MainFrame:Destroy()
end)

return {}