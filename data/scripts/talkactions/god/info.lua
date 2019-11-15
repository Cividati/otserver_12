local talk = TalkAction("/info")

function talk.onSay(player, words, param)
	local target = Player(param)
	
	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end
	
	if not target then
		player:sendCancelMessage("Player not found.")
		return false
	end
	
	if param == "" then
		player:sendCancelMessage("Command param required.")
		return false
	end

	local targetIp = target:getIp()
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 
	"\nName: " .. target:getName()..
	"\nAccess: " .. (target:getGroup():getAccess() and "1" or "0")..
	"\nLevel: " .. target:getLevel()..
	"\nMagic Level: " .. target:getMagicLevel()..
	"\nSpeed: " .. target:getSpeed()..
	"\nPosition: " .. string.format("(%0.5d / %0.5d / %0.3d)", target:getPosition().x, target:getPosition().y, target:getPosition().z)..
	"\nIP: " .. Game.convertIpToString(targetIp))

	local players = {}
	for _, targetPlayer in ipairs(Game.getPlayers()) do	
		if targetPlayer:getIp() == targetIp and targetPlayer ~= target then
			players[#players + 1] = targetPlayer:getName() .. " [" .. targetPlayer:getLevel() .. "]"
		end
	end

	if #players > 0 then
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Other players on same IP: " .. table.concat(players, ", ") .. ".")
	end
	return false
end

talk:separator(" ")
talk:register()