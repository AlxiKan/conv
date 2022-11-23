#!/bin/bash

genFormat(){
	if [ ${format} = "html" ]; then
		echo "	Generating html file..."
		pandoc ${file} -f markdown -t html --metadata -s -o ${file::len-3}.html
		echo "	Done!"
	elif [ ${format} = "pdf" ]; then
		echo "	Generating pdf file..."
		pandoc -N --variable "geometry=margin=1.1in" --variable mainfont="OpenSans-Regular.ttf" --variable fontsize=13pt --variable version=2.0 ${file}  --pdf-engine=xelatex --toc -o ${file::len-3}.pdf;
		echo "	Done!"
	else
		echo "	Error: Wrong Argument."
	fi
}

var=0

while getopts ":i:f:h" opt; do
	case $opt in
		i) file=$OPTARG;;
		f) format=$OPTARG;;
		h) echo "HELP PAGE"; echo "-i, Name of the file"; echo "-f, Format type"; var=1;;
	esac
done

if [ ${var} = 0 ]; then
	genFormat ${file} ${format}
fi
