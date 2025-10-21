# scripts/ui/main_menu.gd
extends Control

@onready var button_play: Button = $MainContainer/MenuButtons/ButtonPlay
@onready var button_about: Button = $MainContainer/MenuButtons/ButtonAbout
@onready var button_exit: Button = $MainContainer/MenuButtons/ButtonExit

func _ready():
	# Verifica se os botões existem antes de conectar
	if button_play:
		button_play.pressed.connect(_on_button_play_pressed)
	else:
		push_error("Botão 'ButtonPlay' não encontrado na cena main_menu.tscn")
		
	if button_about:
		button_about.pressed.connect(_on_button_about_pressed)
	if button_exit:
		button_exit.pressed.connect(_on_button_exit_pressed)

func _on_button_play_pressed():
	print("Botão Jogar pressionado.")
	Global.reset_game()
	var first_level_path = "res://scenes/levels/level_%02d.tscn" % Global.current_level_index
	SceneLoader.change_scene(first_level_path)

func _on_button_about_pressed():
	print("Botão Sobre pressionado.")
	pass

func _on_button_exit_pressed():
	print("Botão Sair pressionado.")
	get_tree().quit()
