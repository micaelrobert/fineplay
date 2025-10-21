# scripts/autoload/scene_loader.gd
extends Node

var current_scene: Node = null
var next_scene_path: String = ""

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var transition_rect: ColorRect = $TransitionRect

func _ready():
	transition_rect.visible = false
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func change_scene(scene_path: String):
	if scene_path == current_scene.scene_file_path:
		# --- CORREÇÃO AQUI ---
		push_warning("Tentando carregar a mesma cena: %s" % scene_path)
		return

	print("Carregando cena: ", scene_path)
	next_scene_path = scene_path
	
	transition_rect.visible = true
	animation_player.play("fade_in")

func _on_fade_in_finished():
	current_scene.free()
	
	var next_scene_res = load(next_scene_path)
	current_scene = next_scene_res.instantiate()
	
	get_tree().get_root().add_child(current_scene)
	
	animation_player.play("fade_out")

func _on_fade_out_finished():
	transition_rect.visible = false
