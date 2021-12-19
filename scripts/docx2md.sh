#!/bin/bash

# Convert all docx files to Markdown
# Requires Pandoc: https://pandoc.org/
# Tested with Pandoc 2.13

rootDir=$1
docxDir=$(realpath $rootDir"/docx")
mdDir=$(realpath $rootDir"/md")

if [ "$#" -ne 1 ] ; then
  echo "Usage: docx2md.sh rootDirectory" >&2
  exit 1
fi

while IFS= read -d $'\0' file ; do
    # Input file (docx)
    docxIn=$file
    # Input file basename, extension removed
    bName=$(basename "$docxIn" | cut -f 1 -d '.')

    # Output name (markdown)
    outName=$bName.md

    # Output file, including path
    mdOut=$mdDir/$outName

    # Convert with Pandoc
    pandoc -s \"$docxIn\" -t markdown -o \"$mdOut\"

done < <(find $docxDir -type f -regex '.*\.\(docx\|DOCX\)' -print0)
