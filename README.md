# Script Autobackup:

### script_backup.sh
____

Pasos de Configuración:
1. Crear clave ssh entre el server de produccion y el de backup.
2. Configurar los valores de coneccion dentro del archivo.
3. Crear la automatizacion en el crontab con el comando
``crontab -e`` y agregar la linea:

``30 20 * * * /ruta_al_script/script_backup.sh``

Donde los primeros 5 parametros son el intervalo de tiempo de ejecucion.
En este caso se ejecuta siempre a las 20:30 horas.


