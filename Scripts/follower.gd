extends CharacterBody2D
class_name Follower

# inspector
@export_group("Node References")
@export var sprite: AnimatedSprite2D = null
@export var target: CharacterBody2D = null
@export var raycast: RayCast2D = null
@export var currentSpawn: Node2D = null
@export var spawnAnimation: PackedScene
@export var staminaTimer: Timer = null
@export_group("Follower Stats")
@export var stamina: float = 6
@export var tired: bool = false
@export_group("Target Relations")
@export var playerOffset: float = 30
@export var acceptableDistance: float = 10
@export_group("Follower Transforms")
@export var defaultScale: Vector2 = Vector2(1, 1)
@export_group("Follower Speeds")
@export var horizontalSpeed: float = 100
@export var verticalSpeed: float = 100
@export var flySpeed: float = 100
@export var jumpSpeed: float = 100
@export_group("Follower States")
@export var currentState: States
@export var jumpableStates: Array[States] = [States.IDLE, States.WALKING, States.GROUND]

# atributes
@export_category("Atributes")
@export_group("Debug")
@export var currentDistance: float = NAN
@export var currentTarget: Vector2 = Vector2(0, 0)
@export var minimumJump: float
# states
enum States {
	SPAWN,
	IDLE,
	WALKING,
	JUMP,
	FLY,
	GROUND,
	ACTING,
	FROZEN,
	DEAD
}


# methods
func fly(delta: float) -> void:
	if not raycast.is_colliding() or self.position.y != currentTarget.y:
		if not tired:
			position = position.move_toward(currentTarget, flySpeed * delta)
		## LATER MAKE THIS A "TIRED" STATE
		elif not raycast.is_colliding():
			position.y = position.y + (flySpeed * delta)
		else:
			_enterState(States.GROUND)
		#####################################
	else:
		_enterState(States.GROUND)
		
	

func _ready() -> void:
	if not spawnAnimation:
		spawnAnimation = currentSpawn.spawnAnimation
	updateJumpSpeed(jumpSpeed) # ????????????????W
	_enterState(States.SPAWN)
	


func updateJumpSpeed(newSpeed: float) -> void: # ????????
	minimumJump = target.jumpVelocity / -3 + 25
	jumpSpeed = newSpeed
	if jumpSpeed < minimumJump:
		print("VERIFIVCOU")
		jumpSpeed = minimumJump

func _process(delta: float) -> void:
	updateTarget()
	updateDistance()
	gravity(delta)

	## ADD THIS TO A "UPDATEDIRECTION()" FUNCTION
	if currentDistance > acceptableDistance:
		if target.direction:
			sprite.scale.x = target.direction
	#################################################

	## ADD TO "CHECKIFFLY()"
	if not raycast.is_colliding() and currentState != States.SPAWN and not tired:
		_enterState(States.FLY)
	##########################

	## ADD LATER TO "MATCHSTATES()"
	match currentState:
		States.WALKING:
			followPlayer(delta)
			if currentDistance < acceptableDistance:
				_enterState(States.IDLE)

		States.IDLE:
			if currentDistance > acceptableDistance:
				_enterState(States.WALKING)

		States.JUMP:
			position.y -= jumpSpeed * delta

		States.FLY:
			fly(delta)
			
		
	
#########################################

func jump() -> void:
	if currentState in jumpableStates:
		startStamina()
		_enterState(States.JUMP)
		
	

func startStamina(speedScale = 1) -> void:
	print("COMECOU")
	staminaTimer.start(stamina * speedScale)


func onExited() -> void:
	_enterState(States.SPAWN)
	


func followPlayer(delta: float) -> void:
	position.x = move_toward(position.x, currentTarget.x, horizontalSpeed * delta)
	


func gravity(delta: float) -> void:
	if not raycast.is_colliding():
		if currentState in jumpableStates:
			position.y += verticalSpeed * delta
			
		
	


func onAnimationEnded() -> void:
	match currentState:
		States.SPAWN:
			_enterState(States.IDLE)

		States.JUMP:
			_enterState(States.FLY)

		States.GROUND:
			_enterState(States.IDLE)
			
		
	


func updateDistance() -> void:
	currentDistance = abs(position.x - currentTarget.x)
	


func updateTarget() -> void:
	currentTarget = Vector2(target.position.x - playerOffset, target.position.y)
	


func _enterState(newState: States) -> void:
	currentState = newState

	match currentState:
		States.SPAWN:
			sprite.play("spawn")
			position = currentSpawn.position
			onSpawned()

		States.IDLE:
			tired = false
			sprite.play("idle")

		States.WALKING:
			sprite.play("walk")

		States.JUMP:
			sprite.play("jump")

		States.FLY:
			sprite.play("fly")

		States.GROUND:
			sprite.play("ground")
			
		
	


func onTargetJump() -> void:
	jump()
	


func onTired() -> void:
	print("TIRED!")
	tired = true
	
func onSpawned() -> void:
	tired = false
	var newAnimation = spawnAnimation.instantiate()
	add_child(newAnimation)
	
