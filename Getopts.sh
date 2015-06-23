#!/bin/bash

<<<<<<< HEAD
SKIPBLANKS=
TMPDIR=/tmp
CASE=lower

#$1

if [ "$0"  == ./Getopts.sh ]; then
echo "Es getoptsssssssssss"
fi
if [ -d "$1" ] ; then
echo "Es un directoriooooo" 
fi

         #  if [ -d $1 ]
          # then

           #echo 'Si lo haceeeeeeeeee'
           #fi 

while getopts :bt:u arg
do
   case $arg in
      b)   SKIPBLANKS=TRUE ;;
      # c)   if [ -d "$OPTARG" ]
         #  then
         #  echo 'Se selecciono la opcion u'
         #  fi ;;
      t)   if [ -d "$OPTARG" ]
           then
              TMPDIR=$OPTARG
		echo "El valor de TMPDIR: "$TMPDIR
		var1=`ls -l ${TMPDIR} | egrep -c ^-`

		find ${TMPDIR} -type f | egrep "txt" > /home/ronaldo/Escritorio/txt.txt
		txt=`egrep -c "*.txt" /home/ronaldo/Escritorio/txt.txt`

		find ${TMPDIR} -type f | egrep "pdf" > /home/ronaldo/Escritorio/pdf.txt
		pdf=`egrep -c "pdf" /home/ronaldo/Escritorio/pdf.txt`

		find ${TMPDIR} -type f | egrep "mp3" > /home/ronaldo/Escritorio/mp3.txt
		mp3=`egrep -c "mp3" /home/ronaldo/Escritorio/mp3.txt`

		find ${TMPDIR} -type f | egrep "png" > /home/ronaldo/Escritorio/png.txt
		png=`egrep -c "png" /home/ronaldo/Escritorio/png.txt`

		find ${TMPDIR} -type f | egrep "odt" > /home/ronaldo/Escritorio/odt.txt
		odt=`egrep -c "odt" /home/ronaldo/Escritorio/odt.txt`

		#find ${TMPDIR} -type f | egrep "*" > /home/ronaldo/Escritorio/otros.txt
		#otros=`egrep -c "*" /home/ronaldo/Escritorio/otros.txt`

      suma=$(($txt+$pdf+$mp3+$png+$odt))
      otros=$(($var1-$suma))

		echo "La cantidad de ficheros es: "${var1}
		echo "lo que guarda txt es: "${txt}
      echo "lo que guarda pdf es: "${pdf}
      echo "lo que guarda mp3 es: "${mp3}
      echo "lo que guarda png es: "${png}
      echo "lo que guarda odt es: "${odt}
      echo "lo que guarda otros es: "${otros}
		echo "Lo que guarda varl1 es: "$varl1
		
#- archivos regulares
#d directorios
#c dispositivos de caracter
#b dispositivos de bloque
#s sockets
#p tuberías
#l links		
=======
if [ "$0"  == ./Getopts.sh -a ! -d "$1" ]; then
	logger -p error -t GESTOR_ALARMAS Falta Argumento válido
	echo "Missing dirname ("./Getopts.sh --help" for help)"


