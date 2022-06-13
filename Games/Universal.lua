local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ForeverSaad/Glare-Hub/main/UI-Library.lua"))()

local Glare = Library.new("Glare Hub - UNIVERSAL", 9896979764)

-- Player Variables
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Function Variables
local InfiniteJumping = false
local Clipping = false
local ClickTP = false

-- Service Variables
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

-- Theme
local Themes = {
	Background = Color3.fromRGB(24, 24, 24),
	Glow = Color3.fromRGB(0, 0, 0),
	Accent = Color3.fromRGB(10, 10, 10),
	LightContrast = Color3.fromRGB(20, 20, 20),
	DarkContrast = Color3.fromRGB(14, 14, 14),  
	TextColor = Color3.fromRGB(255, 255, 255)
}

-- Combat Page
local CombatPage = Glare:addPage("Combat", 6034996695)

-- Movement Page
local MovementPage = Glare:addPage("Movement", 6034333271)

local BasicMovementSection = MovementPage:addSection("Basic")

BasicMovementSection:addSlider("Walkspeed", 16, 1, 500, function(value)
    Player.Character.Humanoid.WalkSpeed = value
end)

BasicMovementSection:addSlider("JumpPower", 50, 1, 500, function(value)
    Player.Character.Humanoid.JumpPower = value
    Player.Character.Humanoid.UseJumpPower = true
end)

BasicMovementSection:addToggle("Infinite Jump", false, function(value)
    if value then
        InfiniteJumping = true
    else
        InfiniteJumping = false
    end
end)

BasicMovementSection:addToggle("Noclip", false, function(value)
    if value then
        function Noclip()
            if Player.Character ~= nil then
                for i,v in pairs(Player.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end
        Clipping = true
        Noclipping = RunService.Stepped:Connect(Noclip)
    else
        Noclipping:Disconnect()
        Clipping = false
    end
end)

BasicMovementSection:addToggle("Click TP", false, function(value)
    if not ClickTP then
        ClickTP = true
    else
        ClickTP = false
    end
end)

-- Infinite Jump
Mouse.KeyDown:Connect(function(Key)
    if Key == " "  and InfiniteJumping == true then
        Player.Character.Humanoid:ChangeState("Jumping")
    end
end)

-- ClickTP
Mouse.Button1Down:Connect(function()
    if ClickTP then
        local TpPos = Mouse.Hit.p
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(TpPos)
    end
end)

-- Visuals Page
local VisualsPage = Glare:addPage("Visuals", 6034996695)

-- Utility Page
local UtilityPage = Glare:addPage("Utility", 6031302976)

-- Settings Page
local SettingsPage = Glare:addPage("Settings", 311226871)

local KeyBindSection = SettingsPage:addSection("Keybinds")

KeyBindSection:addKeybind("Toggle GUI", Enum.KeyCode.LeftControl, function(a)
	Glare:toggle()
end)

KeyBindSection:addKeybind("Noclip", Enum.KeyCode.E, function()
    if not Clipping and Player.Character ~= nil then
        Clipping = true
        function Noclip()
            if Player.Character ~= nil then
                for i,v in pairs(Player.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end
        Noclipping = RunService.Stepped:Connect(Noclip)
    else
        Noclipping:Disconnect()
        Clipping = false
    end
end)

local ThemeSection = SettingsPage:addSection("Theme")

for theme, color in pairs(Themes) do -- Credit to UI lib's documentation
	ThemeSection:addColorPicker(theme, color, function(color3)
	    Glare:setTheme(theme, color3)
	end)
end