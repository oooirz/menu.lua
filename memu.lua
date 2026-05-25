local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

if CoreGui:FindFirstChild("Weir") then CoreGui:FindFirstChild("Weir"):Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Weir"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Settings = {
    Aimbot = false,
    Fly = false,
    Ghost = false,
    ESP = false,
    AllView = false
}
local AimOffset = Vector3.new(0, -0.12, 0)
local FlySpeed = 35
local FlyEnabled = false

local AimBox = Instance.new("Frame")
AimBox.Size = UDim2.new(0, 45, 0, 65)
AimBox.BackgroundTransparency = 1
AimBox.Visible = false
AimBox.Parent = ScreenGui
local BoxStroke = Instance.new("UIStroke")
BoxStroke.Color = Color3.new(0,0,0)
BoxStroke.Thickness = 2
BoxStroke.Parent = AimBox

local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Position = UDim2.new(0.5, -20, 0.05, 0)
ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,36)
ToggleBtn.Image = "https://cdn.discordapp.com/attachments/1502986714799411405/1508341040132657212/FB_IMG_1779686816687.jpg?ex=6a152f8f&is=6a13de0f&hm=d425c1d7327ae7bb3886a4f45ed708edcfd789bf51fcab8c886ba460df2a17b2"
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1,0)
Instance.new("UIStroke", ToggleBtn).Color = Color3.fromRGB(212,175,55)
ToggleBtn.Parent = ScreenGui

local MainFrame = Instance.new("Frame")
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.BackgroundColor3 = Color3.fromRGB(18,19,26)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,10)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(32,30,38)
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,30)
Title.Text = "👑 Weir"
Title.TextColor3 = Color3.fromRGB(255,51,119)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

local Dragging, DragStart, StartPos
MainFrame.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = Input.Position
        StartPos = MainFrame.Position
        Input.Changed:Connect(function() if Input.UserInputState == Enum.UserInputState.End then Dragging = false end end)
    end
end)
MainFrame.InputChanged:Connect(function(Input)
    if Dragging then
        local Delta = Input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)
ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local Scrolling = Instance.new("ScrollingFrame")
Scrolling.Position = UDim2.new(0,10,0,50)
Scrolling.Size = UDim2.new(1,-20,1,-85)
Scrolling.BackgroundTransparency = 1
Scrolling.CanvasSize = UDim2.new(0,0,0,260)
Scrolling.ScrollBarThickness = 2
Scrolling.Parent = MainFrame
local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0,6)
ListLayout.Parent = Scrolling

local Status = Instance.new("TextLabel")
Status.Position = UDim2.new(0,10,1,-28)
Status.Size = UDim2.new(1,-20,0,20)
Status.BackgroundColor3 = Color3.fromRGB(10,10,10)
Status.Text = "สถานะ: พร้อมใช้งาน"
Status.TextColor3 = Color3.fromRGB(0,255,204)
Status.TextSize = 10
Status.Font = Enum.Font.Code
Instance.new("UICorner", Status).CornerRadius = UDim.new(0,4)
Status.Parent = MainFrame

local function CreateButton(Name, Key)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1,0,0,35)
    Btn.BackgroundColor3 = Color3.fromRGB(26,27,38)
    Btn.Text = Name
    Btn.TextColor3 = Color3.fromRGB(203,213,225)
    Btn.TextSize = 12
    Btn.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,6)
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(39,41,61)
    Stroke.Parent = Btn
    Btn.Parent = Scrolling

    Btn.MouseButton1Click:Connect(function()
        Settings[Key] = not Settings[Key]
        Stroke.Color = Settings[Key] and Color3.fromRGB(51,166,255) or Color3.fromRGB(39,41,61)
        Btn.BackgroundColor3 = Settings[Key] and Color3.fromRGB(22,42,61) or Color3.fromRGB(26,27,38)
        Status.Text = "สถานะ: "..Name.." -> "..(Settings[Key] and "✅ เปิด" or "❌ ปิด")
    end)
end

CreateButton("🎯 ล็อกหัว", "Aimbot")
CreateButton("✈️ ระบบบิน", "Fly")
CreateButton("👻 หายตัว", "Ghost")
CreateButton("👁️ มองทะลุ", "ESP")
CreateButton("🌍 มองทุกคน", "AllView")

local MobileFlyUI = Instance.new("Frame")
MobileFlyUI.Position = UDim2.new(0.82, 0, 0.2, 0)
MobileFlyUI.Size = UDim2.new(0, 120, 0, 180)
MobileFlyUI.BackgroundTransparency = 0.8
MobileFlyUI.BackgroundColor3 = Color3.new(0,0,0)
MobileFlyUI.Visible = false
MobileFlyUI.Parent = ScreenGui

local FlyToggle = Instance.new("TextButton")
FlyToggle.Size = UDim2.new(1,0,0,40)
FlyToggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
FlyToggle.Text = "🔴 ปิดบิน"
FlyToggle.TextColor3 = Color3.new(1,1,1)
FlyToggle.Font = Enum.Font.GothamBold
FlyToggle.TextSize = 12
Instance.new("UICorner", FlyToggle).CornerRadius = UDim.new(0,8)
FlyToggle.Parent = MobileFlyUI

