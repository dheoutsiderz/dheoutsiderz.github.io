--=========================================
-- 📱 VALHALLA V.10 — FRIEND MARKER (👑)
--=========================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local SET_CLIPBOARD = setclipboard or toclipboard or print

-- Bersihkan GUI lama
if game:GetService("CoreGui"):FindFirstChild("ValhallaFriendMark") then
    game:GetService("CoreGui").ValhallaFriendMark:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ValhallaFriendMark"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

----------------------------------------------------------------
-- BURGER BUTTON (Minimize Mode)
----------------------------------------------------------------
local BurgerFrame = Instance.new("TextButton", ScreenGui)
BurgerFrame.Name = "BurgerMenu"
BurgerFrame.Size = UDim2.new(0, 45, 0, 45)
BurgerFrame.Position = UDim2.new(0.017, 2, 1, -265)
BurgerFrame.BackgroundColor3 = Color3.fromRGB(255, 105, 180) 
BurgerFrame.Text = "TP"
BurgerFrame.TextColor3 = Color3.new(1, 1, 1)
BurgerFrame.TextSize = 22

BurgerFrame.Visible = false 
BurgerFrame.Draggable = true 
BurgerFrame.Active = true

local BurgerCorner = Instance.new("UICorner", BurgerFrame)
BurgerCorner.CornerRadius = UDim.new(1, 0) 

local BurgerStroke = Instance.new("UIStroke", BurgerFrame)
BurgerStroke.Thickness = 2
BurgerStroke.Color = Color3.new(1, 1, 1)

----------------------------------------------------------------
-- MAIN FRAME
----------------------------------------------------------------
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 360) 
MainFrame.Position = UDim2.new(0.092, -140, 0.5, -370)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 8)

-- PINK-WHITE GRADIENT HEADER
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 32)
Header.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)

local UIGradient = Instance.new("UIGradient", Header)
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 105, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "TELEPORT & SPY"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 10
Title.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", Header)
MinBtn.Size = UDim2.new(0, 26, 0, 26)
MinBtn.Position = UDim2.new(1, -58, 0.5, -13)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinBtn.BackgroundTransparency = 0.6
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

local Close = Instance.new("TextButton", Header)
Close.Size = UDim2.new(0, 26, 0, 26)
Close.Position = UDim2.new(1, -29, 0.5, -13)
Close.Text = "X"
Close.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Close.BackgroundTransparency = 0.4
Close.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", Close)

MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; BurgerFrame.Visible = true end)
BurgerFrame.MouseButton1Click:Connect(function() MainFrame.Visible = true; BurgerFrame.Visible = false end)
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

----------------------------------------------------------------
-- STATUS POPULATION BAR
----------------------------------------------------------------
local StatusBar = Instance.new("Frame", MainFrame)
StatusBar.Size = UDim2.new(1, -16, 0, 22)
StatusBar.Position = UDim2.new(0, 8, 0, 38)
StatusBar.BackgroundTransparency = 1

local StatusLabel = Instance.new("TextLabel", StatusBar)
StatusLabel.Size = UDim2.new(1, 0, 1, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.RichText = true 
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 9
StatusLabel.TextColor3 = Color3.new(1, 1, 1)
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center

local function updateStatus()
    local allPlayers = Players:GetPlayers()
    local onlineFriends = 0
    for _, p in ipairs(allPlayers) do
        if p ~= LocalPlayer then
            local success, isFriend = pcall(function() return LocalPlayer:IsFriendsWith(p.UserId) end)
            if success and isFriend then onlineFriends = onlineFriends + 1 end
        end
    end
    local nonFriends = #allPlayers - onlineFriends - 1
    StatusLabel.Text = string.format(
        "👥 Total: <font color='#FFFF00'>%d</font>  |  " ..
        "🟢 Friends: <font color='#00FFFF'>%d</font>  |  " ..
        "⚪ Others: <font color='#FFC0CB'>%d</font>",
        #allPlayers, onlineFriends, nonFriends
    )
end

----------------------------------------------------------------
-- PLAYER LIST SCROLLING
----------------------------------------------------------------
local Scrolling = Instance.new("ScrollingFrame", MainFrame)
Scrolling.Size = UDim2.new(1, -16, 1, -115)
Scrolling.Position = UDim2.new(0, 8, 0, 65)
Scrolling.BackgroundTransparency = 1
Scrolling.ScrollBarThickness = 2
Scrolling.CanvasSize = UDim2.new(0, 0, 0, 0)

local Layout = Instance.new("UIListLayout", Scrolling)
Layout.Padding = UDim.new(0, 8)
Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scrolling.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y)
end)

