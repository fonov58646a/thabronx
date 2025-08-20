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
local SliderButton = Instance.new("TextButton")
local UICorner7 = Instance.new("UICorner")
local OwnerLabel = Instance.new("TextLabel")
local UICorner8 = Instance.new("UICorner")
local DiscordLinkLabel = Instance.new("TextLabel")
local CopyDiscordButton = Instance.new("TextButton")
local UICorner9 = Instance.new("UICorner")

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
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 550)

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

OwnerLabel.Name = "OwnerLabel"
OwnerLabel.Parent = InfoTabContent
OwnerLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
OwnerLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
OwnerLabel.Position = UDim2.new(0.1, 0, 0.1, 0)
OwnerLabel.Font = Enum.Font.SourceSansSemibold
OwnerLabel.Text = "OWNER OF VORTX HUB: YourName"
OwnerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
OwnerLabel.TextSize = 18.0
OwnerLabel.TextXAlignment = Enum.TextXAlignment.Center

DiscordLinkLabel.Name = "DiscordLinkLabel"
DiscordLinkLabel.Parent = InfoTabContent
DiscordLinkLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
DiscordLinkLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
DiscordLinkLabel.Position = UDim2.new(0.1, 0, 0.3, 0)
DiscordLinkLabel.Font = Enum.Font.SourceSansSemibold
DiscordLinkLabel.Text = "Discord Link:"
DiscordLinkLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordLinkLabel.TextSize = 18.0
DiscordLinkLabel.TextXAlignment = Enum.TextXAlignment.Center

CopyDiscordButton.Name = "CopyDiscordButton"
CopyDiscordButton.Parent = InfoTabContent
CopyDiscordButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
CopyDiscordButton.Position = UDim2.new(0.35, 0, 0.3, 0)
CopyDiscordButton.Size = UDim2.new(0.3, 0, 0.1, 0)
CopyDiscordButton.Font = Enum.Font.SourceSans
CopyDiscordButton.Text = "Copy Link"
CopyDiscordButton.TextColor3 = Color3.fromRGB(255, 0, 0)
CopyDiscordButton.TextSize = 14.0

UICorner9.CornerRadius = UDim.new(0, 10)
UICorner9.Parent = CopyDiscordButton

--====================--
--== Features Tab Content ==--
--====================--

FeaturesTabContent.Name = "FeaturesTabContent"
FeaturesTabContent.Parent = ContentFrame
FeaturesTabContent.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
FeaturesTabContent.Size = UDim2.new(1, 0, 1, 0)
FeaturesTabContent.Visible = false

UICorner10 = Instance.new("UICorner")
UICorner10.CornerRadius = UDim.new(0, 10)
UICorner10.Parent = FeaturesTabContent

--====================--
--== Settings Tab Content ==--
--====================--

SettingsTabContent.Name = "SettingsTabContent"
SettingsTabContent.Parent = ContentFrame
SettingsTabContent.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
SettingsTabContent.Size = UDim2.new(1, 0, 1, 0)
SettingsTabContent.Visible = false

UICorner11 = Instance.new("UICorner")
UICorner11.CornerRadius = UDim.new(0, 10)
UICorner11.Parent = SettingsTabContent

--====================--
--== Logo Frame ==--
--====================--

LogoFrame.Name = "LogoFrame"
LogoFrame.Parent = TabsFrame
LogoFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
LogoFrame.Position = UDim2.new(0.75, 0, 0.15, 0)
LogoFrame.Size = UDim2.new(0.15, 0, 0.7, 0)

LogoImage.Name = "LogoImage"
LogoImage.Parent = LogoFrame
LogoImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LogoImage.BackgroundTransparency = 1.0
LogoImage.Position = UDim2.new(0.1, 0, 0.15, 0)
LogoImage.Size = UDim2.new(0.8, 0, 0.7, 0)
LogoImage.Image = "rbxassetid://0" -- Replace with your logo image ID

--====================--
--== Discord Button ==--
--====================--

DiscordButton.Name = "DiscordButton"
DiscordButton.Parent = ContentFrame
DiscordButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
DiscordButton.Position = UDim2.new(0.75, 0, 0.3, 0)
DiscordButton.Size = UDim2.new(0.2, 0, 0.1, 0)
DiscordButton.Font = Enum.Font.SourceSans
DiscordButton.Text = "Discord"
DiscordButton.TextColor3 = Color3.fromRGB(255, 0, 0)
DiscordButton.TextSize = 14.0

UICorner12 = Instance.new("UICorner")
UICorner12.CornerRadius = UDim.new(0, 10)
UICorner12.Parent = DiscordButton

--====================--
--== Toggle Button ==--
--====================--

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ContentFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ToggleButton.Position = UDim2.new(0.1, 0, 0.3, 0)
ToggleButton.Size = UDim2.new(0.2, 0, 0.1, 0)
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.Text = "OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14.0

UICorner13 = Instance.new("UICorner")
UICorner13.CornerRadius = UDim.new(0, 10)
UICorner13.Parent = ToggleButton

--====================--
--== Minimize Button ==--
--====================--

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
MinimizeButton.Position = UDim2.new(0.7, 0, 0, 0)
MinimizeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
MinimizeButton.Font = Enum.Font.SourceSans
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
MinimizeButton.TextSize = 20.0

