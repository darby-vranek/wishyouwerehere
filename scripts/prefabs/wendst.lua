local MakePlayerCharacter = require("prefabs/player_common")

local assets =
{
	Asset("ANIM", "anim/wendy.zip"),
}

local prefabs =
{
}

local start_inv =
{
}

local fn = function(inst)
	inst.soundsname = "wendy"

	inst.AnimState:SetBuild("wendy")
	
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "wendst.tex" )
	
	inst.components.health:SetMaxHealth(150)
	inst.components.hunger:SetMax(150)
	inst.components.sanity:SetMax(200)

	inst.components.combat.damagemultiplier = .75
	
end

return MakePlayerCharacter("wendst", prefabs, assets, fn, start_inv)
