extends CharacterBody2D
@export var animator: AnimationPlayer
@export var party_pos = 2
@export var name_ = ""
@export var ativo = true
@onready var alvo: CharacterBody2D = $"../Personagem"
@export var textura = "res://sprites/Caleb/caleb_spriteSheetNew.png"
func _ready():
	$Sprite2D.texture = load(textura)
func seguir():
	if alvo.move_historic.size() >= party_pos:
		var tween = create_tween()
		animator.play("walk_" + alvo.move_historic[alvo.move_historic.size() - party_pos ])
		tween.tween_property(self, "position", Vector2(alvo.movimentos[alvo.movimentos.size() - party_pos][0], alvo.movimentos[alvo.movimentos.size() - party_pos][1]), 0.5)
		await animator.animation_finished
		animator.play("idle_" + str(alvo.move_historic[alvo.move_historic.size() - party_pos]))

func change_character():
	$Sprite2D.texture = load(textura)


