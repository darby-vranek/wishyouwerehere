local MakePlayerCharacter = require("prefabs/player_common")

local assets =
{
	Asset("ANIM", "anim/wendy.zip"),
	Asset("ANIM", "anim/wendy_channel.zip"),
    Asset("ANIM", "anim/wendy_channel_flower.zip"),
    Asset("ANIM", "anim/wendy_mount_channel.zip"),
    Asset("ANIM", "anim/wendy_flower_over.zip"),
    Asset("ANIM", "anim/player_idles_wendy.zip"),
}

local prefabs =
{
	"abby_flower",
	"abigailsummonfx",
    "abigailsummonfx_mount",
    "abigailunsummonfx",
    "abigailunsummonfx_mount",
}

local start_inv =
{
	"abby_flower"
}

local fn = function(inst)
	inst.soundsname = "wendy"
	inst:SetStateGraph("SGwilson")

	inst.AnimState:SetBuild("wendy")

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "wendst.tex" )

	inst.components.health:SetMaxHealth(150)
	inst.components.hunger:SetMax(150)
	inst.components.sanity:SetMax(200)

	inst.components.combat.damagemultiplier = .75

	inst.AnimState:AddOverrideBuild("wendy_channel")
    inst.AnimState:AddOverrideBuild("wendy_channel_flower")
    inst.AnimState:AddOverrideBuild("player_idles_wendy")
    inst.AnimState:AddOverrideBuild("wendy_commune")

end

return MakePlayerCharacter("wendst", prefabs, assets, fn, start_inv)
