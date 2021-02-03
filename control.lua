function scroll(event)
	log("Scroll Called")
	-- this is the main function that handles the scrolling
	--when the player selects an item
	
	-- check if it's already in the hotbar at all (Not Done, will do soon)
	-- check if it's already first the hotbar (Done)
	-- check if there is spaces (Not Done, will do soon)
	-- check if it's an item and the player has enabled that (Done)
	-- otherwise move everything and add (Done)
	
	local player = game.players[event.player_index] 
	--get the player that this event has been called for
	local do_items = settings.get_player_settings(player)["do-items-in-hotbar"].value 
	-- get whether to add items that aren't placeable 
	local hotbar_offset = (settings.get_player_settings(player)["working-hotbar"].value * 10) - 10 
	-- get which hotbar to work in and use it to index
	local right_left = settings.get_player_settings(player)["sort-rl"].value 
	-- get whether to sort right-left instead
	local left_right = not right_left -- if not sorting right-left

	if settings.get_player_settings(player)["enable-mod"].value and player.cursor_stack.valid_for_read and not (player.cursor_stack.prototype.place_result == nil and not do_items) then --if they have the mod enabled
		
		 --if the item in the cursor is valid
		log(player.cursor_stack.name) -- log the name for debugging
		log(player.cursor_stack.count) -- log the count
			
		
		local startIndex = 1
		local endIndex = 1
		local direction = 1

		if left_right then
			startIndex = 1
			endIndex = 10
			direction = 1

		elseif right_left then
			startIndex = 10
			endIndex = 1
			direction = -1

		end

		local selected = nil
		
		for num=startIndex,endIndex,direction do -- for (num=startIndex; num < endindex; num += direction ? 1 : -1)
			
			
			if (player.get_quick_bar_slot(num + hotbar_offset) == nil or player.cursor_stack.name == player.get_quick_bar_slot(num + hotbar_offset).name) and selected == nil then
				selected = num
			end
			
			--if left_right then 
			--end 
		end
		
		if left_right then
			startIndex = selected
			endIndex = 2
			direction = -1
		
		elseif right_left then
			startIndex = selected
			endIndex = 9
			direction = 1
		end
		
		for num=startIndex,endIndex,direction do
			if not false then--(startIndex == num) then
				player.set_quick_bar_slot(num + hotbar_offset, player.get_quick_bar_slot((num + direction) + hotbar_offset))
			end
		end
		
		if left_right then
			player.set_quick_bar_slot(1 + hotbar_offset, player.cursor_stack.prototype)
		
		elseif right_left then
			player.set_quick_bar_slot(10 + hotbar_offset, player.cursor_stack.prototype)
		
		end
	end
end

script.on_event(defines.events.on_player_cursor_stack_changed, scroll)

