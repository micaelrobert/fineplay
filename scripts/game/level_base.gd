# scripts/game/level_base.gd
extends Node2D

@onready var score_label: Label = $UI/MarginContainer/ScoreLabel
@onready var correct_sfx: AudioStreamPlayer = $Audio/CorrectSFX
@onready var wrong_sfx: AudioStreamPlayer = $Audio/WrongSFX
@onready var bgm_player: AudioStreamPlayer = $Audio/BGM

func _ready():
	Global.score_updated.connect(_on_global_score_updated)
	_on_global_score_updated(Global.current_score)
	
	if not bgm_player.playing:
		bgm_player.play()

func _on_global_score_updated(new_score: int):
	score_label.text = "Pontos: %s" % new_score

func report_answer(is_correct: bool):
	if is_correct:
		print("Resposta Correta!")
		correct_sfx.play()
		Global.add_score(10)
		
		await get_tree().create_timer(1.5).timeout
		
		Global.load_next_level()
		
	else:
		print("Resposta Errada.")
		wrong_sfx.play()
		pass
