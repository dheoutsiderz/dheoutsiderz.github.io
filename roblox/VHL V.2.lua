--=========================================
-- ⚔️ VALHALLA V.1 — MAIN GUI STRUCTURE (Base)
--=========================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Helper function
local function newCorner(obj, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 8)
	c.Parent = obj
	return c
end

-- Main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Valhalla_V1_GUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = PlayerGui

-- Main Frame
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 500, 0, 420)
main.Position = UDim2.new(0, 20, 1, -440)
main.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
newCorner(main, 12)

-- Header
local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 46)
header.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
newCorner(header, 12)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -140, 1, 0)
title.Position = UDim2.new(0, 16, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.Text = "VALHALLA V.1"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left

-- 🌀 Burger Icon (Hidden)
local burgerIcon = Instance.new("TextButton", screenGui)
burgerIcon.Name = "BurgerIcon"
burgerIcon.Size = UDim2.fromOffset(70, 70)
burgerIcon.Position = UDim2.new(0, 20, 1, -500)
burgerIcon.AnchorPoint = Vector2.new(0, 0)
burgerIcon.Text = "VHL"
burgerIcon.Font = Enum.Font.GothamBlack
burgerIcon.TextScaled = true
burgerIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
burgerIcon.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
burgerIcon.BorderSizePixel = 0
burgerIcon.ZIndex = 5
burgerIcon.Visible = false
newCorner(burgerIcon, 70)

-- Hover Effect
local stroke = Instance.new("UIStroke", burgerIcon)
stroke.Thickness = 2
stroke.Transparency = 0.25
stroke.Color = Color3.fromRGB(255, 0, 0)

burgerIcon.MouseEnter:Connect(function()
	TweenService:Create(burgerIcon, TweenInfo.new(0.15), {
		Size = UDim2.fromOffset(76, 76),
		BackgroundColor3 = Color3.fromRGB(50, 0, 0)
	}):Play()
end)
burgerIcon.MouseLeave:Connect(function()
	TweenService:Create(burgerIcon, TweenInfo.new(0.15), {
		Size = UDim2.fromOffset(70, 70),
		BackgroundColor3 = Color3.fromRGB(30, 0, 0)
	}):Play()
end)

-- Minimize & Close
local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 42, 0, 28)
minimizeBtn.Position = UDim2.new(1, -92, 0.5, -14)
minimizeBtn.Text = "━"
minimizeBtn.Font = Enum.Font.GothamBlack
minimizeBtn.TextSize = 22
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
newCorner(minimizeBtn, 8)

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.new(0, 42, 0, 28)
closeBtn.Position = UDim2.new(1, -46, 0.5, -14)
closeBtn.Text = "✖"
closeBtn.Font = Enum.Font.GothamBlack
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
newCorner(closeBtn, 8)

-- Button Logic
minimizeBtn.MouseButton1Click:Connect(function()
	main.Visible = false
	burgerIcon.Visible = true
end)

burgerIcon.MouseButton1Click:Connect(function()
	burgerIcon.Visible = false
	main.Visible = true
end)

closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Left Tabs
local tabsFrame = Instance.new("Frame", main)
tabsFrame.Size = UDim2.new(0, 140, 1, -46)
tabsFrame.Position = UDim2.new(0, 0, 0, 46)
tabsFrame.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
tabsFrame.BorderSizePixel = 0
newCorner(tabsFrame, 8)

-- Content Area
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -140, 1, -46)
content.Position = UDim2.new(0, 140, 0, 46)
content.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
content.BorderSizePixel = 0
newCorner(content, 10)

-- Tabs System
local tabs = {}
local function createContentFrame(name)
	local f = Instance.new("Frame")
	f.Name = name
	f.Size = UDim2.new(1, 0, 1, 0)
	f.BackgroundTransparency = 1
	f.Visible = false
	f.Parent = content
	tabs[name] = f
	return f
end

local function CreateTabButton(text, order, tabName)
	local btn = Instance.new("TextButton", tabsFrame)
	btn.Size = UDim2.new(1, -16, 0, 40)
	btn.Position = UDim2.new(0, 8, 0, (order - 1) * 50 + 8)
	btn.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
	btn.BorderSizePixel = 0
	btn.Font = Enum.Font.GothamBold
	btn.Text = text
	btn.TextSize = 18
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	newCorner(btn, 10)

	btn.MouseButton1Click:Connect(function()
		for name, frame in pairs(tabs) do
			frame.Visible = (name == tabName)
		end
	end)

	return btn
end

-- Search Helper
local function mkSearch(parent, placeholder)
	local box = Instance.new("TextBox")
	box.Size = UDim2.new(1, -20, 0, 34)
	box.Position = UDim2.new(0, 10, 0, 10)
	box.PlaceholderText = placeholder or "Search..."
	box.Font = Enum.Font.GothamBold
	box.TextSize = 16
	box.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.BorderSizePixel = 0
	box.Parent = parent
	newCorner(box, 8)
	return box
end

-- Tabs Initialization
local EmoteTab = createContentFrame("Emote")
local SpyTab = createContentFrame("Spy")
local AvatarTab = createContentFrame("Avatar")
local ClothsTab = createContentFrame("Cloths")
local AuraTab = createContentFrame("Aura")
local TitanTab = createContentFrame("Titan")
local CheatTab = createContentFrame("Cheat")


CreateTabButton("EMOTE", 1, "Emote")
CreateTabButton("SPY", 2, "Spy")
CreateTabButton("AVATAR", 3, "Avatar")
CreateTabButton("CLOTHS", 4, "Cloths")
CreateTabButton("AURA", 5, "Aura")
CreateTabButton("TITAN", 6, "Titan")
CreateTabButton("CHEAT", 7, "Cheat")


tabs["Emote"].Visible = true






--=========================================
-- 🎭 VALHALLA V.X — EMOTE TAB (Global Search + Pagination Fix)
--=========================================
do
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer

	--== HEADER ==--
	local eTitle = Instance.new("TextLabel", EmoteTab)
	eTitle.Size = UDim2.new(1, -20, 0, 28)
	eTitle.Position = UDim2.new(0, 10, 0, 8)
	eTitle.BackgroundTransparency = 1
	eTitle.Font = Enum.Font.GothamBlack
	eTitle.TextSize = 20
	eTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	eTitle.TextXAlignment = Enum.TextXAlignment.Left
	eTitle.Text = "🎭 Emote Manager"

	local eHUD = Instance.new("TextLabel", EmoteTab)
	eHUD.Size = UDim2.new(1, -20, 0, 22)
	eHUD.Position = UDim2.new(0, 10, 0, 38)
	eHUD.BackgroundTransparency = 1
	eHUD.Font = Enum.Font.GothamBold
	eHUD.TextSize = 14
	eHUD.TextColor3 = Color3.fromRGB(255, 220, 220)
	eHUD.TextXAlignment = Enum.TextXAlignment.Left
	eHUD.Text = "🔹 Status: No emote active"

	--== EMOTE DATA ==--
	local EMOTES = {
		["SPIN"] = {
			{ name = "Ngeframe", id = 89227290900829 },
			{ name = "Levitate", id = 131063357988754 },
			{ name = "Elton John - Elevate", id = 11394033602 },
			{ name = "Skibidi Toilet Titan Speakerman Laser Spin", id = 134283166482394 },
			{ name = "Swinging In Air", id = 92680771102087 },
			{ name = "Swinging", id = 78512680384025 },
			{ name = "Swinging on a swing", id = 125747999910324 },
			{ name = "[NEW] Sky Swing", id = 70566397439835 },
			{ name = "Spin Me", id = 126008456731780 },
			{ name = "Spin1", id = 110792133024438 },
			{ name = "Spin2", id = 91004858616595 },
			{ name = "Money Hop Spin", id = 75672330899301 },
			{ name = "Monkey Spin", id = 105128045372416 },
			{ name = "Homer Floor Spin", id = 105128045372416 },
			{ name = "Microwave Spin", id = 80416220413470 },
			{ name = "Spin Around with a Friend Matching", id = 80879471830819 },
			{ name = "Spinning", id = 100935687246938 },
			{ name = "Head Spin1", id = 113821268084684 },
			{ name = "Head Spin2", id = 124522818196151 },	
			{ name = "Tornado1", id = 135373056067761 },
			{ name = "Tornado2", id = 110990913678013 },
			{ name = "Funky Touhou Spin", id = 76950177647300 },	
			{ name = "Goofy Spin", id = 85058233989583 },
			{ name = "Hovering Spin", id = 95329943746305 },
			{ name = "Hover Torso Spin", id = 96827306464973 },
			{ name = "Plushie Sit Spin", id = 115204251208617 },
			{ name = "Spinning Dancing Roach", id = 73178676975054 },
			{ name = "Particle Accelerator Spin", id = 133779321964805 },
			{ name = "SLOW 360 SPIN", id = 130065247828069 },
			{ name = "🐛 Wigglepillar.exe", id = 91114883954161 },
			{ name = "Sonic's Spindash", id = 119889021060156 },
		},


		
		["ANOMALY"] = {
			
			{ name = "SEIZURE", id = 98719422024341 },
			{ name = "Flopping Fish", id = 79075971527754 },
			{ name = "Worm", id = 112024753958948 },
			{ name = "Halloween Headless Effortless Aura", id = 121812124134821 },
			{ name = "🎃Pumpkin king👑 Helloween", id = 98413544617717 },
			{ name = "Around the Head", id = 124729247977888 },
			{ name = "Stylish Head Spin CHEAP", id = 78413960254297 },
			{ name = "head levitating cool pose", id = 83771735525171 },
			{ name = "Circus Head Balance", id = 106291630863459 },
			{ name = "invisible-me", id = 127212897044971 },
			{ name = "e invisible BEST", id = 134386657144069 },
			{ name = "Helicopter", id = 76510079095692 },
			{ name = "Floating Bodyparts", id = 104493858272363 },			
			{ name = "Glitch through walls", id = 86036950557685 },
			{ name = "RAPID FIRE Gun Morph", id = 107728954756412 },
			{ name = "Speed Mirage", id = 96731289267640 },
			{ name = "Little Obbyist", id = 115569573258316 },
			{ name = "Speed Glitch+", id = 80120791952773 },
			{ name = "New Best No clip and Speed", id = 115176965319158 },
			
		},
		["POSE"] = {

			{ name = "Aura Idle", id = 122746752555782 }, --FLY
			{ name = "Levitation Idle Emote 2", id = 113087712986783 },
			{ name = "Effortless Aura Farming", id = 92770238137159 },
			{ name = "Bored", id = 10713992055 },
			{ name = "Gangster Pose", id = 79137761903782 },
			{ name = "Police Vest Rest Pose", id = 83026903211659 },
			{ name = "FORSAKEN John Doe Pose", id = 72526127498800 },
			{ name = "Piccolo Aura Farm", id = 120442396223948 },
			
			{ name = "♡ : super shy girly idle pose", id = 132231192986474 },
			{ name = "♡ Cute n shy Idle Emote Profile Pose", id = 80222624644964 },
			{ name = "Saja Boys Pose K-Demon Hunters", id = 137722603631996 },
			{ name = "adorable dolly pose ", id = 101717677816415 },
			{ name = "Sonic Adventure Profile Pose ", id = 127286984691941 },
			{ name = "ZENITSU", id = 72756717372074 },
			{ name = "FORSAKEN c00lkid Pose", id = 95203125292023 },
			{ name = "Sae Itoshi", id = 92116031773879 },
			{ name = "AKAZA COMPASS STAND", id = 91272249010090 },
			{ name = "Hatsune Miku Idle Pose", id = 102071710417689 },
			{ name = "Menacing Vampire", id = 117040875500187 },
			

			{ name = "Head Pat High", id = 129028749543457 },
			{ name = "Head Pat LOW", id = 89973918892326 },
			{ name = "Pats & Pets", id = 79836879022390 },	
			{ name = "Getting pats ", id = 125620162258383 },

			{ name = "♡: Cute Shy Sway ", id = 111791335636739 },
			
			{ name = "Head scratches - Head pats", id = 114313599861536 },	
			{ name = "♡ kawaii magical girl kpop idle pose", id = 87225106485926 },
			
			
			

			{ name = "KAMEHAMEHA", id = 10714389396 },
			{ name = "Godlike", id = 10714347256 },
			{ name = "Cute Hips Profile Pose", id = 117181705578424 },
			
			
			{ name = "Chill Pose - wall", id = 78848614632586 },
			{ name = "Cute crouch", id = 93731275877969 },
			{ name = "Cute", id = 134221596131910 },
			{ name = "Pose for the Pic 📸", id = 117336874204710 },
		},
		["FLOAT"] = {
			{ name = "Stylish Floating", id = 112089880074848 },
			{ name = "Fashionable Floating", id = 79427658849804 },
			{ name = "Super Cool Float", id = 93302851761572 },
			{ name = "Sukuna Float", id = 83732702799140 },
			{ name = "Floating God", id = 73980801925168 },
			{ name = "Floating Angel", id = 114959114929023 },
			{ name = "♥ fairy float", id = 86767222955628 },
			{ name = "Gojo Floating The Honored One", id = 109030594660124 },
			{ name = "Floating in Love", id = 102342919277367 },
			{ name = "Kicking Feet Laying Float (Thinking About You <3)", id = 135630098620308 },
			{ name = "Floating In Space", id = 96694088279578 },
			{ name = "Float In The Sky", id = 74366578999263 },
			{ name = "Floating Spin", id = 137847348761702 },
			{ name = "HOT Spinning Cat", id = 135311171741053 },
			{ name = "Floating on clouds", id = 77840765435893 },
			{ name = "Aura Pose Floating KING", id = 70375615605401 },
			{ name = "SpiderMan Hanging Pose", id = 123955307291627 },
			{ name = "Spiderman Hang", id = 83345430870757 },
			{ name = "Cool Spiderman", id = 71918078252326 },
			{ name = "🕷 SPIDERMAN POSE", id = 123888267685221 },
			{ name = "SpiderMan Stance", id = 105660889267902 },
			{ name = "FLOATING IN AURA", id = 101015832986529 },
			{ name = "Effortless Aura Pose", id = 133418516499878 },
			{ name = "Floating Immortality Cultivator Meditation", id = 132625096369457 },
			{ name = "Floating Relaxation", id = 108540721793164 },
			{ name = "floating thinker", id = 91157835269964 },
			{ name = "Spooky Float", id = 133523945826598 },
			{ name = "Unbothered Aura Floating Sitting", id = 88225720130440 },
			{ name = "sit and hug (matching 1)", id = 117154715182434 },
			{ name = "prince float (matching with princess)", id = 124593296684755 },
			{ name = "Matching emote 1", id = 124593296684755 },
			{ name = "Matching emote 2", id = 130475965340195 },

			{ name = "Floating Sitting", id = 84179650680787 },
			{ name = "Floating Laugh Gogeta BAHAHA", id = 117612306395442 },
			{ name = "Zen floating meditation emote", id = 103853175871097 },

			
		},
		["FLY"] = {
			{ name = "e-fly", id = 91133306449431 },
			{ name = "FLY2", id = 89523370947906 },
			{ name = "Flying", id = 117803396402998 },
			{ name = "Flying Superhero", id = 139316348405933 },
			{ name = "Flying Headspin", id = 103176466848993 },
			{ name = "Flying UFO", id = 118703314621593 },
			{ name = "Flying Ghost", id = 71551101275479 },
			{ name = "Baby Sit", id = 106700033859778 },
			{ name = "Sad Sit", id = 76194987015555 },
			{ name = "Flying Broom Witch Halloween", id = 132644742102046 },
			{ name = "Relaxed Lean Sit", id = 115415367985235 },
			{ name = "Flying Celestial Dunhuang Feitian Apsara Immortal", id = 109964124738715 },
		},
		["HUG"] = {
			{ name = "cute plush hug", id = 88875926125122 },
			{ name = "Hugging a Plushie", id = 71421245788594 },
			{ name = "cute hugging plushie idle emote", id = 137631388828941 },
			{ name = "Duo Hug Emote (Hugging)", id = 139846829336719 },
			{ name = "Cute Hug Pose 1 MATCHING", id = 132014993199931 },
			{ name = "Hug Emote", id = 73124906770925 },
			{ name = "Sweet Hug Pose V2 MATCHING", id = 118264035209903 },
			{ name = "Hug 🤗❤️", id = 118478639008343 },
			{ name = "Cozy Hug Pose V1 [MATCHING]", id = 88383446061342 },
			{ name = "Cute hug + petting", id = 115731801744043 },
			{ name = "MATCHING Sitting Hug 1", id = 100032088866413 },
			{ name = "Cute Matching Sit Hug 2-2", id = 105341373580564 },
			{ name = "cute plushie hug sit", id = 85638447484999 },
			{ name = "🤍 cutesi shy embrace profile pose", id = 77471980954315 },
			{ name = "Sweet Embrace Matching 1", id = 120711290059318 },
			{ name = "Sweet Embrace Matching 2", id = 112078433891854 },
		},
		["LEVITATE"] = {
			{ name = "Cuco - Levitate", id = 15698404340 },
			{ name = "Levitate - F1", id = 93318476235092 }, -- Fly
			{ name = "Floating / Levitating Aura Farming God", id = 76625806728264 }, --fly
			{ name = "Levitation Idle Emote", id = 92967667525489 }, --fly
			{ name = "Levitate - P1", id = 139126843666438 }, --Fly pose foto 1
			{ name = "Levitate - P2", id = 100827816514743 }, --Fly pose foto 
			{ name = "Sideways Chill Levitation", id = 72276728857706 },
			{ name = "Levitation Sit", id = 73814846238255 }, --sit
			{ name = "Levitat S1", id = 84214424948939 }, --sit
			{ name = "Levitat S2", id = 116988807998422 }, --sit
			{ name = "Menacingly Levitating", id = 118080259725285 }, --sit
			{ name = "Relaxing Chill Levitation", id = 89996348645965 },
			
			
		},

		["LEAN WALL"] = {
			{ name = "Wall Lean Pose 1", id = 113694692828125 }, --kekanan
			{ name = "Wall Lean Pose 2", id = 99593986466315 }, --tengah
			{ name = "Wall Lean - hvnsnt", id = 128744696457318 }, --tengah
			{ name = "Nonchalantly Leaning", id = 138429027900975 }, --tengah
			{ name = "Side Lean AURAFARMING", id = 138100149715377 }, --KeKiri
			{ name = "Side Wall Lean", id = 84124626233808 }, --KeKiri
			{ name = "Wall Lean Dynamic Face Animation V1", id = 87613777175338 },
			{ name = "Wall Lean", id = 112018126760165 },
			{ name = "Wall Car pose ", id = 72094470168307 },
			{ name = "Leaning Against Wall Arms Crossed", id = 137050689270734 },
			{ name = "AURA FARM YN Wall Lean", id = 114388371896974 },
			{ name = "Car Pose Crossed Arms Lean 1.0", id = 139853858727379 },
			{ name = "Car Pose Tokyo Lean", id = 132760747409859 },
			{ name = "aura-farming-wall-lean-hands-in-pockets", id = 74129426877661 },
			{ name = "Wall Lean ", id = 98576036035538 },
			{ name = "peek-lean-left", id = 123862584261569 },
			{ name = "Aura Lean Pose", id = 108102772285697 },
			{ name = "peeking lean right", id = 87095827181320 },
			{ name = "Leaning Left Cute Kawaii Shy Standing Idle Pose", id = 79512307482736 },
			{ name = "Small Spoon Hug / Wall Lean matching", id = 119468870503205 },
			{ name = "Cute Leaning Back Floating Pose", id = 132010019724953 },
			{ name = "coy-scene-cute-shy-leaning-pose-v1", id = 74707304756409 },
			{ name = "Stylish wall lean head bopping", id = 140080058448455 },
		},



		["RUN & WALK"] = {
			{ name = "Fake R15 Zombie Run", id = 81981358389159 },
			{ name = "Panic RUN", id = 131462725467743 },
		},
		["SIT"] = {
			{ name = "Alone Sad Sit", id = 117639474362201 },
			{ name = "Arms Sit Idle", id = 97532637410256 },
			{ name = "Demon Slayer Douma Sit", id = 127626736897320 },
			{ name = "Nonchalant Sit", id = 126899447275562 },
			
			{ name = "Sit1", id = 102544119718369 },
			{ name = "Sit2", id = 79178981296653 },
			{ name = "Sit3", id = 132613565926090 },
			{ name = "Bubbly Sit", id = 93120341268524 },
			{ name = "Relaxed Sit", id = 104595291484684 },
			{ name = "Relaxed Lean Sit", id = 115415367985235 },

			{ name = "Asian Squat", id = 75040559357535 },
			{ name = "Sitting Squat Idle Pose", id = 96357779735687 },
			{ name = "High School Squat Sit", id = 84129863420846 },
			{ name = "Slav Squat", id = 80745177719793 },
			{ name = "Slavic Squat", id = 87350387256948 },
			{ name = "Sitting Laughing", id = 88839824817553 },	
			{ name = "Gangster Delinquent Crouch", id = 95168577584880 },
			{ name = "Sweet Sit Pose V1 SIT ANYWHERE", id = 75141049180386 },

			{ name = "Aura Sit", id = 77139456213922 },			
			{ name = "Flat Sitting Pose", id = 99430742775879 },
			{ name = "e sit", id = 86898753801433 },			
			{ name = "♡ | Cute Kawaii Sitting Idle Pose", id = 108970542267590 },
			{ name = "♡ ꒰ Cute Sitting Over Posee", id = 93007823380600 },			
			{ name = "Cute Mademoiselle Sit", id = 108144624364486 },
			{ name = "Cute Mademoiselle Sit", id = 125394292161615 },

			{ name = "MM2 Sit", id = 130577643309726 },
			{ name = "Kawaii Sitting Cutely", id = 129223668843262 },
			{ name = "Possessed Creepy Scary Sit", id = 123025077368973 },
		},
		["LAUGH"] = {
			{ name = "Penyeimbang Dunia", id = 101493277956253 },
			{ name = "FF LOL (Laugh)", id = 98316145061745 },
			{ name = "Cute-Feet-Kicking", id = 124287251935400 },
			{ name = "Olivia Rodrigo Head Bop", id = 81059409025475 },

			{ name = "WOOF BARK WOOF", id = 96435804447949 },
			{ name = "silly-jumping-spider-dance", id = 139310328821985 },
			{ name = "Tuff", id = 99195149999804 },
			{ name = "Head Bang", id = 93648818551396 },
			{ name = "MUAHAHAHA-EVIL-VILLAIN-LAUGH", id = 127415121971326 },
			{ name = "Arthur Morgan Coughing", id = 138706623195970 },
			{ name = "Boxing1", id = 80933111363555 },
			{ name = "Boxing2", id = 87683757107994 },
			{ name = "Dropkick", id = 133566007754001 },
			{ name = "Slow-Mo Backflip", id = 83263981931146 },
			{ name = "KAPOW!! boxing, fighting, punching", id = 71483195998835 },
			{ name = "I WANNA RUN AWAY", id = 104428851742579 },
			{ name = "Mr Tenna's Kick", id = 138408477594658 },
			{ name = "Tornado Kick", id = 128984215333257 },
			{ name = "Deltarune - Tenna Kick", id = 118139885865308 },
			
			{ name = "The shmoves", id = 108917274123277 },
			{ name = "Shuba Duck Dance (Player)", id = 139786724466087 },
			{ name = "Shuba Duck (Duck dance)", id = 112147579333528 },
			{ name = "Snake", id = 87173235683810 },
			{ name = "Happy sway", id = 131510920544621 },
			{ name = "Hip sway", id = 138316142522795 },
			{ name = "feelin myself sway", id = 77780134372141 },
			{ name = "Mean Sway", id = 74499136141567 },
			{ name = "Hip Dance (Dwerk)", id = 138671912289772 },
			{ name = "Needy Dance", id = 78086740525202 },	
			{ name = "Shake It - Emote", id = 113845704012433 },
			{ name = "Mom, call a taxi!!!", id = 120497502251867 },
			{ name = "Incredible Gassy", id = 85495100338628 },
			{ name = "Needy circle shake", id = 71970944840848 },
			{ name = "67 ! Six Seven", id = 117735161161092 },
			{ name = "67 ! Six Seven Best", id = 86835116615970 },

			{ name = "TWICE LIKEY", id = 14899979575 },
			{ name = "TWICE - Fancy", id = 94593166146998 },
			{ name = "hip sway hands behind head", id = 113344961968366 },
			
			{ name = "Super Crazy Shake Dance", id = 115591593036589 },
			{ name = "My arms are crossed. Be aware of it", id = 72081313822408 },	
			{ name = "Happy Dog", id = 128174898363655 },
			{ name = "Head Banger 1", id = 109018050573097 },
			{ name = "Head Banger 2", id = 75117155576035 },
			{ name = "Bang Head on Wall", id = 89060597619453 },
			{ name = "Skibidi Shake", id = 129069398913210 },
		},
		["COUPLE"] = {
			{ name = "[MIRA] Arm Around Sit | (1/2) Couple & Duo Sync", id = 76855167050324 },
			{ name = "[MIRA] Arm Around Sit 2 | (1/2) Couple & Duo Sync", id = 90598647736165 },
			{ name = "[MIRA] Lap Massage Pose | (1/2) Couple & Duo Sync", id = 110800242342916 },
			{ name = "Blowing Kiss Animation", id = 135823269056913 },
			{ name = "Heart Pop kiss (BADDIEE!!!)", id = 91125307877136 },
			{ name = "♡ cutesy matching spiderman kiss (mary's part)", id = 110235213168404 },
			{ name = "cute matching emote 1.0 (boy)", id = 107692835429619 },

			{ name = "Matching Titanic Pose 2/2", id = 84941959168137 },

			{ name = "Bestie Hug Right", id = 128636899430334 },
			{ name = "♡ Cute matching side friend hug emote", id = 99681083245635 },

			{ name = "Cute Hand Hold 2 MATCHING", id = 100576074728286 },
			{ name = "Linked Arms (Matching)", id = 120391982778937 },

		},
		["SLEEP"] = {
			{ name = "Sleep", id = 82858845963128 },
			{ name = "Sleeping", id = 115306317108861 },
			{ name = "Fake Death", id = 118422508938639 },
			{ name = "MM2 Fake Dead", id = 84112287597268 },
			{ name = "Playing Dead", id = 84114319413819 },
			{ name = "Sleeping Sideways", id = 100118897356565 },
			{ name = "Crying Pose", id = 104270330131897 },
			{ name = "Lying On Stomach Pose", id = 123822744060080 },
			{ name = "Laying Cutely", id = 103228987744330 },
			{ name = "Cute Kicking Feet Lay", id = 88055075246852 },
			{ name = "cute laying legs up idle", id = 98426774209184 },
			{ name = "chill laying", id = 120213959413096 },
			{ name = "Side Laying Pose Idle", id = 131208559032966 },
			
			{ name = "Sleeping Floating Idle", id = 138737799418113 },
		},
		["DANCE"] = {	
			{ name = "Sholat", id = 93009184159377 },
			{ name = "Around Town", id = 10713981723 },
			{ name = "apple store girl (do you want me)", id = 109364514498221 },

			{ name = "Baddie Hips", id = 73517007972710 },
			{ name = "Breakdance", id = 98789624256873 },
			{ name = "Belly Dance", id = 85312683743028 },
			{ name = "BEST Soda Pop", id = 139110277540140 },
			{ name = "Blue Shirt Guy Dancing", id = 133551169796944 },
			{ name = "Baddie Belly Dance", id = 96100759913198 },
			{ name = "Billy Bounce", id = 133394554631338 },
			{ name = "Boogie Down", id = 99662142344622 },

			{ name = "Candy Emote", id = 136073073685621 },
			{ name = "Caramelldansen", id = 73785690856046 },
			{ name = "Coffin Walkout", id = 126771729094882 },
			{ name = "Confess to Me", id = 108873777157620 },
			{ name = "Crip Walk", id = 132838817124258 },
			{ name = "C Walk", id = 131775634784551 },
			{ name = "Cute-Feet-Kicking", id = 124287251935400 },
			
			
			{ name = "Dance If You're Peak", id = 120407099958260 },
			{ name = "Dia Delicia Dance", id = 108759656834820 },
			{ name = "Die Lit", id = 130445733737505 },
			{ name = "Dorky Dance", id = 10714069471 },
			{ name = "Dougie Meme Dance", id = 87574738912971 },
			{ name = "Dougie Everybody Loves Me", id = 93650537970037 },	
			{ name = "DO THE DANCE WITH THE PANTS", id = 106984923725161 },
			{ name = "Druski Dance", id = 90042170774234 },
			{ name = "Deltarune Jevil idle", id = 102604133886520 },
			

			{ name = "Festive Dance", id = 15679621440 },
			{ name = "Floss Dance", id = 10714340543 },
			{ name = "Festa No Brasil - Fortnite", id = 82516443009513 },

			{ name = "Gangnam Style", id = 84884231781022 },
			{ name = "Go Mufasa", id = 134919149950950 },
			{ name = "Goofy Orange Cat Dance", id = 1039585546037 },
			

			{ name = "Hip Dance (Dwerk)", id = 138671912289772 },

			{ name = "IShowSpeed Bounce Dance", id = 111272262660539 },
			{ name = "It Ain't My Fault - Zara Larsson", id = 10714374267 },

			{ name = "Jabba Switchway", id = 116714406076290 },
			{ name = "Jason Vorhees", id = 126786971779567 },
			{ name = "Jason Vorhees ORIGINAL", id = 87282442358351 },
			{ name = "jay guapo Dance", id = 89794141549021 },
			{ name = "Jason Voorhees Catch", id = 107098873662122 },
			{ name = "Jubi Slide", id = 85247727536511 },
			{ name = "Jumpstyle Dance", id = 138647889956297 },
			{ name = "Jumpstyle Dance Loop", id = 105888820080134 },

			{ name = "Koto Nai Meme Dance", id = 83650099589962 },

			{ name = "Louisiana Jigg", id = 126597745883758 },
			
			{ name = "Michael Myers Dance", id = 82232716721054 },
			{ name = "Michael Myers Shake Dance", id = 138694026614242 },
			{ name = "MOSH", id = 96147994216119 },
			{ name = "Macarena", id = 89558401923098 },	


			{ name = "Nyan Nyan!", id = 108025254624123 },

			{ name = "Olivia Rodrigo Head Bop", id = 81059409025475 },

			{ name = "Panini Dance - Lil Nas X (LNX)", id = 10714394082 },
			{ name = "Popular", id = 93062298566806 },
			{ name = "Party Rock Anthem", id = 113074782746670 },
			
			{ name = "Rakai Dance", id = 88182429670590 },
			{ name = "Rat Dance", id = 78684440273676 },
			{ name = "Rock Out", id = 122719596509695 },
			{ name = "Robot", id = 10714392151 },
			{ name = "Rambunctious", id = 98593519635326 },
			
			{ name = "Secret Handshake Dance", id = 71243990877913 },
			{ name = "Side to Side", id = 10714366910 },
			{ name = "Shuffling", id = 118468821959324 },
			{ name = "Sturdy Dance - Ice Spice", id = 17746180844 },
			{ name = "Sturdy Dance - Ice Spice [CHEAP]", id = 99558490932154 },
			{ name = "Sturdy Dance", id = 132967433846099 },
			{ name = "Sturdy Dance", id = 132967433846099 },
			{ name = "Snoop's Walk", id = 110204898807330 },
			{ name = "Spicy Life Dance", id = 71589647866255 },
			{ name = "Sturdy", id = 128968764985212 },
			{ name = "SUIIIIII", id = 82709687426105 },
			
			{ name = "Thai style DJ Dancing", id = 123965099095742 },
			{ name = "Take The L", id = 125578981255289 },
			{ name = "Trip Out", id = 126780665379004 },
			{ name = "TV Time Dance", id = 104748118296461 },
			{ name = "The Tylil Dance", id = 110494040742516 },
			{ name = "The Look", id = 132921312059404 },
			
			{ name = "Wednesday - Jenna", id = 117572638957410 },
			{ name = "What You Want", id = 139130639469681 },
			{ name = "Yungblud Happier Jump", id = 15609995579 },

			{ name = "zesty sturdy", id = 128601227868542 },
		}
	}

	--== STATE ==--
	local currentCategory = "SPIN"
	local currentTrack, currentBtn, currentSpeed = nil, nil, 1
	local page, perPage = 1, 100
	local filtered = {}

	--== CORE FUNCTIONS ==--
	local function stopCurrentEmote()
		local char = LocalPlayer.Character
		if char and char:FindFirstChildOfClass("Humanoid") then
			for _, track in ipairs(char:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
				track:Stop()
			end
		end
		if currentBtn then currentBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0) end
		currentBtn, currentTrack = nil, nil
		eHUD.Text = "🔹 Status: No emote active"
	end

	local function playEmote(btn, animId)
		stopCurrentEmote()
		local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not hum then return end
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. tostring(animId)
		local track = hum:LoadAnimation(anim)
		track:Play()
		track:AdjustSpeed(currentSpeed)
		currentTrack, currentBtn = track, btn
		btn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
		eHUD.Text = "🎬 Playing: " .. btn.Text
	end

	--== SUBTABS (SCROLLABLE) ==--
	local subTabScroll = Instance.new("ScrollingFrame", EmoteTab)
	subTabScroll.Size = UDim2.new(1, -20, 0, 38)
	subTabScroll.Position = UDim2.new(0, 10, 0, 68)
	subTabScroll.ScrollBarThickness = 4
	subTabScroll.ScrollingDirection = Enum.ScrollingDirection.X
	subTabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
	subTabScroll.BackgroundTransparency = 1

	local subLayout = Instance.new("UIListLayout", subTabScroll)
	subLayout.FillDirection = Enum.FillDirection.Horizontal
	subLayout.Padding = UDim.new(0, 6)
	subLayout.SortOrder = Enum.SortOrder.LayoutOrder

	local catButtons = {}
	for cat, _ in pairs(EMOTES) do
		local b = Instance.new("TextButton", subTabScroll)
		b.Size = UDim2.new(0, 90, 0, 34)
		b.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
		b.TextColor3 = Color3.new(1, 1, 1)
		b.Font = Enum.Font.GothamBlack
		b.TextSize = 14
		b.Text = cat
		newCorner(b, 8)
		catButtons[cat] = b

		b.MouseButton1Click:Connect(function()
			for _, bb in pairs(catButtons) do bb.BackgroundColor3 = Color3.fromRGB(120, 0, 0) end
			b.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
			currentCategory, page = cat, 1
			rebuildEmotes("")
		end)
	end

	subLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		subTabScroll.CanvasSize = UDim2.new(0, subLayout.AbsoluteContentSize.X + 10, 0, 0)
	end)

	--== SCROLL EMOTE LIST ==--
	local eScroll = Instance.new("ScrollingFrame", EmoteTab)
	eScroll.Size = UDim2.new(1, -20, 1, -210)
	eScroll.Position = UDim2.new(0, 10, 0, 108)
	eScroll.ScrollBarThickness = 6
	eScroll.BackgroundTransparency = 1

	local eLayout = Instance.new("UIGridLayout", eScroll)
	eLayout.CellSize = UDim2.new(0.48, 0, 0, 30)
	eLayout.CellPadding = UDim2.new(0, 4, 0, 4)
	eLayout.SortOrder = Enum.SortOrder.LayoutOrder
	eLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		eScroll.CanvasSize = UDim2.new(0, 0, 0, eLayout.AbsoluteContentSize.Y + 10)
	end)




	--== PAGINATION & SEARCH ==--
	local navBar = Instance.new("Frame", EmoteTab)
	navBar.Size = UDim2.new(1, -20, 0, 40)
	navBar.AnchorPoint = Vector2.new(0.5, 1)
	navBar.Position = UDim2.new(0.5, 0, 1, -60)
	navBar.BackgroundTransparency = 1

	local prevBtn = Instance.new("TextButton", navBar)
	prevBtn.Size = UDim2.new(0, 45, 0, 36)
	prevBtn.Position = UDim2.new(0, 0, 0, 5)
	prevBtn.Text = "Prev"
	prevBtn.Font = Enum.Font.GothamBlack
	prevBtn.TextSize = 14
	prevBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
	prevBtn.TextColor3 = Color3.new(1, 1, 1)
	newCorner(prevBtn, 8)

	local eSearch = Instance.new("TextBox", navBar)
	eSearch.Size = UDim2.new(1, -270, 0, 36)
	eSearch.Position = UDim2.new(0, 48, 0, 5)
	eSearch.PlaceholderText = "Search"
	eSearch.Font = Enum.Font.GothamBold
	eSearch.TextSize = 16
	eSearch.Text = "" -- 🧩 fix tulisan 'TextBox' muncul
	eSearch.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
	eSearch.TextColor3 = Color3.fromRGB(255, 255, 255)
	newCorner(eSearch, 8)

	local nextBtn = Instance.new("TextButton", navBar)
	nextBtn.Size = UDim2.new(0, 45, 0, 36)
	nextBtn.Position = UDim2.new(1, -220, 0, 5)
	nextBtn.Text = "Next"
	nextBtn.Font = Enum.Font.GothamBlack
	nextBtn.TextSize = 14
	nextBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
	nextBtn.TextColor3 = Color3.new(1, 1, 1)
	newCorner(nextBtn, 8)

	local pageLabel = Instance.new("TextLabel", navBar)
	pageLabel.Size = UDim2.new(0, 100, 0, 36)
	pageLabel.Position = UDim2.new(1, -70, 0, 5)
	pageLabel.BackgroundTransparency = 1
	pageLabel.Font = Enum.Font.GothamBold
	pageLabel.TextSize = 14
	pageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	pageLabel.Text = "1/1"

