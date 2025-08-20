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
local TitleBar = Instance.new("Frame")
local UICorner2 = Instance.new("UICorner")
local ExecutorLabel = Instance.new("TextLabel")
local UserLabel = Instance.new("TextLabel")
local MinimizeButton = Instance.new("TextButton")
local MaximizeButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local UICorner3 = Instance.new("UICorner")
local ContentFrame = Instance.new("Frame")
local UICorner4 = Instance.new("UICorner")
local InfoFrame = Instance.new("Frame")
local UICorner5 = Instance.new("UICorner")
local OwnerLabel = Instance.new("TextLabel")
local CopyButton = Instance.new("TextButton")
local UICorner6 = Instance.new("UICorner")
local DiscordButton = Instance.new("TextButton")
local UICorner7 = Instance.new("UICorner")
local ToggleFrame = Instance.new("Frame")
local UICorner8 = Instance.new("UICorner")
local ToggleButton = Instance.new("TextButton")
local UICorner9 = Instance.new("UICorner")
local SliderFrame = Instance.new("Frame")
local UICorner10 = Instance.new("UICorner")
local SliderBackground = Instance.new("Frame")
local SliderButton = Instance.new("Frame")
local UICorner11 = Instance.new("UICorner")
local LogoCircle = Instance.new("ImageLabel")
local UICorner12 = Instance.new("UICorner")

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
MainFrame.ClipsDescendants = true

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

--====================--
--== Title Bar ==--
--====================--

TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TitleBar.Size = UDim2.new(1, 0, 0.1, 0)
TitleBar.BorderSize = Enum.BorderSize.None

UICorner2.CornerRadius = UDim.new(0, 10)
UICorner2.Parent = TitleBar

--====================--
--== Executor Label ==--
--====================--

ExecutorLabel.Name = "ExecutorLabel"
ExecutorLabel.Parent = TitleBar
ExecutorLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ExecutorLabel.BackgroundTransparency = 1
ExecutorLabel.Position = UDim2.new(0.1, 0, 0, 0)
ExecutorLabel.Size = UDim2.new(0.4, 0, 1, 0)
ExecutorLabel.Font = Enum.Font.SourceSansSemibold
ExecutorLabel.Text = "Executor: VortX Hub"
ExecutorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecutorLabel.TextSize = 14.0

--====================--
--== User Label ==--
--====================--

UserLabel.Name = "UserLabel"
UserLabel.Parent = TitleBar
UserLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
UserLabel.BackgroundTransparency = 1
UserLabel.Position = UDim2.new(0.55, 0, 0, 0)
UserLabel.Size = UDim2.new(0.4, 0, 1, 0)
UserLabel.Font = Enum.Font.SourceSansSemibold
UserLabel.Text = "User: " .. player.Name
UserLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
UserLabel.TextSize = 14.0

--====================--
--== Minimize Button ==--
--====================--

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
MinimizeButton.Position = UDim2.new(0.75, 0, 0, 0)
MinimizeButton.Size = UDim2.new(0.075, 0, 1, 0)
MinimizeButton.Font = Enum.Font.SourceSans
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 18.0

UICorner3.CornerRadius = UDim.new(0, 10)
UICorner3.Parent = MinimizeButton

--====================--
--== Maximize Button ==--
--====================--

MaximizeButton.Name = "MaximizeButton"
MaximizeButton.Parent = TitleBar
MaximizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
MaximizeButton.Position = UDim2.new(0.85, 0, 0, 0)
MaximizeButton.Size = UDim2.new(0.075, 0, 1, 0)
MaximizeButton.Font = Enum.Font.SourceSans
MaximizeButton.Text = "□"
MaximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MaximizeButton.TextSize = 18.0

UICorner4 = Instance.new("UICorner")
UICorner4.CornerRadius = UDim.new(0, 10)
UICorner4.Parent = MaximizeButton

--====================--
--== Close Button ==--
--====================--

CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
CloseButton.Position = UDim2.new(0.95, 0, 0, 0)
CloseButton.Size = UDim2.new(0.075, 0, 1, 0)
CloseButton.Font = Enum.Font.SourceSans
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.TextSize = 18.0

UICorner5 = Instance.new("UICorner")
UICorner5.CornerRadius = UDim.new(0, 10)
UICorner5.Parent = CloseButton

--====================--
--== Content Frame ==--
--====================--

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
ContentFrame.Position = UDim2.new(0, 0, 0.1, 0)
ContentFrame.Size = UDim2.new(1, 0, 0.9, 0)

UICorner6 = Instance.new("UICorner")
UICorner6.CornerRadius = UDim.new(0, 10)
UICorner6.Parent = ContentFrame

--====================--
--== Info Frame ==--
--====================--

InfoFrame.Name = "InfoFrame"
InfoFrame.Parent = ContentFrame
InfoFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
InfoFrame.Position = UDim2.new(0, 0, 0.1, 0)
InfoFrame.Size = UDim2.new(1, 0, 0.8, 0)

UICorner7 = Instance.new("UICorner")
UICorner7.CornerRadius = UDim.new(0, 10)
UICorner7.Parent = InfoFrame

--====================--
--== Logo Circle ==--
--====================--

LogoCircle.Name = "LogoCircle"
LogoCircle.Parent = ContentFrame
LogoCircle.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
LogoCircle.Position = UDim2.new(0.4, 0, 0.025, 0)
LogoCircle.Size = UDim2.new(0.2, 0, 0.2, 0)
LogoCircle.Image = "rbxassetid://0" -- Replace with your logo image ID
LogoCircle.BackgroundTransparency = 1

