function scroll(event)
	--log("Scroll Called")
	-- this is the main function that handles the scrolling
	--when the player selects an item
	
	-- check if it's already in the hotbar at all (Not Done, will do soon)
	-- check if it's already first the hotbar (Done)
	-- check if there is spaces (Not Done, will do soon)
	-- check if it's an item and the player has enabled that (Done)
	-- otherwise move everything and add (Done)
	
	local player = game.players[event.player_index]
	if player.cursor_stack.valid_for_read then
		log(player.cursor_stack.name)
		log(player.cursor_stack.count)
		local do_items = settings.get_player_settings(player)["do-items-in-hotbar"].value
		local working_hotbar = (settings.get_player_settings(player)["working-hotbar"].value * 10) - 10
		if player.get_quick_bar_slot(1 + working_hotbar) == player.cursor_stack.prototype or (player.cursor_stack.prototype.place_result == nil and do_items == false) then
		do end
		
		else
			local fin_slot = nil
			
			for slot=2,10 do
				if (player.get_quick_bar_slot(slot + working_hotbar) == nil and fin_slot == nil) or (player.get_quick_bar_slot(slot + working_hotbar) == player.cursor_stack.prototype and fin_slot == nil) then
					fin_slot = 10 - slot
				end
			end
			if fin_slot == nil then fin_slot = 0 end
			for num=fin_slot,8 do
				player.set_quick_bar_slot((10 - num) + working_hotbar, player.get_quick_bar_slot((9 - num) + working_hotbar))
			end
			player.set_quick_bar_slot(1 + working_hotbar, player.cursor_stack.name)
		end
	end

	
	
end

script.on_event(defines.events.on_player_cursor_stack_changed, scroll)
