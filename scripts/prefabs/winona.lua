local MakePlayerCharacter = require("prefabs/player_common")

local assets =
{
	Asset("ANIM", "anim/winona.zip"),
    Asset("SOUND", "sound/winona.fsb"),
}

local prefabs =
{
}

local start_inv =
{
}

local fn = function(inst)
	inst.soundsname = "winona"
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "winona.tex" )
	
	inst.components.health:SetMaxHealth(150)
	inst.components.hunger:SetMax(150)
	inst.components.sanity:SetMax(200)
	
end

return MakePlayerCharacter("winona", prefabs, assets, fn, start_inv)
