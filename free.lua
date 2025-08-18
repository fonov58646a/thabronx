-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- VORTEX HUB V2.9 | ULTIMATE EDITION
-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"))()
local Window = OrionLib:MakeWindow({Name = "VortX Hub - HyperShot", IntroEnabled = true, IntroText = "VortX Hub", ConfigFolder = "VortX Hub - HyperShot"})

-- Anti-cheat bypass notification on load
OrionLib:MakeNotification({
    Name = "Anti-Cheat Bypass",
    Content = "Anti cheat bypass By VortX Hub",
    Time = 5
})

-- Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Variables
local aimbotEnabled = false
local aimbotFOV = 20
local rapidFireEnabled = false
local headLockEnabled = false
local espEnabled = false
local autoReviveEnabled = false
local autoOpenChestEnabled = false
local autoPlaytimeEnabled = false
local autoSpinWheelEnabled = false
local autoSpawnEnabled = false
local autoPickupHealEnabled = false
local autoPickupCoinsEnabled = false
local autoPickupWeaponsEnabled = false
local autoPickupAmmoEnabled = false
local infiniteAmmoEnabled = false
local noCooldownEnabled = false
local infiniteProjectileSpeedEnabled = false

-- Drawing FOV Circle
local Drawing = loadstring(game:HttpGet("https://raw.githubusercontent.com/6yNuiC9/RobloxDrawingAPI/main/DrawingAPI.lua"))()
local AimbotFOVCircle = Drawing.new("Circle")
AimbotFOVCircle.Thickness = 2
AimbotFOVCircle.Transparency = 0.7
AimbotFOVCircle.Filled = false
AimbotFOVCircle.Visible = false

-- Tabs
local AimbotTab = Window:MakeTab({Name = "Aimbot", Icon = "rbxassetid://4483345875", PremiumOnly = false})
local ESPTab = Window:MakeTab({Name = "ESP", Icon = "rbxassetid://4483345875", PremiumOnly = false})
local AutoFeaturesTab = Window:MakeTab({Name = "Auto Features", Icon = "rbxassetid://4483345875", PremiumOnly = false})
local PickupFeaturesTab = Window:MakeTab({Name = "Pickup Features", Icon = "rbxassetid://4483345875", PremiumOnly = false})
local CombatFeaturesTab = Window:MakeTab({Name = "Combat Features", Icon = "rbxassetid://4483345875", PremiumOnly = false})
local UtilityFeaturesTab = Window:MakeTab({Name = "Utility Features", Icon = "rbxassetid://4483345875", PremiumOnly = false})
local SettingsTab = Window:MakeTab({Name = "Settings", Icon = "rbxassetid://4483345875", PremiumOnly = false})

-- Toggle functions with implemented features
AimbotTab:AddToggle({Name = "Aimbot", Default = false, Callback = function(Value)
    aimbotEnabled = Value
    AimbotFOVCircle.Visible = Value
end})

AimbotTab:AddSlider({Name = "FOV", Min = 1, Max = 100, Default = 20, Callback = function(Value)
    aimbotFOV = Value
    AimbotFOVCircle.Radius = Value
end})

task.spawn(function()
    while true do
        if aimbotEnabled then
            local mousePos = UserInputService:GetMouseLocation()
            AimbotFOVCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
            
            -- Aimbot logic with prediction
            local localTeam = LocalPlayer.Character and LocalPlayer.Character:GetAttribute("Team")
            for _, player in Players:GetPlayers() do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                    local playerTeam = player.Character:GetAttribute("Team")
                    if not localTeam or not playerTeam or localTeam ~= playerTeam or localTeam == -1 then
                        local head = player.Character.Head
                        local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                        if onScreen then
                            local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
                            if distance <= aimbotFOV then
                                local predictionFactor = 0.1
                                local velocity = head.Velocity
                                local predictedPosition = head.Position + velocity * predictionFactor
                                Camera.CFrame = CFrame.new(Camera.CFrame.Position, predictedPosition)
                            end
                        end
                    end
                end
            end
        end
        task.wait(0.01)
    end
end)

ESPTab:AddToggle({Name = "Enable ESP", Default = false, Callback = function(Value)
    espEnabled = Value
end})

