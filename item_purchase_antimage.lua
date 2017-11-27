

local tableItemsToBuy = { 
				"item_reaver",
				"item_tango",
				"item_boots",
				"item_ring_of_health",
				"item_power_treads",
				"item_bfury",
				"item_sange",
				"item_basher",
				"item_manta",
				"item_abyssal_blade",
				"item_ultimate_scepter"
				"item_butterfly",
				"item_heart", ---------replace battle fury
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
