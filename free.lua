repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local InsertService = game:GetService("InsertService") -- Make sure InsertService is defined
local StarterGui = game:GetService("StarterGui")

local WindUI = nil
local success, errorMessage = pcall(function()
    local scriptContent = game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua")
    if scriptContent and scriptContent ~= "" then
        WindUI = loadstring(scriptContent)()
    else
        error("Failed to retrieve WindUI script content.")
    end
end)

if not success or not WindUI then
    warn("Failed to load WindUI: " .. (errorMessage or "Unknown error"))
    game.StarterGui:SetCore("SendNotification", {
        Title = "VORTX Error",
        Text = "The script does not support your executor!",
        Duration = 10,
        Button1 = "OK"
    })
    return
end

local Confirmed = false
WindUI:Popup({
    Title = "VortX Loaded! - Evade",
    Icon = "star",
    IconThemed = true,
    Content = "VORTX| Join our (https://discord.gg/TXebwYcPaB)",
    Buttons = {
        { Title = "Cancel", Variant = "Secondary", Callback = function() end },
        { Title = "Continue", Icon = "arrow-right", Callback = function() Confirmed = true end, Variant = "Primary" }
    }
})

repeat task.wait() until Confirmed

local Window = WindUI:CreateWindow({
    Title = "VORTX - Evade | Premium But Free (V1.0)",
    IconThemed = true,
    Icon = "star",
    Author = "VORTX",
    Size = UDim2.fromOffset(600, 400),
    Transparent = true,
    Theme = "Dark",
})

Window:EditOpenButton({
    Title = "VORTX - Open",
    Icon = "monitor",
    CornerRadius = UDim.new(0, 6),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromRGB(30, 30, 30), Color3.fromRGB(255, 255, 255)),
    Draggable = true,
})

--- Add UI Elements to GameTab ---
local GameTab = Window:Tab({ Title = "Main", Icon = "rocket" })
local VoteTab = Window:Tab({ Title = "Vote", Icon = "map" })
local EspTab = Window:Tab({ Title = "Esp", Icon = "eye" })
local PlayerTab = Window:Tab({ Title = "Player", Icon = "user" })
local ReviveTab = Window:Tab({ Title = "Revive", Icon = "shield-plus" })
local FakeTab = Window:Tab({ Title = "Fake", Icon = "sparkles" })
local SkullTab = Window:Tab({ Title = "Best", Icon = "skull" })
local MiscTab = Window:Tab({ Title = "Misc", Icon = "file-cog" })
local Niggatab = Window:Tab({ Title = "Info", Icon = "settings-2" })

local headlessEnabled = false
local korbloxEnabled = false

local FullbrightEnabled = false
local NoFogEnabled = false
local SuperFullBrightnessEnabled = false
local VibrantEnabled = false

local ActiveAutoWin = false
local ActiveAutoFarmMoney = false
local AutoFarmSummerEvent = false
local AntiAfkEnabled = true
local AntiTp = true
local AntiBypass = true

local ValueSpeed = 16 
local ActiveCFrameSpeedBoost = false
local OriginalWalkSpeed = 16 

local cframeSpeedConnection = nil

PlayerTab:Input({
    Title = "Set Base Speed",
    Placeholder = "Enter Speed Value (1-1000)",
    onChanged = function(value)
        local num = tonumber(value)
        if num and num >= 1 and num <= 5000 then
            ValueSpeed = num
            print("[VORTX] Speed value set to: " .. ValueSpeed)
            if ActiveWalkSpeedBoost and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = ValueSpeed
            end
        else
            ValueSpeed = 16 
            print("[VORTX] Invalid speed value. Please enter a number between 1 and 100. Reverted to 16.")
        end
    end
})