----------------------------------------------------------------
-- 🧠 Kirim ke kolom COMMAND (BUKAN chat publik)
----------------------------------------------------------------
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

local function sendChatCommand(cmd)
	task.spawn(function()
		local gui = LocalPlayer:WaitForChild("PlayerGui")
		local commandBox = nil

		for _, v in ipairs(gui:GetDescendants()) do
			if v:IsA("TextBox") and v.PlaceholderText and v.PlaceholderText:lower():find("command") then
				commandBox = v
				break
			end
		end

		if commandBox then
			commandBox:CaptureFocus()
			commandBox.Text = cmd
			task.wait(0.1)
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
			task.wait(0.05)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
			commandBox:ReleaseFocus()
			print("[VALHALLA] ✅ Command executed:", cmd)
		else
			warn("[VALHALLA] ⚠️ Kolom command tidak ditemukan, fallback ke chat publik.")
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local chatEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
			if chatEvent and chatEvent:FindFirstChild("SayMessageRequest") then
				chatEvent.SayMessageRequest:FireServer(cmd, "All")
			end
		end
	end)
end

----------------------------------------------------------------
-- 🕹 Tambahan tombol di TAB EMOTE (sejajar dengan prev|next)
----------------------------------------------------------------
task.defer(function()
	local EmoteTab = tabs and tabs["Emote"]
	if not EmoteTab then
		warn("[VALHALLA] ❌ EmoteTab belum dibuat.")
		return
	end

	-- frame bar tombol bawah
	local footer = Instance.new("Frame", EmoteTab)
	footer.Size = UDim2.new(1, -20, 0, 36)
	footer.Position = UDim2.new(0, 2, 1, -95)
	footer.BackgroundTransparency = 1

	local function makeBtn(x, text, color)
		local b = Instance.new("TextButton", footer)
		b.Size = UDim2.new(0.14, -1, 1, 0)
		b.Position = UDim2.new(x, 0, 0, 0)
		b.BackgroundColor3 = color or Color3.fromRGB(90,0,0)
		b.TextColor3 = Color3.new(1,1,1)
		b.Font = Enum.Font.GothamBold
		b.TextSize = 14
		b.Text = text
		b.BorderSizePixel = 0
		Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
		return b
	end

	local reBtn = makeBtn(0.52, "RE", Color3.fromRGB(100,0,0))
	local size1Btn = makeBtn(0.66, "0.3", Color3.fromRGB(120,0,0))
	local size2Btn = makeBtn(0.80, "1", Color3.fromRGB(140,0,0))

	reBtn.MouseButton1Click:Connect(function()
		sendChatCommand("/re")
	end)

	size1Btn.MouseButton1Click:Connect(function()
		sendChatCommand("/size 0.3")
	end)

	size2Btn.MouseButton1Click:Connect(function()
		sendChatCommand("/size 1")
	end)
end)


	--== FOOTER SPEED ==--
	local controlFrame = Instance.new("Frame", EmoteTab)
	controlFrame.Size = UDim2.new(1, -20, 0, 40)
	controlFrame.AnchorPoint = Vector2.new(0.5, 1)
	controlFrame.Position = UDim2.new(0.5, 0, 1, -10)
	controlFrame.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
	newCorner(controlFrame, 10)

	local function makeBtn(txt, posX, w)
		local b = Instance.new("TextButton", controlFrame)
		b.Size = UDim2.new(0, w, 0, 36)
		b.Position = UDim2.new(0, posX, 0, 2)
		b.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
		b.TextColor3 = Color3.new(1, 1, 1)
		b.Font = Enum.Font.GothamBlack
		b.TextSize = 18
		b.Text = txt
		newCorner(b, 8)
		return b
	end

	local minusBtn = makeBtn("−", 6, 36)
	local speedBox = Instance.new("TextBox", controlFrame)
	speedBox.Size = UDim2.new(0, 46, 0, 36)
	speedBox.Position = UDim2.new(0, 45, 0, 2)
	speedBox.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
	speedBox.Text = tostring(currentSpeed)
	speedBox.Font = Enum.Font.GothamBold
	speedBox.TextSize = 20
	speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	speedBox.TextXAlignment = Enum.TextXAlignment.Center
	newCorner(speedBox, 8)

	local plusBtn = makeBtn("+", 94, 36)
	local resetBtn = makeBtn("🔁 Reset", 132, 90)
	local stopBtn = makeBtn("🛑 STOP", 228, 110)
	stopBtn.AnchorPoint = Vector2.new(1, 0)
	stopBtn.Position = UDim2.new(1, -6, 0, 2)
	stopBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

	--== BUILD FUNCTION (GLOBAL SEARCH) ==--
	function rebuildEmotes(filter)
		for _, c in ipairs(eScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
		filter = (filter or ""):lower()
		filtered = {}

		if filter ~= "" then
			-- 🔍 GLOBAL SEARCH (across all categories)
			for cat, list in pairs(EMOTES) do
				for _, e in ipairs(list) do
					if e.name:lower():find(filter, 1, true) then
						table.insert(filtered, { name = e.name .. " [" .. cat .. "]", id = e.id })
					end
				end
			end
		else
			-- 🔸 Category-only search
			local emotes = EMOTES[currentCategory] or {}
			for _, e in ipairs(emotes) do table.insert(filtered, e) end
		end

		local totalPages = math.max(1, math.ceil(#filtered / perPage))
		page = math.clamp(page, 1, totalPages)
		pageLabel.Text = ("%d/%d"):format(page, totalPages)

		local startIdx = (page - 1) * perPage + 1
		local endIdx = math.min(startIdx + perPage - 1, #filtered)
		for i = startIdx, endIdx do
			local e = filtered[i]
			local b = Instance.new("TextButton", eScroll)
			b.Size = UDim2.new(0.48, 0, 0, 34)
			b.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
			b.Text = e.name
			b.Font = Enum.Font.GothamSemibold
			b.TextSize = 13
			b.TextColor3 = Color3.new(1, 1, 1)
			b.TextWrapped = true
			newCorner(b, 6)
			b.MouseButton1Click:Connect(function()
				if currentBtn == b then stopCurrentEmote() else playEmote(b, e.id) end
			end)
		end
	end

	

	--== CONNECTIONS ==--
	eSearch:GetPropertyChangedSignal("Text"):Connect(function() page = 1 rebuildEmotes(eSearch.Text) end)
	prevBtn.MouseButton1Click:Connect(function() if page > 1 then page -= 1 rebuildEmotes(eSearch.Text) end end)
	nextBtn.MouseButton1Click:Connect(function() if #filtered > page * perPage then page += 1 rebuildEmotes(eSearch.Text) end end)
	minusBtn.MouseButton1Click:Connect(function() currentSpeed = math.max(1, currentSpeed - 1) speedBox.Text = tostring(currentSpeed) if currentTrack then currentTrack:AdjustSpeed(currentSpeed) end end)
	plusBtn.MouseButton1Click:Connect(function() currentSpeed = math.min(10, currentSpeed + 1) speedBox.Text = tostring(currentSpeed) if currentTrack then currentTrack:AdjustSpeed(currentSpeed) end end)
	resetBtn.MouseButton1Click:Connect(function() currentSpeed = 1 speedBox.Text = "1" stopCurrentEmote() end)
	stopBtn.MouseButton1Click:Connect(stopCurrentEmote)

	--== INIT ==--
	rebuildEmotes("")
end


--=========================================
-- 🕵️ VALHALLA V.10 — SPY TAB (FULL + HUD STATUS, CAMERA FIX)
--=========================================
do
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UIS = game:GetService("UserInputService")
	local LocalPlayer = Players.LocalPlayer
	local camera = workspace.CurrentCamera

	----------------------------------------------------------------
	-- STATE (declare once at top)
	----------------------------------------------------------------
	local spyConn = nil
	local spyTarget = nil
	local rotX, rotY, zoom = 15, 180, 10
	local panOffset = Vector3.new(0,0,0)
	local viewMode, spying = "front", false
	local sensitivity, zoomSpeed = 1.2, 0.7
	local gpRot, gpMove = Vector2.new(0,0), Vector2.new(0,0)
	local rightHeld = false
	local DEADZONE = 0.15

	----------------------------------------------------------------
	-- UI HEADER + HUD
	----------------------------------------------------------------
	local spyTitle = Instance.new("TextLabel", SpyTab)
	spyTitle.Size = UDim2.new(1, -20, 0, 28)
	spyTitle.Position = UDim2.new(0, 10, 0, 8)
	spyTitle.BackgroundTransparency = 1
	spyTitle.Font = Enum.Font.GothamBlack
	spyTitle.TextSize = 20
	spyTitle.TextColor3 = Color3.fromRGB(255,255,255)
	spyTitle.TextXAlignment = Enum.TextXAlignment.Left
	spyTitle.Text = "🕵️ Spy Manager"

	local hudTarget = Instance.new("TextLabel", SpyTab)
	hudTarget.Size = UDim2.new(1,-20,0,20)
	hudTarget.Position = UDim2.new(0,10,0,36)
	hudTarget.BackgroundTransparency = 1
	hudTarget.Font = Enum.Font.GothamBold
	hudTarget.TextSize = 14
	hudTarget.TextColor3 = Color3.fromRGB(255,255,180)
	hudTarget.TextXAlignment = Enum.TextXAlignment.Left
	hudTarget.Text = "🎯 Target: None"

	local hudStatus = Instance.new("TextLabel", SpyTab)
	hudStatus.Size = UDim2.new(1,-20,0,20)
	hudStatus.Position = UDim2.new(0,10,0,56)
	hudStatus.BackgroundTransparency = 1
	hudStatus.Font = Enum.Font.GothamBold
	hudStatus.TextSize = 13
	hudStatus.TextColor3 = Color3.fromRGB(180,255,180)
	hudStatus.TextXAlignment = Enum.TextXAlignment.Left
	hudStatus.Text = "📷 View: FRONT | 👥 Players: 0 | 🟢 Friends: 0"

	----------------------------------------------------------------
	-- SEARCH + SUBTABS
	----------------------------------------------------------------
	local searchBox = Instance.new("TextBox", SpyTab)
	searchBox.Size = UDim2.new(1,-24,0,34)
	searchBox.Position = UDim2.new(0,10,0,78)
	searchBox.PlaceholderText = "Search Player…"
	searchBox.Font = Enum.Font.GothamBold
	searchBox.TextSize = 14
	searchBox.Text = ""
	searchBox.TextColor3 = Color3.fromRGB(255,255,255)
	searchBox.BackgroundColor3 = Color3.fromRGB(60,0,0)
	searchBox.ClearTextOnFocus = false
	searchBox.BorderSizePixel = 0
	local cornerSearch = Instance.new("UICorner", searchBox)
	cornerSearch.CornerRadius = UDim.new(0,8)

	local subBar = Instance.new("Frame", SpyTab)
	subBar.Size = UDim2.new(1,-20,0,34)
	subBar.Position = UDim2.new(0,10,0,115)
	subBar.BackgroundTransparency = 1

	local btnOthers = Instance.new("TextButton", subBar)
	btnOthers.Size = UDim2.new(0.49,-6,1,0)
	btnOthers.Text = "👤 OTHERS"
	btnOthers.Font = Enum.Font.GothamBold
	btnOthers.TextSize = 16
	btnOthers.TextColor3 = Color3.fromRGB(255,255,255)
	btnOthers.BackgroundColor3 = Color3.fromRGB(140,0,0)
	btnOthers.BorderSizePixel = 0
	local cornerOthers = Instance.new("UICorner", btnOthers) cornerOthers.CornerRadius = UDim.new(0,8)

	local btnFriends = Instance.new("TextButton", subBar)
	btnFriends.Size = UDim2.new(0.49,-6,1,0)
	btnFriends.Position = UDim2.new(0.51,0,0,0)
	btnFriends.Text = "🟢 FRIENDS"
	btnFriends.Font = Enum.Font.GothamBold
	btnFriends.TextSize = 16
	btnFriends.TextColor3 = Color3.fromRGB(255,255,255)
	btnFriends.BackgroundColor3 = Color3.fromRGB(0,100,0)
	btnFriends.BorderSizePixel = 0
	local cornerFriends = Instance.new("UICorner", btnFriends) cornerFriends.CornerRadius = UDim.new(0,8)

	----------------------------------------------------------------
	-- PLAYER LIST
	----------------------------------------------------------------
	local sScroll = Instance.new("ScrollingFrame", SpyTab)
	sScroll.Size = UDim2.new(1, -20, 1, -230)
	sScroll.Position = UDim2.new(0, 10, 0, 155)
	sScroll.BackgroundTransparency = 1
	sScroll.ScrollBarThickness = 6
	local sLayout = Instance.new("UIGridLayout", sScroll)
	sLayout.CellPadding = UDim2.new(0,10,0,10)
	sLayout.CellSize = UDim2.new(0.48, 0, 0, 80)
	sLayout.SortOrder = Enum.SortOrder.LayoutOrder
	sLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		sScroll.CanvasSize = UDim2.new(0,0,0,sLayout.AbsoluteContentSize.Y + 10)
	end)

	----------------------------------------------------------------
	-- HUD helper
	----------------------------------------------------------------
	local function updateHUD()
		local total = 0
		local friends = 0
		for _,p in ipairs(Players:GetPlayers()) do
			if p ~= LocalPlayer then
				total = total + 1
				local ok,res = pcall(function() return LocalPlayer:IsFriendsWith(p.UserId) end)
				if ok and res then friends = friends + 1 end
			end
		end
		hudStatus.Text = string.format("📷 View: %s | 👥 Players: %d | 🟢 Friends: %d", viewMode:upper(), total, friends)
	end

	----------------------------------------------------------------
	-- CAMERA FUNCTIONS
	----------------------------------------------------------------
	local function resetView()
		rotX, rotY, zoom = 15, 180, 10
		panOffset = Vector3.new(0,0,0)
	end

	local function resetCamera()
		if spyConn then spyConn:Disconnect() spyConn=nil end
		spying = false
		spyTarget = nil
		camera.CameraType = Enum.CameraType.Custom
		local ch = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local hum = ch:FindFirstChildOfClass("Humanoid")
		if hum then camera.CameraSubject = hum end
		UIS.MouseBehavior = Enum.MouseBehavior.Default
		hudTarget.Text = "🎯 Target: None"
		updateHUD()
	end

	UIS.InputBegan:Connect(function(i,gp)
		if gp then return end
		if i.UserInputType == Enum.UserInputType.MouseButton2 then
			rightHeld = true
			UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
		end
	end)
	UIS.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton2 then
			rightHeld = false
			UIS.MouseBehavior = Enum.MouseBehavior.Default
		end
	end)

	UIS.InputChanged:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseWheel and spying then
			local step = math.abs(i.Position.Z)
			local boost = math.clamp(0.6 + step*0.6, 0.6, 3.0)
			if i.Position.Z > 0 then zoom = math.clamp(zoom - zoomSpeed*boost, 5, 25)
			elseif i.Position.Z < 0 then zoom = math.clamp(zoom + zoomSpeed*boost, 5, 25) end
		elseif spying and rightHeld and i.UserInputType == Enum.UserInputType.MouseMovement then
			rotY = (rotY - i.Delta.X * sensitivity * 0.25) % 360
			rotX = math.clamp(rotX - i.Delta.Y * sensitivity * 0.25, -80, 80)
		elseif i.UserInputType == Enum.UserInputType.Gamepad1 then
			if i.KeyCode == Enum.KeyCode.Thumbstick2 then
				local X = math.abs(i.Position.X) > DEADZONE and i.Position.X or 0
				local Y = math.abs(i.Position.Y) > DEADZONE and i.Position.Y or 0
				gpRot = Vector2.new(X,Y)
			elseif i.KeyCode == Enum.KeyCode.Thumbstick1 then
				local X = math.abs(i.Position.X) > DEADZONE and i.Position.X or 0
				local Y = math.abs(i.Position.Y) > DEADZONE and i.Position.Y or 0
				gpMove = Vector2.new(X,Y)
			elseif i.KeyCode == Enum.KeyCode.ButtonR2 then
				if spying then zoom = math.clamp(zoom - zoomSpeed, 5, 25) end
			elseif i.KeyCode == Enum.KeyCode.ButtonL2 then
				if spying then zoom = math.clamp(zoom + zoomSpeed, 5, 25) end
			end
		end
	end)

	local function teleportBehind(p)
		if not (p and p.Character and p.Character:FindFirstChild("HumanoidRootPart")) then return end
		local me = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local root = me:FindFirstChild("HumanoidRootPart")
		if root then
			root.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,8)
		end
	end

	local function startFollow(p)
		if not (p and p.Character and p.Character:FindFirstChild("HumanoidRootPart")) then return end
		spyTarget = p
		_G.spyTarget = p
		spying = true
		camera.CameraType = Enum.CameraType.Scriptable
		hudTarget.Text = "🎯 Target: " .. (p.DisplayName or p.Name or "Unknown")
		updateHUD()
		if spyConn then spyConn:Disconnect() spyConn = nil end
		spyConn = RunService.RenderStepped:Connect(function()
			if not spying or not spyTarget or not spyTarget.Character or not spyTarget.Character:FindFirstChild("HumanoidRootPart") then
				resetCamera()
				return
			end
			local hrp = spyTarget.Character.HumanoidRootPart
			-- gamepad adjustments
			if gpRot.Magnitude > 0 then
				rotY = (rotY - gpRot.X * 3.5) % 360
				rotX = math.clamp(rotX - gpRot.Y * 3.5, -80, 80)
			end
			if gpMove.Magnitude > 0 then
				local moveSpeed = 0.3
				panOffset = panOffset + Vector3.new(-gpMove.X * moveSpeed, gpMove.Y * moveSpeed, 0)
			end
			local rx, ry = math.rad(rotX), math.rad(rotY)
			local dir = Vector3.new(math.cos(ry)*math.cos(rx), math.sin(rx), math.sin(ry)*math.cos(rx))
			if viewMode == "front" then dir = -dir end
			local base = hrp.Position + panOffset
			local camPos = base + dir * zoom + Vector3.new(0, 3, 0)
			local lookAt = base + Vector3.new(0, 2, 0)
			camera.CFrame = CFrame.new(camPos, lookAt)
		end)
	end

	----------------------------------------------------------------
	-- PLAYER LIST BUILDER
	----------------------------------------------------------------
	local isFriendCache = {}
	local function isFriend(p)
		if p == LocalPlayer then return false end
		if isFriendCache[p.UserId] ~= nil then return isFriendCache[p.UserId] end
		local ok, res = pcall(function() return LocalPlayer:IsFriendsWith(p.UserId) end)
		isFriendCache[p.UserId] = ok and res or false
		return isFriendCache[p.UserId]
	end

	local activeTab = "OTHERS"

	local function makeRow(p)
		local row = Instance.new("Frame")
		row.Size = UDim2.new(0,0,0,80)
		row.BackgroundColor3 = isFriend(p) and Color3.fromRGB(30,80,30) or Color3.fromRGB(80,0,0)
		row.BorderSizePixel = 0
		local corner = Instance.new("UICorner", row) corner.CornerRadius = UDim.new(0,8)

		local name = Instance.new("TextLabel", row)
		name.BackgroundTransparency = 1
		name.Size = UDim2.new(1,-20,0,24)
		name.Position = UDim2.new(0,10,0,6)
		name.Text = p.DisplayName
		name.Font = Enum.Font.GothamBold
		name.TextSize = 14
		name.TextColor3 = Color3.fromRGB(255,255,255)
		name.TextXAlignment = Enum.TextXAlignment.Left

		local uname = Instance.new("TextLabel", row)
		uname.BackgroundTransparency = 1
		uname.Size = UDim2.new(1,-20,0,18)
		uname.Position = UDim2.new(0,10,0,28)
		uname.Text = "@" .. p.Name
		uname.Font = Enum.Font.Gotham
		uname.TextSize = 12
		uname.TextColor3 = Color3.fromRGB(200,200,200)
		uname.TextXAlignment = Enum.TextXAlignment.Left

		local spyB = Instance.new("TextButton", row)
		spyB.Size = UDim2.new(0.46,-4,0,20)
		spyB.Position = UDim2.new(0,10,0,52)
		spyB.Text = "SPY"
		spyB.Font = Enum.Font.GothamBlack
		spyB.TextSize = 13
		spyB.TextColor3 = Color3.fromRGB(255,255,255)
		spyB.BackgroundColor3 = Color3.fromRGB(140,0,0)
		local spyCorner = Instance.new("UICorner", spyB) spyCorner.CornerRadius = UDim.new(0,8)
		spyB.MouseButton1Click:Connect(function()
			-- ensure reset then follow (keeps behavior same)
			resetCamera()
			startFollow(p)
		end)

		local tpB = spyB:Clone()
		tpB.Text = "TP"
		tpB.Position = UDim2.new(0.52,0,0,52)
		tpB.BackgroundColor3 = Color3.fromRGB(100,0,0)
		tpB.Parent = row
		tpB.MouseButton1Click:Connect(function() teleportBehind(p) end)

		return row
	end

	local function rebuild()
	-- Bersihkan semua hasil lama (termasuk label “No players found”)
	for _, c in ipairs(sScroll:GetChildren()) do
		if c:IsA("Frame") or c:IsA("TextLabel") then
			c:Destroy()
		end
	end

	local q = (searchBox.Text or ""):lower()
	local totalPlayers = 0

	-- Loop semua player
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			local ok, res = pcall(function()
				return LocalPlayer:IsFriendsWith(p.UserId)
			end)
			local f = ok and res or false
			isFriendCache[p.UserId] = f

			-- Filter tab + search
			if (activeTab == "FRIENDS" and f) or (activeTab == "OTHERS" and not f) then
				local key = (p.DisplayName .. " @" .. p.Name):lower()
				if q == "" or key:find(q, 1, true) then
					makeRow(p).Parent = sScroll
					totalPlayers += 1
				end
			end
		end
	end

	-- Kalau hasil kosong, tampilkan hanya satu label “No players found”
	if totalPlayers == 0 then
		local none = Instance.new("TextLabel")
		none.Size = UDim2.new(1,0,0,40)
		none.BackgroundTransparency = 1
		none.Text = "🚫 No players found in this tab"
		none.Font = Enum.Font.GothamBold
		none.TextSize = 14
		none.TextColor3 = Color3.fromRGB(200,200,200)
		none.Parent = sScroll
	end
end

	----------------------------------------------------------------
	-- BUTTONS & EVENTS
	----------------------------------------------------------------
	btnOthers.MouseButton1Click:Connect(function()
		activeTab = "OTHERS"
		btnOthers.BackgroundColor3 = Color3.fromRGB(180,0,0)
		btnFriends.BackgroundColor3 = Color3.fromRGB(0,100,0)
		rebuild()
	end)
	btnFriends.MouseButton1Click:Connect(function()
		activeTab = "FRIENDS"
		btnFriends.BackgroundColor3 = Color3.fromRGB(0,140,0)
		btnOthers.BackgroundColor3 = Color3.fromRGB(140,0,0)
		rebuild()
	end)

	-- footer (create once, same layout as before)
	local footer = Instance.new("Frame", SpyTab)
	footer.Size = UDim2.new(1,-20,0,30)
	footer.Position = UDim2.new(0,10,1,-35)
	footer.BackgroundTransparency = 1

	local names = {"STOP","CAM","BACK","VIEW","RESETCAM"}
	local colors = {Color3.fromRGB(160,0,0),Color3.fromRGB(120,0,0),Color3.fromRGB(120,0,0),Color3.fromRGB(100,0,0),Color3.fromRGB(80,0,0)}
	local btns = {}
	for i,n in ipairs(names) do
		local b = Instance.new("TextButton", footer)
		b.Size = UDim2.new(0.19,-4,1,0)
		b.Position = UDim2.new((i-1)*0.19+(i-1)*0.012,0,0,0)
		b.Text = n=="RESETCAM" and "♻️RESET" or n
		b.Font = Enum.Font.GothamBlack
		b.TextSize = 14
		b.TextColor3 = Color3.fromRGB(255,255,255)
		b.BackgroundColor3 = colors[i]
		local corner = Instance.new("UICorner", b) corner.CornerRadius = UDim.new(0,8)
		btns[n] = b
	end

	btns.STOP.MouseButton1Click:Connect(function() resetCamera() end)
	btns.CAM.MouseButton1Click:Connect(function()
		if spyTarget then
			resetCamera()
			task.wait(0.05)
			startFollow(spyTarget)
		end
	end)
	btns.BACK.MouseButton1Click:Connect(function()
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
		end
	end)
	btns.VIEW.MouseButton1Click:Connect(function()
		viewMode = (viewMode == "front") and "behind" or "front"
		updateHUD()
	end)
	btns.RESETCAM.MouseButton1Click:Connect(function() resetView() end)

	----------------------------------------------------------------
	-- EVENTS
	----------------------------------------------------------------
	searchBox:GetPropertyChangedSignal("Text"):Connect(rebuild)
	Players.PlayerAdded:Connect(function(p) isFriendCache[p.UserId] = nil rebuild() end)
	Players.PlayerRemoving:Connect(rebuild)

	SpyTab:GetPropertyChangedSignal("Visible"):Connect(function()
		if not SpyTab.Visible then
			resetCamera()
		else
			rebuild()
		end
	end)
	SpyTab.AncestryChanged:Connect(function(_, parent)
		if not parent then resetCamera() end
	end)

	----------------------------------------------------------------
	-- INIT
	----------------------------------------------------------------
	rebuild()
	updateHUD()
end



----------------------------------------------------------------
-- 🚶 FOLLOW SYSTEM (VISIBLE ON SPY TAB)
----------------------------------------------------------------
task.defer(function()
	task.wait(0.1)
	if SpyTab:FindFirstChild("FollowFrame") then
		SpyTab.FollowFrame:Destroy()
	end

	local followFrame = Instance.new("Frame")
	followFrame.Name = "FollowFrame"
	followFrame.Parent = SpyTab
	followFrame.Size = UDim2.new(1, -20, 0, 30)
	followFrame.AnchorPoint = Vector2.new(0, 1)
	followFrame.Position = UDim2.new(0, 10, 1, -40)
	followFrame.BackgroundTransparency = 1
	followFrame.ZIndex = 100

	local function mkBtn(x, text, color)
		local b = Instance.new("TextButton")
		b.Parent = followFrame
		b.Size = UDim2.new(0.155, -4, 1, 0)
		b.Position = UDim2.new(x, 0, 0, 0)
		b.BackgroundColor3 = color or Color3.fromRGB(90, 0, 0)
		b.Font = Enum.Font.GothamBold
		b.TextSize = 14
		b.TextColor3 = Color3.new(1, 1, 1)
		b.Text = text
		b.BorderSizePixel = 0
		b.ZIndex = 101
		Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
		return b
	end

	local btnFollow = mkBtn(0.00, "🚶FLW", Color3.fromRGB(0, 120, 0))
	local btnBack   = mkBtn(0.17, "⬇️", Color3.fromRGB(120, 80, 0))
	local btnLeft   = mkBtn(0.34, "⬅️", Color3.fromRGB(100, 60, 0))
	local btnRight  = mkBtn(0.51, "➡️", Color3.fromRGB(100, 60, 0))
	local btnFront  = mkBtn(0.68, "⬆️", Color3.fromRGB(120, 80, 0))
	local btnStop   = mkBtn(0.85, "⛔", Color3.fromRGB(140, 0, 0))

	local RunService = game:GetService("RunService")
	local followConn

	local function stopFollow()
		if followConn then followConn:Disconnect() followConn = nil end
		btnFollow.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
		btnBack.BackgroundColor3   = Color3.fromRGB(120, 80, 0)
		btnLeft.BackgroundColor3   = Color3.fromRGB(100, 60, 0)
		btnRight.BackgroundColor3  = Color3.fromRGB(100, 60, 0)
		btnFront.BackgroundColor3  = Color3.fromRGB(120, 80, 0)
	end

	local function startFollow(mode)
		stopFollow()
		local target = _G.spyTarget
		if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
			warn("[VALHALLA] Tidak ada target aktif dari SpyTab.")
			return
		end

		local player = game.Players.LocalPlayer
		local myChar = player.Character or player.CharacterAdded:Wait()
		local myHum = myChar:WaitForChild("Humanoid")
		local myHRP = myChar:WaitForChild("HumanoidRootPart")

		followConn = RunService.Heartbeat:Connect(function()
			if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
				stopFollow()
				return
			end
			local tHRP = target.Character.HumanoidRootPart
			if mode == "follow" then
				myHum:MoveTo(tHRP.Position + (tHRP.CFrame.LookVector * -3))
			elseif mode == "back" then
				myHRP.CFrame = tHRP.CFrame * CFrame.new(0, 0, 3)
			elseif mode == "left" then
				myHRP.CFrame = tHRP.CFrame * CFrame.new(-3, 0, 0)
			elseif mode == "right" then
				myHRP.CFrame = tHRP.CFrame * CFrame.new(3, 0, 0)
			elseif mode == "front" then
				myHRP.CFrame = tHRP.CFrame * CFrame.new(0, 0, -3)
			end
		end)
	end

	btnFollow.MouseButton1Click:Connect(function() startFollow("follow") end)
	btnBack.MouseButton1Click:Connect(function() startFollow("back") end)
	btnLeft.MouseButton1Click:Connect(function() startFollow("left") end)
	btnRight.MouseButton1Click:Connect(function() startFollow("right") end)
	btnFront.MouseButton1Click:Connect(function() startFollow("front") end)
	btnStop.MouseButton1Click:Connect(stopFollow)

	SpyTab:GetPropertyChangedSignal("Visible"):Connect(function()
		if not SpyTab.Visible then stopFollow() end
	end)
end)





--=========================================
-- 🧬 VALHALLA V.1 — AVATAR MORPH MANAGER (Fixed HUD + Status Active)
--=========================================
if tabs["Avatar"] then
	pcall(function() tabs["Avatar"]:Destroy() end)
	tabs["Avatar"] = nil
end

local AvatarTab = createContentFrame("Avatar")
tabs["Avatar"] = AvatarTab
CreateTabButton("AVATAR", 3, "Avatar")

local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--=========================================
-- ⚙️ UNIVERSAL COMMAND SENDER
--=========================================
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

function sendChatCommand(msg)
	local gui = LocalPlayer:WaitForChild("PlayerGui")
	local commandBox = nil

	-- cari kolom command (bukan chat publik)
	for _, v in ipairs(gui:GetDescendants()) do
		if v:IsA("TextBox") and v.PlaceholderText and v.PlaceholderText:lower():find("command") then
			commandBox = v
			break
		end
	end

	if not commandBox then
		warn("[VALHALLA] ❌ Kolom command tidak ditemukan. Gagal kirim:", msg)
		return
	end

	-- isi teks ke kolom command
	commandBox:CaptureFocus()
	commandBox.Text = msg
	task.wait(0.1)

	-- tekan ENTER (eksekusi command)
	VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
	task.wait(0.05)
	VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)

	commandBox:ReleaseFocus()
	print("[VALHALLA] ✅ Command executed:", msg)