UICorner14 = Instance.new("UICorner")
UICorner14.CornerRadius = UDim.new(0, 10)
UICorner14.Parent = MinimizeButton

--====================--
--== Maximize Button ==--
--====================--

MaximizeButton.Name = "MaximizeButton"
MaximizeButton.Parent = MainFrame
MaximizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
MaximizeButton.Position = UDim2.new(0.8, 0, 0, 0)
MaximizeButton.Size = UDim2.new(0.1, 0, 0.1, 0)
MaximizeButton.Font = Enum.Font.SourceSans
MaximizeButton.Text = "□"
MaximizeButton.TextColor3 = Color3.fromRGB(255, 0, 0)
MaximizeButton.TextSize = 20.0

UICorner15 = Instance.new("UICorner")
UICorner15.CornerRadius = UDim.new(0, 10)
UICorner15.Parent = MaximizeButton

--====================--
--== Close Button ==--
--====================--

CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
CloseButton.Size = UDim2.new(0.1, 0, 0.1, 0)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextSize = 20.0

UICorner16 = Instance.new("UICorner")
UICorner16.CornerRadius = UDim.new(0, 10)
UICorner16.Parent = CloseButton

--====================--
--== Executor Label ==--
--====================--

ExecutorLabel.Name = "ExecutorLabel"
ExecutorLabel.Parent = MainFrame
ExecutorLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ExecutorLabel.Position = UDim2.new(0.1, 0, 0, 0)
ExecutorLabel.Size = UDim2.new(0.3, 0, 0.1, 0)
ExecutorLabel.Font = Enum.Font.SourceSans
ExecutorLabel.Text = "Executor: "
ExecutorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecutorLabel.TextSize = 14.0

--====================--
--== User Name Label ==--
--====================--

UserNameLabel.Name = "UserNameLabel"
UserNameLabel.Parent = MainFrame
UserNameLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
UserNameLabel.Position = UDim2.new(0.4, 0, 0, 0)
UserNameLabel.Size = UDim2.new(0.3, 0, 0.1, 0)
UserNameLabel.Font = Enum.Font.SourceSans
UserNameLabel.Text = "User: " .. player.Name
UserNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
UserNameLabel.TextSize = 14.0

--====================--
--== Slider ==--
--====================--

SliderFrame.Name = "SliderFrame"
SliderFrame.Parent = ContentFrame
SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
SliderFrame.Position = UDim2.new(0.1, 0, 0.5, 0)
SliderFrame.Size = UDim2.new(0.8, 0, 0.15, 0)

UICorner17 = Instance.new("UICorner")
UICorner17.CornerRadius = UDim.new(0, 10)
UICorner17.Parent = SliderFrame

SliderBackground.Name = "SliderBackground"
SliderBackground.Parent = SliderFrame
SliderBackground.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
SliderBackground.Position = UDim2.new(0.1, 0, 0.3, 0)
SliderBackground.Size = UDim2.new(0.8, 0, 0.4, 0)

SliderButton.Name = "SliderButton"
SliderButton.Parent = SliderBackground
SliderButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SliderButton.Size = UDim2.new(0, 20, 0, 20)
SliderButton.Position = UDim2.new(0, 0, 0.5, -10)
SliderButton.Font = Enum.Font.SourceSans
SliderButton.Text = ""
SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
SliderButton.TextSize = 14.0

UICorner18 = Instance.new("UICorner")
UICorner18.CornerRadius = UDim.new(0, 10)
UICorner18.Parent = SliderButton

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

local function createSlider()
    local isDragging = false
    local value = 0

    SliderButton.MouseButton1Down:Connect(function()
        isDragging = true
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local newPosition = math.clamp((input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1)
            value = newPosition
            SliderButton.Position = UDim2.new(value, 0, 0.5, -10)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)

    return {
        getValue = function()
            return value
        end,
        setValue = function(newValue)
            value = math.clamp(newValue, 0, 1)
            SliderButton.Position = UDim2.new(value, 0, 0.5, -10)
        end
    }
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

-- Create slider
local mySlider = createSlider()

--====================--
--== Mobile Support ==--
--====================--

local isDragging = false
local dragPosition = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        local mousePosition = input.Position
        dragPosition = Vector2.new(mousePosition.X - MainFrame.AbsolutePosition.X, mousePosition.Y - MainFrame.AbsolutePosition.Y)
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                isDragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local newPosition = Vector2.new(input.Position.X - dragPosition.X, input.Position.Y - dragPosition.Y)
        MainFrame.Position = UDim2.new(0.5, newPosition.X - MainFrame.AbsoluteSize.X / 2, 0.5, newPosition.Y - MainFrame.AbsoluteSize.Y / 2)
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
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 50)})
    tween:Play()
end)

-- Maximize button
MaximizeButton.MouseButton1Click:Connect(function()
    local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 550)})
    tween:Play()
end)

-- Close button
CloseButton.MouseButton1Click:Connect(function()
    UI:Destroy()
end)

-- Copy Discord link button
CopyDiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/TXebwYcPaB")
    print("Discord link copied to clipboard!")
end)

--====================--
--== Final Touches ==--
--====================--

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
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
