local add_to_temporary_property_original = PlayerManager.add_to_temporary_property

function PlayerManager:_clbk_bulletstorm_expire()

	self._bullet_storm_clbk = nil
	managers.hud:set_bulletstorm( false )
	
	for id , weapon in pairs( managers.player:player_unit():inventory():available_selections() ) do
		managers.hud:set_ammo_amount( id , weapon.unit:base():ammo_info() )
	end

end

function PlayerManager:add_to_temporary_property(name, time, ...)
   add_to_temporary_property_original(self, name, time, ...)
	if name == "bullet_storm" and time then
	
		if not self._bullet_storm_clbk then
			self._bullet_storm_clbk = "Infinite"
			managers.hud:set_bulletstorm( true )
			managers.enemy:add_delayed_clbk( self._bullet_storm_clbk , callback( self , self , "_clbk_bulletstorm_expire" ) , TimerManager:game():time() + time )
		end
		
	end
end