PlayerTab:Toggle({
    Title = "Speed Boost (Cframe)",
    Callback = function(state)
        ActiveCFrameSpeedBoost = state
        if ActiveCFrameSpeedBoost then
            print("[VORTX] CFrame Speed Boost Enabled!")
            
            if cframeSpeedConnection then
                cframeSpeedConnection:Disconnect()
                cframeSpeedConnection = nil
            end

            cframeSpeedConnection = RunService.RenderStepped:Connect(function()
                local character = LocalPlayer.Character
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                local hrp = character and character:FindFirstChild("HumanoidRootPart")

                if character and humanoid and hrp then
                    local moveDir = humanoid.MoveDirection
                    if moveDir.Magnitude > 0 then
                        hrp.CFrame = hrp.CFrame + moveDir * math.max(ValueSpeed, 1) * 0.080
                    end
                end
            end)
        else
            print("[VORTX] CFrame Speed Boost Disabled!")
            if cframeSpeedConnection then
                cframeSpeedConnection:Disconnect()
                cframeSpeedConnection = nil
            end
        end
    end
})

local originalBrightness = game.Lighting.Brightness
local originalOutdoorAmbient = game.Lighting.OutdoorAmbient
local originalAmbient = game.Lighting.Ambient
local originalGlobalShadows = game.Lighting.GlobalShadows
local originalFogEnd = game.Lighting.FogEnd
local originalFogStart = game.Lighting.FogStart
local originalFogColor = game.Lighting.FogColor
local originalColorCorrectionEnabled = game.Lighting.ColorCorrection.Enabled
local originalSaturation = game.Lighting.ColorCorrection.Saturation
local originalContrast = game.Lighting.ColorCorrection.Contrast

local function applyFullBrightness()
    game.Lighting.Brightness = 2
    game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    game.Lighting.GlobalShadows = false
end

local function removeFullBrightness()
    game.Lighting.Brightness = originalBrightness
    game.Lighting.OutdoorAmbient = originalOutdoorAmbient
    game.Lighting.Ambient = originalAmbient
    game.Lighting.GlobalShadows = originalGlobalShadows
end

local function applySuperFullBrightness()
    game.Lighting.Brightness = 15
    game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    game.Lighting.GlobalShadows = false
end

local function applyNoFog()
    game.Lighting.FogEnd = 1000000
    game.Lighting.FogStart = 999999
end

local function removeNoFog()
    game.Lighting.FogEnd = originalFogEnd
    game.Lighting.FogStart = originalFogStart
end

local function applyVibrant()
    game.Lighting.ColorCorrection.Enabled = true
    game.Lighting.ColorCorrection.Saturation = 0.8
    game.Lighting.ColorCorrection.Contrast = 0.4
end

local function removeVibrant()
    game.Lighting.ColorCorrection.Enabled = originalColorCorrectionEnabled
    game.Lighting.ColorCorrection.Saturation = originalSaturation
    game.Lighting.ColorCorrection.Contrast = originalContrast
end

local afk = true

MiscTab:Toggle({
    Title = "Anti-AFK",
    Default = true,
    Callback = function(state)
        afk = state -- อัปเดตตัวแปรหลัก
        if state then
            task.spawn(function()
                while afk do
                    if not LocalPlayer then return end
                    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                    task.wait(60)
                end
            end)
        else
            print("[VORTX
] Anti-AFK disabled.")
        end
    end
})

MiscTab:Toggle({
    Title = "Full Brightness",
    Default = false,
    Callback = function(state)
        FullbrightEnabled = state
        if state then
            applyFullBrightness()
        else
            removeFullBrightness()
        end
    end
})

MiscTab:Toggle({
    Title = "Super Full Brightness",
    Default = false,
    Callback = function(state)
        SuperFullBrightnessEnabled = state
        if state then
            applySuperFullBrightness()
        else
            removeFullBrightness()
        end
    end
})

MiscTab:Toggle({
    Title = "No Fog",
    Default = false,
    Callback = function(state)
        NoFogEnabled = state
        if state then
            applyNoFog()
        else
            removeNoFog()
        end
    end
})

