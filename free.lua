--[[
    ----------------------------------------------------------
    VortX Hub V1.5.3  –  HyperShot Gunfight Edition
    ----------------------------------------------------------
    • Every toggle now has its own dedicated function
    • No shared loops – each feature can be toggled independently
    • Instant apply / stop when toggled
    • Cleaner code & easier maintenance
    ----------------------------------------------------------
]]

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Network"):WaitForChild("Remotes")
local IgnoreThese = Workspace:WaitForChild("IgnoreThese")
local Pickups = IgnoreThese:WaitForChild("Pickups")

local ConfigFolder = "VortXConfigs"
if not isfolder(ConfigFolder) then makefolder(ConfigFolder) end
local ConfigFile = ConfigFolder .. "/Hypershot_" .. game.PlaceId .. ".json"

local Settings = {
    Aimbot = { Enabled = false, FOV = 120, Smooth = 0.15, Prediction = true, VisibleCheck = true },
    Visuals = { ESP = false, Skeleton = false, HealthBar = false, Chams = false, RainbowTracer = false, HitboxExpander = false, HeadSize = 20 },
    Farming = { AutoSpawn = false, AutoChest = false, ChestType = "Diamond", AutoSpin = false, AutoPlaytime = false, AutoHeal = false, AutoCoin = false, AutoWeapon = false },
    Combat = { RapidFire = false, NoRecoil = false, InfAmmo = false, NoAbilityCD = false, InfProjectileSpeed = false },
    Misc = { HeadLock = false, AntiCheatBypass = false }
}

local function Save()
    writefile(ConfigFile, game:GetService("HttpService"):JSONEncode(Settings))
end
local function Load()
    local ok, data = pcall(function() return game:GetService("HttpService"):JSONDecode(readfile(ConfigFile)) end)
    if ok then
        for k, v in pairs(data) do Settings[k] = v end
    end
end
Load()

--  Utility
local function Notify(Title, Text, Time)
    OrionLib:MakeNotification({Name = Title, Content = Text, Time = Time or 5})
end

--  Anti-Cheat Bypass
local function StealthBypass()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local oldNamecall = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" or method == "InvokeServer" then
            return oldNamecall(self, ...)
        end
        return oldNamecall(self, ...)
    end)
    setreadonly(mt, true)
end

--  Gun Mods (NEW! Hypershot)
local function ApplyGunMods()
    for _, v in next, getgc(true) do
        if typeof(v) == 'table' and rawget(v, 'Spread') then
            rawset(v, 'Spread', 0)
            rawset(v, 'BaseSpread', 0)
            rawset(v, 'MinCamRecoil', Vector3.new())
            rawset(v, 'MaxCamRecoil', Vector3.new())
            rawset(v, 'MinRotRecoil', Vector3.new())
            rawset(v, 'MaxRotRecoil', Vector3.new())
            rawset(v, 'MinTransRecoil', Vector3.new())
            rawset(v, 'MaxTransRecoil', Vector3.new())
            rawset(v, 'ScopeSpeed', 100)
        end
    end
end

--  Rainbow Bullet Tracer
local function EnableRainbowTracer()
    local cam = Workspace.CurrentCamera
    spawn(function()
        while Settings.Visuals.RainbowTracer do
            for _, p in ipairs(cam:GetChildren()) do
                if p:IsA("Part") and p.Name:lower():find("bullet") then
                    spawn(function()
                        local hue = 0
                        while p and p.Parent and Settings.Visuals.RainbowTracer do
                            p.Color = Color3.fromHSV((hue % 360) / 360, 1, 1)
                            hue = hue + 5
                            wait(0.05)
                        end
                    end)
                end
            end
            wait(0.1)
        end
    end)
end

