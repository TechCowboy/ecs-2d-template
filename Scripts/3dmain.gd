extends Node3D

var my_maze : Maze


var cols = 10	
var rows = 10

var north_wall = preload("res://Scenes/north_wall.tscn")
var south_wall = preload("res://Scenes/south_wall.tscn")
var east_wall = preload("res://Scenes/east_wall.tscn")
var west_wall = preload("res://Scenes/west_wall.tscn")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	my_maze = Maze.new()
	my_maze.generate(0, 0, cols, rows)
	my_maze.display_maze()

	draw_maze()

func get_walls(room:MazeRoom) -> String:
	var walls = ""
	if room.north:
		walls += 'N'
	if room.west:
		walls += 'W'
	if room.south:
		walls += 'S'
	if room.east:
		walls += 'E'
	return walls

func draw_maze():
	
	var start_x = -50
	var start_y =   0
	var start_z = -50
	var x
	var y
	var z
	var cell_size = 2
	var north
	var east
	var west
	var south	
	var my_room
	

	for row in range(my_maze.rows):
		for col in range(my_maze.cols):
			my_room = my_maze.get_room(col,row)
			x = start_x + col * cell_size
			y = start_y
			z = start_z + row * cell_size
			
			var walls = get_walls(my_room)

			if walls.find('N')>=0:
				north =  north_wall.instantiate()
				north.global_position = Vector3(x,y,z)
				add_child(north)

			if walls.find('W')>=0:
				west =  west_wall.instantiate()
				west.global_position = Vector3(x,y,z)
				add_child(west)

			if walls.find('S')>=0:
				south =  south_wall.instantiate()
				south.global_position = Vector3(x,y,z + cell_size)
				add_child(south)

			if walls.find('E')>=0:
				east =  east_wall.instantiate()
				east.global_position = Vector3(x + cell_size,y,z)
				add_child(east)
