--====================--
--== VORTX HUB UI ==--
--====================--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

--====================--
--== UI Configuration ==--
--====================--

local UI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local IntroFrame = Instance.new("Frame")
local IntroTextLabel = Instance.new("TextLabel")
local TabsFrame = Instance.new("Frame")
local ContentFrame = Instance.new("Frame")
local InfoTabContent = Instance.new("Frame")
local LogoFrame = Instance.new("Frame")
local LogoImage = Instance.new("ImageLabel")
local DiscordButton = Instance.new("TextButton")
local UICorner2 = Instance.new("UICorner")
local ToggleButton = Instance.new("TextButton")
local UICorner3 = Instance.new("UICorner")
local MinimizeButton = Instance.new("TextButton")
local UICorner4 = Instance.new("UICorner")
local MaximizeButton = Instance.new("TextButton")
local UICorner5 = Instance.new("UICorner")
local CloseButton = Instance.new("TextButton")
local UICorner6 = Instance.new("UICorner")
local ExecutorLabel = Instance.new("TextLabel")
local UserNameLabel = Instance.new("TextLabel")
local FeaturesTabContent = Instance.new("Frame")
local SettingsTabContent = Instance.new("Frame")
local SliderFrame = Instance.new("Frame")
local SliderBackground = Instance.new("Frame")
local SliderButton = Instance.new("Frame")
local UICorner7 = Instance.new("UICorner")

--====================--
--== UI Properties ==--
--====================--

UI.Name = "VortXHubUI"
UI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

--====================--
--== Main Frame ==--
--====================--

MainFrame.Name = "MainFrame"
MainFrame.Parent = UI
MainFrame.Active = true
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 450, 0, 550)

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

--====================--
--== Intro Frame ==--
--====================--

IntroFrame.Name = "IntroFrame"
IntroFrame.Parent = MainFrame
IntroFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IntroFrame.BackgroundTransparency = 0.6
IntroFrame.Size = UDim2.new(1, 0, 1, 0)

UICorner2.CornerRadius = UDim.new(0, 15)
UICorner2.Parent = IntroFrame

IntroTextLabel.Name = "IntroTextLabel"
IntroTextLabel.Parent = IntroFrame
IntroTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
IntroTextLabel.BackgroundTransparency = 1.0
IntroTextLabel.Size = UDim2.new(0.8, 0, 0.3, 0)
IntroTextLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
IntroTextLabel.Font = Enum.Font.SourceSansBold
IntroTextLabel.Text = ""
IntroTextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
IntroTextLabel.TextScaled = true
IntroTextLabel.TextSize = 30.0
IntroTextLabel.TextWrapped = true
IntroTextLabel.TextStrokeTransparency = 0.5

--====================--
--== Content Frame ==--
--====================--

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ContentFrame.Position = UDim2.new(0, 0, 0.15, 0)
ContentFrame.Size = UDim2.new(1, 0, 0.75, 0)

UICorner3.CornerRadius = UDim.new(0, 15)
UICorner3.Parent = ContentFrame

--====================--
--== Tabs Frame ==--
--====================--

TabsFrame.Name = "TabsFrame"
TabsFrame.Parent = MainFrame
TabsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TabsFrame.Size = UDim2.new(1, 0, 0.15, 0)

--====================--
--== Info Tab Content ==--
--====================--

InfoTabContent.Name = "InfoTabContent"
InfoTabContent.Parent = ContentFrame
InfoTabContent.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
InfoTabContent.Size = UDim2.new(1, 0, 1, 0)
InfoTabContent.Visible = true

UICorner8.CornerRadius = UDim.new(0, 10)
UICorner8.Parent = InfoTabContent

-- Owner Label
OwnerLabel.Name = "OwnerLabel"
OwnerLabel.Parent = InfoTabContent
OwnerLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
OwnerLabel.BackgroundTransparency = 1
OwnerLabel.Position = UDim2.new(0, 0, 0.1, 0)
OwnerLabel.Size = UDim2.new(1, 0, 0.2, 0)
OwnerLabel.Font = Enum.Font.SourceSansSemibold
OwnerLabel.Text = "OWNER OF VORTX HUB: YourName"
OwnerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
OwnerLabel.TextSize = 18.0
OwnerLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Discord Link
DiscordLinkLabel.Name = "DiscordLinkLabel"
DiscordLinkLabel.Parent = InfoTabContent
DiscordLinkLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
DiscordLinkLabel.BackgroundTransparency = 1
DiscordLinkLabel.Position = UDim2.new(0, 0, 0.3, 0)
DiscordLinkLabel.Size = UDim2.new(1, 0, 0.2, 0)
DiscordLinkLabel.Font = Enum.Font.SourceSansSemibold
DiscordLinkLabel.Text = "Discord Link:"
DiscordLinkLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordLinkLabel.TextSize = 18.0
DiscordLinkLabel.TextXAlignment = Enum.TextXAlignment.Center

