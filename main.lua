local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local Camera=workspace.CurrentCamera
local LP=Players.LocalPlayer

local Aim=false
local ESP=true
local AimPart="Head"
local KillCount=0

local gui=Instance.new("ScreenGui",game.CoreGui)

-- INTRO FULLSCREEN
do
    local intro=Instance.new("TextLabel",gui)
    intro.Size=UDim2.new(1,0,1,0)
    intro.BackgroundColor3=Color3.new(0,0,0)
    intro.TextScaled=true
    intro.Font=Enum.Font.Arcade
    intro.Text="script by : PhucHung\n@kieuphuchung"
    intro.TextColor3=Color3.fromRGB(255,255,255)

    local h=0
    local c
    c=RunService.RenderStepped:Connect(function(dt)
        h=(h+dt)%1
        intro.TextColor3=Color3.fromHSV(h,1,1)
    end)

    task.delay(3,function()
        c:Disconnect()
        intro:Destroy()
    end)
end

-- HUB
local frame=Instance.new("Frame",gui)
frame.Size=UDim2.new(0,240,0,200)
frame.Position=UDim2.new(0,20,0,180)
frame.BackgroundColor3=Color3.fromRGB(25,25,25)
frame.Active=true
frame.Draggable=true
Instance.new("UICorner",frame)

local stroke=Instance.new("UIStroke",frame)
stroke.Thickness=2

-- TITLE
local title=Instance.new("TextLabel",frame)
title.Size=UDim2.new(1,0,0,35)
title.Text="⛏ PhucHung OneTap🔥"
title.TextScaled=true
title.BackgroundTransparency=1
title.Font=Enum.Font.Arcade

-- FREE TEXT
local free=Instance.new("TextLabel",frame)
free.Size=UDim2.new(1,0,0,25)
free.Position=UDim2.new(0,0,0.18,0)
free.BackgroundTransparency=1
free.TextScaled=true
free.Font=Enum.Font.Arcade
free.Text="script này hoàn toàn free ! Không mang bán."

-- CREDIT
local credit=Instance.new("TextLabel",frame)
credit.Size=UDim2.new(1,0,0,25)
credit.Position=UDim2.new(0,0,.85,0)
credit.BackgroundTransparency=1
credit.TextScaled=true
credit.Font=Enum.Font.Arcade
credit.Text="script này của Phúc Hưng , tiktok:@kieuphuchung"

-- BUTTONS
local aimBtn=Instance.new("TextButton",frame)
aimBtn.Size=UDim2.new(.9,0,0,35)
aimBtn.Position=UDim2.new(.05,0,.4,0)
aimBtn.Text="AIM : OFF"
aimBtn.TextScaled=true
aimBtn.Font=Enum.Font.Arcade
Instance.new("UICorner",aimBtn)

local espBtn=Instance.new("TextButton",frame)
espBtn.Size=UDim2.new(.9,0,0,35)
espBtn.Position=UDim2.new(.05,0,.6,0)
espBtn.Text="ESP : ON"
espBtn.TextScaled=true
espBtn.Font=Enum.Font.Arcade
Instance.new("UICorner",espBtn)

aimBtn.MouseButton1Click:Connect(function()
    Aim=not Aim
    aimBtn.Text=Aim and "AIM : ON" or "AIM : OFF"
end)

espBtn.MouseButton1Click:Connect(function()
    ESP=not ESP
    espBtn.Text=ESP and "ESP : ON" or "ESP : OFF"
end)

-- NEAREST
function GetNearest()
    if not LP.Character or not LP.Character:FindFirstChild("HumanoidRootPart") then return end
    local d=math.huge
    local t=nil
    for _,v in pairs(Players:GetPlayers()) do
        if v~=LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local h=v.Character:FindFirstChild("Humanoid")
            if h and h.Health>0 then
                local dist=(LP.Character.HumanoidRootPart.Position-v.Character.HumanoidRootPart.Position).Magnitude
                if dist<d then d=dist t=v end
            end
        end
    end
    return t
end

-- RAINBOW
local hue=0

RunService.RenderStepped:Connect(function(dt)
    hue=(hue+dt)%1
    local col=Color3.fromHSV(hue,1,1)

    stroke.Color=col
    title.TextColor3=col
    free.TextColor3=col
    credit.TextColor3=col

    if Aim then
        local T=GetNearest()
        if T and T.Character and T.Character:FindFirstChild(AimPart) then
            Camera.CFrame=CFrame.new(Camera.CFrame.Position,T.Character[AimPart].Position)
        end
    end
end)
