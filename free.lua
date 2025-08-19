--🧠 Brainrot-Stealer + Auto-Return to Base + Saveable Base Position
-- Uses OrionLib UI (already provided)

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"))()

--────────────────────────────────────────
-- 1)  Services & Globals
--────────────────────────────────────────
local Players         = game:GetService("Players")
local RunService      = game:GetService("RunService")
local Workspace       = game:GetService("Workspace")
local LocalPlayer     = Players.LocalPlayer
local TweenService    = game:GetService("TweenService")
local HttpService     = game:GetService("HttpService")

local Character       = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local RootPart        = Character:WaitForChild("HumanoidRootPart")
local BASE_POSITION   = Vector3.new(0, 100, 0)  -- fallback

--────────────────────────────────────────
-- 2)  Save/Load Base Position
--────────────────────────────────────────
local cfgFile = "brainrot_base.txt"
local function loadBase()
    if isfile(cfgFile) then
        local data = HttpService:JSONDecode(readfile(cfgFile))
        BASE_POSITION = Vector3.new(data.X, data.Y, data.Z)
    end
end
local function saveBase(pos)
    local data = {X = pos.X, Y = pos.Y, Z = pos.Z}
    writefile(cfgFile, HttpService:JSONEncode(data))
    BASE_POSITION = pos
end
loadBase()

--────────────────────────────────────────
-- 3)  Utility: return-to-base
--────────────────────────────────────────
local function returnToBase()
    if not RootPart then return end
    local tween = TweenService:Create(
        RootPart,
        TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {CFrame = CFrame.new(BASE_POSITION)}
    )
    tween:Play()
end

--────────────────────────────────────────
-- 4)  Steal brainrot logic
--────────────────────────────────────────
local function stealBrainrot()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj.Name:lower():find("brainrot") and obj:IsA("BasePart") then
            obj.CFrame = RootPart.CFrame * CFrame.new(0, 0, -3)
            firetouchinterest(RootPart, obj, 0)
            firetouchinterest(RootPart, obj, 1)
        end
    end
    returnToBase()
end

--────────────────────────────────────────
-- 5)  OrionLib UI
--────────────────────────────────────────
local Window = OrionLib:MakeWindow({
    Name = "🧠 Brainrot Stealer",
    HidePremium = true,
    SaveConfig = false,
    IntroEnabled = false
})

local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345875"
})

Tab:AddButton({
    Name = "Steal Brainrot",
    Callback = stealBrainrot
})

--────────────────────────────────────────
-- 6)  Auto-return toggle
--────────────────────────────────────────
local autoReturn = false
Tab:AddToggle({
    Name = "Auto-return to base after steal",
    Default = autoReturn,
    Callback = function(v) autoReturn = v end
})

--────────────────────────────────────────
-- 7)  Save / set base position
--────────────────────────────────────────
Tab:AddButton({
    Name = "Save Current Position as Base",
    Callback = function()
        saveBase(RootPart.Position)
        OrionLib:MakeNotification({Name = "Base saved", Content = tostring(BASE_POSITION), Time = 3})
    end
})

-- Hook returnToBase to toggle
local originalSteal = stealBrainrot
stealBrainrot = function()
    originalSteal()
    if autoReturn then returnToBase() end
end

--────────────────────────────────────────
-- 8)  Re-spawn detection
--────────────────────────────────────────
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    RootPart  = char:WaitForChild("HumanoidRootPart")
end)

OrionLib:Init()
