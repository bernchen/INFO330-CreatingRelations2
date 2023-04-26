--table for pokemon stats
CREATE TABLE pokemonstats (
	pokedex_number INTEGER,
    against_bug INTEGER NOT NULL,
    against_dark INTEGER NOT NULL,
    against_dragon INTEGER NOT NULL,
    against_electric INTEGER NOT NULL,
    against_fairy INTEGER NOT NULL,
    against_fight INTEGER NOT NULL,
    against_fire INTEGER,
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
	FOREIGN KEY (pokedex_number) REFERENCES pokemon (pokedex_number)
);

ALTER TABLE pokemonstats
ADD COLUMN against_water INTEGER NOT NULL;

--add pokemon stats
INSERT INTO pokemonstats (pokedex_number, against_bug, against_dark, against_dragon, 
	against_electric, against_fairy, against_fight, against_flying, against_ghost, against_grass, 
	against_ground, against_ice, against_normal, against_poison, against_psychic, against_rock,
	against_steel, against_water)
SELECT pokedex_number, against_bug, against_dark, against_dragon, 
	against_electric, against_fairy, against_fight, against_flying, against_ghost, against_grass, 
	against_ground, against_ice, against_normal, against_poison, against_psychic, against_rock,
	against_steel, against_water
FROM imported_pokemon_data;