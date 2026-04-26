local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local ContentProvider = game:GetService("ContentProvider")

local player = Players.LocalPlayer
local name = player.Name
local id = player.UserId

-- cleanup
local old = CoreGui:FindFirstChild("HypX_UI")
if old then old:Destroy() end

-- gui
local gui = Instance.new("ScreenGui")
gui.Name = "HypX_UI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = CoreGui

------------------------------------------------
-- 🌑 BACKGROUND LAYER (dark overlay depth)
------------------------------------------------
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
bg.BackgroundTransparency = 1
bg.BorderSizePixel = 0
bg.Parent = gui

TweenService:Create(bg,
	TweenInfo.new(0.6),
	{BackgroundTransparency = 0.35}
):Play()

------------------------------------------------
-- 🖤 MAIN CARD
------------------------------------------------
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 360, 0, 92)
main.Position = UDim2.new(1, 420, 1, -70)
main.AnchorPoint = Vector2.new(1,1)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.BackgroundTransparency = 0.18
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0,24)

-- subtle stroke
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255,255,255)
stroke.Transparency = 0.88
stroke.Thickness = 1
stroke.Parent = main

-- soft white glow gradient (no color theme)
local grad = Instance.new("UIGradient")
grad.Rotation = 30
grad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(210,210,210)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))
}
grad.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0,0.98),
	NumberSequenceKeypoint.new(0.5,0.93),
	NumberSequenceKeypoint.new(1,0.98)
}
grad.Parent = main

------------------------------------------------
-- 👤 AVATAR
------------------------------------------------
local avatar = Instance.new("ImageLabel")
avatar.Size = UDim2.new(0,56,0,56)
avatar.Position = UDim2.new(0,18,0.5,0)
avatar.AnchorPoint = Vector2.new(0,0.5)
avatar.BackgroundTransparency = 1
avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..id.."&width=420&height=420&format=png"
avatar.Parent = main
Instance.new("UICorner", avatar).CornerRadius = UDim.new(1,0)

local ring = Instance.new("UIStroke")
ring.Color = Color3.fromRGB(255,255,255)
ring.Transparency = 0.85
ring.Thickness = 1.5
ring.Parent = avatar

------------------------------------------------
-- 📝 TEXT
------------------------------------------------
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-120,0,24)
title.Position = UDim2.new(0,90,0,16)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "HypX Loaded"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1,-120,0,20)
sub.Position = UDim2.new(0,90,0,44)
sub.BackgroundTransparency = 1
sub.Font = Enum.Font.Gotham
sub.Text = "Welcome back, "..name
sub.TextColor3 = Color3.fromRGB(180,180,180)
sub.TextSize = 13
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.Parent = main

------------------------------------------------
-- 🔊 SOUND (FIXED)
------------------------------------------------
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://9118828564"
sound.Volume = 1.6
sound.Parent = main

pcall(function()
	ContentProvider:PreloadAsync({sound})
end)

task.delay(0.05, function()
	sound:Play()
end)

------------------------------------------------
-- ✨ INTRO ANIMATION
------------------------------------------------
main.BackgroundTransparency = 1

TweenService:Create(main,
	TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
	{
		Position = UDim2.new(1,-24,1,-70),
		BackgroundTransparency = 0.18
	}
):Play()

avatar.Size = UDim2.new(0,0,0,0)
TweenService:Create(avatar,
	TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
	{Size = UDim2.new(0,56,0,56)}
):Play()

------------------------------------------------
-- 🌫️ subtle float
------------------------------------------------
task.spawn(function()
	while main.Parent do
		TweenService:Create(main,
			TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{Position = UDim2.new(1,-24,1,-72)}
		):Play()
		task.wait(3)

		TweenService:Create(main,
			TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{Position = UDim2.new(1,-24,1,-68)}
		):Play()
		task.wait(3)
	end
end)

------------------------------------------------
-- ❌ EXIT (3s)
------------------------------------------------
task.spawn(function()
	task.wait(3)

	TweenService:Create(bg,
		TweenInfo.new(0.5),
		{BackgroundTransparency = 1}
	):Play()

	TweenService:Create(main,
		TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{
			Position = UDim2.new(1,420,1,-70),
			BackgroundTransparency = 1
		}
	):Play()

	for _,v in ipairs(main:GetDescendants()) do
		if v:IsA("TextLabel") then
			TweenService:Create(v, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
		elseif v:IsA("ImageLabel") then
			TweenService:Create(v, TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
		elseif v:IsA("Frame") then
			TweenService:Create(v, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
		end
	end

	task.wait(0.7)
	gui:Destroy()
end)

print("HypX UI with Background Loaded")
