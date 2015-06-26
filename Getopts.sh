#!/bin/bash
#---------------------------------VERIFICACIONES DEL DIRECTORIO /var/--------------------------#
ls /var/Proyecto 1>/dev/null 2>/dev/null
#echo "*******"$?
if [ ! $? == 0 ]; then #no existe esa carpeta
   sudo mkdir /var/Proyecto 1>/dev/null 2>/dev/null
else
   #echo 'UNOOOOO'
   logger -p error -t PROYECTO_IASGL Imposible crear carpeta necesaria
   #exit 1
fi

ls /var/Proyecto/ArchivoProyecto 1>/dev/null 2>/dev/null
if [ ! $? == 0 ]; then
   sudo touch /var/Proyecto/ArchivoProyecto 2>/dev/null
else
   #echo 'DOSSSSSSS'
   logger -p error -t PROYECTO_IASGL Imposible crear archivo necesario
   #exit 1
fi

#---------------------------------VERIFICACIONES DEL DIRECTORIO /etc/--------------------------#
ls /etc/variables.sh 1>/dev/null 2>/dev/null
   if [ ! $? == 0 ]; then
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "Error." | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "Razón: Su computadora no cumple con los requisitos mínimos para poder ejecutar este comando." | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "Lo que usted debe hacer es: Copiar el archivo variables.sh suministrado junto al archivo que usted esta corriendo, con el siguiente comando: " | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "sudo cp -i / *Dirección en la cual se encuentra el archivo variables.sh*/ /etc/" | sudo tee -a /var/Proyecto/ArchivoProyecto
      logger -p error -t PROYECTO_IASGL No se encontró el archivo /etc/variables.sh 
      exit 1
   fi
AYUDA=`sudo grep "^AYUDA" /etc/variables.sh | sed 's/AYUDA=\(.*\)/\1/g'` 2>/dev/null
PORCENTAJE=`sudo grep "^PORCENTAJE" /etc/variables.sh | sed 's/PORCENTAJE=\(.*\)/\1/g'`
DPROFUNDIDAD=`sudo grep "^DPROFUNDIDAD" /etc/variables.sh | sed 's/DPROFUNDIDAD=\(.*\)/\1/g'`
TMPDIR=

function AYUDA(){
   echo -e "\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------\n\nSCRIPT GETOPTS:\n\tGetopts es un script con la funcionalidad de mostrar la cantidad de archivos regulares contenidos en un directorio dado, clasificándolos según sea el tipo\n\tdel archivo, ya sea: imágenes, archivos de texto, comprimidos, librerías, archivos de audio, video, archivos de sistema y otros. Por otra parte, Getopts\n\tcuenta con un historial de ejecuciones del mismo script, el cual se guarda en un archivo llamado ArchivoProyecto.txt. Dicho archivo se encuentra en el\n\tdirectorio /var/Proyecto. Getopts también cuenta con un archivo que contiene las variables de configuración ubicado en el directorio /etc/, llamado\n\tvariables.sh.\n\n\tSi se utiliza Getopts por primera vez en una computadora se debe tener en cuenta aspectos muy importantes antes de ejecutar el script:\n\t    1) Copiar el archivo regular variables.sh (el cual se brinda junto con este script), al directorio /etc/ con el comando:\n\t       sudo cp -r /*Dirección en la cual se encuentra el archivo variables.sh*/ /etc/.\n\t    2) Es posible que se le pida digitar su contraseña, esto se hace para poder crear los directorios necesarios para el correcto funcionamiento del script.\n\nSINTAXIS:\n\t./Getopts [OPCIONES] RutaAbsolutaDelDirectorio\n\nOPCIONES:\n\t-d  --- Indica que el proceso de clasificación se hará con la PROFUNDIDAD igual a 1.\n\t\tSi la variable DPROFUNDIDAD (variables.sh)=1 el proceso se hará con una profundidad de búsqueda igual a 1, si DPROFUNDIDAD (variables.sh)=0 el proceso\n\t\tse hará sin límite de profundidad. La opción -d no recibe ningún parámetro.\n\n\t-p1 --- Muestra la cantidad de archivos clasificados por cada tipo en FORMATO DE PORCENTAJE. Estrictamente la opción -p debe llevar como argumento el número 1.\n\n\t-h  --- Descripción del Script, sintaxis y ayuda. Está opción no requiere de parámetros. La opción -h no se puede combinar.\n\nCOMBINACIONES DE OPCIONES:\n\t./Getopts -dp1 ../RutaDirectorio\n\t./Getopts -p1d ../RutaDirectorio\n\t./Getopts -d -p1 ../RutaDirectorio\n\t./Getopts -d ../RutaDirectorio\n\t./Getopts -p1 ../RutaDirectorio\n\t./Getopts -h\n\nMENSAJES DE ERROR:\n\t--Proceso abortado. Razón: es necesario un directorio --SOLUCIÓN: digitar una ruta válida de directorio como argumento.\n\t\tEjemplo: ./Getopts /home/usuario/Descargas\n\n\t--Proceso abortado. Razón: opción inválida -[valor numérico] detectado. --SOLUCIÓN: no ingresar ningún parámetro con la opción -d.\n\t\tEjemplo: ./Getopts -d /home/usuario/Descargas\n\n\t--Proceso abortado. Razón: sólo se admite -p1 --SOLUCIÓN: Estrictamente -p debe llevar como argumento el número 1.\n\t\tEjemplo: ./Getopts -p1 /home/usuario/Descargas\n\n--------------------------------------------------------------------------------------------------------------------------------------------------------------------\n"
   echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
   echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
   echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
   echo "Se mostró la ayuda con el comando -h" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
}

