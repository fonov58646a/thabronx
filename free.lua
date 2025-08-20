--[[
    VORTX HUB v4.0 – My Market
    Transparan glass, cinematic intro, full toggles
    Discord: https://discord.gg/PrmHmDfT
]]

--// Services
local Players   = game:GetService("Players")
local Tween     = game:GetService("TweenService")
local CoreGui   = game:GetService("CoreGui")
local UIS       = game:GetService("UserInputService")
local Replicated= game:GetService("ReplicatedStorage")
local Run       = game:GetService("RunService")

local LP = Players.LocalPlayer
local Character = LP.Character or LP.CharacterAdded:Wait()
local Humanoid  = Character:WaitForChild("Humanoid")

-------------------------------------------------
-- 1.  Anti-kick
-------------------------------------------------
local mt = getrawmetatable(game)
setreadonly(mt,false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(...)
    if getnamecallmethod():lower()=="kick" then return end
    return old(...)
end)

-------------------------------------------------
-- 2.  Remote Cache
-------------------------------------------------
local Rem = {}
for _,v in pairs(Replicated:GetDescendants()) do
    if v:IsA("RemoteEvent") then Rem[v.Name:lower()] = v end
end

-------------------------------------------------
-- 3.  Cinematic Intro (V O R T X)
-------------------------------------------------
local intro = Instance.new("ScreenGui")
intro.Name = "VORTXIntro"
intro.Parent = CoreGui
intro.ResetOnSpawn = false

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
bg.BackgroundTransparency = 0
bg.Parent = intro

local txt = Instance.new("TextLabel")
txt.Size = UDim2.new(0, 400, 0, 120)
txt.Position = UDim2.new(0.5, -200, 0.5, -60)
txt.BackgroundTransparency = 1
txt.Font = Enum.Font.GothamBold
txt.Text = ""
txt.TextColor3 = Color3.fromRGB(255,40,40)
txt.TextSize = 96
txt.Parent = bg

local word = "VORTX"
for i = 1, #word do
    txt.Text = word:sub(1, i) .. " "
    task.wait(0.3)
end
task.wait(0.7)
Tween:Create(bg, TweenInfo.new(0.7), {BackgroundTransparency = 1}):Play()
task.wait(0.7)
intro:Destroy()

-------------------------------------------------
-- 4.  Main UI (Glass + Transparan)
-------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "VORTXHub"
gui.Parent = CoreGui
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 640, 0, 440)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BackgroundTransparency = 0.25
main.BorderSizePixel = 0
main.Parent = gui
Instance.new("UICorner",main).CornerRadius = UDim.new(0,20)

-- blur behind
local blur = Instance.new("ImageLabel")
blur.Image = "rbxassetid://13116647614"
blur.Size = UDim2.new(1,40,1,40)
blur.Position = UDim2.new(0,-20,0,-20)
blur.ImageColor3 = Color3.fromRGB(255,40,40)
blur.ImageTransparency = 0.85
blur.BackgroundTransparency = 1
blur.ScaleType = Enum.ScaleType.Slice
blur.SliceCenter = Rect.new(24,24,152,152)
blur.ZIndex = -1
blur.Parent = main

-------------------------------------------------
-- 5.  Header Penuh Gambar + Info
-------------------------------------------------
local head = Instance.new("Frame")
head.Size = UDim2.new(1,0,0,120)
head.BackgroundColor3 = Color3.fromRGB(30,30,30)
head.BackgroundTransparency = 0.4
head.BorderSizePixel = 0
head.Parent = main
Instance.new("UICorner",head).CornerRadius = UDim.new(0,20)

