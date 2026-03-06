local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Character = LP.Character or LP.CharacterAdded:Wait()
local PG = LP:WaitForChild("PlayerGui")

_G.TelePositions = _G.TelePositions or {}

if PG:FindFirstChild("TP_GUI_COMPACT") then PG.TP_GUI_COMPACT:Destroy() end

local sg = Instance.new("ScreenGui", PG)
sg.Name = "TP_GUI_COMPACT"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function createCorner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = p
end

-----------------------------------------------------------
-- TOMBOL BURGER
-----------------------------------------------------------
local burger = Instance.new("TextButton", sg)
burger.Size = UDim2.fromOffset(45, 45)
burger.Position = UDim2.new(0.010, 2, 1, -265)
burger.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
burger.Text = "TP"; 
burger.TextColor3 = Color3.new(1, 1, 1)
burger.TextSize = 20;
burger.Font = Enum.Font.GothamBlack;
burger.Visible = false
burger.Active = true; 
burger.TextScaled = true
burger.Draggable = true; 
burger.ZIndex = 10
createCorner(burger, 20)

-----------------------------------------------------------
-- WINDOW UTAMA
-----------------------------------------------------------
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 310, 0, 520)
main.Position = UDim2.new(0.092, -140, 0.5, -370)
main.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
main.Active = true; main.Draggable = true; main.ZIndex = 1
createCorner(main, 10)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, -70, 0, 35); title.Position = UDim2.new(0, 12, 0, 0)
title.Text = "TELEPORT BY DHEO"; title.TextColor3 = Color3.new(1, 1, 1)
title.Font = "GothamBlack"; title.TextSize = 12; title.BackgroundTransparency = 1; title.ZIndex = 2; title.TextXAlignment = "Left"

local minBtn = Instance.new("TextButton", main)
minBtn.Size = UDim2.new(0, 26, 0, 26); minBtn.Position = UDim2.new(1, -65, 0, 5)
minBtn.Text = "—"; minBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60); minBtn.ZIndex = 3
minBtn.TextColor3 = Color3.new(1, 1, 1); createCorner(minBtn, 5)

local close = Instance.new("TextButton", main)
close.Size = UDim2.new(0, 26, 0, 26); close.Position = UDim2.new(1, -35, 0, 5)
close.Text = "✖"; close.BackgroundColor3 = Color3.fromRGB(180, 0, 0); close.ZIndex = 3
close.TextColor3 = Color3.new(1, 1, 1); createCorner(close, 5)

minBtn.MouseButton1Click:Connect(function() main.Visible = false; burger.Visible = true end)
burger.MouseButton1Click:Connect(function() main.Visible = true; burger.Visible = false end)
close.MouseButton1Click:Connect(function() sg:Destroy() end)

