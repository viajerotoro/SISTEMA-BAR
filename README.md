# Sistema de gestión de bar

Es una base de datos para la gestión de un bar, actualmente lo hice para que registre las ventas, los consumos del personal, los adelantos de personal, los pagos a los proveedores y cierre de caja.

## El problema

Lo hice para el bar donde trabajo actualmente como encargado, donde todo se registra con papel y lapicera. De ese modo siempre saltan errores, ya sean faltantes o sobrantes. Espero que ayude a bajar un poco el estrés de trabajar en una caja.

## Reglas de negocio

- **Pagos divididos:** Una mesa puede pagar con varios medios a la vez, pueden usar (Crédito, Débito, QR, Transferencia o efectivo). Por eso cada parte se registra por separado.

- **Consumos del personal:** Lo que consume el personal por separado a lo ofrecido "El menú", se les cobra a mitad de precio y se lo descuenta del pago de turno.

- **Adelantos:** El personal puede pedir un adelanto durante la noche lo cual se le descuenta al final de la jornada.

- **Deudas entre turnos:** Si los consumos y los adelantos superan el sueldo queda como deuda para su próximo turno.

- **Propina virtual:** Las propinas pagadas con tarjetas, QR o Transferencias se entregan al personal en efectivo, por lo que se registra como salida de caja.

- **Turnos nocturnos:** Los turnos cruzan la medianoche, por eso los pedidos guardan fecha y hora completas.

- **Sueldos:** Se pueden pagar en efectivo, por transferencia o mitad y mitad. Solo la parte en efectivo sale de la caja.

- **Clientes frecuentes:** Algunos clientes se mueven por todo el bar y no tienen una mesa fija, por eso un pedido puede ser de una mesa o de un cliente.

- **Descuentos:** Cuando un empleado va como cliente paga la mitad, y a veces se le hace un gesto a un cliente si pasó algo con su pedido. El descuento se registra con su motivo, para diferenciarlo de un error de cobro.

- **Redondeo de propina:** La propina compartida se redondea para que todos cobren lo mismo; la diferencia sale de la caja y se registra como gasto.

- **Cierre de caja:** efectivo esperado = caja inicial + cobros en efectivo − gastos − sueldos en efectivo − adelantos. Se compara con el efectivo contado.

- **Historial intacto:** Precios y sueldos se guardan tal como eran en ese momento, y los productos, empleados y mesas no se borran: Se marcan como inactivos.

## Estructura de la base de datos

| Bloque | Tabla | Descripción |
|---|---|---|
| Catálogos | categorias | Tipos de producto (comidas, vinos, tragos, etc.) |
| Catálogos | productos | Productos del bar con su precio y categoría |
| Catálogos | sectores | Sectores del bar (Primera, Segunda, Pasillo, Afuera...) para repartir las mesas entre los mozos |
| Catálogos | mesas | Mesas del bar, identificadas por nombre, con su sector |
| Catálogos | clientes | Clientes frecuentes que no tienen mesa fija |
| Catálogos | formas_pago | Medios de pago aceptados (efectivo, débito, crédito, QR, transferencia) |
| Personal | empleados | Personal del bar, su puesto y su pago por noche |
| Personal | turnos | Cada noche de trabajo, con fecha, horario y caja inicial |
| Personal | turno_empleados | Quién trabajó en cada turno, cuánto cobró y su deuda anterior |
| Personal | adelantos | Adelantos pedidos durante el turno |
| Personal | consumos_personal | Consumos del personal a mitad de precio |
| Personal | pagos_sueldo | Cómo se pagó cada sueldo (efectivo, transferencia o ambos) |
| Ventas | pedidos | Pedidos de una mesa o de un cliente, con hora y descuento (regla `CHECK`: mesa o cliente obligatorio) |
| Ventas | detalle_pedido | Productos incluidos en cada pedido |
| Caja | pagos | Pagos de cada pedido (pueden ser divididos) |
| Caja | gastos | Salidas de efectivo: proveedores, propina virtual, etc. |
| Caja | propinas | Propinas recibidas en el turno |
| Caja | cierres | Efectivo contado al cierre de cada turno |

## Cómo usarlo

1. Instalar [DB Browser for SQLite](https://sqlitebrowser.org/).
2. Crear una base de datos nueva.
3. En la pestaña "Execute SQL", abrir y ejecutar los archivos en este orden:

| Archivo | Qué hace |
|---|---|
| `schema.sql` | Crea las 18 tablas |
| `datos_prueba.sql` | Carga la carta, las mesas, el personal y una noche real completa (nombres anonimizados) |
| `consultas.sql` | Consultas de ejemplo: cobros por forma de pago, productos más vendidos, ventas por categoría, pedidos con diferencias y cierre de caja |

> Nota: SQLite no verifica las claves foráneas por defecto. Para activarlas, ejecutar `PRAGMA foreign_keys = ON;` al abrir la base.

## Prueba con una noche real

Cargué la planilla en papel de una noche real del bar (jueves 16/07/2026: 16 pedidos y 5 empleados) y comparé el cierre del sistema con el de la planilla.

En papel, la caja daba una diferencia de **$31.200** que no se sabía de dónde salía. Al pasar todo al sistema aparecieron las causas, que en la planilla no estaban escritas en ningún lado:

| Causa | Efecto en la diferencia |
|---|---|
| Comida comprada con plata del encargado, anotada como si hubiera salido de la caja | +$33.000 |
| Redondeo de la propina compartida (28.200 entre 5, a 6.000 cada uno), que salió de la caja sin anotarse | −$1.800 |
| **Total** | **$31.200** |

Además, la consulta 4 detecta sola una mesa que pagó $1.000 menos de lo que consumió, algo que en papel no se ve.

Resultado del cierre con SQL (consulta 5):

| Efectivo esperado | Efectivo contado | Diferencia |
|---|---|---|
| $450.380 | $450.380 | **$0** |

## Próximos pasos

- Crear una aplicación web con Python (Flask) para cargar pedidos y ver reportes desde el celular.
- Que funcione sin internet y resista cortes de luz (base local, backups y transacciones).
- Registrar el reparto de sectores entre los mozos de cada noche.
- Registrar el historial cuando una cuenta se cambia de mesa.

## Tecnologías

SQLite · SQL · DB Browser for SQLite · Git · GitHub