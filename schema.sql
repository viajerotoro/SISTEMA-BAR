-- Estructura de la base de datos del bar (SQLite)
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS categorias (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS "sectores" (
	"id"	INTEGER,
	"nombre"	TEXT NOT NULL UNIQUE,
	"activo"	INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS formas_pago(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL UNIQUE,
	es_efectivo INTEGER NOT NULL DEFAULT 0

);
CREATE TABLE IF NOT EXISTS "productos" (
	"id"	INTEGER,
	"nombre"	TEXT NOT NULL,
	"precio"	REAL NOT NULL,
	"categoria_id"	INTEGER NOT NULL,
	"activo"	INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("categoria_id") REFERENCES "categorias"("id")
);
CREATE TABLE IF NOT EXISTS "mesas" (
	"id"	INTEGER,
	"nombre"	TEXT NOT NULL UNIQUE,
	"activa"	INTEGER NOT NULL DEFAULT 1,
	"sector_id"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("sector_id") REFERENCES "sectores"("id")
);
CREATE TABLE IF NOT EXISTS empleados (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	puesto TEXT NOT NULL,
	pago_por_noche INTEGER NOT NULL,
	activo INTEGER NOT NULL DEFAULT 1
);
CREATE TABLE IF NOT EXISTS clientes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    activo INTEGER NOT NULL DEFAULT 1
);
CREATE TABLE IF NOT EXISTS turnos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	fecha TEXT NOT NULL,
	hora_inicio TEXT NOT NULL,
	hora_fin TEXT
, caja_inicial INTEGER NOT NULL DEFAULT 0);
CREATE TABLE IF NOT EXISTS turno_empleados (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	turno_id INTEGER NOT NULL,
	empleado_id INTEGER NOT NULL,
	pago  INTEGER NOT NULL,
	saldo_anterior INTEGER NOT NULL DEFAULT 0,
	FOREIGN KEY (turno_id) REFERENCES turnos(id),
	FOREIGN KEY (empleado_id) REFERENCES empleados(id),
	UNIQUE (turno_id, empleado_id)
	
);
CREATE TABLE IF NOT EXISTS pagos_sueldo (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    turno_empleados_id INTEGER NOT NULL,
    forma_pago_id INTEGER NOT NULL,
    monto INTEGER NOT NULL,
    FOREIGN KEY (turno_empleados_id) REFERENCES turno_empleados(id),
    FOREIGN KEY (forma_pago_id) REFERENCES formas_pago(id)
);
CREATE TABLE IF NOT EXISTS adelantos(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	turno_empleados_id INTEGER NOT NULL,
	monto INTEGER NOT NULL,
	hora TEXT,
	FOREIGN KEY (turno_empleados_id) REFERENCES turno_empleados(id)
	
);
CREATE TABLE IF NOT EXISTS consumos_personal(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	turno_empleados_id INTEGER NOT NULL,
	producto_id INTEGER NOT NULL,
	cantidad INTEGER NOT NULL DEFAULT 1,
	precio_cobrado  INTEGER NOT NULL,
	FOREIGN KEY (turno_empleados_id) REFERENCES turno_empleados(id),
	FOREIGN KEY (producto_id) REFERENCES productos(id)
	
);
CREATE TABLE IF NOT EXISTS pedidos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    turno_id INTEGER NOT NULL,
    mesa_id INTEGER,
    cliente_id INTEGER,
    hora TEXT NOT NULL DEFAULT (datetime('now', 'localtime')),
    hora_cierre TEXT,
    cerrado INTEGER NOT NULL DEFAULT 0, descuento INTEGER NOT NULL DEFAULT 0, motivo_descuento TEXT,
    CHECK (mesa_id IS NOT NULL OR cliente_id IS NOT NULL),
    FOREIGN KEY (turno_id) REFERENCES turnos(id),
    FOREIGN KEY (mesa_id) REFERENCES mesas(id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);
CREATE TABLE IF NOT EXISTS detalle_pedido(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	pedido_id INTEGER NOT NULL,
	producto_id INTEGER NOT NULL,
	cantidad INTEGER NOT NULL DEFAULT 1,
	precio_unitario INTEGER NOT NULL,
	FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
	FOREIGN KEY (producto_id) REFERENCES productos(id)
	
);
CREATE TABLE IF NOT EXISTS pagos(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	pedido_id INTEGER NOT NULL,
	forma_pago_id INTEGER NOT NULL,
	monto INTEGER NOT NULL,
	FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
	FOREIGN KEY (forma_pago_id) REFERENCES formas_pago(id)

);
CREATE TABLE IF NOT EXISTS gastos(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	turno_id INTEGER NOT NULL,
	tipo TEXT NOT NULL,
	descripcion TEXT NOT NULL,
	monto INTEGER NOT NULL,
	FOREIGN KEY (turno_id) REFERENCES turnos(id)
	
);
CREATE TABLE IF NOT EXISTS propinas(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	turno_id INTEGER NOT NULL,
	forma_pago_id INTEGER NOT NULL,
	monto INTEGER NOT NULL,
	FOREIGN KEY (turno_id) REFERENCES turnos(id),
	FOREIGN KEY (forma_pago_id)	REFERENCES formas_pago(id)
	
);
CREATE TABLE IF NOT EXISTS cierres(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	turno_id INTEGER NOT NULL UNIQUE,
	efectivo_total INTEGER NOT NULL,
	hora TEXT NOT NULL DEFAULT (datetime('now', 'localtime')),
	observaciones TEXT,
	FOREIGN KEY (turno_id) REFERENCES turnos(id)
	
);
COMMIT;