end

-- 🧩 HUD
local aTitle = Instance.new("TextLabel", AvatarTab)
aTitle.Size = UDim2.new(1, -20, 0, 28)
aTitle.Position = UDim2.new(0, 10, 0, 8)
aTitle.BackgroundTransparency = 1
aTitle.Font = Enum.Font.GothamBlack
aTitle.TextSize = 20
aTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
aTitle.TextXAlignment = Enum.TextXAlignment.Left
aTitle.Text = "🧬 Avatar Manager"

local aHUD = Instance.new("TextLabel", AvatarTab)
aHUD.Size = UDim2.new(1, -20, 0, 22)
aHUD.Position = UDim2.new(0, 10, 0, 38)
aHUD.BackgroundTransparency = 1
aHUD.Font = Enum.Font.GothamBold
aHUD.TextSize = 14
aHUD.TextColor3 = Color3.fromRGB(255, 220, 220)
aHUD.TextXAlignment = Enum.TextXAlignment.Left
aHUD.Text = "🔹 Status: No avatar active"

-- Container utama
local tabContainer = Instance.new("Frame", AvatarTab)
tabContainer.Size = UDim2.new(1, -20, 0, 70)
tabContainer.Position = UDim2.new(0, 10, 0, 70)
tabContainer.BackgroundTransparency = 1

local tabGrid = Instance.new("UIGridLayout", tabContainer)
tabGrid.CellPadding = UDim2.new(0, 6, 0, 6)
tabGrid.CellSize = UDim2.new(0.23, 0, 0, 30)
tabGrid.FillDirectionMaxCells = 4
tabGrid.SortOrder = Enum.SortOrder.LayoutOrder

-- Sub-tab daftar kategori Avatar
local subTabs = {
	{ name = "Anomaly", color = Color3.fromRGB(100, 0, 0) },
	{ name = "Idle", color = Color3.fromRGB(0, 100, 0) },
	{ name = "Walk", color = Color3.fromRGB(0, 0, 120) },
	{ name = "Run", color = Color3.fromRGB(120, 80, 0) },
	{ name = "Jump", color = Color3.fromRGB(90, 0, 90) },
	{ name = "Climb", color = Color3.fromRGB(0, 150, 100) },
	{ name = "Fall", color = Color3.fromRGB(100, 0, 0) },
	{ name = "Swim", color = Color3.fromRGB(0, 100, 0) },
}

local subFrames, activeTab = {}, nil

-- Area konten
local contentContainer = Instance.new("Frame", AvatarTab)
contentContainer.Size = UDim2.new(1, -20, 1, -180)
contentContainer.Position = UDim2.new(0, 10, 0, 150)
contentContainer.BackgroundTransparency = 1

-- Fungsi buat sub tab
local function createSubTab(tab)
	local btn = Instance.new("TextButton")
	btn.Text = tab.name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = tab.color
	btn.AutoButtonColor = true
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	local frame = Instance.new("ScrollingFrame", contentContainer)
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundTransparency = 1
	frame.ScrollBarThickness = 6
	frame.Visible = false
	frame.CanvasSize = UDim2.new(0, 0, 0, 0)

	local grid = Instance.new("UIGridLayout", frame)
	grid.CellPadding = UDim2.new(0, 5, 0, 5)
	grid.CellSize = UDim2.new(1/3, -10, 0, 30)
	grid.SortOrder = Enum.SortOrder.LayoutOrder

	local function updateCanvas()
		task.wait()
		frame.CanvasSize = UDim2.new(0, 0, 0, grid.AbsoluteContentSize.Y + 10)
	end
	grid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)

	btn.MouseButton1Click:Connect(function()
		for _, v in pairs(subFrames) do v.Visible = false end
		for _, b in ipairs(tabContainer:GetChildren()) do
			if b:IsA("TextButton") then
				b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			end
		end
		frame.Visible = true
		btn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
		activeTab = frame
	end)

	btn.Parent = tabContainer
	subFrames[tab.name] = frame
end

for _, tab in ipairs(subTabs) do
	createSubTab(tab)
end

-- Aktifkan tab pertama
if subFrames[subTabs[1].name] then
	subFrames[subTabs[1].name].Visible = true
end

-- 🔹 Avatar Data Example
local avatarData = {
	 	{ name = "Normal Snake", id = 17275810493 },
		{ name = "Red Snake", id = 17275818049 },
		{ name = "Worm", id = 16494904882 },
		{ name = "Croco Suit", id = 13421513307 },
		{ name = "Duck", id = 18280128517 },
		{ name = "Ghost Pink", id = 86241866231576 },
		{ name = "Ghost Purple", id = 91390658858493 },
		{ name = "Ghost Black", id = 101353463102685 },
		{ name = "Ghost White", id = 77188654801887 },
		{ name = "Ghost Green", id = 119333439043361 },
		{ name = "Ghost Red", id = 112700878171252 },
		{ name = "Ghost Yellow", id = 104817124697807 },
}

for _, data in ipairs(avatarData) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
	btn.Text = data.name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextWrapped = true
	btn.Parent = subFrames["Anomaly"]
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	btn.MouseButton1Click:Connect(function()
		aHUD.Text = "🔸 Equipping " .. data.name .. "..."
		sendChatCommand("/hat " .. data.id)
		task.wait(0.6)
		sendChatCommand("/re")
		aHUD.Text = "🧩 Active: " .. data.name
	end)
end


-- 🔹 Avatar Data Idle 
local avatarData = {
		{ name = "Adidas Community", id = 126354114956642 },
		{ name = "Vampire", id = 1113742618 },
		{ name = "Ninja", id = 658832408 },
		{ name = "Zombie", id = 619535834 },
		{ name = "Werewolf", id = 1113752682 },
		{ name = "Levitation", id = 619542203 },
		{ name = "Astronaut", id = 1090133099 },
		{ name = "Knight", id = 734327140 },
		{ name = "Pirate", id = 837024662 },
		{ name = "Superhero", id = 619528125 },
		{ name = "Adidas Sports", id = 18538150608 },
		{ name = "NFL", id = 101094325978637 },
		{ name = "Bubbly", id = 1018553897 },
		{ name = "Catwalk Glam", id = 101279640971758 },
		{ name = "Mage", id = 754637456 },
		{ name = "Elder", id = 892268340 },
		{ name = "Toy", id = 973771666 },
		{ name = "Cartoony", id = 837011741 },
		{ name = "Popular", id = 101839542383818 },
		{ name = "Bold", id = 16744209868 },
		{ name = "No Boundaries", id = 18755930927 },
		{ name = "Oldschool", id = 5319922112 },
		{ name = "Robot", id = 619521748 },
		{ name = "Stylish", id = 619511648 },
		{ name = "Rthro", id = 2510235063 },
}

for _, data in ipairs(avatarData) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
	btn.Text = data.name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextWrapped = true
	btn.Parent = subFrames["Idle"]
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	btn.MouseButton1Click:Connect(function()
		aHUD.Text = "🔸 Equipping " .. data.name .. "..."
		sendChatCommand("/hat " .. data.id)
		task.wait(0.6)
		sendChatCommand("/re")
		aHUD.Text = "🧩 Active: " .. data.name
	end)
end

-- 🔹 Avatar Data Walk 
local avatarData = {
		{ name = "Adidas Community", id = 106810508343012 },
		{ name = "Vampire", id = 1113741192 },
		{ name = "Ninja", id = 658831143 },
		{ name = "Zombie", id = 619537468 },
		{ name = "Werewolf", id = 1113751657 },
		{ name = "Levitation", id = 619544080 },
		{ name = "Astronaut", id = 1090131576 },
		{ name = "Knight", id = 734326330 },
		{ name = "Pirate", id = 837023892 },
		{ name = "Superhero", id = 619529601 },
		{ name = "Adidas Sports", id = 18538146480 },
		{ name = "NFL", id = 120071305586627 },
		{ name = "Bubbly", id = 1018549681 },
		{ name = "Catwalk Glam", id = 103190462987721 },
		{ name = "Mage", id = 754636298 },
		{ name = "Elder", id = 892267099 },
		{ name = "Toy", id = 973767371 },
		{ name = "Cartoony", id = 837010234 },
		{ name = "Popular", id = 133304526526319 },
		{ name = "Bold", id = 16744219182 },
		{ name = "No Boundaries", id = 18755942776 },
		{ name = "Oldschool", id = 5319909330 },
		{ name = "Robot", id = 619522849 },
		{ name = "Stylish", id = 619512767 },
		{ name = "Rthro", id = 2510242378 },
}