local FlyUp = Instance.new("TextButton")
FlyUp.Position = UDim2.new(0.25,0,0,50)
FlyUp.Size = UDim2.new(0,60,0,60)
FlyUp.BackgroundColor3 = Color3.fromRGB(0,120,255)
FlyUp.Text = "⬆️"
FlyUp.TextSize = 20
FlyUp.Font = Enum.Font.GothamBold
Instance.new("UICorner", FlyUp).CornerRadius = UDim.new(1,0)
FlyUp.Parent = MobileFlyUI

local FlyDown = Instance.new("TextButton")
FlyDown.Position = UDim2.new(0.25,0,0,120)
FlyDown.Size = UDim2.new(0,60,0,60)
FlyDown.BackgroundColor3 = Color3.fromRGB(255,60,60)
FlyDown.Text = "⬇️"
FlyDown.TextSize = 20
FlyDown.Font = Enum.Font.GothamBold
Instance.new("UICorner", FlyDown).CornerRadius = UDim.new(1,0)
FlyDown.Parent = MobileFlyUI

local function GetBestTarget()
    local Best, Dist = nil, math.huge
    for _, Plr in pairs(Players:GetPlayers()) do
        if Plr ~= LocalPlayer and Plr.Character then
            local Head = Plr.Character:FindFirstChild("Head")
            local Hum = Plr.Character:FindFirstChild("Humanoid")
            if Head and Hum and Hum.Health > 0 then
                local ScreenPos, OnScreen = Camera:WorldToScreenPoint(Head.Position)
                if OnScreen then
                    local Dis = (Vector2.new(ScreenPos.X, ScreenPos.Y) - UIS:GetMouseLocation()).Magnitude
                    if Dis < Dist then
                        Dist = Dis
                        Best = Head
                        AimBox.Visible = true
                        AimBox.Position = UDim2.new(0, ScreenPos.X - 22, 0, ScreenPos.Y - 32)
                    end
                end
            end
        end
    end
    if not Best then AimBox.Visible = false end
    return Best
end

local ESP_Table = {}
local function AddESP(Plr)
    if ESP_Table[Plr] then return end
    local High = Instance.new("Highlight")
    High.Name = "WeirESP"
    High.FillTransparency = 0.6
    High.OutlineTransparency = 0
    High.FillColor = Color3.fromRGB(255,0,0)
    High.OutlineColor = Color3.new(0,0,0)
    High.Adornee = Plr.Character
    High.Parent = Plr.Character
    ESP_Table[Plr] = High
end
local function ClearESP() for _,v in pairs(ESP_Table) do v:Destroy() end table.clear(ESP_Table) end

FlyToggle.MouseButton1Click:Connect(function()
    FlyEnabled = not FlyEnabled
    FlyToggle.Text = FlyEnabled and "🟢 เปิดบิน" or "🔴 ปิดบิน"
    FlyToggle.BackgroundColor3 = FlyEnabled and Color3.fromRGB(0,150,0) or Color3.fromRGB(150,0,0)
end)

RunService.RenderStepped:Connect(function()
    local Char = LocalPlayer.Character
    if not Char then return end
    local Hum = Char:FindFirstChild("Humanoid")
    local Root = Char:FindFirstChild("HumanoidRootPart")
    if not Hum or not Root then return end

    MobileFlyUI.Visible = Settings.Fly

    if Settings.Aimbot then
        local Target = GetBestTarget()
        if Target then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Position + AimOffset)
        end
    end

    if Settings.Fly then
        if FlyEnabled then
            Hum.PlatformStand = true
            Hum.GravityScale = 0
            Hum.JumpPower = 0
            Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            Hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
            Hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)

            local Move = Vector3.new()
            if UIS:IsKeyDown(Enum.KeyCode.W) then Move += Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then Move -= Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then Move -= Camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then Move += Camera.CFrame.RightVector end

            if FlyUp.MouseButton1Down then Move += Vector3.new(0,1,0) end
            if FlyDown.MouseButton1Down then Move -= Vector3.new(0,1,0) end

            Root.Velocity = Move.Magnitude > 0 and Move.Unit * FlySpeed or Vector3.new(0,0,0)
        else
            Hum.PlatformStand = false
            Hum.GravityScale = 1
            Hum.JumpPower = 50
            Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            Hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            Hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
        end
    else
        FlyEnabled = false
        Hum.PlatformStand = false
        Hum.GravityScale = 1
        Hum.JumpPower = 50
        Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
    end

    if Settings.Ghost then
        for _,Obj in pairs(Char:GetDescendants()) do
            if Obj:IsA("BasePart") or Obj:IsA("Decal") then Obj.Transparency = 1 end
        end
        Hum.DisplayType = Enum.HumanoidDisplayType.None
    else
        for _,Obj in pairs(Char:GetDescendants()) do
            if Obj:IsA("BasePart") or Obj:IsA("Decal") then Obj.Transparency = 0 end
        end
        Hum.DisplayType = Enum.HumanoidDisplayType.Default
    end

    if Settings.ESP then
        for _,Plr in pairs(Players:GetPlayers()) do
            if Plr ~= LocalPlayer and Plr.Character then AddESP(Plr) end
        end
    else ClearESP() end

    if Settings.AllView then
        for _,Plr in pairs(Players:GetPlayers()) do
            if Plr ~= LocalPlayer and Plr.Character then
                for _,Part in pairs(Plr.Character:GetDescendants()) do
                    if Part:IsA("BasePart") then Part.LocalTransparencyModifier = 0 end
                end
            end
        end
    end
end)

