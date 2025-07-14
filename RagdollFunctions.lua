
local RagdollFunctions = {}

local PhysicsService = game:GetService("PhysicsService")
PhysicsService:CreateCollisionGroup("Players")
PhysicsService:CreateCollisionGroup("Collider")
PhysicsService:CollisionGroupSetCollidable("Players","Collider",false)

function RagdollFunctions:RigPlayer(Character : Model)
	local hum : Humanoid = Character:WaitForChild("Humanoid")
	local hrp : BasePart = Character:WaitForChild("HumanoidRootPart")
	
	assert(hum,Character.Name.." isnt a humanoid")
	
	hum:SetAttribute("RiggedUser",true)
	
	local Colliders = Instance.new("Folder",Character)
	Colliders.Name = "ColliderFolder"
	hum.BreakJointsOnDeath = false
	
	for _,v in pairs(Character:GetDescendants()) do
		if v:IsA("Motor6D") then
			local BallSocket = Instance.new("BallSocketConstraint",v.Part0)
			BallSocket.Name = "BC"
			v.Part1.CanCollide = false
			v.Part0.CanCollide = false

			PhysicsService:SetPartCollisionGroup(v.Part1,"Players")

			local Holder = Instance.new("Part",Colliders)
			Holder.Name = v.Part1.Name
			PhysicsService:SetPartCollisionGroup(Holder,"Collider")
			Holder.Size = v.Part1.Size/2
			Holder.CFrame = v.Part1.CFrame
			
			local Weld = Instance.new("WeldConstraint",Holder) Weld.Part0 = v.Part1 Weld.Part1 = Holder
			Holder.Transparency = 1
			Holder.Massless = true
			Holder.CanCollide = false

			local att1 = Instance.new("Attachment",v.Part0) att1.Name = "AttRag"
			local att2 = Instance.new("Attachment",v.Part1) att1.Name = "AttRag"
			att2.Position = v.C1.Position
			att1.WorldPosition= att2.WorldPosition

			BallSocket.LimitsEnabled = true
			BallSocket.TwistLimitsEnabled = true

			BallSocket.Attachment0 = att1
			BallSocket.Attachment1 = att2
			
			if v.Part0 ~= Character.PrimaryPart and v.Part1 ~= Character.PrimaryPart then
				hum.Ragdoll:Connect(function(val)
					Holder.CanCollide = val
					v.Enabled = not val
				end)
			else
				local WeldConstranint = Instance.new("WeldConstraint",hrp)
				WeldConstranint.Part0 = Character.PrimaryPart
				WeldConstranint.Part1 = Character.PrimaryPart == v.Part1 and v.Part0 or v.Part1
				WeldConstranint.Enabled = false
				
				hum.Ragdoll:Connect(function(val) WeldConstranint.Enabled = val end)
			end
			
			hum.Died:Connect(function() v:Destroy() end)
		end
	end
	
	hum.Ragdoll:Connect(function(val)
		Character:SetPrimaryPartCFrame(val and Character.PrimaryPart.CFrame or CFrame.new(Character.PrimaryPart.Position + Vector3.new(0,hum.HipHeight,0),Character.PrimaryPart.Position + Character.PrimaryPart.CFrame.LookVector * 5)) -- custom characters tend to get stuck sometimes, this prevents them (if u want you can remove it)
	end)
end

return RagdollFunctions
