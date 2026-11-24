-- =============================================
-- DATOS DE PRUEBA
-- Carta, mesas y personal del bar + una noche real completa.
-- Los nombres de personas están anonimizados.
-- Uso: ejecutar después de schema.sql
-- =============================================

PRAGMA foreign_keys = ON;
BEGIN TRANSACTION;

-- =============================================
-- Catálogos
-- =============================================

-- categorias
INSERT INTO categorias (id, nombre)
VALUES
       (1, 'Sándwiches'),
       (2, 'Cervezas'),
       (3, 'Panqueques'),
       (4, 'Vinos tintos'),
       (5, 'Gaseosas'),
       (6, 'Tragos'),
       (7, 'Cafetería'),
       (8, 'Vinos blancos'),
       (9, 'Vinos espumantes'),
       (10, 'Empanadas'),
       (11, 'Pizzas'),
       (12, 'Helados');

-- sectores
INSERT INTO sectores (id, nombre, activo)
VALUES
       (1, 'Primera', 1),
       (2, 'Segunda', 1),
       (3, 'Tercera', 1),
       (4, 'Afuera A', 1),
       (5, 'Afuera B', 1),
       (6, 'Pasillo A', 1),
       (7, 'Pasillo B', 1);

-- formas_pago
INSERT INTO formas_pago (id, nombre, es_efectivo)
VALUES
       (1, 'Efectivo', 1),
       (2, 'Debito', 0),
       (3, 'Credito', 0),
       (4, 'QR', 0),
       (5, 'Transferencia', 0);

