CREATE TABLE categorias (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE
	
);

CREATE TABLE productos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    precio REAL NOT NULL,
    categoria_id INTEGER NOT NULL,
    activo INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
	
);

CREATE TABLE empleados (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	puesto TEXT NOT NULL,
	pago_por_noche INTEGER NOT NULL,
	activo INTEGER NOT NULL DEFAULT 1
	
);

CREATE TABLE turnos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	fecha TEXT NOT NULL,
	hora_inicio TEXT NOT NULL,
	hora_fin TEXT
	
);

CREATE TABLE turno_empleados (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	turno_id INTEGER NOT NULL,
	empleado_id INTEGER NOT NULL,
	pago  INTEGER NOT NULL,
	saldo_anterior INTEGER NOT NULL DEFAULT 0,
	FOREIGN KEY (turno_id) REFERENCES turnos(id),
	FOREIGN KEY (empleado_id) REFERENCES empleados(id),
	UNIQUE (turno_id, empleado_id)
	
);

CREATE TABLE adelantos(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	turno_empleados_id INTEGER NOT NULL,
	monto INTEGER NOT NULL,
	hora TEXT,
	FOREIGN KEY (turno_empleados_id) REFERENCES turno_empleados(id)
	
);

CREATE TABLE consumos_personal(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	turno_empleados_id INTEGER NOT NULL,
	producto_id INTEGER NOT NULL,
	cantidad INTEGER NOT NULL DEFAULT 1,
	precio_cobrado  INTEGER NOT NULL,
	FOREIGN KEY (turno_empleados_id) REFERENCES turno_empleados(id),
	FOREIGN KEY (producto_id) REFERENCES productos(id)
	
);

CREATE TABLE mesas(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL UNIQUE,
	activa INTEGER NOT NULL DEFAULT 1
	
);

CREATE TABLE pedidos(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	turno_id INTEGER NOT NULL,
	mesa_id INTEGER NOT NULL,
	hora TEXT NOT NULL DEFAULT (datetime('now', 'localtime')),
    hora_cierre TEXT,
	cerrado INTEGER NOT NULL DEFAULT 0,
	FOREIGN KEY (turno_id) REFERENCES turnos(id),
	FOREIGN KEY (mesa_id) REFERENCES mesas(id)
	
);

CREATE TABLE detalle_pedido(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	pedido_id INTEGER NOT NULL,
	producto_id INTEGER NOT NULL,
	cantidad INTEGER NOT NULL DEFAULT 1,
	precio_unitario INTEGER NOT NULL,
	FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
	FOREIGN KEY (producto_id) REFERENCES productos(id)
	
);

CREATE TABLE formas_pago(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL UNIQUE,
	es_efectivo INTEGER NOT NULL DEFAULT 0

); 

CREATE TABLE pagos(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	pedido_id INTEGER NOT NULL,
	forma_pago_id INTEGER NOT NULL,
	monto INTEGER NOT NULL,
	FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
	FOREIGN KEY (forma_pago_id) REFERENCES formas_pago(id)

);

CREATE TABLE gastos(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	turno_id INTEGER NOT NULL,
	tipo TEXT NOT NULL,
	descripcion TEXT NOT NULL,
	monto INTEGER NOT NULL,
	FOREIGN KEY (turno_id) REFERENCES turnos(id)
	
);


CREATE TABLE propinas(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	turno_id INTEGER NOT NULL,
	forma_pago_id INTEGER NOT NULL,
	monto INTEGER NOT NULL,
	FOREIGN KEY (turno_id) REFERENCES turnos(id),
	FOREIGN KEY (forma_pago_id)	REFERENCES formas_pago(id)
	
);

CREATE TABLE cierres(
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	turno_id INTEGER NOT NULL UNIQUE,
	efectivo_total INTEGER NOT NULL,
	hora TEXT NOT NULL DEFAULT (datetime('now', 'localtime')),
	observaciones TEXT,
	FOREIGN KEY (turno_id) REFERENCES turnos(id)
	
);
