import os
import sys

if len(sys.argv) > 1:
  input_filename = sys.argv[1]
else:
  input_filename = "dialogue.py"
output_filename = sys.argv[2];
f_in = open(input_filename,"r");
f = open(output_filename,"w")

s_start  = 0
s_halt = -1
s_npc = 1
s_area = 2
s_scene = 3

state = s_start
is_first_scene_dialogue = True
is_first_scene = True
is_first_area = True 

t1 = "\t"
t2 = "\t\t"
t3 = "\t\t\t"

tokens = []
cur_loop = 0
found_loop = False
align_top = False

# Output vars for the state object
# as well as the object holding the dialogue
state_string = ""
dialogue_string = ""

f.write("// This file was automatically generated! Don't touch it!\n")
print output_filename.split(".")[0]
f.write(
"package data{\n\
public class "+output_filename.split(".")[0]+" {\n")

for line in f_in:
    line = line.rstrip()
    line = line.lstrip()
    tokens = line.split()

    if len(tokens) == 0: 
        continue

    if tokens[0][0] == "#":
            continue

    if state == s_start :
        if line == "DONE":
            state = s_halt
        if tokens[0] == "npc":
            dialogue_string += "public static var "+tokens[1]+":Object =\n{\n"
            state_string += "public static var "+tokens[1]+"_state:Object =\n{\n"
            state = s_npc
        continue
    elif state == s_npc:
        if line == "end npc":
            # Close the npc object
            dialogue_string += "};\n\n"
            state_string += "};\n\n"
            dialogue_string += state_string
            state_string = ""
            state = s_start
            is_first_area = True
        elif tokens[0] == "area":
            # Areas within NPC are commaseparated
            if not is_first_area:
                dialogue_string += t1+",\n"
                state_string += t1+",\n"
            is_first_area = False
            # Open up a new area object
            dialogue_string += t1+tokens[1]+": {\n"
            state_string += t1+tokens[1]+": {\n"
            state = s_area
        elif line == "does reset":
            # Make this npc resettable
            state_string += t1 + "does_reset: true,\n"
                
    elif state == s_area:
        if line == "end area" :
            #print "END AREA"
            is_first_scene = True
            # Close the area object
            dialogue_string += "\t}\n"
            state_string += "\t}\n"
            state = s_npc
        elif tokens[0] == "scene":
            # Print scene name
            if not is_first_scene:
                dialogue_string += ",\n"
                state_string += ",\n"
            is_first_scene = False
            # Open up new scene object
            dialogue_string += t2+tokens[1]+": {\n"
            state_string += t2+tokens[1]+": {\n"
            dialogue_string += t3+"dialogue: new Array(\n"
            state = s_scene
        continue
    elif state == s_scene:
        if line == "end scene":
            state = s_area
            # Close the array declaration
            dialogue_string +=  ")\n"
            dialogue_string +=  t2+"}\n"
            # Scene state vars, close this scene object
            if not found_loop:
                cur_loop = 0
            # Whether text should display on top
            top_status = ""
            if (align_top == True):
                top_status = t3+"top: true,\n"
            state_string += top_status+t3+"cur: \"\",\n"+t3+"pos: 0,\n"+t3+"loop: "+str(cur_loop)+",\n"+t3+"dirty: false,\n"+t3+"finished: false\n"+t2+"}\n"
            cur_loop = 0
            is_first_scene_dialogue = True
            found_loop = False
            align_top = False
        elif line == "LOOP":
            found_loop = True
        elif line == "TOP":
            align_top = True
        else:
            # Arrays values are comma-separated
            if not is_first_scene_dialogue:
                dialogue_string += ",\n"
            is_first_scene_dialogue = False
            # Add on new string of dialogue
            dialogue_string += t3+"\t\""+line+"\""
            if not found_loop:
                cur_loop += 1
    else:
        break


#print dialogue_string
f.write(dialogue_string)
# Close the class/package declaration
f.write("}\n}")
f.close()
f_in.close()
    
      