function PROCESO(){
   ArchivosReglaresT_A=`find ${TMPDIR} -maxdepth 1 -type f 2>/dev/null`

   if [ ! $? == 0 ]; then
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "Error." | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "Razón: Su computadora no cumple con los requisitos mínimos para poder ejecutar este comando." | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "No tiene permisos de ingreso a algún directorio, para poder contar sus archivos." | sudo tee -a /var/Proyecto/ArchivoProyecto
      logger -p error -t PROYECTO_IASGL No tiene permisos de ingreso a algún directorio, para poder contar sus archivos
      exit 1
   fi

   ArchivosReglaresT=`find ${TMPDIR} -maxdepth 1 -type f | egrep -c "*" 2>/dev/null`
      
      #IMAGENES:
      sumaImagenes=`find ${TMPDIR} -maxdepth 1 -type f | grep -E -c "*\.(png|cdr|cpt|jpeg|jfif|ppt|pps|jpg|raw|psd|tiff|xcf|gif|eps|dng|psb|jp2|JPG)$" 2>/dev/null`

      #DOCUMENTOS:
      sumaDocumentos=`find ${TMPDIR} -maxdepth 1 -type f | grep -E -c "*\.(txt|css|htm|ps|xlsx|txt|odf|odt|ods|odg|odp|pdf|ott|fodt|uot|docx|xml|doc|dot|html|rtf)$" 2>/dev/null`

      #AUDIO:
      sumaAudio=`find ${TMPDIR} -maxdepth 1 -type f | grep -E -c "*\.(cda|mp3|ogg|wav|au|uLaw|MuLaw|aiff|mid|midi|rmi|wav|ra)$" 2>/dev/null`
         
      #VIDEO:
      sumaVideo=`find ${TMPDIR} -maxdepth 1 -type f | grep -E -c "*\.(avi|mov|movie|mpg|mpeg|qt|ram|mp4|wmv|ogv|AVI)$" 2>/dev/null`

      #COMPRIMIDOS:
      sumaComprimidos=`find ${TMPDIR} -maxdepth 1 -type f | grep -E -c "*\.(gz|gzip|tar|tar.gz|tar.Z|tgz|zip|arj|rar|Z)$" 2>/dev/null`

      #EJECUTABLES
      sumaEjecutables=`find ${TMPDIR} -maxdepth 1 -type f | grep -E -c "*\.(bas|bat|bin|cfg|dll|com|drv|exe|vxd|elf|pl|py|sh)$" 2>/dev/null`

      #CODIGOS FUENTES Y LIBRERIAS
      sumaCoFuLibrerias=`find ${TMPDIR} -maxdepth 1 -type f | grep -E -c "*\.(a|c|cpp|diff|h|lo|o|so|jar|rkt)$" 2>/dev/null`
      
      #ARCHIVOS DEL SISTEMA:
      sumaArchSistema=`find ${TMPDIR} -maxdepth 1 -type f | grep -E -c "*\.(conf|ko|lock|log|pid|socket|tmp)$" 2>/dev/null`

      suma=$(($sumaImagenes+$sumaDocumentos+$sumaAudio+$sumaVideo+$sumaComprimidos+$sumaEjecutables+$sumaCoFuLibrerias+$sumaArchSistema))
      		
      otros=$(($ArchivosReglaresT-$suma))
}

