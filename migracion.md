## Bitácora de Migración de OJS2 a OJS3 de la revista Tecciencia

- Descargamos los XML en versión OJS2 (v2) de la página original (users/issues).
  - Están en el Drive de la revista como (p.ej.) issue_15.xml (v2)
- Creamos un servidor virtual con OJS2 con XAMPP.
- Subimos los XML v2 al OJS2 virtual.
- Actualizamos el OJS2 a OJS3 en el servidor virtual (puede tardar entre 15 minutos y una hora).
- Descargamos los XML en versión OJS3 v3 del servidor virtual (users/issues) - nombre: ojs3.
- Creamos otro servidor virtual con una instalación directa de OJS3 (en este caso fue con LAPP, pero no es importante) - nombre: ojs3new
- Subimos el XML de users al nuevo servidor virtual, miramos los errores y usamos sed en bash para corregirlos.
- Subimos el XML de cada issue al nuevo servidor virtual, miramos los errores comunes y usamos sed en bash para corregirlos.
  - Mirar archivos inst_tecciencia y xml_proc en este repositorio, modificar según la necesidad.
  - Error de XML, usar bash para eliminar campos que aparecen en errores para cada issue.
  - Error de "The content is not encoded as base64", ir a ojs3, crear copia de issue, en la copia eliminar archivos superfluos (ver notas), intentar subirlos otra vez y arreglar el XML según los errores que aparezcan. Se puede usar el mismo comando en bash luego de esto
  - Los XML v3 corregidos (v3c) están en el Drive de la revista como (p.ej.) 11_p.xml, los crudos (v3) se llaman 11.xml y si han sido modificados por errores "base64" entonces se llaman 11_c.xml. 
- Al subir todos los XML v3c ya queda lista la migración.

### Nombres de servidores virtuales

- ojs3 servidor virtual actualizado de OJS2 a OJS3 en /opt/lampp (XAMPP), archivos en files_other (ver config.inc.php)
- ojs3new servidor virtual no. 2 (de prueba para verificar compatibilidad) en /opt/lampp (XAMPP)
- ojs-3 servidor virtual de prueba en /home/lappstack (LAPP)
- Otros detalles de instalación en cuaderno CCC

### Notas

- No teníamos acceso como administradores al OJS2 original, por lo que no podíamos hacer la actualización desde ahí.
- OJS2 funciona con PHP5, por lo cual el XAMPP para el servidor virtual debe cumplir ese requisito.
- LAPP viene por defecto con PHP7, por lo que no se puede hacer la actualización OJS2 a OJS3.
- Para que funcione LAPP o XAMPP hay que poner en terminal:
  - sudo service mysql stop (lo mismo con postgresql)
  - sudo ./manager_linux... en donde esté LAPP o XAMPP
- Para comenzar la instalación de OJS https://pkp.sfu.ca/ojs/README
  - Hacer chmod 755 a los directorios en la instalacion:
      - config.inc.php (optional -- if not writable you will be prompted to manually overwrite this file during installation)
	    - public
	    - cache
- Hacer chmod 777 a files_others en ojs3new para exportar
- Al instalar sea XAMPP o LAPP, hay que cambiar en php.ini memory_limit, post_max_size y upload_max_filesize
- Se pueden descargar varios issues a la vez, pero el archivo pesa más de 200M
- Los XML v3 no son directamente compatibles con OJS3, por eso hay que modificarlos en bash
- En principio aplicar xml_proc directamente debería arreglar los XML de los issues, pero algunos requirieron más procesamiento (18-23).
- No es posible modificar titulos y descripciones de issues en la nueva plataforma, hay que hacer las modificaciones en el servidor virtual ojs3.
- Es posible migrar los archivos del servidor virtual (usando XAMPP) a otro servidor virtual: htdocs/ojs3, ojs.sql (descargar de phppgadmin y subir al nuevo servidor), files_other/, config.inc.php. Mirar permisos.

### Problemas especificos de issues

- 18: sed 's#disciplin\>#discipline#g' 18_p.xml > 18_p2.xml
- 19: Eliminar archivos ancillares en ojs3 (de una copia del issue) en el que no eran pdf ni html (correcciones, etc.)
- 20: Modificar descripción en ojs3
- 21-23: Modificar nombre en ojs3
- Edición especial no fue migrada, aunque el XML v3c está en el Drive

