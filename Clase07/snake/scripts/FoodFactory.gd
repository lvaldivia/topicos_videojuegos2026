class_name FoodFactory
extends EntityFactory

enum FoodType{
	NORMAL,SPECIAL,POISON
}

const FOOD_SCENES:Dictionary = {
	FoodType.NORMAL : preload("res://snake/scenes/NormalFood.tscn"),
	FoodType.SPECIAL : preload("res://snake/scenes/SpecialFood.tscn"),
	FoodType.POISON : preload("res://snake/scenes/PoisonFood.tscn")
}
static func create_food(type:FoodType,pos:Vector2)->BaseEntity:
	if not FOOD_SCENES.has(type): return null
	var food = FOOD_SCENES[type].instantiate()
	food.position = pos
	return food
	
static func create_random(pos:Vector2)->BaseEntity:
	var r = randi() % 10
	if r < 6: return create_food(FoodType.NORMAL,pos)
	elif r < 9 : return create_food(FoodType.SPECIAL,pos)
	else: return create_food(FoodType.POISON,pos)