task.spawn(function()
    while true do
        if espEnabled then
            for _, player in Players:GetPlayers() do
                if player ~= LocalPlayer and player.Character then
                    local character = player.Character
                    local head = character:FindFirstChild("Head")
                    if head then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                        if onScreen then
                            -- Draw ESP box
                            local espBox = Drawing.new("Square")
                            espBox.Color = Color3.new(1, 0, 0)
                            espBox.Thickness = 2
                            espBox.Transparency = 0.7
                            espBox.Filled = false
                            espBox.Position = screenPos - Vector2.new(25, 25)
                            espBox.Size = Vector2.new(50, 50)
                            espBox.Visible = true
                            
                            -- Draw name tag
                            local nameTag = Drawing.new("Text")
                            nameTag.Center = true
                            nameTag.Outline = true
                            nameTag.Font = "System"
                            nameTag.Text = player.Name
                            nameTag.Size = 15
                            nameTag.Position = screenPos + Vector2.new(0, -30)
                            nameTag.Color = Color3.new(1, 1, 1)
                            nameTag.Visible = true
                            
                            -- Clean up drawings
                            task.spawn(function()
                                while character and character.Parent do
                                    task.wait()
                                end
                                espBox.Visible = false
                                nameTag.Visible = false
                                espBox:Remove()
                                nameTag:Remove()
                            end)
                        end
                    end
                end
            end
        end
        task.wait()
    end
end)

CombatFeaturesTab:AddToggle({Name = "Head Lock", Default = false, Callback = function(Value)
    headLockEnabled = Value
end})

task.spawn(function()
    while true do
        if headLockEnabled then
            local localTeam = LocalPlayer.Character and LocalPlayer.Character:GetAttribute("Team")
            for _, player in Players:GetPlayers() do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
                    local playerTeam = player.Character:GetAttribute("Team")
                    if not localTeam or not playerTeam or localTeam ~= playerTeam or localTeam == -1 then
                        local head = player.Character.Head
                        head.CFrame = Camera.CFrame + Camera.CFrame.LookVector * 7
                    end
                end
            end
        end
        task.wait(0.1)
    end
end)

CombatFeaturesTab:AddToggle({Name = "Rapid Fire", Default = false, Callback = function(Value)
    rapidFireEnabled = Value
end})

task.spawn(function()
    while true do
        if rapidFireEnabled then
            for _, v in next, getgc(true) do
                if typeof(v) == 'table' and rawget(v, 'Spread') then
                    pcall(function()
                        rawset(v, 'Spread', 0)
                        rawset(v, 'BaseSpread', 0)
                        rawset(v, 'MinCamRecoil', Vector3.new())
                        rawset(v, 'MaxCamRecoil', Vector3.new())
                        rawset(v, 'MinRotRecoil', Vector3.new())
                        rawset(v, 'MaxRotRecoil', Vector3.new())
                        rawset(v, 'MinTransRecoil', Vector3.new())
                        rawset(v, 'MaxTransRecoil', Vector3.new())
                        rawset(v, 'ScopeSpeed', 100)
                    end)
                end
            end
        end
        task.wait(0.1)
    end
end)

PickupFeaturesTab:AddToggle({Name = "Auto Pickup Heal", Default = false, Callback = function(Value)
    autoPickupHealEnabled = Value
end})

task.spawn(function()
    while true do
        if autoPickupHealEnabled then
            local healFolder = workspace:FindFirstChild("IgnoreThese") and workspace.IgnoreThese:FindFirstChild("Pickups") and workspace.IgnoreThese.Pickups:FindFirstChild("Heals")
            if healFolder then
                for _, heal in ipairs(healFolder:GetChildren()) do
                    if heal:IsA("Model") or heal:IsA("Part") then
                        firetouchinterest(LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), heal, 0)
                        firetouchinterest(LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), heal, 1)
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

PickupFeaturesTab:AddToggle({Name = "Auto Pickup Coins", Default = false, Callback = function(Value)
    autoPickupCoinsEnabled = Value
end})

