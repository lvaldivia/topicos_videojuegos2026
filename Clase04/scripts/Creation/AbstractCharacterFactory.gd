class_name AbstractCharacterFactory
extends RefCounted

func create_player(pos:Vector2)->Character:return null;
func create_week_enemy(pos:Vector2)->Character:return null;
func create_strong_enemy(pos:Vector2)->Character:return null;
func create_boss_enemy(pos:Vector2)->Character:return null;
func get_family_name() ->String: return "Base"
