--//  VortX Hub – My Market Edition v2.0
--//  Discord: https://discord.gg/PrmHmDfT
--//  Mobile-friendly UI & FireServer-powered

local Players      = game:GetService("Players")
local Workspace    = game:GetService("Workspace")
local Replicated   = game:GetService("ReplicatedStorage")
local PathService  = game:GetService("PathfindingService")
local TweenService = game:GetService("TweenService")
local UIS          = game:GetService("UserInputService")
local RunService   = game:GetService("RunService")
local HttpService  = game:GetService("HttpService")

local LocalPlayer  = Players.LocalPlayer
local Character    = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid     = Character:WaitForChild("Humanoid")
local RootPart     = Character:WaitForChild("HumanoidRootPart")

--// Anti-cheat bypass
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(...)
    if getnamecallmethod():lower() == "kick" then return end
    return old(...)
end)

--// FireServer remotes
local Rem = {}
for _, v in pairs(Replicated:GetDescendants()) do
    if v:IsA("RemoteEvent") then Rem[v.Name] = v end
end

--// UI Library (modern)
local VortX = {}
function VortX:Window(title)
    local Gui = Instance.new("ScreenGui")
    Gui.Name = "VortXHub"
    Gui.ResetOnSpawn = false
    Gui.Parent = game:GetService("CoreGui")

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 340, 0, 500)
    Main.Position = UDim2.new(0.5, -170, 0.5, -250)
    Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true
    Main.Parent = Gui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Main

    -- Title
    local Header = Instance.new("TextLabel")
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundTransparency = 1
    Header.Text = title
    Header.TextColor3 = Color3.fromRGB(0, 195, 255)
    Header.Font = Enum.Font.GothamBold
    Header.TextSize = 18
    Header.Parent = Main

    -- Discord link
    local DiscordBtn = Instance.new("TextButton")
    DiscordBtn.Size = UDim2.new(0, 100, 0, 25)
    DiscordBtn.Position = UDim2.new(1, -110, 0, 8)
    DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    DiscordBtn.Text = "Discord"
    DiscordBtn.Font = Enum.Font.GothamBold
    DiscordBtn.TextSize = 12
    DiscordBtn.TextColor3 = Color3.white
    DiscordBtn.Parent = Main
    DiscordBtn.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/PrmHmDfT")
    end)

    -- Scroll list
    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Size = UDim2.new(1, -20, 1, -50)
    Scroll.Position = UDim2.new(0, 10, 0, 45)
    Scroll.BackgroundTransparency = 1
    Scroll.ScrollBarThickness = 4
    Scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 195, 255)
    Scroll.Parent = Main

    local List = Instance.new("UIListLayout")
    List.Padding = UDim.new(0, 6)
    List.Parent = Scroll

    return Scroll
end

function VortX:Toggle(parent, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Btn.Text = "  " .. text
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 14
    Btn.TextColor3 = Color3.white
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.Parent = parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Btn

    local on = false
    Btn.MouseButton1Click:Connect(function()
        on = not on
        Btn.BackgroundColor3 = on and Color3.fromRGB(0, 195, 255) or Color3.fromRGB(40, 40, 40)
        callback(on)
    end)
end

--// Main UI
local Window = VortX:Window("VortX Hub – My Market")

--// Toggle list
local toggles = {
    ["Auto Open Crate"] = function(on)
        while on do
            if Rem.OpenCrate then Rem.OpenCrate:FireServer() end
            task.wait(0.1)
        end
    end,
    ["Auto Buy Crates"] = function(on)
        while on do
            if Rem.BuyCrate then Rem.BuyCrate:FireServer() end
            task.wait(0.5)
        end
    end,
    ["ESP"] = function(on)
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character then
                local head = v.Character:FindFirstChild("Head")
                if head then
                    local b = Instance.new("BillboardGui")
                    b.Adornee = head
                    b.Size = UDim2.new(0, 200, 0, 50)
                    b.AlwaysOnTop = on
                    b.Parent = head
                    local l = Instance.new("TextLabel", b)
                    l.Size = UDim2.new(1, 0, 1, 0)
                    l.BackgroundTransparency = 1
                    l.Text = v.Name
                    l.TextColor3 = Color3.new(1, 1, 1)
                    l.Font = Enum.Font.SourceSans
                    l.TextSize = 14
                end
            end
        end
    end,
    ["Run Fast"] = function(on)
        Humanoid.WalkSpeed = on and 100 or 16
    end,
    ["NoClip"] = function(on)
        while on do
            for _, v in ipairs(Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
            task.wait()
        end
    end,
    ["Fly (Space)"] = function(on)
        local bv
        UIS.InputBegan:Connect(function(i)
            if i.KeyCode == Enum.KeyCode.Space and on then
                bv = bv or Instance.new("BodyVelocity")
                bv.Velocity = Vector3.new(0, 50, 0)
                bv.MaxForce = Vector3.new(0, 4000, 0)
                bv.Parent = RootPart
            end
        end)
        UIS.InputEnded:Connect(function(i)
            if i.KeyCode == Enum.KeyCode.Space and bv then
                bv:Destroy()
                bv = nil
            end
        end)
    end,
    ["Infinite Money"] = function(on)
        if on and Rem.SetMoney then Rem.SetMoney:FireServer(math.huge) end
    end,
    ["500× Luck"] = function(on)
        if on and Rem.SetLuck then Rem.SetLuck:FireServer(500) end
    end,
    ["500× Money Mult"] = function(on)
        if on and Rem.SetMult then Rem.SetMult:FireServer(500) end
    end,
    ["Auto Collect Money"] = function(on)
        while on do
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v.Name:lower():find("money") then
                    firetouchinterest(RootPart, v, 0)
                end
            end
            task.wait(0.2)
        end
    end,
    ["Force Trade"] = function(on)
        if on and Rem.ForceTrade then Rem.ForceTrade:FireServer() end
    end,
    ["Auto Trade"] = function(on)
        while on do
            if Rem.AutoTrade then Rem.AutoTrade:FireServer() end
            task.wait(3)
        end
    end,
    ["Spectate"] = function(on)
        if on and Rem.Spectate then Rem.Spectate:FireServer() end
    end,
    ["View Inventory"] = function(on)
        if on and Rem.ViewInventory then Rem.ViewInventory:FireServer() end
    end
}

for name, func in pairs(toggles) do
    VortX:Toggle(Window, name, func)
end
