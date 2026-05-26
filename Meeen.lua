local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

if CoreGui:FindFirstChild("CyberNuvexClean") then
    CoreGui:FindFirstChild("CyberNuvexClean"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CyberNuvexClean"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local FOVCircle = Instance.new("Frame")
FOVCircle.Name = "VisualFOVCircle"
FOVCircle.Parent = ScreenGui
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
FOVCircle.Size = UDim2.new(0, 140, 0, 140)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Visible = false

local FOVStroke = Instance.new("UIStroke", FOVCircle)
FOVStroke.Color = Color3.fromRGB(255, 255, 255)
FOVStroke.Thickness = 1.5
Instance.new("UICorner", FOVCircle).CornerRadius = UDim.new(1, 0)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Position = UDim2.new(0.5, -135, 0.5, -70)
MainFrame.Size = UDim2.new(0, 270, 0, 140)
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 14, 20)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 51, 119)
MainStroke.Thickness = 1.5

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 32)
Title.Text = "📱 ระบบวงกลมช่วยเล็ง"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12
Title.Font = Enum.Font.SourceSansBold
Title.BackgroundTransparency = 1

local Container = Instance.new("Frame", MainFrame)
Container.Position = UDim2.new(0, 10, 0, 36)
Container.Size = UDim2.new(1, -20, 1, -46)
Container.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Container)
Layout.Padding = UDim.new(0, 6)

local ToggleBtn = Instance.new("TextButton", Container)
ToggleBtn.Size = UDim2.new(1, 0, 0, 42)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(22, 23, 33)
ToggleBtn.Text = "  ❌ แสดงวงกลมเล็งเป้า (FOV)"
ToggleBtn.TextColor3 = Color3.fromRGB(170, 170, 180)
ToggleBtn.TextSize = 12
ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
ToggleBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

local TglStroke = Instance.new("UIStroke", ToggleBtn)
TglStroke.Color = Color3.fromRGB(40, 40, 50)

local isOn = false
ToggleBtn.MouseButton1Click:Connect(function()
    isOn = not isOn
    FOVCircle.Visible = isOn
    if isOn then
        ToggleBtn.Text = "  ✅ แสดงวงกลมเล็งเป้า (FOV)"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 18, 32)
        TglStroke.Color = Color3.fromRGB(255, 51, 119)
    else
        ToggleBtn.Text = "  ❌ แสดงวงกลมเล็งเป้า (FOV)"
        ToggleBtn.TextColor3 = Color3.fromRGB(170, 170, 180)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(22, 23, 33)
        TglStroke.Color = Color3.fromRGB(40, 40, 50)
    end
end)

local InputFrame = Instance.new("Frame", Container)
InputFrame.Size = UDim2.new(1, 0, 0, 42)
InputFrame.BackgroundColor3 = Color3.fromRGB(22, 23, 33)
Instance.new("UICorner", InputFrame).CornerRadius = UDim.new(0, 6)

local Label = Instance.new("TextLabel", InputFrame)
Label.Size = UDim2.new(1, -80, 1, 0)
Label.Position = UDim2.new(0, 10, 0, 0)
Label.Text = "ปรับขนาดรัศมีวงกลม"
Label.TextColor3 = Color3.fromRGB(180, 180, 190)
Label.TextSize = 11
Label.Font = Enum.Font.SourceSansBold
Label.TextXAlignment = Enum.TextXAlignment.Left
Label.BackgroundTransparency = 1

local Box = Instance.new("TextBox", InputFrame)
Box.Position = UDim2.new(1, -70, 0.5, -12)
Box.Size = UDim2.new(0, 60, 0, 24)
Box.BackgroundColor3 = Color3.fromRGB(13, 14, 20)
Box.Text = ""
Box.PlaceholderText = "140"
Box.TextColor3 = Color3.fromRGB(255, 255, 255)
Box.TextSize = 12
Box.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)

local BoxStroke = Instance.new("UIStroke", Box)
BoxStroke.Color = Color3.fromRGB(50, 50, 60)

Box.FocusLost:Connect(function()
    local num = tonumber(Box.Text)
    if num then
        FOVCircle.Size = UDim2.new(0, num, 0, num)
    end
end)

local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true dragStart = input.Position startPos = MainFrame.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