-- productos
INSERT INTO productos (id, nombre, precio, categoria_id, activo)
VALUES
       (1, 'Empanada criolla', 3600, 10, 1),
       (2, 'Stella Artois 975 cm3', 10100, 2, 1),
       (3, 'Fernet Branca con coca', 8600, 6, 1),
       (4, 'Andes Rubia 1 L', 9400, 2, 1),
       (5, 'Patagonia Amber Lager 730 cm3', 9800, 2, 1),
       (6, 'Lugarcito', 15200, 1, 1),
       (7, 'Mojito Malibu', 10100, 6, 1),
       (8, 'Coca-Cola', 4400, 5, 1),
       (9, 'Jugo de naranja', 6500, 5, 1),
       (10, 'Limonada', 6500, 5, 1),
       (11, 'Panqueque con helado', 11400, 3, 1),
       (12, 'Panqueque de dulce de leche', 10800, 3, 1),
       (13, 'Almendrado', 6800, 12, 1),
       (14, 'Suizo', 6800, 12, 1),
       (15, 'Escocés', 6800, 12, 1),
       (16, 'La Linda Malbec', 19900, 4, 1),
       (17, 'Pizza rúcula (media)', 14400, 11, 1),
       (18, 'Pizza especial (media)', 14200, 11, 1),
       (19, 'Pizza mozzarella (media)', 10900, 11, 1),
       (20, 'Copa de vino Malbec', 8300, 4, 1),
       (21, 'Pizza mozzarella (entera)', 19500, 11, 1),
       (22, 'Pizza napolitana (entera)', 19700, 11, 1),
       (23, 'Pizza fugazzetta (entera)', 19700, 11, 1),
       (24, 'Pizza especial (entera)', 22900, 11, 1),
       (25, 'Pizza rúcula (entera)', 24300, 11, 1),
       (26, 'Pizza cuatro quesos (entera)', 24300, 11, 1),
       (27, 'Pizza roquefort (entera)', 24300, 11, 1),
       (28, 'Pizza napolitana (media)', 11600, 11, 1),
       (29, 'Pizza fugazzetta (media)', 11700, 11, 1),
       (30, 'Pizza cuatro quesos (media)', 14400, 11, 1),
       (31, 'Pizza roquefort (media)', 14400, 11, 1),
       (32, 'Empanada árabe', 3600, 10, 1),
       (33, 'Empanada de pollo', 3600, 10, 1),
       (34, 'Empanada jamón y queso', 3600, 10, 1),
       (35, 'Empanada vegetariana', 3600, 10, 1),
       (36, 'Té', 4500, 7, 1),
       (37, 'Andes Negra 1 L', 9400, 2, 0),
       (38, 'Andes Roja 1 L', 9400, 2, 1),
       (39, 'Andes IPA 1 L', 9400, 2, 1),
       (40, 'Stella Artois 470 cm3', 6500, 2, 1),
       (41, 'Imperial IPA 1 L', 9500, 2, 1),
       (42, 'Imperial IPA 470 cm3', 6200, 2, 1),
       (43, 'Patagonia 24.7 730 cm3', 9800, 2, 1),
       (44, 'Andes IPA lata 500 cm3', 6200, 2, 1),
       (45, 'Andes Roja lata 500 cm3', 6200, 2, 1),
       (46, 'Andes Negra lata 500 cm3', 6200, 2, 1),
       (47, 'Andes Rubia lata 500 cm3', 6200, 2, 1),
       (48, 'Sándwich de jamón crudo', 13800, 1, 1),
       (49, 'Sándwich de jamón crudo completo', 13800, 1, 1),
       (50, 'Café chico', 4500, 7, 0),
       (51, 'Café en jarro', 4500, 7, 0),
       (52, 'Café grande', 4500, 7, 0),
       (53, 'Fernet Branca', 7500, 6, 1),
       (54, 'Fernet Branca Menta', 8600, 6, 1),
       (55, 'Ron Havana Club 3 años', 8200, 6, 1),
       (56, 'Ron Havana Club Añejo Especial', 8200, 6, 1),
       (57, 'Ron Havana Club 7 años', 12200, 6, 1),
       (58, 'Ron Bacardi', 12200, 6, 1),
       (59, 'Cuba libre', 9500, 6, 1),
       (60, 'Mojito cubano', 9800, 6, 1),
       (61, 'Gin tonic Beefeater', 11100, 6, 1),
       (62, 'Gin tonic Tanqueray', 13200, 6, 1),
       (63, 'Gin tonic Bombay', 16500, 6, 1),
       (64, 'Gin tonic Ginebra Llave', 8300, 6, 1),
       (65, 'Tequila José Cuervo', 14800, 6, 1),
       (66, 'Tequila Sunrise', 14900, 6, 1),
       (67, 'Vodka Smirnoff', 8100, 6, 1),
       (68, 'Vodka Smirnoff con naranja', 8700, 6, 1),
       (69, 'Vodka Absolut', 10800, 6, 1),
       (70, 'Vodka Absolut saborizado', 10800, 6, 1),
       (71, 'Whisky Johnnie Walker Red Label', 13000, 6, 1),
       (72, 'Whisky Johnnie Walker Black Label', 17300, 6, 1),
       (73, 'Whisky Jameson', 11900, 6, 1),
       (74, 'Whisky Jack Daniel''s', 16900, 6, 1),
       (75, 'Whisky Jim Beam', 12600, 6, 1),
       (76, 'Gancia batido con limón', 7800, 6, 1),
       (77, 'Martini Rosso', 7500, 6, 1),
       (78, 'Martini Bianco', 7500, 6, 1),
       (79, 'Martini Dry con gin', 8200, 6, 1),
       (80, 'Cinzano Rosso', 6900, 6, 1),
       (81, 'Campari', 8900, 6, 1),
       (82, 'Aperol', 8500, 6, 1),
       (83, 'Aperol Spritz', 9800, 6, 1),
       (84, 'Bailey''s', 10800, 6, 1),
       (85, 'Amarula', 17800, 6, 1),
       (86, 'Tía María', 7900, 6, 1),
       (87, 'Caña Legui', 6900, 6, 1),
       (88, 'Cynar julep', 8700, 6, 1),
       (89, 'Piña colada', 7900, 6, 1),
       (90, 'Coñac Reserva San Juan', 7300, 6, 1),
       (91, 'Negroni', 8400, 6, 1),
       (92, 'D.V. Catena Cabernet-Malbec', 29700, 4, 1),
       (93, 'D.V. Catena Malbec', 38900, 4, 1),
       (94, 'Rutini Colección Cabernet-Malbec', 29500, 4, 1),
       (95, 'Rutini Colección Cabernet Sauvignon', 40500, 4, 1),
       (96, 'Rutini Colección Malbec', 46500, 4, 1),
       (97, 'Luigi Bosca Cabernet Sauvignon', 27900, 4, 1),
       (98, 'Luigi Bosca Malbec', 27900, 4, 1),
       (99, 'Salentein Numina Cabernet Franc', 31300, 4, 1),
       (100, 'Salentein Reserva Pinot Noir', 20900, 4, 1),
       (101, 'Salentein Reserva Cabernet Sauvignon', 20900, 4, 1),
       (102, 'Salentein Reserva Malbec', 20900, 4, 1),
       (103, 'Escorihuela Gascón Roble Cabernet Sauvignon', 21900, 4, 1),
       (104, 'Escorihuela Gascón Roble Malbec', 21900, 4, 1),
       (105, 'Escorihuela Gascón Roble Pinot Noir', 21900, 4, 1),
       (106, 'Familia Gascón', 19600, 4, 1),
       (107, 'Lainé Malbec Selección', 18600, 4, 1),
       (108, 'Santa Julia Chenin dulce', 19600, 8, 1),
       (109, 'Cafayate Torrontés tardío', 17900, 8, 1),
       (110, 'Escorihuela Gascón Sauvignon Blanc', 22800, 8, 1),
       (111, 'Salentein Extra Brut', 23700, 9, 1),
       (112, 'Baron B', 48900, 9, 1),
       (113, 'Chandon Extra Brut 187 cm3', 11600, 9, 1),
       (114, 'Paso de los Toros Pomelo', 4400, 5, 1),
       (115, 'Paso de los Toros Tónica', 4400, 5, 1),
       (116, 'Fanta', 4400, 5, 1),
       (117, 'Sprite', 4400, 5, 1),
       (118, 'Red Bull', 5100, 5, 1),
       (119, 'Speed', 4600, 5, 1),
       (120, 'Agua mineral', 3900, 5, 1),
       (121, 'Pomelada', 6500, 5, 1);

