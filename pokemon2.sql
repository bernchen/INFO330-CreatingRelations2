--create abilities table
CREATE TABLE ability (
    ability_id INTEGER PRIMARY KEY,
    abilityname TEXT
);

-- create the pokemonabilities table to store relationship between pokemon and abilities
CREATE TABLE pokemonabilities (
    pokedex_number INTEGER,
    ability_id INTEGER,
    FOREIGN KEY (pokedex_number) REFERENCES pokemon (pokedex_number),
    FOREIGN KEY (ability_id) REFERENCES ability (ability_id)
);

-- add "abilities" column from the pokemon table to new pokemonabilities table
INSERT INTO pokemonabilities (pokedex_number, ability_id)
SELECT pokedex_number, ROW_NUMBER() OVER (ORDER BY abilityname) AS ability_id
FROM imported_pokemon_data, json_each(ability.abilityname)
WHERE json_each.value IS NOT NULL;
	
-- remove "abilities" column from pokemon table
ALTER TABLE pokemon
    DROP COLUMN abilities;
	
-- create the types table to store all pokemon types
CREATE TABLE types (
    type_id INTEGER PRIMARY KEY,
    type_name TEXT
);

-- create the pokemontypes table to store relationship between pokemon and types
CREATE TABLE pokemontypes (
    pokedex_number INTEGER,
    type_id INTEGER,
    FOREIGN KEY (pokedex_number) REFERENCES pokemon (pokedex_number),
    FOREIGN KEY (type_id) REFERENCES types (type_id)
);

-- add the "type1" and "type2" columns from the pokemon table to the new pokemontypes table
INSERT INTO pokemontypes (pokedex_number, type_id)
    SELECT pokedex_number, (SELECT type_id FROM types WHERE type_name = type1) AS type_id
    FROM pokemon;

INSERT INTO pokemontypes (pokedex_number, type_id)
    SELECT pokedex_number, (SELECT type_id FROM types WHERE type_name = type2) AS type_id
    FROM pokemon
    WHERE type2 IS NOT NULL;
	
-- remove type1 and type2 from pokemon table
ALTER TABLE pokemon
    DROP COLUMN type1 AND type2;