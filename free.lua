--[[
    VORTEX-LUNA RED  –  My Market Full Loader
    Discord : https://discord.gg/PrmHmDfT
]]

--// 0. Services
local Players      = game:GetService("Players")
local Replicated   = game:GetService("ReplicatedStorage")
local Workspace    = game:GetService("Workspace")
local RunService   = game:GetService("RunService")
local UIS          = game:GetService("UserInputService")
local Tween        = game:GetService("TweenService")
local CoreGui      = game:GetService("CoreGui")

local LP = Players.LocalPlayer
local Character = LP.Character or LP.CharacterAdded:Wait()
local Humanoid  = Character:WaitForChild("Humanoid")

-------------------------------------------------
-- 1.  Anti-kick & Bypass
-------------------------------------------------
local mt = getrawmetatable(game)
setreadonly(mt,false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self,...)
    local method = getnamecallmethod()
    if method:lower() == "kick" then return end
    return old(self,...)
end)

-------------------------------------------------
-- 2.  Remote Cache Builder
-------------------------------------------------
local Rem = {}
for _,v in pairs(Replicated:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        Rem[v.Name:lower()] = v
    end
end

-------------------------------------------------
-- 3.  UI Luna-Style
-------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "VortexLuna"
gui.Parent = CoreGui
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 480, 0, 260)
main.Position = UDim2.new(0.5, -240, 0.5, -130)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
main.AnchorPoint = Vector2.new(0.5,0.5)
main.Parent = gui
Instance.new("UICorner",main).CornerRadius = UDim.new(0,12)

-- shadow
local shad = Instance.new("ImageLabel")
shad.Image = "rbxassetid://13116647614"
shad.Size = UDim2.new(1,24,1,24)
shad.Position = UDim2.new(0,-12,0,-12)
shad.ImageColor3 = Color3.fromRGB(255,40,40)
shad.ImageTransparency = .7
shad.BackgroundTransparency = 1
shad.ScaleType = Enum.ScaleType.Slice
shad.SliceCenter = Rect.new(24,24,152,152)
shad.ZIndex = -1
shad.Parent = main

-- header
local head = Instance.new("Frame")
head.Size = UDim2.new(1,0,0,42)
head.BackgroundColor3 = Color3.fromRGB(35,35,35)
head.BorderSizePixel = 0
head.Parent = main
Instance.new("UICorner",head).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-40,1,0)
title.Position = UDim2.new(0,12,0,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "VORTEX-LUNA RED"
title.TextColor3 = Color3.fromRGB(255,40,40)
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = head

local close = Instance.new("TextButton")
close.Size = UDim2.new(0,32,0,32)
close.Position = UDim2.new(1,-38,0.5,-16)
close.BackgroundTransparency = 1
close.Font = Enum.Font.SourceSans
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255,255,255)
close.TextSize = 18
close.Parent = head
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-- drag
local dragging, startPos, startMouse
head.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startPos = main.Position
        startMouse = inp.Position
        inp.Changed:Connect(function()
            if inp.UserInputState == Enum.UserInputState.End then dragging=false end
        end)
    end
end)
UIS.InputChanged:Connect(function(inp)
    if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = inp.Position - startMouse
        main.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,
                                  startPos.Y.Scale,startPos.Y.Offset+delta.Y)
    end
end)

-------------------------------------------------
-- 4.  Grid Toggle Builder
-------------------------------------------------
local grid = Instance.new("Frame")
grid.Size = UDim2.new(1,-12,1,-54)
grid.Position = UDim2.new(0,6,0,48)
grid.BackgroundTransparency = 1
grid.Parent = main

local lay = Instance.new("UIGridLayout")
lay.CellSize = UDim2.new(0,220,0,46)
lay.CellPadding = UDim.new(0,8)
lay.Parent = grid

