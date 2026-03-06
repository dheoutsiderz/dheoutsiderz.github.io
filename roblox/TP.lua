local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

_G.TelePositions = _G.TelePositions or {}

if PG:FindFirstChild("TP_GUI_V4_FINAL") then PG.TP_GUI_V4_FINAL:Destroy() end

local sg = Instance.new("ScreenGui", PG)
sg.Name = "TP_GUI_V4_FINAL"
sg.ResetOnSpawn = false

local function createCorner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = p
end

local function makeDraggable(gui)
    local UIS = game:GetService("UserInputService")
    local dragging, dragInput, dragStart, startPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = gui.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-----------------------------------------------------------
-- WINDOW UTAMA
-----------------------------------------------------------
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 550, 0, 320) 
main.Position = UDim2.new(0.5, -300, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.Active = true
createCorner(main, 10)
makeDraggable(main)

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 40); header.BackgroundTransparency = 1

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(0, 300, 1, 0); title.Position = UDim2.new(0, 15, 0, 0)
title.Text = "TELEPORT BY DHEO [V4 FINAL]"; title.TextColor3 = Color3.new(1, 1, 1)
title.Font = "GothamBlack"; title.TextSize = 14; title.BackgroundTransparency = 1; title.TextXAlignment = "Left"

local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.new(0, 30, 0, 30); minBtn.Position = UDim2.new(1, -75, 0, 5)
minBtn.Text = "—"; minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); minBtn.TextColor3 = Color3.new(1,1,1); createCorner(minBtn, 6)

local close = Instance.new("TextButton", header)
close.Size = UDim2.new(0, 30, 0, 30); close.Position = UDim2.new(1, -35, 0, 5)
close.Text = "✖"; close.BackgroundColor3 = Color3.fromRGB(150, 0, 0); close.TextColor3 = Color3.new(1,1,1); createCorner(close, 6)

local container = Instance.new("Frame", main)
container.Size = UDim2.new(1, -20, 1, -60); container.Position = UDim2.new(0, 10, 0, 50); container.BackgroundTransparency = 1

-- GRID 1 (KIRI - LIST TELEPORT)
local leftGrid = Instance.new("ScrollingFrame", container)
leftGrid.Size = UDim2.new(0.52, 0, 1, 0)
leftGrid.BackgroundTransparency = 1; leftGrid.ScrollBarThickness = 2; leftGrid.AutomaticCanvasSize = Enum.AutomaticSize.Y
local lLayout = Instance.new("UIListLayout", leftGrid); lLayout.Padding = UDim.new(0, 6)

-- GRID 2 (KANAN - MANUAL & SAVED)
local rightGrid = Instance.new("Frame", container)
rightGrid.Size = UDim2.new(0.45, 0, 1, 0); rightGrid.Position = UDim2.new(0.55, 0, 0, 0); rightGrid.BackgroundTransparency = 1

-----------------------------------------------------------
-- ISI GRID KANAN
-----------------------------------------------------------
local manualFrame = Instance.new("Frame", rightGrid)
manualFrame.Size = UDim2.new(1, 0, 0, 50); manualFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30); createCorner(manualFrame, 6)

local box = Instance.new("TextBox", manualFrame)
box.Size = UDim2.new(0.7, -5, 0, 32); box.Position = UDim2.new(0, 5, 0, 9); box.PlaceholderText = "X, Y, Z"
box.BackgroundColor3 = Color3.fromRGB(10, 10, 10); box.TextColor3 = Color3.new(1,1,1); box.TextSize = 12; createCorner(box, 4); box.Text = ""

local go = Instance.new("TextButton", manualFrame)
go.Size = UDim2.new(0.3, -8, 0, 32); go.Position = UDim2.new(0.7, 3, 0, 9); go.Text = "GO"
go.BackgroundColor3 = Color3.fromRGB(200, 0, 0); go.TextColor3 = Color3.new(1,1,1); go.Font = "GothamBold"; createCorner(go, 4)

