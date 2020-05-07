## Properties
|Type | # | Description |
|-|-|-|
| INT | 5 | Weight of Item |
| INT | 19 | Value of Item |
| INT | 44 | Top End Damage |
| INT | 105 | Workmanship |
| INT | 131 | Material Type (See Lookup) |
| INT | 171 | Number of Tinks |
| INT | 179 | Imbue Effect (See Lookup) |
| Float | 22 | Variance |
| Float | 29 | Melee Def Skill (1.15 for 15%) |
| Float | 62 | Melee Atk Skill (1.15 for 15%) |
| Float | 63 | Missile Weapon Damage Mod |
| Float | 136 | Crushing Blow Multiplier |
| Float | 147 | Critical Strike Multiplier |
| Float | 144 | Mana Conversion Modifier (.05 for 5%) |
| Float | 149 | Missile Def Skill (1.15 for 15%) |
| Float | 150 | Magic Def Skill (1.15 for 15%) |
| Float | 152 | Elemental Damage |
| String | 1 | Object Name |
| String | 7 | Inscription |
| String | 8 | Inscriber |

## Imbue Lookup
| # | Description |
|-|-|
| 1 | Critical Strike (more crits) |
| 2 | Crippling Blow (stronger crits) |
| 4 | Armor Rend |
| 8 | Slash Rend |
| 16 | Pierce Rend |
| 32| Bludgeon Rend |
| 64| Acid Rend |
| 128 | Cold Rend |
| 256 | Electric Rend |
| 512 | Fire Rend |
| 1024 | Melee Defense |
| 2048 | Missile Defense |
| 4096 | Magic Defense |

## Material Lookup
| ID | Type | Skill | Description | WeenieID |
|-|-|-|-|-|
| 61 | Iron | Weapon | Increases maximum damage by 1 |  |
| 67 | Granite | Weapon | Improves a melee weapon's variance by 20% | 29576 |
| 57 | Brass | Weapon | Increases melee defense bonus by 1% | 21042 |
| 7 | Velvet | Weapon | Increases attack skill bonus by 1% |
| 74 | Mahogany | Weapon | Increases damage modifier by 4% (missile) | 29580 |
| 75 | Oak | Weapon | Decreases speed by 50 |
| 21 | Emerald | Weapon | Imbues Acid Rending | 30097 |
| 13 | Aquamarine | Weapon | Imbues Cold Rending | 30094 |
| 62 | Red Garnet | Weapon | Imbue Fire Rending | 30102 |
| 27 | Jet | Weapon | Imbues Lightning Rending | 30100 |
| 7 | White Sapphire | Weapon | Imbues Bludgeon Rending | 30104 |
| 14 | Black Garnet | Weapon | Imbues Pierce Rending | 30095 |
| 25 | Imperial Topaz | Weapon | Imbues Slash Rending. | 30099 |
| 41 | Sunstone | Magic Item | Imbues Armor Rending | 30103 |
| 21 | Fire Opal | Magic Item | Imbues Crippling Blow | 30098 |
| 14 | Black Opal | Magic Item | Imbues Critical Strike | 30096 |
| 67 | Green Garnet | Magic Item | Improves a wand's PvM and PvP damage modifier by 1% | 21050 |
| 33 | Opal | Magic Item | Increases the item's Mana Conversion bonus by 1% | 21065 |
| 64 | Steel | Armor | Armor Level by +20 | 29581 |
| 13 | Armoredillo Hide | Armor | Acid Protection by 0.4 | 20981 |
| 8 | Wool | Armor | Cold Protection by 0.4 | 20995 |
| 1 | Ceramic | Armor | Fire Protection by 0.4 | 20983 |
| 36 | Reedshark Hide | Armor | Lightning Protection by 0.4 | 20991 |
| 68 | Marble | Armor | Bludgeon Protection by 0.2 | 21061 |
| 66 | Alabaster | Armor | Piercing Protection by 0.2 | 20980 |
| 58 | Bronze | Armor | Slashing Protection by 0.2 | 20982 |
| 34 | Peridot | Armor | Imbues a +1 bonus to Melee Defense |
| 8 | Yellow Topaz | Armor | Imbues a +1 bonus to Missile Defense |
| 50 | Zircon | Armor | Imbues a +1 bonus to Magic Defense |
| 18 | Carnelian | Magic Item | Imbues Minor Strength |
| 63 | Smokey Quartz | Magic Item | Imbues Minor Coordination |
| 55 | Rose Quartz | Magic Item | Imbues Minor Quickness |
| 17 | Bloodstone | Magic Item | Imbues Minor Endurance |
| 10 | Agate | Magic Item | Imbues Minor Focus |
| 19 | Citrine | Magic Item | Imbues Minor Stamina Gain |
| 14 | Azurite | Magic Item | Imbues Wizard's Intellect |
| 25 | Hematite | Magic Item | Imbues Warrior's Vitality |
| 30 | Malachite | Magic Item | Imbues Warrior's Vigor |
| 59 | Copper | Item | Changes Missile Defense activation requirement to Melee Defense |
| 27 | Lapis Lazuli | Magic Item | Imbues Minor Willpower |
| 28 | Lavender Jade | Magic Item | Imbues Minor Mana Gain |
| 62 | Red Jade | Magic Item | Imbues Minor Health Gain |
| 52 | Leather | Special | Renders an item Retained |
| 4 | Linen | Item | Reduces the item's burden by 25% |
| 76 | Pine | Item | Reduces the item's value by 25% |