for _, data in ipairs(avatarData) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
	btn.Text = data.name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextWrapped = true
	btn.Parent = subFrames["Walk"]
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	btn.MouseButton1Click:Connect(function()
		aHUD.Text = "🔸 Equipping " .. data.name .. "..."
		sendChatCommand("/hat " .. data.id)
		task.wait(0.6)
		sendChatCommand("/re")
		aHUD.Text = "🧩 Active: " .. data.name
	end)
end

-- 🔹 Avatar Data Run 
local avatarData = {
		{ name = "Adidas Community", id = 124765145869332 },
		{ name = "Vampire", id = 1113740510 },
		{ name = "Ninja", id = 658830056 },
		{ name = "Zombie", id = 619536621 },
		{ name = "Werewolf", id = 1113750642 },
		{ name = "Levitation", id = 619543231 },
		{ name = "Astronaut", id = 1090130630 },
		{ name = "Knight", id = 734325948 },
		{ name = "Pirate", id = 837023444 },
		{ name = "Superhero", id = 619528716 },
		{ name = "Adidas Sports", id = 18538133604 },
		{ name = "NFL", id = 84823630062362 },
		{ name = "Bubbly", id = 1018548665 },
		{ name = "Catwalk Glam", id = 75036746190467 },
		{ name = "Mage", id = 754635032 },
		{ name = "Elder", id = 892265784 },
		{ name = "Toy", id = 973766674 },
		{ name = "Cartoony", id = 837009922 },
		{ name = "Popular", id = 136276875045281 },
		{ name = "Bold", id = 16744214662 },
		{ name = "No Boundaries", id = 18755933883 },
		{ name = "Oldschool", id = 5319900634 },
		{ name = "Robot", id = 619522386 },
		{ name = "Stylish", id = 619512153 },
		{ name = "Rthro", id = 2510238627 },
}

for _, data in ipairs(avatarData) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
	btn.Text = data.name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextWrapped = true
	btn.Parent = subFrames["Run"]
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	btn.MouseButton1Click:Connect(function()
		aHUD.Text = "🔸 Equipping " .. data.name .. "..."
		sendChatCommand("/hat " .. data.id)
		task.wait(0.6)
		sendChatCommand("/re")
		aHUD.Text = "🧩 Active: " .. data.name
	end)
end

-- 🔹 Avatar Data Jump 
local avatarData = {
		{ name = "Adidas Community", id = 115715495289805 },
		{ name = "Vampire", id = 1113742359 },
		{ name = "Ninja", id = 658832070 },
		{ name = "Zombie", id = 619536283 },
		{ name = "Werewolf", id = 1113752285 },
		{ name = "Levitation", id = 619542888 },
		{ name = "Astronaut", id = 1090132507 },
		{ name = "Knight", id = 734326930 },
		{ name = "Pirate", id = 837024350 },
		{ name = "Superhero", id = 619528412 },
		{ name = "Adidas Sports", id = 18538153691 },
		{ name = "NFL", id = 140600227095432 },
		{ name = "Bubbly", id = 1018553240 },
		{ name = "Catwalk Glam", id = 138641066989023 },
		{ name = "Mage", id = 754637084 },
		{ name = "Elder", id = 892267917 },
		{ name = "Toy", id = 973770652 },
		{ name = "Cartoony", id = 837011171 },
		{ name = "Popular", id = 130373407996664 },
		{ name = "Bold", id = 16744212581 },
		{ name = "No Boundaries", id = 18755925411 },
		{ name = "Oldschool", id = 5319917561 },
		{ name = "Robot", id = 619522088 },
		{ name = "Stylish", id = 619511974 },
		{ name = "Rthro", id = 2510236649 },
}

for _, data in ipairs(avatarData) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
	btn.Text = data.name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextWrapped = true
	btn.Parent = subFrames["Jump"]
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	btn.MouseButton1Click:Connect(function()
		aHUD.Text = "🔸 Equipping " .. data.name .. "..."
		sendChatCommand("/hat " .. data.id)
		task.wait(0.6)
		sendChatCommand("/re")
		aHUD.Text = "🧩 Active: " .. data.name
	end)
end

-- 🔹 Avatar Data Climb
local avatarData = {
		{ name = "Adidas Community", id = 123695349157584 },
		{ name = "Vampire", id = 1113743239 },
		{ name = "Ninja", id = 658833139 },
		{ name = "Zombie", id = 619535091 },
		{ name = "Werewolf", id = 1113754738 },
		{ name = "Levitation", id = 619541458 },
		{ name = "Astronaut", id = 1090134016 },
		{ name = "Knight", id = 734329002 },
		{ name = "Pirate", id = 837025325 },
		{ name = "Superhero", id = 619527470 },
		{ name = "Adidas Sports", id = 18538170170 },
		{ name = "NFL", id = 122757794615785 },
		{ name = "Bubbly", id = 1018554668 },
		{ name = "Catwalk Glam", id = 104741822987331 },
		{ name = "Mage", id = 754639239 },
		{ name = "Elder", id = 892269341 },
		{ name = "Toy", id = 973773170 },
		{ name = "Cartoony", id = 837013990 },
		{ name = "Popular", id = 135810009801094 },
		{ name = "Bold", id = 16744204409 },
		{ name = "No Boundaries", id = 18755919175 },
		{ name = "Oldschool", id = 5319931619 },
		{ name = "Robot", id = 619521311 },
		{ name = "Stylish", id = 619509955 },
		{ name = "Rthro", id = 2510230574 },
}

for _, data in ipairs(avatarData) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
	btn.Text = data.name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextWrapped = true
	btn.Parent = subFrames["Climb"]
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	btn.MouseButton1Click:Connect(function()
		aHUD.Text = "🔸 Equipping " .. data.name .. "..."
		sendChatCommand("/hat " .. data.id)
		task.wait(0.6)
		sendChatCommand("/re")
		aHUD.Text = "🧩 Active: " .. data.name
	end)
end

-- 🔹 Avatar Data Fall
local avatarData = {
		{ name = "Adidas Community", id = 93993406355955 },
		{ name = "Vampire", id = 1113742092 },
		{ name = "Ninja", id = 658831500 },
		{ name = "Zombie", id = 619535616 },
		{ name = "Werewolf", id = 1113751889 },
		{ name = "Levitation", id = 619541867 },
		{ name = "Astronaut", id = 1090132063 },
		{ name = "Knight", id = 734326679 },
		{ name = "Pirate", id = 837024147 },
		{ name = "Superhero", id = 619527817 },
		{ name = "Adidas Sports", id = 18538164337 },
		{ name = "NFL", id = 123307994439772 },
		{ name = "Bubbly", id = 1018552770 },
		{ name = "Catwalk Glam", id = 72706690305027 },
		{ name = "Mage", id = 754636589 },
		{ name = "Elder", id = 892267521 },
		{ name = "Toy", id = 973768058 },
		{ name = "Cartoony", id = 837010685 },
		{ name = "Popular", id = 83937116921114 },
		{ name = "Bold", id = 16744207822 },
		{ name = "No Boundaries", id = 18755922352 },
		{ name = "Oldschool", id = 5319914476 },
		{ name = "Robot", id = 619521521 },
		{ name = "Stylish", id = 619511417 },
		{ name = "Rthro", id = 2510233257 },
}

for _, data in ipairs(avatarData) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
	btn.Text = data.name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextWrapped = true
	btn.Parent = subFrames["Fall"]
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	btn.MouseButton1Click:Connect(function()
		aHUD.Text = "🔸 Equipping " .. data.name .. "..."
		sendChatCommand("/hat " .. data.id)
		task.wait(0.6)
		sendChatCommand("/re")
		aHUD.Text = "🧩 Active: " .. data.name
	end)
end


-- 🔹 Avatar Data Fall
local avatarData = {
		{ name = "Adidas Community", id = 106537993816942 },
		{ name = "Vampire", id = 1113742944 },
		{ name = "Ninja", id = 658832807 },
		{ name = "Zombie", id = 619537096 },
		{ name = "Werewolf", id = 1113752975 },
		{ name = "Levitation", id = 619543721 },
		{ name = "Astronaut", id = 1090133583 },
		{ name = "Knight", id = 734327363 },
		{ name = "Superhero", id = 619529095 },
		{ name = "Adidas Sports", id = 18538158932 },
		{ name = "NFL", id = 136750772888868 },
		{ name = "Bubbly", id = 1018554245 },
		{ name = "Catwalk Glam", id = 112231179705221 },
		{ name = "Mage", id = 754638471 },
		{ name = "Elder", id = 892268710 },
		{ name = "Toy", id = 973772659 },
		{ name = "Cartoony", id = 837012509 },
		{ name = "Popular", id = 128475661806875 },
		{ name = "Bold", id = 16744217055 },
		{ name = "No Boundaries", id = 18755938274 },
		{ name = "Oldschool", id = 5319927054 },
		{ name = "Robot", id = 619522642 },
		{ name = "Stylish", id = 619512450 },
		{ name = "Rthro", id = 2510240941 },
}

for _, data in ipairs(avatarData) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
	btn.Text = data.name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextWrapped = true
	btn.Parent = subFrames["Swim"]
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	btn.MouseButton1Click:Connect(function()
		aHUD.Text = "🔸 Equipping " .. data.name .. "..."
		sendChatCommand("/hat " .. data.id)
		task.wait(0.6)
		sendChatCommand("/re")
		aHUD.Text = "🧩 Active: " .. data.name
	end)
end

-- 🔁 Refresh Button
local refreshBtn = Instance.new("TextButton", AvatarTab)
refreshBtn.Size = UDim2.new(1, -20, 0, 40)
refreshBtn.AnchorPoint = Vector2.new(0.5, 1)
refreshBtn.Position = UDim2.new(0.5, 0, 1, -10)
refreshBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
refreshBtn.Text = "🔄 REFRESH"
refreshBtn.Font = Enum.Font.GothamBlack
refreshBtn.TextSize = 18
refreshBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", refreshBtn).CornerRadius = UDim.new(0, 10)

refreshBtn.MouseButton1Click:Connect(function()
	aHUD.Text = "🔹 Status: No avatar active"
	sendChatCommand("/re")
end)



--=====================================
-- 👕 Valhalla V.1 — Tab CLOTHS (Full Version Final - Command Mode Fix)
--=====================================

if tabs["Cloths"] then
	pcall(function() tabs["Cloths"]:Destroy() end)
	tabs["Cloths"] = nil
end

local ClothsTab = createContentFrame("Cloths")
tabs["Cloths"] = ClothsTab
CreateTabButton("CLOTHS", 4, "Cloths")

--=====================================
-- 🧩 Services
--=====================================
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

--=====================================
-- 🧠 Function kirim ke kolom COMMAND (BUKAN chat publik)
--=====================================
local function sendChat(cmd)
	task.spawn(function()
		local gui = LocalPlayer:WaitForChild("PlayerGui")
		local commandBox = nil

		-- cari textbox command bawaan panel VIP
		for _, v in ipairs(gui:GetDescendants()) do
			if v:IsA("TextBox") and v.PlaceholderText and v.PlaceholderText:lower():find("command") then
				commandBox = v
				break
			end
		end

		if commandBox then
			-- kirim ke kolom command
			commandBox:CaptureFocus()
			commandBox.Text = cmd
			task.wait(0.1)
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
			task.wait(0.05)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
			commandBox:ReleaseFocus()
			print("[VALHALLA] ✅ Command executed:", cmd)
		else
			-- fallback (kalau kolom command gak ditemukan)
			warn("[VALHALLA] ⚠️ Kolom command tidak ditemukan, fallback ke chat publik.")
			local ReplicatedStorage = game:GetService("ReplicatedStorage")
			local chatEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
			if chatEvent and chatEvent:FindFirstChild("SayMessageRequest") then
				chatEvent.SayMessageRequest:FireServer(cmd, "All")
			end
		end
	end)
end

--=====================================
-- 🏷 Title & HUD
--=====================================
local title = Instance.new("TextLabel", ClothsTab)
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "👕 Cloth Presets — Outfit Manager"

local hud = Instance.new("TextLabel", ClothsTab)
hud.Size = UDim2.new(1, -20, 0, 22)
hud.Position = UDim2.new(0, 10, 0, 42)
hud.BackgroundTransparency = 1
hud.Font = Enum.Font.GothamBold
hud.TextSize = 14
hud.TextColor3 = Color3.fromRGB(255, 200, 200)
hud.TextXAlignment = Enum.TextXAlignment.Left
hud.Text = "🔹 Aktif : Tidak ada preset"

local activeNames, activeButtons = {}, {}

local function updateHUD()
	local display = {}
	for cat, name in pairs(activeNames) do
		if name then table.insert(display, string.format("%s (%s)", name, cat)) end
	end
	hud.Text = (#display == 0) and "🔹 Aktif : Tidak ada preset"
		or "🔸 Aktif : " .. table.concat(display, " | ")
end

--=====================================
-- 🔹 Horizontal SubTabs (Scroll)
--=====================================
local subTabs = {"Body","Legs","Valhalla","Accessories","Outfitkuwh","Ayunan","Anomaly"}
local subTabButtons, subTabFrames = {}, {}

local subTabScroll = Instance.new("ScrollingFrame", ClothsTab)
subTabScroll.Size = UDim2.new(1, -20, 0, 36)
subTabScroll.Position = UDim2.new(0, 10, 0, 70)
subTabScroll.BackgroundTransparency = 1
subTabScroll.ScrollBarThickness = 4
subTabScroll.ScrollingDirection = Enum.ScrollingDirection.X
subTabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local subLayout = Instance.new("UIListLayout", subTabScroll)
subLayout.Padding = UDim.new(0, 8)
subLayout.FillDirection = Enum.FillDirection.Horizontal
subLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
subLayout.SortOrder = Enum.SortOrder.LayoutOrder

for _, name in ipairs(subTabs) do
	local btn = Instance.new("TextButton")
	btn.Name = name
	btn.Size = UDim2.new(0, 80, 1, 0)
	btn.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.Text = name
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = true
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	btn.Parent = subTabScroll
	subTabButtons[name] = btn
end

subLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	subTabScroll.CanvasSize = UDim2.new(0, subLayout.AbsoluteContentSize.X + 10, 0, 0)
end)

--=====================================
-- 🔹 Container Isi Preset
--=====================================
local contentContainer = Instance.new("Frame", ClothsTab)
contentContainer.Size = UDim2.new(1, -20, 1, -180)
contentContainer.Position = UDim2.new(0, 10, 0, 120)
contentContainer.BackgroundTransparency = 1

local function createScroll()
	local scroll = Instance.new("ScrollingFrame")
	scroll.Size = UDim2.new(1, 0, 1, 0)
	scroll.BackgroundTransparency = 1
	scroll.ScrollBarThickness = 6
	local grid = Instance.new("UIGridLayout", scroll)
	grid.CellSize = UDim2.new(0.32, -6, 0, 34)
	grid.CellPadding = UDim2.new(0, 6, 0, 6)
	return scroll
end

for _, name in ipairs(subTabs) do
	local scroll = createScroll()
	scroll.Visible = false
	scroll.Parent = contentContainer
	subTabFrames[name] = scroll
end

subTabFrames["Body"].Visible = true
subTabButtons["Body"].BackgroundColor3 = Color3.fromRGB(255, 40, 40)

--=====================================
-- 🔹 Preset Data
--=====================================
local presets = {
	Body = {
		{name="BB V1",ids={{"76928754971570","114025246656510","76780277149069"}}},
		{name="BB V2",ids={{"110886062252365","76676593438086","136389959521690"}}},
		{name="BB V3",ids={{"93493814873698","4416788553","4416785861"}}},
		{name="Boy 2D",ids={{"113838699792971","93083358795770","137471119999383"}}},
		{name="Boy 3D",ids={{"123916977258376","116229930426772","121397669380873"}}},
		{name="Cool Guy",ids={{"18367787821","18367787996","18367787773"}}},
		{name="Luna",ids={{"83989331071060","94970582207749","118085178646067"}}},
		{name="Timah",ids={{"138042576336488","107542824211022","116532227548481"}}}
	},
	Legs = {
		{name="Great Bear",ids={{"2517207746","2517204456"}}},
		{name="Santa",ids={{"92565592431265","103224430842613"}}},
		{name="Boy 2D",ids={{"136437237416895","73047581528141"}}},
		{name="Boy 3D",ids={{"88350987349692","133448348952148"}}},
		{name="Cool Guy",ids={{"18367788000","18367787739"}}},
		{name="Luna",ids={{"128497183772211","70628248499632"}}},
		{name="Timah",ids={{"120945587967533","136539161708514"}}}
	},
	Valhalla = {
		{name="Merah",color=Color3.fromRGB(180,0,0),ids={{"108074955502367","115544288624517"}}},
		{name="Jacket Merah",color=Color3.fromRGB(180,0,0),ids={{"108074955502367"}}},
		
		{name="Pink",color=Color3.fromRGB(255,105,180),ids={{"125560548136472","115544288624517"}}},
		{name="Jacket Pink",color=Color3.fromRGB(255,105,180),ids={{"125560548136472"}}},

		{name="Ungu",color=Color3.fromRGB(160,90,255),ids={{"76424834498538","103853253227253"}}},
		{name="Jacket Ungu",color=Color3.fromRGB(160,90,255),ids={{"76424834498538"}}},

		{name="Abu",color=Color3.fromRGB(180,180,180),ids={{"106300828506288","103853253227253"}}},
		{name="Jacket Abu",color=Color3.fromRGB(180,180,180),ids={{"106300828506288"}}},

		{name="YB JAKET",color=Color3.fromRGB(180,0,0),ids={{"118345678876119"}}},
		{name="JAKET KANG",color=Color3.fromRGB(180,0,0),ids={{"98314531889797","114286546821470"}}}, 
		{name="Kode Titan",color=Color3.fromRGB(255,0,0),ids={{"12532279099","97574673543860"}}}
		
	},
	Accessories = {
		{name="Peacock1",ids={{"11815008142","12979975215","137471119999383"}}},
		{name="Peacock2",ids={{"439944088","15919021516"}}},
		{name="Delinquent-Demon",color=Color3.fromRGB(200,30,30),ids={{"14228725502"}}},
		{name="Tanduk Api",color=Color3.fromRGB(200,30,30),ids={{"215718515"}}},
		{name="korek api itam",color=Color3.fromRGB(200,30,30),ids={{"93520131138422"}}},
		{name="Animated HP Bar",color=Color3.fromRGB(200,30,30),ids={{"18257712999"}}},
		{name="Tag Gamer",color=Color3.fromRGB(200,30,30),ids={{"15696992211"}}},
		{name="BW Halo Horns",color=Color3.fromRGB(200,30,30),ids={{"6773806697"}}},
		{name="Animated-HP-Bar",color=Color3.fromRGB(200,30,30),ids={{"18257712999"}}},
		{name="8-Bit Royal Crown",color=Color3.fromRGB(200,30,30),ids={{"10159600649"}}},
		{name="(⌛) 8-Bit Less Life",color=Color3.fromRGB(200,30,30),ids={{"127950742287431"}}},
		{name="Hovering UFO",color=Color3.fromRGB(200,30,30),ids={{"8151404994"}}}
	},

	Ayunan = {
		{name="Ayunan A1",ids={{"80333737114314","79942954401351"}}},
		{name="Ayunan A2",ids={{"80333737114314","81695862449510"}}},
		{name="Ayunan A3",ids={{"80333737114314","120120030668286"}}},
		{name="Ayunan A4",ids={{"80333737114314","118972097958753"}}},
		{name="Ayunan A5",ids={{"80333737114314","108526071170858"}}},
		{name="Ayunan A6",ids={{"80333737114314","79362324089052"}}},
		{name="Ayunan A7",ids={{"80333737114314","139900628852698"}}},
		
		{name="Ayunan B1",ids={{"114991735194832","79942954401351"}}},
		{name="Ayunan B2",ids={{"114991735194832","81695862449510"}}},
		{name="Ayunan B3",ids={{"114991735194832","120120030668286"}}},
		{name="Ayunan B4",ids={{"114991735194832","118972097958753"}}},
		{name="Ayunan B5",ids={{"114991735194832","108526071170858"}}},
		{name="Ayunan B6",ids={{"114991735194832","79362324089052"}}},
		{name="Ayunan B7",ids={{"114991735194832","139900628852698"}}}
		
	},

	Anomaly = {
		{name="Megawati 1",ids={{"84823357110908","77706523937549","76812080457475"}}},
		{name="Megawati 2",ids={{"8044843668","8044852814"}}},
		{name="Ganjar 1",ids={{"87318990918153","77706523937549","88017772149651"}}},
		{name="Ganjar 2",ids={{"8044843668","8044852814"}}},
		{name="Cool Guy",ids={{"18367788000","18367787739"}}},
		{name="Luna",ids={{"128497183772211","70628248499632"}}},
		{name="Timah",ids={{"120945587967533","136539161708514"}}}
	},

	Outfitkuwh = {
		{name="Outfit 1",ids={{"109568464536337","99351090489289"}}},
		
		{name="Outfit 2",ids={{"123434099612522","12868189114"}}},
		{name="Outfit 3",ids={{"105930045846517","17892919806"}}},
		{name="Arcane",ids={{"16614299581","14898537300","14898537292","131631106410698"}}},
		{name="Palkon1",ids={{"16614299581","14898537300","14898537292","131631106410698"}}},		
		{name="Palkon2",ids={{"137240541854760","128799109830440","14987495311"}}},
		{name="Ayunan",ids={{"114991735194832","79942954401351"}}},

		{name="Spartan Helmet",color=Color3.fromRGB(255,180,0),ids={{"9182736455"}}},
	}
}

--=====================================
-- 🔹 Tombol Preset (pakai sendChatCommand)
--=====================================
local function makePresetButton(tabName, preset)
	local b = Instance.new("TextButton")
	b.BackgroundColor3 = preset.color or Color3.fromRGB(90, 0, 0)
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 13
	b.TextWrapped = true
	b.Text = preset.name
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

	b.MouseButton1Click:Connect(function()
		for _,batch in ipairs(preset.ids) do
			sendChat("/hat " .. table.concat(batch," "))
			task.wait(0.25)
		end
		if activeButtons[tabName] and activeButtons[tabName] ~= b then
			activeButtons[tabName].BackgroundColor3 = preset.color or Color3.fromRGB(90, 0, 0)
		end
		b.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
		activeButtons[tabName] = b
		activeNames[tabName] = preset.name
		updateHUD()
	end)

	return b
end

for tabName, list in pairs(presets) do
	for _, preset in ipairs(list) do
		makePresetButton(tabName, preset).Parent = subTabFrames[tabName]
	end
end

--=====================================
-- 🔹 Switch antar SubTab
--=====================================
for name, btn in pairs(subTabButtons) do
	btn.MouseButton1Click:Connect(function()
		for _, b in pairs(subTabButtons) do
			b.BackgroundColor3 = Color3.fromRGB(90, 0, 0)
		end
		btn.BackgroundColor3 = Color3.fromRGB(255, 40, 40)
		for _, f in pairs(subTabFrames) do
			f.Visible = false
		end
		subTabFrames[name].Visible = true
	end)
end

--=====================================
-- 🔹 Tombol bawah
--=====================================
local bottomFrame = Instance.new("Frame", ClothsTab)
bottomFrame.Size = UDim2.new(1, -20, 0, 34)
bottomFrame.Position = UDim2.new(0, 10, 1, -36)
bottomFrame.BackgroundTransparency = 1

local function makeCtrlButton(txt)
	local b = Instance.new("TextButton", bottomFrame)
	b.Size = UDim2.new(0.24, -4, 1, 0)
	b.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 15
	b.Text = txt
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
	return b
end

local refreshBtn = makeCtrlButton("🔄 Refresh")
refreshBtn.Position = UDim2.new(0.0, 0,0,0)
local resetBtn = makeCtrlButton("♻️ Reset")
resetBtn.Position = UDim2.new(0.25, 0,0, 0)
local saveBtn = makeCtrlButton("💾 Save")
saveBtn.Position = UDim2.new(0.75, 0, 0, 0)
local applyBtn = makeCtrlButton("⚡ Apply")
applyBtn.Position = UDim2.new(0.1, 0,0, 0)

refreshBtn.MouseButton1Click:Connect(function() sendChat("/re") end)
resetBtn.MouseButton1Click:Connect(function()
	sendChat("/re")
	for _, btn in pairs(activeButtons) do
		if btn then btn.BackgroundColor3 = Color3.fromRGB(90, 0, 0) end
	end
	activeButtons, activeNames = {}, {}
	updateHUD()
end)
saveBtn.MouseButton1Click:Connect(function()
	print("[CLOTHS] Save preset feature placeholder.")
end)
applyBtn.MouseButton1Click:Connect(function()
	print("[CLOTHS] Apply preset feature placeholder.")
end)






--=====================================
-- 💪 VALHALLA V.2.8-F — TAB TITAN (GLOBAL SEARCH + SUBTAB FILTER + PAGINATION FIX)
--=====================================

if tabs["Titan"] then
	pcall(function() tabs["Titan"]:Destroy() end)
	tabs["Titan"] = nil
end

local TitanTab = createContentFrame("Titan")
tabs["Titan"] = TitanTab
CreateTabButton("TITAN", 6, "Titan")

-- ⚙️ Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