UICorner12.CornerRadius = UDim.new(0, 100)
UICorner12.Parent = LogoCircle

--====================--
--== Owner Label ==--
--====================--

OwnerLabel.Name = "OwnerLabel"
OwnerLabel.Parent = InfoFrame
OwnerLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
OwnerLabel.BackgroundTransparency = 1
OwnerLabel.Position = UDim2.new(0, 0, 0.1, 0)
OwnerLabel.Size = UDim2.new(1, 0, 0.2, 0)
OwnerLabel.Font = Enum.Font.SourceSansSemibold
OwnerLabel.Text = "OWNER OF VORTX HUB: YourName"
OwnerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
OwnerLabel.TextSize = 16.0
OwnerLabel.TextXAlignment = Enum.TextXAlignment.Center

--====================--
--== Copy Button ==--
--====================--

CopyButton.Name = "CopyButton"
CopyButton.Parent = InfoFrame
CopyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
CopyButton.Position = UDim2.new(0.35, 0, 0.4, 0)
CopyButton.Size = UDim2.new(0.3, 0, 0.15, 0)
CopyButton.Font = Enum.Font.SourceSans
CopyButton.Text = "Copy Link"
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.TextSize = 14.0

UICorner8.CornerRadius = UDim.new(0, 10)
UICorner8.Parent = CopyButton

--====================--
--== Discord Button ==--
--====================--

DiscordButton.Name = "DiscordButton"
DiscordButton.Parent = InfoFrame
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
--== Toggle Frame ==--
--====================--

ToggleFrame.Name = "ToggleFrame"
ToggleFrame.Parent = InfoFrame
ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ToggleFrame.Position = UDim2.new(0.15, 0, 0.65, 0)
ToggleFrame.Size = UDim2.new(0.7, 0, 0.15, 0)

UICorner10.CornerRadius = UDim.new(0, 10)
UICorner10.Parent = ToggleFrame

--====================--
--== Toggle Button ==--
--====================--

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ToggleFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.Position = UDim2.new(0, 0, 0.5, -10)
ToggleButton.Size = UDim2.new(0, 20, 0, 20)
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.Text = ""
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextSize = 14.0

UICorner11.CornerRadius = UDim.new(0, 100)
UICorner11.Parent = ToggleButton

--====================--
--== Slider Frame ==--
--====================--

SliderFrame.Name = "SliderFrame"
SliderFrame.Parent = InfoFrame
SliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
SliderFrame.Position = UDim2.new(0.1, 0, 0.85, 0)
SliderFrame.Size = UDim2.new(0.8, 0, 0.1, 0)

UICorner12.CornerRadius = UDim.new(0, 10)
UICorner12.Parent = SliderFrame

SliderBackground.Name = "SliderBackground"
SliderBackground.Parent = SliderFrame
SliderBackground.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
SliderBackground.Size = UDim2.new(0.9, 0, 1, 0)
SliderBackground.Position = UDim2.new(0.05, 0, 0, 0)

SliderButton.Name = "SliderButton"
SliderButton.Parent = SliderBackground
SliderButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
SliderButton.Size = UDim2.new(0.5, 0, 1, 0)
SliderButton.Position = UDim2.new(0, 0, 0, 0)
SliderButton.BorderSize = Enum.BorderSize.None

UICorner13 = Instance.new("UICorner")
UICorner13.CornerRadius = UDim.new(0, 5)
UICorner13.Parent = SliderButton

--====================--
--== UI Functions ==--
--====================--

local isDragging = false
local dragPosition = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local newPosition = Vector2.new(input.Position.X - dragPosition.X, input.Position.Y - dragPosition.Y)
        MainFrame.Position = UDim2.new(0.5, newPosition.X - MainFrame.AbsoluteSize.X / 2, 0.5, newPosition.Y - MainFrame.AbsoluteSize.Y / 2)
    end
end)

--====================--
--== UI Interactions ==--
--====================--

-- Close button
CloseButton.MouseButton1Click:Connect(function()
    UI:Destroy()
end)

-- Minimize button
local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    if not isMinimized then
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 450, 0, 30)})
        tween:Play()
        isMinimized = true
    else
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 450, 0, 550)})
        tween:Play()
        isMinimized = false
    end
end)

-- Maximize button
local isMaximized = false
MaximizeButton.MouseButton1Click:Connect(function()
    if not isMaximized then
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, -30, 1, -30)})
        tween:Play()
        isMaximized = true
    else
        local tween = TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 450, 0, 550)})
        tween:Play()
        isMaximized = false
    end
end)

-- Copy button
CopyButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/TXebwYcPaB")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Link Copied";
        Text = "Discord link copied to clipboard!";
        Duration = 5;
    })
end)

-- Discord button
DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/TXebwYcPaB")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Link Copied";
        Text = "Discord link copied to clipboard!";
        Duration = 5;
    })
end)

-- Toggle button
local isToggled = false
ToggleButton.MouseButton1Click:Connect(function()
    if not isToggled then
        local tween = TweenService:Create(ToggleButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 255, 0)})
        tween:Play()
        isToggled = true
    else
        local tween = TweenService:Create(ToggleButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)})
        tween:Play()
        isToggled = false
    end
end)

-- Slider functionality
local isDraggingSlider = false
SliderButton.MouseButton1Down:Connect(function()
    isDraggingSlider = true
end)

UserInputService.InputChanged:Connect(function(input)
    if isDraggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
        local newPosition = math.clamp((input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1)
        local tween = TweenService:Create(SliderButton, TweenInfo.new(0.1), {Size = UDim2.new(newPosition, 0, 1, 0)})
        tween:Play()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDraggingSlider = false
    end
end)