-- mesas
INSERT INTO mesas (id, nombre, activa, sector_id)
VALUES
       (1, 'Ventana', 1, 1),
       (2, 'Puerta', 1, 1),
       (3, '38', 1, 1),
       (4, 'Larga', 1, 1),
       (5, 'Sótano', 1, 1),
       (6, 'Tesla', 1, 1),
       (7, 'Redonda', 1, 1),
       (8, 'Sillón', 1, 1),
       (9, 'Piano', 1, 1),
       (10, 'Zorra', 1, 1),
       (11, 'Perchero', 1, 1),
       (12, 'Abuelitos', 1, 1),
       (13, 'Teclado', 1, 1),
       (14, 'Barra', 1, 1),
       (15, '100', 1, 2),
       (16, '102', 1, 2),
       (17, 'Borracho', 1, 2),
       (18, 'Balazo', 1, 2),
       (19, 'Gotera', 1, 2),
       (20, 'Biblioteca', 1, 2),
       (21, 'Reloj', 1, 2),
       (22, 'VIP', 1, 2),
       (23, 'Criaturita', 1, 2),
       (24, 'Rojo', 1, 3),
       (25, 'Teléfono', 1, 3),
       (26, 'Albert', 1, 3),
       (27, 'Adams', 1, 3),
       (28, 'X', 1, 3),
       (29, 'Inca', 1, 3),
       (30, 'Mano', 1, 3),
       (31, 'Gauchos', 1, 3),
       (32, 'Norte', 1, 4),
       (33, 'Palta', 1, 4),
       (34, 'Rúa', 1, 4),
       (35, 'Alta', 1, 4),
       (36, 'Barril', 1, 4),
       (37, 'Esquina', 1, 4),
       (38, 'Revoque', 1, 4),
       (39, 'Banco', 1, 4),
       (40, 'Poste', 1, 5),
       (41, 'Principito', 1, 5),
       (42, 'Níspero', 1, 5),
       (43, 'Satélite', 1, 5),
       (44, 'Última', 1, 5),
       (45, 'Tensor', 1, 5),
       (46, 'Tatú', 1, 5),
       (47, 'Pasillo I', 1, 6),
       (48, 'Pasillo II', 1, 6),
       (49, 'Viven', 1, 7),
       (50, 'René', 1, 7),
       (51, 'Nicho', 1, 7),
       (52, 'Mafalda', 1, 7);

