@startuml umlLab1

entity Item {
  item_id: PK,
  --
  type,
  name,
  max_stack,
  durability,
  recipe,
  description
}
entity Creature {
	creature_id : PK,
  --
  name,
	type_behaviour,
	health,
	speed_move,
  speed_attack,
  strength_attack,
  description
}
entity Structure {
  structure_id : PK,
  --
	type,
  name,
  description
}
entity Biome(TypeLocation) {
  biome_id : PK,
  --
  name,
  type,
	spread,
  description
}
entity Character {
  character_id : PK,
  --
  name,
  max_health,
  max_hunger,
  max_sanity,
  speed_move,
  strength_attack,
  feature,
  description
}
entity Event {
	event_id : PK,
  --
	name,
  description
}
entity Season {
	season_id : PK,
  --
	name,
	quantity_of_days,
	type_weather,
  description
}

entity CreatureDrop {
  creature_id : FK,PK,
  item_id : FK,PK,
  --
  quantity_of_resources
}
entity StartItem {
  character_id : FK,
  item_id : FK,
  --
  quantity_of_resources
}
entity ItemsInBiome {
  item_id : FK,
  biome_id : FK
}
entity CreatureForSeason {
  creature_id : FK,
  season_id : FK
}
entity EventForSeason {
  event_id : FK,
  season_id : FK
}
entity SummonCreature {
  event_id : FK,
  creature_id : FK
}
entity CreatureBiome {
  biome_id : FK,
  creature_id : FK
}
entity BiomeStructure {
  structure_id : FK,
  biome_id : FK
}
entity StructureEvent {
  event_id : FK,
  structure_id : FK
}
entity StructureCreature {
  creature_id : FK,
  structure_id : FK,
  --
  quantity_of_creatures
}

@enduml