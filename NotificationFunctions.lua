
-- Scripted by OrcaniaDevelops
-- Created 7/14/25

--[[

	Used for creating notifications on players screen.

args:

player: selected player for notification (game.Players.LocalPlayer or "OrcaniaDevelops")
pos: position on the screen ('bottom', 'top', 'bottomright')
text: text displayed on the notification ("Hello world!)
duration: amount of time notification is displayed (15)
color: color of text displayed (Color3.new(1,1,1))

	Example:

local NotificationFunctions = require(location.scriptName)

NotificationFunctions:CreateNewNotification(game.Players.LocalPlayer, "bottom", "Hello World!", 5, Color3.fromRBG(255,0,0))


--]]

local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local NotificationFunctions = {}

function NotificationFunctions:CreateNewNotification(player: Player, pos: string, text: string, duration: number, color: Color3)

	local playerGui = player.PlayerGui
	local NotifGui = playerGui.Notifications

	local SFXFolder = SoundService.SFX

	local NotifSound = SFXFolder.Notification:Clone()
	NotifSound.Parent = playerGui
	local playbackSpeed = math.random(0.8, 1.2)
	NotifSound.PlaybackSpeed = playbackSpeed

	local self = script

	local Notification = self.Template:Clone()
    local TweenIn = TweenInfo.new(Notification, 0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
	local TweenOut = TweenInfo.new(Notification, 0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

	local Frame = NotifGui:FindFirstChild(pos)

	if not Frame then
		warn(pos .. " is not a valid member of " .. player.Name .. "'s Notification UI.")
	end
	
	Notification.Parent = NotifGui[pos] 
	NotifSound:Play()
	Notification.TextLabel.Text = text
	Notification.TextLabel.TextColor = color

	Notification.UIScale.Scale = 0
	TweenService:Create(Notification.UIScale, TweenIn, {Scale = 1}):Play()

	task.delay(duration, (function()

		TweenService:Create(Notification.UIScale, TweenOut, {Scale = 0}):Play()
		task.wait(0.2)
		Notification:Destroy()

	end)

end)

return NotificationFunctions
