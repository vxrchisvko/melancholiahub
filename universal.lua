local universalMenu = Instance.new("Frame")
universalMenu.Size = UDim2.new(0, 300, 0, 200)
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

local speedEnabled = false

local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0, 200, 0, 30)
speedBtn.Position = UDim2.new(0.5, -100, 0, 50)
speedBtn.Text = "Toggle Speed"
speedBtn.BackgroundColor3 = Color3.fromRGB(45,45,55)
speedBtn.TextColor3 = Color3.fromRGB(255,255,255)
speedBtn.Parent = universalMenu

speedBtn.MouseButton1Click:Connect(function()
	speedEnabled = not speedEnabled
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if speedEnabled then
		local char = player.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.CFrame += char.HumanoidRootPart.CFrame.LookVector * 1.2
		end
	end
end)

local universalOpen = false

universal.MouseButton1Click:Connect(function()

	universalOpen = not universalOpen

	if universalOpen then
		universalMenu.Visible = true

		universalMenu.Size = UDim2.new(0,0,0,0)
		TweenService:Create(universalMenu, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
			Size = UDim2.new(0,300,0,200)
		}):Play()

		-- ukryj main (opcjonalnie)
		main.Visible = false
		blur.Size = 0
	else
		TweenService:Create(universalMenu, TweenInfo.new(0.2), {
			Size = UDim2.new(0,0,0,0)
		}):Play()

		task.wait(0.2)
		universalMenu.Visible = false

		main.Visible = true
		blur.Size = 18
	end
end)