-- Send chat command
local function sendChat(cmd)
	task.defer(function()
		if TextChatService.ChatInputBarConfiguration then
			local ok = pcall(function()
				TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(cmd)
			end)
			if ok then return end
		end
		local ev = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
		if ev and ev:FindFirstChild("SayMessageRequest") then
			ev.SayMessageRequest:FireServer(cmd, "All")
		end
	end)
end

--=====================================
-- HEADER
--=====================================
local title = Instance.new("TextLabel", TitanTab)
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "💪 Titan  & Items"

local hud = Instance.new("TextLabel", TitanTab)
hud.Size = UDim2.new(1, -20, 0, 40)
hud.Position = UDim2.new(0, 10, 0, 42)
hud.BackgroundTransparency = 0.4
hud.BackgroundColor3 = Color3.fromRGB(40,0,0)
hud.Font = Enum.Font.GothamBold
hud.TextSize = 14
hud.TextColor3 = Color3.fromRGB(255,220,220)
hud.TextWrapped = true
hud.TextXAlignment = Enum.TextXAlignment.Left
hud.TextYAlignment = Enum.TextYAlignment.Top
hud.Text = "🔹 Aktif : Tidak ada mode"

local function updateHUD(activeList)
	if #activeList == 0 then
		hud.Text = "🔹 Aktif : Tidak ada mode"
	else
		hud.Text = "🔸 Aktif : " .. table.concat(activeList, " | ")
	end
end

--=====================================
-- SUBTABS
--=====================================
local subTabs = {"Aksesories","Anomaly","Titan","Bocil","Celana","Hair","Jacket","Kaos","Sweater","Tanktop","AURA","BAHAN","Pet","Ayunan"}
local presets, subTabButtons = {}, {}
local activeButtons = {}
local MAX_ACTIVE = 10

-- Add preset helper
local function addPreset(tabName, name, cmds, color)
	if not presets[tabName] then presets[tabName] = {} end
	table.insert(presets[tabName], {name = name, cmd = cmds, color = color})
end


-- 🧩 SAMPLE DATA (kamu bisa tambah ratusan via addPreset)
        addPreset("Titan","size 0.4",{"/size 0.4"})
        addPreset("Titan","size 0.5",{"/size 0.5"})
		addPreset("Titan","size 0.6",{"/size 0.6"})
		addPreset("Titan","size 0.7",{"/size 0.7"})
		addPreset("Titan","size 0.8",{"/size 0.8"})
		addPreset("Titan","size 1",{"/size 1"})
		
		--VNR
		addPreset("Titan","Keyllachann",{"/sync Keyllachann"})
		addPreset("Titan","NONA",{"/sync Marescha99"})
		addPreset("Titan","Soxn90",{"/sync Soxn90"})
		addPreset("Titan","whooiscrab",{"/sync whooiscrab"})
		--VHL
		addPreset("Titan","Atomic",{"/sync callmeenaatt"})
		addPreset("Titan","Picasso",{"/sync Vermillion1006"})
		addPreset("Titan","LD Pinka",{"/sync Stenly_225"})
		addPreset("Titan","Silkimella",{"/sync Silkymellaa"})
		addPreset("Titan","FangFang",{"/sync kimmychan201"})
		addPreset("Titan","JENNY",{"/sync Lisa_099076"})
		addPreset("Titan","Rz",{"/sync NICHOLAS_HAMSTER"})
		addPreset("Titan","CAPY",{"/sync Capybaraaa9111"})
		addPreset("Titan","CICY",{"/sync OiMilkyyy"})
		addPreset("Titan","NYUN",{"/sync NYUN2901"})
		
		
		--EFFECT AURA
		addPreset("AURA","1001",{"/fire 1001"},Color3.fromRGB(248,248,248))
		addPreset("AURA","1002",{"/fire 1002"},Color3.fromRGB(205,205,205))
		addPreset("AURA","1003",{"/fire 1003"},Color3.fromRGB(17,17,17))
		addPreset("AURA","1004",{"/fire 1004"},Color3.fromRGB(255,0,0))
		addPreset("AURA","1005",{"/fire 1005"},Color3.fromRGB(255,176,0))
		addPreset("AURA","1006",{"/fire 1006"},Color3.fromRGB(180,128,255))
		

		addPreset("Titan","peackock",{"/hat 11815008142 12979975215"})
        addPreset("Titan","peackock",{"/hat 439944088 15919021516"})
		addPreset("BAHAN","Titan Tower",{"/hat 12532279099"})
        addPreset("BAHAN","Yhwach",{"/hat 84943496769346"})
		addPreset("BAHAN","Okarun",{"/hat 74933750870102"})
		addPreset("BAHAN","Okarun",{"/hat 81147001944687"})
		addPreset("BAHAN","Jubah Pelangi",{"/hat 15144985588"})
		addPreset("BAHAN","Jubah-Anime",{"/hat 14458492932"})
		addPreset("BAHAN","Jubah-Cultist",{"/hat 12079062364"})

		addPreset("BAHAN","GB Hitam",{"/hat 10224641560"})
		addPreset("BAHAN","GB Merah",{"/hat 10224627425"})
		addPreset("BAHAN","GB Ungu",{"/hat 10224597781"})
		addPreset("BAHAN","GB Hijau",{"/hat 10774269482"})
		addPreset("BAHAN","GB Pelangi",{"/hat 10224534386"})
		
		addPreset("BAHAN","Aura Petir Hijau",{"/hat 13371517757"})
		addPreset("BAHAN","Aura Petir Merah",{"/hat 12679318568"})
		addPreset("BAHAN","Aura Petir Ungu",{"/hat 13371507107"})
		addPreset("BAHAN","Aura Petir Biru",{"/hat 12679262353"})
		addPreset("BAHAN","Aura Petir kuning",{"/hat 12679349747"})
		addPreset("BAHAN","Aura Petir Pelangi",{"/hat 12679420163"})
				
		addPreset("BAHAN","Aura Bayangan Ungu",{"/hat 10078055236"})
		addPreset("BAHAN","Aura Petir Hitam",{"/hat 10077993672"})
		addPreset("BAHAN","Aura Petir Merah",{"/hat 10078292331"})
		addPreset("BAHAN","Aura Petir Shadow",{"/hat 10078194348"})
		addPreset("BAHAN","Aura Petir Emas",{"/hat 10389940867"})
		addPreset("BAHAN","Aura Petir Biri",{"/hat 10078236381"})
		addPreset("BAHAN","Aura Petir Pink",{"/hat 10389975725"})

		addPreset("BAHAN","PINK Head",{"/hat 16283342232"})
		addPreset("BAHAN","Biru Head",{"/hat 16283333821"})
		addPreset("BAHAN","ORANGE Head",{"/hat 16282052294"})
		addPreset("BAHAN","PUTIH Head",{"/hat 16283343519"})
		addPreset("BAHAN","MERAH Head",{"/hat 16282018584"})

		addPreset("BAHAN","Tentakel Hitam",{"/hat 15157873361"})
		addPreset("BAHAN","Tentakel Merah",{"/hat 15157890484"})	
		addPreset("BAHAN","Tentakel Putih",{"/hat 15157884997"})

		addPreset("BAHAN","Scythes Hijau",{"/hat 16586266102"})
		addPreset("BAHAN","Scythes Perak",{"/hat 16586145940"})
		addPreset("BAHAN","Scythes Gold",{"/hat 16586154430"})
		addPreset("BAHAN","Scythes Perak 2",{"/hat 16586162053"})
		addPreset("BAHAN","Scythes Biru",{"/hat 16586403480"})
		addPreset("BAHAN","Scythes Ungu",{"/hat 16586354335"})
		addPreset("BAHAN","Scythes Merah",{"/hat 16586392137"})

		addPreset("BAHAN","Spikes Merah",{"/hat 13463315072"})
		addPreset("BAHAN","Spikes Hitam",{"/hat 13463285148"})
		addPreset("BAHAN","Tung-Tung-Sahar",{"/hat 75273166995301"})
		addPreset("BAHAN","Shrek",{"/hat 78764701353793"})
		addPreset("BAHAN","Monyet Salju",{"/hat 101746478427334"})
		addPreset("BAHAN","Santa Mecha",{"/hat 15599665427"})
		addPreset("BAHAN","Jamur",{"/hat 12742358149"})
		addPreset("BAHAN","Rubik",{"/hat 11169101785"})

		--AYUNAN
		addPreset("Ayunan","Ayunan 1",{"/hat 80333737114314 79942954401351"})
		addPreset("Ayunan","Ayunan 2",{"/hat 80333737114314 81695862449510"})
		addPreset("Ayunan","Ayunan 3",{"/hat 80333737114314 120120030668286"})
		addPreset("Ayunan","Ayunan 4",{"/hat 80333737114314 118972097958753"})
		addPreset("Ayunan","Ayunan 5",{"/hat 80333737114314 108526071170858"})
		addPreset("Ayunan","Ayunan 6",{"/hat 80333737114314 79362324089052"})
		addPreset("Ayunan","Ayunan 7",{"/hat 80333737114314 139900628852698"})

		addPreset("Ayunan","Ayunan 8",{"/hat 114991735194832 79942954401351"})
		addPreset("Ayunan","Ayunan 9",{"/hat 114991735194832 81695862449510"})
		addPreset("Ayunan","Ayunan 10",{"/hat 114991735194832 120120030668286"})
		addPreset("Ayunan","Ayunan 11",{"/hat 114991735194832 118972097958753"})
		addPreset("Ayunan","Ayunan 12",{"/hat 114991735194832 108526071170858"})
		addPreset("Ayunan","Ayunan 13",{"/hat 114991735194832 79362324089052"})
		addPreset("Ayunan","Ayunan 14",{"/hat 114991735194832 139900628852698"})


		addPreset("Ayunan","Kursi Putih",{"/hat 80333737114314"})
		addPreset("Ayunan","Kursi Kuning",{"/hat 114991735194832"})
		addPreset("Ayunan","Boneka Coklat",{"/hat 79942954401351"})
		addPreset("Ayunan","Boneka Hitam",{"/hat 81695862449510"})
		addPreset("Ayunan","Boneka Abu",{"/hat 120120030668286"})

		addPreset("Ayunan","boneka hantu",{"/hat 118972097958753"})
		addPreset("Ayunan","Tangan boneka menyeramkan",{"/hat 108526071170858"})
		addPreset("Ayunan","Kayu Hitam Tangan Hitam",{"/hat 79362324089052"})
		addPreset("Ayunan","Kayu Hitam Tangan Putih",{"/hat 139900628852698"})


addPreset("Anomaly","Normal Snake",{"/hat 17275810493"})
addPreset("Anomaly","Snake Merah",{"/hat 17275818049"})
addPreset("Anomaly","Worm",{"/hat 16494904882"})
addPreset("Anomaly","Croco Suit",{"/hat 13421513307"})
addPreset("Anomaly","Fat-Crocodile",{"/hat 71178283877542"})
addPreset("Anomaly","Duck",{"/hat 18280128517"})
addPreset("Anomaly","Ghost Pink",{"/hat 86241866231576"})
addPreset("Anomaly","Ghost Purple",{"/hat 91390658858493"})
addPreset("Anomaly","Ghost Black",{"/hat 101353463102685"})
addPreset("Anomaly","Ghost White",{"/hat 77188654801887"})
addPreset("Anomaly","Ghost Green",{"/hat 119333439043361"})
addPreset("Anomaly","Ghost Red",{"/hat 112700878171252"})
addPreset("Anomaly","Ghost Yellow",{"/hat 104817124697807"})

addPreset("Anomaly","Pocong Indo",{"/hat 93693437377341"})
addPreset("Anomaly","Possessed-Girl",{"/hat 113048507106875"})
addPreset("Anomaly","Arab-Sheikh",{"/hat 134513641260384"})
addPreset("Anomaly","Abaya",{"/hat 129212249406439"})
addPreset("Anomaly","Chicken",{"/hat 125340284280306"})
addPreset("Anomaly","Gorichilla",{"/hat 18322091668"})
addPreset("Anomaly","Mort",{"/hat 18322091668"})
addPreset("Anomaly","Frog Yellow",{"/hat 121410959623394"})

addPreset("Anomaly","Cow-Suit",{"/hat 14386697005"})
addPreset("Anomaly","Pakaian-Bebek",{"/hat 15895279007"})
addPreset("Anomaly","Setelan-Bebek",{"/hat 16625600543"})
addPreset("Anomaly","dino",{"/hat 121167662227758"})

addPreset("Anomaly","Kodok Hijau",{"/hat 95724986851415"})
addPreset("Anomaly","Salamander",{"/hat 12368401620"})
addPreset("Anomaly","Anjing Menggigit",{"/hat 118191929945847"})
addPreset("Anomaly","Dispenser",{"/hat 74877035957441"})
addPreset("Anomaly","PattyWagon",{"/hat 18625566765"})
addPreset("Anomaly","Bed Spongbob",{"/hat 104310831743277"})
addPreset("Anomaly","Backrooms",{"/hat 16384177158"})
addPreset("Anomaly","Kandang",{"/hat 11148843650"})
addPreset("Anomaly","Dapur",{"/hat 105124768873052"})
addPreset("Anomaly","GamerRoom",{"/hat 72947878501369"})
addPreset("Anomaly","Kotak Pink Hitam",{"/hat 12992465777"})
addPreset("Anomaly","Kantong",{"/hat 116098557862136"})
addPreset("Anomaly","Tornado",{"/hat 18509027003"})
addPreset("Anomaly","Keranjang Capy",{"/hat 14079522796"})
addPreset("Anomaly","Keranjang Hamster",{"/hat 14141078493"})
addPreset("Anomaly","Punggung Capy",{"/hat 11701552350"})
addPreset("Anomaly","Kucing Pisang",{"/hat 14402484085"})
addPreset("Anomaly","Reaper",{"/hat 126460158330599"})
addPreset("Anomaly","Larva 1",{"/hat 18427115101"})
addPreset("Anomaly","Larva merah",{"/hat 17871445525"})
addPreset("Anomaly","Larva Pink",{"/hat 18735266495"})
addPreset("Anomaly","Larva Kuning",{"/hat 18299517719"})
addPreset("Anomaly","Larva Kuning Snot",{"/hat 18735355609"})


--Pet 
addPreset("Pet","Kelinci 1",{"/hat 12457460070"})
addPreset("Pet","Kelinci 2",{"/hat 12457463525"})
addPreset("Pet","Capybara",{"/hat 12812592326"})
addPreset("Pet","Bear Hitam",{"/hat 15426224164"})
addPreset("Pet","Bear Coklat",{"/hat 15426221621"})
addPreset("Pet","Bear Putih",{"/hat 15426218932"})
addPreset("Pet","Toby The British Shorthair",{"/hat 12410537089"})
addPreset("Pet","Santa Putih",{"/hat 15728521770"})
addPreset("Pet","Santa Hitam",{"/hat 15728572374"})
addPreset("Pet","Pet Rock",{"/hat 13512207682"})
addPreset("Pet","Buldog Abu",{"/hat 119354303000"})
addPreset("Pet","Buldog Coklat",{"/hat 11911063916"})
addPreset("Pet","Pomeranian",{"/hat 11990477151"})
addPreset("Pet","Skally",{"/hat 15227872482"})
addPreset("Pet","Kuda Coklat",{"/hat 14899942821"})
addPreset("Pet","Kuda Putih",{"/hat 14899928485"})

addPreset("Aksesories","Palu Pelangi",{"/hat 15541316570"})
addPreset("Aksesories","Palu Pink",{"/hat 16708106159"})
addPreset("Aksesories","Pistol Air",{"/hat 16972562122"})
addPreset("Aksesories","Sepeda Motor",{"/hat 85097130662142"})
addPreset("Aksesories","Mobil F1",{"/hat 12943625253"})
addPreset("Aksesories","Mobil Racing",{"/hat 15047641374"})

addPreset("Aksesories","Kupluk Merah",{"/hat 16006575041"})
addPreset("Aksesories","Kupluk Biru",{"/hat 89429828388014"})
addPreset("Aksesories","Kupluk Orange",{"/hat 16804126239"})
addPreset("Aksesories","Kupluk Yellow",{"/hat 18229047427"})
addPreset("Aksesories","Kupluk Abu",{"/hat 16150927739"})
addPreset("Aksesories","Kupluk Sigil",{"/hat 16251002612"})
addPreset("Aksesories","Kupluk Arc Black",{"/hat 17387564794"})
addPreset("Aksesories","Kupluk Arc Red",{"/hat 17387607530"})



addPreset("Aksesories","Bandana Black",{"/hat 96087706219507"})
addPreset("Aksesories","Bandana White",{"/hat 101652256896720"})
addPreset("Aksesories","adidas Toon White on Black Bucket Hat",{"/hat 44429370229"})
addPreset("Aksesories","adidas Toon Black on White Bucket Hat",{"/hat 105216311446425"})

addPreset("Aksesories","CHILLED Yellow Dufflebag",{"/hat 17185122177"})
addPreset("Aksesories","Duffel Bag",{"/hat 4436710326"})
addPreset("Aksesories","3.0 White Duffel Bag",{"/hat 6409566316"})
addPreset("Aksesories","[3.0] Black Duffel Gym Bag",{"/hat 130140027023043"})
addPreset("Aksesories","Chrome Cross Duffle Bag",{"/hat 14230226526"})
addPreset("Aksesories","Duffel Bag Black BAPE Shark Camo Designer Y2K 1.0",{"/hat 17418413552"})
addPreset("Aksesories","Duffel Bag BAPE Shark Red",{"/hat 17398310198"})

addPreset("Aksesories","Slipknot Backpack",{"/hat 92299950702250"})
addPreset("Aksesories","y2k Bag",{"/hat 18916751976"})
addPreset("Aksesories","Black SelfMade SprayGround Backpack 2.0",{"/hat 73627569972423"})
addPreset("Aksesories","y2k Slempang",{"/hat 84481485903663"})
addPreset("Aksesories","off shoulder graffiti stickers backpack",{"/hat 17291508166"})
addPreset("Aksesories","off shoulder camo 130 bag (1.0)",{"/hat 118430524956733"})
addPreset("Aksesories","Off Shoulder Black Backpack 1.0",{"/hat 18193515123"})
addPreset("Aksesories","Esoteric Bastion Leather Rope Bag",{"/hat 118491908402717"})
addPreset("Aksesories","y2k crossbody bag white",{"/hat 106870716186239"})
addPreset("Aksesories","off shoulder graffiti stickers backpack",{"/hat 118430524956733"})




addPreset("Aksesories","✅ Black Scythe",{"/hat 91638919315070"})
addPreset("Aksesories","✅ White Scythe ",{"/hat 73659556000345"})
addPreset("Aksesories","Winged Angelic Cherub Guitar - Void Black",{"/hat 107943728196655"})

addPreset("Aksesories","Huge White and Black Fluffy Bunny Plushie",{"/hat 82021400371401"})
addPreset("Aksesories","Eepy Bunny backpack black",{"/hat 13948557954"})
addPreset("Aksesories","Toothless",{"/hat 71227662273402"})
addPreset("Aksesories","Slipknot Backpack",{"/hat 92299950702250"})



addPreset("Aksesories","Luxury Chain Socialite Shades in Silver",{"/hat 92559097787113"})
addPreset("Aksesories","Luxury Chain Socialite Shades in Gold",{"/hat 103798739199964"})
addPreset("Aksesories","Luxury Chain Socialite Shades in Silver",{"/hat 92559097787113"})


addPreset("Bocil","Kitty",{"/hat 17180800755"})
addPreset("Sweater","Posed Bear Fluffy Hoodie Brown",{"/hat 82188854944959"})
addPreset("Bocil","Kitty Reverse",{"/hat 17180803560"})
addPreset("Bocil","Kitty Blood Moon",{"/hat 17180797610"})
addPreset("Bocil","Cat Sweater",{"/hat 17276410536"})
addPreset("Bocil","Bunny Buddy 1",{"/hat 88586286182794"})
addPreset("Bocil","Bunny Buddy Maroon",{"/hat 109445716880169"})
addPreset("Bocil","Cat Hugging Black",{"/hat 17276407263"})
addPreset("Bocil","Banana Cat Hugging",{"/hat 17295280342"})
addPreset("Bocil","Black/White Teeth",{"/hat 88574547624621"})
addPreset("Bocil","bunny pink",{"/hat 78799036448658"})
addPreset("Bocil","cutesy panda paws",{"/hat 84360467684043"})
addPreset("Bocil","CUTE KUROMI",{"/hat 118420798339452"})
addPreset("Bocil","sweet duck",{"/hat 115361115857611"})
addPreset("Bocil","Cutesy Pikachu",{"/hat 135232495915826"})
addPreset("Bocil","sweet duck",{"/hat 17180806511"})
addPreset("Bocil","Stitch Alien ",{"/hat 85194099947674"})
addPreset("Bocil","Black Dragon Onesie",{"/hat 96008230742732"})
addPreset("Bocil","Cute Plushie Shark Onesie Black",{"/hat 122689372214872"})
addPreset("Bocil","Cute Plushie Shark Onesie Blue",{"/hat 80016503644805"})
addPreset("Bocil","Toothless Dragon Onesie",{"/hat 71435241938776"})
addPreset("Bocil","Cute Plushie Shark Onesie Blue",{"/hat 96848412963002"})
addPreset("Bocil","Cute Shark Plushie Onesie Blue",{"/hat 93560160273165"})
addPreset("Bocil","Shark-Jacket-Black",{"/hat 119134549655390"})
addPreset("Bocil","Yellow-Duck-RainCoat",{"/hat 18529518454"})
addPreset("Bocil","Baby-Cow-Onesie-White-Brown",{"/hat 101107796877144"})
addPreset("Bocil","Kawaii Cow Hooded Jacket",{"/hat 111156410476629"})


addPreset("Celana","Y2k Tes",{"/hat 17396862831"})
addPreset("Celana","💜 Layered Wrapped Scarf Denim Pants_Black",{"/hat 109568464536337"})
addPreset("Celana","Luminous Pants",{"/hat 86241524959675"})
addPreset("Celana","Yama Black Baggy Trousers",{"/hat 110082958798640"})
addPreset("Celana","Loose-Cargo-Pants",{"/hat 125353105167440"})

addPreset("Celana","Layered-Scarf-Denim-Pants-Black",{"/hat 82701892912199"})

--Celana Merah

addPreset("Celana","Y2k Named Collective Set Sweatpants",{"/hat 123434099612522"})
addPreset("Celana","Cyberpunk-Goth-Baggy-Cargo-Pants-w-Platform-Shoes",{"/hat 82478415484709"})
addPreset("Celana","His-Baggy-Sweatpants-Super",{"/hat 75034202365608"})
addPreset("Celana","Red-Baggy-Striped-Track-Suit-Pants",{"/hat 94906508654779"})
addPreset("Celana","SAGGING-CARGO-TRACK-PANTS-RED",{"/hat 105930045846517"})
addPreset("Celana","Y2K-Strapped-Cargoes-Blood-Moon",{"/hat 134123566316591"})

-- Celana Hitam
addPreset("Celana","Black-Baggy-Striped-Track-Suit-Pants",{"/hat 100272113644619"})

--Celana Biru
addPreset("Celana","TBL Pants (blue)",{"/hat 79925512337653"})

--baggy
addPreset("Celana","African-Tribal-Black-Sweatpants",{"/hat 18960723430"})
addPreset("Celana","adidas Purple Galaxy Trousers",{"/hat 17202394160"}) -- News adidas

--Denim
addPreset("Celana","Y2K-SAGGING-JEANS-WITH-CHAIN-BELT-BLUE",{"/hat 91060772833164"})
addPreset("Celana","ripped jeans denim",{"/hat 136312986386346"})
addPreset("Celana","black ripped jeans denim",{"/hat 122520044088465"})


--Celana Hitam + Sepatu
addPreset("Celana","Black Sweatpants & Sneakers",{"/hat 122537459608348"})
addPreset("Celana","Ripped Black Baggy",{"/hat 81556798134254"})

--Celana Hitam


--Y2K Layering
addPreset("Celana","Stylized-Black-Cargo-Pants",{"/hat 15909919541"})
addPreset("Celana","Pleats Layered Skirt Pants Black",{"/hat 128280660468223"})
addPreset("Celana","AG Baggy Blue Pants",{"/hat 102311226955131"})
addPreset("Celana","Y2K Baggy Pants Black",{"/hat 137910434186126"})
addPreset("Celana","Baggy Pants White",{"/hat 115899217250614"})
addPreset("Celana","Baggy Pants Black",{"/hat 104434728784319"})
addPreset("Celana","Black-Yellow-Stripe-Patterns-Baggy-Techwear-Pants",{"/hat 115770892725830"})


--Y2K STyle
addPreset("Celana","BB-Black-Y2K-Baggy-Star-Denim-Jeans",{"/hat 72623322161460"})
addPreset("Celana","Emo-Strap-Pants",{"/hat 85723422260752"})
addPreset("Celana","Y2K-Black-Cargo-Pants-with-Strap",{"/hat 126490351689789"})
addPreset("Celana","Y2k-Named-Collective-Set-Sweatpants",{"/hat 140527319282248"})
addPreset("Celana","Y2K-Black-Cargo-Pants-with-Strap",{"/hat 126490351689789"})

addPreset("Celana","Zipped-Cargo-Pants-Black",{"/hat 72106418680695"})
addPreset("Celana","Baggy-Pants-Mystery-Forest",{"/hat 126044046156226"})
addPreset("Celana","Y2K LAYERED DENIM CARGO PANTS GREY",{"/hat 137512823216462"})

addPreset("Celana","Black-Yellow-y2k-Sweatpants",{"/hat 133895694486505"})

