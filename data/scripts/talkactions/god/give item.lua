local talk = TalkAction("/gi")
-- Give Item function
-- talk = words
-- Example:
-- /gi nome_jogador, 2160, 100
function talk.onSay(player, words, param)

local invalidIds = {
	1, 2, 3, 4, 5, 6, 7, 10, 11, 13, 14, 15, 19, 21, 26, 27, 28, 35, 43
}

	if not player:getGroup():getAccess() or player:getAccountType() < ACCOUNT_TYPE_GOD then
		return true
	end
	
	local split = param:split(",")
	local target = Player(split[1])
	local item = split[2]
	
	if string.find(item, " ") == 1 then
		item = string.gsub(split[2], " ", "", 1)
	end
	local itemType = ItemType(item)
	
	if itemType:getId() == 0 then
		itemType = ItemType(tonumber(split[2]))
		if not tonumber(split[2]) or itemType:getId() == 0 then
			player:sendCancelMessage("There is no item with that id or name.")
			return false
		end
	end

	if table.contains(invalidIds, itemType:getId()) then
		return false
	end

	local count = tonumber(split[3])
	if count then
		if itemType:isStackable() then
			count = math.min(10000, math.max(1, count))
		elseif not itemType:isFluidContainer() then
			count = math.min(100, math.max(1, count))
		else
			count = math.max(0, count)
		end
	else
		if not itemType:isFluidContainer() then
			count = 1
		else
			count = 0
		end
	end

	local result = target:addItem(itemType:getId(), count)
	if result then
		if not itemType:isStackable() then
			if type(result) == "table" then
				for _, item in ipairs(result) do
					item:decay()
				end
			else
				result:decay()
			end
		end
		target:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		target:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, player:getName().." gives you ".. count.." ".. itemType:getName())
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You give "..target:getName().." ".. count.." "..itemType:getName())
	end	
		
	return false
end

talk:separator(" ")
talk:register()
