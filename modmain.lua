GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

STRINGS.NAMES.WENDST = "Wendy"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WENDST = "Not all deaths are the same."

PrefabFiles = {
"wendst",
"abby_flower"
}

Assets = {

	Asset( "IMAGE", "images/saveslot_portraits/wendst.tex" ),
	Asset( "ATLAS", "images/saveslot_portraits/wendst.xml" ),
	Asset( "IMAGE", "images/selectscreen_portraits/wendst.tex" ),
	Asset( "ATLAS", "images/selectscreen_portraits/wendst.xml" ),
	Asset( "IMAGE", "images/selectscreen_portraits/wendst_silho.tex" ),
	Asset( "ATLAS", "images/selectscreen_portraits/wendst_silho.xml" ),
	Asset( "IMAGE", "bigportraits/wendst.tex" ),
	Asset( "ATLAS", "bigportraits/wendst.xml" ),
	Asset( "IMAGE", "minimap/wendst.tex" ),
	Asset( "ATLAS", "minimap/wendst.xml" ),

	Asset("ANIM", "anim/abigail_flower_rework.zip"),
}
AddMinimapAtlas("minimap/wendst.xml")

--------------------------------------------------------------------

local ACTIONS = GLOBAL.ACTIONS
local Action = GLOBAL.Action
local ActionHandler = GLOBAL.ActionHandler
local State = GLOBAL.State

--------------------------------------------------------------------

STRINGS.CHARACTER_TITLES.wendst = "The Bereaved"
STRINGS.CHARACTER_NAMES.wendst = "Wendy"
STRINGS.CHARACTER_DESCRIPTIONS.wendst = "*Is haunted by her twin sister\n*Feels comfortable in the dark\n*Doesn't hit very hard"
STRINGS.CHARACTER_QUOTES.wendst = "\"Abigail? Come back! I'm not done playing with you.\""
STRINGS.CHARACTERS.WENDST = require "speech_wendst"

STRINGS.NAMES.ABBY_FLOWER = "Abigail's Flower"

STRINGS.CHARACTERS.WENDST.ANNOUNCE_ABIGAIL_RETRIEVE = "I'm sorry... it's not safe for you out here."
STRINGS.CHARACTERS.WENDST.ANNOUNCE_ABIGAIL_SUMMON =
{
	LEVEL1 = "I know you're tired, but I can't do this alone...",
	LEVEL2 = "I need your help, Abigail...",
	LEVEL3 = "You've rested in peace long enough, dear sister.",
}
STRINGS.CHARACTERS.WENDST.DESCRIBE.ABBY_FLOWER = {
	GENERIC = "It's still so pretty.",
	LEVEL1 = "It was my sister's flower. She's gone far away.",
	LEVEL2 = "I can sense Abigail's spirit growing stronger.",
	LEVEL3 = "Abigail! Are you ready to play?",
}
STRINGS.CHARACTERS.WENDST.ANNOUNCE_ABIGAIL_SUMMON = {
	LEVEL1 = "I know you're tired, but I can't do this alone...",
	LEVEL2 = "I need your help, Abigail...",
	LEVEL3 = "You've rested in peace long enough, dear sister.",
}
STRINGS.ACTIONS.COMMUNEWITHSUMMONED = {
	id ="COMMUNEWITHSUMMONED",
	GENERIC = "Commune",
	MAKE_AGGRESSIVE = "Rile Up",
	MAKE_DEFENSIVE = "Soothe",
}

--------------------------------------------------------------------
-- sg
--------------------------------------------------------------------

