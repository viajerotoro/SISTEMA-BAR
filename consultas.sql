-- =============================================
-- CONSULTAS DEL SISTEMA DEL BAR
-- Ejecutar de a una: seleccionar la consulta y Ctrl + Enter
-- =============================================


-- 1. Total cobrado por cada forma de pago
--    (escrita por Ramiro)
SELECT formas_pago.nombre AS forma, SUM(pagos.monto) AS total
FROM pagos
INNER JOIN formas_pago ON pagos.forma_pago_id = formas_pago.id
GROUP BY formas_pago.nombre;


-- 2. Top 5 de productos más vendidos
--    Igual a la 1, pero suma cantidades y ordena de mayor a menor
SELECT productos.nombre AS producto, SUM(detalle_pedido.cantidad) AS unidades
FROM detalle_pedido
INNER JOIN productos ON detalle_pedido.producto_id = productos.id
GROUP BY productos.nombre
ORDER BY unidades DESC
LIMIT 5;


-- 3. Ventas por categoría
--    Dos JOIN seguidos: detalle -> productos -> categorias
SELECT categorias.nombre AS categoria,
       SUM(detalle_pedido.cantidad * detalle_pedido.precio_unitario) AS vendido
FROM detalle_pedido
INNER JOIN productos  ON detalle_pedido.producto_id = productos.id
INNER JOIN categorias ON productos.categoria_id = categorias.id
GROUP BY categorias.nombre
ORDER BY vendido DESC;


-- 4. Pedidos que pagaron distinto de lo que consumieron
--    Compara lo consumido (detalle) con lo pagado (pagos).
--    LEFT JOIN: muestra la mesa o el cliente, según cuál tenga el pedido.
--    COALESCE: devuelve el primer valor que no sea NULL.
SELECT pedidos.id,
       COALESCE(mesas.nombre, clientes.nombre) AS mesa_o_cliente,
       (SELECT SUM(cantidad * precio_unitario) FROM detalle_pedido
        WHERE detalle_pedido.pedido_id = pedidos.id) - pedidos.descuento AS deberia_pagar,
       (SELECT SUM(monto) FROM pagos
        WHERE pagos.pedido_id = pedidos.id) AS pago
FROM pedidos
LEFT JOIN mesas    ON pedidos.mesa_id = mesas.id
LEFT JOIN clientes ON pedidos.cliente_id = clientes.id
WHERE deberia_pagar <> pago;


-- 5. Cierre de caja de cada noche
--    Efectivo esperado = caja inicial + cobros en efectivo - gastos
--                        - sueldos en efectivo - adelantos
--    Diferencia = efectivo contado - efectivo esperado (0 = cierra perfecto)
SELECT turnos.fecha,
       turnos.caja_inicial
       + (SELECT COALESCE(SUM(pagos.monto), 0) FROM pagos
          INNER JOIN pedidos ON pagos.pedido_id = pedidos.id
          WHERE pedidos.turno_id = turnos.id AND pagos.forma_pago_id = 1)
       - (SELECT COALESCE(SUM(gastos.monto), 0) FROM gastos
          WHERE gastos.turno_id = turnos.id)
       - (SELECT COALESCE(SUM(pagos_sueldo.monto), 0) FROM pagos_sueldo
          INNER JOIN turno_empleados ON pagos_sueldo.turno_empleados_id = turno_empleados.id
          WHERE turno_empleados.turno_id = turnos.id AND pagos_sueldo.forma_pago_id = 1)
       - (SELECT COALESCE(SUM(adelantos.monto), 0) FROM adelantos
          INNER JOIN turno_empleados ON adelantos.turno_empleados_id = turno_empleados.id
          WHERE turno_empleados.turno_id = turnos.id) AS efectivo_esperado,
       cierres.efectivo_total AS efectivo_contado
FROM turnos
INNER JOIN cierres ON cierres.turno_id = turnos.id;
