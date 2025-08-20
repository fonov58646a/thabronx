--// VORTEX-LUNA RED  – My Market Edition
--// Discord : https://discord.gg/PrmHmDfT
--// Mobile  : yes

local Players      = game:GetService("Players")
local UIS          = game:GetService("UserInputService")
local Tween        = game:GetService("TweenService")
local Core         = game:GetService("CoreGui")
local Replicated   = game:GetService("ReplicatedStorage")

local LP      = Players.LocalPlayer
local mouse   = LP:GetMouse()

-------------------------------------------------
-- 0.  Anti-kick
-------------------------------------------------
local mt = getrawmetatable(game)
setreadonly(mt,false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(...)
    if getnamecallmethod():lower()=="kick" then return end
    return old(...)
end)

-------------------------------------------------
-- 1.  Remote cache
-------------------------------------------------
local Rem = {}
for _,v in pairs(Replicated:GetDescendants()) do
    if v:IsA("RemoteEvent") then Rem[v.Name:lower()]=v end
end

-------------------------------------------------
-- 2.  GUI Shell (Luna-style)
-------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "VortexLuna"
gui.Parent = Core
gui.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 480, 0, 260)
main.Position = UDim2.new(0.5, -240, 0.5, -130)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
main.AnchorPoint = Vector2.new(0.5,0.5)
main.Parent = gui

Instance.new("UICorner",main).CornerRadius = UDim.new(0,12)

-- Red glass shadow
local shad = Instance.new("ImageLabel")
shad.Image = "rbxassetid://13116647614"
shad.Size = UDim2.new(1,20,1,20)
shad.Position = UDim2.new(0,-10,0,-10)
shad.ImageColor3 = Color3.fromRGB(255,40,40)
shad.ImageTransparency = .7
shad.BackgroundTransparency = 1
shad.ScaleType = Enum.ScaleType.Slice
shad.SliceCenter = Rect.new(24,24,152,152)
shad.ZIndex = -1
shad.Parent = main

-------------------------------------------------
-- 3.  Header
-------------------------------------------------
local head = Instance.new("Frame")
head.Size = UDim2.new(1,0,0,42)
head.BackgroundColor3 = Color3.fromRGB(35,35,35)
head.BorderSizePixel = 0
head.Parent = main
Instance.new("UICorner",head).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-90,1,0)
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

-------------------------------------------------
-- 4.  Horizontal tabs
-------------------------------------------------
local tabs = Instance.new("ScrollingFrame")
tabs.Size = UDim2.new(1,-12,0,46)
tabs.Position = UDim2.new(0,6,0,48)
tabs.BackgroundTransparency = 1
tabs.ScrollBarThickness = 0
tabs.ScrollingDirection = Enum.ScrollingDirection.X
tabs.Parent = main

local tabList = Instance.new("UIListLayout")
tabList.FillDirection = Enum.FillDirection.Horizontal
tabList.Padding = UDim.new(0,8)
tabList.Parent = tabs

-------------------------------------------------
-- 5.  Tab builder helper
-------------------------------------------------
local activeTab
local function addTab(name, iconId, func)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,110,1,0)
    btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Gotham
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200,200,200)
    btn.TextSize = 14
    btn.Parent = tabs
    Instance.new("UICorner",btn).CornerRadius = UDim.new(0,8)

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0,18,0,18)
    icon.Position = UDim2.new(0,8,0.5,-9)
    icon.Image = "rbxassetid://"..iconId
    icon.BackgroundTransparency = 1
    icon.Parent = btn

    local glow = Instance.new("ImageLabel")
    glow.Image = "rbxassetid://13116647614"
    glow.Size = UDim2.new(1,12,1,12)
    glow.Position = UDim2.new(0,-6,0,-6)
    glow.ImageColor3 = Color3.fromRGB(255,40,40)
    glow.ImageTransparency = .9
    glow.BackgroundTransparency = 1
    glow.ZIndex = -1
    glow.Visible = false
    glow.Parent = btn

    btn.MouseButton1Click:Connect(function()
        if activeTab then
            activeTab.BackgroundColor3 = Color3.fromRGB(35,35,35)
            activeTab:FindFirstChild("ImageLabel",true).Parent.Visible = false
        end
        activeTab = btn
        btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
        glow.Visible = true
        func()
    end)
