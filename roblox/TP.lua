local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

_G.TelePositions = _G.TelePositions or {}

if PG:FindFirstChild("TP_SIDEBAR_COMPLETE") then PG.TP_SIDEBAR_COMPLETE:Destroy() end

local sg = Instance.new("ScreenGui", PG)
sg.Name = "TP_SIDEBAR_COMPLETE"
sg.ResetOnSpawn = false

local function createCorner(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = p
end

-----------------------------------------------------------
-- DATA MAPS (DARI SCRIPT KAMU)
-----------------------------------------------------------
local MapsData = {
     {
        name = "!My Spot",
        spots = {
			{name="Spot Puggy", pos=Vector3.new(1478, 1, -442)},
            {name="Spot DINO RUIN", pos=Vector3.new(6097,-586,4663)},
            {name="Spot MAJA 1 RUIN", pos=Vector3.new(6020,-586,4627)},
            {name="Spot Maja 2 RUIN", pos=Vector3.new(6030,-557,4564)},
            {name="esoterik Lift", pos=Vector3.new(2105,-27,1356)},
            {name="Jungle Lift", pos=Vector3.new(6139,-428,3884)},
            {name="Spot Kraken 1", pos=Vector3.new(-3660,-135,-959)},
            {name="Spot Kraken 2", pos=Vector3.new(-3734,-136,-1014)},
            {name="Spot Kraken 3", pos=Vector3.new(-3700,-136,-1014)},
            {name="Spot King Crab", pos=Vector3.new(-3608, -280, -1585)},
            {name="Spot Jelly Crab", pos=Vector3.new(-3605,-280,-1591)},
            {name="Spot Lochness 1", pos=Vector3.new(-619,7,639)},
            {name="Spot Lochness 2", pos=Vector3.new(-658,17,491)},
            {name="Spot Lochness 3", pos=Vector3.new(-626,19,422)}
        }
    },
	
	    {
        name = "Pirate Cove",
        spots = {
            {name="Spot Leviatan", pos=Vector3.new(3422,4,3507)},
            {name="Spot Mega 1", pos=Vector3.new(3398,4,3458)},
            {name="Spot Mega 2", pos=Vector3.new(3390,8,3320)},
            {name="Spot Batu", pos=Vector3.new(3398,10,3490)},
            {name="Maze Room", pos=Vector3.new(3432,-300,3360)},
			{name="Exchange Kraken", pos=Vector3.new(5698, -892, 15291)},
			{name="Exchange Diary", pos=Vector3.new(5836, -895, 15329)},
            {name="Pirate Treasure", pos=Vector3.new(3337,-300,3104)},
			{name="Misi Rod Leviatan", pos=Vector3.new(3313, -299, 3002)},
			{name="Goblin Shark", pos=Vector3.new(3356, -299, 3039)},
            {name="Crystall Depth", pos=Vector3.new(5749,-905,15393)},
            {name="Gran Maja", pos=Vector3.new(5638,-900,15352)},
            {name="Cursed Kraken 1 (PC)", pos=Vector3.new(5639,-879,15396)},
            {name="Cursed Kraken 2 (PC)", pos=Vector3.new(5685,-896,15327)},
            {name="Cristalized 1", pos=Vector3.new(5830,-896,15346)},
			{name="Cursed Kraken", pos=Vector3.new(5614, -904, 15344)},
        }
    },
	{
        name = "Gloomcamp Grotto",
        spots = {
            {name="Gloomcamp Grotto", pos=Vector3.new(5827, -861, 12328)},
            {name="Sell Ikan", pos=Vector3.new(5987, -851, 12387)},
			{name="Jembatan", pos=Vector3.new(5890, -867, 12292)}
        }
    },
	{
        name = "Starfall Garden",
        spots = {
            {name="Starfall Garden", pos=Vector3.new(-22231, -249, -8101)},
			{name="Sell Fish & Charm", pos=Vector3.new(-22216, -253, -8052)},
			{name="NPC Celestial Warlock", pos=Vector3.new(-22207, -249, -8125)},
			{name="Misi Star 1", pos=Vector3.new(-22292, -253, -7989)},
			{name="Misi Star 2", pos=Vector3.new(-22144, -231, -7844)},
			{name="Misi Star 3", pos=Vector3.new(-22260, -249, -8158)},
			{name="Misi Star 4", pos=Vector3.new(-22204, -248, -8078)},
			{name="Misi Star 5", pos=Vector3.new(-28417, -161, -8267)},
			{name="NPC Mayor Starfall", pos=Vector3.new(-22249, -253, -8049)},
			{name="NPC Grandma Starla", pos=Vector3.new(-22208, -253, -7984)},
			{name="Claim Bobber", pos=Vector3.new(-21956, -237, -7971)},
			{name="Spot 1 Secret", pos=Vector3.new(-22197, -253, -7990)}
			
        }
    },
	{
        name = "The Celestarium",
        spots = {
			{name="The Celestarium", pos=Vector3.new(-28378, -154, -8299)},
            {name="star machine", pos=Vector3.new(-28379, -155, -8135)},
			{name="NPC Azorath", pos=Vector3.new(-28398, -162, -8169)},
			{name="SPOT 1", pos=Vector3.new(-28377, -162, -8256)},
			{name="SPOT 2", pos=Vector3.new(-28344, -162, -8194)}
			
        }
    },
	{
        name = "Cooper Canyon",
        spots = {
            {name="Cooper Canyon", pos=Vector3.new(-4098, 4, 644)},
            {name="NPC WR Stone ", pos=Vector3.new(-4270, 24, 717)},
			{name="NPC Sell Fish", pos=Vector3.new(-4239, 21, 685)},
			{name="NPC Clara PETS", pos=Vector3.new(-4288, 23, 652)},
			{name="NPC Outlaws", pos=Vector3.new(-4123, 8, 423)},
			{name="NPC Prospector", pos=Vector3.new(-4227, 60, 400)},
			{name="Spot 1 atas", pos=Vector3.new(-4193, 60, 432)},
			{name="Spot 1 bawah", pos=Vector3.new(-4147, 7, 616)}
        }
    },
{
        name = "Cooper Canyon Mines",
        spots = {
            {name="Cooper Canyon Mines", pos=Vector3.new(-4167, -555, 534)},
            {name="NPC Nerveous", pos=Vector3.new(-4082, -548, 550)},
			{name="NPC Null Crafting", pos=Vector3.new(-4057, -550, 476)},
			{name="Atas Pengait", pos=Vector3.new(-4036, -520, 555)},
			{name="Atas pengait", pos=Vector3.new(-4039, -539, 552)},
			{name="Spot 1 WR", pos=Vector3.new(-4135, -555, 552)},
			{name="Spot 2 WR", pos=Vector3.new(-4011, -548, 544)}
        }
    },
	{
        name = "Mariana Trench",
        spots = {
			{name="Mariana Trench", pos=Vector3.new(-9276, -241, -86)},
            {name="Silent Reach", pos=Vector3.new(-10010, -80, 40)},
			{name="Spot Silent Reach", pos=Vector3.new(-9998, -65, 172)},
            {name="Lucky Volcano 2", pos=Vector3.new(-8644, -50, -274)},
			{name="rushing current", pos=Vector3.new(-9709, -75, -1731)},
			{name="mutation Vent", pos=Vector3.new(-9225, -92, -1578)},
			{name="Lucky Abbys", pos=Vector3.new(9119, -270, 901)},
			{name="Shiny Abbys", pos=Vector3.new(-9752, -270, 791)}
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
        name = "Underwater City",
        spots = {
			{name="Underwater City", pos=Vector3.new(-3185, -637, -10243)},
			{name="Atas Atlantis Machine", pos=Vector3.new(-3165, -624, -10449)},
			{name="Spot Runic", pos=Vector3.new(-3143, -644, -10450)},
			{name="Tengah Tengah", pos=Vector3.new(-3143, -644, -10412)},
			{name="Jembatan Kiri", pos=Vector3.new(-3223, -637, -10320)},
			{name="Lorong", pos=Vector3.new(-3116, -667, -10522)},
			{name="Spot 2 Pipa", pos=Vector3.new(-3092, -640, -10475)},
			{name="Samping Pipa 2", pos=Vector3.new(-3071, -640, -10445)},
			{name="Spot Jendela", pos=Vector3.new(-3351, -639, -10734)},
			{name="Spot Bawah Pohon", pos=Vector3.new(-3372, -637, -10547)},
			{name="Pipa Lorong", pos=Vector3.new(-3148, -649, -10552)},
        }
    },

	{
        name = "Planet Observatory",
        spots = {
            {name="Submarine Operator", pos=Vector3.new(421, 3, 2185)},
            {name="D.M.C Meteorologist", pos=Vector3.new(426, 31, 2100)},
			{name="Spot Meteor Shark 1", pos=Vector3.new(474, 5, 2217)},
			{name="Spot Meteor Shark 2", pos=Vector3.new(525, 4, 2256)},
			{name="Buy Charm Meteor", pos=Vector3.new(-3177, -639, -10569)},
			{name="Underwater City", pos=Vector3.new(-3185, -637, -10243)},
			{name="Atas Atlantis Machine", pos=Vector3.new(-3165, -624, -10449)},
			{name="Tengah Tengah", pos=Vector3.new(-3143, -644, -10412)},
			{name="Jembatan Kiri", pos=Vector3.new(-3223, -637, -10320)},
			{name="Lorong", pos=Vector3.new(-3116, -667, -10522)},
			{name="Spot 2 Pipa", pos=Vector3.new(-3092, -640, -10475)},
			{name="Samping Pipa 2", pos=Vector3.new(-3071, -640, -10445)},
			{name="Spot Jendela", pos=Vector3.new(-3351, -639, -10734)},
			{name="Spot Bawah Pohon", pos=Vector3.new(-3372, -637, -10547)},
			{name="Pipa Lorong", pos=Vector3.new(-3148, -649, -10552)},
        }
    },
	{
        name = "Sewers",
        spots = {
            {name="Pintu Masuk", pos=Vector3.new(-1419, -1042, -10413)},
            {name="Charm RDA", pos=Vector3.new(-1459, -1042, -10482)},
			{name="Posisi Tengah", pos=Vector3.new(-1443, -1042, -10447)},
			{name="Depan Charm", pos=Vector3.new(-1472, -1042, -10475)},
			{name="Pagar Lubang Air", pos=Vector3.new(-1496, -1042, -10450)},
			
        }
    },
	{
        name = "ThunderZilla",
        spots = {
            {name="Depan Batu", pos=Vector3.new(2117, 0, 21)},
            {name="Spot Kiri", pos=Vector3.new(2061, 0, 62)},
			{name="Spot Kanan", pos=Vector3.new(2072, 0, -36)},
			{name="Spot Dpn Jungle", pos=Vector3.new(2013, 1, 3)},
			{name="Dpn Jungle", pos=Vector3.new(1786, 0, -12)},
			{name="Spot ThunderZIlla", pos=Vector3.new(2015, 8, -1)},
			
        }
    },
	{
        name = "Ancient Jungle",
        spots = {
            {name="Ancient Jungle", pos=Vector3.new(1282,2,-131)},
			{name="Enchant Kuil", pos=Vector3.new(1482,127,-581)},
            {name="Jual Ikan Jungle", pos=Vector3.new(1327,7,-207)},
            {name="Beli Bamboo Rod", pos=Vector3.new(1572,-42,-644)},
            {name="Beli Floral Bait", pos=Vector3.new(1380,-42,-620)},
            {name="Kuil", pos=Vector3.new(1475,-22,-631)},
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
        name = "Weather Machine",
        spots = {
            {name="spot worm", pos=Vector3.new(-1522,2,1912)},
            {name="spot worm", pos=Vector3.new(74,2249,-20)}
        }
    },
    {
        name = "Salon De Fiestas",
        spots = {
           {name="Tengah Titan", pos=Vector3.new(115,4,104)},
            {name="Atas Atap", pos=Vector3.new(127,52,103)},
            {name="Balkon Depan Luar", pos=Vector3.new(124,24,33)},
            {name="Balkon Belakang Luar", pos=Vector3.new(125,24,156)},
            {name="Balkon Kiri Luar", pos=Vector3.new(191,24,103)},
            {name="Balkon Kanan Luar", pos=Vector3.new(53,24,109)}
        }
    },
	{
        name = "Vibu",
        spots = {
            {name="CP 01", pos=Vector3.new(23, 59, -342)},
            {name="CP 02", pos=Vector3.new(618, 184, -1412)},
			{name="CP 03", pos=Vector3.new(1228, 484, -2685)},
			{name="CP 04", pos=Vector3.new(1638, 680, -3972)},
			{name="CP 05", pos=Vector3.new(1633, 1032, -5240)},
			{name="CP 06", pos=Vector3.new(1302, 1228, -6774)},
			{name="CP 07", pos=Vector3.new(758, 1312, -7922)},
			{name="CP 08", pos=Vector3.new(669, 1328, -9163)},
			{name="CP 09", pos=Vector3.new(985, 1756, -10378)},
			{name="CP 10", pos=Vector3.new(1333, 2076, -11407)},
			{name="Summit", pos=Vector3.new(671, 2481, -12277)},
        }
    },
}


-----------------------------------------------------------
-- UI STRUCTURE
-----------------------------------------------------------
local openBtn = Instance.new("TextButton", sg)
openBtn.Size = UDim2.fromOffset(45, 45); 
openBtn.Position = UDim2.new(0, 10, 0.5, 80); 
openBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0); 
openBtn.Text = "TP"; openBtn.TextColor3 = Color3.new(1, 1, 1); 
openBtn.Font = "GothamBlack"; openBtn.TextSize = 30; 
openBtn.Draggable = true; 
openBtn.Visible = false; 
createCorner(openBtn, 22)

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0.50, 0, 1, 0); 
main.BackgroundColor3 = Color3.fromRGB(20, 0, 0); 
main.BorderSizePixel = 0

-- Header
local header = Instance.new("Frame", main); header.Size = UDim2.new(1, 0, 0, 50); header.BackgroundTransparency = 1
local title = Instance.new("TextLabel", header); title.Size = UDim2.new(1, -90, 1, 0); title.Position = UDim2.new(0, 15, 0, 0); 
title.Text = "TELEPORT MAP V.1"; title.TextColor3 = Color3.new(1, 1, 1); title.Font = "GothamBlack"; title.TextSize = 16; title.TextXAlignment = "Left"; title.BackgroundTransparency = 1

local minBtn = Instance.new("TextButton", header); minBtn.Size = UDim2.new(0, 32, 0, 32); minBtn.Position = UDim2.new(1, -78, 0.5, -16); minBtn.Text = "━"; minBtn.BackgroundColor3 = Color3.fromRGB(45, 0, 0); minBtn.TextColor3 = Color3.new(1, 1, 1); minBtn.Font = "GothamBold"; minBtn.TextSize = 20; createCorner(minBtn, 6)
local closeBtn = Instance.new("TextButton", header); closeBtn.Size = UDim2.new(0, 32, 0, 32); closeBtn.Position = UDim2.new(1, -40, 0.5, -16); closeBtn.Text = "✖"; closeBtn.BackgroundColor3 = Color3.fromRGB(160, 0, 0); closeBtn.TextColor3 = Color3.new(1, 1, 1); closeBtn.Font = "GothamBold"; closeBtn.TextSize = 15; createCorner(closeBtn, 6)

minBtn.MouseButton1Click:Connect(function() main.Visible = false; openBtn.Visible = true end)
openBtn.MouseButton1Click:Connect(function() main.Visible = true; openBtn.Visible = false end)
closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

-----------------------------------------------------------
-- SCROLL AREAS
-----------------------------------------------------------
-- Atas: Dropdown Maps
local scrollMaps = Instance.new("ScrollingFrame", main); scrollMaps.Size = UDim2.new(1, 0, 1, -270); 
scrollMaps.Position = UDim2.new(0, 0, 0, 55); 
scrollMaps.BackgroundTransparency = 1; 
scrollMaps.ScrollBarThickness = 2
local layoutMaps = Instance.new("UIListLayout", 
scrollMaps); layoutMaps.Padding = UDim.new(0, 2); layoutMaps.HorizontalAlignment = "Center"

-- Bawah: Footer (Manual & Save)
local footer = Instance.new("Frame", main); footer.Size = UDim2.new(1, 0, 0, 210); footer.Position = UDim2.new(0, 0, 1, -210); footer.BackgroundColor3 = Color3.fromRGB(30, 0, 0)

local box = Instance.new("TextBox", footer); box.Size = UDim2.new(0.7, -15, 0, 38); box.Position = UDim2.new(0, 10, 0, 10); box.Text = ""; box.PlaceholderText = "X, Y, Z"; box.BackgroundColor3 = Color3.fromRGB(15, 0, 0); box.TextColor3 = Color3.new(1, 1, 1); box.TextSize = 14; createCorner(box)
local go = Instance.new("TextButton", footer); go.Size = UDim2.new(0.3, -10, 0, 38); go.Position = UDim2.new(0.7, 0, 0, 10); go.Text = "TP"; go.BackgroundColor3 = Color3.fromRGB(110, 0, 0); go.TextColor3 = Color3.new(1, 1, 1); go.TextSize = 15; go.Font = "GothamBold"; createCorner(go)

local saveBtn = Instance.new("TextButton", footer); saveBtn.Size = UDim2.new(1, -20, 0, 40); saveBtn.Position = UDim2.new(0, 10, 0, 55); saveBtn.Text = "📍 SAVE CURRENT POS"; saveBtn.BackgroundColor3 = Color3.fromRGB(0, 110, 0); saveBtn.TextColor3 = Color3.new(1, 1, 1); saveBtn.Font = "GothamBold"; saveBtn.TextSize = 14; createCorner(saveBtn)

local scrollSaved = Instance.new("ScrollingFrame", footer); scrollSaved.Size = UDim2.new(1, -10, 0, 100); scrollSaved.Position = UDim2.new(0, 5, 0, 105); scrollSaved.BackgroundTransparency = 1; scrollSaved.ScrollBarThickness = 2
local layoutSaved = Instance.new("UIListLayout", scrollSaved); layoutSaved.Padding = UDim.new(0, 5); layoutSaved.HorizontalAlignment = "Center"

-----------------------------------------------------------
-- LOGIC FUNCTIONS
-----------------------------------------------------------
local function createMapDrop(name, data)
    local frame = Instance.new("Frame", scrollMaps); frame.Size = UDim2.new(1, -16, 0, 32); frame.BackgroundColor3 = Color3.fromRGB(50, 0, 0); frame.ClipsDescendants = true; createCorner(frame)
    local b = Instance.new("TextButton", frame); b.Size = UDim2.new(1, 0, 0, 32); b.Text = "  ▶  " .. name; b.TextColor3 = Color3.new(1,1,1); b.BackgroundTransparency = 1; b.TextXAlignment = "Left"; b.Font = "GothamBold"; b.TextSize = 14
    local cont = Instance.new("Frame", frame); cont.Position = UDim2.new(0, 5, 0, 35); cont.Size = UDim2.new(1, -10, 0, 0); cont.BackgroundTransparency = 1
    local grid = Instance.new("UIGridLayout", cont); grid.CellSize = UDim2.new(0.5, -5, 0, 26); grid.CellPadding = UDim2.new(0, 4, 0, 4)

    for _, item in ipairs(data) do
        local btn = Instance.new("TextButton", cont); btn.Text = item.name; btn.BackgroundColor3 = Color3.fromRGB(85, 0, 0); btn.TextColor3 = Color3.new(1,1,1); btn.TextSize = 10; btn.Font = "GothamMedium"; createCorner(btn)
        btn.MouseButton1Click:Connect(function() LP.Character.HumanoidRootPart.CFrame = CFrame.new(item.pos) end)
    end

    local open = false
    b.MouseButton1Click:Connect(function()
        open = not open; b.Text = (open and "  ▼  " or "  ▶  ") .. name
        local rows = math.ceil(#data / 2)
        frame.Size = UDim2.new(1, -16, 0, open and (40 + (rows * 30)) or 32)
        cont.Size = UDim2.new(1, -10, 0, rows * 30)
        scrollMaps.CanvasSize = UDim2.new(0, 0, 0, layoutMaps.AbsoluteContentSize.Y + 20)
    end)
end

local function createSavedCard(name, pos)
    local card = Instance.new("Frame", scrollSaved); 
	card.Size = UDim2.new(1, -10, 0, 35); 
	card.BackgroundColor3 = Color3.fromRGB(45, 55, 45); 
	createCorner(card, 5)
    local lbl = Instance.new("TextLabel", card); 
	lbl.Size = UDim2.new(0.4, 0, 1, 0); 
	lbl.Position = UDim2.new(0, 8, 0, 0); 
	lbl.Text = name; lbl.TextColor3 = Color3.new(1,1,1); 
	lbl.Font = "GothamBold"; 
	lbl.TextSize = 20; 
	lbl.BackgroundTransparency = 1; lbl.TextXAlignment = "Left"
    
    local btnArea = Instance.new("Frame", card); 
	btnArea.Size = UDim2.new(0.6, 0, 1, 0); 
	btnArea.Position = UDim2.new(0.4, 0, 0, 0); 
	btnArea.BackgroundTransparency = 1
    local bl = Instance.new("UIListLayout", 
	btnArea); bl.FillDirection = "Horizontal"; 
	bl.HorizontalAlignment = "Right"; 
	bl.VerticalAlignment = "Center"; bl.Padding = UDim.new(0, 3)

    local function mk(t, c, f)
        local b = Instance.new("TextButton", 
		btnArea); b.Size = UDim2.new(0, 35, 0, 24); 
		b.Text = t; b.BackgroundColor3 = c; 
		b.TextColor3 = Color3.new(1,1,1); 
		b.Font = "GothamBold"; b.TextSize = 10; createCorner(b, 4)
        b.MouseButton1Click:Connect(function() f(b) end)
    end
    
    mk("TP", Color3.fromRGB(0, 130, 0), function() LP.Character.HumanoidRootPart.CFrame = CFrame.new(pos) end)
    mk("Copy", Color3.fromRGB(0, 90, 160), function(btn) 
        setclipboard(math.floor(pos.X)..", "..math.floor(pos.Y)..", "..math.floor(pos.Z)) 
        btn.Text = "OK!"; task.wait(1); btn.Text = "Copy"
    end)
    mk("X", Color3.fromRGB(160, 0, 0), function() card:Destroy(); _G.TelePositions[name] = nil end)
    
    scrollSaved.CanvasSize = UDim2.new(0, 0, 0, layoutSaved.AbsoluteContentSize.Y)
end

-----------------------------------------------------------
-- INIT & EVENTS
-----------------------------------------------------------
for _, m in ipairs(MapsData) do createMapDrop(m.name, m.spots) end

saveBtn.MouseButton1Click:Connect(function()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local pos = hrp.Position
        local n = "Pos: "..math.floor(pos.X)..", "..math.floor(pos.Y)..", "..math.floor(pos.Z)
        if not _G.TelePositions[n] then
            _G.TelePositions[n] = pos
            createSavedCard(n, pos)
        end
    end
end)

go.MouseButton1Click:Connect(function()
    local c = box.Text:gsub(" ",""):split(",")
    if #c == 3 then LP.Character.HumanoidRootPart.CFrame = CFrame.new(tonumber(c[1]), tonumber(c[2]), tonumber(c[3])) end
end)