-- Copy Discord Button
CopyDiscordButton.Name = "CopyDiscordButton"
CopyDiscordButton.Parent = InfoTabContent
CopyDiscordButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
CopyDiscordButton.Position = UDim2.new(0.35, 0, 0.4, 0)
CopyDiscordButton.Size = UDim2.new(0.3, 0, 0.15, 0)
CopyDiscordButton.Font = Enum.Font.SourceSans
CopyDiscordButton.Text = "Copy Link"
CopyDiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyDiscordButton.TextSize = 14.0

UICorner8.CornerRadius = UDim.new(0, 10)
UICorner8.Parent = CopyDiscordButton

-- Discord Button
DiscordButton.Name = "DiscordButton"
DiscordButton.Parent = InfoTabContent
DiscordButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
DiscordButton.Position = UDim2.new(0.65, 0, 0.4, 0)
DiscordButton.Size = UDim2.new(0.3, 0, 0.15, 0)
DiscordButton.Font = Enum.Font.SourceSans
DiscordButton.Text = "Discord"
DiscordButton.TextColor3 = Color3.fromRGB(255, 0, 0)
DiscordButton.TextSize = 14.0

UICorner9.CornerRadius = UDim.new(0, 10)
UICorner9.Parent = DiscordButton

--====================--
--== UI Functions ==--
--====================--

local function createTab(name, position)
    local tab = Instance.new("TextButton")
    tab.Name = name
    tab.Parent = TabsFrame
    tab.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    tab.Position = UDim2.new(position, 0, 0, 0)
    tab.Size = UDim2.new(0.25, 0, 1, 0)
    tab.Font = Enum.Font.SourceSans
    tab.Text = name
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.TextSize = 14.0

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 10)
    tabCorner.Parent = tab

    tab.MouseButton1Click:Connect(function()
        InfoTabContent.Visible = name == "Info"
        FeaturesTabContent.Visible = name == "Features"
        SettingsTabContent.Visible = name == "Settings"
    end)

    return tab
end

local function animateIntro()
    local letters = {"V", "O", "R", "T", "X"}
    local letterDelay = 0.3
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

    for i, letter in ipairs(letters) do
        local letterTween = TweenService:Create(IntroTextLabel, tweenInfo, {Text = table.concat(letters, " ", 1, i)})
        letterTween:Play()
        wait(letterDelay)
    end

    wait(1)
    local fadeOut = TweenService:Create(IntroFrame, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
    fadeOut:Play()
    wait(1)
    IntroFrame:Destroy()
end

local function createToggle(parent, position, size)
    local toggle = Instance.new("TextButton")
    toggle.Name = "Toggle"
    toggle.Parent = parent
    toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    toggle.Position = position
    toggle.Size = size
    toggle.Font = Enum.Font.SourceSans
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.TextSize = 14.0

    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 10)
    toggleCorner.Parent = toggle

    local function toggleSwitch()
        if toggle.Text == "OFF" then
            toggle.Text = "ON"
            toggle.TextColor3 = Color3.fromRGB(0, 255, 0)
            toggle.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            local tween = TweenService:Create(toggle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 100, 0)})
            tween:Play()
        else
            toggle.Text = "OFF"
            toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            local tween = TweenService:Create(toggle, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)})
            tween:Play()
        end
    end

    toggle.MouseButton1Click:Connect(toggleSwitch)

    return toggle
end

--====================--
--== Initialize UI ==--
--====================--

-- Create tabs
local infoTab = createTab("Info", 0)
local featuresTab = createTab("Features", 0.25)
local settingsTab = createTab("Settings", 0.5)

-- Animate intro
animateIntro()

-- Create toggle
local myToggle = createToggle(ContentFrame, UDim2.new(0.1, 0, 0.3, 0), UDim2.new(0.2, 0, 0.1, 0))

--====================--
--== Mobile Support ==--
--====================--

local isDragging = false
local dragPosition = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(0.5, delta.X - MainFrame.AbsoluteSize.X / 2, 0.5, delta.Y - MainFrame.AbsoluteSize.Y / 2)
    end
end)

--====================--
--== UI Interactions ==--
--====================--

-- Discord button
DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/TXebwYcPaB") -- Replace with your Discord link
    print("Discord link copied to clipboard!")
end)

-- Toggle button
local isToggled = false
ToggleButton.MouseButton1Click:Connect(function()
    isToggled = not isToggled
    if isToggled then
        ToggleButton.Text = "ON"
        ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 0)
        local tween = TweenService:Create(ToggleButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 100, 0)})
        tween:Play()
    else
        ToggleButton.Text = "OFF"
        ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        local tween = TweenService:Create(ToggleButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(50, 50, 60)})
        tween:Play()
    end
end)

-- Minimize button
MinimizeButton.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 450, 0, 50)})
    tween:Play()
end)

-- Maximize button
MaximizeButton.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 450, 0, 550)})
    tween:Play()
end)

-- Close button
CloseButton.MouseButton1Click:Connect(function()
    UI:Destroy()
end)

-- Copy Discord button
CopyDiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/TXebwYcPaB")
    print("Discord link copied to clipboard!")
end)

-- Make UI draggable
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(0.5, delta.X - MainFrame.AbsoluteSize.X / 2, 0.5, delta.Y - MainFrame.AbsoluteSize.Y / 2)
    end
end)
