local SGui = Instance.new("ScreenGui")
SGui.Name, SGui.ResetOnSpawn = "Weir", false
if game:GetService("CoreGui"):FindFirstChild("Weir") then game:GetService("CoreGui"):FindFirstChild("Weir"):Destroy() end
SGui.Parent = game:GetService("CoreGui")

local Plrs, UIS, RS, WS = game:GetService("Players"), game:GetService("UserInputService"), game:GetService("RunService"), game:GetService("Workspace")
local LP, Cam = Plrs.LocalPlayer, WS.CurrentCamera
local Feat = {Aim=false,Fly=false,Ghost=false,Esp=false,AllView=false}
local AimOffset = Vector3.new(0, -0.15, 0)
local FlySpeed = 30
local CanFly = false

local AimBox = Instance.new("Frame",SGui)
AimBox.Size, AimBox.BackgroundTransparency = UDim2.new(0, 45, 0, 65), 1
local BoxStroke = Instance.new("UIStroke",AimBox)
BoxStroke.Color, BoxStroke.Thickness = Color3.new(0,0,0), 2
AimBox.Visible = false

local Btn = Instance.new("ImageButton",SGui)
Btn.Position, Btn.Size, Btn.BackgroundColor3 = UDim2.new(0.5,-20,0.05,0), UDim2.new(0,40,0,40), Color3.fromRGB(30,30,36)
Btn.Image = "https://cdn.discordapp.com/attachments/1502986714799411405/1508341040132657212/FB_IMG_1779686816687.jpg?ex=6a152f8f&is=6a13de0f&hm=d425c1d7327ae7bb3886a4f45ed708edcfd789bf51fcab8c886ba460df2a17b2"
Instance.new("UICorner",Btn).CornerRadius=UDim.new(1,0)
local BS=Instance.new("UIStroke",Btn)BS.Color,BS.Thickness=Color3.fromRGB(212,175,55),2

local Main=Instance.new("Frame",SGui)
Main.Position,Main.Size,Main.BackgroundColor3=UDim2.new(0.5,-150,0.5,-150),UDim2.new(0,300,0,350),Color3.fromRGB(18,19,26)
Instance.new("UICorner",Main).CornerRadius=UDim.new(0,10)
local MS=Instance.new("UIStroke",Main)MS.Color=Color3.fromRGB(32,30,38)

local Title=Instance.new("TextLabel",Main)
Title.Size,Title.Text,Title.TextColor3,Title.TextSize,Title.Font,Title.BackgroundTransparency=UDim2.new(1,0,0,30),"👑 Weir",Color3.fromRGB(255,51,119),16,Enum.Font.SourceSansBold,1

local drag,dS,startP
Main.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=true startP=i.Position dS=Main.Position i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then drag=false end end)end end)
Main.InputChanged:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then if drag then local d=i.Position-startP Main.Position=UDim2.new(dS.X.Scale,dS.X.Offset+d.X,dS.Y.Scale,dS.Y.Offset+d.Y)end end end)
Btn.MouseButton1Click:Connect(function()Main.Visible=not Main.Visible end)

local Scr=Instance.new("ScrollingFrame",Main)
Scr.Position,Scr.Size,Scr.BackgroundTransparency,Scr.CanvasSize,Scr.ScrollBarThickness=UDim2.new(0,10,0,50),UDim2.new(1,-20,1,-85),1,UDim2.new(0,0,0,260),2
local Lay=Instance.new("UIListLayout",Scr)Lay.Padding=UDim.new(0,6)

local Status=Instance.new("TextLabel",Main)
Status.Position,Status.Size,Status.BackgroundColor3,Status.Text,Status.TextColor3,Status.TextSize,Status.Font=UDim2.new(0,10,1,-28),UDim2.new(1,-20,0,20),Color3.fromRGB(10,10,10),"สถานะ: พร้อมใช้งาน",Color3.fromRGB(0,255,204),10,Enum.Font.Code
Instance.new("UICorner",Status).CornerRadius=UDim.new(0,4)

local function AddBtn(Name,Key)local B=Instance.new("TextButton",Scr)B.Size=UDim2.new(1,0,0,35)B.BackgroundColor3=Color3.fromRGB(26,27,38)B.Text=Name B.TextColor3=Color3.fromRGB(203,213,225)B.TextSize=12 B.Font=Enum.Font.SourceSansBold Instance.new("UICorner",B).CornerRadius=UDim.new(0,6)local S=Instance.new("UIStroke",B)S.Color=Color3.fromRGB(39,41,61)B.MouseButton1Click:Connect(function()Feat[Key]=not Feat[Key]S.Color=Feat[Key]and Color3.fromRGB(51,166,255)or Color3.fromRGB(39,41,61)B.BackgroundColor3=Feat[Key]and Color3.fromRGB(22,42,61)or Color3.fromRGB(26,27,38)Status.Text="สถานะ: "..Name.." -> "..(Feat[Key]and"✅ เปิด"or"❌ ปิด")end)end