-----------------------------------------------------------
-- SCROLL LIST MAP
-----------------------------------------------------------
local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, -16, 0, 200)
scroll.Position = UDim2.new(0, 8, 0, 45)
scroll.BackgroundTransparency = 0.85
scroll.BackgroundColor3 = Color3.new(0,0,0)
scroll.ScrollBarThickness = 3
scroll.ZIndex = 5
createCorner(scroll, 5)

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 3)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local Maps = {
    {
        name = "!My Spot",
        spots = {
            {name="Spot DINO RUIN", pos=Vector3.new(6097,-586,4663)},
            {name="Spot MAJA 1 RUIN", pos=Vector3.new(6020,-586,4627)},
            {name="Spot Maja 2 RUIN", pos=Vector3.new(6030,-557,4564)},
            {name="esoterik Lift", pos=Vector3.new(2105,-27,1356)},
            {name="Jungle Lift", pos=Vector3.new(6139,-428,3884)},
            {name="Spot Kraken 1", pos=Vector3.new(-3660,-135,-959)},
            {name="Spot Kraken 2", pos=Vector3.new(-3734,-136,-1014)},
            {name="Spot Kraken 3", pos=Vector3.new(-3700,-136,-1014)},
            {name="Spot King Crab", pos=Vector3.new(-3604,-280,-1589)},
            {name="Spot Jelly Crab", pos=Vector3.new(-3605,-280,-1591)},
            {name="Spot Lochness 1", pos=Vector3.new(-619,7,639)},
            {name="Spot Lochness 2", pos=Vector3.new(-658,17,491)},
            {name="Spot Lochness 3", pos=Vector3.new(-626,19,422)}
        }
    },
    {
        name = "Ancient Jungle",
        spots = {
            {name="Ancient Jungle", pos=Vector3.new(1282,2,-131)},
            {name="Jual Ikan Jungle", pos=Vector3.new(1327,7,-207)},
            {name="Beli Bamboo Rod", pos=Vector3.new(1572,-42,-644)},
            {name="Beli Floral Bait", pos=Vector3.new(1380,-42,-620)},
            {name="Kuil", pos=Vector3.new(1475,-22,-631)},
            {name="Enchant Kuil", pos=Vector3.new(1482,127,-581)},   
            {name="Pintu Misi Element", pos=Vector3.new(1887,7,-578)},
            {name="Papan Misi Element", pos=Vector3.new(2099,-92,-699)},
            {name="kuil bawah", pos=Vector3.new(6053,-539,4403)},
            {name="Jamur Ungu", pos=Vector3.new(1494,17,-351)},
            {name="Jamur Merah", pos=Vector3.new(1517,15,-325)},
            {name="Jamur Ijo", pos=Vector3.new(1482,11,-300)},
            {name="Artefak Ijo", pos=Vector3.new(1380,6,109)},
            {name="Artefak Ungu", pos=Vector3.new(1827,7,-287)},
            {name="Artefak Merah", pos=Vector3.new(890,7,-358)},
            {name="Artefak Kuning", pos=Vector3.new(1480,6,-852)},
            {name="Spot King Jelly", pos=Vector3.new(1677,2,-674)},
            {name="Spot Lubang 1", pos=Vector3.new(1412,4,-554)},
            {name="Spot Lubang 2", pos=Vector3.new(1410,4,-588)},
            {name="Spot Lubang 3", pos=Vector3.new(1404,4,-623)},
            {name="Spot Maja 1", pos=Vector3.new(1471,-8,-579)},
            {name="Spot Maja 2", pos=Vector3.new(1489,-18,-599)},
            {name="Spot Maja 3", pos=Vector3.new(1468,-22,-623)},
            {name="Spot Maja 4", pos=Vector3.new(1489,-18,-599)},
            {name="Spot Maja 5", pos=Vector3.new(1465,-23,-668)},
            {name="Spot Maja 1 Bawah", pos=Vector3.new(6043,-580,4567)},
            {name="Spot Maja 2 Bawah", pos=Vector3.new(6059,-589,4599)},
            {name="Spot Maja 3 Bawah", pos=Vector3.new(6046,-589,4609)},
            {name="Spot Maja 4 Bawah", pos=Vector3.new(6001,-586,4663)},
            {name="Spot Maja 5 Bawah", pos=Vector3.new(6097,-586,4663)},
            {name="Spot Maja 6 Bawah", pos=Vector3.new(6044,-586,4715)},
            {name="Spot Maja 7 Bawah", pos=Vector3.new(6030,-557,4564)} 
        }
    },
    {
        name = "Corral Reff",
        spots = {
            {name="spot dolphin 1", pos=Vector3.new(-2917,3,2066)},
            {name="spot dolphin 2", pos=Vector3.new(-2962,3,2031)},
            {name="spot dolphin 3", pos=Vector3.new(-2957,2,2066)},
            {name="spot dolphin 4", pos=Vector3.new(-2930,6,2054)},
            {name="Spot SC 1", pos=Vector3.new(-3261,2,2212)},
            {name="Spot SC 2", pos=Vector3.new(-3032,2,2279)},
            {name="Spot Monster Shark", pos=Vector3.new(-3218,3,1915)}
        }
    },
    {
        name = "Creater",
        spots = {
            {name="Pintu masuk", pos=Vector3.new(881,30,4961)},
            {name="Spot 1 Creater", pos=Vector3.new(1059,3,5030)},
            {name="Spot 2 Creater", pos=Vector3.new(999,17,5094)},
            {name="Spot 3 Creater", pos=Vector3.new(981,43,5072)}  
        }
    },
    {
        name = "Esoterik",
        spots = {
            {name="esoterik Lift", pos=Vector3.new(2105,-27,1356)},
            {name="Enchant Eso", pos=Vector3.new(3227,-1303,1403)},
            {name="Spot 1 Eso", pos=Vector3.new(3186,-1303,1366)},
            {name="Spot 2 Eso", pos=Vector3.new(3256,-1302,1409)},
            {name="Spot 3 Eso", pos=Vector3.new(3300,-1303,1371)},
            {name="Spot 4 Eso", pos=Vector3.new(3250,-1294,1435)},
            {name="Spot 5 Eso", pos=Vector3.new(3211,-1303,1408)}
        }
    },
    {
        name = "Fisherman",
        spots = {
            {name="Base", pos=Vector3.new(92,17,2826)},
            {name="Pintu Masuk", pos=Vector3.new(4,9,2814)},
            {name="Buy Rod", pos=Vector3.new(144,20,2845)},
            {name="Buy Bobber", pos=Vector3.new(111,17,2866)},
            {name="Buy Radar", pos=Vector3.new(-47,20,2868)},
            {name="Selle Ikan", pos=Vector3.new(49,17,2868)},
            {name="Buy hazmat / totem", pos=Vector3.new(-137,3,2767)},
            {name="Spot Orca 1", pos=Vector3.new(202,3,2802)},
			{name="Spot Orca 2", pos=Vector3.new(-80, 3, 2878)},
        }
    },
    {
        name = "Kohana",
        spots = {
            {name="Kohana", pos=Vector3.new(-603,3,789)},
            {name="Tmpt rahasia", pos=Vector3.new(-543,8,-79)},
            {name="Spot Dino 1", pos=Vector3.new(-901,16,614)},
            {name="Spot Dino 2", pos=Vector3.new(-860,18,463)},
            {name="Spot Dino 3", pos=Vector3.new(-656,17,480)},
            {name="Spot Dino 4", pos=Vector3.new(-837,18,476)}, 
            {name="Spot Dino 5", pos=Vector3.new(-662,16,538)},
            {name="Volcano Lava 1", pos=Vector3.new(-568,22,146)},
            {name="Volcano Lava 2", pos=Vector3.new(-609,48,168)}   
        }
    },
    {
        name = "Kohana Lava",
        spots = {
            {name="Kohana", pos=Vector3.new(-379,15,149)},
            {name="Jual Ikan", pos=Vector3.new(-483,21,137)},
            {name="Volcano Lava 1", pos=Vector3.new(-568,22,146)},
            {name="Volcano Lava 2", pos=Vector3.new(-577,60,111)},
            {name="Volcano Lava 3", pos=Vector3.new(-547,18,141)}
        }
    },
    {
        name = "Volcanic Cavern",
        spots = {
            {name="Volcanic Cavern", pos=Vector3.new(1259,83,-10244)},
            {name="Cavenr 1", pos=Vector3.new(1131,87,-10272)},
            {name="Cavern 2", pos=Vector3.new(1147,73,-10234)},
            {name="Spot Blueflame Ray", pos=Vector3.new(1273,83,-10251)}
        }
    },
    {
        name = "Lava Basin",
        spots = {
            {name="Lava Basin", pos=Vector3.new(1018,85,-10245)},
            {name="Crafting Charm", pos=Vector3.new(871,96,-10178)},
            {name="Spot 1", pos=Vector3.new(894,89,-10197)},
            {name="Spot Gacor 1", pos=Vector3.new(836,86,-10264)},
            {name="Spot Gacor 2", pos=Vector3.new(936,67,-10219)},
            {name="Spot Gacor 3", pos=Vector3.new(894,72,-10180)}
        }
    },
    {
        name = "Tropical",
        spots = {
            {name="Tropical Paus", pos=Vector3.new(-2165,53,3665)},
            {name="Tropical Batu", pos=Vector3.new(-2165,2,3637)},
            {name="Spot Whale", pos=Vector3.new(-2173,53,3633)},
            {name="Spot Albino CryOshade", pos=Vector3.new( -3739,-136,-1013)} 
        }
    },
    {
        name = "Lost Isle",
        spots = {
            {name="Lost Isle", pos=Vector3.new(-3563,2,-1270)},
            {name="Sysypus", pos=Vector3.new(-3737,-136,-1014)},
            {name="Spot Kraken 1", pos=Vector3.new(-3740,-136,-1008)},
            {name="Spot Kraken 2", pos=Vector3.new(-3787,-136,-955)},
            {name="Spot Kraken 3", pos=Vector3.new(-3685,-136,-893)},
            {name="Treasure", pos=Vector3.new(-3601,-282,-1506)},
            {name="Spot King Crab", pos=Vector3.new(-3627,-285,-1644)},
            {name="Tottem Rubby 1", pos=Vector3.new(-3588,-280,-1700)},
            {name="Tottem Rubby 2", pos=Vector3.new(-3556,-280,-1605)},
            {name="Tottem Rubby 3", pos=Vector3.new(-3658,-280,-1617)},
            {name="Spot Rubby", pos=Vector3.new(-3613,-284,-1654)},
            {name="Treasure 1", pos=Vector3.new(-3599,-280,-1634)},
            {name="Treasure 2", pos=Vector3.new(-3594,-282,-1644)}
        }
    },
    {
        name = "!Pirate Cove",
        spots = {
            {name="Spot Leviatan", pos=Vector3.new(3422,4,3507)},
            {name="Spot Mega 1", pos=Vector3.new(3398,4,3458)},
            {name="Spot Mega 2", pos=Vector3.new(3390,8,3320)},
            {name="Spot Batu", pos=Vector3.new(3398,10,3490)},
            {name="Maze Room", pos=Vector3.new(3432,-300,3360)},
            {name="Pirate Treasure", pos=Vector3.new(3337,-300,3104)},
			{name="Misi Rod Leviatan", pos=Vector3.new(3313, -299, 3002)},
			{name="Goblin Shark", pos=Vector3.new(3356, -299, 3039)},
            {name="Crystall Depth", pos=Vector3.new(5749,-905,15393)},
            {name="Gran Maja", pos=Vector3.new(5638,-900,15352)},
            {name="Kraken 1 (PC)", pos=Vector3.new(5639,-879,15396)},
            {name="Kraken 2 (PC)", pos=Vector3.new(5685,-896,15327)},
            {name="Cristalized", pos=Vector3.new(5830,-896,15346)}
        }
    },
    {
        name = "!Leviatan Den",
        spots = {
            {name="Leviatan Mid", pos=Vector3.new(3474,-288,3471)},
            {name="Leviatan Left", pos=Vector3.new(3540,-288,3481)},
            {name="Leviatan Right", pos=Vector3.new(3429,-288,3519)},
            {name="Leviatan Batu 1", pos=Vector3.new(3440,-281,3540)},
            {name="Leviatan Batu 2", pos=Vector3.new(3461,-285,3549)},
            {name="Leviatan Atas", pos=Vector3.new(3497,-246,3539)}
        }
    },
	{
        name = "Planet Observatory",
        spots = {
            {name="Submarine Operator", pos=Vector3.new(421, 3, 2185)},
            {name="D.M.C Meteorologist", pos=Vector3.new(426, 31, 2100)},
			{name="Buy Charm Meteor", pos=Vector3.new(5009, 4934, 5005)},
			{name="Spot 1", pos=Vector3.new(362, 5, 2124)},
			{name="Spot 2", pos=Vector3.new(362, 5, 2124)},
        }
    },
    {
        name = "Weather Machine",
        spots = {
            {name="spot worm", pos=Vector3.new(-1522,2,1912)},
            {name="spot worm", pos=Vector3.new(74,2249,-20)}
        }
    },
    {
        name = "Salon De Fiestas",
        spots = {
           {name="Tengah Titan", pos=Vector3.new(-86,2,36)},
            {name="Atas Atap", pos=Vector3.new(-84,49,22)},
            {name="Balkon Depan Luar", pos=Vector3.new(-86,26,-27)},
            {name="Balkon Belakang Luar", pos=Vector3.new(-89,26,100)},
            {name="Balkon Kiri Luar", pos=Vector3.new(-18,30,21)},
            {name="Balkon Kanan Luar", pos=Vector3.new(-155,30,31)}
        }
    },
}

