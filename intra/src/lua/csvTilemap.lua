

groups = DAME.GetGroups()
groupCount = as3.tolua(groups.length) -1

FileExt = as3.tolua(VALUE_FileExt)
csvDir = as3.tolua(VALUE_CSVDir)

-- Output tilemap data

function exportMapCSV( mapLayer, layerFileName )
	-- get the raw mapdata. To change format, modify the strings passed in (rowPrefix,rowSuffix,columnPrefix,columnSeparator,columnSuffix)
	mapText = as3.tolua(DAME.ConvertMapToText(mapLayer,"","\n","",",",""))
	--print("output to "..as3.tolua(VALUE_CSVDir).."/"..layerFileName)
	DAME.WriteFile(csvDir.."/"..layerFileName, mapText );
end



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
		if isMap == true then
			mapFileName = groupName.."_"..layerSimpleName.."."..FileExt
			-- Generate the map file.
			exportMapCSV( layer, mapFileName )
		end
	end
end


return 1