MiscTab:Toggle({
    Title = "Vibrant +200%",
    Default = false,
    Callback = function(state)
        VibrantEnabled = state
        if state then
            applyVibrant()
        else
            removeVibrant()
        end
    end
})

MiscTab:Toggle({
    Title = "FPS Boost",
    Default = false,
    Callback = function(state)
        if state then
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                elseif v:IsA("Decal") then
                    v.Transparency = 1
                end
            end
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        else
            print("[VORTX] FPS Boost disabled. (by rhy)")
        end
    end
})

if FullbrightEnabled then
    applyFullBrightness()
end
if NoFogEnabled then
    applyNoFog()
end
if SuperFullBrightnessEnabled then
    applySuperFullBrightness()
end
if VibrantEnabled then
    applyVibrant()
end

local selectedMapNumber = 1
local autoVoteEnabled = false
local voteConnection = nil

VoteTab:Dropdown({
    Title = "Select Map",
    Values = {"Map 1", "Map 2", "Map 3", "Map 4"},
    Callback = function(value)
        if value == "Map 1" then
            selectedMapNumber = 1
        elseif value == "Map 2" then
            selectedMapNumber = 2
        elseif value == "Map 3" then
            selectedMapNumber = 3
        elseif value == "Map 4" then
            selectedMapNumber = 4
        end
    end
})

VoteTab:Button({
    Title = "Vote!",
    Callback = function()
        fireVoteServer(selectedMapNumber)
    end
})

VoteTab:Toggle({
    Title = "Auto Vote",
    Callback = function(state)
        autoVoteEnabled = state
        if autoVoteEnabled then
            if not voteConnection then
                voteConnection = game:GetService("RunService").Heartbeat:Connect(function()
                    fireVoteServer(selectedMapNumber)
                end)
            end
        else
            if voteConnection then
                voteConnection:Disconnect()
                voteConnection = nil
            end
        end
    end
})

local function fireVoteServer(selectedMapNumber)
    local eventsFolder = ReplicatedStorage:WaitForChild("Events", 10)
    if eventsFolder then
        local playerFolder = eventsFolder:WaitForChild("Player", 10)
        if playerFolder then
            local voteEvent = playerFolder:WaitForChild("Vote", 10)
            if voteEvent and typeof(voteEvent) == "Instance" and voteEvent:IsA("RemoteEvent") then
                local args = {
                    [1] = selectedMapNumber
                }
                voteEvent:FireServer(unpack(args))
            else
                warn("Vote RemoteEvent not found or is not a RemoteEvent.")
            end
        else
            warn("Player folder not found under Events.")
        end
    else
        warn("Events folder not found in ReplicatedStorage.")
    end
end

GameTab:Toggle({
    Title = "Auto Farm Win",
    Callback = function(state)
        ActiveAutoWin = state
        if ActiveAutoWin then
            print("[VORTX] Auto Farm Win Enabled!")
            spawn(function()
                while ActiveAutoWin do
                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local rootPart = character:FindFirstChild("HumanoidRootPart")

                    if character and rootPart then
                        if character:GetAttribute("Downed") then
                            ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
                            print("[VORTX] Revived for Auto Win!")
                            task.wait(0.5)
                        end

                        if not character:GetAttribute("Downed") then
                            local securityPart = Instance.new("Part")
                            securityPart.Name = "SecurityPartTemp"
                            securityPart.Size = Vector3.new(10, 1, 10)
                            securityPart.Position = Vector3.new(0, 500, 0)
                            securityPart.Anchored = true
                            securityPart.Transparency = 1
                            securityPart.CanCollide = true
                            securityPart.Parent = Workspace

                            rootPart.CFrame = securityPart.CFrame + Vector3.new(0, 3, 0)
                            task.wait(0.5)
                            securityPart:Destroy()
                        end
                    end
                    task.wait(0.1)
                end
            end)
        else
            print("[VORTX] Auto Farm Win Disabled!")
        end
    end
})

