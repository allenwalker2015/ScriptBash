#!/bin/bash

SKIPBLANKS=
TMPDIR=/tmp
CASE=lower

#$1

           if [ -d $1 ]
           then

           echo 'Si lo haceeeeeeeeee'
           fi 

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
	
		#var1=`ls -l ${TMPDIR} | egrep -c ^-`
		var2= ls -l ${TMPDIR} | egrep -c ^d
                var3= ls -l ${TMPDIR} | egrep -c ^d
                var4= ls -l ${TMPDIR} | egrep -c ^d
                var5= ls -l ${TMPDIR} | egrep -c ^d
                var6= ls -l ${TMPDIR} | egrep -c ^d
                var7= ls -l ${TMPDIR} | egrep -c ^d
                var8= ls -l ${TMPDIR} | egrep -c ^d
		
              echo 'Se selecciono la opcion d' 
           else
              echo "$0: $OPTARG no es un directorio." >&2
              exit 1
           fi ;;
      u)   CASE=upper
           echo 'Se selecciono la opcion u'
           ;;
      :)   echo "$0: Must supply an argument to -$OPTARG" >&2
           exit 1 ;;
      \?)  echo "Opción inválida -$OPTARG ingnorada. holis" >>error.txt ;;
   esac
done

echo 'skip: '$SKIPBLANKS
echo 'tmp: '$TMPDIR
echo 'case: '$CASE

exit 0

