import sqlite3

# 1. Conectarse a la base
conexion = sqlite3.connect('bar.db')
conexion.execute('PRAGMA foreign_keys = ON')

# 2. Guardar la consulta en una variable (comillas triples = texto de varias líneas)
consulta = """
SELECT formas_pago.nombre AS forma, sum(pagos.monto) AS total
FROM pagos
INNER JOIN formas_pago ON pagos.forma_pago_id = formas_pago.id
GROUP BY formas_pago.nombre;"""

# 3. Ejecutarla y traer los resultados

resultados = conexion.execute(consulta).fetchall()

# 4. Mostrarlos

for forma, total in resultados:
    print(f"{forma}: {total}")

# 5. cerrar la conexión

conexion.close()