GameTab:Toggle({
    Title = "Auto Farm Money",
    Callback = function(state)
        ActiveAutoFarmMoney = state
        if ActiveAutoFarmMoney then
            print("[VORTX] Auto Farm Money Enabled!")
            spawn(function()
                while ActiveAutoFarmMoney do
                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")

                    if character and rootPart then
                        if character:GetAttribute("Downed") then
                            ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
                            print("[VORTX] Revived for Auto Farm-Money!")
                            task.wait(0.5)
                        end

                        local downedPlayerFound = false
                        local playersInGame = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Players")
                        if playersInGame then
                            for _, v in pairs(playersInGame:GetChildren()) do
                                if v:IsA("Model") and v:FindFirstChildOfClass("Humanoid") and v:GetAttribute("Downed") then
                                    rootPart.CFrame = v.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                                    ReplicatedStorage.Events.Character.Interact:FireServer("Revive", true, v)
                                    print("[VORTX] Reviving player for Farm Money!")
                                    task.wait(0.5)
                                    downedPlayerFound = true
                                    break
                                end
                            end
                        end

                        if not downedPlayerFound then
                            print("[VORTX] ⚠️ No downed player found for Auto Farm Money, waiting...")
                        end

                        local securityPart = Instance.new("Part")
                        securityPart.Name = "SecurityPartTemp"
                        securityPart.Size = Vector3.new(10, 1, 10)
                        securityPart.Position = Vector3.new(0, 500, 0)
                        securityPart.Anchored = true
                        securityPart.Transparency = 1
                        securityPart.CanCollide = true
                        securityPart.Parent = Workspace
                        rootPart.CFrame = securityPart.CFrame + Vector3.new(0, 3, 0)

                    else
                        print("[VORTX] Character or HumanoidRootPart not found, waiting for spawn.")
                    end
                    task.wait(1)
                end
            end)
        else
            print("[VORTX] Auto Farm Money Disabled!")
        end
    end
})

GameTab:Toggle({
    Title = "Auto Farm Summer Event",
    Callback = function(state)
        AutoFarmSummerEvent = state
        if AutoFarmSummerEvent then
            print("[VORTX] Auto Farm Summer Event Enabled!")
            spawn(function()
                while AutoFarmSummerEvent do
                    local tickets = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Effects") and Workspace.Game.Effects:FindFirstChild("Tickets")
                    if tickets then
                        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                        local rootPart = character and character:FindFirstChild("HumanoidRootPart")

                        if character and rootPart then
                            if character:GetAttribute("Downed") then
                                ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
                                print("[VORTX] Revived for Summer Event!")
                                task.wait(0.5)
                            end

                            for _, ticket in ipairs(tickets:GetChildren()) do
                                local ticketPart = ticket:FindFirstChild("HumanoidRootPart") or ticket.PrimaryPart
                                if ticketPart and rootPart then
                                    rootPart.CFrame = ticketPart.CFrame + Vector3.new(0, 2, 0)
                                    task.wait(0.2)
                                end
                            end

                            local securityPart = Instance.new("Part")
                            securityPart.Name = "SecurityPartTemp"
                            securityPart.Size = Vector3.new(10, 1, 10)
                            securityPart.Position = Vector3.new(0, 500, 0)
                            securityPart.Anchored = true
                            securityPart.Transparency = 1
                            securityPart.CanCollide = true
                            securityPart.Parent = Workspace
                            rootPart.CFrame = securityPart.CFrame + Vector3.new(0, 3, 0)
                        end
                    else
                        print("[VORTX] ⚠️ Tickets not found for Summer Event!")
                    end
                    task.wait(1)
                end
            end)
        else
            print("[VORTX] Auto Farm Summer Event Disabled!")
        end
    end
})

local loopFakeBundleConnection = nil
local loopFakeBundleEnabled = false
local Niggastats = true
local Admin = true