AddStategraphState("wilson", State{
	name = "summon_abigail",
	tags = { "doing", "busy", "nodangle", "canrotate" },

	onenter = function(inst)
		print("summon onenter")
		inst.components.locomotor:Stop()
		inst.AnimState:PlayAnimation("wendy_channel")
		inst.AnimState:PushAnimation("wendy_channel_pst", false)

		if inst.bufferedaction ~= nil then
            -- local flower = inst.bufferedaction.invobject
            -- if flower ~= nil then
            --     inst.AnimState:OverrideSymbol("flower", flower.AnimState:GetBuild(), "flower")
            -- end

            inst.sg.statemem.action = inst.bufferedaction
        end
	end,

	timeline =
	{
		TimeEvent(0 * FRAMES, function(inst)
			-- if inst.components.talker ~= nil and inst.components.ghostlybond ~= nil then -- add back when I have gb set up
			if inst.components.talker ~= nil then
				-- TODO need to make level based on bond level
				inst.components.talker:Say(GetString(inst.prefab, "ANNOUNCE_ABIGAIL_SUMMON", "LEVEL3"))
			end
		end),

		TimeEvent(6*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/common/haunted_flower_LP") end),
		TimeEvent(53*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/beefalo/saddle/shake_off") end),

		TimeEvent(52 * FRAMES, function(inst)
			inst.sg.statemem.fx = SpawnPrefab(inst.components.rider:IsRiding() and "abigailsummonfx_mount" or "abigailsummonfx")
			inst.sg.statemem.fx.entity:SetParent(inst.entity)
			inst.sg.statemem.fx.Transform:SetRotation(inst.Transform:GetRotation())
			inst.sg.statemem.fx.AnimState:SetTime(0) -- hack to force update the initial facing direction

			if inst.components.talker ~= nil then
				inst.components.talker:ShutUp()
			end
		end),
		TimeEvent(62 * FRAMES, function(inst)
			if inst:PerformBufferedAction() then
				inst.sg.statemem.fx = nil
			else
				inst.sg:GoToState("idle")
			end
		end),
		TimeEvent(74 * FRAMES, function(inst) inst.sg:RemoveStateTag("busy") end),
	},

	events =
	{
		EventHandler("animqueueover", function(inst)
			if inst.AnimState:AnimDone() then
				-- inst.sg:GoToState("idle")
			end
		end),
	},

	onexit = function(inst)
		inst.AnimState:ClearOverrideSymbol("flower")
		if inst.sg.statemem.fx ~= nil then
			inst.sg.statemem.fx:Remove()
		end
		if inst.bufferedaction == inst.sg.statemem.action then
			inst:ClearBufferedAction()
		end
	end,
})

AddStategraphState("wilson", State {
    name = "unsummon_abigail",
    tags = { "doing", "busy", "nodangle" },

    onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("wendy_recall")
        inst.AnimState:PushAnimation("wendy_recall_pst", false)

        if inst.bufferedaction ~= nil then
            -- local flower = inst.bufferedaction.invobject
            -- if flower ~= nil then
            --     inst.AnimState:OverrideSymbol("flower", flower.AnimState:GetBuild(), "flower")
            -- end

            inst.sg.statemem.action = inst.bufferedaction

            inst.components.talker:Say(GetString(inst.prefab, "ANNOUNCE_ABIGAIL_RETRIEVE"))
        end
    end,

    timeline =
    {
        TimeEvent(6*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_girl_attack_LP", "angry") end),
        TimeEvent(30*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/ghost/ghost_girl_attack_LP", "angry") end),
        TimeEvent(26 * FRAMES, function(inst)
            inst.sg:RemoveStateTag("busy")

            if inst.components.talker ~= nil then
                inst.components.talker:ShutUp()
            end

            local flower = nil
            if inst.bufferedaction ~= nil then
                flower = inst.bufferedaction.invobject
            end

            if inst:PerformBufferedAction() then
                local fx = SpawnPrefab(inst.components.rider:IsRiding() and "abigailunsummonfx_mount" or "abigailunsummonfx")
                fx.entity:SetParent(inst.entity)
                fx.Transform:SetRotation(inst.Transform:GetRotation())
                fx.AnimState:SetTime(0) -- hack to force update the initial facing direction

                -- if flower ~= nil then
                    -- local skin_build = flower:GetSkinBuild()
                    -- if skin_build ~= nil then
                    --     fx.AnimState:OverrideItemSkinSymbol("flower", skin_build, "flower", flower.GUID, flower.AnimState:GetBuild() )
                    -- end
                -- end
            else
                inst.sg:GoToState("idle")
            end
        end),
    },
	events =
    {
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },

    onexit = function(inst)
        inst.AnimState:ClearOverrideSymbol("flower")
        if inst.bufferedaction == inst.sg.statemem.action then
            inst:ClearBufferedAction()
        end
    end,
})

AddStategraphState("wilson", State{
    name = "commune_with_abigail",
    tags = { "doing", "busy", "nodangle" },

	onenter = function(inst)
        inst.components.locomotor:Stop()
        inst.AnimState:PlayAnimation("wendy_commune_pre")
        inst.AnimState:PushAnimation("wendy_commune_pst", false)

        if inst.bufferedaction ~= nil then
            local flower = inst.bufferedaction.invobject
            if flower ~= nil then
                inst.AnimState:OverrideSymbol("flower", "abigail_flower_rework", "flower")
            end

            inst.sg.statemem.action = inst.bufferedaction

        end
    end,

    timeline =
    {
        TimeEvent(14 * FRAMES, function(inst)
            inst:PerformBufferedAction()
        end),

        TimeEvent(35 * FRAMES, function(inst)
			inst.sg:RemoveStateTag("busy")
		end),
    },

    events =
    {
        EventHandler("animqueueover", function(inst)
            if inst.AnimState:AnimDone() then
                inst.sg:GoToState("idle")
            end
        end),
    },

    onexit = function(inst)
        inst.AnimState:ClearOverrideSymbol("flower")
        if inst.bufferedaction == inst.sg.statemem.action then
            inst:ClearBufferedAction()
        end
    end,
})

--------------------------------------------------------------------
-- actions
--------------------------------------------------------------------

local castsummon = function(act)
	print("castsummon")
	act.doer.sg:GoToState("summon_abigail")
end

local castunsummon = function(act)
	print("castunsummon")
	act.doer.sg:GoToState("unsummon_abigail")
end

local communewithsummoned = function(act)
	print("communewithsummoned")
	act.doer.sg:GoToState("commune_with_abigail")
end

--

local act_castsummon = Action({mount_enabled=true}, 3, true, true)
act_castsummon.id = "CASTSUMMON"
act_castsummon.fn = castsummon
act_castsummon.str = "Summon"

local act_castunsummon = Action({mount_enabled=true}, math.huge, false, true)
act_castunsummon.id = "CASTUNSUMMON"
act_castunsummon.fn = castunsummon
act_castunsummon.str = "Recall"

local act_communewithsummoned = Action({mount_enabled=true}, 3, true, true)
act_communewithsummoned.id = "COMMUNEWITHSUMMONED"
act_communewithsummoned.fn = communewithsummoned
act_communewithsummoned.str = "Commune"

AddAction(act_castsummon)
AddAction(act_castunsummon)
AddAction(act_communewithsummoned)

--------------------------------------------------------------------

table.insert(GLOBAL.CHARACTER_GENDERS.FEMALE, "wendst")

AddModCharacter("wendst")

local function newcomponents(inst)

end
AddPlayerPostInit(newcomponents)
