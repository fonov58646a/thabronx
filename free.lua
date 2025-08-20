-- VortxHub Interface Suite
-- Version 1.0.0

-- // SERVICES
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- // MAIN UI TABLE
local VortxHub = {}
VortxHub.__index = VortxHub

-- // CONFIGURATION
VortxHub.configuration = {
    Name = "VortxHub Interface Suite",
    Version = "1.0.0",
    Theme = {
        Primary = Color3.fromRGB(255, 0, 0),
        Secondary = Color3.fromRGB(40, 0, 0),
        Background = Color3.fromRGB(30, 0, 0),
        Text = Color3.fromRGB(255, 255, 255)
    },
    Keybind = Enum.KeyCode.RightControl,
    IntroEnabled = true,
    MobileSupport = true,
    PC_Support = true
}

-- // CORE UI OBJECTS
VortxHub.ui = nil
VortxHub.window = nil
VortxHub.notifications = {}
VortxHub.configs = {}
VortxHub.elements = {}

-- // CREATE MAIN UI
function VortxHub.new()
    local self = setmetatable({}, VortxHub)
    
    -- // CREATE SCREEN GUI
    self.ui = Instance.new("ScreenGui")
    self.ui.Name = "VortxHubUI"
    self.ui.IgnoreGuiInset = true
    self.ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- // CREATE MAIN WINDOW
    self:createMainWindow()
    
    -- // CREATE TAB SYSTEM
    self.tabs = {}
    self.currentTab = nil
    
    return self
end

function VortxHub:createMainWindow()
    -- // CREATE FRAME
    self.window = Instance.new("Frame")
    self.window.Size = UDim2.new(0, 550, 0, 600)
    self.window.Position = UDim2.new(0.5, -275, 0.5, -300)
    self.window.BackgroundColor3 = self.configuration.Theme.Background
    self.window.BorderSizePixel = 0
    self.window.CornerRadius = UDim.new(0, 15)
    self.window.Parent = self.ui
    
    -- // CREATE BG EFFECT
    local bgEffect = Instance.new("Frame")
    bgEffect.Size = UDim2.new(1, 0, 1, 0)
    bgEffect.BackgroundColor3 = self.configuration.Theme.Primary
    bgEffect.BackgroundTransparency = 0.85
    bgEffect.BorderSizePixel = 0
    bgEffect.ZIndex = -1
    bgEffect.Parent = self.window
    
    -- // CREATE TITLE BAR
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.BackgroundColor3 = self.configuration.Theme.Primary
    titleBar.Parent = self.window
    
    -- // CREATE TITLE TEXT
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 1, 0)
    title.Text = self.configuration.Name
    title.TextColor3 = self.configuration.Theme.Text
    title.Font = Enum.Font.Cartoon
    title.TextScaled = true
    title.Parent = titleBar
    
    -- // CREATE CONTENT AREA
    self.contentArea = Instance.new("ScrollingFrame")
    self.contentArea.Size = UDim2.new(1, 0, 1, -50)
    self.contentArea.Position = UDim2.new(0, 0, 0, 50)
    self.contentArea.BackgroundColor3 = self.configuration.Theme.Secondary
    self.contentArea.BorderSizePixel = 0
    self.contentArea.ScrollBarThickness = 4
    self.contentArea.Parent = self.window
    
    -- // ENABLE DRAGGING
    self:enableDragging(titleBar)
    
    -- // CREATE CLOSE BUTTON
    self:createCloseButton()
end

function VortxHub:enableDragging(dragPart)
    local dragToggle = false
    local dragOffset = Vector2.new(0, 0)
    
    dragPart.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true
            dragOffset = Vector2.new(
                self.window.Position.X.Offset - input.Position.X,
                self.window.Position.Y.Offset - input.Position.Y
            )
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragToggle and 
           (input.UserInputType == Enum.UserInputType.MouseMovement or 
            input.UserInputType == Enum.UserInputType.Touch) then
            self.window.Position = UDim2.new(
                0.5, -self.window.Size.X.Offset/2 + input.Position.X + dragOffset.X,
                0.5, -self.window.Size.Y.Offset/2 + input.Position.Y + dragOffset.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = false
        end
    end)
end

