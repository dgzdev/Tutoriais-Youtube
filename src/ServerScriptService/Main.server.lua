local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")

-- * Physics Service
local function SetCollisionGroup(Character): RBXScriptConnection
	for index: number, BasePart: BasePart in ipairs(Character:GetDescendants()) do
		if not (BasePart:IsA("BasePart")) then
			continue
		end
		BasePart.CollisionGroup = "Players"
	end
	return Character.DescendantAdded:Connect(function(descendant: BasePart)
		if not (descendant:IsA("BasePart")) then
			return
		end

		descendant.CollisionGroup = "Players"
	end)
end

-- ? Player Added
Players.PlayerAdded:Connect(function(Player: Player)
	local Character = Player.Character or Player.CharacterAdded:Wait()

	-- * Collision Group
    local Connection = SetCollisionGroup(Character)
    Player.CharacterAdded:Connect(function(character: Model)
        Connection:Disconnect()
        Connection = SetCollisionGroup(character)
    end)
end)    