SkullTab:Toggle({
    Title = "Anti-Lagging",
    Callback = function(state)
        Niggastats = state
        print("[VORTX] Anti-Lagging")
    end
})

SkullTab:Toggle({
    Title = "Anti-Admin",
    Default = true,
    Callback = function(state)
        Admin = state -- อัปเดตตัวแปรหลัก
        if state then
            task.spawn(function()
                while Admin do
                    if not LocalPlayer then return end
                    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                    task.wait(60)
                end
            end)
        else
            print("[VORTX] Anti-Admin disabled.")
        end
    end
})

local KORBLOX_RIGHT_LEG_ID = 139607718

local function getLocalPlayerCharacter()
    local player = Players.LocalPlayer
    if player then
        return player.Character or player.CharacterAdded:Wait()
    end
    return nil
end

local function applyHeadless()
    local character = getLocalPlayerCharacter()
    if character then
        local head = character:FindFirstChild("Head")
        if head then
            head.Transparency = 1
            local face = head:FindFirstChildOfClass("Decal")
            if face then
                face.Transparency = 1
            end
            local mesh = head:FindFirstChildOfClass("SpecialMesh") or head:FindFirstChildOfClass("CylinderMesh")
            if mesh then
                mesh.MeshId = ""
            end
            for _, child in ipairs(head:GetChildren()) do
                if child:IsA("Accessory") and child.AccessoryType == Enum.AccessoryType.Face then
                    child.Handle.Transparency = 1
                end
            end
        end
    end
end

local function removeHeadless()
    local character = getLocalPlayerCharacter()
    if character then
        local head = character:FindFirstChild("Head")
        if head then
            head.Transparency = 0
            local face = head:FindFirstChildOfClass("Decal")
            if face then
                face.Transparency = 0
            end
            -- Re-apply original head mesh/appearance by applying the humanoid description
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local originalDescription = Players:GetHumanoidDescriptionFromUserId(Players.LocalPlayer.UserId)
                if originalDescription then
                    humanoid:ApplyDescription(originalDescription)
                end
            end
        end
    end
end

local loadedKorbloxAccessory = nil

local function applyKorbloxRightLeg()
    local character = getLocalPlayerCharacter()
    if character and character:FindFirstChildOfClass("Humanoid") then
        local humanoid = character:FindFirstChildOfClass("Humanoid")

        if loadedKorbloxAccessory and loadedKorbloxAccessory.Parent == character then
            return -- Already applied
        end

        local success, asset = pcall(function()
            return InsertService:LoadAsset(KORBLOX_RIGHT_LEG_ID)
        end)

        if success and asset then
            local accessory = asset:FindFirstChildOfClass("Accessory")
            if accessory then
                -- Remove existing right leg accessories to prevent duplicates or conflicts
                for _, child in ipairs(character:GetChildren()) do
                    if child:IsA("Accessory") and child.Name == "Right Leg" then
                        child:Destroy()
                    end
                end
                humanoid:AddAccessory(accessory)
                loadedKorbloxAccessory = accessory
            end
        else
            warn("Failed to load Korblox Right Leg asset: " .. (asset or "Unknown error"))
        end
    end
end

local function removeKorbloxRightLeg()
    local character = getLocalPlayerCharacter()
    if character then
        if loadedKorbloxAccessory and loadedKorbloxAccessory.Parent == character then
            loadedKorbloxAccessory:Destroy()
            loadedKorbloxAccessory = nil
        else
            -- Fallback: if loadedKorbloxAccessory wasn't tracked, try to find and destroy by MeshId
            for _, child in ipairs(character:GetChildren()) do
                if child:IsA("Accessory") and child.Handle and child.Handle:FindFirstChildOfClass("SpecialMesh") then
                    if child.Handle:FindFirstChildOfClass("SpecialMesh").MeshId == "rbxassetid://" .. KORBLOX_RIGHT_LEG_ID then
                        child:Destroy()
                    end
                end
            end
        end

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            -- Re-apply the original character description to restore the default leg
            local originalDescription = Players:GetHumanoidDescriptionFromUserId(Players.LocalPlayer.UserId)
            if originalDescription then
                humanoid:ApplyDescription(originalDescription)
            end
        end
    end