function VortxHub:createCloseButton()
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 40, 0, 40)
    closeButton.Position = UDim2.new(1, -40, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = self.configuration.Theme.Text
    closeButton.Font = Enum.Font.SourceSans
    closeButton.Parent = self.window
    
    closeButton.MouseButton1Click:Connect(function()
        self.ui.Enabled = false
        task.wait(0.5)
        self.ui.Enabled = true
    end)
end

-- // TAB SYSTEM
function VortxHub:createTab(name, callback)
    -- // TAB CONTAINER
    if not self.tabContainer then
        self.tabContainer = Instance.new("Frame")
        self.tabContainer.Size = UDim2.new(0, 80, 1, 0)
        self.tabContainer.BackgroundColor3 = self.configuration.Theme.Secondary
        self.tabContainer.Parent = self.window
    end
    
    -- // CREATE TAB BUTTON
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(1, 0, 0, 40)
    tab.BackgroundColor3 = self.configuration.Theme.Background
    tab.AutoButtonColor = false
    tab.Text = name
    tab.TextColor3 = self.configuration.Theme.Text
    tab.Font = Enum.Font.SourceSans
    tab.Parent = self.tabContainer
    
    -- // CUSTOM ICON
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(1, 0, 1, 0)
    icon.Image = "rbxassetid://YOUR_LOGO_ID" -- Replace with your logo
    icon.BackgroundTransparency = 1
    icon.Parent = tab
    
    -- // TAB CONTENT FRAME
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -80, 1, 0)
    content.Position = UDim2.new(0, 80, 0, 0)
    content.BackgroundColor3 = self.configuration.Theme.Background
    content.Parent = self.window
    
    content.Visible = false
    
    -- // TAB INTERACTION
    tab.MouseEnter:Connect(function()
        TweenService:Create(tab, TweenInfo.new(0.2), {BackgroundColor3 = self.configuration.Theme.Primary}):Play()
    end)
    
    tab.MouseLeave:Connect(function()
        if tab ~= self.currentTab then
            TweenService:Create(tab, TweenInfo.new(0.2), {BackgroundColor3 = self.configuration.Theme.Background}):Play()
        end
    end)
    
    tab.MouseButton1Click:Connect(function()
        -- // HIDE PREVIOUS TABS
        if self.currentTab then
            self.currentTab.Visible = false
        end
        
        -- // SHOW NEW TAB
        content.Visible = true
        self.currentTab = content
        
        -- // UPDATE UI
        for _, t in ipairs(self.tabContainer:GetChildren()) do
            if t:IsA("TextButton") then
                TweenService:Create(t, TweenInfo.new(0.2), {BackgroundColor3 = self.configuration.Theme.Background}):Play()
            end
        end
        
        TweenService:Create(tab, TweenInfo.new(0.2), {BackgroundColor3 = self.configuration.Theme.Primary}):Play()
        
        -- // RUN CALLBACK
        if callback then callback(content) end
    end)
    
    -- // STORE TAB REFERENCE
    table.insert(self.tabs, {button = tab, content = content})
    
    return content
end

-- // ELEMENT CREATION
function VortxHub:createLabel(parent, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 40)
    label.Position = UDim2.new(0, 10, 0, 10)
    label.Text = text
    label.TextColor3 = self.configuration.Theme.Text
    label.Font = Enum.Font.SourceSans
    label.Parent = parent
    
    return label
end

function VortxHub:createButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Position = UDim2.new(0, 10, 0, 10)
    button.Text = text
    button.TextColor3 = self.configuration.Theme.Text
    button.Font = Enum.Font.SourceSans
    button.BackgroundColor3 = self.configuration.Theme.Primary
    button.Parent = parent
    
    button.MouseButton1Click:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 0, 0)}):Play()
        task.wait(0.2)
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = self.configuration.Theme.Primary}):Play()
        
        if callback then callback() end
    end)
    
    return button
end