function PROCESO_RECURSIVO(){
   ArchivosReglaresT_A=`find ${TMPDIR} -type f 2>/dev/null`
   
   if [ ! $? == 0 ]; then
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "Error." | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "Razón: Su computadora no cumple con los requisitos mínimos para poder ejecutar este comando." | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "No tiene permisos de ingreso a algún directorio, para poder contar sus archivos." | sudo tee -a /var/Proyecto/ArchivoProyecto
      logger -p error -t PROYECTO_IASGL No tiene permisos de ingreso a algún directorio, para poder contar sus archivos
      exit 1
   fi
   ArchivosReglaresT=`find ${TMPDIR} -type f | egrep -c "*"`   
   
      #IMAGENES:
      sumaImagenes=`find ${TMPDIR} -type f | grep -E -c "*\.(png|cdr|cpt|jpeg|jfif|ppt|pps|jpg|raw|psd|tiff|xcf|gif|eps|dng|psb|jp2|JPG)$" 2>/dev/null`

      #DOCUMENTOS:
      sumaDocumentos=`find ${TMPDIR} -type f | grep -E -c "*\.(txt|css|htm|ps|xlsx|txt|odf|odt|ods|odg|odp|pdf|ott|fodt|uot|docx|xml|doc|dot|html|rtf)$" 2>/dev/null`

      #AUDIO:
      sumaAudio=`find ${TMPDIR} -type f | grep -E -c "*\.(cda|mp3|ogg|wav|au|uLaw|MuLaw|aiff|mid|midi|rmi|wav|ra)$" 2>/dev/null`
         
      #VIDEO:
      sumaVideo=`find ${TMPDIR} -type f | grep -E -c "*\.(avi|mov|movie|mpg|mpeg|qt|ram|mp4|wmv|ogv|AVI)$" 2>/dev/null`

      #COMPRIMIDOS:
      sumaComprimidos=`find ${TMPDIR} -type f | grep -E -c "*\.(gz|gzip|tar|tar.gz|tar.Z|tgz|zip|arj|rar|Z)$" 2>/dev/null`

      #EJECUTABLES
      sumaEjecutables=`find ${TMPDIR} -type f | grep -E -c "*\.(bas|bat|bin|cfg|dll|com|drv|exe|vxd|elf|pl|py|sh)$" 2>/dev/null`

      #CODIGOS FUENTES Y LIBRERIAS
      sumaCoFuLibrerias=`find ${TMPDIR} -type f | grep -E -c "*\.(a|c|cpp|diff|h|lo|o|so|jar|rkt)$" 2>/dev/null`
      
      #ARCHIVOS DEL SISTEMA:
      sumaArchSistema=`find ${TMPDIR} -type f | grep -E -c "*\.(conf|ko|lock|log|pid|socket|tmp)$" 2>/dev/null`

      suma=$(($sumaImagenes+$sumaDocumentos+$sumaAudio+$sumaVideo+$sumaComprimidos+$sumaEjecutables+$sumaCoFuLibrerias+$sumaArchSistema))
      		
      otros=$(($ArchivosReglaresT-$suma))
}

function NORMAL(){
   PROCESO
   if [ "$suma" == 0 ]; then
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "El directorio que usted ingreso es: "$TMPDIR | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso no contiene archivos regulares." | sudo tee -a /var/Proyecto/ArchivoProyecto
   else
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "El directorio que usted ingreso es: "$TMPDIR | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "La cantidad total de archivos regulares es: "${ArchivosReglaresT} | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "IMAGENES: "$sumaImagenes | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "DOCUMENTOS: "$sumaDocumentos | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "AUDIO: "$sumaAudio | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "VIDEO: "$sumaVideo | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "COMPRIMIDOS: "$sumaComprimidos | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "EJECUTABLES: "$sumaEjecutables | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "LIBRERIAS: "$sumaCoFuLibrerias | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "ARCHIVOS DEL SISTEMA: "$sumaArchSistema | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "OTROS: "${otros} | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo ""
   fi
}

