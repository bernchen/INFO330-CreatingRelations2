--csv into sql
.mode csv
.import pokemon.csv imported_pokemon_data;

---create table for pokemon data
CREATE TABLE thepokemon (
	pokedex_number INTEGER PRIMARY KEY,
	name TEXT NOT NULL,
	type1 TEXT NOT NULL,
	type2 TEXT,
	abilities TEXT NOT NULL,
	classfication TEXT NOT NULL,
	capture_rate INTEGER NOT NULL,
	attack INTEGER NOT NULL,
	defense INTEGER NOT NULL,
	sp_attack INTEGER NOT NULL,
	sp_defense INTEGER NOT NULL,
	base_egg_steps INTEGER NOT NULL,
	base_happiness INTEGER NOT NULL,
	base_total INTEGER NOT NULL,
	height_m TEXT,
	weight_kg TEXT,
	experience_growth INTEGER NOT NULL,
	hp INTEGER NOT NULL,
	speed INTEGER NOT NULL,
	percentage_male INTEGER,
	generation INTEGER NOT NULL,
	is_legendary INTEGER NOT NULL
);

--create types table based on type and pokedex_number
CREATE TABLE types (
	pokedex_number INTEGER,
	type1 TEXT NOT NULL,
	type2 TEXT,
	type TEXT,
	FOREIGN KEY (pokedex_number) REFERENCES thepokemon (pokedex_number)
);

--insert data into thepokemon table
INSERT INTO thepokemon (pokedex_number, name, type1, type2, abilities, classfication,
	capture_rate, attack, defense, sp_attack, sp_defense, base_egg_steps, base_happiness, base_total,
	height_m, weight_kg, experience_growth, hp, speed, percentage_male, generation, is_legendary)
SELECT pokedex_number, name, type1, type2, abilities, classfication, 
	capture_rate, attack, defense, sp_attack, sp_defense, base_egg_steps, base_happiness, base_total,
	height_m, weight_kg, experience_growth, hp, speed, percentage_male, generation, is_legendary
FROM imported_pokemon_data;

--split the abilities into separate rows
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