end

-------------------------------------------------
-- 6.  Drag logic
-------------------------------------------------
local dragging, startPos, startMouse
head.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        startPos = main.Position
        startMouse = inp.Position
        inp.Changed:Connect(function()
            if inp.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
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
-- 7.  Close
-------------------------------------------------
close.MouseButton1Click:Connect(function() gui:Destroy() end)

-------------------------------------------------
-- 8.  Functions untuk toggle
-------------------------------------------------
local function toggleESP(on)
    for _,plr in ipairs(game:GetService("Players"):GetPlayers()) do
        if plr ~= LP and plr.Character then
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
    local Humanoid = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if not Humanoid then return end
    if on then
        Humanoid.WalkSpeed = 100
        Humanoid.JumpPower = 100
    else
        Humanoid.WalkSpeed = 16
        Humanoid.JumpPower = 50
    end
end

local function toggleNoClip(on)
    while on do
        for _,v in ipairs(LP.Character:GetDescendants()) do
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

local function toggleAutoTrade(on)
    while on do
        if Rem.autotrade then Rem.autotrade:FireServer() end
        task.wait(3)
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
                firetouchinterest(LP.Character:FindFirstChild("HumanoidRootPart"), v, 0)
            end
        end
        task.wait(0.2)
    end
end

-------------------------------------------------
-- 9.  Buat Tab & Toggle
-------------------------------------------------
local function buildTab(name, icon, func)
    local tabFrame = Instance.new("Frame")
    tabFrame.Size = UDim2.new(1,-12,1,-100)
    tabFrame.Position = UDim2.new(0,6,0,100)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = false
    tabFrame.Name = name
    tabFrame.Parent = main

    local grid = Instance.new("UIGridLayout")
    grid.CellSize = UDim2.new(0,220,0,46)
    grid.CellPadding = UDim.new(0,8)
    grid.Parent = tabFrame

    -- wrapper
    local function addToggle(label, iconId, callback)
        local card = Instance.new("Frame")
        card.BackgroundColor3 = Color3.fromRGB(30,30,30)
        card.BorderSizePixel = 0
        card.Parent = tabFrame
        Instance.new("UICorner",card).CornerRadius = UDim.new(0,8)

        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0,24,0,24)
        icon.Position = UDim2.new(0,8,0.5,-12)
        icon.Image = "rbxassetid://"..iconId
        icon.BackgroundTransparency = 1
        icon.Parent = card

        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1,-70,1,0)
        txt.Position = UDim2.new(0,40,0,0)
        txt.BackgroundTransparency = 1
        txt.Font = Enum.Font.Gotham
        txt.Text = label
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
    end

    addToggle("Auto Crate",   6031075931, toggleAutoCrate)
    addToggle("ESP",          6031280882, toggleESP)
    addToggle("Fly / Speed",  6031225810, toggleFly)
    addToggle("NoClip",       6035056483, toggleNoClip)
    addToggle("∞ Money",      6034767619, toggleInfMoney)
    addToggle("500× Luck",    6031225810, toggle500Luck)
    addToggle("500× Money",   6034767619, toggle500Money)
    addToggle("Auto Collect", 6031075931, toggleAutoCollect)
    addToggle("Auto Trade",   6035056483, toggleAutoTrade)

    return tabFrame
end

local tab1 = buildTab("Main", 6031280882)
addTab("Main", 6031280882, function()
    for _,v in ipairs(main:GetChildren()) do
        if v.Name ~= "Main" and v:IsA("Frame") then v.Visible = false end
    end
    tab1.Visible = true
end)
addTab("Premium", 6034767619, function() end) -- placeholder
activeTab = tab1.Visible = true
