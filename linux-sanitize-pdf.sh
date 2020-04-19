#!/bin/bash

# Authored by Diver Drew and QuickRecon of r/scuba
# Based off of Windows Sanitize-PDF.bat by Kerbalnut
# at https://github.com/Kerbalnut/Sanitize-PDF

# Method and security notes:
# https://security.stackexchange.com/questions/103323/effectiveness-of-flattening-a-pdf-to-remove-malware
# https://www.ghostscript.com/Documentation.html
# https://www.ghostscript.com/doc/9.23/Install.htm
# https://linux.die.net/man/1/gs
# https://www.ghostscript.com/doc/current/Use.htm

echo ""
echo ""
echo ""
echo " ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~"
echo "Hey there! This shell script will take your PDF"
echo "and strip it of all active objects, trackers,"
echo "auto-launch print dialogues, and other JS crap"
echo "by using GhostScript [GNU Affero GPL license] <3"
echo " ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~"
echo "It will preserve OCR/text, as well as chapters."
echo " ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~"
echo "NOTE: this will likely NOT protect against a "
echo "deliberately-malicious PDF, especially ones that"
echo "target GhostScript and/or have image exploits."
echo " ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~"
echo ""

if [ "$#" -ne 1 ]
# "$#" is the number of command line parameters
# (if number of parameters not equal to 1)
# [ ] is shorthand for the "test" command
  then
    read -p "Enter file to convert (or specify as argument next time): " inputPDF
  else
    inputPDF=$1
fi

inputLowercase=${inputPDF,,}
# bash case-transformations (${var,,} and ${var^^}) introduced in bash v. 4
# ...because .pdf is not the same as .PDF

outputPDF=${inputLowercase/.pdf/-flattened.pdf}
# https://stackoverflow.com/questions/13210880/replace-one-substring-for-another-string-in-shell-script
# replacing ".pdf" with "-flattened.pdf" to append filename for output

gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile=$outputPDF $inputPDF

echo " ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~"
echo "Okay! Looks like we're done. Check the output"
echo "for Chapters and OCR/text-preservation."
echo "Output file will be named:"
echo "$outputPDF"
echo " ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~"
echo ""
