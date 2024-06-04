#!/usr/bin/python
#
# www.josephlandry.com
#
# buildmap.py
#
# Builds map images from Anodyne game source files.
#
# Anodyne game: http://www.anodynegame.com/
#
# The source folder should be in ./
# The map images will be outputted to ./maps/ in PNG format.
#

import os
import csv
from PIL import Image
from xml import sax

def read_layer(filename):
	f = open(filename, "r")
	map_reader = csv.reader(f, delimiter=",")
	map = []
	for row in map_reader:
		map.append(row)
	f.close()
	return map


def read_tileset(filename):
	tilesetimage = Image.open(filename).convert("RGBA");
	tilesetimage_xblocks = int(tilesetimage.size[0] / 16)
	tilesetimage_yblocks = int(tilesetimage.size[1] / 16)
	tileset = []
	for i in range(tilesetimage_yblocks):
		for j in range(tilesetimage_xblocks):
			tile = tilesetimage.crop((j * 16, i * 16, j * 16 + 16, i * 16 + 16))
			tileset.append(tile)
	return tileset

def paint_with_layer(image, layer, tileset):
	y_blocks = len(layer)
	x_blocks = len(layer[0])
	for i in range(y_blocks):
		for j in range(x_blocks):
			tile_index = int(layer[i][j])
			tile = tileset[tile_index]
			if tile_index != 0:
				image.paste(tile, (j * 16, i * 16, j * 16 + 16, i * 16 + 16), tile)


def generate_map_image(map):
	layer = read_layer(map["layers"][0])
	tileset = read_tileset(map["tileset"])
	image = Image.new("RGB", (len(layer[0]) * 16, len(layer) * 16))
	paint_with_layer(image, layer, tileset)
	for layerfile in map["layers"][1:]:
		layer = read_layer(layerfile)
		paint_with_layer(image, layer, tileset)
	return image

class RegistryHandler(sax.ContentHandler):
	mapname = ""
	registry = {}
	def startElement(self, name, attrs):
		if name == "root":
			pass
		elif name == "map":
			self.mapname = attrs["name"]
			if self.mapname not in self.registry.keys():
				self.registry[self.mapname] = {}
		else:
			if not(name in self.registry[self.mapname].keys()):
				self.registry[self.mapname][name] = []
			self.registry[self.mapname][name].append({"x": attrs["x"], "y": attrs["y"], "frame": attrs["frame"]})
	def endElement(self, name):
		pass

def read_registry():
	parser = sax.make_parser()
	handler = RegistryHandler()
	parser.setContentHandler( handler )
	parser.parse( 'xml/Intra.xml')
	return handler.registry

	

