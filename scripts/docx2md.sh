#!/bin/bash

# Convert all docx files to Markdown
# Requires Pandoc: https://pandoc.org/
# Tested with Pandoc 2.13

# Script argument is root dir of this repo
rootDir=$1
docxDir=$(realpath $rootDir"/docx")
mdDir=$(realpath $rootDir"/md")

# Display usage if no of arguments not equal to 1
if [ "$#" -ne 1 ] ; then
  echo "Usage: docx2md.sh rootDirectory" >&2
  exit 1
fi

# Iterate over files in docx directory
while IFS= read -d $'\0' file ; do
    # Input file basename, extension removed
    bName=$(basename "$file" | cut -f 1 -d '.')

    # Add docx extension for input file name
    inName="$bName".docx

    # Add md extension for output file name
    outName="$bName".md

    # Full path to input file
    docxIn="$docxDir"/"$inName"

    # Full path to output file
    mdOut="$mdDir"/"$outName"

    # Print input, output file paths to terminal
    echo $docxIn
    echo $mdOut

    # Convert file with Pandoc
    pandoc -s "$docxIn" -t markdown -o "$mdOut"
    
done < <(find $docxDir -type f -print0)