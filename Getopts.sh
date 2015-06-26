#!/bin/bash

ls /var/Proyecto 1>/dev/null 2>/dev/null
if [ ! $? == 0 ]; then #no existe esa carpeta
   sudo mkdir /var/Proyecto 2>/dev/null
else
   logger -p error -t PROYECTO_IASGL Imposible crear carpeta necesaria
   exit 1
fi

ls /var/Proyecto/ArchivoProyecto 1>/dev/null 2>/dev/null
if [ ! $? == 0 ]; then
   sudo touch /var/Proyecto/ArchivoProyecto 2>/dev/null
else
   logger -p error -t PROYECTO_IASGL Imposible crear archivo necesario
   exit 1
fi

#---------------------------------VERIFICACIONES DEL DIRECTORIO /etc/--------------------------#
ls /etc/variables.sh 1>/dev/null 2>/dev/null
   if [ ! $? == 0 ]; then
      echo "" >> /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************"  >> /var/Proyecto/ArchivoProyecto
      date >> /var/Proyecto/ArchivoProyecto
      echo "Error." | tee -a /var/Proyecto/ArchivoProyecto
      echo "Razón: Su computadora no cumple con los requisitos mínimos para poder ejecutar este comando." | tee -a /var/Proyecto/ArchivoProyecto
      echo "Lo que usted debe hacer es: Copiar el archivo variables.sh que se encuentra en el mismo directorio en el cual se encuentra el archivo que usted esta corriendo, con el siguiente comando: " | tee -a /var/Proyecto/ArchivoProyecto
      echo "sudo cp -r / *Dirección en la cual se encuentra el archivo variables.sh*/ /etc/" | tee -a /var/Proyecto/ArchivoProyecto
      logger -p error -t PROYECTO_IASGL No se encontró el archivo /etc/variables.sh 
      exit 1
   fi
AYUDA=`grep "^AYUDA" /etc/variables.sh | sed 's/AYUDA=\(.*\)/\1/g'` 2>/dev/null
PORCENTAJE=`grep "^PORCENTAJE" /etc/variables.sh | sed 's/PORCENTAJE=\(.*\)/\1/g'`
DPROFUNDIDAD=`grep "^DPROFUNDIDAD" /etc/variables.sh | sed 's/DPROFUNDIDAD=\(.*\)/\1/g'`
TMPDIR=

function AYUDA(){
   echo "*Mostrar sólo ayuda*"
   #---leer archivo de ayuda---
}

function PROCESO(){
   ArchivosReglaresT_A=`find ${TMPDIR} -maxdepth 1 -type f 2>/dev/null`

   if [ ! $? == 0 ]; then
      echo "" >> /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
      date >> /var/Proyecto/ArchivoProyecto
      echo "Error." | tee -a /var/Proyecto/ArchivoProyecto
      echo "Razón: Su computadora no cumple con los requisitos mínimos para poder ejecutar este comando." | tee -a /var/Proyecto/ArchivoProyecto
      echo "No tiene permisos de ingreso a algún directorio, para poder contar sus archivos." | tee -a /var/Proyecto/ArchivoProyecto
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
      echo "" >> /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
      date >> /var/Proyecto/ArchivoProyecto
      echo "Error." | tee -a /var/Proyecto/ArchivoProyecto
      echo "Razón: Su computadora no cumple con los requisitos mínimos para poder ejecutar este comando." | tee -a /var/Proyecto/ArchivoProyecto
      echo "No tiene permisos de ingreso a algún directorio, para poder contar sus archivos." | tee -a /var/Proyecto/ArchivoProyecto
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
      echo "" >> /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
      date >> /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso es: "$TMPDIR | tee -a /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso no contiene archivos regulares." | tee -a /var/Proyecto/ArchivoProyecto
   else
      echo "" >> /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
      date >> /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso es: "$TMPDIR | tee -a /var/Proyecto/ArchivoProyecto
      echo "La cantidad total de archivos regulares es: "${ArchivosReglaresT} | tee -a /var/Proyecto/ArchivoProyecto
      echo "" | tee -a /var/Proyecto/ArchivoProyecto
      echo "IMAGENES: "$sumaImagenes | tee -a /var/Proyecto/ArchivoProyecto
      echo "DOCUMENTOS: "$sumaDocumentos | tee -a /var/Proyecto/ArchivoProyecto
      echo "AUDIO: "$sumaAudio | tee -a /var/Proyecto/ArchivoProyecto
      echo "VIDEO: "$sumaVideo | tee -a /var/Proyecto/ArchivoProyecto
      echo "COMPRIMIDOS: "$sumaComprimidos | tee -a /var/Proyecto/ArchivoProyecto
      echo "EJECUTABLES: "$sumaEjecutables | tee -a /var/Proyecto/ArchivoProyecto
      echo "LIBRERIAS: "$sumaCoFuLibrerias | tee -a /var/Proyecto/ArchivoProyecto
      echo "ARCHIVOS DEL SISTEMA: "$sumaArchSistema | tee -a /var/Proyecto/ArchivoProyecto
      echo "OTROS: "${otros} | tee -a /var/Proyecto/ArchivoProyecto
   fi
}

