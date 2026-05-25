local SGui = Instance.new("ScreenGui")
SGui.Name, SGui.ResetOnSpawn = "Nuvex", false
if game:GetService("CoreGui"):FindFirstChild("Nuvex") then game:GetService("CoreGui"):FindFirstChild("Nuvex"):Destroy() end
SGui.Parent = game:GetService("CoreGui")

local Plrs, UIS, RS, WS = game:GetService("Players"), game:GetService("UserInputService"), game:GetService("RunService"), game:GetService("Workspace")
local LP, Cam = Plrs.LocalPlayer, WS.CurrentCamera
local Feat = {Aim=false,Fly=false,Ghost=false,Esp=false}
local AimOff, FlySpd = Vector3.new(0,-0.5,0), 25

local Btn = Instance.new("ImageButton",SGui)
Btn.Position, Btn.Size, Btn.BackgroundColor3, Btn.Image = UDim2.new(0.5,-20,0.05,0), UDim2.new(0,40,0,40), Color3.fromRGB(30,30,36), "rbxassetid://13444458514"
Instance.new("UICorner",Btn).CornerRadius=UDim.new(1,0)
local BS=Instance.new("UIStroke",Btn)BS.Color,BS.Thickness=Color3.fromRGB(212,175,55),2

local Main=Instance.new("Frame",SGui)
Main.Position,Main.Size,Main.BackgroundColor3=UDim2.new(0.5,-150,0.5,-150),UDim2.new(0,300,0,350),Color3.fromRGB(18,19,26)
Instance.new("UICorner",Main).CornerRadius=UDim.new(0,10)
local MS=Instance.new("UIStroke",Main)MS.Color=Color3.fromRGB(32,30,38)

local Title=Instance.new("TextLabel",Main)
Title.Size,Title.Text,Title.TextColor3,Title.TextSize,Title.Font,Title.BackgroundTransparency=UDim2.new(1,0,0,30),"👑 ไซเบอร์ นูเวกซ์",Color3.fromRGB(255,51,119),16,Enum.Font.SourceSansBold,1

local drag,dS,startP
Main.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then drag=true startP=i.Position dS=Main.Position i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then drag=false end end)end end)
Main.InputChanged:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then if drag then local d=i.Position-startP Main.Position=UDim2.new(dS.X.Scale,dS.X.Offset+d.X,dS.Y.Scale,dS.Y.Offset+d.Y)end end end)
Btn.MouseButton1Click:Connect(function()Main.Visible=not Main.Visible end)

local Scr=Instance.new("ScrollingFrame",Main)
Scr.Position,Scr.Size,Scr.BackgroundTransparency,Scr.CanvasSize,Scr.ScrollBarThickness=UDim2.new(0,10,0,50),UDim2.new(1,-20,1,-85),1,UDim2.new(0,0,0,220),2
local Lay=Instance.new("UIListLayout",Scr)Lay.Padding=UDim.new(0,6)

local Status=Instance.new("TextLabel",Main)
Status.Position,Status.Size,Status.BackgroundColor3,Status.Text,Status.TextColor3,Status.TextSize,Status.Font=UDim2.new(0,10,1,-28),UDim2.new(1,-20,0,20),Color3.fromRGB(10,10,10),"สถานะ: พร้อมใช้งาน",Color3.fromRGB(0,255,204),10,Enum.Font.Code
Instance.new("UICorner",Status).CornerRadius=UDim.new(0,4)

local function AddBtn(Name,Key)local B=Instance.new("TextButton",Scr)B.Size=UDim2.new(1,0,0,35)B.BackgroundColor3=Color3.fromRGB(26,27,38)B.Text=Name B.TextColor3=Color3.fromRGB(203,213,225)B.TextSize=12 B.Font=Enum.Font.SourceSansBold Instance.new("UICorner",B).CornerRadius=UDim.new(0,6)local S=Instance.new("UIStroke",B)S.Color=Color3.fromRGB(39,41,61)B.MouseButton1Click:Connect(function()Feat[Key]=not Feat[Key]S.Color=Feat[Key]and Color3.fromRGB(51,166,255)or Color3.fromRGB(39,41,61)B.BackgroundColor3=Feat[Key]and Color3.fromRGB(22,42,61)or Color3.fromRGB(26,27,38)Status.Text="สถานะ: "..Name.." -> "..(Feat[Key]and"✅ เปิด"or"❌ ปิด")end)end

