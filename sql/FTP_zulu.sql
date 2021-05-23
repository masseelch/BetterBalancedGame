-- Stolen from the mod Civilizations Expanded: Zulu by p0kiehl. Altered by masseelch.
--=============================================================================================================
-- CIVILIZATION UNIQUE ABILITY: ISIBONGO (ENHANCEMENT)
--=============================================================================================================
-- Cities with a garrisoned unit gain +3 Loyalty and +1 Amenity, doubling if the garrisoned unit is a Corps or Army.
-- Gold and resource costs for unit upgrades are discounted 50%.
--=============================================================================================================
-- Modifiers
---------------------------------------------------------------------------------------------------------------
insert into Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
values ('P0K_TRAIT_GARRISON_CORPS_AMENITY', 'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_AMENITY', 'CITY_HAS_GARRISON_CORPS_REQUIREMENT'),
       ('P0K_TRAIT_GARRISON_ARMY_AMENITY', 'MODIFIER_PLAYER_CITIES_ADJUST_POLICY_AMENITY', 'CITY_HAS_GARRISON_ARMY_REQUIREMENT');
---------------------------------------------------------------------------------------------------------------
-- ModifierArguments
---------------------------------------------------------------------------------------------------------------
-- update ModifierArguments
-- set Value = 3
-- where ModifierId = 'TRAIT_ISIBONGO_GARRISONFORMATIONIDENTITY';

insert into ModifierArguments (ModifierId, Name, Value)
values ('P0K_TRAIT_GARRISON_CORPS_AMENITY', 'Amount', 1),
       ('P0K_TRAIT_GARRISON_ARMY_AMENITY', 'Amount', 1);
---------------------------------------------------------------------------------------------------------------
-- TraitModifiers
---------------------------------------------------------------------------------------------------------------
insert into TraitModifiers (TraitType, ModifierId)
values ('TRAIT_CIVILIZATION_ZULU_ISIBONGO', 'P0K_TRAIT_GARRISON_CORPS_AMENITY'),
       ('TRAIT_CIVILIZATION_ZULU_ISIBONGO', 'P0K_TRAIT_GARRISON_ARMY_AMENITY');
