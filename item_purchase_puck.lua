

local tableItemsToBuy = { 
				"item_null_talisman",
   		             --"item_tango_single", -------- this is the shared tango, but how do we do that?
				"item_boots",
				"item_phase_boots", --------- Choose one you think it’s the best
				"item_power_treads",  --------- Just Choose one of them
				"item_veil_of_discord",
				"item_blink",
				"item_sheepstick",
				"item_dagon_#", ---------level 1-5 #is the level of item
				"item_octarine_core",
				"item_travel_boots_#",  ---------level 1-2
			};


----------------------------------------------------------------------------------------------------

function ItemPurchaseThink()

	local npcBot = GetBot();

	if ( #tableItemsToBuy == 0 )
	then
		npcBot:SetNextItemPurchaseValue( 0 );
		return;
	end
--wehn the list of items are all purchased
	local sNextItem = tableItemsToBuy[1];

	npcBot:SetNextItemPurchaseValue( GetItemCost( sNextItem ) );

	if ( npcBot:GetGold() >= GetItemCost( sNextItem ) )
	then
		npcBot:ActionImmediate_PurchaseItem( sNextItem );
		table.remove( tableItemsToBuy, 1 );
	end

end

----------------------------------------------------------------------------------------------------
