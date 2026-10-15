extends CharacterBody2D
class_name Player
##
##
##
	#### ATRIBUTOS ####
@export_group("Locomoção")
@export var speed: float = 120
@export var jumpVelocity: float = 320
@export var damping: float = 0.5
@export var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export_group("Stomping Enemies")
@export var min_stomp_degree: float = 35
@export var max_stomp_degree: float = 145
@export var stomp_y_velocity: float = -150
@export_group("Camera")
@export var camera: Camera2D
@export var distanciaAceitavel: float = 20
@export_group("DEBUGING")
@export var is_dead: bool = false
@export var airDashCount = 1

signal jump
signal airDash
var airDashed: bool = false

var direction: float
##
##
##	
	#### METHODS ####
func _process(delta: float) -> void:
	if camera.position.y > 0:
		camera.position.y = 0
	
	# a distancia no qual a camera começa a seguir
	# seria bom colocar essa variavel lá em cima no codigo, junto com as outras variáveis...
	
	# aqui ele verifica se a distancia x (posicao x do player - posicao x da camera) e maior ou menor que a distanciaaceitavel
	if abs(self.position.x) - abs(camera.position.x) > distanciaAceitavel or abs(self.position.x) - abs(camera.position.x) < distanciaAceitavel * -1:
		# mmovendo a camera  s u a v e m e n t e . nno eixo x
		camera.position.x = move_toward(camera.position.x, self.position.x, delta * speed)
	
	# aqui ele verifica se a distancia y (posicao y do player - posicao y da camera) e maior ou menor que a distanciaaceitavel
	if abs(self.position.y) - abs(camera.position.y) > distanciaAceitavel or abs(self.position.y) - abs(camera.position.y) < distanciaAceitavel * -1:
		# mmovendo a camera  s u a v e m e n t e . nno eixo y
		camera.position.y = move_toward(camera.position.y, self.position.y, delta * speed)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
	# if on air
		velocity.y += gravity * delta
	else:
		airDashed = false
	if Input.is_action_just_pressed("jump") and is_on_floor():
	# if jumped on floor
		jump.emit()
		velocity.y = jumpVelocity
		if not airDashCount:
			airDashCount += 1
	elif Input.is_action_just_pressed("jump") and airDashCount:
		airDash.emit()
		velocity.y = jumpVelocity
		airDashCount -= 1
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity *= 0.5
	direction = Input.get_axis("left", "right")
	
	if direction:
		position.x = position.x + speed * direction * delta
	#aadasdasdasdasdadadadadadelse:
		#position.x = move_toward(position.x, 0, speed * delta)
		
	$Sprite.triggerAnimation(velocity, direction)
	move_and_slide()
##
# move these to manager.gd
func _ready() -> void:
	camera.position_smoothing_enabled = true
	jumpVelocity = jumpVelocity * -1

##
##
##
	#### LIST OF METHODS TO MAKE LATER ####
## swift() -> returns velocity vector with it's y inverted ##
## notOnFloor() and OnFloor() -> já diz tudo amg... ##
## 'justReleased' option for already made justPressed ##
## getInputDirection() -> Input.get-axis(negative, positive) ##
## startCharacter() -> returns move-and-slide() ##

func _die():
	is_dead = true
	$Sprite.play("smallDeath")
	set_physics_process(false)
	var death_tween = get_tree().create_tween()
	death_tween.tween_property(self, "position", position + Vector2(0, -50), 0.5)
	death_tween.chain().tween_property(self, "position", position + Vector2(0, 300), 1)
	death_tween.tween_callback(func (): get_tree().reload_current_scene())

func _on_area_2d_area_entered(area: Area2D) -> void:
	if not (area is Enemy) or is_dead:
		return
	
	if area is Koopa and (area as Koopa).in_a_shell:
		(area as Koopa)._on_stomp(self.position)
		return
		
	var angle = rad_to_deg(self.position.angle_to_point((area as Enemy).position))
	
	if angle > min_stomp_degree and angle < max_stomp_degree:
		(area as Enemy)._die()
		velocity.y = stomp_y_velocity
	else:
		_die()


func onAirDash() -> void:
	airDashed = true
