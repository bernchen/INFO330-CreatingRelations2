-- ability table to store each pokemon's abilities
CREATE TABLE  ability (
    ability_id INTEGER PRIMARY KEY,
    abilityname TEXT
);

--pokemon abilities table between thepokemon and ability
CREATE TABLE pokemonabilities (
    pokedex_number INTEGER,
    ability_id INTEGER,
    FOREIGN KEY (pokedex_number) REFERENCES thepokemon (pokedex_number),
    FOREIGN KEY (ability_id) REFERENCES abilities (ability_id)
);

-- add the "abilities" column from thepokemon table to new pokemonabilities table
INSERT INTO pokemonabilities (pokedex_number, ability_id)
SELECT pokedex_number, ROW_NUMBER() OVER (ORDER BY abilityname) AS ability_id
FROM thepokemon, json_each(abilities)
WHERE json_each.value IS NOT NULL;

--remove abilities duplicates from thepokemon
ALTER TABLE thepokemon
DROP COLUMN abilities;