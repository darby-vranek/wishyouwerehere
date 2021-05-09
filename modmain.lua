GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

STRINGS.NAMES.WENDST = "Wendy"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WENDST = "Will update with their quotes for Winona for you console-spawners."

PrefabFiles = {
	"wendst",
}

Assets = { 
	-- Asset("ANIM", "anim/wendy.zip"),

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
	
	Asset("SOUNDPACKAGE", "sound/winona.fev"),	
	Asset("SOUND", "sound/winona.fsb"),
	
	Asset("SOUNDPACKAGE", "sound/winona_items.fev"),	
	Asset("SOUND", "sound/winona_items.fsb"),
}
AddMinimapAtlas("minimap/wendst.xml")

RemapSoundEvent( "dontstarve/characters/winona/death_voice", "winona/characters/winona/death_voice" )
RemapSoundEvent( "dontstarve/characters/winona/hurt", "winona/characters/winona/hurt" )
RemapSoundEvent( "dontstarve/characters/winona/talk_LP", "winona/characters/winona/talk_LP" )

--------------------------------------------------------------------
STRINGS.CHARACTER_TITLES.wendst = "The Bereaved"
STRINGS.CHARACTER_NAMES.wendst = "Wendy"
STRINGS.CHARACTER_DESCRIPTIONS.wendst = "*Is haunted by her twin sister\n*Feels comfortable in the dark\n*Doesn't hit very hard"
STRINGS.CHARACTER_QUOTES.wendst = "\"Abigail? Come back! I'm not done playing with you.\""
--------------------------------------------------------------------
STRINGS.CHARACTERS.WENDST = require "speech_wendst"

table.insert(GLOBAL.CHARACTER_GENDERS.FEMALE, "wendst")

AddModCharacter("wendst")

local function newcomponents(inst)
	
end
AddPlayerPostInit(newcomponents)