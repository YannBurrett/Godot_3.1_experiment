extends MeshInstance

var happy_materials = []

func _ready():
	get_happy_materials()


func get_happy_materials():
#	var happy_materials_count = 0
#	var dir = Directory.new()
#	var path = "res://GFX/emotes/happy/Materials/"
#	dir.open(path)
#	dir.list_dir_begin()
#
#	while true:
#		var file = dir.get_next()
#		if file == "":
#			break
#		elif not file.begins_with("."):
#			happy_materials[happy_materials_count] = (path+file)
#			happy_materials_count += 1

	happy_materials = ["res://GFX/emotes/happy/Materials/1.material",
			"res://GFX/emotes/happy/Materials/2.material",
			"res://GFX/emotes/happy/Materials/3.material",
			"res://GFX/emotes/happy/Materials/4.material",
			"res://GFX/emotes/happy/Materials/5.material",
			"res://GFX/emotes/happy/Materials/6.material",
			"res://GFX/emotes/happy/Materials/7.material",
			"res://GFX/emotes/happy/Materials/8.material",
			"res://GFX/emotes/happy/Materials/9.material"
			]


func be_happy():
	randomize()
	var current_material = happy_materials[randi() % happy_materials.size()]
	set_surface_material(0, load(current_material))