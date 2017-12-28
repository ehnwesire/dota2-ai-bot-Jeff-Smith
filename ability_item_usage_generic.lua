--[[
Appendix A - Chaining to a generic implementation in Lua[edit]
If you're implementing a generic version of a mode or ability/item usage, 
you should add this code to the bottom of your generic file (adjusting the name of the module appropriately, 
and including the functions you want to be callable from hero-specific classes):

BotsInit = require( "game/botsinit" );
local MyModule = BotsInit.CreateGeneric();
MyModule.OnStart = OnStart;
MyModule.OnEnd = OnEnd;
MyModule.Think = Think;
MyModule.GetDesire = GetDesire;
return MyModule;
Then in your hero-specific implementation, you can start your file with this:

mode_defend_ally_generic = dofile( GetScriptDirectory().."/mode_defend_ally_generic" )
which allows you to do things like the following in your bot-specific code:

mode_defend_ally_generic.OnStart();
]]--