end

local function removeAllHats()
    local character = getLocalPlayerCharacter()
    if character then
        for _, child in ipairs(character:GetChildren()) do
            if child:IsA("Accessory") and (child.AccessoryType == Enum.AccessoryType.Hat or child.AccessoryType == Enum.AccessoryType.Hair or child.AccessoryType == Enum.AccessoryType.Face or child.AccessoryType == Enum.AccessoryType.Neck or child.AccessoryType == Enum.AccessoryType.Shoulder or child.AccessoryType == Enum.AccessoryType.Front or child.AccessoryType == Enum.AccessoryType.Back or child.AccessoryType == Enum.AccessoryType.Waist) then
                child:Destroy()
            end
        end
    end
end

FakeTab:Dropdown({
    Title = "Fake Bundle (Visual)",
    Values = {"Headless", "Korblox (Fixing)"},
    Multi = true,
    Callback = function(values)
        if table.find(values, "Headless") and not headlessEnabled then
            headlessEnabled = true
            applyHeadless()
        elseif not table.find(values, "Headless") and headlessEnabled then
            headlessEnabled = false
            removeHeadless()
        end

        if table.find(values, "Korblox (Fixing)") and not korbloxEnabled then
            korbloxEnabled = true
            applyKorbloxRightLeg()
        elseif not table.find(values, "Korblox (Fixing)") and korbloxEnabled then
            korbloxEnabled = false
            removeKorbloxRightLeg()
        end
    end
})

FakeTab:Toggle({
    Title = "Loop Fake Bundle",
    Callback = function(state)
        loopFakeBundleEnabled = state
        if loopFakeBundleEnabled then
            if not loopFakeBundleConnection then
                loopFakeBundleConnection = game:GetService("RunService").Heartbeat:Connect(function()
                    applyKorbloxRightLeg()
                    applyHeadless()
                end)
            end
        else
            if loopFakeBundleConnection then
                loopFakeBundleConnection:Disconnect()
                loopFakeBundleConnection = nil
            end
        end
    end
})

local removeAllHatw = false

FakeTab:Toggle({
    Title = "Remove All Hats",
    Callback = function(state)
        removeAllHatw = state
        if state then
            removeAllHats()
        end
    end
}) 

Players.LocalPlayer.CharacterAdded:Connect(function(character)
    if headlessEnabled then
        task.wait(0.1) -- Small delay to ensure character fully loads
        applyHeadless()
    end
    if korbloxEnabled then
        task.wait(0.1) -- Small delay
        applyKorbloxRightLeg()
    end
end)

-- ===== Esp Tab
local ActiveEspPlayers = false
local ActiveEspBots = false
local ActiveEspSummerEvent = false
local ActiveDistanceEsp = false

local function CreateEsp(Char, Color, Text, ParentPart, YOffset)
    if not Char or not ParentPart or not ParentPart:IsA("BasePart") then return end
    if Char:FindFirstChild("ESP_Highlight") and ParentPart:FindFirstChild("ESP") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.Adornee = Char
    highlight.FillColor = Color
    highlight.FillTransparency = 0.8
    highlight.OutlineColor = Color
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Enabled = true
    highlight.Parent = Char

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP"
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, YOffset, 0)
    billboard.Adornee = ParentPart
    billboard.Enabled = true
    billboard.Parent = ParentPart

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = tostring(Text) or ""
    label.TextColor3 = Color
    label.TextScaled = true
    label.Font = Enum.Font.SourceSansBold
    label.Parent = billboard

    spawn(function()
        local Camera = Workspace.CurrentCamera
        while highlight.Parent and billboard.Parent and ParentPart.Parent and Camera do
            local cameraPosition = Camera.CFrame.Position
            local distance = (cameraPosition - ParentPart.Position).Magnitude
            local safeText = tostring(Text) or ""
            if ActiveDistanceEsp then
                label.Text = safeText .. " " .. tostring(math.floor(distance + 0.5)) .. " Studs"
            else
                label.Text = safeText
            end
            task.wait(0.1)
        end
        if highlight then highlight:Destroy() end
        if billboard then billboard:Destroy() end
    end)