local saveBtn = Instance.new("TextButton", rightGrid)
saveBtn.Size = UDim2.new(1, 0, 0, 40); saveBtn.Position = UDim2.new(0, 0, 0, 58)
saveBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 60); saveBtn.Text = "📍 SAVE CURRENT POS"
saveBtn.TextColor3 = Color3.new(1,1,1); saveBtn.Font = "GothamBlack"; saveBtn.TextSize = 11; createCorner(saveBtn, 6)

local savedScroll = Instance.new("ScrollingFrame", rightGrid)
savedScroll.Size = UDim2.new(1, 0, 1, -110); savedScroll.Position = UDim2.new(0, 0, 0, 110)
savedScroll.BackgroundTransparency = 1; savedScroll.ScrollBarThickness = 2; savedScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
local sLayout = Instance.new("UIListLayout", savedScroll); sLayout.Padding = UDim.new(0, 5)

-----------------------------------------------------------
-- FUNGSI KARTU SAVED (FIX SEJAJAR)
-----------------------------------------------------------
local function createCard(name, pos)
    local card = Instance.new("Frame", savedScroll)
    card.Size = UDim2.new(1, -6, 0, 40)
    card.BackgroundColor3 = Color3.fromRGB(35, 35, 35); createCorner(card, 6)
    
    local lbl = Instance.new("TextLabel", card)
    lbl.Size = UDim2.new(0.4, 0, 1, 0)
    lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.Text = name; lbl.TextColor3 = Color3.new(1,1,1); lbl.TextSize = 8; lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = "Left"; lbl.Font = "GothamBold"; lbl.ClipsDescendants = true

    local btnArea = Instance.new("Frame", card)
    btnArea.Size = UDim2.new(0.6, -5, 1, 0)
    btnArea.Position = UDim2.new(0.4, 0, 0, 0)
    btnArea.BackgroundTransparency = 1
    
    local bl = Instance.new("UIListLayout", btnArea)
    bl.FillDirection = "Horizontal"; bl.HorizontalAlignment = "Right"; bl.VerticalAlignment = "Center"; bl.Padding = UDim.new(0, 3)
    
    local function mk(t, c, f)
        local b = Instance.new("TextButton", btnArea); b.Size = UDim2.new(0, 36, 0, 22)
        b.Text = t; b.BackgroundColor3 = c; b.TextColor3 = Color3.new(1,1,1); b.TextSize = 8; b.Font = "GothamBold"; createCorner(b, 4)
        b.MouseButton1Click:Connect(function() f(b) end)
    end
    
    mk("TP", Color3.fromRGB(0, 150, 0), function() if LP.Character:FindFirstChild("HumanoidRootPart") then LP.Character.HumanoidRootPart.CFrame = CFrame.new(pos) end end)
    mk("Copy", Color3.fromRGB(0, 100, 200), function(btn) setclipboard(math.floor(pos.X)..", "..math.floor(pos.Y)..", "..math.floor(pos.Z)); btn.Text = "OK"; task.wait(0.5); btn.Text = "Copy" end)
    mk("Del", Color3.fromRGB(180, 0, 0), function() card:Destroy(); _G.TelePositions[name] = nil end)
end

-----------------------------------------------------------
-- DROPDOWN MAPS (KIRI - LIST LENGKAP)
-----------------------------------------------------------
local Maps = {
    { name = "!My Spot", spots = { {name="Dino Ruin", pos=Vector3.new(6097,-586,4663)}, {name="Maja 1", pos=Vector3.new(6020,-586,4627)}, {name="Kraken 1", pos=Vector3.new(-3660,-135,-959)} } },
    { name = "Ancient Jungle", spots = { {name="Spawn", pos=Vector3.new(1282,2,-131)}, {name="Jual Ikan", pos=Vector3.new(1327,7,-207)}, {name="Kuil", pos=Vector3.new(1475,-22,-631)} } },
    { name = "Lost Isle", spots = { {name="Lost Isle", pos=Vector3.new(-3563,2,-1270)}, {name="Sypsypus", pos=Vector3.new(-3737,-136,-1014)} } },
    { name = "!Pirate Cove", spots = { {name="Leviatan Mid", pos=Vector3.new(3474,-288,3471)}, {name="Maze Room", pos=Vector3.new(3432,-300,3360)} } }
}

