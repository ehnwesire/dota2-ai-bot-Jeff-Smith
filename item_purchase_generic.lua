function Think () 

	local npcBot = GetBot(); 
	
	if( npcBot.secretShopMode ~= true and npcBot.sideShopMode ~= true)
	then
		if ( IsItemPurchasedFromSideShop (sNextItem) and npcBot:DistanceFomSideShop() <= 2000)
		then
			npcBot.sideShopMode = true; 
		end
		
		if ( IsItemPurchasedFromSecretShop (sNextItem))
		then
			npcBot.secretShopMode = true;
		end
	end
	