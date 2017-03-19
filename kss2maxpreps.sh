FILENAME=$1 
echo 'Starting the process of converting KSS file ' $FILENAME'.kss to MaxPreps Import format.' 
xsltproc -o $FILENAME.txt Kss2MaxPrepsImport.xsl $FILENAME.kss
echo 'Finished the process of converting KSS file ' $FILENAME'.kss to MaxPreps Import format.' 