addPreset("Celana","MONEY-SAGGING-JEANS-WITH-CHAIN-BLACK",{"/hat 114836621265962"})
addPreset("Celana","001-Y2K-Pants-Black-Jeans",{"/hat 122148247390060"})
addPreset("Celana","SAGGING-CARGO-TRACK-PANTS-BLACK",{"/hat 103268948162192"})
addPreset("Celana","Baggy-Pants-Black-White-Smoke",{"/hat 116231360275745"})
addPreset("Celana","Baggy-Cargo-Pants-White",{"/hat 94540132575322"})
addPreset("Celana","Baggy-Sporty-Sweatpants-Shoes",{"/hat 73147148669448"})
addPreset("Celana","Baggy-Cargo-Pants-Black",{"/hat 76404438335283"})
addPreset("Celana","Y2K-SAGGING-JEANS-WITH-CHAIN-BELT-BLACK",{"/hat 130432772712618"})
addPreset("Celana","Baggy-jeans-Black",{"/hat 110651488161112"})
addPreset("Celana","Double-Layered-Sagging-Pants-Black",{"/hat 88373708705695"})
addPreset("Celana","Cool-Y2k-Grunge-Set-Sweatpants-Black",{"/hat 136523649473545"})

addPreset("Celana","Denim-Y2k-Jeans-Drippy-Smiley-Face",{"/hat 17712259820"})
addPreset("Celana","SAGGING-CARGO-TRACK-PANTS-GREY",{"/hat 71009803672741"})
addPreset("Celana","Baggy-Cargo-Pants-w-Pockets-Belt-Straps-White",{"/hat 114694029270244"})
addPreset("Celana","Yama-White-Baggy-Trousers",{"/hat 93477726364140"})
addPreset("Celana","Y2K-LAYERED-DENIM-CARGO-PANTS-BLACK",{"/hat 107362202703454"})

addPreset("Celana","Y2K-Strapped-Cargoes-Reverse-Monochrome",{"/hat 130326113767626"})
addPreset("Celana","IM-BLACK-STRIPE-PANTS",{"/hat 111947621108072"})
addPreset("Celana","Brown-Doodled-Kawaii-Emo-Cargo",{"/hat 17855278562"})
addPreset("Celana","Cross-Y2K-Cargo-Pants-White-Pink-Spider",{"/hat 17209176075"})
addPreset("Celana","Baggy-Cargo-Pants-w-Pockets-Belt-Straps-Black",{"/hat 83720288303944"})
addPreset("Celana","Light-blue-Baggy-jeans",{"/hat 86484672342979"})
addPreset("Celana","Cross-Y2K-Cargo-Pants-White-Black",{"/hat 18523847857"})
addPreset("Celana","MONEY-SAGGING-JEANS-WITH-CHAIN-ASH-GREEN",{"/hat 127309210701919"})
addPreset("Celana","MONEY-SAGGING-JEANS-WITH-CHAIN-ASH-BLUE",{"/hat 122630784517557"})
addPreset("Celana","ardor-string-jeans-light",{"/hat 18507527463"})
addPreset("Celana","Black-Cyber-Sigil-Jeans",{"/hat 18964447317"})
addPreset("Celana","ardor-string-jeans-med",{"/hat 18507389298"})
addPreset("Celana","Y2K-LAYERED-BAGGY-JEANS-ASHBLUE",{"/hat 80977152167175"})
addPreset("Celana","Y2K-LAYERED-DENIM-CARGO-PANTS-KHAKI",{"/hat 107681837490987"})
addPreset("Celana","Y2K-LAYERED-BAGGY-JEANS-BLACK",{"/hat 123936591051518"})
addPreset("Celana","Y2K-Strapped-Cargoes-Monochrome",{"/hat 124004763861993"})
addPreset("Celana","Japanese-Anime-Pants-Bontan",{"/hat 72270919631045"})

addPreset("Celana","Vintage-Washed-Jeans",{"/hat 74025923547268"})
addPreset("Celana","Y2K-SAGGING-JEANS-WITH-CHAIN-BELT-KHAKI-GREEN",{"/hat 70794461472608"})


addPreset("Celana","Y2K-SAGGING-JEANS-WITH-CHAIN-BELT-DARK-BLUE",{"/hat 86104158914845"})
addPreset("Celana","SAGGING-CARGO-TRACK-PANTS-OLIVE",{"/hat 71665854257991"})
addPreset("Celana","Chrom-Heart-Pants",{"/hat 80283360461363"})
addPreset("Celana","Y2K-Baggy-Cargoes-Blood-Moon",{"/hat 94441754364719"})
addPreset("Celana","Pink-White-Hearts-Baggy-Cargo-Pants",{"/hat 18612749279"})
addPreset("Celana","Baggy-vstar-Sweatpants",{"/hat 115406342582524"})
addPreset("Celana","Grunge-Ripped-Punk-Jeans-Belt-Platform-Shoes",{"/hat 103054482692002"})
addPreset("Celana","BB-White-Low-Rise-Baggy-Jeans",{"/hat 122087513466241"})
addPreset("Celana","M11-Baggy-Chrome-Cross-Jeans-w-timb-boots",{"/hat 79760894317442"})
addPreset("Celana","Y2K-OVERSIZED-BAGGY-JEANS-WITH-SHOES-GREY",{"/hat 90485292978106"})
addPreset("Celana","Black-Y2K-Baggy-Strap-Cargo-Jeans-w-Sneakers",{"/hat 90432730205903"})
addPreset("Celana","Black-Sweatpants-with-Sneakers",{"/hat 94432107331160"})
addPreset("Celana","M11-Baggy-Chrome-Cross-Jeans-w-timb-boots",{"/hat 79908658673842"})

addPreset("Celana","Black-Cyber-Sigil-Jeans",{"/hat 18964450118"})
addPreset("Celana","Canvas-Cargo-Pants",{"/hat 18474338097"})
addPreset("Celana","Stylish-Black-Baggy-Tracksuits",{"/hat 107221904954874"})
addPreset("Celana","M11-Y2K-Star-Baggy-Jeans-w-Timb-boots",{"/hat 73118087896633"})
addPreset("Celana","Y2K-Jeans-Strawberry",{"/hat 16854282952"})
addPreset("Celana","Black-Cargo-Pants-w-Crosses",{"/hat 127607506688817"})
addPreset("Celana","Black-Y2k-Gothic-Jeans",{"/hat 17278036207"})
addPreset("Celana","Cargo-Pants-White-Urban-Baggy-Cargos-Canvas-Y2K",{"/hat 103205925267286"})
addPreset("Celana","Black-Metal-Cross-Y2K-Cargo-Pants-w-Shoes",{"/hat 18539653755"})
addPreset("Celana","Black-Urban-Baggy-Cargos",{"/hat 16817213433"})
addPreset("Celana","Black-Y2K-Cargos-with-Sneakers",{"/hat 130216127035940"})
addPreset("Celana","Cargo-Pants-Black-Urban-Baggy-Cargos-Canvas-Y2K",{"/hat 89719648221460"})
addPreset("Celana","grunge-cross-y2k-jeans-w-studded-belts",{"/hat 18322035249"})
addPreset("Celana","White-Y2k-Gothic-Jeans",{"/hat 17278050406"})
addPreset("Celana","Emo-Baggy-Jeans-Black",{"/hat 109962646960605"})
addPreset("Celana","Y2K-Jeans-Blanc",{"/hat 16854270678"})
addPreset("Celana","White-Baggy-Cargo-Pants",{"/hat 136815896912016"})




addPreset("Celana","Ripped Grey Baggy",{"/hat 99217827072109"})
addPreset("Celana","White-Baggy-Cargo-Pants-w-Shoes-Straps",{"/hat 72281289528751"})
addPreset("Celana","Grey-Baggy-Cargo-Pants-w-Shoes-Straps",{"/hat 100386431082999"})
addPreset("Celana","Y2K-Baggy-Jeans-with-strap",{"/hat 77491744010860"})
addPreset("Celana","Y2k-Gothic-Jeans-w-Cross",{"/hat 18518081251"})
addPreset("Celana","Light-Baggy-Jeans-w-Shoes",{"/hat 76135156501582"})
addPreset("Celana","Baggy-Pants-Black-with-Flames",{"/hat 85723422260752"})
addPreset("Celana","Baggy-Pants-White-with-Flames",{"/hat 136413676403346"})
addPreset("Celana","Baggy-Flame-Sweats-Black-and-Grey",{"/hat 73153781498466"})
addPreset("Celana","white-red-flames-y2k-cargo-pants",{"/hat 17434229031"})
addPreset("Celana","white-black-flames-y2k-cargo-pants",{"/hat 16896207314"})
addPreset("Celana","Baggy-Flame-Sweats-Black-and-Pink",{"/hat 94455639815238"})
addPreset("Celana","black-purple-flames-y2k-cargo-pants",{"/hat 17434232011"})
addPreset("Celana","Black-Business-Pants",{"/hat 77706523937549"})
addPreset("Celana","Formal-Business-Pants-Black",{"/hat 17347785205"})
addPreset("Celana","Basic-Skinnies-Blackk",{"/hat 17256670844"})
addPreset("Celana","Suspender-Jeans-Black",{"/hat 9241899146"})
addPreset("Celana","Purple-Brand-Skinny-Jeans-w-Designer-Belt",{"/hat 80697657455281"})
addPreset("Celana","Swedish-House-Mafia-Black-CargoPants",{"/hat 15171017017"})
addPreset("Celana","Atlanta-Psd-Jeans",{"/hat 73292224812334"})
addPreset("Celana","Halloween-Orange-and-Black-Scary-Bat-Pumpkin",{"/hat 113005018253902"})
addPreset("Celana","Baggy-joggers-Grey",{"/hat 107677980027566"})
addPreset("Celana","Baggy-Joggers-Black",{"/hat 126135883970838"})
addPreset("Celana","adidas-Trousers-Black-and-White",{"/hat 18407452734"})
addPreset("Celana","adidas-Loose-Fit-Tracksuit-Bottoms",{"/hat 15513040145"})
addPreset("Celana","Designer-Shark-Pants-Red",{"/hat 18742003708"})
addPreset("Celana","Designer-Shark-Pants-White",{"/hat 18742042423"})
addPreset("Celana","Ninja-Sweats-Wolf-Monochrome",{"/hat 12930383195"})
addPreset("Celana","Tokyo-Urban-Combat-Techwear-Joggers-Black",{"/hat 138991655669891"})
addPreset("Celana","Perfect-Fit-Black-Ripped-Jeans",{"/hat 13354322361"})
addPreset("Celana","Engineering-Pants-White-Black",{"/hat 10371046330"})
addPreset("Celana","adidas-Trousers-Floral-White-on-Black",{"/hat 17578038197"})
addPreset("Celana","Fashionable-Paratrooper-Pants",{"/hat 11561533396"})
addPreset("Celana","y2k-gangsta-tracksuit-pants-black",{"/hat 17829216066"})
addPreset("Celana","Utility-Pants-Black",{"/hat 9179890366"})
addPreset("Celana","adidas-Halloween-Pumpkin-Trousers",{"/hat 84968578336690"})
addPreset("Celana","Japanese-Streetwear-Pants-Blackout",{"/hat 82817136754432"})
addPreset("Celana","Tokyo-Urban-Combat-Techwear-Joggers-White",{"/hat 82752050315206"})
addPreset("Celana","Utility-Pants-Black-Red",{"/hat 9191605361"})
addPreset("Celana","Baggy-Oversized-Denim-Overalls-in-Purple",{"/hat 88274677490831"})
addPreset("Celana","Baggy-Oversized-Denim-Overalls-in-Red",{"/hat 73232183332449"})
addPreset("Celana","Baggy-Oversized-Denim-Overalls-in-Brown",{"/hat 123704096031872"})
addPreset("Celana","Baggy-Oversized-Denim-Overalls-in-White",{"/hat 112042392487319"})
addPreset("Celana","Baggy-Oversized-Denim-Overalls-in-Pink",{"/hat 131559607965076"})
addPreset("Celana","Baggy-Oversized-Denim-Overalls-in-Blue",{"/hat 96012145827162"})
addPreset("Celana","Baggy-Oversized-Denim-Overalls-in-Grey",{"/hat 134355490584725"})
addPreset("Celana","Baggy-Oversized-Denim-Overalls-in-Blue",{"/hat 84446684101984"})
addPreset("Celana","Baggy-Oversized-Denim-Overalls-in-Dark-Green",{"/hat 106215786441733"})
addPreset("Celana","Baggy-Oversized-Denim-Overalls-in-Yellow",{"/hat 90838430375852"})

addPreset("Celana","Overall skut",{"/hat 126525668123621"})
addPreset("Celana","Happy day jumpsuit",{"/hat 135930933110128"})
addPreset("Celana","Overall 001 ver.3",{"/hat 133478317180352"})

addPreset("Celana","Arcanae Exclusive Overall",{"/hat 81318078771148"})
addPreset("Celana","Overall 1TR Ver.1",{"/hat 96560247809837"})
addPreset("Celana","Overall ARCANAEx001 Pink Edition",{"/hat 83200117964539"})
addPreset("Celana","Overall ARCANAEx001 Denim Edition",{"/hat 130271725414272"})
addPreset("Celana","Overall ARCANAEx001",{"/hat 90581196217010"})


addPreset("Celana","Sarung (Dark)",{"/hat 18814049886"})
addPreset("Celana","Sarung (Green)",{"/hat 18814027426"})
addPreset("Celana","Sarung (Blue)",{"/hat 18814034773"})






--My hair
addPreset("Hair","White - Parted Short Fade",{"/hat 86959646078374"})
addPreset("Hair","White Messy Manhwa Aura",{"/hat 97420535316745"})
addPreset("Hair","Tenri Sazanami (Black Red)",{"/hat 133069976441762"})
addPreset("Hair","Tenri Sazanami (Ash Grey)",{"/hat 131775041031988"})
addPreset("Hair","Tenri Sazanami (Black)",{"/hat 97042702952729"})
addPreset("Hair","Messy Taper Fringe",{"/hat 16160085391"})
addPreset("Hair","Side Parted Slicked Back",{"/hat 17854798700"})
addPreset("Hair","Messy Parted Light Bangs White",{"/hat 13260633569"})
addPreset("Hair","Messy Parted Light Bangs Black",{"/hat 13260539172"})
addPreset("Hair","Black Topi",{"/hat 135829665804722"})
addPreset("Hair","Black Shaved Head Buzzcut",{"/hat 92350055893943"})
addPreset("Hair","Black Messy Short Fringe",{"/hat 15219402962"})
 
-- BOTAK
addPreset("Hair","Y2K-Pink-Fire-Dyed-Buzz-Cut-Hair",{"/hat 92418398211639"})
addPreset("Hair","Heart-Dyed-Buzz-Cut",{"/hat 12395299028"})
addPreset("Hair","Y2K-Fire-Dyed-Blonde-Buzz-Cut-Hair",{"/hat 15105120291"})
addPreset("Hair","Flaming-Mohawk",{"/hat 191101707"})

--Bocil
addPreset("Hair","Black-Messy-Hair-w-Hoodie-Headphones",{"/hat 105275386127995"})
addPreset("Hair","White-Black-Messy-Anime-Hair-w-Cute-Cat-Hood",{"/hat 93472908133730"})
addPreset("Hair","Tilted-Wolfcut-Pierced-Sun-Hat-Messy-Hair-White",{"/hat 18679539684"})
addPreset("Hair","White",{"/hat 85880680122086"})
addPreset("Hair","STREET-STYLE-HAIR-WITH-CAP-SPIDER-AIRPODS-BLACK",{"/hat 124570680549363"})
addPreset("Hair","Messy-Anime-Hair-w-Y2k-Punk-Goggles-Black",{"/hat 130423767048795"})
addPreset("Hair","STREET-STYLE-HAIR-WITH-CAP-SPIDER-AIRPODS",{"/hat 73081416565777"})
addPreset("Hair","Messy-Anime-Boy-Hair-w-Y2K-Distressed-Hat-Black",{"/hat 77047800832136"})
addPreset("Hair","White-Messy-Hair-w-Blue-Santa-Hat",{"/hat 85692331805287"})
addPreset("Hair","Rubber-Duck-Bubble-Messy-Hair",{"/hat 125637654963026"})
addPreset("Hair","Cool-Super-Messy-Boy-Hair-w-Beanie-Black-White",{"/hat 15569253826"})
addPreset("Hair","Black-Messy-Hair-w-Black-Santa-Hat",{"/hat 81732160618694"})
addPreset("Hair","Black-Messy-Anime-Boy-Hair-w-Y2K-Distressed-Hat",{"/hat 77305752348992"})
addPreset("Hair","Black-White-Messy-Anime-Hair-w-Goth-Captain-Hat",{"/hat 91472407917560"})
addPreset("Hair","Black-White-Anime-Hair-w-Beanie-Headphones",{"/hat 15916183967"})
addPreset("Hair","Messy-Hair-w-Headphones-Y2K-Beanie-Black-White",{"/hat 15309258403"})
addPreset("Hair","Punk-Cat-Ears-Hairstyle-White",{"/hat 14496981415"})
addPreset("Hair","Black-Pierced-Cat-Ears-Hair",{"/hat 128111495539791"})
addPreset("Hair","Black-Cool-Messy-Boy-Hair-w-Y2K-Goggles-Ushanka",{"/hat 118837715531609"})
addPreset("Hair","Punk-Cat-Ears-Hairstyle-Black",{"/hat 14496749790"})
addPreset("Hair","Black-White-Anime-Boy-Hair-w-Y2K-Distressed-Hat",{"/hat 91591932680347"})
addPreset("Hair","Silver-Cool-Messy-Boy-Hair-w-Y2K-Goggles-Ushanka",{"/hat 93114050328334"})
addPreset("Hair","Brown-Streaky-Messy-Wolfcut-Hair-w-Backwards-Cap",{"/hat 73305974851730"})
addPreset("Hair","Fried-Egg-Headphones-Messy-Hair",{"/hat 140309411483117"})
addPreset("Hair","Black-Red-Messy-Anime-Hair-w-Y2K-Captain-Hat",{"/hat 83964923141222"})
addPreset("Hair","Fluffy-Curly-Hair-w-Punk-Hat-White",{"/hat 127633889942185"})
addPreset("Hair","Yellow-Messy-Anime-Hair-w-Goth-Captain-Hat",{"/hat 88948183151817"})
addPreset("Hair","Grunge-mullet-w-bunny-beanie-in-Black",{"/hat 14998156600"})
addPreset("Hair","Brown",{"/hat 70984588027539"})
addPreset("Hair","Gray-Messy-Hair-w-Y2k-Punk-Visor",{"/hat 83125002339682"})
addPreset("Hair","Rubber-Duck-Bubble-Messy-Hair",{"/hat 130286877796581"})
addPreset("Hair","Sky-Blue-Messy-Hair-w-Cat-Knit-Beanie",{"/hat 96871966950009"})
addPreset("Hair","Messy-Hair-with-Punk-Cap-Silver",{"/hat 16067611849"})
addPreset("Hair","Silver-Messy-Anime-Boy-Hair-w-Y2K-Distressed-Hat",{"/hat 114751808641821"})
addPreset("Hair","Pink",{"/hat 128552820051823"})
--WHITE Messy
addPreset("Hair","White",{"/hat 100531979448882"})
addPreset("Hair","Ragna",{"/hat 129748819870954"})
addPreset("Hair","Messy-Taper-Fringe",{"/hat 16169262402"})
addPreset("Hair","White-Side-Parted-Messy-Hair",{"/hat 136623612959352"})
addPreset("Hair","White-Messy-Middle-Part-Hair-w-Earring",{"/hat 97714842615043"})
addPreset("Hair","White",{"/hat 115392749698336"})
addPreset("Hair","White-Black-Messy-Wavy-Hair",{"/hat 17058126195"})
addPreset("Hair","Ichigo",{"/hat 90331854046406"})
addPreset("Hair","White-Messy-Fluffy-Boy-Hair",{"/hat 18653280000"})
addPreset("Hair","White-Fluffy-Zoldyck-Hair",{"/hat 126541017138655"})
addPreset("Hair","Transparent-Messy-Emo-Hair-White",{"/hat 137426448595501"})



--BLACK Messy
addPreset("Hair","Black-Modern-Mullet",{"/hat 18401051407"})
addPreset("Hair","Jay-Jo-Mullet",{"/hat 72363502718122"})
addPreset("Hair","Black-Messy-Middle-Part-Hair",{"/hat 92263951458902"})
addPreset("Hair","Anime-Sorcerer-Hair-in-Black-White",{"/hat 16189403583"})
addPreset("Hair","BARREL-TWISTS-DREADS",{"/hat 122785871028435"})
addPreset("Hair","Chrollo",{"/hat 90053332814168"})
addPreset("Hair","Slicked-Back-Dreads-Headband",{"/hat 18361709437"})
addPreset("Hair","Qin-Shi-Huang",{"/hat 110093458777022"})
addPreset("Hair","Faded-Phantom-Flow",{"/hat 129020394568763"})
addPreset("Hair","Black-Stylish-Side-Parted-Emo-Hair",{"/hat 113524098255484"})
addPreset("Hair","Messy-MIddle-Hair-w-Wide-Brim-Hat-Black-White",{"/hat 120706607600238"})
addPreset("Hair","Black-Messy-Handsome-Wolfcut",{"/hat 115052355538883"})
addPreset("Hair","Black-Messy-Wolfcut-w-Bandage",{"/hat 115520061093937"})
addPreset("Hair","Black-Parted-Short-Fade-Light-Bangs",{"/hat 96656411683020"})
addPreset("Hair","Black-Messy-Wolfcut",{"/hat 98528599025378"})
addPreset("Hair","Black-Messy-Anime-Hair-w-Goth-Captain-Hat",{"/hat 110130716552479"})
addPreset("Hair","Black-Messy-Dragon-Hunter-Hair",{"/hat 116773763268018"})
addPreset("Hair","Black-K-Pop-Idol-Hair",{"/hat 116370675366789"})
addPreset("Hair","Black-Red-Messy-Middle-Part-Hair-w-Earring",{"/hat 90719764200179"})
addPreset("Hair","Black-Messy-Middle-Part-Hair-w-Earring",{"/hat 87408873306733"})
addPreset("Hair","Messy-Fluffy-Anime-Boy-Hair-Black-White",{"/hat 87561079315046"})
addPreset("Hair","Black-White-Parted-Short-Fade-Light-Bangs",{"/hat 139792341994063"})
addPreset("Hair","Lu-Guang-Black",{"/hat 79623244992791"})
addPreset("Hair","Stylish-Hair-Black",{"/hat 16314636793"})
addPreset("Hair","Black-Red-Parted-Short-Fade-Light-Bangs",{"/hat 123780472030792"})
addPreset("Hair","Black-Messy-Hair",{"/hat 125975708913643"})
addPreset("Hair","Fluffy-Messy-Hair-Black",{"/hat 14892162637"})
addPreset("Hair","Messy-Fluffy-Anime-Boy-Hair-Black",{"/hat 93604871172898"})
addPreset("Hair","Dragon-Messy-Hair-Black",{"/hat 116788699891272"})
addPreset("Hair","Side-Parted-Slicked-Back-Gojo-Hair",{"/hat 120478611992895"})
addPreset("Hair","Qin-Shi-Huang-Gold",{"/hat 107505014995178"})



-- ASH 
addPreset("Hair","Ash-Messy-Middle-Part-Hair",{"/hat 92880086523642"})
addPreset("Hair","BLOND-BARREL-TWISTS-DREADS",{"/hat 78872304386489"})
addPreset("Hair","Super-Messy-Fluffy-Boy-Hair-Blonde",{"/hat 12887264012"})
addPreset("Hair","Ash-Messy-Middle-Part-Hair",{"/hat 92880086523642"})
addPreset("Hair","Messy-Anime-Hair-in-Platinum-Blonde",{"/hat 15916039554"})
addPreset("Hair","Cool-Boy-grey-Hair-season-23",{"/hat 132147367605810"})
addPreset("Hair","Stylish-Side-Swept-Hair-Ash",{"/hat 13935869335"})
addPreset("Hair","Messy-Parted-Light-Bangs-Hair-Platinum-Blonde",{"/hat 13260615898"})
addPreset("Hair","Blonde-Stylish-Side-Parted-Emo-Hair",{"/hat 128650634523996"})
addPreset("Hair","Stylish-Side-Swept-Hair-Platinum-Blonde",{"/hat 13935862450"})
addPreset("Hair","Messy-Parted-Light-Bangs-Hair-Ash",{"/hat 13260627139"})
addPreset("Hair","Black-Side-Parted-Messy-Hair",{"/hat 71737288862061"})
addPreset("Hair","Messy-Parted-Light-Bangs-Hair-Silver",{"/hat 13260631087"})

--Biru
addPreset("Hair","Blue",{"/hat 128302998787378"})
addPreset("Hair","Messy-Hair-w-Y2K-Punk-Cat-Beanie-Sky-Blue",{"/hat 13388773290"})
addPreset("Hair","Messy-Hair-w-White-Skull-Headphones-Black-Blue",{"/hat 83212540700129"})
addPreset("Hair","Sky-Blue-Messy-Middle-Part-Hair",{"/hat 91129537751106"})
addPreset("Hair","Black-Blue-Messy-Wavy-Hair",{"/hat 17058150667"})
addPreset("Hair","Punk-Cat-Ears-Hairstyle-Sky-Blue",{"/hat 14496910356"})
addPreset("Hair","Sky-Blue-Messy-Fluffy-Boy-Hair",{"/hat 18653087121"})

