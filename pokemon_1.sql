--csv into sql
.mode csv
.import pokemon.csv imported_pokemon_data;

--create table for pokemon data
CREATE TABLE pokemon (
	abilities TEXT NOT NULL,
	against_bug INTEGER NOT NULL,
	against_dark INTEGER NOT NULL,
	against_dragon INTEGER NOT NULL,
	against_electric INTEGER NOT NULL,
	against_fairy INTEGER NOT NULL,
	against_fight INTEGER NOT NULL,
	against_fire INTEGER NOT NULL,
	against_flying INTEGER NOT NULL,
	against_ghost INTEGER NOT NULL,
	against_grass INTEGER NOT NULL,
	against_ground INTEGER NOT NULL,
	against_ice INTEGER NOT NULL,
	against_normal INTEGER NOT NULL,
	against_poison INTEGER NOT NULL,
	against_psychic INTEGER NOT NULL,
	against_rock INTEGER NOT NULL,
	against_steel INTEGER NOT NULL,
	against_water INTEGER NOT NULL,
	attack INTEGER NOT NULL,
	base_egg_steps INTEGER NOT NULL,
	base_happiness INTEGER NOT NULL,
	base_total INTEGER NOT NULL,
	capture_rate INTEGER NOT NULL,
	classfication TEXT NOT NULL,
	defense INTEGER NOT NULL,
	experience_growth INTEGER NOT NULL,
	height_m TEXT,
	hp INTEGER NOT NULL,
	name TEXT NOT NULL,
	percentage_male INTEGER,
	pokedex_number INTEGER PRIMARY KEY,
	sp_attack INTEGER NOT NULL,
	sp_defense INTEGER NOT NULL,
	speed INTEGER NOT NULL,
	type1 TEXT NOT NULL,
	type2 TEXT,
	weight_kg TEXT,
	generation INTEGER NOT NULL,
	is_legendary INTEGER NOT NULL);

--data from imported csv to pokemon table
INSERT INTO pokemon (abilities, against_bug, against_dark, against_dragon, against_electric, against_fairy, 
	against_fight, against_fire, against_flying, against_ghost, against_grass, against_ground, against_ice, against_normal,
	against_poison, against_psychic, against_rock, against_steel, against_water, attack, base_egg_steps, base_happiness,
	base_total, capture_rate, classfication, defense, experience_growth, height_m, hp, name, percentage_male, 
	pokedex_number, sp_attack, sp_defense, speed, type1, type2, weight_kg, generation, is_legendary)
SELECT abilities, against_bug, against_dark, against_dragon, against_electric, against_fairy, 
	against_fight, against_fire, against_flying, against_ghost, against_grass, against_ground, against_ice, against_normal,
	against_poison, against_psychic, against_rock, against_steel, against_water, attack, base_egg_steps, base_happiness,
	base_total, capture_rate, classfication, defense, experience_growth, height_m, hp, name, percentage_male, 
	pokedex_number, sp_attack, sp_defense, speed, type1, type2, weight_kg, generation, is_legendary
FROM imported_pokemon_data;

--1nf to split the abilities into separate rows
WITH split(pokedex_number, abilities, nextabilities) AS (
	SELECT pokedex_number, '' AS abilities, abilities|| ',' AS nextabilities
	FROM imported_pokemon_data
	UNION ALL
		SELECT pokedex_number,
			substr(nextabilities, 0, instr(nextabilities, ',')) AS abilities,
			substr(nextabilities, instr(nextabilities, ',') +1) AS nextabilities
		FROM split
		WHERE nextabilities != ' '
)
SELECT pokedex_number, abilities,
	replace(replace(replace(trim(abilities), '[', ''), ']', ''), '''', '') AS abilities
FROM split
WHERE abilities != ''
ORDER BY pokedex_number;