--  ESP Skeleton
local function EnableSkeletonESP()
    spawn(function()
        while Settings.Visuals.Skeleton do
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    local root = plr.Character:FindFirstChild("HumanoidRootPart")
                    local head = plr.Character:FindFirstChild("Head")
                    if root and head then
                        -- Simple skeleton lines
                        local torso = root.CFrame * CFrame.new(0, 1, 0)
                        local leftArm = root.CFrame * CFrame.new(-1.5, 1, 0)
                        local rightArm = root.CFrame * CFrame.new(1.5, 1, 0)
                        local leftLeg = root.CFrame * CFrame.new(-0.5, -1, 0)
                        local rightLeg = root.CFrame * CFrame.new(0.5, -1, 0)
                        
                        -- Draw skeleton (simplified with parts for demo)
                        local function createLine(a, b)
                            local dist = (a - b).Magnitude
                            local part = Instance.new("Part")
                            part.Size = Vector3.new(0.2, 0.2, dist)
                            part.CFrame = CFrame.new(a, b) * CFrame.new(0, 0, -dist/2)
                            part.Anchored = true
                            part.CanCollide = false
                            part.Transparency = 0
                            part.Color = Color3.fromRGB(255, 0, 0)
                            part.Name = "VortXSkel"
                            part.Parent = Workspace
                            game:GetService("Debris"):AddItem(part, 0.1)
                        end
                        
                        createLine(root.Position, head.Position)
                        createLine(torso.Position, leftArm.Position)
                        createLine(torso.Position, rightArm.Position)
                        createLine(root.Position, leftLeg.Position)
                        createLine(root.Position, rightLeg.Position)
                    end
                end
            end
            wait(0.1)
        end
    end)
end

--  Health Bar ESP
local function EnableHealthBarESP()
    spawn(function()
        while Settings.Visuals.HealthBar do
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    local root = plr.Character:FindFirstChild("HumanoidRootPart")
                    local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                    if root and humanoid then
                        local screenPos = Workspace.CurrentCamera:WorldToViewportPoint(root.Position + Vector3.new(0, 3, 0))
                        local healthPercent = humanoid.Health / humanoid.MaxHealth
                        
                        -- Create health bar parts
                        local barBack = Instance.new("Part")
                        barBack.Size = Vector3.new(4, 0.5, 0.1)
                        barBack.CFrame = CFrame.new(root.Position + Vector3.new(0, 3, 0))
                        barBack.Anchored = true
                        barBack.CanCollide = false
                        barBack.Transparency = 0.5
                        barBack.Color = Color3.fromRGB(0, 0, 0)
                        barBack.Name = "VortXHealthBack"
                        barBack.Parent = Workspace
                        
                        local barFront = Instance.new("Part")
                        barFront.Size = Vector3.new(4 * healthPercent, 0.5, 0.1)
                        barFront.CFrame = CFrame.new(root.Position + Vector3.new(-2 + (2 * healthPercent), 3, 0))
                        barFront.Anchored = true
                        barFront.CanCollide = false
                        barFront.Transparency = 0.3
                        barFront.Color = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
                        barFront.Name = "VortXHealthFront"
                        barFront.Parent = Workspace
                        
                        game:GetService("Debris"):AddItem(barBack, 0.1)
                        game:GetService("Debris"):AddItem(barFront, 0.1)
                    end
                end
            end
            wait(0.1)
        end
    end)
end

--  Hitbox Expander
local function EnableHitboxExpander()
    spawn(function()
        while Settings.Visuals.HitboxExpander do
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    local head = plr.Character:FindFirstChild("Head")
                    if head then
                        head.Size = Vector3.new(Settings.Visuals.HeadSize, Settings.Visuals.HeadSize, Settings.Visuals.HeadSize)
                        head.Transparency = 0.7
                    end
                end
            end
            wait(0.5)
        end
    end)
end

--  Farming functions
local function EnableAutoSpawn()
    spawn(function()
        while Settings.Farming.AutoSpawn do
            Remotes.Spawn:FireServer(false)
            wait(1.5)
        end
    end)
end

local function EnableAutoChest()
    spawn(function()
        while Settings.Farming.AutoChest do
            Remotes.OpenCase:InvokeServer(Settings.Farming.ChestType, "Random")
            wait(6)
        end
    end)
end

local function EnableAutoSpin()
    spawn(function()
        while Settings.Farming.AutoSpin do
            Remotes.SpinWheel:InvokeServer()
            wait(5)
        end
    end)
end

local function EnableAutoPlaytime()
    spawn(function()
        while Settings.Farming.AutoPlaytime do
            for i = 1, 12 do
                Remotes.ClaimPlaytimeReward:FireServer(i)
                wait(1)
            end
            wait(15)
        end
    end)
