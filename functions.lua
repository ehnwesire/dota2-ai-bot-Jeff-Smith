--[[
If you'd like to just override decisionmaking around ability and item usage, 
you can implement the following functions in an ability_item_usage_generic.lua file:

ItemUsageThink() - Called every frame. Responsible for issuing item usage actions.
AbilityUsageThink() - Called every frame. Responsible for issuing ability usage actions.
CourierUsageThink() - Called every frame. Responsible for issuing commands to the courier.
BuybackUsageThink() - Called every frame. Responsible for issuing a command to buyback.
AbilityLevelUpThink() - Called every frame. Responsible for managing ability leveling.

int GetItemCost( sItemName )

Returns the cost of the specified item.
bool IsItemPurchasedFromSecretShop( sItemName )

Returns if the specified item is purchased from the secret shops.
bool IsItemPurchasedFromSideShop( sItemName )

Returns if the specified item can be purchased from the side shops.
int GetItemStockCount( sItemName )

Returns the current stock count of the specified item.
{ { hItem, hOwner, nPlayer, vLocation }, ...} GetDroppedItemList()

Returns a table of tables that list the item, owner, 
and location of items that have been dropped on the ground.

if(npcBot.secretShopMode~=true and npcBot.sideShopMode ~=true)
        then
            if (IsItemPurchasedFromSideShop( sNextItem ) and npcBot:DistanceFromSideShop() <= 2000)
            then
                npcBot.sideShopMode = true;
            end
            if (IsItemPurchasedFromSecretShop( sNextItem )) 
            then
                npcBot.secretShopMode = true;
            end
        end
		
Mode Override
If you'd like to work within the existing mode architecture but override the logic for mode desire and behavior, 
for example the Laning mode, you can implement the following functions in a mode_laning_generic.lua file:

GetDesire() - Called every ~300ms, and needs to return a floating-point value between 0 and 1 that indicates how much this mode wants to be the active mode.
OnStart() - Called when a mode takes control as the active mode.
OnEnd() - Called when a mode relinquishes control to another active mode.
Think() - Called every frame while this is the active mode. Responsible for issuing actions for the bot to take.
You can additionally just override the mode logic for a specific hero, such as Lina,
with a mode_laning_lina.lua file. Please see Appendix A for implementation details if you'd like to chain calls from a hero-specific mode override back to a generic mode override.

The list of valid bot modes to override are:

laning
attack
roam
retreat
secret_shop
side_shop
rune
push_tower_top
push_tower_mid
push_tower_bot
defend_tower_top
defend_tower_mid
defend_tower_bottom
assemble
team_roam
farm
defend_ally
evasive_maneuvers
roshan
item
ward
]]--