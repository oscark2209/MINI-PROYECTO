INSERT INTO clientes VALUES
('CC101','Maria Gomez','maria.gomez@mail.com','3101112233','Calle 10 #5-20','Bogota'),
('CC102','Juan Perez','juan.perez@mail.com','3155558899','Carrera 8 #20-15','Bogota'),
('CC103','Laura Rojas','laura.rojas@mail.com','3209994455','Av 68 #45-30','Medellin');

INSERT INTO vendedores VALUES
('VEN01','Ana Torres','Norte'),
('VEN02','Carlos Ruiz','Centro'),
('VEN03','Diana Mora','Occidente');

INSERT INTO categorias (nombre) VALUES
('Perifericos'),
('Pantallas'),
('Computadores'),
('Accesorios');

INSERT INTO productos VALUES
('P001','Mouse USB',1),
('P002','Teclado mecanico',1),
('P003','Monitor 24',2),
('P004','Portatil 14',3),
('P005','Base refrigerante',4),
('P006','Webcam HD',1);

INSERT INTO ventas VALUES
('V1001','2026-04-01','CC101','VEN01','Transferencia','Bancolombia'),
('V1002','2026-04-02','CC102','VEN02','Tarjeta','Davivienda'),
('V1003','2026-04-03','CC101','VEN01','Transferencia','Bancolombia'),
('V1004','2026-04-04','CC103','VEN03','Efectivo','Caja');

INSERT INTO detalle_venta VALUES
('V1001','P001',2,45000,0),
('V1001','P002',1,180000,0),
('V1002','P003',1,720000,20000),
('V1002','P001',1,45000,0),
('V1003','P004',1,2450000,50000),
('V1003','P002',2,180000,0),
('V1003','P005',1,95000,0),
('V1004','P003',2,720000,0),
('V1004','P006',1,150000,10000);