-- empleados
INSERT INTO empleados (id, nombre, puesto, pago_por_noche, activo)
VALUES
       (1, 'MOZO 1', 'MOZO', 55000, 1),
       (2, 'MOZO 2', 'MOZO', 55000, 1),
       (3, 'MOZO 3', 'MOZO', 55000, 1),
       (4, 'COCINA 1', 'COCINERO', 64000, 1),
       (5, 'COCINA 2', 'AYUDANTE DE COCINA', 55000, 1),
       (6, 'COCINA 3', 'AYUDANTE DE COCINA', 55000, 1),
       (7, 'BARRA 1', 'BARTENDER', 64000, 1),
       (8, 'BARRA 2', 'ENCARGADO', 64000, 1);

-- clientes
INSERT INTO clientes (id, nombre, activo)
VALUES
       (1, 'Cliente frecuente 1', 1),
       (2, 'Cliente frecuente 2', 1);

-- =============================================
-- Noche de prueba: jueves 16/07/2026 (planilla real, nombres anonimizados)
-- =============================================

-- turnos
INSERT INTO turnos (id, fecha, hora_inicio, hora_fin, caja_inicial)
VALUES
       (1, '2026-07-16', '19:00', '03:00', 444680);

-- turno_empleados
INSERT INTO turno_empleados (id, turno_id, empleado_id, pago, saldo_anterior)
VALUES
       (1, 1, 4, 64000, 0),
       (2, 1, 5, 55000, 0),
       (3, 1, 1, 55000, 0),
       (4, 1, 2, 55000, 0),
       (5, 1, 8, 64000, 0);

-- pagos_sueldo
INSERT INTO pagos_sueldo (id, turno_empleados_id, forma_pago_id, monto)
VALUES
       (1, 1, 5, 64000),
       (2, 2, 5, 55000),
       (3, 3, 5, 55000),
       (4, 5, 5, 64000),
       (5, 4, 1, 44800);

-- adelantos
INSERT INTO adelantos (id, turno_empleados_id, monto, hora)
VALUES
       (1, 4, 3000, NULL);

-- consumos_personal
INSERT INTO consumos_personal (id, turno_empleados_id, producto_id, cantidad, precio_cobrado)
VALUES
       (1, 4, 55, 1, 4100),
       (2, 4, 47, 1, 3100);

