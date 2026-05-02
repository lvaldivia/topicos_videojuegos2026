class_name CharacterPrototype
extends RefCounted

static func clone(original:Character,new_pos:Vector2 = Vector2.ZERO) ->Character:
	var path = original.scene_file_path
	if path.is_empty():
		push_error("Prototype el persona no tiene scen file path "+path)
		return null
	var scene = load(path)
	var clone_ch :Character = scene.instantiate()
	clone_ch.max_health = original.max_health
	clone_ch.damanage = original.damanage
	clone_ch.speed = original.speed
	clone_ch.position = new_pos
	print("[Prototype] Clonado: ", original.character_name,
		  " → HP:", clone_ch.max_health,
		  " DMG:", clone_ch.damanage)
	return clone_ch