function PORCENTAJE(){
   PROCESO
   if [ "$suma" == 0 ]; then
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "El directorio que usted ingreso es: "$TMPDIR | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso no contiene archivos regulares." | sudo tee -a /var/Proyecto/ArchivoProyecto
   else
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "El directorio que usted ingreso es: "$TMPDIR | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "La cantidad total de archivos regulares es: "${ArchivosReglaresT} | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "IMAGENES: "$((100*$sumaImagenes/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "DOCUMENTOS: "$((100*$sumaDocumentos/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "AUDIO: "$((100*$sumaAudio/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "VIDEO: "$((100*$sumaVideo/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "COMPRIMIDOS: "$((100*$sumaComprimidos/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "EJECUTABLES: "$((100*$sumaEjecutables/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "LIBRERIAS: "$((100*$sumaCoFuLibrerias/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "ARCHIVOS DEL SISTEMA: "$((100*$sumaArchSistema/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "OTROS: "$((100*$otros/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo ""
   fi
}

function RECURSIVO(){
   PROCESO_RECURSIVO
   if [ "$suma" == 0 ]; then
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "El directorio que usted ingreso es: "$TMPDIR | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso no contiene archivos regulares." | sudo tee -a /var/Proyecto/ArchivoProyecto
   else
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "El directorio que usted ingreso es: "$TMPDIR | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "La cantidad total de archivos regulares es: "${ArchivosReglaresT} | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "IMAGENES: "$sumaImagenes | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "DOCUMENTOS: "$sumaDocumentos | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "AUDIO: "$sumaAudio | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "VIDEO: "$sumaVideo | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "COMPRIMIDOS: "$sumaComprimidos | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "EJECUTABLES: "$sumaEjecutables | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "LIBRERIAS: "$sumaCoFuLibrerias | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "ARCHIVOS DEL SISTEMA: "$sumaArchSistema | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "OTROS: "${otros} | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo ""
   fi
}

function PORCENTAJE_RECURSIVO(){
   PROCESO_RECURSIVO
   if [ "$suma" == 0 ]; then
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "El directorio que usted ingreso es: "$TMPDIR | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso no contiene archivos regulares." | sudo tee -a /var/Proyecto/ArchivoProyecto
   else
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "El directorio que usted ingreso es: "$TMPDIR | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "La cantidad total de archivos regulares es: "${ArchivosReglaresT} | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "IMAGENES: "$((100*$sumaImagenes/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "DOCUMENTOS: "$((100*$sumaDocumentos/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "AUDIO: "$((100*$sumaAudio/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "VIDEO: "$((100*$sumaVideo/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "COMPRIMIDOS: "$((100*$sumaComprimidos/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "EJECUTABLES: "$((100*$sumaEjecutables/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "LIBRERIAS: "$((100*$sumaCoFuLibrerias/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "ARCHIVOS DEL SISTEMA: "$((100*$sumaArchSistema/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "OTROS: "$((100*$otros/$ArchivosReglaresT))"%" | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo ""
   fi
}

#------------------------------------FIN DE LAS FUNCIONES---------------------------------#

   while getopts :dhp: arg
      do
      case $arg in
         d)   DPROFUNDIDAD=0 ;;
         h)   if [ $# == 1 ]; then
                 AYUDA=1
              else
                 echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
                 echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
                 date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null 
                 echo "Proceso abortado." | sudo tee -a /var/Proyecto/ArchivoProyecto
                 echo "Razón: opción -h no se puede combinar." | sudo tee -a /var/Proyecto/ArchivoProyecto
                 logger -p auth.error -t PROYECTO_IASGL Combinación inválida
                 exit 1
              fi ;;
         p)   NUMERO=$(echo $OPTARG | egrep --only-matching '^[0-9]+')
              if [ "$NUMERO" == 1 ]; then
                 PORCENTAJE=$NUMERO
              else
                 echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
                 echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
                 date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
                 echo "Proceso abortado." | sudo tee -a /var/Proyecto/ArchivoProyecto
                 echo "Razón: sólo se admite -p1 (Seleccione -h para ver la ayuda)." | sudo tee -a /var/Proyecto/ArchivoProyecto
                 logger -p auth.error -t PROYECTO_IASGL Argumento inválido
                 exit 1
              fi

              OPCION=$(echo $OPTARG | egrep --only-matching 'd$')
              if [ "$OPCION" == "d" ]; then
                 DPROFUNDIDAD=0
              fi ;;
         :)   echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
              echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
              date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
              echo "Proceso abortado." | sudo tee -a /var/Proyecto/ArchivoProyecto
              echo "Razón: debe proveer un argumento a la opción: -p1" | sudo tee -a /var/Proyecto/ArchivoProyecto
              logger -p auth.error -t PROYECTO_IASGL Sintaxis argumentos inválida
              exit 1 ;;
         \?)  echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
              echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
              date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
              echo "Proceso abortado." | sudo tee -a /var/Proyecto/ArchivoProyecto
              echo "Razón: opción inválida -$OPTARG detectada." | sudo tee -a /var/Proyecto/ArchivoProyecto
              logger -p auth.error -t PROYECTO_IASGL Opción inválida
              exit 1 ;;
      esac
   done

if [ $# == 0 ]; then
   echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
   echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
   date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
   echo "Proceso abortado." | sudo tee -a /var/Proyecto/ArchivoProyecto
   echo "Razón: es necesario un directorio (Seleccione -h para ver la ayuda)." | sudo tee -a /var/Proyecto/ArchivoProyecto
   logger -p auth.error -t PROYECTO_IASGL Falta directorio
   exit 1
elif [ $# == 1 ]; then
   TMPDIR=$1

   if [ "$AYUDA" == 1 ]; then
      AYUDA
      exit 0
   elif [ -d "$TMPDIR" ]; then
      if [ "$PORCENTAJE" == 1 ]; then
         if [ "$DPROFUNDIDAD" == 1 ]; then
            PORCENTAJE_RECURSIVO
         else
            PORCENTAJE
         fi         
      else
         if [ "$DPROFUNDIDAD" == 1 ]; then
            RECURSIVO
         else
            NORMAL
         fi
      fi

      exit 0     
   else
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "Proceso abortado." | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "Razón: argumento NO es directorio." | sudo tee -a /var/Proyecto/ArchivoProyecto
      logger -p auth.error -t PROYECTO_IASGL Falta Argumento válido
      exit 1
   fi      
elif [ $# == 2 ]; then
   TMPDIR=$2

elif [ $# == 3 ]; then
   TMPDIR=$3

else
   echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
   echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
   date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
   echo "Proceso abortado." | sudo tee -a /var/Proyecto/ArchivoProyecto
   echo "Razón: cantidad argumentos inválida." | sudo tee -a /var/Proyecto/ArchivoProyecto
   logger -p auth.error -t PROYECTO_IASGL Cantidad argumentos inválida
   exit 1
fi

#Verificación si meten parámetros#
if [ -d "$TMPDIR" ]; then
   if [ "$PORCENTAJE" == 1 -a "$DPROFUNDIDAD" == 0 ]; then
      PORCENTAJE
   elif [ "$PORCENTAJE" == 1 ]; then
      PORCENTAJE_RECURSIVO
   elif [ "$DPROFUNDIDAD" == 0 ]; then
      NORMAL
   else
      echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
      echo "Error." | sudo tee -a /var/Proyecto/ArchivoProyecto
      echo "Razón: error encontrado en archivo de configuración." | sudo tee -a /var/Proyecto/ArchivoProyecto
      logger -p error -t PROYECTO_IASGL Error desconocido
      exit 1
   fi   
else
   echo "" | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
   echo "*********************************************************************"  | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
   date | echo | sudo tee -a /var/Proyecto/ArchivoProyecto 1>/dev/null
   echo "Error." | sudo tee -a /var/Proyecto/ArchivoProyecto
   echo "Razón: argumento NO es directorio." | sudo tee -a /var/Proyecto/ArchivoProyecto
   logger -p error -t PROYECTO_IASGL Falta Argumento válido
   exit 1
fi

exit 0
