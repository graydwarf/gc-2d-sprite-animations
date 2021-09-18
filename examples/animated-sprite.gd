extends Node2D

# Credit / Reference Materials
# Keyboard Buttons: https://docs.godotengine.org/en/stable/classes/class_animatedsprite.html
# Animated Sprite Tutorial: https://docs.godotengine.org/en/stable/tutorials/2d/2d_sprite_animation.html

onready var _animated_sprite = $AnimatedSprite
var _facingDirection = ""

var _listOfEventKeysForUiLeft : Array
var _listOfEventKeysForUiRight : Array

# Note: Input handling is primitive to keep code minimal.
func _process(_delta):
	if _facingDirection == "" && Input.is_action_pressed("ui_left"):
		MoveInDirection("Left")
	elif _facingDirection == "" && Input.is_action_pressed("ui_right"):
		MoveInDirection("Right")

	if _facingDirection == "Left" && Input.is_action_just_released("ui_left"):
		StopMovement()
	elif _facingDirection == "Right" && Input.is_action_just_released("ui_right"):
		StopMovement()

func MoveInDirection(dir):
	_animated_sprite.play("run")
	_facingDirection = dir
	if dir == "Left":
		_animated_sprite.flip_h = true
	else:
		_animated_sprite.flip_h = false

func StopMovement():
	_animated_sprite.stop()
	_facingDirection = ""

# Note: These key bindings can normally be done through
# Project Settings -> Input Map but we load this project
# inside Godot Companion where we swap out different key
# bindings between different examples.
func AddKeyBindings():
	var listOfLeftBinds = [KEY_A, KEY_J]
	var listOfRightBinds = [KEY_D, KEY_L]
	for key in listOfLeftBinds:
		var inputEventKey = AddInputEventKey(key, "ui_left")
		_listOfEventKeysForUiLeft.append(inputEventKey)

	for key in listOfRightBinds:
		var inputEventKey = AddInputEventKey(key, "ui_right")
		_listOfEventKeysForUiRight.append(inputEventKey)

func AddInputEventKey(key, uiEventName):
	var inputEventKey = InputEventKey.new()
	inputEventKey.scancode = key
	InputMap.action_add_event(uiEventName, inputEventKey)
	return inputEventKey

func RemoveKeyBindings():
	for key in _listOfEventKeysForUiLeft:
		InputMap.action_erase_event("ui_left", key)

	for key in _listOfEventKeysForUiRight:
		InputMap.action_erase_event("ui_right", key)

	_listOfEventKeysForUiLeft.clear()
	_listOfEventKeysForUiRight.clear()

# shared support functions
# used when running locally
# used when running within godot-companion
func Start():
	AddKeyBindings()

func Stop():
	RemoveKeyBindings()

func GetGodotDocUrl():
	return "tutorials/2d/2d_sprite_animation.html"