-------------------------------------------------
-- 5.  Toggle Functions
-------------------------------------------------
local function addToggle(name, iconId, callback)
    local card = Instance.new("Frame")
    card.BackgroundColor3 = Color3.fromRGB(30,30,30)
    card.BorderSizePixel = 0
    card.Parent = grid
    Instance.new("UICorner",card).CornerRadius = UDim.new(0,8)

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0,22,0,22)
    icon.Position = UDim2.new(0,8,0.5,-11)
    icon.Image = "rbxassetid://"..iconId
    icon.BackgroundTransparency = 1
    icon.Parent = card

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1,-70,1,0)
    txt.Position = UDim2.new(0,36,0,0)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.Gotham
    txt.Text = name
    txt.TextColor3 = Color3.fromRGB(255,255,255)
    txt.TextSize = 14
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.Parent = card

    local sw = Instance.new("TextButton")
    sw.Size = UDim2.new(0,48,0,24)
    sw.Position = UDim2.new(1,-54,0.5,-12)
    sw.BackgroundColor3 = Color3.fromRGB(60,60,60)
    sw.BorderSizePixel = 0
    sw.Text = ""
    sw.Parent = card
    Instance.new("UICorner",sw).CornerRadius = UDim.new(0,12)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0,20,0,20)
    knob.Position = UDim2.new(0,2,0.5,-10)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BorderSizePixel = 0
    knob.Parent = sw
    Instance.new("UICorner",knob).CornerRadius = UDim.new(0,10)

    local on = false
    sw.MouseButton1Click:Connect(function()
        on = not on
        Tween:Create(knob,TweenInfo.new(.2),{Position = on and UDim2.new(1,-22,0.5,-10) or UDim2.new(0,2,0.5,-10)}):Play()
        Tween:Create(sw,TweenInfo.new(.2),{BackgroundColor3 = on and Color3.fromRGB(255,40,40) or Color3.fromRGB(60,60,60)}):Play()
        callback(on)
    end)

    -- mini preview on icon click
    icon.MouseButton1Click:Connect(function()
        local prev = Instance.new("ImageLabel")
        prev.Size = UDim2.new(0,64,0,64)
        prev.Position = UDim2.new(0.5,-32,0.5,-32)
        prev.Image = icon.Image
        prev.BackgroundTransparency = 1
        prev.ZIndex = 10
        prev.Parent = card
        Tween:Create(prev,TweenInfo.new(.2),{Size = UDim2.new(0,0,0,0)}):Play()
        task.wait(.2)
        prev:Destroy()
    end)
end

-------------------------------------------------
-- 6.  Daftar Toggle + fungsi
-------------------------------------------------
local function toggleESP(on)
    for _,plr in pairs(Players:GetPlayers()) do
        if plr~=LP and plr.Character then
            local head = plr.Character:FindFirstChild("Head")
            if head then
                if on then
                    local b = Instance.new("BillboardGui")
                    b.Adornee = head
                    b.Size = UDim2.new(0,200,0,50)
                    b.AlwaysOnTop = true
                    b.Parent = head
                    local l = Instance.new("TextLabel")
                    l.Size = UDim2.new(1,0,1,0)
                    l.BackgroundTransparency = 1
                    l.Text = plr.Name
                    l.TextColor3 = Color3.new(1,0,0)
                    l.Font = Enum.Font.SourceSansBold
                    l.TextSize = 14
                    l.Parent = b
                else
                    for _,v in ipairs(head:GetChildren()) do
                        if v:IsA("BillboardGui") then v:Destroy() end
                    end
                end
            end
        end
    end
end

local function toggleFly(on)
    Humanoid.WalkSpeed = on and 100 or 16
    Humanoid.JumpPower = on and 100 or 50
end

local function toggleNoClip(on)
    while on and task.wait() do
        for _,v in ipairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end

local function toggleAutoCrate(on)
    while on do
        if Rem.opencrate then Rem.opencrate:FireServer() end
        task.wait(0.1)
    end
end

local function toggleInfMoney(on)
    if on and Rem.setmoney then Rem.setmoney:FireServer(9e9) end
end

local function toggle500Luck(on)
    if on and Rem.setluck then Rem.setluck:FireServer(500) end
end

local function toggle500Money(on)
    if on and Rem.setmultiplier then Rem.setmultiplier:FireServer(500) end
end

local function toggleAutoCollect(on)
    while on do
        for _,v in ipairs(workspace:GetDescendants()) do
            if v.Name:lower():find("money") then
                firetouchinterest(Character:FindFirstChild("HumanoidRootPart"), v, 0)
            end
        end
        task.wait(0.2)
    end
end

local function toggleAutoTrade(on)
    while on do
        if Rem.autotrade then Rem.autotrade:FireServer() end
        task.wait(3)
    end
end

-------------------------------------------------
-- 7.  Populate toggles
-------------------------------------------------
addToggle("Auto Crate",    6031075931, toggleAutoCrate)
addToggle("ESP",           6031280882, toggleESP)
addToggle("Fly / Speed",   6031225810, toggleFly)
addToggle("NoClip",        6035056483, toggleNoClip)
addToggle("∞ Money",       6034767619, toggleInfMoney)
addToggle("500× Luck",     6031225810, toggle500Luck)
addToggle("500× Money",    6034767619, toggle500Money)
addToggle("Auto Collect",  6031075931, toggleAutoCollect)
addToggle("Auto Trade",    6035056483, toggleAutoTrade)

-------------------------------------------------
-- 8.  Auto-center on resize
-------------------------------------------------
game:GetService("RunService").RenderStepped:Connect(function()
    main.Position = UDim2.new(0.5, -main.AbsoluteSize.X/2, 0.5, -main.AbsoluteSize.Y/2)
end)

print("✅ VORTEX-LUNA RED loaded – My Market ready")
