local SGui = Instance.new("ScreenGui")
SGui.Name, SGui.ResetOnSpawn = "Weir", false
if game:GetService("CoreGui"):FindFirstChild("Weir") then game:GetService("CoreGui"):FindFirstChild("Weir"):Destroy() end
SGui.Parent = game:GetService("CoreGui")

local Plrs, UIS, RS, WS = game:GetService("Players"), game:GetService("UserInputService"), game:GetService("RunService"), game:GetService("Workspace")
local LP, Cam = Plrs.LocalPlayer, WS.CurrentCamera
local Feat = {Aim=false,Fly=false,Ghost=false,Esp=false,AllView=false}
local AimOff, FlySpd, MaxFlySpd = Vector3.new(0,-0.5,0), 30, 80
local Flying, Velocity = false, Vector3.new()

local AimBox = Instance.new("Frame",SGui)
AimBox.Size, AimBox.BackgroundTransparency = UDim2.new(0,40,0,60), 1
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

local function GetClose()
    local T,D,Pos=nil,math.huge,nil
    for _,P in pairs(Plrs:GetPlayers())do
        if P~=LP and P.Character and P.Character:FindFirstChild("Head")then
            local H=P.Character.Head
            local Torso=P.Character:FindFirstChild("Torso")or P.Character:FindFirstChild("UpperTorso")or H
            local S=Cam:WorldToScreenPoint(Torso.Position)
            if S.Z>0 then
                local M=(Vector2.new(S.X,S.Y)-UIS:GetMouseLocation()).Magnitude
                if M<D then D=M T=H Pos=Vector2.new(S.X,S.Y) end
            end
        end
    end
    if Pos then AimBox.Visible=true AimBox.Position=UDim2.new(0,Pos.X-20,0,Pos.Y-30) else AimBox.Visible=false end
    return T
end

UIS.InputBegan:Connect(function(I,G)
    if G then return end
    if Feat.Fly and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        if I.KeyCode == Enum.KeyCode.Space then FlySpd = MaxFlySpd
        elseif I.KeyCode == Enum.KeyCode.LeftControl then FlySpd = 15
        elseif I.KeyCode == Enum.KeyCode.F then Flying = not Flying
        end
    end
end)
UIS.InputEnded:Connect(function(I)
    if I.KeyCode == Enum.KeyCode.Space or I.KeyCode == Enum.KeyCode.LeftControl then FlySpd = 30
    end
end)

local ESP = {}
local function CreateESP(Plr)
    if ESP[Plr] then return end
    local Container = Instance.new("Folder")
    Container.Name = "Weir_ESP"
    local Box = Instance.new("Highlight")
    Box.Name = "Box"
    Box.FillTransparency = 0.7
    Box.OutlineTransparency = 0
    Box.FillColor = Color3.fromRGB(255, 0, 0)
    Box.OutlineColor = Color3.new(0,0,0)
    Box.Adornee = Plr.Character
    Box.Parent = Container
    local NameTag = Instance.new("TextLabel")
    NameTag.Size = UDim2.new(0, 100, 0, 20)
    NameTag.BackgroundTransparency = 1
    NameTag.TextColor3 = Color3.new(1,1,1)
    NameTag.TextStrokeTransparency = 0.5
    NameTag.Text = Plr.Name.." | "..math.floor((Cam.CFrame.Position - Plr.Character.Head.Position).Magnitude).."m"
    NameTag.Font, NameTag.TextSize = Enum.Font.GothamBold, 12
    NameTag.Parent = Container
    ESP[Plr] = {Container=Container, Box=Box, NameTag=NameTag}
end

local function UpdateESP()
    for Plr, Data in pairs(ESP) do
        if Plr.Character and Plr.Character:FindFirstChild("Head") then
            local Pos = Cam:WorldToScreenPoint(Plr.Character.Head.Position)
            if Pos.Z > 0 then
                Data.NameTag.Visible = true
                Data.NameTag.Position = UDim2.new(0, Pos.X - 50, 0, Pos.Y - 40)
                Data.NameTag.Text = Plr.Name.." | "..math.floor((Cam.CFrame.Position - Plr.Character.Head.Position).Magnitude).."m"
                Data.Box.Adornee = Plr.Character
            else Data.NameTag.Visible = false end
        else Data.Container:Destroy() ESP[Plr] = nil end
    end
end

local function RemoveAllESP() for _,Data in pairs(ESP) do Data.Container:Destroy() end table.clear(ESP) end

RS.RenderStepped:Connect(function()
    local C = LP.Character if not C or not C:FindFirstChild("HumanoidRootPart") then return end
    local Hum, HRP = C.Humanoid, C.HumanoidRootPart
    if Feat.Aimbot then local T=GetClose() if T then Cam.CFrame=CFrame.new(Cam.CFrame.Position,T.Position+AimOff)end end
    if Feat.Fly and Flying then
        Hum.PlatformStand = true
        Hum.GravityScale = 0
        Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
        local Move = Vector3.new()
        if UIS:IsKeyDown(Enum.KeyCode.W) then Move += Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then Move -= Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then Move -= Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then Move += Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then Move += Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then Move -= Vector3.new(0,1,0) end
        HRP.Velocity = Move.Magnitude > 0 and Move.Unit * FlySpd or Vector3.new(0,0,0)
    else
        Hum.PlatformStand = false
        Hum.GravityScale = 1
        Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
    end
    if Feat.Ghost then
        for _,P in pairs(C:GetDescendants())do if P:IsA("BasePart")or P:IsA("Decal")then P.Transparency=1 end end
        Hum.DisplayType=Enum.HumanoidDisplayType.None
    else
        for _,P in pairs(C:GetDescendants())do if P:IsA("BasePart")or P:IsA("Decal")then P.Transparency=0 end end
        Hum.DisplayType=Enum.HumanoidDisplayType.Default
    end
    if Feat.Esp then
        for _,P in pairs(Plrs:GetPlayers())do if P~=LP and P.Character and not ESP[P] then CreateESP(P)end end
        UpdateESP()
    end
    if Feat.AllView then
        for _,P in pairs(Plrs:GetPlayers())do
            if P~=LP and P.Character then
                P.Character.Head.Transparency = 0
                P.Character.Head.CanCollide = false
                for _,Part in pairs(P.Character:GetChildren())do if Part:IsA("BasePart")then Part.LocalTransparencyModifier = 0 end end
            end
        end
    end
    if not Feat.Esp then RemoveAllESP() end
end)

