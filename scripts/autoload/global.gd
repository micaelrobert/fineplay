# scripts/autoload/global.gd
extends Node

# --- Variáveis de Estado ---
var current_score: int = 0
var current_level_index: int = 1
var max_levels: int = 2 # ATUALIZE ISSO QUANDO CRIAR MAIS NÍVEIS

# --- Sinais ---
signal score_updated(new_score)

# --- Funções Públicas ---
func add_score(points: int):
	current_score += points
	score_updated.emit(current_score)
	print("Score atualizado: ", current_score)

func reset_game():
	current_score = 0
	current_level_index = 1
	score_updated.emit(current_score)
	print("Jogo resetado.")

func load_next_level():
	current_level_index += 1
	
	if current_level_index > max_levels:
		print("Fim de jogo! Voltando ao menu.")
		reset_game()
		SceneLoader.change_scene("res://scenes/ui/main_menu.tscn")
	else:
		var next_level_path = "res://scenes/levels/level_%02d.tscn" % current_level_index
		
		if ResourceLoader.exists(next_level_path):
			SceneLoader.change_scene(next_level_path)
		else:
			# ERRO CORRIGIDO AQUI: use push_error
			push_error("Erro: Cena do próximo nível não encontrada em: %s" % next_level_path)
			SceneLoader.change_scene("res://scenes/ui/main_menu.tscn")