local function createMapDrop(name, data)
    local frame = Instance.new("Frame", leftGrid)
    frame.Size = UDim2.new(1, -8, 0, 35); frame.BackgroundColor3 = Color3.fromRGB(60, 0, 0); frame.ClipsDescendants = true; createCorner(frame, 6)
    
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1, 0, 0, 35); b.Text = "  ▶  " .. name; b.TextColor3 = Color3.new(1,1,1); b.BackgroundTransparency = 1; b.TextXAlignment = "Left"; b.Font = "GothamBold"; b.TextSize = 12
    
    local cont = Instance.new("Frame", frame)
    cont.Position = UDim2.new(0, 8, 0, 40); cont.Size = UDim2.new(1, -16, 0, 0); cont.BackgroundTransparency = 1
    local gl = Instance.new("UIGridLayout", cont); gl.CellSize = UDim2.new(0.5, -5, 0, 30); gl.CellPadding = UDim2.new(0, 5, 0, 5)
    
    for _, item in ipairs(data) do
        local btn = Instance.new("TextButton", cont); btn.Text = item.name; btn.BackgroundColor3 = Color3.fromRGB(100, 0, 0); btn.TextColor3 = Color3.new(1,1,1); btn.TextSize = 10; btn.Font = "GothamBold"; createCorner(btn, 4)
        btn.MouseButton1Click:Connect(function() LP.Character.HumanoidRootPart.CFrame = CFrame.new(item.pos) end)
    end
    
    local open = false
    b.MouseButton1Click:Connect(function()
        open = not open; b.Text = (open and "  ▼  " or "  ▶  ") .. name
        local rows = math.ceil(#data / 2)
        frame.Size = UDim2.new(1, -8, 0, open and (45 + (rows * 35)) or 35)
    end)
end

for _, m in ipairs(Maps) do createMapDrop(m.name, m.spots) end

-----------------------------------------------------------
-- EVENT HANDLERS
-----------------------------------------------------------
go.MouseButton1Click:Connect(function()
    local c = box.Text:gsub(" ",""):split(",")
    if #c == 3 then LP.Character.HumanoidRootPart.CFrame = CFrame.new(tonumber(c[1]), tonumber(c[2]), tonumber(c[3])) end
end)

saveBtn.MouseButton1Click:Connect(function()
    local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local pos = hrp.Position
        local n = math.floor(pos.X)..", "..math.floor(pos.Y)..", "..math.floor(pos.Z)
        if not _G.TelePositions[n] then _G.TelePositions[n] = pos; createCard(n, pos) end
    end
end)

for n, p in pairs(_G.TelePositions) do createCard(n, p) end

-- Burger Toggle
local burger = Instance.new("TextButton", sg)
burger.Size = UDim2.fromOffset(45, 45); burger.Position = UDim2.new(0.01, 0, 0.5, 0); burger.BackgroundColor3 = Color3.fromRGB(45, 0, 0); burger.Text = "TP"; burger.TextColor3 = Color3.new(1,1,1); burger.Font="GothamBlack"; burger.Visible = false; createCorner(burger, 22); makeDraggable(burger)

minBtn.MouseButton1Click:Connect(function() main.Visible = false; burger.Visible = true end)
burger.MouseButton1Click:Connect(function() main.Visible = true; burger.Visible = false end)
close.MouseButton1Click:Connect(function() sg:Destroy() end)