local headImg = Instance.new("ImageLabel")
headImg.Size = UDim2.new(1,0,1,0)
headImg.Image = "rbxassetid://13116647614"
headImg.ImageColor3 = Color3.fromRGB(255,40,40)
headImg.ImageTransparency = 0.6
headImg.ScaleType = Enum.ScaleType.Crop
headImg.Parent = head

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-20,0,40)
title.Position = UDim2.new(0,10,0,10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "VORTX HUB"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextSize = 28
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = head

local desc = Instance.new("TextLabel")
desc.Size = UDim2.new(1,-20,0,60)
desc.Position = UDim2.new(0,10,0,50)
desc.BackgroundTransparency = 1
desc.Font = Enum.Font.Gotham
desc.Text = "Modern glass UI for My Market.\nToggle features below."
desc.TextColor3 = Color3.fromRGB(220,220,220)
desc.TextSize = 14
desc.TextWrapped = true
desc.TextXAlignment = Enum.TextXAlignment.Left
desc.Parent = head

local close = Instance.new("TextButton")
close.Size = UDim2.new(0,36,0,36)
close.Position = UDim2.new(1,-46,0.5,-18)
close.BackgroundTransparency = 1
close.Font = Enum.Font.SourceSans
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255,255,255)
close.TextSize = 24
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
-- 6.  Grid Toggle
-------------------------------------------------
local grid = Instance.new("Frame")
grid.Size = UDim2.new(1,-24,1,-144)
grid.Position = UDim2.new(0,12,0,132)
grid.BackgroundTransparency = 1
grid.Parent = main

local lay = Instance.new("UIGridLayout")
lay.CellSize = UDim2.new(0,290,0,60)
lay.CellPadding = UDim.new(0,12)
lay.Parent = grid

local function addToggle(name, iconId, callback)
    local card = Instance.new("Frame")
    card.BackgroundColor3 = Color3.fromRGB(35,35,35)
    card.BackgroundTransparency = 0.3
    card.BorderSizePixel = 0
    card.Parent = grid
    Instance.new("UICorner",card).CornerRadius = UDim.new(0,16)

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0,28,0,28)
    icon.Position = UDim2.new(0,12,0.5,-14)
    icon.Image = "rbxassetid://"..iconId
    icon.BackgroundTransparency = 1
    icon.Parent = card

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1,-90,1,0)
    txt.Position = UDim2.new(0,48,0,0)
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.Gotham
    txt.Text = name
    txt.TextColor3 = Color3.fromRGB(255,255,255)
    txt.TextSize = 16
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.Parent = card

    local sw = Instance.new("TextButton")
    sw.Size = UDim2.new(0,52,0,26)
    sw.Position = UDim2.new(1,-64,0.5,-13)
    sw.BackgroundColor3 = Color3.fromRGB(70,70,70)
    sw.BorderSizePixel = 0
    sw.Text = ""
    sw.Parent = card
    Instance.new("UICorner",sw).CornerRadius = UDim.new(0,13)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0,22,0,22)
    knob.Position = UDim2.new(0,2,0.5,-11)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BorderSizePixel = 0
    knob.Parent = sw
    Instance.new("UICorner",knob).CornerRadius = UDim.new(0,11)

    local on = false
    sw.MouseButton1Click:Connect(function()
        on = not on
        Tween:Create(knob,TweenInfo.new(.2),{Position = on and UDim2.new(1,-24,0.5,-11) or UDim2.new(0,2,0.5,-11)}):Play()
        Tween:Create(sw,TweenInfo.new(.2),{BackgroundColor3 = on and Color3.fromRGB(255,40,40) or Color3.fromRGB(70,70,70)}):Play()
        callback(on)
    end)

    -- mini preview
    icon.MouseButton1Click:Connect(function()
        local prev = Instance.new("ImageLabel")
        prev.Size = UDim2.new(0,80,0,80)
        prev.Position = UDim2.new(0.5,-40,0.5,-40)
        prev.Image = icon.Image
        prev.BackgroundTransparency = 1
        prev.ZIndex = 10
        prev.Parent = card
        Tween:Create(prev,TweenInfo.new(.25),{Size = UDim2.new(0,0,0,0)}):Play()
        task.wait(.25)
        prev:Destroy()
    end)
end

-------------------------------------------------
-- 7.  Toggle Functions
-------------------------------------------------
local function toggleESP(on)
    for _,plr in ipairs(Players:GetPlayers()) do
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
    Humanoid.WalkSpeed = on and 120 or 16
    Humanoid.JumpPower = on and 120 or 50
end

local function toggleNoClip(on)
    while on do
        for _,v in ipairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
        task.wait()
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
-- 8.  Populate
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

print("✅ VORTX HUB loaded – My Market ready")
