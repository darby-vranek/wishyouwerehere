local assets =
{
    Asset("ANIM", "anim/abigail_flower_rework.zip"),
    -- not sure if I need this one
    Asset("IMAGE", "images/inventoryimages/inventoryimages1.tex"),
	Asset("ATLAS", "images/inventoryimages/abigail_flower_level0.xml"),
	Asset("ATLAS", "images/inventoryimages/abigail_flower_level2.xml"),
	Asset("ATLAS", "images/inventoryimages/abigail_flower_level3.xml"),
}


local function getstatus(inst)
	local _bond_level = inst._bond_level

	return _bond_level == 1 and "LEVEL1"
		or _bond_level == 2 and "LEVEL2"
		or _bond_level == 3 and "LEVEL3"
		or nil
	end

local function updateimage(inst)
	if inst._bond_level == 1 then
		inst.components.inventoryitem.atlasname = "images/inventoryimages/abigail_flower_level0.xml"
		inst.components.inventoryitem:ChangeImageName("abigail_flower_level3")
		inst.AnimState:PlayAnimation("level0_pre")
		inst.AnimState:PushAnimation("level0_loop")
	elseif inst._bond_level == 2 then
		inst.components.inventoryitem.atlasname = "images/inventoryimages/abigail_flower_level2.xml"
		inst.components.inventoryitem:ChangeImageName("abigail_flower_level2")
		inst.AnimState:PlayAnimation("level2_pre")
		inst.AnimState:PushAnimation("level2_loop")

	elseif inst._bond_level == 3 then
		inst.components.inventoryitem.atlasname = "images/inventoryimages/abigail_flower_level3.xml"
		inst.components.inventoryitem:ChangeImageName("abigail_flower_level3")
		inst.AnimState:PlayAnimation("level3_pre")
		inst.AnimState:PushAnimation("level3_loop")
	end

end

local function fn()
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local anim = inst.entity:AddAnimState()
	local sound = inst.entity:AddSoundEmitter()

	local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon( "abigail_flower.png" )

	anim:SetBank("abigail_flower_rework")
	anim:SetBuild("abigail_flower_rework")
	inst.AnimState:PlayAnimation("level3_pre")
	inst.AnimState:PushAnimation("level3_loop")
	MakeInventoryPhysics(inst)


	-- not sure if this is gonna work, but i will leave it here for now
	-- local minimap = inst.entity:AddMiniMapEntity()
    -- minimap:SetIcon( "abigail_flower.png" )

    -- this should be set to 0 but for now i want it to be easier to check
    inst._bond_level = 3

	inst:AddComponent("inspectable")
	inst.components.inspectable.getstatus = getstatus

	inst:AddComponent("inventoryitem")
	updateimage(inst)

	inst:AddComponent("summoningitem")

	return inst
end

--


local assets_summonfx =
{
    Asset("ANIM", "anim/wendy_channel_flower.zip"),
    Asset("ANIM", "anim/wendy_mount_channel_flower.zip"),
}

local assets_unsummonfx =
{
    Asset("ANIM", "anim/wendy_recall_flower.zip"),
    Asset("ANIM", "anim/wendy_mount_recall_flower.zip"),
}

local assets_levelupfx =
{
    Asset("ANIM", "anim/abigail_flower_change.zip"),
}

local function AlignToTarget(inst)
	local parent = inst.entity:GetParent()
	if parent ~= nil then
	    inst.Transform:SetRotation(parent.Transform:GetRotation())
	end
end

local function MakeSummonFX(anim, use_anim_for_build, is_mounted)
    return function()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()

        inst:AddTag("FX")

		if is_mounted then
	        inst.Transform:SetSixFaced()
		else
	        inst.Transform:SetFourFaced()
		end


        inst.AnimState:SetBank(anim)
		if use_anim_for_build then
	        inst.AnimState:SetBuild(anim)
	        inst.AnimState:OverrideSymbol("flower", "abigail_flower_rework", "flower")
		else
	        inst.AnimState:SetBuild("abigail_flower_rework")
		end
        inst.AnimState:PlayAnimation(anim)

		if is_mounted then
			inst:AddComponent("updatelooper")
			inst.components.updatelooper:AddOnWallUpdateFn(AlignToTarget)
		end


        --Anim is padded with extra blank frames at the end
        inst:ListenForEvent("animover", inst.Remove)

        return inst
    end
end

return Prefab("abby_flower", fn, assets),
	Prefab("abigailsummonfx", MakeSummonFX("wendy_channel_flower", true, false), assets_summonfx),
    Prefab("abigailsummonfx_mount", MakeSummonFX("wendy_mount_channel_flower", true, true), assets_summonfx),
	Prefab("abigailunsummonfx", MakeSummonFX("wendy_recall_flower", false, false), assets_unsummonfx),
    Prefab("abigailunsummonfx_mount", MakeSummonFX("wendy_mount_recall_flower", false, true), assets_unsummonfx),
	Prefab("abigaillevelupfx", MakeSummonFX("abigail_flower_change", false, false), assets_levelupfx)
