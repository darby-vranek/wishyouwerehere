GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

STRINGS.NAMES.WENDST = "Wendy"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WENDST = "Will update with their quotes for Winona for you console-spawners."

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

-- not sure if I need these or if it's enough to reference them within abby_flower.lua
	-- it didn't break so I'm gonna leave it out for now
-- Asset("IMAGE", "images/inventoryimages/inventoryimages1.tex"),
-- Asset("ATLAS", "images/inventoryimages/abigail_flower_level0.xml"),
-- Asset("ATLAS", "images/inventoryimages/abigail_flower_level2.xml"),
-- Asset("ATLAS", "images/inventoryimages/abigail_flower_level3.xml"),
}
AddMinimapAtlas("minimap/wendst.xml")

--------------------------------------------------------------------

local ACTIONS = GLOBAL.ACTIONS
local Action = GLOBAL.Action

--------------------------------------------------------------------

STRINGS.CHARACTER_TITLES.wendst = "The Bereaved"
STRINGS.CHARACTER_NAMES.wendst = "Wendy"
STRINGS.CHARACTER_DESCRIPTIONS.wendst = "*Is haunted by her twin sister\n*Feels comfortable in the dark\n*Doesn't hit very hard"
STRINGS.CHARACTER_QUOTES.wendst = "\"Abigail? Come back! I'm not done playing with you.\""

STRINGS.CHARACTERS.WENDST = require "speech_wendst"

STRINGS.NAMES.ABBY_FLOWER = "Abigail's Flower"

STRINGS.CHARACTERS.WENDST.DESCRIBE.ABBY_FLOWER =
{
GENERIC = "It's still so pretty.",
LEVEL1 = "It was my sister's flower. She's gone far away.",
LEVEL2 = "I can sense Abigail's spirit growing stronger.",
LEVEL3 = "Abigail! Are you ready to play?",
}

--------------------------------------------------------------------
-- actions
--------------------------------------------------------------------

local castsummon = function(act)
	print("castsummon")
end

local castunsummon = function(act)
	print("castunsummon")
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

-- I really feel like I need a reference to AddAction here, but for now I'll just leave it and wait for it to break
AddAction(act_castsummon)
AddAction(act_castunsummon)

--------------------------------------------------------------------

table.insert(GLOBAL.CHARACTER_GENDERS.FEMALE, "wendst")

AddModCharacter("wendst")

local function newcomponents(inst)

end
AddPlayerPostInit(newcomponents)
