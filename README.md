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

- **Cierre de caja:** efectivo final = efectivo total − sueldos − propinas.

- **Historial intacto:** Precios y sueldos se guardan tal como eran en ese momento, y los productos, empleados y mesas no se borran: Se marcan como inactivos.

## Estructura de la base de datos

| Bloque | Tabla | Descripción |
|---|---|---|
| Catálogos | categorias | Tipos de producto (comidas, vinos, tragos, etc.) |
| Catálogos | productos | Productos del bar con su precio y categoría |
| Catálogos | mesas | Mesas del bar, identificadas por nombre |
| Catálogos | formas_pago | Medios de pago aceptados (efectivo, débito, crédito, QR, transferencia) |
| Personal | empleados | Personal del bar, su puesto y su pago por noche |
| Personal | turnos | Cada noche de trabajo, con fecha y horario |
| Personal | turno_empleados | Quién trabajó en cada turno, cuánto cobró y su deuda anterior |
| Personal | adelantos | Adelantos pedidos durante el turno |
| Personal | consumos_personal | Consumos del personal a mitad de precio |
| Ventas | pedidos | Pedidos de cada mesa, con hora de apertura y cierre |
| Ventas | detalle_pedido | Productos incluidos en cada pedido |
| Caja | pagos | Pagos de cada pedido (pueden ser divididos) |
| Caja | gastos | Salidas de efectivo: proveedores, propina virtual, etc. |
| Caja | propinas | Propinas recibidas en el turno |
| Caja | cierres | Efectivo contado al cierre de cada turno |

## Cómo usarlo

1. Instalar [DB Browser for SQLite](https://sqlitebrowser.org/).
2. Crear una base de datos nueva.
3. En la pestaña "Execute SQL", abrir el archivo `schema.sql` y ejecutarlo.

> Nota: SQLite no verifica las claves foráneas por defecto. Para activarlas, ejecutar `PRAGMA foreign_keys = ON;` al abrir la base.

## Próximos pasos

- Cargar datos de prueba de un turno completo.
- Escribir consultas para calcular sueldos y el cierre de caja.
- Crear una interfaz en Python para cargar pedidos y ver reportes.

## Tecnologías

SQLite · SQL · DB Browser for SQLite · Git