function PORCENTAJE(){
   PROCESO
   if [ "$suma" == 0 ]; then
      echo "" >> /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
      date >> /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso es: "$TMPDIR | tee -a /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso no contiene archivos regulares." | tee -a /var/Proyecto/ArchivoProyecto
   else
      echo "" >> /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
      date >> /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso es: "$TMPDIR | tee -a /var/Proyecto/ArchivoProyecto
      echo "La cantidad total de archivos regulares es: "${ArchivosReglaresT} | tee -a /var/Proyecto/ArchivoProyecto
      echo "" | tee -a /var/Proyecto/ArchivoProyecto
      echo "IMAGENES: "$((100*$sumaImagenes/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "DOCUMENTOS: "$((100*$sumaDocumentos/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "AUDIO: "$((100*$sumaAudio/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "VIDEO: "$((100*$sumaVideo/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "COMPRIMIDOS: "$((100*$sumaComprimidos/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "EJECUTABLES: "$((100*$sumaEjecutables/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "LIBRERIAS: "$((100*$sumaCoFuLibrerias/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "ARCHIVOS DEL SISTEMA: "$((100*$sumaArchSistema/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "OTROS: "$((100*$otros/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
   fi
}

function RECURSIVO(){
   PROCESO_RECURSIVO
   if [ "$suma" == 0 ]; then
      echo "" >> /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
      date >> /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso es: "$TMPDIR | tee -a /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso no contiene archivos regulares." | tee -a /var/Proyecto/ArchivoProyecto
   else
      echo "" >> /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
      date >> /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso es: "$TMPDIR | tee -a /var/Proyecto/ArchivoProyecto
      echo "La cantidad total de archivos regulares es: "${ArchivosReglaresT} | tee -a /var/Proyecto/ArchivoProyecto
      echo "" | tee -a /var/Proyecto/ArchivoProyecto
      echo "IMAGENES: "$sumaImagenes | tee -a /var/Proyecto/ArchivoProyecto
      echo "DOCUMENTOS: "$sumaDocumentos | tee -a /var/Proyecto/ArchivoProyecto
      echo "AUDIO: "$sumaAudio | tee -a /var/Proyecto/ArchivoProyecto
      echo "VIDEO: "$sumaVideo | tee -a /var/Proyecto/ArchivoProyecto
      echo "COMPRIMIDOS: "$sumaComprimidos | tee -a /var/Proyecto/ArchivoProyecto
      echo "EJECUTABLES: "$sumaEjecutables | tee -a /var/Proyecto/ArchivoProyecto
      echo "LIBRERIAS: "$sumaCoFuLibrerias | tee -a /var/Proyecto/ArchivoProyecto
      echo "ARCHIVOS DEL SISTEMA: "$sumaArchSistema | tee -a /var/Proyecto/ArchivoProyecto
      echo "OTROS: "${otros} | tee -a /var/Proyecto/ArchivoProyecto
   fi
}

function PORCENTAJE_RECURSIVO(){
   PROCESO_RECURSIVO
   if [ "$suma" == 0 ]; then
      echo "" >> /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
      date >> /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso es: "$TMPDIR | tee -a /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso no contiene archivos regulares." | tee -a /var/Proyecto/ArchivoProyecto
   else
      echo "" >> /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
      date >> /var/Proyecto/ArchivoProyecto
      echo "El directorio que usted ingreso es: "$TMPDIR | tee -a /var/Proyecto/ArchivoProyecto
      echo "La cantidad total de archivos regulares es: "${ArchivosReglaresT} | tee -a /var/Proyecto/ArchivoProyecto
      echo "" | tee -a /var/Proyecto/ArchivoProyecto
      echo "IMAGENES: "$((100*$sumaImagenes/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "DOCUMENTOS: "$((100*$sumaDocumentos/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "AUDIO: "$((100*$sumaAudio/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "VIDEO: "$((100*$sumaVideo/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "COMPRIMIDOS: "$((100*$sumaComprimidos/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "EJECUTABLES: "$((100*$sumaEjecutables/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "LIBRERIAS: "$((100*$sumaCoFuLibrerias/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "ARCHIVOS DEL SISTEMA: "$((100*$sumaArchSistema/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
      echo "OTROS: "$((100*$otros/$ArchivosReglaresT))"%" | tee -a /var/Proyecto/ArchivoProyecto
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
                 echo "" >> /var/Proyecto/ArchivoProyecto
                 echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
                 date >> /var/Proyecto/ArchivoProyecto
                 echo "Proceso abortado." | tee -a /var/Proyecto/ArchivoProyecto
                 echo "Razón: opción -h no se puede combinar." | tee -a /var/Proyecto/ArchivoProyecto
                 logger -p auth.error -t PROYECTO_IASGL Combinación inválida
                 exit 1
              fi ;;
         p)   NUMERO=$(echo $OPTARG | egrep --only-matching '^[0-9]+')
              if [ "$NUMERO" == 1 ]; then
                 PORCENTAJE=$NUMERO
              else
                 echo "" >> /var/Proyecto/ArchivoProyecto
                 echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
                 date  >> /var/Proyecto/ArchivoProyecto
                 echo "Proceso abortado." | tee -a /var/Proyecto/ArchivoProyecto
                 echo "Razón: sólo se admite -p1 (Seleccione -h para ver la ayuda)." | tee -a /var/Proyecto/ArchivoProyecto
                 logger -p auth.error -t PROYECTO_IASGL Argumento inválido
                 exit 1
              fi

              OPCION=$(echo $OPTARG | egrep --only-matching 'd$')
              if [ "$OPCION" == "d" ]; then
                 DPROFUNDIDAD=0
              fi ;;
         :)   echo "" >> /var/Proyecto/ArchivoProyecto
              echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
              date >> /var/Proyecto/ArchivoProyecto
              echo "Proceso abortado." | tee -a /var/Proyecto/ArchivoProyecto
              echo "Razón: debe proveer un argumento a la opción: -p1" | tee -a /var/Proyecto/ArchivoProyecto
              logger -p auth.error -t PROYECTO_IASGL Sintaxis argumentos inválida
              exit 1 ;;
         \?)  echo "" >> /var/Proyecto/ArchivoProyecto
              echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
              date >> /var/Proyecto/ArchivoProyecto
              echo "Proceso abortado." | tee -a /var/Proyecto/ArchivoProyecto
              echo "Razón: opción inválida -$OPTARG detectada." | tee -a /var/Proyecto/ArchivoProyecto
              logger -p auth.error -t PROYECTO_IASGL Opción inválida
              exit 1 ;;
      esac
   done

if [ $# == 0 ]; then
   echo "" >> /var/Proyecto/ArchivoProyecto
   echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
   date >> /var/Proyecto/ArchivoProyecto
   echo "Proceso abortado." | tee -a /var/Proyecto/ArchivoProyecto
   echo "Razón: es necesario un directorio (Seleccione -h para ver la ayuda)." | tee -a /var/Proyecto/ArchivoProyecto
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
      echo "" >> /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
      date >> /var/Proyecto/ArchivoProyecto
      echo "Proceso abortado." | tee -a /var/Proyecto/ArchivoProyecto
      echo "Razón: argumento NO es directorio." | tee -a /var/Proyecto/ArchivoProyecto
      logger -p auth.error -t PROYECTO_IASGL Falta Argumento válido
      exit 1
   fi      
elif [ $# == 2 ]; then
   TMPDIR=$2

elif [ $# == 3 ]; then
   TMPDIR=$3

else
   echo "" >> /var/Proyecto/ArchivoProyecto
   echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
   date >> /var/Proyecto/ArchivoProyecto
   echo "Proceso abortado." | tee -a /var/Proyecto/ArchivoProyecto
   echo "Razón: cantidad argumentos inválida." | tee -a /var/Proyecto/ArchivoProyecto
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
      echo "" >> /var/Proyecto/ArchivoProyecto
      echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
      date  >> /var/Proyecto/ArchivoProyecto
      echo "Error." | tee -a /var/Proyecto/ArchivoProyecto
      echo "Razón: error encontrado en archivo de configuración." | tee -a /var/Proyecto/ArchivoProyecto
      logger -p error -t PROYECTO_IASGL Error desconocido
      exit 1
   fi   
else
   echo "" >> /var/Proyecto/ArchivoProyecto
   echo "*********************************************************************" >> /var/Proyecto/ArchivoProyecto
   date >> /var/Proyecto/ArchivoProyecto
   echo "Error." | tee -a /var/Proyecto/ArchivoProyecto
   echo "Razón: argumento NO es directorio." | tee -a /var/Proyecto/ArchivoProyecto
   logger -p error -t PROYECTO_IASGL Falta Argumento válido
   exit 1
fi

exit 0
