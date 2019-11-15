local talk = TalkAction("/giveitem")

function onSay(cid, words, param)
	local param = param.explode(param, ',')
	
	if not param or param == "" then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Command param required.")
		
		return
	end
	
	local pid = getCreatureByName(param[1])
	
	if not isPlayer(pid) then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "The given player doesn't exist or is offline.")
		
		return
	end
	
	local itemid, amount = tonumber(param[2]), tonumber(param[3]) or 1
	
	if not itemid then
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Invalid itemid.")
		
		return
	end
	
	doPlayerSendTextMessage(pid, 22, "Você acabou de receber "..amount.."x "..getItemNameById(itemid).." do ADM!")
	doPlayerAddItem(pid, itemid, amount)
	
	return true
end