end

local function RemoveEsp(Char, ParentPart)
    if Char then
        local highlight = Char:FindFirstChild("ESP_Highlight")
        if highlight then highlight:Destroy() end
    end
    if ParentPart then
        local billboard = ParentPart:FindFirstChild("ESP")
        if billboard then billboard:Destroy() end
    end
end

-- Function to handle creating ESP for a single player
local function handlePlayerEsp(player)
    if player ~= LocalPlayer and player.Character then
        local function createPlayerEspOnCharacter(character)
            if ActiveEspPlayers and character:FindFirstChild("Head") then
                CreateEsp(character, Color3.fromRGB(0, 255, 0), player.Name, character.Head, 1)
            end
        end

        -- Check current character
        createPlayerEspOnCharacter(player.Character)

        -- Connect to CharacterAdded for respawns
        player.CharacterAdded:Connect(function(newCharacter)
            task.wait(0.1) -- Small delay for character to fully load
            createPlayerEspOnCharacter(newCharacter)
        end)

        -- Connect to CharacterRemoving to clean up ESP when character is destroyed
        player.CharacterRemoving:Connect(function(oldCharacter)
            if oldCharacter:FindFirstChild("Head") then
                RemoveEsp(oldCharacter, oldCharacter.Head)
            end
        end)
    end
end

-- Store connections to disconnect them cleanly
local playerAddedConnection = nil
local playerRemovingConnections = {}
local characterAddedConnections = {}
local characterRemovingConnections = {}
local botLoopConnection = nil
local summerEventLoopConnection = nil


