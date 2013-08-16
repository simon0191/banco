
Banco
=====

http://simon0191-banco.herokuapp.com/
##Descripción


Aplicación que simula el funcionamiento de un banco. 

Las entidades que se manejan son: Cliente, Cuenta y Movimiento. 
Un Cliente puede tener varias cuentas y cada cuenta puede tener varios movimientos. Un cliente tiene: nombre, dirección y teléfono. Una cuenta tiene: número y saldo. 
Un movimiento tiene: tipo (si es débito o crédito; los débitos aumentan y los créditos reducen el saldo), fecha y valor.

##Funcionalidades


Para acceder al sistema, el usuario debe autenticarse por medio de la página de _login_ [/login](http://simon0191-banco.herokuapp.com/banco/login). Para probar la aplicación existen 3 usuarios con diferentes roles:
```
+---------+------------+------------+
| Usuario | Contraseña |    Rol     |
+---------+------------+------------+
| admin   | admin      | ROLE_ADMIN |
| user1   | user1      | ROLE_USER  |
| user2   | user2      | ROLE_USER  |
+---------+------------+------------+
```

Una vez autenticado, el usuario tendrá la posibilidad de llevar a cabo las siguientes acciones dependiendo de su rol. Generalmente, el usuario con rol _ROLE\_ADMIN_, podrá crear crear, editar, actualizar y eliminar objetos(Cliente, Cuenta y Movimiento) de otros usuarios, mientras que los usuarios con rol _ROLE\_USER_ únicamente podrán crear, editar, actualizar y eliminar objetos que les pertenezcan.

1.	Creación, modificación, consulta y eliminación de Clientes y Cuentas.
	- [/cuentas](http://simon0191-banco.herokuapp.com/cuentas)
	- [/cuentas?form](http://simon0191-banco.herokuapp.com/cuentas?form)
	- [/clientes](http://simon0191-banco.herokuapp.com/clientes)
	- [/clientes?form](http://simon0191-banco.herokuapp.com/clientes?form)
        
        
2.	Registrar movimientos en una cuenta validando que no se permitan registrar movimientos que dejen un saldo negativo en la cuenta.
	- [/movimientoes?form](http://simon0191-banco.herokuapp.com/movimientoes?form)
    
3.	Generar un reporte que, especificando un rango de fechas y un cliente, visualice las cuentas asociadas con sus respectivos saldos y el total de débitos y créditos realizados durante las fechas.
	- [/movimientoes?find=ByFechaBetween&form](http://simon0191-banco.herokuapp.com/movimientoes?find=ByFechaBetween&form)
        
##Herramientas y tecnologías utilizadas

- Spring 3.0
- ROO 1.2.4
- Postgres 9.3
- Eclipse - Spring Tool Suite 3.3


##Instrucciones de despliegue

1. Crear la base de datos utilizando el _script_ [squema.sql](https://raw.github.com/simon0191/banco/master/src/main/resources/sql/squema.sql) o ejecutar la aplicación y poblar la base de datos utilizando el _script_ [init.sql](https://raw.github.com/simon0191/banco/master/src/main/resources/sql/init.sql)
2. Importar el proyecto a Eclipse - Spring Tool Suite como "_Exisiting Maven Project_"
2. Agregar la variable de entorno _$DATABASE\_URL_ con la siguiente estructura:
```
postgres://{usuario}:{contraseña}@{host}:{puerto}/{base de datos}
```
Por ejemplo:
Sistema operativo *Nix:
```
export postgres://simon:mi_password@localhost:5432/banco_db
```
Sistema operativo Windows:
```
set postgres://simon:mi_password@localhost:5432/banco_db
```
Eclipse:

	```
	1. Click derecho sobre el proyecto
	2. Run As>Run configurations
	3. Pesataña "Environment">New
	4. Name: DATABASE_URL
	5. Value: postgres://simon:mi_password@localhost:5432/banco_db
	```
3. Ejecutar el proyecto

```
1. Click derecho sobre el proyecto
2. Run As>Run on server
```



##Otros

 
1.   [Código fuente de la aplicación](https://github.com/simon0191/banco/archive/master.zip)
2.   Archivos para despliegue: 
	- [WAR](https://docs.google.com/file/d/0B0Z4F6M8dm4Ma051VDBFNVRuS2s/edit?usp=sharing)
	- [Script para creación de base de datos](https://raw.github.com/simon0191/banco/master/src/main/resources/sql/init.sql)

        
3.   Diagrama Entidad Relación de la base de datos.

 ```


       +---------------------+        +----------------------+     +------------------------+
       |  Cliente            |        |  Cuenta              |     |  Movimiento            |
       |---------------------|        |----------------------|     |------------------------|
       | bigint id           |        | bigint id            |     | bigint id              |
       | varchar direccion   |        | varchar numero       +----<| timestamp fecha        |
       | varchar nombre      |-------<| numeric saldo        |     | integer tipo           |
       | varchar password    |        +----------------------+     |                        |
       | varchar telefono    |        | FOREIGN_KEYS         |     +------------------------+
       | varchar usuario     |        |----------------------|     | FOREIGN_KEYS           |
       +---------------------+        | bigint cliente       |     |------------------------|
                                      |                      |     | bigint cuenta          |
                                      +----------------------+     |                        |
                                                                   +------------------------+
 ```



