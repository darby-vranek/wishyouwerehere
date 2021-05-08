GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

STRINGS.NAMES.WINONA = "Winona"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WINONA = "Will update with their quotes for Winona for you console-spawners."

PrefabFiles = {
	"winona",
}

Assets = { 
	
    Asset( "IMAGE", "images/saveslot_portraits/winona.tex" ),
	Asset( "ATLAS", "images/saveslot_portraits/winona.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/winona.tex" ),
	Asset( "ATLAS", "images/selectscreen_portraits/winona.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/winona_silho.tex" ),
	Asset( "ATLAS", "images/selectscreen_portraits/winona_silho.xml" ),
	
    Asset( "IMAGE", "bigportraits/winona.tex" ),
	Asset( "ATLAS", "bigportraits/winona.xml" ),
	
	Asset( "IMAGE", "minimap/winona.tex" ),
	Asset( "ATLAS", "minimap/winona.xml" ),
	
	Asset("SOUNDPACKAGE", "sound/winona.fev"),	
	Asset("SOUND", "sound/winona.fsb"),
	
	Asset("SOUNDPACKAGE", "sound/winona_items.fev"),	
	Asset("SOUND", "sound/winona_items.fsb"),
}
AddMinimapAtlas("minimap/winona.xml")

RemapSoundEvent( "dontstarve/characters/winona/death_voice", "winona/characters/winona/death_voice" )
RemapSoundEvent( "dontstarve/characters/winona/hurt", "winona/characters/winona/hurt" )
RemapSoundEvent( "dontstarve/characters/winona/talk_LP", "winona/characters/winona/talk_LP" )

--------------------------------------------------------------------
STRINGS.CHARACTER_TITLES.winona = "The Handywoman"
STRINGS.CHARACTER_NAMES.winona = "Winona"
STRINGS.CHARACTER_DESCRIPTIONS.winona = "*Is a skilled builder\n*Gets one free hit from the dark\n*Brings her own tools"
STRINGS.CHARACTER_QUOTES.winona = "Anything can be fixed with hard work and elbow grease."
--------------------------------------------------------------------
STRINGS.CHARACTERS.WINONA = require "speech_winona"

table.insert(GLOBAL.CHARACTER_GENDERS.FEMALE, "winona")

AddModCharacter("winona")

local function newcomponents(inst)
	
end
AddPlayerPostInit(newcomponents)