EspTab:Toggle({
    Title = "Players ESP",
    Callback = function(state)
        ActiveEspPlayers = state
        if ActiveEspPlayers then
            print("[VORTX] Players ESP Enabled!")
            -- Apply ESP to all existing players
            for _, plr in pairs(Players:GetPlayers()) do
                handlePlayerEsp(plr)
            end

            -- Connect to PlayerAdded for new players
            playerAddedConnection = Players.PlayerAdded:Connect(function(newPlayer)
                handlePlayerEsp(newPlayer)
            end)

            -- Connect to PlayerRemoving to clean up ESP for leaving players
            playerRemovingConnections[playerAddedConnection] = Players.PlayerRemoving:Connect(function(leavingPlayer)
                if leavingPlayer.Character and leavingPlayer.Character:FindFirstChild("Head") then
                    RemoveEsp(leavingPlayer.Character, leavingPlayer.Character.Head)
                end
            end)

        else
            print("[VORTX] Players ESP Disabled!")
            -- Disconnect PlayerAdded listener
            if playerAddedConnection then
                playerAddedConnection:Disconnect()
                playerAddedConnection = nil
            end
            -- Disconnect PlayerRemoving listener
            if playerRemovingConnections[playerAddedConnection] then
                playerRemovingConnections[playerAddedConnection]:Disconnect()
                playerRemovingConnections[playerAddedConnection] = nil
            end
            
            -- Remove ESP from all current players
            for _, plr in pairs(Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("Head") then
                    RemoveEsp(plr.Character, plr.Character.Head)
                end
            end
        end
    end
})

EspTab:Toggle({
    Title = "NextBots ESP",
    Callback = function(state)
        ActiveEspBots = state
        if ActiveEspBots then
            print("[VORTX] NextBots ESP Enabled!")
            botLoopConnection = game:GetService("RunService").Heartbeat:Connect(function()
                local botsFolder = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Players")
                if botsFolder then
                    for _, bot in pairs(botsFolder:GetChildren()) do
                        if bot:IsA("Model") and bot:FindFirstChild("Hitbox") then
                            bot.Hitbox.Transparency = 0.5
                            CreateEsp(bot, Color3.fromRGB(255, 0, 0), bot.Name, bot.Hitbox, -2)
                        end
                    end
                end
            end)
        else
            print("[VORTX] NextBots ESP Disabled!")
            if botLoopConnection then
                botLoopConnection:Disconnect()
                botLoopConnection = nil
            end
            local botsFolder = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Players")
            if botsFolder then
                for _, bot in pairs(botsFolder:GetChildren()) do
                    if bot:IsA("Model") and bot:FindFirstChild("Hitbox") then
                        bot.Hitbox.Transparency = 1
                        RemoveEsp(bot, bot.Hitbox)
                    end
                end
            end
        end
    end
})

EspTab:Toggle({
    Title = "Summer Event ESP",
    Callback = function(state)
        ActiveEspSummerEvent = state
        if ActiveEspSummerEvent then
            print("[VORTX] Summer Event ESP Enabled!")
            summerEventLoopConnection = game:GetService("RunService").Heartbeat:Connect(function()
                local ticketsFolder = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Effects") and Workspace.Game.Effects:FindFirstChild("Tickets")
                if ticketsFolder then
                    for _, ticket in pairs(ticketsFolder:GetChildren()) do
                        if ticket and ticket.PrimaryPart and ticket.Name == "Visual" then
                            CreateEsp(ticket, Color3.fromRGB(255, 255, 0), "Ticket", ticket.PrimaryPart, -2)
                        end
                    end
                end
            end)
        else
            print("[VORTX] Summer Event ESP Disabled!")
            if summerEventLoopConnection then
                summerEventLoopConnection:Disconnect()
                summerEventLoopConnection = nil
            end
            local ticketsFolder = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Effects") and Workspace.Game.Effects:FindFirstChild("Tickets")
            if ticketsFolder then
                for _, ticket in pairs(ticketsFolder:GetChildren()) do
                    if ticket and ticket.PrimaryPart then
                        RemoveEsp(ticket, ticket.PrimaryPart)
                    end
                end
            end
        end
    end
})

EspTab:Toggle({
    Title = "Distance ESP",
    Callback = function(state)
        ActiveDistanceEsp = state
        if ActiveDistanceEsp then
            print("[VORTX] Distance ESP Enabled!")
        else
            print("[VORTX] Distance ESP Disabled!")
        end
    end
})

local autoReviveEnabled = false
local lastCheckTime = 0
local checkInterval = 5

ReviveTab:Button({
    Title = "Revive Yourself",
    Callback = function()
        local player = LocalPlayer
        local character = player.Character
        if character and character:GetAttribute("Downed") then
            ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
            print("[VORTX] ✅ Revived!")
        else
            print("[VORTX] ⚠️ You are not Downed yet!")
        end
    end
})

ReviveTab:Toggle({
    Title = "Auto Revive Yourself",
    Callback = function(state)
        autoReviveEnabled = state
        if autoReviveEnabled then
            print("[VORTX] Auto Revive Enabled")
        else
            print("[VORTX] Auto Revive Disabled")
        end
    end
})

RunService.Heartbeat:Connect(function()
    if autoReviveEnabled then
        if tick() - lastCheckTime >= checkInterval then
            lastCheckTime = tick()
            local player = LocalPlayer
            local character = player.Character
            if character and character:GetAttribute("Downed") then
                ReplicatedStorage.Events.Player.ChangePlayerMode:FireServer(true)
                print("[VORTX] ✅ Auto-Revived!")
            end
        end
    end
end)