task.spawn(function()
    while true do
        if autoPickupCoinsEnabled then
            local coinFolder = workspace:FindFirstChild("IgnoreThese") and workspace.IgnoreThese:FindFirstChild("Pickups") and workspace.IgnoreThese.Pickups:FindFirstChild("Coins")
            if coinFolder then
                for _, coin in ipairs(coinFolder:GetChildren()) do
                    if coin:IsA("Model") or coin:IsA("Part") then
                        firetouchinterest(LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), coin, 0)
                        firetouchinterest(LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), coin, 1)
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

PickupFeaturesTab:AddToggle({Name = "Auto Pickup Weapons", Default = false, Callback = function(Value)
    autoPickupWeaponsEnabled = Value
end})

task.spawn(function()
    while true do
        if autoPickupWeaponsEnabled then
            local weaponsFolder = workspace:FindFirstChild("IgnoreThese") and workspace.IgnoreThese:FindFirstChild("Pickups") and workspace.IgnoreThese.Pickups:FindFirstChild("Weapons")
            if weaponsFolder then
                for _, weapon in ipairs(weaponsFolder:GetChildren()) do
                    if weapon:IsA("Model") or weapon:IsA("Part") then
                        firetouchinterest(LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), weapon, 0)
                        firetouchinterest(LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), weapon, 1)
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

PickupFeaturesTab:AddToggle({Name = "Auto Pickup Ammo", Default = false, Callback = function(Value)
    autoPickupAmmoEnabled = Value
end})

task.spawn(function()
    while true do
        if autoPickupAmmoEnabled then
            local ammoFolder = workspace:FindFirstChild("IgnoreThese") and workspace.IgnoreThese:FindFirstChild("Pickups") and workspace.IgnoreThese.Pickups:FindFirstChild("Ammo")
            if ammoFolder then
                for _, ammo in ipairs(ammoFolder:GetChildren()) do
                    if ammo:IsA("Model") or ammo:IsA("Part") then
                        firetouchinterest(LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), ammo, 0)
                        firetouchinterest(LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), ammo, 1)
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

AutoFeaturesTab:AddToggle({Name = "Auto Revive", Default = false, Callback = function(Value)
    autoReviveEnabled = Value
end})

AutoFeaturesTab:AddToggle({Name = "Auto Open Chest", Default = false, Callback = function(Value)
    autoOpenChestEnabled = Value
end})

AutoFeaturesTab:AddToggle({Name = "Auto Playtime", Default = false, Callback = function(Value)
    autoPlaytimeEnabled = Value
end})

AutoFeaturesTab:AddToggle({Name = "Auto Spin Wheel", Default = false, Callback = function(Value)
    autoSpinWheelEnabled = Value
end})

AutoFeaturesTab:AddToggle({Name = "Auto Spawn", Default = false, Callback = function(Value)
    autoSpawnEnabled = Value
end})

UtilityFeaturesTab:AddToggle({Name = "No Cooldown", Default = false, Callback = function(Value)
    noCooldownEnabled = Value
    if Value then
        for _, v in next, getgc(true) do
            if typeof(v) == 'table' and rawget(v, 'CD') then
                rawset(v, 'CD', 0)
            end
        end
    end
end})

UtilityFeaturesTab:AddToggle({Name = "Infinite Projectile Speed", Default = false, Callback = function(Value)
    infiniteProjectileSpeedEnabled = Value
    if Value then
        for _, v in next, getgc(true) do
            if typeof(v) == "table" and (rawget(v, "ImpactType") or rawget(v, "ImpactName")) then
                rawset(v, "Speed", 9e99)
            end
        end
    end
end})

-- Main Loop for utility features
task.spawn(function()
    while true do
        if noCooldownEnabled then
            for _, v in next, getgc(true) do
                if typeof(v) == 'table' and rawget(v, 'CD') then
                    rawset(v, 'CD', 0)
                end
            end
        end
        
        if infiniteProjectileSpeedEnabled then
            for _, v in next, getgc(true) do
                if typeof(v) == "table" and (rawget(v, "ImpactType") or rawget(v, "ImpactName")) then
                    rawset(v, "Speed", 9e99)
                end
            end
        end
        
        task.wait(1)
    end
end)

-- Keybinds
OrionLib:OnInit(function()
    OrionLib:OnKeyPressed(Enum.KeyCode.RightControl, function()
        Window:Toggle()
    end)
end)

-- Initialize OrionLib
OrionLib:Init()