-----------------------------------------------------------
-- FUNCTION CREATE CARD (Update: Copy Feedback)
-----------------------------------------------------------
local function createCard(name, pos)
    local card = Instance.new("Frame", savedScroll)
    card.Size = UDim2.new(1, -4, 0, 35); card.BackgroundColor3 = Color3.fromRGB(40, 55, 40); card.ZIndex = 5; createCorner(card, 4)
    
    local lbl = Instance.new("TextLabel", card); lbl.Size = UDim2.new(0.4, 0, 1, 0); lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.Text = name; lbl.TextColor3 = Color3.new(1,1,1); lbl.Font = "GothamBold"; lbl.TextSize = 14; lbl.ZIndex = 6; lbl.BackgroundTransparency = 1; lbl.TextXAlignment = "Left"
    
    local bA = Instance.new("Frame", card); bA.Size = UDim2.new(0.6, 0, 1, 0); bA.Position = UDim2.new(0.4, 0, 0, 0); bA.BackgroundTransparency = 1; bA.ZIndex = 6
    local bl = Instance.new("UIListLayout", bA); bl.FillDirection = "Horizontal"; bl.HorizontalAlignment = "Right"; bl.Padding = UDim.new(0, 3); bl.VerticalAlignment = "Center"
    
    local function mk(t, c, f)
        local b = Instance.new("TextButton", bA); 
		b.Size = UDim2.new(0, 42, 0, 24); 
		b.Text = t; b.BackgroundColor3 = c
        b.TextColor3 = Color3.new(1,1,1); 
		b.Font = "GothamBold"; 
		b.TextSize = 9; 
		b.ZIndex = 7; 
		createCorner(b, 3)
        b.MouseButton1Click:Connect(function() f(b) end)
        return b
    end

    mk("TP", Color3.fromRGB(0, 100, 0), function() 
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            LP.Character.HumanoidRootPart.CFrame = CFrame.new(pos) 
        end
    end)
    
    mk("Copy", Color3.fromRGB(0, 80, 140), function(btn) 
        setclipboard(math.floor(pos.X)..", "..math.floor(pos.Y)..", "..math.floor(pos.Z)) 
        local old = btn.Text
        btn.Text = "Copied!"
        task.wait(1)
        btn.Text = old
    end)
    
    mk("Del", Color3.fromRGB(140, 0, 0), function() card:Destroy(); _G.TelePositions[name] = nil end)
    
    savedScroll.CanvasSize = UDim2.new(0, 0, 0, sLayout.AbsoluteContentSize.Y + 5)
