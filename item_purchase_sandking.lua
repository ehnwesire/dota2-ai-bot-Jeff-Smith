

local tableItemsToBuy = { 
				"item_stout_shield",
				"item_tango",
				"item_boots",
				"item_arcane_boots",
				"item_blink",
				"item_veil_of_discord",
				"item_pipe",
				"item_assault",
				"item_ultimate_scepter",
				"item_guardian_greaves",
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
