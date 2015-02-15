# resumix
A XSL stylesheet for transforming a resume from XML data to an SVG layout

Update your resume details in the XML file and generate a new SVG/PDF when needed.

# Instructions
First generate the SVG using an input XML and XSLT

```
java -jar saxon9he.jar -s:resume.xml -xsl:resumator.xsl -o:output.svg
```

Then convert the to convert the SVG into a PDF we'll use the SMTP program

```
java -jar SMTP/out/artifacts/SMTP_jar/SMTP.jar -f output.svg -p 2 -o output.pdf
```
-f and -o are are to specify the input and output files
-p is used to specify how many pages are present, since this is not automatically detected yet