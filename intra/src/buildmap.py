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
# The source folder should be in ./Anodyne/src/
# The map images will be outputted to ./maps/ in PNG format.
#

import os
import csv
from PIL import Image
from xml import sax

def read_layer(filename):
	f = open(filename, "rb")
	map_reader = csv.reader(f, delimiter=",")
	map = []
	for row in map_reader:
		map.append(row)
	f.close()
	return map


def read_tileset(filename):
	tilesetimage = Image.open(filename);
	tilesetimage_xblocks = tilesetimage.size[0] / 16
	tilesetimage_yblocks = tilesetimage.size[1] / 16
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
	parser.parse( 'Anodyne/src/global/Registry_embedXML.dat')
	return handler.registry

	

mapfiles = [ 
	{
		"world": "APARTMENT", 
		"tileset": "Anodyne/src/data/TileData__Apartment_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_APARTMENT_BG.dat", "Anodyne/src/data/CSV_Data_APARTMENT_BG2.dat", "Anodyne/src/data/CSV_Data_APARTMENT_FG.dat"]
	},
	{
		"world": "BEACH", 
		"tileset": "Anodyne/src/data/TileData__Beach_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_BEACH_BG.dat"]
	},
	{
		"world": "BEDROOM", 
		"tileset": "Anodyne/src/data/TileData__Bedroom_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_BEDROOM_BG.dat"]
	},
	{
		"world": "BLANK", 
		"tileset": "Anodyne/src/data/TileData_Blank_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_BLANK_BG.dat"]
	},
	{
		"world": "BLUE", 
		"tileset": "Anodyne/src/data/TileData_Blue_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_BLUE_BG.dat", "Anodyne/src/data/CSV_Data_BLUE_BG2.dat"]
	},
	{
		"world": "CELL", 
		"tileset": "Anodyne/src/data/TileData_Cell_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_CELL_BG.dat"]
	},
	{
		"world": "CIRCUS", 
		"tileset": "Anodyne/src/data/TileData__Circus_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_CIRCUS_BG.dat", "Anodyne/src/data/CSV_Data_CIRCUS_FG.dat"]
	},
	{
		"world": "CLIFF", 
		"tileset": "Anodyne/src/data/TileData_Cliff_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_CLIFF_BG.dat", "Anodyne/src/data/CSV_Data_CLIFF_BG2.dat"]
	},
	{
		"world": "CROWD", 
		"tileset": "Anodyne/src/data/TileData__Crowd_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_CROWD_BG.dat", "Anodyne/src/data/CSV_Data_CROWD_BG2.dat"]
	},
	{
		"world": "DEBUG", 
		"tileset": "Anodyne/src/data/TileData_Debug_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_DEBUG_BG.dat", "Anodyne/src/data/CSV_Data_DEBUG_BG2.dat", "Anodyne/src/data/CSV_Data_DEBUG_FG.dat"]
	},
	{
		"world": "DRAWER", 
		"tileset": "Anodyne/src/data/TileData_BlackWhite_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_DRAWER_BG.dat"]
	},
	{
		"world": "FIELDS", 
		"tileset": "Anodyne/src/data/TileData__Fields_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_FIELDS_BG.dat", "Anodyne/src/data/CSV_Data_FIELDS_FG.dat"]
	},
	{
		"world": "FOREST", 
		"tileset": "Anodyne/src/data/TileData_Forest_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_FOREST_BG.dat", "Anodyne/src/data/CSV_Data_FOREST_BG2.dat", "Anodyne/src/data/CSV_Data_FOREST_FG.dat"]
	},
	{
		"world": "GO", 
		"tileset": "Anodyne/src/data/TileData_Go_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_GO_BG.dat", "Anodyne/src/data/CSV_Data_GO_BG2.dat"]
	},
	{
		"world": "HAPPY", 
		"tileset": "Anodyne/src/data/TileData_Happy_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_HAPPY_BG.dat", "Anodyne/src/data/CSV_Data_HAPPY_BG2.dat"]
	},
	{
		"world": "HOTEL", 
		"tileset": "Anodyne/src/data/TileData__Hotel_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_HOTEL_BG.dat", "Anodyne/src/data/CSV_Data_HOTEL_BG2.dat", "Anodyne/src/data/CSV_Data_HOTEL_FG.dat"]
	},
	{
		"world": "NEXUS", 
		"tileset": "Anodyne/src/data/TileData__Nexus_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_NEXUS_BG.dat", "Anodyne/src/data/CSV_Data_NEXUS_FG.dat"]
	},
	{
		"world": "OVERWORLD", 
		"tileset": "Anodyne/src/data/TileData__Overworld_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_OVERWORLD_BG.dat", "Anodyne/src/data/CSV_Data_OVERWORLD_BG2.dat"]
	},
	{
		"world": "REDCAVE", 
		"tileset": "Anodyne/src/data/TileData_REDCAVE_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_REDCAVE_BG.dat", "Anodyne/src/data/CSV_Data_REDCAVE_BG2.dat"]
	},
	{
		"world": "REDSEA", 
		"tileset": "Anodyne/src/data/TileData_Red_Sea_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_REDSEA_BG.dat", "Anodyne/src/data/CSV_Data_REDSEA_FG.dat"]
	},
	{
		"world": "SPACE", 
		"tileset": "Anodyne/src/data/TileData_Space_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_SPACE_BG.dat", "Anodyne/src/data/CSV_Data_SPACE_BG2.dat", "Anodyne/src/data/CSV_Data_SPACE_FG.dat"]
	},
	{
		"world": "STREET", 
		"tileset": "Anodyne/src/data/TileData__Street_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_STREET_BG.dat", "Anodyne/src/data/CSV_Data_STREET_BG2.dat", "Anodyne/src/data/CSV_Data_STREET_FG.dat"]
	},
	{
		"world": "SUBURB", 
		"tileset": "Anodyne/src/data/TileData_Suburb_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_SUBURB_BG.dat"]
	},
	{
		"world": "TERMINAL", 
		"tileset": "Anodyne/src/data/TileData_Terminal_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_TERMINAL_BG.dat", "Anodyne/src/data/CSV_Data_TERMINAL_BG2.dat"]
	},
	{
		"world": "WINDMILL", 
		"tileset": "Anodyne/src/data/TileData__Windmill_Tiles.png",
		"layers": ["Anodyne/src/data/CSV_Data_WINDMILL_BG.dat", "Anodyne/src/data/CSV_Data_WINDMILL_BG2.dat"]
	}
]

entities = {
	"Treasure": { "image": "Anodyne/src/entity/gadget/Treasure_S_TREASURE_SPRITE.png", "tile_index": 1}
}


# build initial map images
maps = {}
for mapfile in mapfiles:
	print "Processing: " + mapfile["world"]
	map = generate_map_image(mapfile)
	maps[mapfile["world"]] = map


# read registry XML file that contains entity information
registry = read_registry()
treasure_tiles = read_tileset("Anodyne/src/entity/gadget/Treasure_S_TREASURE_SPRITE.png");

# draw the supported entites on the maps
for worlds in registry.keys():
	print "Processing entities: " + worlds
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
	print "Saving " + map
	map_image.save("maps/" + map + ".png", "PNG")
