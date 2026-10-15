extends AnimatedSprite2D
class_name PlayerAnimation
##
##
##
	#### METHODS ####
func triggerAnimation(velocity: Vector2, direction: int) -> void:
# flip frame based on direction #
# (only work for nodes with scale.x set to 1) #
	if direction:
		scale.x = direction
# change frames #
	if not get_parent().is_on_floor():
		play("smallJump")
	#elif sign(velocity.x) != sign(direction) && velocity.x != 0 && direction != 0:
		#play("smallSlide")
	elif direction:
		play("smallRun")
	else:
		play("smallIdle")
##
	#### THINGS TO ADD TO manager.gd ####
### getParentThen("doThis") -> returns doThis() ## ## explanation on (**) ##
### signsOf(value1, value2, string***, string*) -> returns bool ##
###
	## (*) what happens when any of the values are 0; "zeroIsFalse" is default ##
	## (***) "different" or "same"
	## (**) v EXAMPLE BELOW v ##
#extends Node
###
###
###
	##### METHODS ####
#func getParent(node: Node, function: String) -> void:
	## 1. Turn the string into a Callable object #
	#var action = Callable(node, function)
	## 2. Run it using call() #
	#action.call()
###
	### On 'node' object (can be just 'self') ##
#func function() -> void:
	#print("I'M CALLED!")
###
###
###
	##### END ####
