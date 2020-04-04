-- Display the settings for the exporter.
DAME.AddHtmlTextLabel("An simple xml exporter to demonstrate a different output format. Not to be used directly but serve as an example for your own exporter.")
DAME.AddBrowsePath("Xml dir:","DataDir",false, "Where you place the xml files.")

DAME.AddTextInput("Level Name", "", "LevelName", true, "The name you wish to call this level." )

return 1