local function createPlayerRow(p)
    if p == LocalPlayer then return end
    
    local success, isFriend = pcall(function() return LocalPlayer:IsFriendsWith(p.UserId) end)
    local friendPrefix = (success and isFriend) and "👑 " or ""

    local Row = Instance.new("Frame", Scrolling)
    Row.Size = UDim2.new(1, -4, 0, 60) 
    Row.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", Row)

    local DNLabel = Instance.new("TextLabel", Row)
    DNLabel.Size = UDim2.new(0.6, 0, 0, 15)
    DNLabel.Position = UDim2.new(0, 8, 0, 6)
    DNLabel.BackgroundTransparency = 1
    DNLabel.RichText = true
    -- Memberi warna kuning pada ikon mahkota jika ada
    DNLabel.Text = (friendPrefix ~= "" and "<font color='#FFD700'>"..friendPrefix.."</font>" or "") .. p.DisplayName
    DNLabel.TextColor3 = Color3.fromRGB(255, 105, 180) 
    DNLabel.Font = Enum.Font.GothamBold
    DNLabel.TextSize = 11
    DNLabel.TextXAlignment = Enum.TextXAlignment.Left

    local UNBtn = Instance.new("TextButton", Row)
    UNBtn.Size = UDim2.new(0.4, 0, 0, 15)
    UNBtn.Position = UDim2.new(0.6, -10, 0, 6)
    UNBtn.BackgroundTransparency = 1
    UNBtn.Text = "@" .. p.Name
    UNBtn.TextColor3 = Color3.fromRGB(0, 255, 255) 
    UNBtn.Font = Enum.Font.Gotham
    UNBtn.TextSize = 9
    UNBtn.TextXAlignment = Enum.TextXAlignment.Right

    UNBtn.MouseButton1Click:Connect(function()
        SET_CLIPBOARD(p.Name); UNBtn.Text = "COPIED!"; task.wait(1); UNBtn.Text = "@"..p.Name
    end)

    local BtnContainer = Instance.new("Frame", Row)
    BtnContainer.Size = UDim2.new(1, -16, 0, 22)
    BtnContainer.Position = UDim2.new(0, 8, 0, 28)
    BtnContainer.BackgroundTransparency = 1
    local GLayout = Instance.new("UIGridLayout", BtnContainer)
    GLayout.CellSize = UDim2.new(0.15, 0, 1, 0) 
    GLayout.CellPadding = UDim2.new(0.015, 0, 0, 0)

    local function createBtn(txt, color, func)
        local b = Instance.new("TextButton", BtnContainer)
        b.Text = txt; b.BackgroundColor3 = color; b.TextColor3 = Color3.new(1,1,1)
        b.Font = Enum.Font.GothamBlack; b.TextSize = 10; Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(func)
    end

    local function getHRP(target) return target.Character and target.Character:FindFirstChild("HumanoidRootPart") end
    
    createBtn("F", Color3.fromRGB(255, 105, 180), function()
        if getHRP(p) then LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2) end
    end)
    createBtn("B", Color3.fromRGB(255, 105, 180), function()
        if getHRP(p) then LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2) end
    end)
    createBtn("L", Color3.fromRGB(255, 105, 180), function()
        if getHRP(p) then LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(-2, 0, 0) end
    end)
    createBtn("R", Color3.fromRGB(255, 105, 180), function()
        if getHRP(p) then LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(2, 0, 0) end
    end)
    createBtn("0", Color3.fromRGB(255, 105, 180), function()
        if getHRP(p) then LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end
    end)
    createBtn("SPY", Color3.fromRGB(70, 70, 70), function()
        if p.Character and p.Character:FindFirstChild("Humanoid") then
            workspace.CurrentCamera.CameraSubject = p.Character.Humanoid
        end
    end)
end

----------------------------------------------------------------
-- FOOTER
----------------------------------------------------------------
local ResetBtn = Instance.new("TextButton", MainFrame)
ResetBtn.Size = UDim2.new(1, -16, 0, 30)
ResetBtn.Position = UDim2.new(0, 8, 1, -40)
ResetBtn.Text = "RESET CAMERA"
ResetBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ResetBtn.TextColor3 = Color3.new(1, 1, 1)
ResetBtn.Font = Enum.Font.GothamBold; ResetBtn.TextSize = 11; Instance.new("UICorner", ResetBtn)
ResetBtn.MouseButton1Click:Connect(function()
    workspace.CurrentCamera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
end)

local function updateAll()
    for _, v in ipairs(Scrolling:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
    for _, p in ipairs(Players:GetPlayers()) do createPlayerRow(p) end
    updateStatus()
end

Players.PlayerAdded:Connect(updateAll); Players.PlayerRemoving:Connect(updateAll)
updateAll()