-- pedidos
INSERT INTO pedidos (id, turno_id, mesa_id, cliente_id, hora, hora_cierre, cerrado, descuento, motivo_descuento)
VALUES
       (1, 1, 8, NULL, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (2, 1, 22, NULL, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (3, 1, 6, NULL, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (4, 1, 5, NULL, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (5, 1, 18, NULL, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (6, 1, NULL, 1, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (7, 1, 47, NULL, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (8, 1, 41, NULL, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (9, 1, 48, NULL, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (10, 1, 25, NULL, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (11, 1, 1, NULL, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (12, 1, 30, NULL, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (13, 1, NULL, 2, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (14, 1, 39, NULL, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (15, 1, 19, NULL, '2026-07-16 19:00:00', NULL, 1, 0, NULL),
       (16, 1, 37, NULL, '2026-07-16 19:00:00', NULL, 1, 0, NULL);

-- detalle_pedido
INSERT INTO detalle_pedido (id, pedido_id, producto_id, cantidad, precio_unitario)
VALUES
       (1, 1, 20, 1, 8300),
       (2, 1, 5, 1, 9800),
       (3, 1, 17, 1, 14400),
       (4, 2, 5, 1, 9800),
       (5, 2, 6, 1, 15200),
       (6, 2, 29, 1, 11700),
       (7, 3, 5, 2, 9800),
       (8, 3, 17, 2, 14400),
       (9, 4, 47, 1, 6200),
       (10, 4, 8, 1, 4400),
       (11, 4, 24, 1, 22900),
       (12, 4, 61, 2, 11100),
       (13, 4, 55, 1, 8200),
       (14, 4, 89, 1, 7900),
       (15, 4, 5, 1, 9800),
       (16, 5, 6, 2, 15200),
       (17, 5, 2, 1, 10100),
       (18, 6, 1, 6, 3600),
       (19, 6, 61, 4, 11100),
       (20, 6, 36, 2, 4500),
       (21, 6, 13, 1, 6800),
       (22, 7, 29, 1, 11700),
       (23, 7, 17, 1, 14400),
       (24, 7, 4, 1, 9400),
       (25, 7, 47, 1, 6200),
       (26, 8, 4, 1, 9400),
       (27, 8, 6, 1, 15200),
       (28, 9, 98, 1, 27900),
       (29, 9, 17, 1, 14400),
       (30, 10, 36, 2, 4500),
       (31, 11, 18, 1, 14200),
       (32, 11, 2, 1, 10100),
       (33, 12, 19, 1, 10900),
       (34, 12, 6, 1, 15200),
       (35, 12, 8, 2, 4400),
       (36, 13, 1, 2, 3600),
       (37, 13, 120, 1, 3900),
       (38, 13, 36, 2, 4500),
       (39, 14, 102, 1, 20900),
       (40, 14, 120, 2, 3900),
       (41, 14, 12, 1, 10800),
       (42, 15, 4, 1, 9400),
       (43, 15, 18, 1, 14200),
       (44, 16, 81, 2, 8900),
       (45, 16, 72, 1, 17300),
       (46, 16, 120, 2, 3900),
       (47, 16, 69, 1, 10800);

-- pagos
INSERT INTO pagos (id, pedido_id, forma_pago_id, monto)
VALUES
       (1, 1, 1, 31500),
       (2, 2, 5, 36700),
       (3, 3, 1, 48400),
       (4, 4, 1, 81600),
       (5, 5, 2, 40500),
       (6, 6, 1, 81800),
       (7, 7, 1, 41700),
       (8, 8, 4, 24600),
       (9, 9, 1, 42300),
       (10, 10, 4, 9000),
       (11, 11, 1, 24300),
       (12, 12, 1, 34900),
       (13, 13, 1, 20100),
       (14, 14, 5, 39500),
       (15, 15, 2, 23600),
       (16, 16, 1, 53700);

-- gastos
INSERT INTO gastos (id, turno_id, tipo, descripcion, monto)
VALUES
       (1, 1, 'Proveedor', 'Bebidas', 300000),
       (2, 1, 'Proveedor', 'Fiambre', 105000),
       (3, 1, 'Redondeo propina', '28.200 entre 5, a 6.000 c/u', 1800);

-- propinas
INSERT INTO propinas (id, turno_id, forma_pago_id, monto)
VALUES
       (1, 1, 1, 28200);

-- cierres
INSERT INTO cierres (id, turno_id, efectivo_total, hora, observaciones)
VALUES
       (1, 1, 450380, '2026-07-17 03:00:00', NULL);

COMMIT;