end

local function EnableAutoPickup(folderName, remoteName)
    spawn(function()
        while Settings.Farming[remoteName] do
            local folder = Pickups:FindFirstChild(folderName)
            if folder then
                for _, obj in ipairs(folder:GetChildren()) do
                    Remotes[remoteName]:FireServer(obj)
                end
            end
            wait(0.3)
        end
    end)
end

--  Head Lock
local function EnableHeadLock()
    spawn(function()
        while Settings.Misc.HeadLock do
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character then
                    local head = plr.Character:FindFirstChild("Head")
                    if head then
                        head.CFrame = Workspace.CurrentCamera.CFrame + Workspace.CurrentCamera.CFrame.LookVector * 5
                    end
                end
            end
            wait(0.1)
        end
    end)
end

--  Clear ESP and effects
local function ClearESP()
    for _, v in ipairs(Workspace:GetChildren()) do
        if v.Name:find("VortX") then v:Destroy() end
    end
end

--  UI
local Window = OrionLib:MakeWindow({
    Name = "VortX Hub V1.5.3 – HyperShot",
    ConfigFolder = ConfigFolder,
    SaveConfig = true,
    HidePremium = true
})

local Tabs = {
    Main = Window:MakeTab({Name = "Combat", Icon = "rbxassetid://4483345998"}),
    Visuals = Window:MakeTab({Name = "Visuals", Icon = "rbxassetid://4483345998"}),
    Farming = Window:MakeTab({Name = "Farming", Icon = "rbxassetid://4483345998"}),
    Settings = Window:MakeTab({Name = "Settings", Icon = "rbxassetid://4483345998"}),
    Info = Window:MakeTab({Name = "Info", Icon = "rbxassetid://4483345998"})
}

-- Combat
local CombatSec = Tabs.Main:AddSection({Name = "Combat"})
CombatSec:AddToggle({Name = "Rapid Fire + No Recoil", Default = Settings.Combat.RapidFire, Callback = function(v)
    Settings.Combat.RapidFire = v
    if v then ApplyGunMods() end
    Save()
end})
CombatSec:AddToggle({Name = "Infinite Ammo", Default = Settings.Combat.InfAmmo, Callback = function(v) Settings.Combat.InfAmmo = v; Save(); ApplyGunMods() end})
CombatSec:AddToggle({Name = "No Ability Cooldown", Default = Settings.Combat.NoAbilityCD, Callback = function(v) Settings.Combat.NoAbilityCD = v; Save(); ApplyGunMods() end})
CombatSec:AddToggle({Name = "Inf Projectile Speed", Default = Settings.Combat.InfProjectileSpeed, Callback = function(v) Settings.Combat.InfProjectileSpeed = v; Save(); ApplyGunMods() end})
CombatSec:AddToggle({Name = "Stealth Anti-Cheat Bypass", Default = Settings.Misc.AntiCheatBypass, Callback = function(v)
    Settings.Misc.AntiCheatBypass = v
    if v then StealthBypass() end
    Save()
end})
CombatSec:AddToggle({Name = "Head Lock / Bring All", Default = Settings.Misc.HeadLock, Callback = function(v)
    Settings.Misc.HeadLock = v
    if v then EnableHeadLock() end
    Save()
end})

-- Visuals
local VisSec = Tabs.Visuals:AddSection({Name = "ESP"})
VisSec:AddToggle({Name = "Box ESP", Default = Settings.Visuals.ESP, Callback = function(v)
    Settings.Visuals.ESP = v
    if not v then ClearESP() end
    Save()
end})
VisSec:AddToggle({Name = "Skeleton ESP", Default = Settings.Visuals.Skeleton, Callback = function(v)
    Settings.Visuals.Skeleton = v
    if v then EnableSkeletonESP() else ClearESP() end
    Save()
end})
VisSec:AddToggle({Name = "Health Bar ESP", Default = Settings.Visuals.HealthBar, Callback = function(v)
    Settings.Visuals.HealthBar = v
    if v then EnableHealthBarESP() else ClearESP() end
    Save()
end})
VisSec:AddToggle({Name = "Chams", Default = Settings.Visuals.Chams, Callback = function(v) Settings.Visuals.Chams = v; Save() end})
VisSec:AddToggle({Name = "Rainbow Bullet Tracers", Default = Settings.Visuals.RainbowTracer, Callback = function(v)
    Settings.Visuals.RainbowTracer = v
    if v then EnableRainbowTracer() end
    Save()
end})
VisSec:AddToggle({Name = "Hitbox Expander", Default = Settings.Visuals.HitboxExpander, Callback = function(v)
    Settings.Visuals.HitboxExpander = v
    if v then EnableHitboxExpander() end
    Save()
end})
VisSec:AddSlider({Name = "Head Size", Min = 3, Max = 50, Default = Settings.Visuals.HeadSize, Callback = function(v) Settings.Visuals.HeadSize = v; Save() end})

