Banco
=====

Aplicación que simula el funcionamiento de un banco.


Las entidades que se manejan son: Cliente, Cuenta y Movimiento. 
Un Cliente puede tener varias cuentas y cada cuenta puede tener varios movimientos. Un cliente tiene: nombre, dirección y teléfono. Una cuenta tiene: número y saldo. 
Un movimiento tiene: tipo (si es débito o crédito; los débitos aumentan y los créditos reducen el saldo), fecha y valor.

El sistema permite:
-	La creación, modificación, consulta y eliminación de Clientes y Cuentas.
		/cuentas
		/cuentas?form
		/clientes
		/clientes?form
-	Registrar movimientos en una cuenta validando que no se permitan registrar movimientos que dejen un saldo negativo en la cuenta.
		/movimientoes?form
-	Generar un reporte que, especificando un rango de fechas y un cliente, visualice las cuentas asociadas con sus respectivos saldos y el total de débitos y créditos realizados durante las fechas.
		/movimientoes?find=ByFechaBetween&form

 
 
1.   Código fuente de la aplicación.
2.   Paquete para despliegue: WAR, script para creación de base de datos e instrucciones con los demás adicionales necesarios para el despliegue (es muy importante que se especifiquen las versiones de las herramientas requeridas para el despliegue).
3.   Diagrama Entidad Relación de la base de datos.
4.   Manual de usuario de la aplicación.
