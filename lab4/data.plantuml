DROP TYPE IF EXISTS type_behaviour CASCADE;
DROP TYPE IF EXISTS type_weather CASCADE;
DROP TYPE IF EXISTS type_biome CASCADE;
DROP TABLE IF EXISTS Item CASCADE;
DROP TABLE IF EXISTS Creature CASCADE;
DROP TABLE IF EXISTS Structures CASCADE;
DROP TABLE IF EXISTS Biome CASCADE;
DROP TABLE IF EXISTS GameCharacter CASCADE;
DROP TABLE IF EXISTS Events CASCADE;
DROP TABLE IF EXISTS Season CASCADE;
DROP TABLE IF EXISTS CreatureDrop CASCADE;
DROP TABLE IF EXISTS StartItem CASCADE;
DROP TABLE IF EXISTS ItemsInBiome CASCADE;
DROP TABLE IF EXISTS CreatureForSeason CASCADE;
DROP TABLE IF EXISTS EventForSeason CASCADE;
DROP TABLE IF EXISTS SummonCreature CASCADE;
DROP TABLE IF EXISTS CreatureBiome CASCADE;
DROP TABLE IF EXISTS BiomeStructure CASCADE;
DROP TABLE IF EXISTS StructureEvent CASCADE;
DROP TABLE IF EXISTS StructureCreature CASCADE;

CREATE TYPE type_behaviour AS ENUM ('Hostile', 'Neutral', 'Passive');

CREATE TYPE type_weather AS ENUM ('Rain', 'Snow', 'Sun', 'Light');

CREATE TYPE type_biome AS ENUM ('Earth', 'Cave');

