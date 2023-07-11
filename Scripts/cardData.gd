extends Resource
class_name CardData

@export
var name_key : String

@export_range(0, 10)
var cost = 0

@export
var img: Texture2D

@export
var description_key : String

@export
var blockPrefab : PackedScene