end


-----------------------------------------------------------
-- SCROLLING MENU
-----------------------------------------------------------
local function createMapDrop(name, data)
    local frame = Instance.new("Frame", scroll)
    frame.Size = UDim2.new(1, -4, 0, 32); 
	frame.BackgroundColor3 = Color3.fromRGB(70, 0, 0)
    frame.ClipsDescendants = true; 
	frame.ZIndex = 6; 
	createCorner(frame, 4)
    
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(1, 0, 0, 32); b.Text = "  ▶  " .. name; b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundTransparency = 1; b.TextXAlignment = "Left"; b.Font = "GothamBold"; b.TextSize = 14; b.ZIndex = 7
    
    local cont = Instance.new("Frame", frame)
    cont.Position = UDim2.new(0, 5, 0, 35); cont.Size = UDim2.new(1, -10, 0, 0); cont.BackgroundTransparency = 1; cont.ZIndex = 7
    
    local gl = Instance.new("UIGridLayout", cont)
    gl.CellSize = UDim2.new(0.5, -4, 0, 26); gl.CellPadding = UDim2.new(0, 4, 0, 4)
    
    for _, item in ipairs(data) do
        local btn = Instance.new("TextButton", cont)
        btn.Text = item.name; btn.BackgroundColor3 = Color3.fromRGB(110, 0, 0); btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = "GothamMedium"; btn.TextSize = 12; btn.ZIndex = 8; createCorner(btn, 4)
        btn.MouseButton1Click:Connect(function() 
            if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                LP.Character.HumanoidRootPart.CFrame = CFrame.new(item.pos) 
            end
        end)
    end
    
    local open = false
    b.MouseButton1Click:Connect(function()
        open = not open; b.Text = (open and "  ▼  " or "  ▶  ") .. name
        local rows = math.ceil(#data / 2)
        frame.Size = UDim2.new(1, -4, 0, open and (40 + (rows * 30)) or 32)
        cont.Size = UDim2.new(1, -10, 0, rows * 30)
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
end

for _, mapData in ipairs(Maps) do createMapDrop(mapData.name, mapData.spots) end

-----------------------------------------------------------
-- MANUAL TP
-----------------------------------------------------------
local manualFrame = Instance.new("Frame", main)
manualFrame.Size = UDim2.new(1, -16, 0, 50);
manualFrame.Position = UDim2.new(0, 8, 0, 255)
manualFrame.BackgroundColor3 = Color3.fromRGB(25, 0, 0); 
manualFrame.ZIndex = 4; createCorner(manualFrame, 6)

local box = Instance.new("TextBox", manualFrame)
box.Size = UDim2.new(0.75, -8, 0, 30); 
box.Position = UDim2.new(0, 4, 0, 10); 
box.PlaceholderText = "X, Y, Z"
box.Text = "-81, 784, -111"; 
box.BackgroundColor3 = Color3.fromRGB(15, 0, 0); 
box.TextColor3 = Color3.new(1,1,1); 
box.TextSize = 11; box.ZIndex = 5; createCorner(box, 4)

local go = Instance.new("TextButton", manualFrame)
go.Size = UDim2.new(0.25, -4, 0, 30); go.Position = UDim2.new(0.75, 0, 0, 10); go.Text = "TP"
go.BackgroundColor3 = Color3.fromRGB(150, 0, 0); go.TextColor3 = Color3.new(1,1,1); go.TextSize = 12; go.ZIndex = 5; createCorner(go, 4)

go.MouseButton1Click:Connect(function() 
    local coords = box.Text:gsub(" ",""):split(",")
    if #coords == 3 then 
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(tonumber(coords[1]), tonumber(coords[2]), tonumber(coords[3]))
    end 
end)

-----------------------------------------------------------
-- SAVE POSITION (Update: Nama Koordinat)
-----------------------------------------------------------
local saveBtn = Instance.new("TextButton", main)
saveBtn.Size = UDim2.new(1, -16, 0, 38); 
saveBtn.Position = UDim2.new(0, 8, 0, 315)
saveBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0); 
saveBtn.Text = "📍 SAVE CURRENT POS"; 
saveBtn.TextColor3 = Color3.new(1,1,1); 
saveBtn.Font = Enum.Font.GothamBlack;
saveBtn.TextSize = 14; 
saveBtn.ZIndex = 4; createCorner(saveBtn, 8)

savedScroll = Instance.new("ScrollingFrame", main)
savedScroll.Size = UDim2.new(1, -16, 0, 150); 
savedScroll.Position = UDim2.new(0, 8, 0, 360)
savedScroll.BackgroundTransparency = 1; 
savedScroll.ScrollBarThickness = 2; 
savedScroll.ZIndex = 4
sLayout = Instance.new("UIListLayout", 
savedScroll); sLayout.Padding = UDim.new(0, 4)

for n, p in pairs(_G.TelePositions) do createCard(n, p) end

saveBtn.MouseButton1Click:Connect(function()
    local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local pos = hrp.Position
        local coordName = math.floor(pos.X)..", "..math.floor(pos.Y)..", "..math.floor(pos.Z)
        if not _G.TelePositions[coordName] then
            _G.TelePositions[coordName] = pos
            createCard(coordName, pos)
        end
    end
end)
