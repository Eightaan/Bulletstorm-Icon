if VHUDPlus or WolfHUD and WolfHUD:getSetting({"CustomHUD", "ENABLED"}, true) then return end

local init_original = HUDTeammate.init
local set_ammo_amount_by_type_original = HUDTeammate.set_ammo_amount_by_type

function HUDTeammate:init(...)
    init_original(self, ...)
	if self._main_player then
	    self:inject_ammo_glow()
	end
end

function HUDTeammate:inject_ammo_glow()
	self._primary_ammo = self._player_panel:child("weapons_panel"):child("primary_weapon_panel"):bitmap({
		align           = "center",
		w 				= 50,
		h 				= 45,
		name 			= "primary_ammo",
		visible 		= false,
		texture 		= "guis/textures/pd2/crimenet_marker_glow",
		color 			= Color("00AAFF"),
		layer 			= 2,
		blend_mode 		= "add"
	})
	self._secondary_ammo = self._player_panel:child("weapons_panel"):child("secondary_weapon_panel"):bitmap({
		align           = "center",
		w 				= 50,
		h 				= 45,
		name 			= "secondary_ammo",
		visible 		= false,
		texture 		= "guis/textures/pd2/crimenet_marker_glow",
		color 			= Color("00AAFF"),
		layer 			= 2,
		blend_mode 		= "add"
	})
	self._primary_ammo:set_center_y(self._player_panel:child("weapons_panel"):child("primary_weapon_panel"):child("ammo_clip"):y() + self._player_panel:child("weapons_panel"):child("primary_weapon_panel"):child("ammo_clip"):h() / 2 - 2)
	self._secondary_ammo:set_center_y(self._player_panel:child("weapons_panel"):child("secondary_weapon_panel"):child("ammo_clip"):y() + self._player_panel:child("weapons_panel"):child("secondary_weapon_panel"):child("ammo_clip"):h() / 2 - 2)
    self._primary_ammo:set_center_x(self._player_panel:child("weapons_panel"):child("primary_weapon_panel"):child("ammo_clip"):x() + self._player_panel:child("weapons_panel"):child("primary_weapon_panel"):child("ammo_clip"):w() / 2)
	self._secondary_ammo:set_center_x(self._player_panel:child("weapons_panel"):child("secondary_weapon_panel"):child("ammo_clip"):x() + self._player_panel:child("weapons_panel"):child("secondary_weapon_panel"):child("ammo_clip"):w() / 2)
end

function HUDTeammate:set_ammo_amount_by_type(type, ...)
	set_ammo_amount_by_type_original(self, type, ...)

	local weapon_panel = self._player_panel:child( "weapons_panel" ):child( type .. "_weapon_panel" )
	local ammo_clip = weapon_panel:child( "ammo_clip" )

	if self._main_player and self._bullet_storm then
	    ammo_clip:set_color(Color.white)
		ammo_clip:set_text( "8" )
		ammo_clip:set_rotation( 90 )
	else
		ammo_clip:set_rotation( 0 )
	end
end 

function HUDTeammate:_set_bulletstorm( state )
	self._bullet_storm = state
 
	if not self._primary_ammo then return end

    if self._bullet_storm then
	    local hudinfo = managers.hud:script(PlayerBase.PLAYER_INFO_HUD_PD2)
		local pweapon_panel = self._player_panel:child( "weapons_panel" ):child( "primary_weapon_panel" )
		local pammo_clip = pweapon_panel:child( "ammo_clip" )
		local sweapon_panel = self._player_panel:child( "weapons_panel" ):child( "secondary_weapon_panel" )
		local sammo_clip = sweapon_panel:child( "ammo_clip" )

		self._primary_ammo:set_visible(true)
		self._secondary_ammo:set_visible(true)
		self._primary_ammo:animate(hudinfo.flash_icon, 4000000000)
		self._secondary_ammo:animate(hudinfo.flash_icon, 4000000000)

		pammo_clip:set_color(Color.white)
		pammo_clip:set_text( "8" )
		pammo_clip:set_rotation( 90 )

		sammo_clip:set_color(Color.white)
		sammo_clip:set_text( "8" )
		sammo_clip:set_rotation( 90 )	
    else
        self._primary_ammo:set_visible(false)
		self._secondary_ammo:set_visible(false)		
	end
end

local set_custom_radial_orig = HUDTeammate.set_custom_radial
function HUDTeammate:set_custom_radial(data)
	set_custom_radial_orig(self, data)
    local duration = data.current / data.total
	local aced = managers.player:upgrade_level("player", "berserker_no_ammo_cost", 0) == 1
    if  self._main_player and aced and duration > 0 then
        managers.hud:set_bulletstorm(true)
    else
        managers.hud:set_bulletstorm(false)
    end
end