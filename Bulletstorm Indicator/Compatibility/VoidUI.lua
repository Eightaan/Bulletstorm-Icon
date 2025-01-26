if not VoidUI then return end

local init_original = HUDTeammate.init
local set_ammo_amount_by_type_original = HUDTeammate.set_ammo_amount_by_type
local set_custom_radial_orig = HUDTeammate.set_custom_radial

function HUDTeammate:init(...)
    init_original(self, ...)
	if self._main_player then
	    self:inject_ammo_glow()
	end
end

function HUDTeammate:inject_ammo_glow()
	local hud_scale = VoidUI.options.hud_main_scale 
	self._primary_ammo = self._custom_player_panel:child("weapons_panel"):child("primary_ammo_panel"):bitmap({
		align           = "center",
		w 				= 100 * hud_scale,
		h 				= 45 * hud_scale,
		name 			= "primary_ammo",
		visible 		= false,
		texture 		= "guis/textures/pd2/crimenet_marker_glow",
		color 			= Color("00AAFF"),
		layer 			= 2,
		blend_mode 		= "add"
	})
	self._primary_ammo_text = self._custom_player_panel:child("weapons_panel"):child("primary_ammo_panel"):text({
		align = "center",
		name = "primary_ammo_text",
		visible = false,
		text = "8",
		font = tweak_data.menu.pd2_large_font,
		font_size = tweak_data.menu.pd2_large_font_size * hud_scale,
		color = Color.white,
		rotation = 90,
		layer = 4
	})
	self._secondary_ammo = self._custom_player_panel:child("weapons_panel"):child("secondary_ammo_panel"):bitmap({
		align           = "center",
		w 				= 100 * hud_scale,
		h 				= 45 * hud_scale,
		name 			= "secondary_ammo",
		visible 		= false,
		texture 		= "guis/textures/pd2/crimenet_marker_glow",
		color 			= Color("00AAFF"),
		layer 			= 2,
		blend_mode 		= "add"
	})
	self._secondary_ammo_text = self._custom_player_panel:child("weapons_panel"):child("secondary_ammo_panel"):text({
		align = "center",
		name = "primary_ammo_text",
		visible = false,
		text = "8",
		font = tweak_data.menu.pd2_large_font,
		font_size = tweak_data.menu.pd2_large_font_size * hud_scale,
		color = Color.white,
		rotation = 90,
		layer = 4
	})
	self._primary_ammo:set_center_y(self._custom_player_panel:child("weapons_panel"):child("primary_ammo_panel"):child("primary_ammo_amount"):y() + self._custom_player_panel:child("weapons_panel"):child("primary_ammo_panel"):child("primary_ammo_amount"):h() / 2)
	self._primary_ammo:set_center_x(self._custom_player_panel:child("weapons_panel"):child("primary_ammo_panel"):child("primary_ammo_amount"):x() + self._custom_player_panel:child("weapons_panel"):child("primary_ammo_panel"):child("primary_ammo_amount"):w() / 3.5)
	self._primary_ammo_text:set_center_y(self._custom_player_panel:child("weapons_panel"):child("primary_ammo_panel"):child("primary_ammo_amount"):y() + self._custom_player_panel:child("weapons_panel"):child("primary_ammo_panel"):child("primary_ammo_amount"):h() / 2)
	self._primary_ammo_text:set_center_x(self._custom_player_panel:child("weapons_panel"):child("primary_ammo_panel"):child("primary_ammo_amount"):x() + self._custom_player_panel:child("weapons_panel"):child("primary_ammo_panel"):child("primary_ammo_amount"):w() / 3.5)
	
	self._secondary_ammo:set_center_y(self._custom_player_panel:child("weapons_panel"):child("secondary_ammo_panel"):child("secondary_ammo_amount"):y() + self._custom_player_panel:child("weapons_panel"):child("secondary_ammo_panel"):child("secondary_ammo_amount"):h() / 2)
	self._secondary_ammo:set_center_x(self._custom_player_panel:child("weapons_panel"):child("secondary_ammo_panel"):child("secondary_ammo_amount"):x() + self._custom_player_panel:child("weapons_panel"):child("secondary_ammo_panel"):child("secondary_ammo_amount"):w() / 3.5)
	self._secondary_ammo_text:set_center_y(self._custom_player_panel:child("weapons_panel"):child("secondary_ammo_panel"):child("secondary_ammo_amount"):y() + self._custom_player_panel:child("weapons_panel"):child("secondary_ammo_panel"):child("secondary_ammo_amount"):h() / 2)
	self._secondary_ammo_text:set_center_x(self._custom_player_panel:child("weapons_panel"):child("secondary_ammo_panel"):child("secondary_ammo_amount"):x() + self._custom_player_panel:child("weapons_panel"):child("secondary_ammo_panel"):child("secondary_ammo_amount"):w() / 3.5)
end

function HUDTeammate:set_ammo_amount_by_type(type, ...)
	set_ammo_amount_by_type_original(self, type, ...)
	
	local selected_ammo_panel = self._custom_player_panel:child("weapons_panel"):child(type.."_ammo_panel")
	local ammo_amount = selected_ammo_panel:child(type.."_ammo_amount")
	if self._main_player and self._bullet_storm then
		ammo_amount:set_text( "" )
	end
end 

function HUDTeammate:_set_bulletstorm( state )
	self._bullet_storm = state
 
    if self._bullet_storm then
	    local hudinfo = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		local weapons_panel = self._custom_player_panel:child("weapons_panel")
		local primary_ammo_panel = weapons_panel:child("primary_ammo_panel")
		local secondary_ammo_panel = weapons_panel:child("secondary_ammo_panel")
		local primary_ammo_amount = primary_ammo_panel:child("primary_ammo_amount")
		local secondary_ammo_amount = secondary_ammo_panel:child("secondary_ammo_amount")

		self._primary_ammo:set_visible(true)
		self._secondary_ammo:set_visible(true)
		self._primary_ammo_text:set_visible(true)
		self._secondary_ammo_text:set_visible(true)
		self._primary_ammo:animate(hudinfo.flash_icon, 4000000000)
		self._secondary_ammo:animate(hudinfo.flash_icon, 4000000000)
		primary_ammo_amount:set_text( "" )
		secondary_ammo_amount:set_text( "" )
    else
        self._primary_ammo:set_visible(false)
		self._secondary_ammo:set_visible(false)		
		self._primary_ammo_text:set_visible(false)
		self._secondary_ammo_text:set_visible(false)
	end
end

function HUDTeammate:set_custom_radial(data)
	set_custom_radial_orig(self, data)
    local duration = data.current / data.total
	local aced = managers.player:upgrade_level("player", "berserker_no_ammo_cost", 0) == 1
	if self._main_player and aced then
        if duration > 0 then
            managers.hud:set_bulletstorm(true)
        else
            managers.hud:set_bulletstorm(false)
        end
    end
end