# 🚀 **Configuración de RAID con Bash** 🖥️

Bienvenido al **script de configuración RAID** creado por **Martín Cantero**. Este script facilita la creación y gestión de sistemas RAID en Linux con una interfaz sencilla y amigable. Puedes usarlo para configurar RAID 0, RAID 1, RAID 5 y RAID 10 de manera automatizada.

---

## ✨ **Características** 🌟

- 🔧 **Soporte para varios niveles de RAID**: RAID 0, RAID 1, RAID 5 y RAID 10.
- 🖥️ **Instalación automática de herramientas necesarias**: `mdadm`, `rsync`, `initramfs-tools`.
- 📝 **Asistencia paso a paso**: Ve lo que está sucediendo en cada momento con mensajes claros.
- 🔄 **Interactividad**: Decide si deseas desmontar y eliminar el RAID después de la configuración.
- 💻 **Fácil de usar**: Solo ejecuta el script y sigue las instrucciones.

---

## 🚀 **Requisitos** 🛠️

- 🐧 **Sistema operativo Linux** (Se recomienda Debian/Ubuntu).
- 🔑 **Permisos de root** para ejecutar el script.
- 💾 **Discos adicionales** para la configuración del RAID.

---

## 📚 **¿Cómo usarlo?** 🤔

1. **Clonar el repositorio**:

   Si quieres usar el script o contribuir, clónalo desde GitHub:

   ```bash
   git clone https://github.com/martiincantero/raidsenlinux.git
   cd raidsenlinux
   ```

2. **Dar permisos de ejecución**:

   Asegúrate de darle permisos de ejecución al script:

   ```bash
   chmod +x raidsenlinux.sh
   ```

3. **Ejecutar el script**:

   Ejecuta el script con permisos de root:

   ```bash
   sudo ./raidsenlinux.sh
   ```

   El script te guiará paso a paso en todo el proceso. Solo sigue las instrucciones en pantalla.

---

## 🛠️ **Pasos que realiza el script** 🔍

1. **Instalación de herramientas necesarias** 🧰: Instala `mdadm`, `rsync`, y `initramfs-tools`.
2. **Selecciona el tipo de RAID** 📊: Elige entre RAID 0, RAID 1, RAID 5 o RAID 10.
3. **Prepara los discos** 💾: Configura las particiones de los discos seleccionados.
4. **Crea el RAID** 💥: Crea el RAID con los discos seleccionados.
5. **Crea el sistema de archivos** 📝: Formatea el RAID con `ext4` y lo monta.
6. **Configuración persistente** 🔄: Asegura que el RAID se monte automáticamente al iniciar el sistema.
7. **Desmontaje y eliminación opcional** ❌: Puedes optar por desmontar y eliminar el RAID después de configurarlo.

---

## 🤝 **Contribuir** 💡

¡Contribuir es muy fácil! Si deseas ayudar a mejorar el script o añadir nuevas funcionalidades, sigue estos pasos:

1. Haz un **fork** del repositorio.
2. Crea una **pull request** con tus mejoras.

**¡Tu ayuda es bienvenida!** 👏

---

## 📜 **Licencia** 🖋️

Este proyecto está licenciado bajo la **MIT License**. Consulta el archivo [LICENSE](./LICENSE) para más detalles.

¡Gracias por usar este script! 🙌


