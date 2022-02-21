extends Node2D

export(String, FILE, "*.tscn") var next_scene_path

func _ready():
	GameManager.stop_music()

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene(next_scene_path)
	pass # Replace with function body.