AddBtn("🎯 ล็อกหัว","Aimbot")
AddBtn("✈️ บิน","Fly")
AddBtn("👻 หายตัว","Ghost")
AddBtn("👁️ มองทะลุ","Esp")

local function GetClose()local T,D=nil,math.huge for _,P in pairs(Plrs:GetPlayers())do if P~=LP and P.Character and P.Character:FindFirstChild("Head")then local S=Cam:WorldToScreenPoint(P.Character.Head.Position)if S.Z>0 then local M=(Vector2.new(S.X,S.Y)-UIS:GetMouseLocation()).Magnitude if M<D then D=M T=P.Character.Head end end end end return T end

UIS.InputBegan:Connect(function(I,G)if G then return end if Feat.Fly and LP.Character and LP.Character:FindFirstChild("Humanoid")then if I.KeyCode==Enum.KeyCode.Space then FlySpd=50 elseif I.KeyCode==Enum.KeyCode.LeftControl then FlySpd=10 end end end)
UIS.InputEnded:Connect(function(I)if I.KeyCode==Enum.KeyCode.Space or I.KeyCode==Enum.KeyCode.LeftControl then FlySpd=25 end end)

local ESP={}
local function SetESP(M)if ESP[M]then return end local H=Instance.new("Highlight")H.Name="NuvexESP"H.FillTransparency=0.5 H.OutlineTransparency=0 H.FillColor=Color3.fromRGB(255,0,85)H.OutlineColor=Color3.fromRGB(255,255,255)H.Adornee=M H.Parent=M ESP[M]=H end
local function DelESP(M)if ESP[M]then ESP[M]:Destroy()ESP[M]=nil end end

RS.RenderStepped:Connect(function()local C=LP.Character if not C or not C:FindFirstChild("HumanoidRootPart")then return end local H=C.Humanoid if Feat.Aimbot then local T=GetClose()if T then Cam.CFrame=CFrame.new(Cam.CFrame.Position,T.Position+AimOff)end end if Feat.Fly then H.PlatformStand=true H:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)H:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)H:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)local D=Vector3.new()if UIS:IsKeyDown(Enum.KeyCode.W)then D+=Cam.CFrame.LookVector end if UIS:IsKeyDown(Enum.KeyCode.S)then D-=Cam.CFrame.LookVector end if UIS:IsKeyDown(Enum.KeyCode.A)then D-=Cam.CFrame.RightVector end if UIS:IsKeyDown(Enum.KeyCode.D)then D+=Cam.CFrame.RightVector end if UIS:IsKeyDown(Enum.KeyCode.Space)then D+=Vector3.new(0,1,0)end if UIS:IsKeyDown(Enum.KeyCode.LeftControl)then D-=Vector3.new(0,1,0)end C.HumanoidRootPart.Velocity=D.Magnitude>0 and D.Unit*FlySpd or Vector3.new(0,0,0)else H.PlatformStand=false H:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)H:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)H:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)end if Feat.Ghost then for _,P in pairs(C:GetDescendants())do if P:IsA("BasePart")or P:IsA("Decal")then P.Transparency=1 end end H.DisplayType=Enum.HumanoidDisplayType.None else for _,P in pairs(C:GetDescendants())do if P:IsA("BasePart")or P:IsA("Decal")then P.Transparency=0 end end H.DisplayType=Enum.HumanoidDisplayType.Default end if Feat.Esp then for _,P in pairs(Plrs:GetPlayers())do if P~=LP and P.Character then SetESP(P.Character)end end else for K in pairs(ESP)do DelESP(K)end end end)

