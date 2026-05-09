local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer

-- =========================
-- BLUR
-- =========================
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

TweenService:Create(blur, TweenInfo.new(0.5), {
	Size = 24
}):Play()

-- =========================
-- LOADING SCREEN
-- =========================
local loadGui = Instance.new("ScreenGui")
loadGui.Name = "LoadingScreen"
loadGui.ResetOnSpawn = false
loadGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(1,0,1,0)
frame.BackgroundColor3 = Color3.fromRGB(10,10,15)
frame.BackgroundTransparency = 0
frame.BorderSizePixel = 0
frame.Transparency = 100
frame.Parent = loadGui

-- =========================
-- PARTICLES SYSTEM
-- =========================
local particlesFolder = Instance.new("Folder")
particlesFolder.Name = "Particles"
particlesFolder.Parent = frame

local function createParticle()
	local p = Instance.new("Frame")
	p.Size = UDim2.new(0, math.random(2,4), 0, math.random(2,4))
	p.Position = UDim2.new(math.random(), 0, math.random(), 0)
	p.BackgroundColor3 = Color3.fromRGB(255,255,255)
	p.BackgroundTransparency = 0.9
	p.BorderSizePixel = 0
	p.Parent = particlesFolder

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(1,0)
	c.Parent = p

	task.spawn(function()
		while p.Parent do
			local tween = TweenService:Create(p, TweenInfo.new(math.random(3,6), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
				Position = UDim2.new(math.random(),0,math.random(),0),
				BackgroundTransparency = math.random(85,95)/100
			})
			tween:Play()
			tween.Completed:Wait()
		end
	end)
end

for i = 1, 25 do
	createParticle()
end

-- =========================
-- MOON
-- =========================
local moon = Instance.new("ImageLabel")
moon.Size = UDim2.new(0, 100, 0, 100)
moon.Position = UDim2.new(0.5, 0, 0.45, 0)
moon.AnchorPoint = Vector2.new(0.5, 0.5)
moon.BackgroundTransparency = 1
moon.Image = "rbxthumb://type=Asset&id=73404703881683&w=420&h=420"
moon.Parent = frame

-- smooth rotation
task.spawn(function()
	while moon.Parent do
		moon.Rotation += 0.6
		task.wait()
	end
end)

-- =========================
--  TEXT
-- =========================
local text = Instance.new("TextLabel")
text.Size = UDim2.new(1,0,0,30)
text.Position = UDim2.new(0,0,0.6,0)
text.BackgroundTransparency = 1
text.Text = "loading melancholia..."
text.TextColor3 = Color3.fromRGB(255,255,255)
text.Font = Enum.Font.Gotham
text.TextSize = 16
text.Parent = frame

task.wait(3)

-- =========================
-- FADE OUT LOADING
-- =========================
TweenService:Create(frame, TweenInfo.new(0.5), {
	BackgroundTransparency = 1
}):Play()

TweenService:Create(moon, TweenInfo.new(0.5), {
	ImageTransparency = 1
}):Play()

TweenService:Create(text, TweenInfo.new(0.5), {
	TextTransparency = 1
}):Play()

TweenService:Create(blur, TweenInfo.new(0.5), {
	Size = 18
}):Play()

task.wait(0.6)
loadGui:Destroy()

-- =========================
-- HUB UI
-- =========================
local gui = Instance.new("ScreenGui")
gui.Name = "CenterHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- MAIN
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 420, 0, 90)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(120,120,120)
stroke.Transparency = 0.6
stroke.Thickness = 1
stroke.Parent = main

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,25)
title.BackgroundTransparency = 1
title.Text = "melancholia hub"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = main

-- BUTTONS
local function makeButton(text, x)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0,120,0,30)
	btn.Position = UDim2.new(0,x,0,45)
	btn.BackgroundColor3 = Color3.fromRGB(45,45,55)
	btn.BorderSizePixel = 0
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 14
	btn.Parent = main

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,6)
	c.Parent = btn

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {
			BackgroundColor3 = Color3.fromRGB(70,70,85)
		}):Play()
	end)

	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {
			BackgroundColor3 = Color3.fromRGB(45,45,55)
		}):Play()
	end)

	return btn
end

local evade = makeButton("Evade", 20)
local teams = makeButton("Teams", 150)
local universal = makeButton("Universal", 280)

-- ANIMATION IN HUB
main.Size = UDim2.new(0,0,0,0)
TweenService:Create(main, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {
	Size = UDim2.new(0,420,0,90)
}):Play()

-- DRAG
local dragging, dragStart, startPos

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- TOGGLE
local open = true

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end

	if input.KeyCode == Enum.KeyCode.RightShift then
		open = not open

		if open then
			main.Visible = true
			blur.Size = 18
		else
			main.Visible = false
			blur.Size = 0
		end
	end
end)

-- BUTTON EVENTS
evade.MouseButton1Click:Connect(function()
	--todo
end)

teams.MouseButton1Click:Connect(function()
--todo
end)

universal.MouseButton1Click:Connect(function()
    --todo
end)