elif [ "$0"  == ./Getopts.sh -a -d "$1" ] ; then
	TMPDIR=$1
   echo ""
	echo "El directorio que usted ingreso es: "$TMPDIR

	ArchivosReglaresT=`find ${TMPDIR} -type f | egrep -c "*"`
      echo "La cantidad total de archivos regulares es: "${ArchivosReglaresT}
      echo ""

      #IMAGENES:
      png=`find ${TMPDIR} -type f | grep -E -c "*\.png$"`
      cdr=`find ${TMPDIR} -type f | grep -E -c "*\.cdr$"`
      cpt=`find ${TMPDIR} -type f | grep -E -c "*\.cpt$"`
      jpeg=`find ${TMPDIR} -type f | grep -E -c "*\.jpeg$"`
      jfif=`find ${TMPDIR} -type f | grep -E -c "*\.jfif$"`
      ppt=`find ${TMPDIR} -type f | grep -E -c "*\.ppt$"`
      pps=`find ${TMPDIR} -type f | grep -E -c "*\.pps$"`
      jpg=`find ${TMPDIR} -type f | grep -E -c "*\jpg$"`
      raw=`find ${TMPDIR} -type f | grep -E -c "*\raw$"`
      psd=`find ${TMPDIR} -type f | grep -E -c "*\psd$"`
      tiff=`find ${TMPDIR} -type f | grep -E -c "*\tiff$"`
      xcf=`find ${TMPDIR} -type f | grep -E -c "*\xcf$"`
      gif=`find ${TMPDIR} -type f | grep -E -c "*\gif$"`
      eps=`find ${TMPDIR} -type f | grep -E -c "*\eps$"`
      dng=`find ${TMPDIR} -type f | grep -E -c "*\dng$"`
      psb=`find ${TMPDIR} -type f | grep -E -c "*\psb$"`
      jp2=`find ${TMPDIR} -type f | grep -E -c "*\jp2$"`
      		sumaImagenes=$(($png+$cdr+$cpt+$jpeg+$jfif+$ppt+$pps+$jpg+$raw+$psd+$tiff+$xcf+$gif+$eps+$dng+$psb+$jp2))
            echo "IMAGENES: "$sumaImagenes

      #DOCUMENTOS:
      txt=`find ${TMPDIR} -type f | grep -E -c "*\.txt$"`
      css=`find ${TMPDIR} -type f | grep -E -c "*\.css$"`
      htm=`find ${TMPDIR} -type f | grep -E -c "*\.htm$"`
      ps=`find ${TMPDIR} -type f | grep -E -c "*\.ps$"`
      xlsx=`find ${TMPDIR} -type f | grep -E -c "*\.xlsx$"`
      ppt=`find ${TMPDIR} -type f | grep -E -c "*\.txt$"`
      odf=`find ${TMPDIR} -type f | grep -E -c "*\.odf$"`
      odt=`find ${TMPDIR} -type f | grep -E -c "*\.odt$"`
      ods=`find ${TMPDIR} -type f | grep -E -c "*\.ods$"`
      odg=`find ${TMPDIR} -type f | grep -E -c "*\.odg$"`
      odp=`find ${TMPDIR} -type f | grep -E -c "*\.odp$"`
      pdf=`find ${TMPDIR} -type f | grep -E -c "*\.pdf$"`
      ott=`find ${TMPDIR} -type f | grep -E -c "*\.ott$"`
      fodt=`find ${TMPDIR} -type f | grep -E -c "*\.fodt$"`
      uot=`find ${TMPDIR} -type f | grep -E -c "*\.uot$"`
      docx=`find ${TMPDIR} -type f | grep -E -c "*\.docx$"`
      xml=`find ${TMPDIR} -type f | grep -E -c "*\.xml$"`
      doc=`find ${TMPDIR} -type f | grep -E -c "*\.doc$"`
      dot=`find ${TMPDIR} -type f | grep -E -c "*\.dot$"`
      html=`find ${TMPDIR} -type f | grep -E -c "*\.html$"`
      rtf=`find ${TMPDIR} -type f | grep -E -c "*\.rtf$"`
         sumaDocumentos=$(($txt+$odf+$odt+$ods+$odg+$odp+$pdf+$ott+$fodt+$uot+$docx+$xml+$doc+$dot+$html+$rtf))
         echo "DOCUMENTOS: "$sumaDocumentos

      #AUDIO:
      cda=`find ${TMPDIR} -type f | grep -E -c "*\.cda$"`
      mp3=`find ${TMPDIR} -type f | grep -E -c "*\.mp3$"`
      ogg=`find ${TMPDIR} -type f | grep -E -c "*\.ogg$"`
      wav=`find ${TMPDIR} -type f | grep -E -c "*\.wav$"`
      au=`find ${TMPDIR} -type f | grep -E -c "*\.au$"`
      uLaw=`find ${TMPDIR} -type f | grep -E -c "*\.uLaw$"`
      MuLaw=`find ${TMPDIR} -type f | grep -E -c "*\.MuLaw$"`
      aiff=`find ${TMPDIR} -type f | grep -E -c "*\.aiff$"`
      mid=`find ${TMPDIR} -type f | grep -E -c "*\.mid$"`
      midi=`find ${TMPDIR} -type f | grep -E -c "*\.midi$"`
      imi=`find ${TMPDIR} -type f | grep -E -c "*\.rmi$"`
      wav=`find ${TMPDIR} -type f | grep -E -c "*\.wav$"`
      ra=`find ${TMPDIR} -type f | grep -E -c "*\.ra$"`
         sumaAudio=$(($cda+$mp3+$ogg+$wav+$au+$uLaw+$MuLaw+$aiff+$mid+$midi+$rmi+$wav+$ra))
         echo "AUDIO: "$sumaAudio
         
      #VIDEO:
      avi=`find ${TMPDIR} -type f | grep -E -c "*\.avi$"`
      mov=`find ${TMPDIR} -type f | grep -E -c "*\.mov$"`
      movie=`find ${TMPDIR} -type f | grep -E -c "*\.movie$"`
      mpg=`find ${TMPDIR} -type f | grep -E -c "*\.mpg$"`
      mpeg=`find ${TMPDIR} -type f | grep -E -c "*\.mpeg$"`
      qt=`find ${TMPDIR} -type f | grep -E -c "*\.qt$"`
      ram=`find ${TMPDIR} -type f | grep -E -c "*\.ram$"`
      mp4=`find ${TMPDIR} -type f | grep -E -c "*\.mp4$"`
      wmv=`find ${TMPDIR} -type f | grep -E -c "*\.wmv$"`
      ogv=`find ${TMPDIR} -type f | grep -E -c "*\.ogv$"`
         sumaVideo=$(($avi+$mov+$movie+$mpg+$mpeg+$qt+$ram+$mp4+$wmv+$ogv))
         echo "VIDEO: "$sumaVideo

      #COMPRIMIDOS:
      gz=`find ${TMPDIR} -type f | grep -E -c "*\.gz$"`
      gzip=`find ${TMPDIR} -type f | grep -E -c "*\.gzip$"`
      tar=`find ${TMPDIR} -type f | grep -E -c "*\.tar$"`
      targz=`find ${TMPDIR} -type f | grep -E -c "*\.tar.gz$"`
      tarZ=`find ${TMPDIR} -type f | grep -E -c "*\.tar.Z$"`
      tgz=`find ${TMPDIR} -type f | grep -E -c "*\.tgz$"`
      zip=`find ${TMPDIR} -type f | grep -E -c "*\.zip$"`
      arj=`find ${TMPDIR} -type f | grep -E -c "*\.arj$"`
      rar=`find ${TMPDIR} -type f | grep -E -c "*\.rar$"`
      z=`find ${TMPDIR} -type f | grep -E -c "*\.Z$"`     
         sumaComprimidos=$(())
         echo "COMPRIMIDOS: "$sumaComprimidos

		#find ${TMPDIR} -type f | egrep "mp3" > /var/tmp/Proyecto/pdf.txt
		#mp3=`egrep -c "mp3" /var/tmp/Proyecto/pdf.txt`

#http://www.ccee.edu.uy/ensenian/catcomp/material/ArchivosFormatosExtensiones.pdf
#http://cefire.edu.gva.es/pluginfile.php/277781/mod_resource/content/1/Unidad4/unidad4_html/formatos_de_archivos_y_extensiones.html
#http://www.taringa.net/comunidades/ubuntuparataringeros/3894103/Pregunta-Extension-de-las-aplicaciones-en-linux.html


      		suma=$(($txt+$pdf+$mp3+$png+$odt))
      		otros=$(($ArchivosReglaresT-$suma))

      echo ""
     	echo "lo que guarda otros es: "${otros}
>>>>>>> origin/master
	
echo "Es un directoriooooo" 
fi

exit 0

