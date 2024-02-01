extends CharacterBody2D
@export var animator: AnimationPlayer
@export var party_pos = 2
@export var name_ = ""
@export var ativo = true
var textura = "res://sprites/Morgana_SpriteSheet.png"
func _ready():
	$Sprite2D.texture = load(textura)
func seguir():
	if $"../Personagem".move_historic.size() > 3:
		var tween = create_tween()
		animator.play("walk_" + $"../Personagem".move_historic[$"../Personagem".move_historic.size() - party_pos ])
		print($"../Personagem".move_historic)
		print($"../Personagem".movimentos)
		tween.tween_property(self, "position", Vector2($"../Personagem".movimentos[$"../Personagem".movimentos.size() - party_pos][0], $"../Personagem".movimentos[$"../Personagem".movimentos.size() - party_pos][1]), 0.5)
		await animator.animation_finished
		animator.play("idle_" + str($"../Personagem".move_historic[$"../Personagem".move_historic.size() - party_pos]))

func change_character():
	$Sprite2D.texture = load(textura)


