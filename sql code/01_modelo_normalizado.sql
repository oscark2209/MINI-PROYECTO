DROP TABLE IF EXISTS detalle_venta;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS vendedores;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    cliente_doc VARCHAR(20) PRIMARY KEY,
    cliente_nombre VARCHAR(100),
    cliente_email VARCHAR(120),
    cliente_telefono VARCHAR(30),
    cliente_direccion VARCHAR(150),
    cliente_ciudad VARCHAR(80)
);

CREATE TABLE vendedores (
    vendedor_id VARCHAR(10) PRIMARY KEY,
    vendedor_nombre VARCHAR(100),
    vendedor_zona VARCHAR(80)
);

CREATE TABLE categorias (
    categoria_id SERIAL PRIMARY KEY,
    nombre VARCHAR(80)
);

CREATE TABLE productos (
    producto_codigo VARCHAR(10) PRIMARY KEY,
    producto_nombre VARCHAR(100),
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
);

CREATE TABLE ventas (
    venta_id VARCHAR(10) PRIMARY KEY,
    fecha_venta DATE,
    cliente_doc VARCHAR(20),
    vendedor_id VARCHAR(10),
    metodo_pago VARCHAR(80),
    entidad_pago VARCHAR(80),

    FOREIGN KEY (cliente_doc) REFERENCES clientes(cliente_doc),
    FOREIGN KEY (vendedor_id) REFERENCES vendedores(vendedor_id)
);

CREATE TABLE detalle_venta (
    venta_id VARCHAR(10),
    producto_codigo VARCHAR(10),
    cantidad INT,
    precio_unitario NUMERIC(12,2),
    descuento NUMERIC(12,2),

    PRIMARY KEY (venta_id, producto_codigo),

    FOREIGN KEY (venta_id) REFERENCES ventas(venta_id),
    FOREIGN KEY (producto_codigo) REFERENCES productos(producto_codigo)
);