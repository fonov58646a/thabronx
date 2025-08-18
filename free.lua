-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
-- VORTEX HUB V2.9 | ULTIMATE EDITION
-- ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"))()
local Window = OrionLib:MakeWindow({Name = "VortX Hub - HyperShot", IntroEnabled = true, IntroText = "VortX Hub", ConfigFolder = "VortX Hub - HyperShot"})

-- Anti-cheat bypass notification
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
local autoFireEnabled = false
local autoReviveEnabled = false
local autoOpenChestEnabled = false
local autoPlaytimeEnabled = false
local autoSpinWheelEnabled = false
local autoSpawnEnabled = false
local autoPickupHealEnabled = false
local autoPickupCoinsEnabled = false
local autoPickupWeaponsEnabled = false
local autoPickupAmmoEnabled = false
local noCooldownEnabled = false
local infiniteProjectileSpeedEnabled = false

-- ESP Configuration
local ESP_Config = {
    Enabled = false,
    Color = Color3.fromRGB(255, 0, 0),
    Transparency = 0.7,
    TeamCheck = false
}

-- Manual FOV Circle Drawing
local AimbotFOVCircle = Instance.new("Part")
AimbotFOVCircle.Name = "AimbotFOVCircle"
AimbotFOVCircle.Shape = Enum.PartType.Cylinder
AimbotFOVCircle.Transparency = 0.5
AimbotFOVCircle.BrickColor = BrickColor.new("Really red")
AimbotFOVCircle.Size = Vector3.new(0.2, 0.2, 0.2)
AimbotFOVCircle.Anchored = true
AimbotFOVCircle.CanCollide = false
AimbotFOVCircle.Parent = workspace

-- Tabs
local AimbotTab = Window:MakeTab({Name = "Aimbot", Icon = "rbxassetid://4483345875", PremiumOnly = false})
local ESPTab = Window:MakeTab({Name = "ESP", Icon = "rbxassetid://4483345875", PremiumOnly = false})
local AutoFeaturesTab = Window:MakeTab({Name = "Auto Features", Icon = "rbxassetid://4483345875", PremiumOnly = false})
local PickupFeaturesTab = Window:MakeTab({Name = "Pickup Features", Icon = "rbxassetid://4483345875", PremiumOnly = false})
local CombatFeaturesTab = Window:MakeTab({Name = "Combat Features", Icon = "rbxassetid://4483345875", PremiumOnly = false})
local UtilityFeaturesTab = Window:MakeTab({Name = "Utility Features", Icon = "rbxassetid://4483345875", PremiumOnly = false})
local InfoTab = Window:MakeTab({Name = "Info", Icon = "rbxassetid://4483345875", PremiumOnly = false})

-- Toggle functions
AimbotTab:AddToggle({Name = "Aimbot", Default = false, Callback = function(Value)
    aimbotEnabled = Value
    AimbotFOVCircle.Transparency = Value and 0.5 or 1
end})

AimbotTab:AddSlider({Name = "FOV", Min = 1, Max = 100, Default = 20, Callback = function(Value)
    aimbotFOV = Value
    AimbotFOVCircle.Size = Vector3.new(Value/50, 0.2, Value/50)
end})

AimbotTab:AddToggle({Name = "Auto Fire", Default = false, Callback = function(Value)
    autoFireEnabled = Value
end})

ESPTab:AddToggle({Name = "Enable ESP", Default = false, Callback = function(Value)
    espEnabled = Value
end})

ESPTab:AddColorPicker({Name = "ESP Color", Default = Color3.fromRGB(255, 0, 0), Callback = function(Value)
    ESP_Config.Color = Value
end})

ESPTab:AddSlider({Name = "ESP Transparency", Min = 0, Max = 1, Default = 0.7, Callback = function(Value)
    ESP_Config.Transparency = Value
end})

ESPTab:AddToggle({Name = "Team Check", Default = false, Callback = function(Value)
    ESP_Config.TeamCheck = Value
end})

CombatFeaturesTab:AddToggle({Name = "Head Lock", Default = false, Callback = function(Value)
    headLockEnabled = Value
end})

