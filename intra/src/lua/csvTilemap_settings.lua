-- Display the settings for the exporter.

DAME.AddHtmlTextLabel("This exporter just exports the tilemaps in comma separated values format. Nothing else will be exported.")
DAME.AddBrowsePath("CSV dir:","CSVDir",false, "Where the exported file will be.")
DAME.AddTextInput("File Extension", "csv", "FileExt", true, "The file extension of the output file." )

return 1
