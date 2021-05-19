--==============================================================
--******			C I V I L I Z A T I O N S			  ******
--==============================================================

--==================
-- Aztec
--==================
-- INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType) VALUES
-- 	('TRAIT_AZTECS_FIVE_SUNS_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
-- INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
-- 	('TRAIT_AZTECS_FIVE_SUNS_MELEE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_MELEE'),
-- 	('TRAIT_AZTECS_FIVE_SUNS_MELEE_PRODUCTION', 'EraType', 'NO_ERA'),
-- 	('TRAIT_AZTECS_FIVE_SUNS_MELEE_PRODUCTION', 'Amount', '50');
-- INSERT OR IGNORE INTO TraitModifiers VALUES
-- 	('TRAIT_CIVILIZATION_LEGEND_FIVE_SUNS', 'TRAIT_AZTECS_FIVE_SUNS_MELEE_PRODUCTION');
-- -- Aztec Tlachtli Unique Building is now slightly cheaper and is +3 Culture instead of +2 Faith/+1 Culture
-- DELETE FROM Building_YieldChanges WHERE BuildingType='BUILDING_TLACHTLI' AND YieldType='YIELD_FAITH';
-- UPDATE Building_YieldChanges SET YieldChange=3 WHERE BuildingType='BUILDING_TLACHTLI';
-- UPDATE Buildings SET Cost=100 WHERE BuildingType='BUILDING_TLACHTLI';
--
-- -- Huey gives +2 culture to lake tiles
-- INSERT OR IGNORE INTO BuildingModifiers (BuildingType, ModifierId)
-- 	VALUES ('BUILDING_HUEY_TEOCALLI', 'HUEY_LAKE_CULTURE');
-- INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
-- 	VALUES
-- 	('HUEY_LAKE_CULTURE', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'FOODHUEY_PLAYER_REQUIREMENTS'),
-- 	('HUEY_LAKE_CULTURE_MODIFIER', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'FOODHUEY_PLOT_IS_LAKE_REQUIREMENTS');
-- INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value)
-- 	VALUES
-- 	('HUEY_LAKE_CULTURE', 'ModifierId', 'HUEY_LAKE_CULTURE_MODIFIER'),
-- 	('HUEY_LAKE_CULTURE_MODIFIER', 'Amount', '2'),
-- 	('HUEY_LAKE_CULTURE_MODIFIER', 'YieldType', 'YIELD_CULTURE');

-- Tlachtli +3 Culture instead +2
update Building_YieldChanges set YieldChange = 3 where BuildingType = 'BUILDING_TLACHTLI' and YieldType = 'YIELD_CULTURE';

-- Aztecs have +50% production towards melee units
insert or ignore into Modifiers (ModifierId, ModifierType) values ('TRAIT_AZTECS_FIVE_SUNS_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
insert or ignore into ModifierArguments (ModifierId, Name, Value) values ('TRAIT_AZTECS_FIVE_SUNS_MELEE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_MELEE'),
                                                                         ('TRAIT_AZTECS_FIVE_SUNS_MELEE_PRODUCTION', 'EraType', 'NO_ERA'),
                                                                         ('TRAIT_AZTECS_FIVE_SUNS_MELEE_PRODUCTION', 'Amount', '50');
insert or ignore into TraitModifiers values ('TRAIT_CIVILIZATION_LEGEND_FIVE_SUNS', 'TRAIT_AZTECS_FIVE_SUNS_MELEE_PRODUCTION');

-- Eagle warrior no longer replaces warrior but swordsman (with all its values)
update Units set Combat = 35, Cost = 90, Maintenance = 2, PrereqTech = 'TECH_IRON_WORKING', MandatoryObsoleteTech = 'TECH_REPLACEABLE_PARTS' where UnitType = 'UNIT_AZTEC_EAGLE_WARRIOR';
update UnitReplaces set ReplacesUnitType = 'UNIT_SWORDSMAN' where CivUniqueUnitType = 'UNIT_AZTEC_EAGLE_WARRIOR';
update UnitUpgrades set UpgradeUnit = 'UNIT_MAN_AT_ARMS' where Unit = 'UNIT_AZTEC_EAGLE_WARRIOR';

-- Eagle warrior can see through forest / jungle and has no movement penalty (ability of kongos nagao unit).
insert or ignore into Modifiers select 'EAGLE_WARRIOR_FOREST_MOVEMENT', ModifierType, RunOnce, NewOnly, Permanent, Repeatable, OwnerRequirementSetId, SubjectRequirementSetId, OwnerStackLimit, SubjectStackLimit from Modifiers where ModifierId = 'NAGAO_FOREST_MOVEMENT';
insert or ignore into ModifierArguments select 'EAGLE_WARRIOR_FOREST_MOVEMENT', Name, Type, Value, Extra, SecondExtra from ModifierArguments where ModifierId = 'NAGAO_FOREST_MOVEMENT';
insert or ignore into UnitAbilities select 'ABILITY_EAGLE_WARRIOR', 'LOC_ABILITY_EAGLE_WARRIOR_NAME', 'LOC_ABILITY_EAGLE_WARRIOR_DESCRIPTION', Inactive, ShowFloatTextWhenEarned, Permanent from UnitAbilities where UnitAbilityType = 'ABILITY_NAGAO';
insert or ignore into UnitAbilityModifiers (UnitAbilityType, ModifierId) values ('ABILITY_EAGLE_WARRIOR', 'EAGLE_WARRIOR_FOREST_MOVEMENT');
insert or ignore into Types (Type, Kind) values ('ABILITY_EAGLE_WARRIOR', 'KIND_ABILITY');
insert or ignore into TypeTags (Type, Tag) values ('ABILITY_EAGLE_WARRIOR', 'CLASS_EAGLE_WARRIOR'), ('UNIT_AZTEC_EAGLE_WARRIOR', 'CLASS_EAGLE_WARRIOR');
insert or ignore into Tags (Tag, Vocabulary) values ('CLASS_EAGLE_WARRIOR', 'ABILITY_CLASS');
