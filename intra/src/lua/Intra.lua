--seen.lua
--a simple sprite exporter that outputs a single level node per
--set of sprites

groups = DAME.GetGroups()
groupCount = as3.tolua(groups.length) -1

DAME.SetFloatPrecision(0)

tab1 = "\t"
tab2 = "\t\t"
tab3 = "\t\t\t"
tab4 = "\t\t\t\t"

dataDir = as3.tolua(VALUE_DataDir)
levelName = as3.tolua(VALUE_LevelName)


function exportMapCSV( mapLayer, layerFileName )
	-- get the raw mapdata. To change format, modify the strings passed in (rowPrefix,rowSuffix,columnPrefix,columnSeparator,columnSuffix)
	mapText = as3.tolua(DAME.ConvertMapToText(mapLayer,"","\n","",",",""))
	--print("output to "..as3.tolua(VALUE_CSVDir).."/"..layerFileName)
	
	--Don't bother generating the BG_old tilemaps
	if (string.find(layerFileName,"BG_old") == nil) then
		DAME.WriteFile(dataDir.."/../csv/"..layerFileName, mapText );
	end
end

-- This is the file for the map level class.
fileText = ""
maps = {}
spriteLayers = {}
masterLayerAddText = ""
stageAddText = tab3.."if ( addToStage )\n"
stageAddText = stageAddText..tab3.."{\n"


for groupIndex = 0,groupCount do
	group = groups[groupIndex]
	groupName = as3.tolua(group.name)
	groupName = string.gsub(groupName, " ", "_")
	layerCount = as3.tolua(group.children.length) - 1
	
	
	-- Go through each layer and store some tables for the different layer types.
	for layerIndex = 0,layerCount do
		layer = group.children[layerIndex]
		isMap = as3.tolua(layer.map)~=nil
		layerSimpleName = as3.tolua(layer.name)
		layerSimpleName = string.gsub(layerSimpleName, " ", "_")
		layerName = groupName..layerSimpleName
		if as3.tolua(layer.IsSpriteLayer()) == true then
			table.insert( spriteLayers,{groupName,layer,layerName,layerSimpleName})
			stageAddText = stageAddText..tab4.."addSpritesForLayer"..layerName.."(onAddSpritesCallback);\n"
		end
        if isMap == true then
			mapFileName = groupName.."_"..layerSimpleName..".csv"
			-- Generate the map file.
			exportMapCSV( layer, mapFileName )
		end
	end
    
    	
    
end



-- create the sprites.
fileText = fileText.."<root>\n";
for i,v in ipairs(spriteLayers) do
	spriteLayer = spriteLayers[i]
	fileText = fileText..tab1.."<map name=\""..tostring(as3.tolua(spriteLayer[1])).."\" type=\""..tostring(as3.tolua(spriteLayer[4])).."\">\n"
	
	val_p = "%%if prop:p%%".." p=\"%prop:p%\"".."%%endprop%%"
	val_alive = "%%if prop:alive%%".." alive=\"%prop:alive%\"".."%%endprop%%"
	val_type = "%%if prop:type%%".." type=\"%prop:type%\" ".."%%endprop%%"
	
	
	
	creationText = tab2.."<%class% x=\"%xpos%\" y=\"%ypos%\" guid=\"%guid%\" frame=\"%frame%\""..val_p..val_alive..val_type.."/>\n"
	fileText = fileText..as3.tolua(DAME.CreateTextForSprites(spriteLayers[i][2],creationText,"Avatar"))
	fileText = fileText..tab1.."</map>\n"
end

fileText = fileText.."</root>\n";
	
-- Save the file!

DAME.WriteFile(dataDir.."\\"..levelName..".xml", fileText )

return 1
