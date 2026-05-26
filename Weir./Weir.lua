local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("CyberNuvexClean") then
    CoreGui:FindFirstChild("CyberNuvexClean"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CyberNuvexClean"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- วงกลมแสดงขอบเขตการมองเห็น
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

-- เมนูหลัก
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.Position = UDim2.new(0.5, -135, 0.5, -70)
MainFrame.Size = UDim2.new(0, 270, 0, 200) -- เพิ่มขนาดเพื่อใส่เมนูล็อกเป้า
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 14, 20)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(255, 51, 119)
MainStroke.Thickness = 1.5

local ToggleMenuBtn = Instance.new("TextButton")
ToggleMenuBtn.Name = "ToggleMenuBtn"
ToggleMenuBtn.Parent = ScreenGui
ToggleMenuBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleMenuBtn.Size = UDim2.new(0, 50, 0, 30)
ToggleMenuBtn.BackgroundColor3 = Color3.fromRGB(13, 14, 20)
ToggleMenuBtn.Text = "เมนู"
ToggleMenuBtn.TextColor3 = Color3.fromRGB(255, 51, 119)
ToggleMenuBtn.TextSize = 12
ToggleMenuBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", ToggleMenuBtn).CornerRadius = UDim.new(0, 6)
local BtnStroke = Instance.new("UIStroke", ToggleMenuBtn)
BtnStroke.Color = Color3.fromRGB(255, 51, 119)
BtnStroke.Thickness = 1

ToggleMenuBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 32)
Title.Text = "📱 ระบบวงกลมช่วยเล็ง + ล็อกเป้า"
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

-- ปุ่มเปิด/ปิด แสดงวงกลม FOV
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

-- ช่องปรับขนาด FOV
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
    if num and num > 0 then
        FOVCircle.Size = UDim2.new(0, num, 0, num)
        FOVSize = num -- อัปเดตค่าขนาดสำหรับระบบล็อกเป้า
    end
end)

-- ==========================================
-- ✅ ส่วนเพิ่มเติม: ระบบล็อกเป้า
-- ==========================================

-- ตัวแปรควบคุมระบบ
local AimEnabled = false
local AimSpeed = 0.15 -- ความนุ่มนวล (ยิ่งน้อยยิ่งไว, ยิ่งมากยิ่งนุ่ม)
local AimPart = "Head" -- จุดล็อกเป้า: Head, UpperTorso, HumanoidRootPart
local FOVSize = 140 -- ขนาดขอบเขตเริ่มต้น
local LockedTarget = nil

-- ปุ่มเปิด/ปิด ระบบล็อกเป้า
local AimToggleBtn = Instance.new("TextButton", Container)
AimToggleBtn.Size = UDim2.new(1, 0, 0, 42)
AimToggleBtn.BackgroundColor3 = Color3.fromRGB(22, 23, 33)
AimToggleBtn.Text = "  ❌ เปิดใช้งานล็อกเป้า"
AimToggleBtn.TextColor3 = Color3.fromRGB(170, 170, 180)
AimToggleBtn.TextSize = 12
AimToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
AimToggleBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", AimToggleBtn).CornerRadius = UDim.new(0, 6)

local AimStroke = Instance.new("UIStroke", AimToggleBtn)
AimStroke.Color = Color3.fromRGB(40, 40, 50)

AimToggleBtn.MouseButton1Click:Connect(function()
    AimEnabled = not AimEnabled
    if AimEnabled then
        AimToggleBtn.Text = "  ✅ เปิดใช้งานล็อกเป้า"
        AimToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        AimToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 60, 40)
        AimStroke.Color = Color3.fromRGB(50, 200, 100)
    else
        AimToggleBtn.Text = "  ❌ เปิดใช้งานล็อกเป้า"
        AimToggleBtn.TextColor3 = Color3.fromRGB(170, 170, 180)
        AimToggleBtn.BackgroundColor3 = Color3.fromRGB(22, 23, 33)
        AimStroke.Color = Color3.fromRGB(40, 40, 50)
        LockedTarget = nil -- เคลียร์เป้าเมื่อปิดระบบ
    end
end)

-- ฟังก์ชันหาเป้าหมายที่ใกล้ที่สุดในขอบเขต FOV
local function GetClosestTarget()
    local ClosestPlayer = nil
    local ShortestDistance = math.huge
    local CenterScreen = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, Plr in pairs(Players:GetPlayers()) do
        if Plr ~= LocalPlayer and Plr.Character and Plr.Character:FindFirstChild(AimPart) and Plr.Character:FindFirstChild("Humanoid") and Plr.Character.Humanoid.Health > 0 then
            local PartPos, OnScreen = Camera:WorldToViewportPoint(Plr.Character[AimPart].Position)
            if OnScreen then
                local Distance = (Vector2.new(PartPos.X, PartPos.Y) - CenterScreen).Magnitude
                if Distance < ShortestDistance and Distance <= FOVSize / 2 then
                    ShortestDistance = Distance
                    ClosestPlayer = Plr.Character
                end
            end
        end
    end
    return ClosestPlayer
end

-- ฟังก์ชันเล็งเป้าหมาย
RunService.RenderStepped:Connect(function()
    if not AimEnabled then return end

    -- กดเมาส์ซ้ายเพื่อล็อกเป้า (ปรับปุ่มได้ตามใจชอบ)
    if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        if not LockedTarget then
            LockedTarget = GetClosestTarget()
        end

        if LockedTarget and LockedTarget:FindFirstChild(AimPart) then
            local TargetPos = LockedTarget[AimPart].Position
            local CameraCFrame = Camera.CFrame
            local AimCFrame = CFrame.new(CameraCFrame.Position, TargetPos)
            
            -- ปรับความนุ่มนวล
            Camera.CFrame = Camera.CFrame:Lerp(AimCFrame, AimSpeed)
        end
    else
        LockedTarget = nil -- ปลดล็อกเมื่อปล่อยเมาส์
    end
end)

-- ==========================================
-- ส่วนลากเมนูเหมือนเดิม
-- ==========================================
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

local btnDragging, btnDragStart, btnStartPos
ToggleMenuBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = true btnDragStart = input.Position btnStartPos = ToggleMenuBtn.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then btnDragging = false end end)
    end
end)
UIS.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and btnDragging then
        local delta = input.Position - btnDragStart
        ToggleMenuBtn.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
    end
end)
