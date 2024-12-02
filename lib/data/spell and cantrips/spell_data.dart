final Map<String, Map<String, dynamic>> spellsByClass = {
  "Barbarian": {
    "Cantrips": [], // No spellcasting for Barbarians by default
    "FirstLevel": [],
    "SpellsKnown": {
      'Cantrips': 0,
      "FirstLevelSpells": 0,
    },
  },
  "Bard": {
    "Cantrips": [
      "Blade Ward",
      "Dancing Lights",
      "Friends",
      "Light",
      "Mage Hand",
      "Mending",
      "Message",
      "Minor Illusion",
      "Prestidigitation",
      "True Strike",
      "Vicious Mockery",
    ],
    "FirstLevel": [
      "Animal Friendship",
      "Bane",
      "Charm Person",
      "Comprehend Languages",
      "Cure Wounds",
      "Detect Magic",
      "Disguise Self",
      "Dissonant Whispers",
      "Faerie Fire",
      "Feather Fall",
      "Healing Word",
      "Heroism",
      "Identify",
      "Illusory Script",
      "Longstrider",
      "Silent Image",
      "Sleep",
      "Speak with Animals",
      "Tasha's Hideous Laughter",
      "Thunderwave",
      "Unseen Servant",
    ],
    "SpellsKnown": {
      "Cantrips": 2,
      "FirstLevelSpells": 4, // Known, not counting spell slots
    },
  },
  "Cleric": {
    "Cantrips": [
      "Guidance",
      "Light",
      "Mending",
      "Resistance",
      "Sacred Flame",
      "Spare the Dying",
      "Thaumaturgy",
    ],
    "FirstLevel": [
      "Bane",
      "Bless",
      "Command",
      "Create or Destroy Water",
      "Cure Wounds",
      "Detect Evil and Good",
      "Detect Magic",
      "Detect Poison and Disease",
      "Guiding Bolt",
      "Healing Word",
      "Inflict Wounds",
      "Protection from Evil and Good",
      "Purify Food and Drink",
      "Sanctuary",
      "Shield of Faith",
    ],
    "SpellsKnown": {
      "Cantrips": 3,
      "FirstLevelSpells": 4, // (WIS Mod + Cleric level, typically 4 at Level 1)
    },
  },
  "Druid": {
    "Cantrips": [
      "Control Flames",
      "Create Bonfire",
      "Druidcraft",
      "Frostbite",
      "Guidance",
      "Gust",
      "Magic Stone",
      "Mending",
      "Mold Earth",
      "Poison Spray",
      "Produce Flame",
      "Resistance",
      "Shape Water",
      "Shillelagh",
      "Thorn Whip",
    ],
    "FirstLevel": [
      "Absorb Elements",
      "Animal Friendship",
      "Charm Person",
      "Create or Destroy Water",
      "Cure Wounds",
      "Detect Magic",
      "Detect Poison and Disease",
      "Entangle",
      "Faerie Fire",
      "Fog Cloud",
      "Goodberry",
      "Healing Word",
      "Ice Knife",
      "Jump",
      "Longstrider",
      "Purify Food and Drink",
      "Speak with Animals",
      "Thunderwave",
    ],
    "SpellsKnown": {
      "Cantrips": 2,
      "FirstLevelSpells": 4, // (WIS Mod + Druid level, typically 4 at Level 1)
    },
  },
  "Fighter": {
    "Cantrips": [], // Eldritch Knight subclass only
    "FirstLevel": [],
    "SpellsKnown": {
      "Cantrips": 0,
      "FirstLevelSpells": 0,
    },
  },
  "Paladin": {
    "Cantrips": [], // Paladins don’t have cantrips
    "FirstLevel": [
      "Bless",
      "Command",
      "Compelled Duel",
      "Cure Wounds",
      "Detect Evil and Good",
      "Detect Magic",
      "Detect Poison and Disease",
      "Divine Favor",
      "Heroism",
      "Protection from Evil and Good",
      "Purify Food and Drink",
      "Searing Smite",
      "Shield of Faith",
      "Thunderous Smite",
      "Wrathful Smite",
    ],
    "SpellsKnown": {
      "Cantrips": 0,
      "FirstLevelSpells": 2, // Based on CHA mod + half Paladin level, typically 2 at Level 1
    },
  },
  "Ranger": {
    "Cantrips": [], // Rangers don’t have cantrips
    "FirstLevel": [
      "Absorb Elements",
      "Alarm",
      "Animal Friendship",
      "Cure Wounds",
      "Detect Magic",
      "Detect Poison and Disease",
      "Ensnaring Strike",
      "Fog Cloud",
      "Goodberry",
      "Hail of Thorns",
      "Hunter's Mark",
      "Jump",
      "Longstrider",
      "Speak with Animals",
    ],
    "SpellsKnown": {
      "Cantrips": 0,
      "FirstLevelSpells": 2, // Based on WIS mod + half Ranger level, typically 2 at Level 1
    },
  },
  "Rogue": {
    "Cantrips": [], // Arcane Trickster subclass only
    "FirstLevel": [],
    "SpellsKnown": {
      "Cantrips": 0,
      "FirstLevelSpells": 0,
    },
  },
  "Sorcerer": {
    "Cantrips": [
      "Acid Splash",
      "Blade Ward",
      "Chill Touch",
      "Control Flames",
      "Dancing Lights",
      "Fire Bolt",
      "Friends",
      "Frostbite",
      "Light",
      "Mage Hand",
      "Mending",
      "Message",
      "Minor Illusion",
      "Prestidigitation",
      "Ray of Frost",
      "Shape Water",
      "Shocking Grasp",
      "Thunderclap",
      "True Strike",
    ],
    "FirstLevel": [
      "Burning Hands",
      "Charm Person",
      "Chromatic Orb",
      "Color Spray",
      "Comprehend Languages",
      "Detect Magic",
      "Disguise Self",
      "Expeditious Retreat",
      "False Life",
      "Feather Fall",
      "Mage Armor",
      "Magic Missile",
      "Shield",
      "Silent Image",
      "Sleep",
      "Thunderwave",
    ],
    "SpellsKnown": {
      "Cantrips": 4,
      "FirstLevelSpells": 2, // Fixed based on Sorcerer table
    },
  },
  "Warlock": {
    "Cantrips": [
      "Blade Ward",
      "Chill Touch",
      "Create Bonfire",
      "Eldritch Blast",
      "Friends",
      "Mage Hand",
      "Minor Illusion",
      "Prestidigitation",
      "True Strike",
    ],
    "FirstLevel": [
      "Armor of Agathys",
      "Arms of Hadar",
      "Charm Person",
      "Comprehend Languages",
      "Expeditious Retreat",
      "Hellish Rebuke",
      "Hex",
      "Illusory Script",
      "Protection from Evil and Good",
      "Unseen Servant",
      "Witch Bolt",
    ],
    "SpellsKnown": {
      "Cantrips": 2,
      "FirstLevelSpells": 2, // Fixed based on Warlock table
    },
  },
  "Wizard": {
    "Cantrips": [
      "Acid Splash",
      "Blade Ward",
      "Chill Touch",
      "Control Flames",
      "Create Bonfire",
      "Dancing Lights",
      "Fire Bolt",
      "Friends",
      "Frostbite",
      "Gust",
      "Light",
      "Mage Hand",
      "Mending",
      "Message",
      "Minor Illusion",
      "Mold Earth",
      "Poison Spray",
      "Prestidigitation",
      "Ray of Frost",
      "Shape Water",
      "Shocking Grasp",
      "Thunderclap",
      "True Strike",
    ],
    "FirstLevel": [
      "Alarm",
      "Burning Hands",
      "Charm Person",
      "Color Spray",
      "Comprehend Languages",
      "Detect Magic",
      "Disguise Self",
      "Expeditious Retreat",
      "False Life",
      "Feather Fall",
      "Find Familiar",
      "Fog Cloud",
      "Grease",
      "Identify",
      "Illusory Script",
      "Mage Armor",
      "Magic Missile",
      "Shield",
      "Silent Image",
      "Sleep",
      "Tasha's Hideous Laughter",
      "Tenser's Floating Disk",
      "Thunderwave",
      "Unseen Servant",
    ],
    "SpellsKnown": {
      "Cantrips": 3,
      "FirstLevelSpells": 6, // From Wizard Spellbook
    },
  },
};
