local talk = TalkAction("!ot")
 
function talk.onSay(player, words, param)

	local playerGuild = player:getGuild()
	local creature = player

	if(not playerGuild or playerGuild:getId() == 0) then
		player:sendTextMessage(MESSAGE_INFO_DESCR,"Sorry, you're not in a guild.")
		return false
	end

	if player:getGuildLevel() < 2 then -- 3 = Leader, 2 = Vice-Leader, 1 = Regular Member
		player:sendTextMessage(MESSAGE_INFO_DESCR,"You have to be Leader or Vice-Leader of your guild to change outfits!")
		return false
	end

	local outfit = creature:getOutfit()
	local count = 0
	local message = "*Guild* Your outfit has been changed by leader. (" ..player:getName() .. ")"

	for _, members in ipairs(Game.getPlayers()) do
		if(members:getGuild() == playerGuild and player ~= members) then
			local newOutfit = outfit
			if(not members:hasOutfit(outfit.lookType, outfit.lookAddons)) then
				local tmpOutfit = members:getOutfit()
				newOutfit.lookAddons = 0 --tmpOutfit.lookAddons
				if(not members:hasOutfit(outfit.lookType, 0)) then
					newOutfit.lookType = tmpOutfit.lookType
				end
			end

			members:getPosition():sendMagicEffect(66)
			members:setOutfit(newOutfit)
			members:sendTextMessage(MESSAGE_INFO_DESCR, message)
			count = count + 1
		end
	end

	player:sendTextMessage(MESSAGE_INFO_DESCR,"Guild members outfit has been changed. (Total: " .. count .. ")")
	
	return false
end


talk:separator(" ")
talk:register()
