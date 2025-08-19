--[[
    🧠 Brainrot Stealer + Real-time UI + Walk Home
    • Custom UI
    • Real-time "holding" indicator
    • Walks back to base (no teleport)
]]

-- Services
local Players      = game:GetService("Players")
local Workspace    = game:GetService("Workspace")
local PathService  = game:GetService("PathfindingService")
local HttpService  = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character   = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid    = Character:WaitForChild("Humanoid")
local RootPart    = Character:WaitForChild("HumanoidRootPart")

-- Base save/load
local CFG_FILE = "brainrot_base.txt"
local BASE_POS = Vector3.new(0, 50, 0)

if isfile(CFG_FILE) then
    local t = HttpService:JSONDecode(readfile(CFG_FILE))
    BASE_POS = Vector3.new(t.X, t.Y, t.Z)
end

local function saveBase(pos)
    writefile(CFG_FILE, HttpService:JSONEncode({X = pos.X, Y = pos.Y, Z = pos.Z}))
    BASE_POS = pos
end

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotUI"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 140)
Frame.Position = UDim2.new(0.5, -110, 0.5, -70)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Selectable = true
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🧠 Brainrot Stealer"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = Frame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 20)
StatusLabel.Position = UDim2.new(0, 10, 0, 35)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Checking..."
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 14
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = Frame

local StealBtn = Instance.new("TextButton")
StealBtn.Size = UDim2.new(0, 90, 0, 30)
StealBtn.Position = UDim2.new(0.5, -45, 1, -70)
StealBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
StealBtn.Text = "Steal"
StealBtn.Font = Enum.Font.GothamBold
StealBtn.TextColor3 = Color3.white
StealBtn.TextSize = 14
StealBtn.Parent = Frame

local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(0, 90, 0, 30)
SaveBtn.Position = UDim2.new(0.5, -45, 1, -35)
SaveBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
SaveBtn.Text = "Set Base"
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.TextColor3 = Color3.white
SaveBtn.TextSize = 14
SaveBtn.Parent = Frame

-- Drag UI
local dragging, dragInput, dragStart, startPos
Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Real-time status
local function isHolding()
    if LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or Character:FindFirstChildOfClass("Tool") then
        return true
    end
    for _, v in ipairs(Character:GetDescendants()) do
        if v:IsA("BasePart") and not v.Anchored and v ~= RootPart then
            return true
        end
    end
    return false
end

RunService.RenderStepped:Connect(function()
    if isHolding() then
        StatusLabel.Text = "Status: Holding item"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        StatusLabel.Text = "Status: Not holding anything"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- Walk to base
local function walkToBase()
    local path = PathService:CreatePath({
        AgentCanJump = true,
        AgentHeight = 5,
        AgentRadius = 2,
        WaypointSpacing = 4
    })
    path:ComputeAsync(RootPart.Position, BASE_POS)
    if path.Status == Enum.PathStatus.Success then
        for _, wp in ipairs(path:GetWaypoints()) do
            Humanoid:MoveTo(wp.Position)
            Humanoid.MoveToFinished:Wait()
        end
    else
        Humanoid:MoveTo(BASE_POS)
    end
end

-- Steal brainrot
local function stealBrainrot()
    -- Collect brainrot parts
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("brainrot") then
            firetouchinterest(RootPart, obj, 0)
            firetouchinterest(RootPart, obj, 1)
        end
    end

    -- Wait until holding
    local t = 0
    repeat
        task.wait(0.2)
        t = t + 0.2
    until isHolding() or t > 3

    walkToBase()
end

-- Button events
StealBtn.MouseButton1Click:Connect(stealBrainrot)
SaveBtn.MouseButton1Click:Connect(function()
    saveBase(RootPart.Position)
    StatusLabel.Text = "Base saved!"
    task.wait(2)
end)

-- Reconnect character
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
end)