AddBtn("🎯 ล็อกหัว","Aimbot")
AddBtn("✈️ ระบบบิน","Fly")
AddBtn("👻 หายตัว","Ghost")
AddBtn("👁️ มองทะลุ","Esp")
AddBtn("🌍 มองทุกคน","AllView")

local function GetClosestPlayer()
    local BestTarget, MinDistance = nil, math.huge
    for _, Plr in pairs(Plrs:GetPlayers()) do
        if Plr ~= LP and Plr.Character then
            local Head = Plr.Character:FindFirstChild("Head")
            local Root = Plr.Character:FindFirstChild("HumanoidRootPart")
            local Hum = Plr.Character:FindFirstChild("Humanoid")
            if Head and Root and Hum and Hum.Health > 0 then
                local ScreenPos, Visible = Cam:WorldToScreenPoint(Head.Position)
                if Visible then
                    local DistanceToMouse = (Vector2.new(ScreenPos.X, ScreenPos.Y) - UIS:GetMouseLocation()).Magnitude
                    if DistanceToMouse < MinDistance then
                        MinDistance = DistanceToMouse
                        BestTarget = Head
                        AimBox.Visible = true
                        AimBox.Position = UDim2.new(0, ScreenPos.X - 22, 0, ScreenPos.Y - 32)
                    end
                end
            end
        end
    end
    if not BestTarget then AimBox.Visible = false end
    return BestTarget
end

UIS.InputBegan:Connect(function(I,G)
    if G then return end
    if I.KeyCode == Enum.KeyCode.F and Feat.Fly then CanFly = not CanFly end
    if Feat.Fly and CanFly then
        if I.KeyCode == Enum.KeyCode.Space then FlySpeed = 55
        elseif I.KeyCode == Enum.KeyCode.LeftControl then FlySpeed = 12
        end
    end
end)
UIS.InputEnded:Connect(function(I)
    if I.KeyCode == Enum.KeyCode.Space or I.KeyCode == Enum.KeyCode.LeftControl then FlySpeed = 30 end
end)

local ESP = {}
local function CreateESP(Plr)
    if ESP[Plr] then return end
    local H = Instance.new("Highlight")
    H.Name = "Weir_ESP"
    H.FillTransparency = 0.6
    H.OutlineTransparency = 0
    H.FillColor = Color3.fromRGB(255, 0, 0)
    H.OutlineColor = Color3.new(0,0,0)
    H.Adornee = Plr.Character
    H.Parent = Plr.Character
    ESP[Plr] = H
end
local function ClearESP() for _,v in pairs(ESP) do v:Destroy() end table.clear(ESP) end

RS.RenderStepped:Connect(function()
    local Char = LP.Character
    if not Char then return end
    local Hum = Char:FindFirstChild("Humanoid")
    local Root = Char:FindFirstChild("HumanoidRootPart")
    if not Hum or not Root then return end

    if Feat.Aimbot then
        local Target = GetClosestPlayer()
        if Target then
            Cam.CFrame = CFrame.new(Cam.CFrame.Position, Target.Position + AimOffset)
        end
    end

    if Feat.Fly then
        if CanFly then
            Hum.PlatformStand = true
            Hum.GravityScale = 0
            Hum.JumpPower = 0
            Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            Hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
            Hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
            local MoveDir = Vector3.new()
            if UIS:IsKeyDown(Enum.KeyCode.W) then MoveDir += Cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then MoveDir -= Cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then MoveDir -= Cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then MoveDir += Cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then MoveDir += Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then MoveDir -= Vector3.new(0,1,0) end
            Root.Velocity = MoveDir.Magnitude > 0 and MoveDir.Unit * FlySpeed or Vector3.new(0,0,0)
        else
            Hum.PlatformStand = false
            Hum.GravityScale = 1
            Hum.JumpPower = 50
            Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            Hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            Hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
        end
    else
        CanFly = false
        Hum.PlatformStand = false
        Hum.GravityScale = 1
        Hum.JumpPower = 50
        Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
    end

    if Feat.Ghost then
        for _,P in pairs(Char:GetDescendants())do if P:IsA("BasePart")or P:IsA("Decal")then P.Transparency=1 end end
        Hum.DisplayType=Enum.HumanoidDisplayType.None
    else
        for _,P in pairs(Char:GetDescendants())do if P:IsA("BasePart")or P:IsA("Decal")then P.Transparency=0 end end
        Hum.DisplayType=Enum.HumanoidDisplayType.Default
    end

    if Feat.Esp then for _,P in pairs(Plrs:GetPlayers())do if P~=LP and P.Character then CreateESP(P)end end else ClearESP() end

    if Feat.AllView then
        for _,P in pairs(Plrs:GetPlayers())do if P~=LP and P.Character then for _,Part in pairs(P.Character:GetDescendants())do if Part:IsA("BasePart")then Part.LocalTransparencyModifier=0 end end end end
    end
end)

