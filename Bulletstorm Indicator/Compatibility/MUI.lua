if ArmStatic and MUIMenu and MUIMenu:ClassEnabled("MUITeammate") and MUIMenu:ClassEnabled("MUILegend") and MUIMenu:ClassEnabled("AnimatedList") then
	if RequiredScript == "lib/managers/hud/hudteammate" then
			function HUDTeammate:_set_bulletstorm(state)
				self._infinite_ammo = state;
				if self._infinite_ammo then
					self._primary_ammo_clip:set_color(Color.white);
					self._primary_ammo_clip:set_text("8");
					self._primary_ammo_clip:set_rotation(90);
					self._secondary_ammo_clip:set_color(Color.white);
					self._secondary_ammo_clip:set_text("8");
					self._secondary_ammo_clip:set_rotation(90);
				end
			end

		function HUDTeammate:set_inf_ammo_amount_by_type()
			if self._main_player and self._infinite_ammo then
				self._primary_ammo_clip:set_text("8");
				self._secondary_ammo_clip:set_text("8");
				self._primary_ammo_clip:set_color(Color.white);
				self._secondary_ammo_clip:set_color(Color.white);
				self._primary_ammo_clip:set_rotation(90);
				self._secondary_ammo_clip:set_rotation(90);
			else
				self._primary_ammo_clip:set_rotation(0);
				self._secondary_ammo_clip:set_rotation(0);
			end
		end
	elseif RequiredScript == "lib/managers/hudmanagerpd2" then
		function HUDManager:set_teammate_ammo_amount(id, selection_index, max_clip, current_clip, current_left, max_left)
			self._teammate_panels[id]:set_ammo_amount_by_type(selection_index, max_clip, current_clip, current_left, max_left)
			self._teammate_panels[id]:set_inf_ammo_amount_by_type()
		end
	end
end