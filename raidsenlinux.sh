#!/bin/bash

# Limpiar pantalla
clear

# Mostrar bienvenida
echo "####################################################"
echo "#    Bienvenido al script de configuración RAID   #"
echo "#    Desarrollado por Martín Cantero.             #"
echo "#    Para uso público en GitHub.                  #"
echo "####################################################"
echo ""

# Variables
RAID_DEVICE="/dev/md0"
MOUNT_POINT="/mnt/raid"

# Comprobación de permisos
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, ejecuta este script como root."
  exit 1
fi

# Instalación de herramientas necesarias
echo "Paso 1: Instalando mdadm y herramientas necesarias..."
apt update && apt install -y mdadm rsync initramfs-tools

# Preguntar qué tipo de RAID desea configurar
echo ""
echo "Paso 2: ¿Qué tipo de RAID deseas configurar?"
echo "1) RAID 0 (Striping)"
echo "2) RAID 1 (Mirroring)"
echo "3) RAID 5 (Striping con paridad)"
echo "4) RAID 10 (RAID 1+0)"
read -p "Selecciona una opción (1-4): " RAID_OPTION

# Selección de discos según el tipo de RAID
case $RAID_OPTION in
1)
  echo "Has seleccionado RAID 0."
  DISCOS=(/dev/sdb /dev/sdc)
  RAID_LEVEL=0
  ;;
2)
  echo "Has seleccionado RAID 1."
  DISCOS=(/dev/sdb /dev/sdc)
  RAID_LEVEL=1
  ;;
3)
  echo "Has seleccionado RAID 5."
  DISCOS=(/dev/sdb /dev/sdc /dev/sdd /dev/sde)
  RAID_LEVEL=5
  ;;
4)
  echo "Has seleccionado RAID 10."
  DISCOS=(/dev/sdb /dev/sdc /dev/sdd /dev/sde)
  RAID_LEVEL=10
  ;;
*)
  echo "Opción no válida. Saliendo..."
  exit 1
esac

# Preparación de los discos
echo ""
echo "Paso 3: Preparando discos..."
for DISCO in "${DISCOS[@]}"; do
  echo "Configurando $DISCO..."
  (
    echo n    # Nueva partición
    echo p    # Partición primaria
    echo 1    # Número de partición
    echo      # Primer sector (por defecto)
    echo      # Último sector (por defecto)
    echo t    # Cambiar tipo de partición
    echo fd   # Tipo Linux RAID autodetect
    echo w    # Escribir cambios
  ) | fdisk "$DISCO"
done

# Creación del RAID
echo ""
echo "Paso 4: Creando RAID nivel $RAID_LEVEL con ${#DISCOS[@]} dispositivos..."
mdadm --create --verbose $RAID_DEVICE --level=$RAID_LEVEL --raid-devices=${#DISCOS[@]} "${DISCOS[@]/%/1}"

# Verificación del estado del RAID
echo ""
echo "Paso 5: Verificando el estado del RAID..."
cat /proc/mdstat

# Creación del sistema de archivos y montaje
echo ""
echo "Paso 6: Creando sistema de archivos ext4 en $RAID_DEVICE..."
mkfs.ext4 $RAID_DEVICE

echo "Paso 7: Creando punto de montaje en $MOUNT_POINT..."
mkdir -p $MOUNT_POINT

echo "Paso 8: Montando el RAID en $MOUNT_POINT..."
mount $RAID_DEVICE $MOUNT_POINT

# Configuración permanente del RAID en el sistema
echo ""
echo "Paso 9: Configurando montaje automático al iniciar el sistema..."
mdadm --detail --scan >> /etc/mdadm/mdadm.conf
update-initramfs -u

UUID=$(blkid -s UUID -o value $RAID_DEVICE)
echo "Añadiendo entrada a /etc/fstab..."
echo "UUID=$UUID $MOUNT_POINT ext4 defaults,nofail 0 0" >> /etc/fstab

# Finalización y opción para desmontar el RAID
echo ""
while true; do
    echo "¿Deseas desmontar y eliminar el RAID después de configurarlo?"
    read -p "Respuesta (s/n): " RESPUESTA
    case $RESPUESTA in
        [Ss]* )
            echo "Paso 10: Desmontando y eliminando el RAID..."
            umount $MOUNT_POINT
            mdadm --stop $RAID_DEVICE
            
            for DISCO in "${DISCOS[@]}"; do
                (
                  echo d # Eliminar partición
                  echo w # Guardar cambios
                ) | fdisk "$DISCO"
            done
            
            rm -rf $MOUNT_POINT
            
            echo "El RAID ha sido desmontado y eliminado."
            break;;
        [Nn]* )
            echo "El RAID permanecerá configurado y montado en $MOUNT_POINT."
            break;;
        * )
            echo "Por favor, responde 's' o 'n'."
            ;;
    esac
done

echo ""
echo "Proceso completado. ¡Gracias por usar este script!"
echo "Recuerda que este script está disponible en GitHub para cualquier mejora o colaboración."

