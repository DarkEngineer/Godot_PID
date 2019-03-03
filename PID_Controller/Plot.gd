extends Node2D

var a = 1.0
var b = 0.0
var c = 0.0
var _pv = 0.0
var y_1 = 0.0
var y_2 = 0.0
var control_array = []
var sv = 200.0

func _ready():
	update()

func _draw():
	var pre_x = 0.0
	var i = 0
	draw_line(Vector2(0, -sv), Vector2( 1200, -sv), ColorN("red"), 4)
	for obj in control_array:
		draw_line(Vector2(i, -pre_x * a), Vector2(i + 1, -obj * a), ColorN("chartreuse"), 1)
		pre_x = obj
		i += 1

func _on_a_value_changed(value):
	a = value
	update()


func _on_IterationTimer_timeout():
	var K = 0.7
	var T = 0.2
	var u_t = owner.calculate(sv, _pv)
	var y_t = K * u_t - owner._dt/ T *(y_1 - y_2)
	control_array.append(y_t)
	y_2 = y_1
	y_1 = y_t
	_pv = y_t
	print(y_t)
	update()