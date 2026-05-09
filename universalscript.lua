local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = player.PlayerGui:WaitForChild("CenterHub")

-- MAIN WINDOW
local universalMenu = Instance.new("Frame")
universalMenu.Name = "UniversalMenu"
universalMenu.Size = UDim2.new(0, 420, 0, 260)
universalMenu.Position = UDim2.new(0.5, 0, 0.5, 0)
universalMenu.AnchorPoint = Vector2.new(0.5, 0.5)
universalMenu.BackgroundColor3 = Color3.fromRGB(20,20,25)
universalMenu.BorderSizePixel = 0
universalMenu.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,8)
corner.Parent = universalMenu

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(120,120,120)
stroke.Transparency = 0.5
stroke.Parent = universalMenu

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "Universal Menu"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = universalMenu

-- TAB BAR
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1,0,0,30)
tabBar.Position = UDim2.new(0,0,0,35)
tabBar.BackgroundTransparency = 1
tabBar.Parent = universalMenu

-- PAGES
local pages = {}

local function createPage(name)
	local page = Instance.new("Frame")
	page.Name = name
	page.Size = UDim2.new(1,0,1,-70)
	page.Position = UDim2.new(0,0,0,70)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.Parent = universalMenu

	pages[name] = page
	return page
end

local visualsPage = createPage("Visuals")
local movementPage = createPage("Movement")
local miscPage = createPage("Misc")

-- TAB BUTTONS
local function makeTab(text, x, pageName)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0,120,1,0)
	btn.Position = UDim2.new(0,x,0,0)
	btn.BackgroundColor3 = Color3.fromRGB(35,35,45)
	btn.BorderSizePixel = 0
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 13
	btn.Parent = tabBar

	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0,6)
	c.Parent = btn

	btn.MouseButton1Click:Connect(function()
		for _, p in pairs(pages) do
			p.Visible = false
		end

		pages[pageName].Visible = true
	end)
end

makeTab("Visuals", 10, "Visuals")
makeTab("Movement", 145, "Movement")
makeTab("Misc", 280, "Misc")

visualsPage.Visible = true

-- VISUALS BUTTON
local fovBtn = Instance.new("TextButton")
fovBtn.Size = UDim2.new(0,180,0,30)
fovBtn.Position = UDim2.new(0,20,0,20)
fovBtn.BackgroundColor3 = Color3.fromRGB(45,45,55)
fovBtn.Text = "Increase FOV"
fovBtn.TextColor3 = Color3.fromRGB(255,255,255)
fovBtn.Font = Enum.Font.Gotham
fovBtn.TextSize = 13
fovBtn.Parent = visualsPage

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(0,6)
fovCorner.Parent = fovBtn

fovBtn.MouseButton1Click:Connect(function()
	workspace.CurrentCamera.FieldOfView = 90
end)

-- MOVEMENT BUTTON
local speedEnabled = false

local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0,180,0,30)
speedBtn.Position = UDim2.new(0,20,0,20)
speedBtn.BackgroundColor3 = Color3.fromRGB(45,45,55)
speedBtn.Text = "Toggle Speed"
speedBtn.TextColor3 = Color3.fromRGB(255,255,255)
speedBtn.Font = Enum.Font.Gotham
speedBtn.TextSize = 13
speedBtn.Parent = movementPage

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0,6)
speedCorner.Parent = speedBtn

speedBtn.MouseButton1Click:Connect(function()
	speedEnabled = not speedEnabled

	if speedEnabled then
		speedBtn.Text = "Speed: ON"
	else
		speedBtn.Text = "Speed: OFF"
	end
end)

RunService.RenderStepped:Connect(function()
	if speedEnabled then
		local char = player.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")

		if hrp then
			hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * 0.4)
		end
	end
end)

-- MISC BUTTON
local notifyBtn = Instance.new("TextButton")
notifyBtn.Size = UDim2.new(0,180,0,30)
notifyBtn.Position = UDim2.new(0,20,0,20)
notifyBtn.BackgroundColor3 = Color3.fromRGB(45,45,55)
notifyBtn.Text = "Notify"
notifyBtn.TextColor3 = Color3.fromRGB(255,255,255)
notifyBtn.Font = Enum.Font.Gotham
notifyBtn.TextSize = 13
notifyBtn.Parent = miscPage

local notifyCorner = Instance.new("UICorner")
notifyCorner.CornerRadius = UDim.new(0,6)
notifyCorner.Parent = notifyBtn

notifyBtn.MouseButton1Click:Connect(function()
	game.StarterGui:SetCore("SendNotification", {
		Title = "Universal",
		Text = "Menu working",
		Duration = 3
	})
end)

-- OPEN ANIMATION
universalMenu.Size = UDim2.new(0,0,0,0)

TweenService:Create(universalMenu, TweenInfo.new(
	0.35,
	Enum.EasingStyle.Quart,
	Enum.EasingDirection.Out
), {
	Size = UDim2.new(0,420,0,260)
}):Play()
