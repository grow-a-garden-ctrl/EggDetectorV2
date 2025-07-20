-- 🔍 Delta Executor Detection + Freeze Lock by Drei

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local gui = player:WaitForChild("PlayerGui")

-- Function to detect executor
local function getExecutorName()
	if identifyexecutor then
		return identifyexecutor()
	elseif getexecutorname then
		return getexecutorname()
	elseif isdelta then
		return "Delta"
	elseif iskrnlclosure then
		return "Krnl"
	elseif syn then
		return "Synapse X"
	elseif is_sirhurt_closure then
		return "SirHurt"
	elseif pebc_execute then
		return "ProtoSmasher"
	elseif isfluxus then
		return "Fluxus"
	else
		return "Unknown"
	end
end

local executor = getExecutorName()
warn("Executor Detected:", executor)

-- If executor is Delta, activate the freeze screen
if executor:lower():find("delta") then
	-- Wait for character
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local rootPart = character:WaitForChild("HumanoidRootPart")

	-- 🌀 Blur screen
	local blur = Instance.new("BlurEffect")
	blur.Name = "DeltaFreezeBlur"
	blur.Size = 25
	blur.Parent = Lighting

	-- 🧊 Freeze player
	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.AutoRotate = false
	rootPart.Anchored = true

	-- 🎥 Lock camera
	camera.CameraType = Enum.CameraType.Scriptable
	camera.CFrame = CFrame.new(rootPart.Position + Vector3.new(0, 6, 12), rootPart.Position)

	-- Create UI
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 200)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner", mainFrame)
uiCorner.CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Text = "This script is not stable on Delta.\nPlease use Krnl if you wish to use the script."
title.Font = Enum.Font.Gotham
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(30, 30, 30)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -40, 0, 100)
title.Position = UDim2.new(0, 20, 0, 20)
title.TextWrapped = true
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Center
title.Parent = mainFrame

-- Copy Button
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0, 200, 0, 36)
copyButton.Position = UDim2.new(0.5, -100, 1, -50)
copyButton.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
copyButton.Text = "Copy Krnl Link"
copyButton.Font = Enum.Font.Gotham
copyButton.TextSize = 16
copyButton.TextColor3 = Color3.fromRGB(0, 0, 0)
copyButton.AutoButtonColor = true
copyButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner", copyButton)
buttonCorner.CornerRadius = UDim.new(0, 6)

copyButton.MouseButton1Click:Connect(function()
    setclipboard("https://wearedevs.net/d/Krnl")
    copyButton.Text = "Copied!"
    task.wait(1)
    copyButton.Text = "Copy Krnl Link"
end)


	-- 🔧 Hide TopBar (ESC/menu)
	pcall(function()
		StarterGui:SetCore("TopbarEnabled", false)
	end)

	-- ⛔ Block input backup
	UserInputService.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Keyboard or input.UserInputType == Enum.UserInputType.Gamepad1 then
			input:CaptureController()
		end
	end)
else
	-- ✅ Not Delta → continue loading Egg Detector script
	loadstring(game:HttpGet("https://pastefy.app/6ogbs0qv/raw"))()
end
