class_name FantasyFactory
extends  AbstractCharacterFactory

#WARRIOR
#GOBLIN
func get_family_name() ->String:
	return "Fantasia"

func create_player(pos:Vector2)->Character:
	var c :Character = GameConfig.SCENES[GameConfig.CharacterType.WARRIOR].instantiate()
	c.position = pos
	return c
	
func create_week_enemy(pos:Vector2)->Character:
	var c :Character = GameConfig.SCENES[GameConfig.CharacterType.GOBLIN].instantiate()
	c.position = pos
	return c
	