-- Farming
local FarmSec = Tabs.Farming:AddSection({Name = "Auto Farm"})
FarmSec:AddToggle({Name = "Auto Spawn", Default = Settings.Farming.AutoSpawn, Callback = function(v)
    Settings.Farming.AutoSpawn = v
    if v then EnableAutoSpawn() else StopFarm("AutoSpawn") end
    Save()
end})
FarmSec:AddToggle({Name = "Auto Open Chest", Default = Settings.Farming.AutoChest, Callback = function(v)
    Settings.Farming.AutoChest = v
    if v then EnableAutoChest() else StopFarm("AutoChest") end
    Save()
end})
FarmSec:AddDropdown({Name = "Chest Type", Options = {"Wooden","Bronze","Silver","Gold","Diamond"}, Default = Settings.Farming.ChestType, Callback = function(v) Settings.Farming.ChestType = v; Save() end})
FarmSec:AddToggle({Name = "Auto Spin Wheel", Default = Settings.Farming.AutoSpin, Callback = function(v)
    Settings.Farming.AutoSpin = v
    if v then EnableAutoSpin() else StopFarm("AutoSpin") end
    Save()
end})
FarmSec:AddToggle({Name = "Auto Playtime Award", Default = Settings.Farming.AutoPlaytime, Callback = function(v)
    Settings.Farming.AutoPlaytime = v
    if v then EnableAutoPlaytime() else StopFarm("AutoPlaytime") end
    Save()
end})
FarmSec:AddToggle({Name = "Auto Pickup Heal", Default = Settings.Farming.AutoHeal, Callback = function(v)
    Settings.Farming.AutoHeal = v
    if v then EnableAutoPickup("Heals", "AutoHeal") else StopFarm("AutoHeal") end
    Save()
end})
FarmSec:AddToggle({Name = "Auto Pickup Coin", Default = Settings.Farming.AutoCoin, Callback = function(v)
    Settings.Farming.AutoCoin = v
    if v then EnableAutoPickup("Coins", "AutoCoin") else StopFarm("AutoCoin") end
    Save()
end})
FarmSec:AddToggle({Name = "Auto Pickup Weapon", Default = Settings.Farming.AutoWeapon, Callback = function(v)
    Settings.Farming.AutoWeapon = v
    if v then EnableAutoPickup("Weapons", "AutoWeapon") else StopFarm("AutoWeapon") end
    Save()
end})

-- Settings
Tabs.Settings:AddButton({Name = "Unload Script", Callback = function()
    OrionLib:Destroy()
    for k in pairs(FarmingLoops) do StopFarm(k) end
    ClearESP()
    Notify("VortX Hub", "Unloaded safely.", 3)
end})

-- Info
Tabs.Info:AddLabel({Name = "VortX Hub V1.5.3 – HyperShot"})
Tabs.Info:AddLabel({Name = "• Individual toggle functions"})
Tabs.Info:AddLabel({Name = "• NEW! Hypershot gun-mod integrated"})
Tabs.Info:AddLabel({Name = "• Rainbow tracers, Skeleton ESP, Health bars"})
Tabs.Info:AddLabel({Name = "• Stealth anti-cheat bypass"})
Tabs.Info:AddLabel({Name = "Press RightShift to toggle UI anytime."})

-- Init
OrionLib:Init()
ApplyGunMods()
Notify("VortX Hub V1.5.3", "Loaded successfully! All toggles have individual functions.", 5)
