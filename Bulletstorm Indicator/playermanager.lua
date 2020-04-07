if ArmStatic 
or restoration and restoration:all_enabled("HUD/MainHUD", "HUD/Teammate") 
or PDTHHud and PDTHHud.Options:GetValue("HUD/MainHud") 
or SydneyHUD and SydneyHUD:GetOption("improved_ammo_count") 
or NepgearsyHUDReborn
or WolfHUD and WolfHUD:getSetting({"CustomHUD", "ENABLED"}, true)
or Holo
then return end

local add_to_temporary_property_original = PlayerManager.add_to_temporary_property

function PlayerManager:_clbk_bulletstorm_expire()
	self._bullet_storm_clbk = nil
	managers.hud:set_bulletstorm( false )
	
	if not BL2Options and managers.player and managers.player:player_unit() and managers.player:player_unit():inventory() then
		for id , weapon in pairs( managers.player:player_unit():inventory():available_selections() ) do
			managers.hud:set_ammo_amount( id , weapon.unit:base():ammo_info() )
		end
	end
end

function PlayerManager:add_to_temporary_property(name, time, value, ...)
   add_to_temporary_property_original(self, name, time, value, ...)

	if not BL2Options and name == "bullet_storm" and time then
	
		if not self._bullet_storm_clbk then
			self._bullet_storm_clbk = "infinite"
			managers.hud:set_bulletstorm( true )
			managers.enemy:add_delayed_clbk( self._bullet_storm_clbk , callback( self , self , "_clbk_bulletstorm_expire" ) , TimerManager:game():time() + time )
		end
	end
end