--Pink
addPreset("Hair","Messy-Parted-Light-Bangs-Hair-Pink",{"/hat 13260636502"})
addPreset("Hair","Pink-Messy-Middle-Part-Hair",{"/hat 95719103534344"})
addPreset("Hair","Pink",{"/hat 76886445570493"})
addPreset("Hair","Messy-Hair-w-Y2K-Punk-Cat-Beanie-Pink",{"/hat 13388770197"})

addPreset("Jacket","90s Varsity",{"/hat 86142263485302"})
addPreset("Jacket","Bunny-Crop-Jacket-Reverse-Blood-Moon",{"/hat 12868189114"})
addPreset("Jacket","Froggy-Hoodie-Monochrome",{"/hat 140502815961842"})

addPreset("Jacket","Spiderdyf SPY",{"/hat 107750804272212"})
addPreset("Jacket","Baseball Bomber Yellow",{"/hat 129770451236894"})
addPreset("Jacket","black roses",{"/hat 109719419054580"})
addPreset("Jacket","Estime",{"/hat 121666152870250"})
addPreset("Jacket","XXII",{"/hat 122038240365177"})
addPreset("Jacket","spooky ghost smile",{"/hat 14760223994"})
addPreset("Jacket","dragon jacket",{"/hat 95506444924679"})
addPreset("Jacket","Cyber Sigil",{"/hat 83715371352964"})
addPreset("Jacket","Black Coat Shoulder",{"/hat 17815567528"})
addPreset("Jacket","Cream White Coat Shoulder",{"/hat 17815560161"})
addPreset("Jacket","Big FurCoat 1",{"/hat 93161345416771"})
addPreset("Jacket","Big FurCoat 2",{"/hat 91454299555978"})
addPreset("Jacket","Fluffy Solid Black",{"/hat 12302400834"})
addPreset("Jacket","Hero Jacket Oni Blood Moon",{"/hat 14433369343"})
addPreset("Jacket","Hero Jacket Oni Reverse Monochrome",{"/hat 14433374543"})
addPreset("Jacket","VARSITY JACKET SWAG",{"/hat 125786650102653"})
addPreset("Jacket","TTR-Yellow",{"/hat 90930486127559"})
addPreset("Jacket","TTR-Pink",{"/hat 134953598638380"})
addPreset("Jacket","TTR-Black",{"/hat 71331132658729"})
addPreset("Jacket","Y2K-Pink-Spider",{"/hat 15371712895"})
addPreset("Jacket","AMITY-de-LA-FAM",{"/hat 110055343347528"})
addPreset("Jacket","Leather-Bomber",{"/hat 82405897845832"})
addPreset("Jacket","Doom-reaper-grunge-punk-vest",{"/hat 110405445717736"})
addPreset("Jacket","Black Leather Strap",{"/hat 108898666444531"})
addPreset("Jacket","Hero-Jacket-Oni-Monochrome",{"/hat 14433372460"})
addPreset("Jacket","Hero-Jacket-Vaporwave-Monochrome",{"/hat 14433381519"})
addPreset("Jacket","Hero-Jacket-Vaporwave-Vanta",{"/hat 14433377015"})
addPreset("Jacket","Half Reverse Monochrome",{"/hat 89001983085421"})
addPreset("Jacket","Half Monochrome",{"/hat 99161498096174"})
addPreset("Jacket","Half Solid Red",{"/hat 88084145053341"})
addPreset("Jacket","White Off Shoulder",{"/hat 18396754379"})
addPreset("Jacket","Engineering Monochrome",{"/hat 109386577934874"})
addPreset("Jacket","Engineering Blackout",{"/hat 86876330611930"})
addPreset("Jacket","Black Jacket Around Waist",{"/hat 125437867529388"})
addPreset("Jacket","Y2K Hugging Waist Jacket Black",{"/hat 124220413922160"})
addPreset("Jacket","Black Jacket Around Waist",{"/hat 9210584093"})
addPreset("Jacket","White Jacket Around Waist",{"/hat 88099491252719"})
addPreset("Jacket","Black-Flannel-Shirt-Tied-Fall-Comfy-Emo-Y2K",{"/hat 140080096339528"})
addPreset("Jacket","Red-Flannel-Shirt-Tied-Fall-Comfy-Emo-Y2K-Autumn",{"/hat 77720417440650"})
addPreset("Jacket","Urban Bunny Red",{"/hat 110058890023560"})
addPreset("Jacket","Urban Bunny Black",{"/hat 116337262752407"})
addPreset("Jacket","Urban Bunny Gray",{"/hat 126153145228235"})
addPreset("Jacket","cross puffer vest",{"/hat 72453946777312"})



-- Kaos Hitam

addPreset("Kaos","T-Shirt with Chain (gw pake)",{"/hat 123936072348905"}) 
addPreset("Kaos","Graphic SVDDENLY T-Shirt Black w/ Cross Chain",{"/hat 99351090489289"})
addPreset("Kaos","Black Future",{"/hat 111576916780803"})
addPreset("Kaos","Autisme",{"/hat 107033184055711"})
addPreset("Kaos","Hellfire Guts",{"/hat 18736295207"})
addPreset("Kaos","Hellfire Hitam",{"/hat 18736386171"})
addPreset("Kaos","Tuhan Cinta Dunia",{"/hat 101251974102847"})
addPreset("Kaos","Chrome Heart",{"/hat 119294311549713"})
addPreset("Kaos","SCT Camo",{"/hat 123933413999942"})
addPreset("Kaos","SCT 1",{"/hat 124801656661850"})
addPreset("Kaos","SCT 2",{"/hat 96162549907118"})
addPreset("Kaos","SCT 3",{"/hat 118789741231674"})
addPreset("Kaos","SCT 4",{"/hat 98958170373159"})
addPreset("Kaos","Mewah + Chain",{"/hat 18866259255"})
addPreset("Kaos","Supreme",{"/hat 90536031737308"})
addPreset("Kaos","Floral-adidas",{"/hat 18187288259"})
addPreset("Kaos","Black Adidas",{"/hat 15512960296"})
addPreset("Kaos","Adidas Ungu",{"/hat 18203393196"})
addPreset("Kaos","LA-Sport-Jersey Putih",{"/hat 74644336188040"})
addPreset("Kaos","LA-Sport-Jersey Hitam",{"/hat 120892355065438"})
addPreset("Kaos","NEWYORK Kuning",{"/hat 78943492521729"})
addPreset("kaos","NEWYORK Hitam",{"/hat 111576916780803"})
addPreset("Kaos","NEWYORK Merah",{"/hat 111202422466045"})
addPreset("Kaos","Cuban + Chain",{"/hat 88022186118780"})
addPreset("Kaos","T-SHIRT PUTIH",{"/hat 75094031027369"})
addPreset("Kaos","y2k Pierced Tongue",{"/hat 80596145225426"})
addPreset("Kaos","Kantor Hitam",{"/hat 133331049150205"})
addPreset("Kaos","Kobe Bryant Hitam",{"/hat 71537163372112"})




addPreset("Sweater","Flowers b",{"/hat 14911909756"})
addPreset("Sweater","Preface Stars Trilogy Zip-Up",{"/hat 104415181457039"})
addPreset("Sweater","adidas Denim",{"/hat 16891303372"})
addPreset("Sweater","Y2k Fashion",{"/hat 75502962832524"})
addPreset("Sweater","JONCLOTHING White",{"/hat 84483315587953"})
addPreset("Sweater","JONCLOTHING Black",{"/hat 93672333660792"})
addPreset("Sweater","JONCLOTHING ABU",{"/hat 105289744031676"})
addPreset("Sweater","JONCLOTHING 1",{"/hat 121262878766215"})
addPreset("Sweater","JONCLOTHING 2",{"/hat 110435499104308"})
addPreset("Sweater","JONCLOTHING 3",{"/hat 85341414553457"})
addPreset("Sweater","DRESSX Dundas",{"/hat 11821884835"})
addPreset("Sweater","001",{"/hat 77221665909659"})
addPreset("Sweater","Messy Knitted Skull Head",{"/hat 14912025341"})
addPreset("Sweater","MARCHÉE - Deep Red",{"/hat 131068832811436"})
addPreset("Sweater","MARCHÉE - Ash Grey",{"/hat 128012920767502"})
addPreset("Sweater","MARCHÉE - Urban Grunge ",{"/hat 107713693068200"})
addPreset("Sweater","MARCHÉE - Sad Bacon",{"/hat 100712092049086"})
addPreset("Sweater","Y2k Fashion",{"/hat 108087753152776"})
addPreset("Sweater","Vintage Style",{"/hat 92319431648622"})
addPreset("Sweater","Y2k Fashion Supreme",{"/hat 105538561748026"})
addPreset("Sweater","MARCHÉE - Washed Blue",{"/hat 139419220635619"})
addPreset("Sweater","Rock Band ",{"/hat 9448504499"})
addPreset("Sweater","Spider Black",{"/hat 18864532161"})
addPreset("Sweater","courtside ",{"/hat 75457309110424"})
addPreset("Sweater","Black & White Stitches",{"/hat 16478562189"})
addPreset("Sweater","White & Black Stitches",{"/hat 16478590766"})
addPreset("Sweater","Black Skeleton",{"/hat 137516104773557"})
addPreset("Sweater","Black Sp5der",{"/hat 111988334376839"})
addPreset("Sweater","MIRACLE GOD",{"/hat 100723094497267"})
addPreset("Sweater","Halloween Orange",{"/hat 15053837171"})



addPreset("Tanktop","BALLER",{"/hat 106962952494700"})
addPreset("Tanktop","Baller Skull White",{"/hat 130754551716327"})
addPreset("Tanktop","Street Force Ripped",{"/hat 109600137488427"})
addPreset("Tanktop","BALLER DISTRESSED",{"/hat 73094911932606"})
addPreset("Tanktop","White Ripped",{"/hat 99550714092058"})
addPreset("Tanktop","California Vibes",{"/hat 74937496439485"})
addPreset("Tanktop","Putih Polos",{"/hat 17120506795"})
addPreset("Tanktop","Putih + Salib",{"/hat 17120511517"})
addPreset("Tanktop","Black + Salib",{"/hat 17120526686"})
addPreset("Tanktop","Putih + Salib",{"/hat 17120511517"})

--=====================================
-- SUBTAB BUTTON BAR
--=====================================
local subScroll = Instance.new("ScrollingFrame", TitanTab)
subScroll.Size = UDim2.new(1,-20,0,36)
subScroll.Position = UDim2.new(0,10,0,90)
subScroll.BackgroundTransparency = 1
subScroll.ScrollBarThickness = 4
subScroll.ScrollingDirection = Enum.ScrollingDirection.X

local layout = Instance.new("UIListLayout", subScroll)
layout.Padding = UDim.new(0,8)
layout.FillDirection = Enum.FillDirection.Horizontal
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	subScroll.CanvasSize = UDim2.new(0, layout.AbsoluteContentSize.X + 10, 0, 0)
end)

for _, name in ipairs(subTabs) do
	local b = Instance.new("TextButton")
	b.Name = name
	b.Size = UDim2.new(0,80,1,0)
	b.BackgroundColor3 = Color3.fromRGB(90,0,0)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	b.Text = name
	Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)
	b.Parent = subScroll
	subTabButtons[name] = b
end

--=====================================
-- CONTENT AREA
--=====================================
local content = Instance.new("Frame", TitanTab)
content.Size = UDim2.new(1,-20,1,-175)
content.Position = UDim2.new(0,10,0,135)
content.BackgroundTransparency = 1

local scroll = Instance.new("ScrollingFrame", content)
scroll.Size = UDim2.new(1,0,1,-40)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6

--=====================================
-- BUTTON CREATOR
--=====================================
local function makeButton(tabName, data)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,0,0,34)
	b.BackgroundColor3 = Color3.fromRGB(90,0,0)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 13
	b.TextWrapped = true
	b.Text = data.name
	Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)

	b.MouseButton1Click:Connect(function()
		local key = tabName.."_"..data.name
		local count = 0
		for _ in pairs(activeButtons) do count+=1 end
		if not activeButtons[key] and count >= MAX_ACTIVE then
			hud.Text = "❌ Maksimal 10 aktif! Matikan satu dulu."
			return
		end
		if activeButtons[key] then
			activeButtons[key] = nil
			b.BackgroundColor3 = Color3.fromRGB(90,0,0)
		else
			for _,cmd in ipairs(data.cmd) do
				sendChat(cmd)
				task.wait(0.1)
			end
			activeButtons[key] = {name=data.name, tab=tabName}
			b.BackgroundColor3 = Color3.fromRGB(0,180,0)
		end

		local names = {}
		for _,v in pairs(activeButtons) do
			table.insert(names, v.name.." ("..v.tab..")")
		end
		updateHUD(names)
	end)
	return b
end

--=====================================
-- SEARCH + PAGINATION
--=====================================
local searchBox = Instance.new("TextBox", content)
searchBox.PlaceholderText = "🔍Search..."
searchBox.Size = UDim2.new(0.30,0,0,32)
searchBox.Position = UDim2.new(0.21,0,1,-36)
searchBox.BackgroundColor3 = Color3.fromRGB(60,0,0)
searchBox.TextColor3 = Color3.new(1,1,1)
searchBox.Font = Enum.Font.GothamBold
searchBox.TextSize = 14
searchBox.ClearTextOnFocus = false
searchBox.BorderSizePixel = 0
searchBox.Text = "" -- 🧩 fix tulisan 'TextBox' muncul
Instance.new("UICorner",searchBox).CornerRadius = UDim.new(0,8)

local btnPrev = Instance.new("TextButton", content)
btnPrev.Text = "◀ Prev"
btnPrev.Size = UDim2.new(0.2,0,0,32)
btnPrev.Position = UDim2.new(0.0,0,1,-36)
btnPrev.BackgroundColor3 = Color3.fromRGB(120,0,0)
btnPrev.TextColor3 = Color3.new(1,1,1)
btnPrev.Font = Enum.Font.GothamBold
btnPrev.TextSize = 14
Instance.new("UICorner",btnPrev).CornerRadius = UDim.new(0,8)

local btnNext = Instance.new("TextButton", content)
btnNext.Text = "Next ▶"
btnNext.Size = UDim2.new(0.2,0,0,32)
btnNext.Position = UDim2.new(0.52,0,1,-36)
btnNext.BackgroundColor3 = Color3.fromRGB(120,0,0)
btnNext.TextColor3 = Color3.new(1,1,1)
btnNext.Font = Enum.Font.GothamBold
btnNext.TextSize = 14
Instance.new("UICorner",btnNext).CornerRadius = UDim.new(0,8)



----------------------------------------------------------------
-- 📏 SIZE BUTTON (/size 0.3)
----------------------------------------------------------------
local sizeBtn = Instance.new("TextButton", TitanTab)
sizeBtn.Size = UDim2.new(0.2, 0, 0, 32)
sizeBtn.Position = UDim2.new(0.72, 0, 0, 298) -- sejajar dengan tombol auto RE
sizeBtn.Text = "📏 SIZE 0.3"
sizeBtn.Font = Enum.Font.GothamBlack
sizeBtn.TextSize = 14
sizeBtn.TextColor3 = Color3.fromRGB(255,255,255)
sizeBtn.BackgroundColor3 = Color3.fromRGB(120,0,0)
Instance.new("UICorner", sizeBtn).CornerRadius = UDim.new(0,8)

sizeBtn.MouseButton1Click:Connect(function()
	sendChatCommand("/size 0.3")
	print("[VALHALLA] 📏 /size 0.3 dikirim ke command bar.")
end)


--=====================================
-- RENDER SYSTEM (FIXED)
--=====================================
local ITEMS_PER_PAGE = 100
local page, totalPages = 1, 1
local currentFilterTab = nil

local function getAllItems()
	local all = {}
	for tabName, list in pairs(presets) do
		for _, item in ipairs(list) do
			table.insert(all, {tab=tabName, name=item.name, cmd=item.cmd})
		end
	end
	return all
end

local function renderPage(filter)
	scroll:ClearAllChildren()
	local grid = Instance.new("UIGridLayout", scroll)
	grid.CellSize = UDim2.new(0.32, -6, 0, 34)
	grid.CellPadding = UDim2.new(0,6,0,6)
	scroll.CanvasSize = UDim2.new(0,0,0,0)

	local all = getAllItems()
	local items = {}
	for _,d in ipairs(all) do
		if (not currentFilterTab or d.tab == currentFilterTab) then
			if not filter or filter == "" or string.find(d.name:lower(), filter:lower()) then
				table.insert(items, d)
			end
		end
	end

	totalPages = math.max(1, math.ceil(#items / ITEMS_PER_PAGE))
	page = math.clamp(page, 1, totalPages)
	local start = (page - 1) * ITEMS_PER_PAGE + 1
	local finish = math.min(page * ITEMS_PER_PAGE, #items)

	for i = start, finish do
		local d = items[i]
		if d then
			task.defer(function()
				local b = makeButton(d.tab, d)
				b.Parent = scroll
				if activeButtons[d.tab.."_"..d.name] then
					b.BackgroundColor3 = Color3.fromRGB(0,180,0)
				end
			end)
		end
	end

	task.defer(function()
		scroll.CanvasSize = UDim2.new(0,0,0,grid.AbsoluteContentSize.Y + 10)
	end)

	hud.Text = string.format("📄 Page %d / %d  |  Total Preset: %d%s",
		page, totalPages, #items, currentFilterTab and ("  |  Tab: "..currentFilterTab) or "")
end

for name,btn in pairs(subTabButtons) do
	btn.MouseButton1Click:Connect(function()
		for _,b in pairs(subTabButtons) do b.BackgroundColor3 = Color3.fromRGB(90,0,0) end
		btn.BackgroundColor3 = Color3.fromRGB(255,40,40)
		currentFilterTab = (currentFilterTab == name) and nil or name
		page = 1
		renderPage(searchBox.Text)
	end)
end

btnPrev.MouseButton1Click:Connect(function()
	page = math.max(1, page - 1)
	renderPage(searchBox.Text)
end)
btnNext.MouseButton1Click:Connect(function()
	page = math.min(totalPages, page + 1)
	renderPage(searchBox.Text)
end)
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	page = 1
	renderPage(searchBox.Text)
end)

task.defer(function() renderPage("") end)

--=====================================
-- BOTTOM CONTROL BUTTONS
--=====================================
local bottom = Instance.new("Frame", TitanTab)
bottom.Size = UDim2.new(1,-20,0,36)
bottom.Position = UDim2.new(0,10,1,-36)
bottom.BackgroundTransparency = 1

local function mkCtrl(txt)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0.24,-2,1,0)
	b.BackgroundColor3 = Color3.fromRGB(120,0,0)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 15
	b.Text = txt
	b.BorderSizePixel = 0
	Instance.new("UICorner",b).CornerRadius = UDim.new(0,8)
	b.Parent = bottom
	return b
end

--local refreshBtn = mkCtrl("🔄 Refresh")
local clearBtn   = mkCtrl("🧹 Clear")
--local applyBtn   = mkCtrl("⚡ Apply")
local resetBtn   = mkCtrl("♻️ Reset")

refreshBtn.Position = UDim2.new(0.0,0,0,0)
clearBtn.Position   = UDim2.new(0.25,0,-0.1,0)
applyBtn.Position   = UDim2.new(0.50,0,0,0)
resetBtn.Position   = UDim2.new(0.75,0,-0.1,0)

refreshBtn.MouseButton1Click:Connect(function() sendChat("/re") end)
clearBtn.MouseButton1Click:Connect(function()
	activeButtons = {}
	updateHUD({})
	renderPage(searchBox.Text)
end)
applyBtn.MouseButton1Click:Connect(function()
	for _,v in pairs(activeButtons) do
		for _,cmd in ipairs(v.cmd) do sendChat(cmd) end
	end
end)
resetBtn.MouseButton1Click:Connect(function()
	sendChat("/re")
	activeButtons = {}
	updateHUD({})
	renderPage(searchBox.Text)
end)

--=========================================
-- 🧠 UNIVERSAL SEND COMMAND FIX
--=========================================
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

function sendChat(msg)
	local gui = LocalPlayer:WaitForChild("PlayerGui")
	local box = nil

	-- 🔍 1️⃣ Cari TextBox yang kemungkinan adalah kolom command
	for _, v in ipairs(gui:GetDescendants()) do
		if v:IsA("TextBox") and v.PlaceholderText and v.PlaceholderText:lower():find("command") then
			box = v
			break
		end
	end

	if not box then
		warn("[VALHALLA] ❌ Kolom command tidak ditemukan.")
		return
	end

	-- isi text
	box:CaptureFocus()
	box.Text = msg
	task.wait(0.1)

	-----------------------------------------------------
	-- ⚙️ 2️⃣ Coba cara 1: Simulasi ENTER
	-----------------------------------------------------
	VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
	task.wait(0.05)
	VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)

	-----------------------------------------------------
	-- ⚙️ 3️⃣ Coba cara 2: Jalankan fungsi internal "Submit" atau "Execute"
	-----------------------------------------------------
	pcall(function()
		for _, s in ipairs(box.Parent:GetDescendants()) do
			if s:IsA("LocalScript") and s.Name:lower():find("command") then
				local env = getsenv(s)
				if env then
					if type(env.Submit) == "function" then
						env.Submit(msg)
						print("[VALHALLA] ✅ Submit() triggered")
						break
					elseif type(env.ExecuteCommand) == "function" then
						env.ExecuteCommand(msg)
						print("[VALHALLA] ✅ ExecuteCommand() triggered")
						break
					elseif type(env.RunCommand) == "function" then
						env.RunCommand(msg)
						print("[VALHALLA] ✅ RunCommand() triggered")
						break
					end
				end
			end
		end
	end)

	-----------------------------------------------------
	-- ⚙️ 4️⃣ Coba cara 3: Jalankan event bawaan “CommandEvent”
	-----------------------------------------------------
	pcall(function()
		for _, obj in ipairs(gui:GetDescendants()) do
			if obj:IsA("RemoteEvent") and obj.Name:lower():find("command") then
				obj:FireServer(msg)
				print("[VALHALLA] ✅ CommandEvent fired")
				break
			end
		end
	end)

	box:ReleaseFocus()
end


----------------------------------------------------------------
-- 🌀 AUTO /RE LOOP BUTTON — FINAL FIX (STOP ON GUI CLOSE)
----------------------------------------------------------------
local autoRE = false
local loopThread = nil

local autoReBtn = Instance.new("TextButton", TitanTab)
autoReBtn.Size = UDim2.new(0.25, -4, 0, 36)
autoReBtn.Position = UDim2.new(0.02, 0, 0, 335)
autoReBtn.Text = "🔁 RE: OFF"
autoReBtn.Font = Enum.Font.GothamBlack
autoReBtn.TextSize = 14
autoReBtn.TextColor3 = Color3.fromRGB(255,255,255)
autoReBtn.BackgroundColor3 = Color3.fromRGB(100,0,0)
Instance.new("UICorner", autoReBtn).CornerRadius = UDim.new(0,8)

-- 🔘 Fungsi start / stop
local function startAutoRe()
	autoRE = true
	autoReBtn.Text = "🔁 RE: ON"
	autoReBtn.BackgroundColor3 = Color3.fromRGB(0,120,0)

	loopThread = task.spawn(function()
		while autoRE do
			sendChatCommand("/re") -- tetap pakai function kamu yang udah benar
			task.wait(8) -- delay 2 detik antar /re
		end
	end)
end

local function stopAutoRe(reason)
	if not autoRE then return end
	autoRE = false
	autoReBtn.Text = "🔁 RE: OFF"
	autoReBtn.BackgroundColor3 = Color3.fromRGB(100,0,0)
	print("[VALHALLA] 📴 Auto /re dimatikan" .. (reason and " ("..reason..")" or ""))
end

-- Tombol toggle
autoReBtn.MouseButton1Click:Connect(function()
	if autoRE then
		stopAutoRe("manual toggle")
	else
		startAutoRe()
	end
end)

-- Auto stop saat GUI ditutup
TitanTab:GetPropertyChangedSignal("Visible"):Connect(function()
	if not TitanTab.Visible and autoRE then
		stopAutoRe("GUI ditutup")
	end
end)

-- Auto stop kalau GUI dihapus dari parent (antisipasi destroy)
TitanTab.AncestryChanged:Connect(function(_, parent)
	if not parent and autoRE then
		stopAutoRe("GUI dihapus")
	end
end)



----------------------------------------------------------------
-- 🌀 /re ke Chat Publik (langsung terkirim)
----------------------------------------------------------------
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")

local function sendPublicChat(msg)
	task.spawn(function()
		local sent = false

		-- 1) TextChatService: RBXGeneral (baru)
		local channels = TextChatService:FindFirstChild("TextChannels")
		if channels then
			local general = channels:FindFirstChild("RBXGeneral")
			if general then
				local ok = pcall(function() general:SendAsync(msg) end)
				if ok then sent = true end
			end
		end

		-- 2) TextChatService: target channel active bar
		if not sent and TextChatService.ChatInputBarConfiguration and TextChatService.ChatInputBarConfiguration.TargetTextChannel then
			local ok = pcall(function()
				TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(msg)
			end)
			if ok then sent = true end
		end

		-- 3) Legacy chat (DefaultChatSystemChatEvents)
		if not sent then
			local dcs = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
			if dcs and dcs:FindFirstChild("SayMessageRequest") then
				dcs.SayMessageRequest:FireServer(msg, "All")
				sent = true
			end
		end

		-- 4) Fallback terakhir: simulasi ketik & enter
		if not sent then
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Slash, false, game)
			task.wait(0.2)
			VirtualInputManager:SendTextInput(msg)
			task.wait(0.05)
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
		end
	end)
end