CREATE TABLE IF NOT EXISTS Item 
(
	item_id SERIAL PRIMARY KEY,
	item_type VARCHAR(32) NOT NULL,
	item_name VARCHAR(32) NOT NULL,
	max_stack SMALLINT NOT NULL CHECK (max_stack BETWEEN 1 AND 40),
	durability SMALLINT CHECK (durability BETWEEN 0 AND 100),
	recipe_id INTEGER UNIQUE CHECK (recipe_id > 0),
	description TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Creature
(
	creature_id SERIAL PRIMARY KEY,
	creature_name VARCHAR(32) NOT NULL,
	behaviour type_behaviour NOT NULL,
	health SMALLINT NOT NULL CHECK (health > 0),
	speed_move REAL NOT NULL CHECK (speed_move >= 0),
	speed_attack REAL CHECK (speed_attack >= 0),
	strength_attack SMALLINT CHECK (strength_attack > 0),
	description TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Structures
(
	structure_id SERIAL PRIMARY KEY,
	structure_type VARCHAR(32) NOT NULL,
	structure_name VARCHAR(32) NOT NULL,
	description TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Biome
(
	biome_id SERIAL PRIMARY KEY,
	biome_name VARCHAR(32) NOT NULL,
	biome_location type_biome NOT NULL,
	spread REAL NOT NULL CHECK (spread BETWEEN 0.1 AND 100),
	description TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS GameCharacter
(
	character_id SERIAL PRIMARY KEY,
	character_name VARCHAR(32) NOT NULL,
	max_health SMALLINT NOT NULL CHECK (max_health > 0),
	max_hunger SMALLINT NOT NULL CHECK (max_hunger > 0),
	max_sanity SMALLINT NOT NULL CHECK (max_sanity > 0),
	speed_move REAL NOT NULL CHECK (speed_move >= 0),
	strength_attack REAL NOT NULL CHECK (strength_attack >= 0),
	feature TEXT NOT NULL UNIQUE,
	description TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Events 
(
	event_id SERIAL PRIMARY KEY,
	event_name VARCHAR(32) NOT NULL,
	description TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Season
(
	season_id SERIAL PRIMARY KEY,
	season_name VARCHAR(32) NOT NULL,
	quantity_of_days SMALLINT NOT NULL CHECK (quantity_of_days BETWEEN 1 AND 20),
	weather type_weather NOT NULL,
	description TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS CreatureDrop
(
	creature_id INTEGER NOT NULL REFERENCES Creature(creature_id),
	item_id INTEGER NOT NULL REFERENCES Item(item_id),
	quantity_of_resources SMALLINT NOT NULL,
	PRIMARY KEY (creature_id, item_id)
);

CREATE TABLE IF NOT EXISTS StartItem 
(
	character_id INTEGER NOT NULL REFERENCES GameCharacter(character_id),
	item_id INTEGER NOT NULL REFERENCES Item(item_id),
	quantity_of_resources SMALLINT NOT NULL,
	PRIMARY KEY (character_id, item_id)
);

CREATE TABLE IF NOT EXISTS ItemsInBiome 
(
	item_id INTEGER NOT NULL REFERENCES Item(item_id),
	biome_id INTEGER NOT NULL REFERENCES Biome(biome_id),
	PRIMARY KEY (biome_id, item_id)
);

CREATE TABLE IF NOT EXISTS CreatureForSeason 
(
	creature_id INTEGER NOT NULL REFERENCES Creature(creature_id),
	season_id INTEGER NOT NULL REFERENCES Season(season_id),
	PRIMARY KEY (creature_id, season_id)
);

CREATE TABLE IF NOT EXISTS EventForSeason 
(
	event_id INTEGER NOT NULL REFERENCES Events(event_id),
	season_id INTEGER NOT NULL REFERENCES Season(season_id),
	PRIMARY KEY (event_id, season_id)
);

CREATE TABLE IF NOT EXISTS SummonCreature 
(
	event_id INTEGER NOT NULL REFERENCES Events(event_id),
	creature_id INTEGER NOT NULL REFERENCES Creature(creature_id),
	PRIMARY KEY (event_id, creature_id)
);

CREATE TABLE IF NOT EXISTS CreatureBiome
(
	biome_id INTEGER NOT NULL REFERENCES Biome(biome_id),
	creature_id INTEGER NOT NULL REFERENCES Creature(creature_id),
	PRIMARY KEY (biome_id, creature_id)
);

CREATE TABLE IF NOT EXISTS BiomeStructure
(
	structure_id INTEGER NOT NULL REFERENCES Structures(structure_id),
	biome_id INTEGER NOT NULL REFERENCES Biome(biome_id),
	PRIMARY KEY (structure_id, biome_id)
);

CREATE TABLE IF NOT EXISTS StructureEvent 
(
	event_id INTEGER NOT NULL REFERENCES Events(event_id),
	structure_id INTEGER NOT NULL REFERENCES Structures(structure_id),
	PRIMARY KEY (event_id, structure_id)
);

CREATE TABLE IF NOT EXISTS StructureCreature
(
	creature_id INTEGER NOT NULL REFERENCES Creature(creature_id),
	structure_id INTEGER NOT NULL REFERENCES Structures(structure_id),
	quantity_of_creatures SMALLINT NOT NULL,
	PRIMARY KEY (creature_id, structure_id)
);

INSERT INTO Item (item_type, item_name, max_stack, durability, recipe_id, description) VALUES
('Голова', 'Зимова шапка', 1, 100, 1, 'Одяг. Екіпірується на голову. Втрачає 100% міцності за 10 днів.'),
('Тіло', 'Пухкий желет', 1, 100, 2, 'Одяг. Екіпірується на тіло. Втрачає 100% міцності за 15 днів.'),
('Рука', 'Спис', 1, 100, 3, 'Зброя. Екіпірується в руку. Втрачає 100% міцності за 150 атак.'),
('Ресурс', 'Зрізана трава', 40, NULL, NULL, 'Ресурс - зрізана трава. Використовується для крафту. Не має міцності.'),
('Ресурс', 'Павутина', 40, NULL, NULL, 'Ресурс - павутина. Використовується для крафту. Не має міцності.'),
('Будівельний', 'Паркан', 20, NULL, 4, 'Будівельний інструмент. Можна розташувати на поверхні. Не має міцності.'),
('Рука', 'Сокира', 1, 100, 5, 'Зброя/інструмент. Екіпірується в руку. Втрачає 100% міцності за 100 ударів.'),
('Будівельний', 'Міні-робот', 1, NULL, 6, 'Робот, що лежить в інвентарі WX-78 при появі в сіті.'),
('Ресурс', 'Маленьке м''ясо', 40, NULL, NULL, 'Маленьке м''ясо. Випадає після вбивства кроликів.'),
('Ресурс', 'Монстро м''ясо', 40, NULL, NULL, 'Монстро м''ясо. Випадає після вбивства біфало або свина-перевертня.'),
('Ресурс', 'Велике м''ясо', 40, NULL, NULL, 'Велике м''ясо. Випадає після вбивства павука-воїна чи гончої.');

INSERT INTO Creature (creature_name, behaviour, health, speed_move, speed_attack, strength_attack, description) VALUES
('Павук-воїн', 'Hostile', 400, 4, 4, 20, 'Павук-воїн. Монстр. Вилазить з кокона.'),
('Свин-перевертень', 'Hostile', 525, 4, 5, 34, 'Свин перевертень. Поява під час повнолуння, якщо не встиг сховатись.'),
('Біфало', 'Neutral', 1000, 1.5, 4, 34, 'Біфало. Живе в савані. Мешкає зі стадом.'),
('Індик', 'Passive', 50, 3, NULL, NULL, 'Індик. Пасивний, але краде ягоди. Місце появи - ягідний кущ.'),
('Гонча', 'Hostile', 150, 6, 4, 20, 'Гонча. Часто влаштовують набіги на персонажів.'),
('Кролик', 'Passive', 25, 5, NULL, NULL, 'Маленький кролик. Можна зловити в трав''яну пастку. Після вбивства випадає мале м''ясо.');

INSERT INTO Structures (structure_type, structure_name, description) VALUES 
('Стіна', 'Тулецитова стіна', 'Стіна зроблена з тулециту. Має до 800 хп.'),
('Стіна', 'Місячна стіна', 'Стіна зроблена з місячного каменю. Має до 1600 хп.'),
('Станція', 'Алхімічний двигун', 'Станція для вивчення просунутих рецептів.'),
('Пастка', 'Скриня-пастка', 'Скриня, що викликає підпал навколишніх предметів з ймовіріністю 50%.'),
('Пастка', 'Обманка-лігво', 'Лігво, що при наближенні викликає гончіх.');

INSERT INTO Biome (biome_name, biome_location, spread, description) VALUES 
('Савана', 'Earth', 10, 'Біом савани. Містить багато трави та стада біфало.'),
('Ліс', 'Earth', 20, 'Лісний біом. Містить багато ялинок.'),
('Лабіринт', 'Cave', 5, 'Біом лабіринту. В ньому знаходиться Древній страж.');

INSERT INTO GameCharacter (character_name, max_health, max_hunger, max_sanity, speed_move, strength_attack, feature, description) VALUES 
('Вілсон', 150, 150, 200, 5, 10, 'Відрощує розкішну бороду', 'Вілсон. Чудовий базовий персонаж з посередніми шансами на виживання'),
('WX-78', 125, 125, 125, 5, 10, 'Отримує шкоду від води. Робот.', 'Робот, що страждає від води, але може заряжатись різними чіпами.'),
('Венді', 150, 150, 200, 5, 7.5, 'Має привида. Слабша атака. Зменшена втрата розуму в темряві', 'Дівчинка Венді, що втратила сестру, але має її привида з собою. Слабша атака. Зменшена втрата розуму в темряві.');

INSERT INTO Events (event_name, description) VALUES 
('Пожежа', 'Пожежа викликана подіями або природніми підпалами впродовж літа.'),
('Повнолуння', 'Повнолуння виникає кожні 21 день.'),
('Дощ', 'Дощ викликканий сезонними подіями або після взаємодії з проклятими структурами.');

INSERT INTO Season (season_name, quantity_of_days, weather, description) VALUES 
('Літо', 16, 'Sun', 'Літо. Навколо спека, сонце, підпали та унікальні літні істоти.'),
('Зима', 16, 'Snow', 'Зима. Часті снігопади, нові істоти, сезонний бос.'),
('Весна', 20, 'Light', 'Весна. Сезон повний дощів та блискавок.'),
('Осінь', 20, 'Sun', 'Осінь. Найспокійніша пора року.');

INSERT INTO CreatureDrop VALUES 
(1, 5, 2),
(3, 9, 4),
(6, 10, 1),
(1, 11, 1),
(3, 12, 4),
(5, 11, 1),
(2, 12, 2);

INSERT INTO StartItem VALUES 
(1, 8, 1);

INSERT INTO ItemsInBiome VALUES 
(4, 2);

INSERT INTO CreatureForSeason VALUES 
(4, 1),
(4, 3);

INSERT INTO EventForSeason VALUES 
(1, 1);

INSERT INTO SummonCreature VALUES
(2, 2);

INSERT INTO CreatureBiome VALUES 
(1, 3),
(2, 1),
(1, 6),
(2, 4),
(2, 5),
(2, 2);

INSERT INTO BiomeStructure VALUES 
(1, 3);

INSERT INTO StructureEvent VALUES 
(1, 4);

INSERT INTO StructureCreature VALUES 
(5, 5, 2);


--SELECT COUNT (DISTINCT item_type) AS quantity_of_item_types FROM Item;

--SELECT SUM(quantity_of_days) AS days_in_full_year FROM Season; 

--SELECT MIN(max_health) AS lowest_health FROM GameCharacter; 

--SELECT MAX(max_sanity) AS highest_sanity FROM GameCharacter; 

--SELECT AVG(max_stack) AS average_stack_size  
--FROM Item  
--WHERE item_type != 'Голова'  
--AND item_type != 'Тіло'  
--AND item_type != 'Рука'; 

--SELECT behaviour, MAX(health) AS health  
--FROM Creature 
--GROUP BY behaviour 
--ORDER BY health DESC; 

--SELECT behaviour, COUNT(creature_id) AS creature  
--FROM Creature 
--GROUP BY behaviour 
--ORDER BY creature DESC; 

--SELECT biome_location, AVG(spread) AS average_spread  
--FROM Biome  
--GROUP BY biome_location; 

--SELECT biome_location, AVG(spread) AS average_spread 
--FROM Biome  
--GROUP BY biome_location  
--HHAVING AVG(spread) > 10;  

--SELECT strength_attack, AVG(max_sanity) AS average_characters_sanity  
--FROM GameCharacter  
--GROUP BY strength_attack  
--HAVING AVG(max_sanity) < 185; 

--SELECT c.creature_name, s.season_name  
--FROM Creature c
--INNER JOIN CreatureForSeason cfs ON c.creature_id = cfs.creature_id  
--INNER JOIN Season s ON s.season_id = cfs.season_id; 

--SELECT i.item_name, i.item_type
--FROM Item i  
--LEFT JOIN ItemsInBiome iib ON i.item_id = iib.item_id  
--WHERE iib.biome_id IS NULL; 

--SELECT *  
--FROM CreatureBiome cb  
--FULL OUTER JOIN Creature c ON c.creature_id = cb.creature_id  
--FULL OUTER JOIN Biome b ON b.biome_id = cb.biome_id  
--WHERE cb.biome_id IS NOT NULL AND cb.creature_id IS NOT NULL; 

--SELECT biome_name, event_name, biome_location, spread  
--FROM Biome 
--CROSS JOIN Events; 

--Або (SELECT нижче дасть той самий результат, що і SELECT вище) 

--SELECT biome_name, event_name, biome_location, spread  
--FROM Biome, Events; 

--SELECT  
--ROUND(AVG(c.health)::numeric, 2) AS average_creature_health, 
--ROUND(AVG(gc.strength_attack)::numeric, 2) AS average_character_damage, 
--ROUND((AVG(c.health) / AVG(gc.strength_attack))::numeric, 2) AS quantity_of_attacks  
--FROM Creature c  
--CROSS JOIN GameCharacter gc; 

--SELECT b.biome_name, c.creature_name, cd.quantity_of_resources, i.item_name, i.max_stack,  
--(i.max_stack / cd.quantity_of_resources) AS quantity_of_death_for_full_stack  
--FROM CreatureBiome cb  
--INNER JOIN Biome b USING (biome_id)  
--INNER JOIN Creature c USING (creature_id)  
--INNER JOIN CreatureDrop cd USING (creature_id)  
--INNER JOIN Item i USING (item_id)  
--WHERE i.item_name LIKE '%м''ясо%'  
--ORDER BY b.biome_name DESC; 