mapfiles = [ 
	{
		"world": "APARTMENT", 
		"tileset": "res/tilemaps/Apartment_tilemap.png",
		"layers": ["csv/APARTMENT_BG.csv", "csv/APARTMENT_BG2.csv", "csv/APARTMENT_FG.csv"]
	},
	{
		"world": "BEACH", 
		"tileset": "res/tilemaps/Beach_tilemap.png",
		"layers": ["csv/BEACH_BG.csv"]
	},
	{
		"world": "BEDROOM", 
		"tileset": "res/tilemaps/Bedroom_tilemap.png",
		"layers": ["csv/BEDROOM_BG.csv"]
	},
	{
		"world": "BLANK", 
		"tileset": "res/tilemaps/Blank_tiles.png",
		"layers": ["csv/BLANK_BG.csv"]
	},
	{
		"world": "BLUE", 
		"tileset": "res/tilemaps/Blue_tilemap.png",
		"layers": ["csv/BLUE_BG.csv", "csv/BLUE_BG2.csv"]
	},
	{
		"world": "CELL", 
		"tileset": "res/tilemaps/Cell_tilemap.png",
		"layers": ["csv/TRAIN_BG.csv"]
	},
	{
		"world": "CIRCUS", 
		"tileset": "res/tilemaps/Circus_tilemap.png",
		"layers": ["csv/CIRCUS_BG.csv", "csv/CIRCUS_FG.csv"]
	},
	{
		"world": "CLIFF", 
		"tileset": "res/tilemaps/Cliff_tilemap.png",
		"layers": ["csv/CLIFF_BG.csv", "csv/CLIFF_BG2.csv"]
	},
	{
		"world": "CROWD", 
		"tileset": "res/tilemaps/Crowd_tilemap.png",
		"layers": ["csv/CROWD_BG.csv", "csv/CROWD_BG2.csv"]
	},
	{
		"world": "DEBUG", 
		"tileset": "res/tilemaps/mockup_tiles.png",
		"layers": ["csv/DEBUG_BG.csv", "csv/DEBUG_BG2.csv", "csv/DEBUG_FG.csv"]
	},
	{
		"world": "DRAWER", 
		"tileset": "res/tilemaps/BlackWhite_tilemap.png",
		"layers": ["csv/DRAWER_BG.csv"]
	},
	{
		"world": "FIELDS", 
		"tileset": "res/tilemaps/Fields_tilemap.png",
		"layers": ["csv/FIELDS_BG.csv", "csv/FIELDS_FG.csv"]
	},
	{
		"world": "FOREST", 
		"tileset": "res/tilemaps/Forest_tilemap.png",
		"layers": ["csv/FOREST_BG.csv", "csv/FOREST_BG2.csv", "csv/FOREST_FG.csv"]
	},
	{
		"world": "GO", 
		"tileset": "res/tilemaps/Go_tilemap.png",
		"layers": ["csv/GO_BG.csv", "csv/GO_BG2.csv"]
	},
	{
		"world": "HAPPY", 
		"tileset": "res/tilemaps/Happy_tilemap.png",
		"layers": ["csv/HAPPY_BG.csv", "csv/HAPPY_BG2.csv"]
	},
	{
		"world": "HOTEL", 
		"tileset": "res/tilemaps/Hotel_tilemap.png",
		"layers": ["csv/HOTEL_BG.csv", "csv/HOTEL_BG2.csv", "csv/HOTEL_FG.csv"]
	},
	{
		"world": "NEXUS", 
		"tileset": "res/tilemaps/Nexus_tilemap.png",
		"layers": ["csv/NEXUS_BG.csv", "csv/NEXUS_FG.csv"]
	},
	{
		"world": "OVERWORLD", 
		"tileset": "res/tilemaps/Overworld_tilemap.png",
		"layers": ["csv/OVERWORLD_BG.csv", "csv/OVERWORLD_BG2.csv"]
	},
	{
		"world": "REDCAVE", 
		"tileset": "res/tilemaps/REDCAVE_tiles.png",
		"layers": ["csv/REDCAVE_BG.csv", "csv/REDCAVE_BG2.csv"]
	},
	{
		"world": "REDSEA", 
		"tileset": "res/tilemaps/redsea_tiles.png",
		"layers": ["csv/REDSEA_BG.csv", "csv/REDSEA_FG.csv"]
	},
	{
		"world": "SPACE", 
		"tileset": "res/tilemaps/Space_tilemap.png",
		"layers": ["csv/SPACE_BG.csv", "csv/SPACE_BG2.csv", "csv/SPACE_FG.csv"]
	},
	{
		"world": "STREET", 
		"tileset": "res/tilemaps/Street_tilemap.png",
		"layers": ["csv/STREET_BG.csv", "csv/STREET_BG2.csv", "csv/STREET_FG.csv"]
	},
	{
		"world": "SUBURB", 
		"tileset": "res/tilemaps/Suburb_tilemap.png",
		"layers": ["csv/SUBURB_BG.csv"]
	},
	{
		"world": "TERMINAL", 
		"tileset": "res/tilemaps/Terminal_tilemap.png",
		"layers": ["csv/TERMINAL_BG.csv", "csv/TERMINAL_BG2.csv"]
	},
	{
		"world": "WINDMILL", 
		"tileset": "res/tilemaps/Windmill_tilemap.png",
		"layers": ["csv/WINDMILL_BG.csv", "csv/WINDMILL_BG2.csv"]
	}
]

entities = {
	"Treasure": { "image": "res/sprites/gadgets/treasureboxes.png", "tile_index": 1}
}


# build initial map images
maps = {}
for mapfile in mapfiles:
	print("Processing: " + mapfile["world"])
	map = generate_map_image(mapfile)
	maps[mapfile["world"]] = map


# read registry XML file that contains entity information
registry = read_registry()
treasure_tiles = read_tileset("res/sprites/gadgets/treasureboxes.png");

# draw the supported entites on the maps
for worlds in registry.keys():
	print("Processing entities: " + worlds)
	if worlds in maps.keys():
		apartment = maps[worlds]
		apartment_regs = registry[worlds]
		if "Treasure" in apartment_regs.keys():
			treasures = apartment_regs["Treasure"]
			for treasure in treasures:
				x = int(treasure["x"])
				y = int(treasure["y"])
				apartment.paste(treasure_tiles[0], (x, y, x+16, y+16), treasure_tiles[0])




# Make map directory and save images
if not os.path.exists("maps"):
    os.makedirs("maps")

for map in maps.keys():
	map_image = maps[map];
	print("Saving " + map)
	map_image.save("maps/" + map + ".png", "PNG")