-- ===== Tombol di TitanTab =====
local publicReBtn = Instance.new("TextButton", TitanTab)
publicReBtn.Size = UDim2.new(0.25, -4, 0, 36)
publicReBtn.Position = UDim2.new(0.49, 0, 1, -39) -- adjust posisinya sesuai layout
publicReBtn.BackgroundColor3 = Color3.fromRGB(160, 0, 0)
publicReBtn.TextColor3 = Color3.new(1,1,1)
publicReBtn.Font = Enum.Font.GothamBold
publicReBtn.TextSize = 16
publicReBtn.Text = "💬RE(PB)"
publicReBtn.BorderSizePixel = 0
Instance.new("UICorner", publicReBtn).CornerRadius = UDim.new(0,8)

publicReBtn.MouseButton1Click:Connect(function()
	sendPublicChat("/re")
end)





--=====================================
-- 👕 VALHALLA V.1 — TAB AURA (AURA, Fire & Particles Manager - Command Mode)
--=====================================

if tabs["Aura"] then
	pcall(function() tabs["Aura"]:Destroy() end)
	tabs["Aura"] = nil
end

local AuraTab = createContentFrame("Aura")
tabs["Aura"] = AuraTab
CreateTabButton("AURA", 5, "Aura")

local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--=====================================
-- 🧠 Kirim lewat kolom COMMAND VIP
--=====================================
local function sendChat(cmd)
	task.spawn(function()
		local gui = LocalPlayer:WaitForChild("PlayerGui")
		local commandBox = nil

		-- cari kolom Command bawaan VIP / Panel
		for _, v in ipairs(gui:GetDescendants()) do
			if v:IsA("TextBox") and v.PlaceholderText and v.PlaceholderText:lower():find("command") then
				commandBox = v
				break
			end
		end

		if commandBox then
			commandBox:CaptureFocus()
			commandBox.Text = cmd
			task.wait(0.1)
			VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
			task.wait(0.05)
			VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
			commandBox:ReleaseFocus()
			print("[VALHALLA] ✅ Command executed:", cmd)
		else
			-- fallback: kirim ke chat publik kalau command box gak ketemu
			local chatEvent = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
			if chatEvent and chatEvent:FindFirstChild("SayMessageRequest") then
				chatEvent.SayMessageRequest:FireServer(cmd, "All")
				warn("[VALHALLA] ⚠️ Kolom command tidak ditemukan, fallback ke chat publik.")
			end
		end
	end)
end

--=====================================
-- 🧩 HUD
--=====================================
local title = Instance.new("TextLabel", AuraTab)
title.Size = UDim2.new(1, -20, 0, 34)
title.Position = UDim2.new(0, 10, 0, 10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Text = "👕 AURA — Fire & Particles"
title.TextXAlignment = Enum.TextXAlignment.Left

-- Input Catalog ID
local inputBox = Instance.new("TextBox", AuraTab)
inputBox.Size = UDim2.new(1, -20, 0, 34)
inputBox.Position = UDim2.new(0, 10, 0, 50)
inputBox.PlaceholderText = "Masukan ID Katalog"
inputBox.Font = Enum.Font.GothamBold
inputBox.TextSize = 16
inputBox.TextColor3 = Color3.fromRGB(255,255,255)
inputBox.BackgroundColor3 = Color3.fromRGB(60,0,0)
inputBox.BorderSizePixel = 0
newCorner(inputBox,8)

-- Helper buat tombol
local function createBtn(txt, x, y, color)
	local btn = Instance.new("TextButton", AuraTab)
	btn.Size = UDim2.new(0.3, -8, 0, 32)
	btn.Position = UDim2.new(x, 8, 0, y)
	btn.Text = txt
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 15
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.BackgroundColor3 = color or Color3.fromRGB(100,0,0)
	btn.BorderSizePixel = 0
	newCorner(btn,8)
	return btn
end

-- Tombol Baris 1
local checkBtn   = createBtn("🔍 Check Item", 0, 100, Color3.fromRGB(120,0,0))
local useBtn     = createBtn("💎 Use (/hat)", 0.34, 100, Color3.fromRGB(90,0,0))
local refreshBtn = createBtn("🔄 Refresh (/re)", 0.68, 100, Color3.fromRGB(140,0,0))

-- Baris 2 — Fire Controls
local colorBox = Instance.new("TextBox", AuraTab)
colorBox.Size = UDim2.new(0.3, -8, 0, 30)
colorBox.Position = UDim2.new(0, 8, 0, 140)
colorBox.PlaceholderText = "Kode Fire (1001)"
colorBox.Font = Enum.Font.GothamBold
colorBox.TextSize = 14
colorBox.TextColor3 = Color3.fromRGB(255,255,255)
colorBox.BackgroundColor3 = Color3.fromRGB(40,0,0)
colorBox.BorderSizePixel = 0
newCorner(colorBox,8)

local fireBtn = createBtn("🔥 Fire", 0.34, 140, Color3.fromRGB(180,0,0))
local unfireBtn = createBtn("❌ Unfire", 0.68, 140, Color3.fromRGB(100,0,0))

-- Baris 3 — Particles Controls
local particlesBox = Instance.new("TextBox", AuraTab)
particlesBox.Size = UDim2.new(0.3, -8, 0, 30)
particlesBox.Position = UDim2.new(0, 8, 0, 180)
particlesBox.PlaceholderText = "Kode Particle (1001)"
particlesBox.Font = Enum.Font.GothamBold
particlesBox.TextSize = 14
particlesBox.TextColor3 = Color3.fromRGB(255,255,255)
particlesBox.BackgroundColor3 = Color3.fromRGB(40,0,0)
particlesBox.BorderSizePixel = 0
newCorner(particlesBox,8)

local particlesBtn = createBtn("✨ Particles", 0.34, 180, Color3.fromRGB(180,0,0))
local unparticlesBtn = createBtn("❌ Unparticles", 0.68, 180, Color3.fromRGB(100,0,0))

-- Status Info
local statusLabel = Instance.new("TextLabel", AuraTab)
statusLabel.Size = UDim2.new(1, -20, 0, 90)
statusLabel.Position = UDim2.new(0, 10, 0, 225)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 14
statusLabel.TextColor3 = Color3.fromRGB(200,200,200)
statusLabel.TextWrapped = true
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.TextYAlignment = Enum.TextYAlignment.Top
statusLabel.Text = "💬 Waiting for input..."

--=====================================
-- 🧩 Tombol Logic
--=====================================
checkBtn.MouseButton1Click:Connect(function()
	local text = inputBox.Text:gsub("%s+", " ")
	if text == "" then
		statusLabel.Text = "⚠️ Masukkan ID dulu."
		return
	end
	local found = {}
	for id in string.gmatch(text, "%S+") do
		local nid = tonumber(id)
		if nid then
			local ok, info = pcall(function() return MarketplaceService:GetProductInfo(nid) end)
			if ok and info then
				table.insert(found, info.Name .. " ("..nid..")")
			end
		end
	end
	if #found > 0 then
		statusLabel.Text = "✅ Ditemukan:\n" .. table.concat(found, ",\n")
	else
		statusLabel.Text = "❌ Tidak ditemukan item valid."
	end
end)

useBtn.MouseButton1Click:Connect(function()
	local text = inputBox.Text:gsub("%s+", " ")
	if text == "" then 
		statusLabel.Text = "⚠️ Masukkan ID dulu."; 
		return 
	end
	sendChat("/hat " .. text)
	statusLabel.Text = "💬 /hat dikirim ke Command."
end)

refreshBtn.MouseButton1Click:Connect(function()
	sendChat("/re")
	statusLabel.Text = "🔄 /re dikirim ke Command."
end)

fireBtn.MouseButton1Click:Connect(function()
	local code = colorBox.Text ~= "" and colorBox.Text or "1001"
	sendChat("/fire " .. code)
	statusLabel.Text = "🔥 Fire aktif ("..code..")"
end)

unfireBtn.MouseButton1Click:Connect(function()
	sendChat("/unfire")
	statusLabel.Text = "❌ Fire dimatikan."
end)

particlesBtn.MouseButton1Click:Connect(function()
	local code = particlesBox.Text ~= "" and particlesBox.Text or "1001"
	sendChat("/particles " .. code)
	statusLabel.Text = "✨ Particles aktif ("..code..")"
end)

unparticlesBtn.MouseButton1Click:Connect(function()
	sendChat("/unparticles")
	statusLabel.Text = "❌ Particles dimatikan."
end)

--=====================================
-- ⚔️ VALHALLA V.5.5 — CHEAT TAB (Scroll + Fixed Footer + Follow Section)
--=====================================

if tabs["Cheat"] then
	pcall(function() tabs["Cheat"]:Destroy() end)
	tabs["Cheat"] = nil
end

local CheatTab = createContentFrame("Cheat")
tabs["Cheat"] = CheatTab
CreateTabButton("CHEAT", 7, "Cheat")

-- ⚙️ Services
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

-- 🧠 States
local states = {
	infjump=false, noclip=false, fly=false, god=false,
	ragdoll=false, shift=false, afk=false, fling=false, follow=false
}

local walkspeed, flyspeed = 16, 60
local flyConn, noclipConn, godConn, jumpConn, flingConn
local bodyVel, bodyGyro

--============================
-- 🧭 HEADER
--============================
local title = Instance.new("TextLabel", CheatTab)
title.Size = UDim2.new(1,-20,0,34)
title.Position = UDim2.new(0,10,0,10)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "⚔️ Cheat Manager"

local hud = Instance.new("TextLabel", CheatTab)
hud.Size = UDim2.new(1,-20,0,22)
hud.Position = UDim2.new(0,10,0,44)
hud.BackgroundTransparency = 1
hud.Font = Enum.Font.GothamBold
hud.TextSize = 14
hud.TextColor3 = Color3.fromRGB(200,255,200)
hud.TextXAlignment = Enum.TextXAlignment.Left
hud.Text = "🔹 Active: None"

local function updateHUD()
	local active = {}
	for k,v in pairs(states) do
		if v then
			local map = {
				infjump="Infinite Jump", noclip="Noclip", fly="Fly",
				god="God Mode", ragdoll="Anti-Ragdoll", shift="ShiftLock",
				afk="AFK", fling="Fling", follow="Follow"
			}
			table.insert(active,map[k])
		end
	end
	hud.Text = #active==0 and "🔹 Active: None" or "🔹 Active: "..table.concat(active,", ")
end

--============================
-- 📜 SCROLL AREA (semua tombol cheat)
--============================
local scroll = Instance.new("ScrollingFrame", CheatTab)
scroll.Size = UDim2.new(1,-20,1,-210)
scroll.Position = UDim2.new(0,10,0,80)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local layout = Instance.new("UIGridLayout", scroll)
layout.CellPadding = UDim2.new(0, 10, 0, 10)
layout.CellSize = UDim2.new(0.48, 0, 0, 36)

local function setBtnColor(btn, state)
	btn.BackgroundColor3 = state and Color3.fromRGB(0,180,0) or Color3.fromRGB(90,0,0)
end

local function mkBtn(text)
	local b = Instance.new("TextButton", scroll)
	b.BackgroundColor3 = Color3.fromRGB(90,0,0)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 16
	b.TextColor3 = Color3.new(1,1,1)
	b.Text = text
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

--============================
-- 🦘 Infinite Jump
--============================
local infBtn = mkBtn("🦘 Infinite Jump")
infBtn.MouseButton1Click:Connect(function()
	states.infjump = not states.infjump
	if jumpConn then jumpConn:Disconnect(); jumpConn=nil end
	if states.infjump then
		jumpConn = UIS.JumpRequest:Connect(function()
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end)
	end
	setBtnColor(infBtn, states.infjump)
	updateHUD()
end)

--============================
-- 🚷 Noclip
--============================
local noclipBtn = mkBtn("🚷 Noclip")
noclipBtn.MouseButton1Click:Connect(function()
	states.noclip = not states.noclip
	setBtnColor(noclipBtn, states.noclip)
	updateHUD()
	if states.noclip then
		noclipConn = RunService.Stepped:Connect(function()
			for _,v in pairs(player.Character:GetDescendants()) do
				if v:IsA("BasePart") then v.CanCollide=false end
			end
		end)
	else
		if noclipConn then noclipConn:Disconnect();noclipConn=nil end
		for _,v in pairs(player.Character:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide=true end
		end
	end
end)

--============================
-- 🪽 Fly
--============================
local flyBtn = mkBtn("🪽 Fly Mode")
local function stopFly()
	if flyConn then flyConn:Disconnect() flyConn=nil end
	if bodyVel then bodyVel:Destroy() bodyVel=nil end
	if bodyGyro then bodyGyro:Destroy() bodyGyro=nil end
end
local function startFly()
	stopFly()
	local root = player.Character:WaitForChild("HumanoidRootPart")
	bodyVel = Instance.new("BodyVelocity", root)
	bodyGyro = Instance.new("BodyGyro", root)
	bodyVel.MaxForce = Vector3.new(9e9,9e9,9e9)
	bodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
	flyConn = RunService.RenderStepped:Connect(function()
		local move = Vector3.zero
		local cam = workspace.CurrentCamera
		if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end
		bodyVel.Velocity = move.Magnitude>0 and move.Unit*flyspeed or Vector3.zero
		bodyGyro.CFrame = cam.CFrame
	end)
end
flyBtn.MouseButton1Click:Connect(function()
	states.fly = not states.fly
	if states.fly then startFly() else stopFly() end
	setBtnColor(flyBtn, states.fly)
	updateHUD()
end)

--============================
-- 🛡 God Mode
--============================
local godBtn = mkBtn("🛡 God Mode")
godBtn.MouseButton1Click:Connect(function()
	states.god = not states.god
	setBtnColor(godBtn, states.god)
	updateHUD()
	if states.god then
		godConn = RunService.Heartbeat:Connect(function()
			if humanoid and humanoid.Health < humanoid.MaxHealth then
				humanoid.Health = humanoid.MaxHealth
			end
		end)
	else
		if godConn then godConn:Disconnect();godConn=nil end
	end
end)

--============================
-- 🤸 Anti-Ragdoll
--============================
local ragBtn = mkBtn("🤸 Anti-Ragdoll")
ragBtn.MouseButton1Click:Connect(function()
	states.ragdoll = not states.ragdoll
	setBtnColor(ragBtn, states.ragdoll)
	updateHUD()
end)

--============================
-- 🎯 SHIFT LOCK (GUI Version - Stable)
--============================
local shiftBtn = mkBtn("🎯Shift Lock")

shiftBtn.MouseButton1Click:Connect(function()
	states.shift = not states.shift
	setBtnColor(shiftBtn, states.shift)
	updateHUD()

	local cam = workspace.CurrentCamera
	local char = player.Character or player.CharacterAdded:Wait()
	local hum = char:FindFirstChildOfClass("Humanoid")

	if states.shift then
		-- 🔒 Lock kamera dan nonaktifkan autorotate
		hum.AutoRotate = false
		cam.CameraType = Enum.CameraType.Custom
		UIS.MouseBehavior = Enum.MouseBehavior.LockCenter

		-- 🧭 Pastikan GUI tidak ganggu input mouse
		for _, gui in ipairs(player.PlayerGui:GetChildren()) do
			if gui:IsA("ScreenGui") then
				gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			end
		end
	else
		-- 🔓 Kembalikan seperti semula
		hum.AutoRotate = true
		UIS.MouseBehavior = Enum.MouseBehavior.Default
	end
end)


--============================
-- 💤 AFK
--============================
local afkBtn = mkBtn("💤 AFK Mode")
afkBtn.MouseButton1Click:Connect(function()
	states.afk = not states.afk
	setBtnColor(afkBtn, states.afk)
	updateHUD()
	if states.afk then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/hassanxzayn-lua/Anti-afk/main/antiafkbyhassanxzyn"))();
	end
end)

--============================
-- 💥 Fling Mode
--============================
local flingBtn = mkBtn("💥 Fling Mode")
local function stopFling()
	states.fling=false
	if flingConn then flingConn:Disconnect();flingConn=nil end
end
local function startFling()
	stopFling()
	states.fling=true
	flingConn = RunService.Heartbeat:Connect(function()
		local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		for _,v in ipairs(Players:GetPlayers()) do
			if v~=player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				local t=v.Character.HumanoidRootPart
				if (hrp.Position - t.Position).Magnitude < 12 then
					t.Velocity = t.Velocity + (t.Position - hrp.Position).Unit * 160
				end
			end
		end
	end)
end



flingBtn.MouseButton1Click:Connect(function()
	if states.fling then stopFling() else startFling() end
	setBtnColor(flingBtn, states.fling)
	updateHUD()
end)
updateHUD()





--============================
-- 🚶 FOLLOW SYSTEM (5 Sejajar, di Atas Speed Panel)
--============================
local followFrame = Instance.new("Frame", CheatTab)
followFrame.Size = UDim2.new(1, -20, 0, 36)
followFrame.Position = UDim2.new(0, 10, 1, -125)
followFrame.BackgroundTransparency = 1

local function mkFollowBtn(x, text, color)
	local b = Instance.new("TextButton", followFrame)
	b.Size = UDim2.new(0.19, -4, 1, 0)
	b.Position = UDim2.new(x, 0, 0, 0)
	b.BackgroundColor3 = color or Color3.fromRGB(90, 0, 0)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 15
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Text = text
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
	return b
end

-- Tombol baris
local normalFollowBtn = mkFollowBtn(0.00, "FLW", Color3.fromRGB(0,120,0))
local tpBackBtn       = mkFollowBtn(0.20, "TPB", Color3.fromRGB(120,80,0))
local tpLeftBtn       = mkFollowBtn(0.40, "TPL", Color3.fromRGB(100,80,0))
local tpRightBtn      = mkFollowBtn(0.60, "TPR", Color3.fromRGB(100,80,0))
local stopFollowBtn   = mkFollowBtn(0.80, "Stop", Color3.fromRGB(140,0,0))






----------------------------------------------------------------
-- FUNGSI FOLLOW / STOP
----------------------------------------------------------------
local followConn
local function stopFollow()
	states.follow = false
	if followConn then followConn:Disconnect() followConn = nil end
	setBtnColor(normalFollowBtn, false)
	setBtnColor(tpBackBtn, false)
	setBtnColor(tpLeftBtn, false)
	setBtnColor(tpRightBtn, false)
	updateHUD()
end

local function startFollow(mode)
	stopFollow()
	local target = _G.spyTarget
	if not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
		warn("[VALHALLA] Tidak ada target aktif dari SpyTab.")
		return
	end

	states.follow = true
	updateHUD()
	local myChar = player.Character or player.CharacterAdded:Wait()
	local myHum = myChar:WaitForChild("Humanoid")

	followConn = RunService.Heartbeat:Connect(function()
		if not states.follow or not target or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") then
			stopFollow()
			return
		end

		local targetHRP = target.Character.HumanoidRootPart
		local myHRP = myChar:FindFirstChild("HumanoidRootPart")
		if not myHRP then return end

		if mode == "normal" then
			myHum:MoveTo(targetHRP.Position + (targetHRP.CFrame.LookVector * -2.5))
		elseif mode == "tp_back" then
			myHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 2.5)
		elseif mode == "tp_left" then
			myHRP.CFrame = targetHRP.CFrame * CFrame.new(-2.5, 0, 0)
		elseif mode == "tp_right" then
			myHRP.CFrame = targetHRP.CFrame * CFrame.new(2.5, 0, 0)
		end
	end)

	local btn =
		mode == "normal" and normalFollowBtn or
		mode == "tp_back" and tpBackBtn or
		mode == "tp_left" and tpLeftBtn or
		mode == "tp_right" and tpRightBtn

	if btn then setBtnColor(btn, true) end
end

----------------------------------------------------------------
-- KONEKSI TOMBOL
----------------------------------------------------------------
normalFollowBtn.MouseButton1Click:Connect(function() startFollow("normal") end)
tpBackBtn.MouseButton1Click:Connect(function() startFollow("tp_back") end)
tpLeftBtn.MouseButton1Click:Connect(function() startFollow("tp_left") end)
tpRightBtn.MouseButton1Click:Connect(function() startFollow("tp_right") end)
stopFollowBtn.MouseButton1Click:Connect(stopFollow)


--============================
-- ⚙️ SPEED CONTROLS (Compact Layout + Classic Position)
--============================
local speedFrame = Instance.new("Frame", CheatTab)
speedFrame.Size = UDim2.new(1,-20,0,36)
speedFrame.Position = UDim2.new(0,10,1,-85)
speedFrame.BackgroundTransparency = 1

-- WalkSpeed
local minusW = Instance.new("TextButton", speedFrame)
minusW.Size = UDim2.new(0.08, 0, 1, 0)
minusW.Position = UDim2.new(0, 0, 0, 0)
minusW.Text = "-"
minusW.Font = Enum.Font.GothamBlack
minusW.TextSize = 20
minusW.TextColor3 = Color3.new(1,1,1)
minusW.BackgroundColor3 = Color3.fromRGB(120,0,0)
Instance.new("UICorner", minusW).CornerRadius = UDim.new(0,8)

local wsLabel = Instance.new("TextLabel", speedFrame)
wsLabel.Size = UDim2.new(0.32, 0, 1, 0)
wsLabel.Position = UDim2.new(0.09, 0, 0, 0)
wsLabel.BackgroundTransparency = 1
wsLabel.Font = Enum.Font.GothamBold
wsLabel.TextSize = 14
wsLabel.TextColor3 = Color3.fromRGB(255,255,255)
wsLabel.Text = "🏃 WalkSpeed: "..walkspeed

local plusW = minusW:Clone()
plusW.Text = "+"
plusW.Position = UDim2.new(0.42, 0, 0, 0)
plusW.Parent = speedFrame

-- FlySpeed
local minusF = minusW:Clone()
minusF.Position = UDim2.new(0.54, 0, 0, 0)
minusF.Parent = speedFrame

local fsLabel = wsLabel:Clone()
fsLabel.Position = UDim2.new(0.63, 0, 0, 0)
fsLabel.Text = "🕊️ FlySpeed: "..flyspeed
fsLabel.Parent = speedFrame

local plusF = plusW:Clone()
plusF.Position = UDim2.new(0.96, -10, 0, 0)
plusF.Parent = speedFrame

-- Update logic
local function updateSpeeds()
	wsLabel.Text = "🏃WalkSpeed: "..walkspeed
	fsLabel.Text = "🕊️FlySpeed: "..flyspeed
end

minusW.MouseButton1Click:Connect(function()
	walkspeed = math.max(10, walkspeed - 2)
	humanoid.WalkSpeed = walkspeed
	updateSpeeds()
end)
plusW.MouseButton1Click:Connect(function()
	walkspeed = math.min(200, walkspeed + 2)
	humanoid.WalkSpeed = walkspeed
	updateSpeeds()
end)
minusF.MouseButton1Click:Connect(function()
	flyspeed = math.max(10, flyspeed - 10)
	updateSpeeds()
end)
plusF.MouseButton1Click:Connect(function()
	flyspeed = math.min(300, flyspeed + 10)
	updateSpeeds()
end)

updateSpeeds()


--============================
-- 🔁 RESET FOOTER (Tetap di bawah)
--============================
local footerFrame = Instance.new("Frame", CheatTab)
footerFrame.Size = UDim2.new(1,-20,0,40)
footerFrame.Position = UDim2.new(0,10,1,-45)
footerFrame.BackgroundTransparency = 1

local resetBtn = Instance.new("TextButton", footerFrame)
resetBtn.Size = UDim2.new(1,0,1,-6)
resetBtn.Position = UDim2.new(0,0,0,0)
resetBtn.BackgroundColor3 = Color3.fromRGB(150,0,0)
resetBtn.Text = "🔁 RESET / RESPAWN"
resetBtn.Font = Enum.Font.GothamBlack
resetBtn.TextSize = 18
resetBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", resetBtn).CornerRadius = UDim.new(0,8)

resetBtn.MouseButton1Click:Connect(function()
	stopFollow()
	if flyConn then flyConn:Disconnect(); flyConn=nil end
	if flingConn then flingConn:Disconnect(); flingConn=nil end
	player:LoadCharacter()
	for k in pairs(states) do states[k]=false end
	updateHUD()
end)

updateSpeeds()
updateHUD()

--============================
-- 🧹 AUTO RESET FOLLOW SAAT GUI DITUTUP
--============================
CheatTab:GetPropertyChangedSignal("Visible"):Connect(function()
	if not CheatTab.Visible then
		stopFollow()
	end
end)

CheatTab.AncestryChanged:Connect(function(_, parent)
	if not parent then
		stopFollow()
	end
end)



----------------------------------------------------------------
-- 🎵 SOUND TRACKER — Steal Music ID (100% akurat)
----------------------------------------------------------------
local function createMusicStealer(parent)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -20, 0, 37)
    btn.Position = UDim2.new(0, 10, 0, 249)
    btn.Text = "🎵 STEAL PLAYING MUSIC"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(120,0,0)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

    btn.MouseButton1Click:Connect(function()
        local foundId = nil

        -- cari semua sound yang sedang dimainkan
        for _, obj in ipairs(game:GetDescendants()) do
            if obj:IsA("Sound") and obj.IsPlaying then
                local id = tonumber(obj.SoundId:match("%d+"))
                if id then
                    foundId = id
                    break
                end
            end
        end

        if not foundId then
            btn.Text = "❌ Tidak ada musik yang dimainkan"
            task.wait(1.2)
            btn.Text = "🎵 STEAL PLAYING MUSIC"
            return
        end

        -- copy ID musik
        setclipboard(tostring(foundId))

        btn.Text = "✅ Copied ID: "..foundId
        task.wait(1.6)
        btn.Text = "🎵 STEAL PLAYING MUSIC"
    end)
end

-- PASANG KE TAB CHEAT:
createMusicStealer(CheatTab)
