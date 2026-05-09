-- =========================
-- 🌌 UNIVERSAL MENU
-- =========================

local universalMenu = Instance.new("Frame")
universalMenu.Size = UDim2.new(0, 0, 0, 0)
universalMenu.Position = UDim2.new(0.5, 0, 0.5, 120)
universalMenu.AnchorPoint = Vector2.new(0.5, 0.5)
universalMenu.BackgroundColor3 = Color3.fromRGB(20,20,25)
universalMenu.BorderSizePixel = 0
universalMenu.Visible = false
universalMenu.Parent = gui

local uc = Instance.new("UICorner")
uc.CornerRadius = UDim.new(0, 8)
uc.Parent = universalMenu

local uStroke = Instance.new("UIStroke")
uStroke.Color = Color3.fromRGB(120,120,120)
uStroke.Transparency = 0.6
uStroke.Thickness = 1
uStroke.Parent = universalMenu

local uTitle = Instance.new("TextLabel")
uTitle.Size = UDim2.new(1,0,0,30)
uTitle.BackgroundTransparency = 1
uTitle.Text = "Universal Menu"
uTitle.TextColor3 = Color3.fromRGB(255,255,255)
uTitle.Font = Enum.Font.GothamBold
uTitle.TextSize = 16
uTitle.Parent = universalMenu

-- =========================
-- SPEED TOGGLE
-- =========================

local speedEnabled = false

local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0, 220, 0, 35)
speedBtn.Position = UDim2.new(0.5, -110, 0, 50)
speedBtn.BackgroundColor3 = Color3.fromRGB(45,45,55)
speedBtn.TextColor3 = Color3.fromRGB(255,255,255)
speedBtn.Font = Enum.Font.Gotham
speedBtn.TextSize = 14
speedBtn.Text = "Speed: OFF"
speedBtn.Parent = universalMenu

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 6)
speedCorner.Parent = speedBtn

speedBtn.MouseButton1Click:Connect(function()

	speedEnabled = not speedEnabled

	if speedEnabled then
		speedBtn.Text = "Speed: ON"

		TweenService:Create(speedBtn, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(90,120,255)
		}):Play()

	else
		speedBtn.Text = "Speed: OFF"

		TweenService:Create(speedBtn, TweenInfo.new(0.2), {
			BackgroundColor3 = Color3.fromRGB(45,45,55)
		}):Play()
	end
end)

game:GetService("RunService").RenderStepped:Connect(function()

	if speedEnabled then

		local char = player.Character

		if char and char:FindFirstChild("HumanoidRootPart") then

			char.HumanoidRootPart.CFrame +=
				char.HumanoidRootPart.CFrame.LookVector * 0.8

		end
	end
end)

-- =========================
-- OPEN MENU
-- =========================

local universalOpen = false

universal.MouseButton1Click:Connect(function()

	universalOpen = not universalOpen

	if universalOpen then

		main.Visible = false
		blur.Size = 0

		universalMenu.Visible = true

		TweenService:Create(
			universalMenu,
			TweenInfo.new(0.35, Enum.EasingStyle.Quart),
			{
				Size = UDim2.new(0, 320, 0, 220)
			}
		):Play()

	else

		TweenService:Create(
			universalMenu,
			TweenInfo.new(0.25),
			{
				Size = UDim2.new(0,0,0,0)
			}
		):Play()

		task.wait(0.25)

		universalMenu.Visible = false

		main.Visible = true
		blur.Size = 18
	end
end)