function VortxHub:createToggle(parent, label, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -20, 0, 40)
    toggleFrame.Position = UDim2.new(0, 10, 0, 10)
    toggleFrame.BackgroundColor3 = self.configuration.Theme.Background
    toggleFrame.Parent = parent
    
    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Size = UDim2.new(0.6, 0, 1, 0)
    toggleLabel.Text = label
    toggleLabel.TextColor3 = self.configuration.Theme.Text
    toggleLabel.Font = Enum.Font.SourceSans
    toggleLabel.Parent = toggleFrame
    
    local toggleSwitch = Instance.new("Frame")
    toggleSwitch.Size = UDim2.new(0, 50, 0, 25)
    toggleSwitch.Position = UDim2.new(0.6, 0, 0.5, -12.5)
    toggleSwitch.BackgroundColor3 = self.configuration.Theme.Secondary
    toggleSwitch.CornerRadius = UDim.new(0, 15)
    toggleSwitch.Parent = toggleFrame
    
    local toggleKnob = Instance.new("Frame")
    toggleKnob.Size = UDim2.new(0, 25, 0, 25)
    toggleKnob.Position = UDim2.new(0, 0, 0, 0)
    toggleKnob.BackgroundColor3 = self.configuration.Theme.Primary
    toggleKnob.CornerRadius = UDim.new(0, 15)
    toggleKnob.Parent = toggleSwitch
    
    local isEnabled = false
    
    toggleSwitch.MouseButton1Click:Connect(function()
        isEnabled = not isEnabled
        
        if isEnabled then
            TweenService:Create(toggleSwitch, TweenInfo.new(0.2), {BackgroundColor3 = self.configuration.Theme.Primary}):Play()
            TweenService:Create(toggleKnob, TweenInfo.new(0.2), {BackgroundColor3 = self.configuration.Theme.Text, Position = UDim2.new(1, -25, 0, 0)}):Play()
        else
            TweenService:Create(toggleSwitch, TweenInfo.new(0.2), {BackgroundColor3 = self.configuration.Theme.Secondary}):Play()
            TweenService:Create(toggleKnob, TweenInfo.new(0.2), {BackgroundColor3 = self.configuration.Theme.Primary, Position = UDim2.new(0, 0, 0, 0)}):Play()
        end
        
        if callback then callback(isEnabled) end
    end)
    
    return toggleFrame
end

function VortxHub:createSlider(parent, label, min, max, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -20, 0, 40)
    sliderFrame.Position = UDim2.new(0, 10, 0, 10)
    sliderFrame.BackgroundColor3 = self.configuration.Theme.Background
    sliderFrame.Parent = parent
    
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Size = UDim2.new(0.6, 0, 1, 0)
    sliderLabel.Text = label
    sliderLabel.TextColor3 = self.configuration.Theme.Text
    sliderLabel.Font = Enum.Font.SourceSans
    sliderLabel.Parent = sliderFrame
    
    local sliderTrack = Instance.new("Frame")
    sliderTrack.Size = UDim2.new(0.6, 0, 0, 10)
    sliderTrack.Position = UDim2.new(0.6, 0, 0.5, -5)
    sliderTrack.BackgroundColor3 = self.configuration.Theme.Secondary
    sliderTrack.CornerRadius = UDim.new(0, 5)
    sliderTrack.Parent = sliderFrame
    
    local sliderKnob = Instance.new("Frame")
    sliderKnob.Size = UDim2.new(0, 25, 0, 25)
    sliderKnob.Position = UDim2.new(0, 0, 0.5, -12.5)
    sliderKnob.BackgroundColor3 = self.configuration.Theme.Primary
    sliderKnob.CornerRadius = UDim.new(0, 15)
    sliderKnob.Parent = sliderTrack
    
    local sliderValue = Instance.new("TextLabel")
    sliderValue.Size = UDim2.new(0.3, 0, 0, 25)
    sliderValue.Position = UDim2.new(0.3, 0, 0, 15)
    sliderValue.Text = min
    sliderValue.TextColor3 = self.configuration.Theme.Text
    sliderValue.Font = Enum.Font.SourceSans
    sliderValue.Parent = sliderFrame
    
    local currentValue = min
    
    sliderTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local position = input.Position.X - sliderTrack.AbsolutePosition.X
            local percentage = math.clamp(position / sliderTrack.AbsoluteSize.X, 0, 1)
            currentValue = math.floor(min + (max - min) * percentage)
            
            sliderValue.Text = currentValue
            sliderKnob.Position = UDim2.new(percentage, -12.5, 0.5, -12.5)
            
            if callback then callback(currentValue) end
        end
    end)
    
    return sliderFrame
end

