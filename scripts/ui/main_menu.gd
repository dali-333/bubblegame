extends Control

@onready var start_btn: Button = $MarginContainer/VBoxContainer/VBoxContainer/StartBtn
@onready var exit_btn: Button = $MarginContainer/VBoxContainer/VBoxContainer/ExitBtn



	


func _on_start_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://player/world.tscn")


func _on_exit_btn_pressed() -> void:
	get_tree().quit()