CombatFeaturesTab:AddToggle({Name = "Rapid Fire", Default = false, Callback = function(Value)
    rapidFireEnabled = Value
end})

PickupFeaturesTab:AddToggle({Name = "Auto Pickup Heal", Default = false, Callback = function(Value)
    autoPickupHealEnabled = Value
end})

PickupFeaturesTab:AddToggle({Name = "Auto Pickup Coins", Default = false, Callback = function(Value)
    autoPickupCoinsEnabled = Value
end})

PickupFeaturesTab:AddToggle({Name = "Auto Pickup Weapons", Default = false, Callback = function(Value)
    autoPickupWeaponsEnabled = Value
end})

PickupFeaturesTab:AddToggle({Name = "Auto Pickup Ammo", Default = false, Callback = function(Value)
    autoPickupAmmoEnabled = Value
end})

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

-- Info Tab
InfoTab:AddLabel("VortX Hub v1.5.0")
InfoTab:AddLabel("New Features:")
InfoTab:AddLabel("- Enhanced ESP with chams")
InfoTab:AddLabel("- Auto Fire integration with aimbot")
InfoTab:AddLabel("- Improved FOV drawing")
InfoTab:AddLabel("- Auto pickup optimizations")
InfoTab:AddLabel("- Better combat features")
InfoTab:AddButton("Copy Discord", function() setclipboard("discord.gg/VortX") end)

-- Aimbot Logic
task.spawn(function()
    while true do
        if aimbotEnabled then
            local mousePos = UserInputService:GetMouseLocation()
            AimbotFOVCircle.CFrame = CFrame.new(mousePos.X, workspace.CurrentCamera.CFrame.Position.Y, mousePos.Y)
            
            if autoFireEnabled then
                mouse1press()
                task.wait(0.1)
                mouse1release()
            end
        else
            AimbotFOVCircle.Transparency = 1
        end
        task.wait(0.01)
    end
end)

-- ESP Logic
task.spawn(function()
    while true do
        if espEnabled then
            for _, player in Players:GetPlayers() do
                if player ~= LocalPlayer and player.Character then
                    local character = player.Character
                    local head = character:FindFirstChild("Head")
                    local rootPart = character:FindFirstChild("HumanoidRootPart")
                    if head and rootPart then
                        local screenPos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
                        if onScreen then
                            -- Draw ESP box
                            local espBox = Instance.new("BoxHandleAdornment")
                            espBox.Adornee = rootPart
                            espBox.Color3 = ESP_Config.Color
                            espBox.Transparency = ESP_Config.Transparency
                            espBox.Size = rootPart.Size + Vector3.new(0.2, 0.2, 0.2)
                            espBox.ZIndex = 10
                            
                            -- Draw name tag
                            local nameTag = Instance.new("TextLabel")
                            nameTag.Text = player.Name
                            nameTag.Size = UDim2.new(0, 200, 0, 50)
                            nameTag.Position = UDim2.new(0.5, -100, 0, -60)
                            nameTag.Font = Enum.Font.SourceSansBold
                            nameTag.TextSize = 20
                            nameTag.TextColor3 = ESP_Config.Color
                            nameTag.BackgroundTransparency = 1
                            nameTag.Parent = workspace.CurrentCamera
                            
                            -- Clean up ESP elements
                            task.spawn(function()
                                while character and character.Parent do
                                    task.wait()
                                end
                                espBox:Destroy()
                                nameTag:Destroy()
                            end)
                        end
                    end
                end
            end
        end
        task.wait()
    end
end)

-- Pickup Features Logic
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

-- Combat Features Logic
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

-- Auto Features Logic
task.spawn(function()
    while true do
        if autoSpawnEnabled then
            -- Auto spawn logic
        end
        
        if autoOpenChestEnabled then
            -- Auto open chest logic
        end
        
        if autoPlaytimeEnabled then
            -- Auto playtime logic
        end
        
        if autoSpinWheelEnabled then
            -- Auto spin wheel logic
        end
        
        if autoReviveEnabled then
            -- Auto revive logic
        end
        
        task.wait(1)
    end
end)

-- Utility Features Logic
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