-- // NOTIFICATION SYSTEM
function VortxHub:showNotification(text, duration)
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0, 300, 0, 50)
    notification.Position = UDim2.new(0.5, -150, 0.5, -250)
    notification.Text = text
    notification.TextColor3 = self.configuration.Theme.Text
    notification.Font = Enum.Font.SourceSans
    notification.BackgroundTransparency = 0.7
    notification.BackgroundColor3 = self.configuration.Theme.Background
    notification.CornerRadius = UDim.new(0, 10)
    notification.Parent = self.ui
    
    TweenService:Create(notification, TweenInfo.new(0.3), {TextTransparency = 0, BackgroundTransparency = 0.3}):Play()
    
    table.insert(self.notifications, notification)
    
    task.wait(duration or 3)
    TweenService:Create(notification, TweenInfo.new(0.3), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
    
    task.wait(0.3)
    for i, v in ipairs(self.notifications) do
        if v == notification then
            table.remove(self.notifications, i)
            break
        end
    end
    notification:Destroy()
end

-- // CONFIGURATION SYSTEM
function VortxHub:saveConfig(name)
    local config = {
        windowSize = self.window.Size,
        windowPosition = self.window.Position,
        elements = {}
    }
    
    for _, element in ipairs(self.elements) do
        config.elements[element.name] = {
            position = element.Position,
            size = element.Size,
            value = element.value or false
        }
    end
    
    self.configs[name] = config
    self:showNotification("Config saved: " .. name, 3)
end

function VortxHub:loadConfig(name)
    if not self.configs[name] then return end
    
    local config = self.configs[name]
    self.window.Size = config.windowSize
    self.window.Position = config.windowPosition
    
    for elementName, elementConfig in pairs(config.elements) do
        for _, element in ipairs(self.elements) do
            if element.name == elementName then
                element.Position = elementConfig.position
                element.Size = elementConfig.size
                if elementConfig.value ~= nil then
                    if element.toggle then
                        element.toggle:setState(elementConfig.value)
                    end
                end
                break
            end
        end
    end
    
    self:showNotification("Config loaded: " .. name, 3)
end

-- // INTRO ANIMATION
function VortxHub:startIntro()
    if not self.configuration.IntroEnabled then return end
    
    local introScreen = Instance.new("ScreenGui")
    introScreen.Name = "VortxIntro"
    introScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local introFrame = Instance.new("Frame")
    introFrame.Size = UDim2.new(1, 0, 1, 0)
    introFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    introFrame.Parent = introScreen
    
    local introText = Instance.new("TextLabel")
    introText.Size = UDim2.new(0.8, 0, 0.8, 0)
    introText.Position = UDim2.new(0.1, 0, 0.1, 0)
    introText.Text = ""
    introText.TextColor3 = self.configuration.Theme.Primary
    introText.Font = Enum.Font.Bauhaus
    introText.TextScaled = true
    introText.TextStrokeTransparency = 0.5
    introText.Parent = introFrame
    
    local letters = {"V", "O", "R", "T", "X"}
    local delay = 0
    
    for _, letter in ipairs(letters) do
        delay += 0.5
        task.spawn(function()
            task.wait(delay)
            introText.Text = introText.Text .. letter
        end)
    end
    
    task.wait(3)
    introScreen:Destroy()
end

-- // MOBILE SUPPORT
function VortxHub:enableMobileSupport()
    if not self.configuration.MobileSupport then return end
    
    local touchGui = Instance.new("TouchGui")
    touchGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local touchFrame = Instance.new("Frame")
    touchFrame.Size = UDim2.new(1, 0, 1, 0)
    touchFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    touchFrame.BackgroundTransparency = 1
    touchFrame.Parent = touchGui
    
    touchFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            self:enableDragging(touchFrame)
        end
    end)
end

-- // PUBLIC METHODS
function VortxHub:Create()
    if game.Players.LocalPlayer and 
       game.Players.LocalPlayer:FindFirstChild("PlayerGui") then
        game.Players.LocalPlayer.PlayerGui:FindFirstChild("VortxHubUI"):Destroy()
        self.ui.Parent = game.Players.LocalPlayer.PlayerGui
    end
    
    self:startIntro()
    self:enableMobileSupport()
    
    return self.ui
end

function VortxHub:GetTheme()
    return self.configuration.Theme
end

function VortxHub:SetTheme(theme)
    self.configuration.Theme = theme
    self:updateUI()
end

function VortxHub:updateUI()
    -- // UPDATE COLORS
    self.window.BackgroundColor3 = self.configuration.Theme.Background
    self.tabContainer.BackgroundColor3 = self.configuration.Theme.Secondary
    for _, tab in ipairs(self.tabs) do
        tab.button.BackgroundColor3 = self.configuration.Theme.Background
        tab.content.BackgroundColor3 = self.configuration.Theme.Background
    end
end
