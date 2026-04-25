local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local playerName = player.Name

local logo = getcustomasset("C:\\Users\\acch0\\Desktop\\HypX Exec\\HypX.png")

-- Remove old UI
local old = CoreGui:FindFirstChild("HypX_Glassy")
if old then
	old:Destroy()
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "HypX_Glassy"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = CoreGui

-- Main
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 290, 0, 78)
main.Position = UDim2.new(0, 20, 1, 110)
main.AnchorPoint = Vector2.new(0,1)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.BackgroundTransparency = 0.18
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255,255,255)
stroke.Thickness = 1.3
stroke.Transparency = 0.55
stroke.Parent = main

-- Shine Gradient
local grad = Instance.new("UIGradient")
grad.Rotation = 35
grad.Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140,140,255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255))
}
grad.Transparency = NumberSequence.new{
	NumberSequenceKeypoint.new(0,0.95),
	NumberSequenceKeypoint.new(0.5,0.75),
	NumberSequenceKeypoint.new(1,0.95)
}
grad.Parent = main

-- Logo
local img = Instance.new("ImageLabel")
img.Size = UDim2.new(0,54,0,54)
img.Position = UDim2.new(0,12,0.5,0)
img.AnchorPoint = Vector2.new(0,0.5)
img.BackgroundTransparency = 1
img.Image = logo
img.Parent = main

Instance.new("UICorner", img).CornerRadius = UDim.new(0,10)

-- Text
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-78,0,24)
title.Position = UDim2.new(0,74,0,12)
title.BackgroundTransparency = 1
title.Font = Enum.Font.Code
title.Text = "HypX Loaded"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1,-78,0,18)
sub.Position = UDim2.new(0,74,0,40)
sub.BackgroundTransparency = 1
sub.Font = Enum.Font.Code
sub.Text = "Welcome back, "..playerName
sub.TextColor3 = Color3.fromRGB(220,220,220)
sub.TextSize = 12
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.Parent = main

-- Snow Effect
local snowFolder = Instance.new("Folder", gui)

local function makeSnow()
	for i = 1, 18 do
		local dot = Instance.new("Frame")
		dot.Size = UDim2.new(0, math.random(2,5), 0, math.random(2,5))
		dot.Position = UDim2.new(math.random(),0,-0.1,0)
		dot.BackgroundColor3 = Color3.fromRGB(255,255,255)
		dot.BorderSizePixel = 0
		dot.BackgroundTransparency = math.random(15,45)/100
		dot.Parent = snowFolder
		Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)

		local endX = math.random(-40,40)
		local speed = math.random(20,35)/10

		local tween = TweenService:Create(
			dot,
			TweenInfo.new(speed, Enum.EasingStyle.Linear),
			{Position = UDim2.new(dot.Position.X.Scale, endX, 1.1, 0)}
		)
		tween:Play()

		tween.Completed:Connect(function()
			dot:Destroy()
		end)
	end
end

task.spawn(function()
	while gui.Parent do
		makeSnow()
		task.wait(0.35)
	end
end)

-- Float animation
task.spawn(function()
	while main.Parent do
		TweenService:Create(
			main,
			TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{Position = UDim2.new(0,20,1,-24)}
		):Play()
		task.wait(1.6)

		TweenService:Create(
			main,
			TweenInfo.new(1.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{Position = UDim2.new(0,20,1,-18)}
		):Play()
		task.wait(1.6)
	end
end)

-- Logo pulse
task.spawn(function()
	while img.Parent do
		TweenService:Create(img,TweenInfo.new(0.8),{
			Size = UDim2.new(0,58,0,58)
		}):Play()
		task.wait(0.8)

		TweenService:Create(img,TweenInfo.new(0.8),{
			Size = UDim2.new(0,54,0,54)
		}):Play()
		task.wait(0.8)
	end
end)

-- Intro slide
TweenService:Create(
	main,
	TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
	{Position = UDim2.new(0,20,1,-20)}
):Play()

-- Outro
task.spawn(function()
	task.wait(4)

	TweenService:Create(
		main,
		TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In),
		{
			Position = UDim2.new(0,20,1,120),
			BackgroundTransparency = 1
		}
	):Play()

	for _,v in pairs(main:GetDescendants()) do
		if v:IsA("TextLabel") or v:IsA("ImageLabel") or v:IsA("Frame") then
			pcall(function()
				v.BackgroundTransparency = 1
			end)
		end
	end

	task.wait(0.7)
	gui:Destroy()
end)

print("HypX loaded.")
