  
**PASO 1\. DIAGNOSTICO TABLA CRUDA**

**1 ATRIBUTOS NO ATÓMICO**  
categorias, descuentos, productos nombres, productos códigos, 

**2\. MARCA DATOS REPETIDOS POR CLIENTE, VENDEDOR, PRODUCTO, CATEGORIA Y PAGO.**   
**CLIENTE:**  
cliente doc: (CC101), cliente nombre (Maria Gomez), cliente email (maria.gomez@mail.com ), cliente numero, (3101112233), cliente dirección (Calle 10 \# 5-20 ), cliente ciudad (Bogota)

**VENDEDOR:**  
vendedor id (VEN01), vendedor nombre, (Ana Torres, vendedor zona (Norte)

**PRODUCTO:**   
productos codigo: (P001), (P002), (P003), productos nombres: (Mouse USB),(Teclado mecanico),(Monitor 24),

**CATEGORÍA:**  
categorias (Periféricos),(Pantallas)

**PAGO:**   
metodos de pago: (Transferencia), entidades de pago (Bancolombia)

**3\.EXPLICA AL MENOS TRES ANOMALIAS: INSERCION, ACTUALIZACION Y ELIMINACION.**   
INSERCION:No se puede registrar un cliente, vendedor o producto nuevo sin crear primero una venta, porque toda la información está en una sola tabla.

ACTUALIZACION:Si cambia el correo de María Gómez, hay que actualizar todas las filas donde aparezca,si una fila no se actualiza, queda inconsistencia 

ELIMINACIÓN:Si se elimina la venta V1003  y era la única donde aparecía un producto como P005 , se pierde también la información de ese producto.   
**4\. REDACTA UNA LISTA INICIAL DE DEPENDENCIAS FUNCIONALES.** 

Clientes:  
cliente\_doc → cliente\_nombre, cliente\_email, cliente\_telefono, cliente\_direccion, cliente\_ciudad

Vendedor:  
vendedor id → vendedor nombre, vendedor zona.

Venta:  
venta id → fecha venta, cliente doc, vendedor id, metodo pago, entidad pago

Detalles de venta:  
(venta id, producto código) → cantidad, precio unitario, descuento.

**PASO 2\. APLICACIÓN DE 1FN.**

DROP TABLE IF EXISTS ventas\_1fn;

CREATE TABLE ventas\_1fn (  
venta\_id VARCHAR(10),  
fecha\_venta DATE,  
cliente\_doc VARCHAR(20),  
cliente\_nombre VARCHAR(100),  
cliente\_email VARCHAR(120),  
cliente\_telefono VARCHAR(30),  
cliente\_direccion VARCHAR(150),  
cliente\_ciudad VARCHAR(80),  
vendedor\_id VARCHAR(10),  
vendedor\_nombre VARCHAR(100),  
vendedor\_zona VARCHAR(80),  
producto\_codigo VARCHAR(10),  
producto\_nombre VARCHAR(100),  
categoria VARCHAR(80),  
cantidad INT,  
precio\_unitario NUMERIC(12,2),  
descuento NUMERIC(12,2), 

**EXPLICACION**

1. En este paso se separaron los datos que estaban juntos en una sola celda. Por ejemplo, si una venta tenía dos productos en una fila, ahora cada producto quedó en una fila diferente.  
2. Después de hacer la separación, cada columna quedó con un solo valor por celda. Así ya se cumple la atomicidad.  
3. También se eliminaron los grupos repetidos de productos, cantidades, precios y descuentos, organizando mejor la información.  
4. Se tomó como clave compuesta (venta\_id, producto\_codigo), porque juntos permiten identificar cada registro de manera única.

**PASO 3\. APLICACIÓN DE 2FN.**  
**TABLA CLIENTES**  
CREATE TABLE clientes (  
    cliente\_doc VARCHAR(20) PRIMARY KEY,  
    cliente\_nombre VARCHAR(100),  
    cliente\_email VARCHAR(120),  
    cliente\_telefono VARCHAR(30),  
    cliente\_direccion VARCHAR(150),  
    cliente\_ciudad VARCHAR(80)  
);  
**TABLA VENTAS**  
CREATE TABLE vendedores (  
    vendedor\_id VARCHAR(10) PRIMARY KEY,  
    vendedor\_nombre VARCHAR(100),  
    vendedor\_zona VARCHAR(80)  
);

**TABLA PRODUCTOS**  
CREATE TABLE productos (  
    producto\_codigo VARCHAR(10) PRIMARY KEY,  
    producto\_nombre VARCHAR(100),  
    categoria VARCHAR(80)  
);

**TABLA VENTAS**  
CREATE TABLE ventas (  
    venta\_id VARCHAR(10) PRIMARY KEY,  
    fecha\_venta DATE,  
    cliente\_doc VARCHAR(20),  
    vendedor\_id VARCHAR(10),  
    metodo\_pago VARCHAR(80),  
    entidad\_pago VARCHAR(80),

    FOREIGN KEY (cliente\_doc) REFERENCES clientes(cliente\_doc),  
    FOREIGN KEY (vendedor\_id) REFERENCES vendedores(vendedor\_id)  
);

**TABLA DETALLES VENTA**

CREATE TABLE detalle\_venta (  
    venta\_id VARCHAR(10),  
    producto\_codigo VARCHAR(10),  
    cantidad INT,  
    precio\_unitario NUMERIC(12,2),  
    descuento NUMERIC(12,2),

    PRIMARY KEY (venta\_id, producto\_codigo),

    FOREIGN KEY (venta\_id) REFERENCES ventas(venta\_id),  
    FOREIGN KEY (producto\_codigo) REFERENCES produ**ctos(producto\_codigo)**  
**);**

**EXPLICACION:**

**1\.**En la tabla de 1FN la clave era (venta\_id, producto\_codigo), porque con esos dos datos juntos se podía identificar cada registro.  
Revise si en realidad esta tabla se dependia de estos dos campos al mismo tiempo y asi se dio

**2\.**Al revisar la tabla se vio que algunos datos no dependían de toda la clave, sino solo de una parte:  
\-La fecha de la venta depende solo de venta \_id.  
\-El nombre del producto depende solo de producto código.  
\-Los datos del cliente dependen solo de cliente doc.  
\-Los datos del vendedor dependen solo de vendedor id.

**3\.**   
**CLIENTES**  
se sacaron los datos de los clientes aparte ya que se veia que estaban repitiendo en varias ocaciones  
**VENDEDORES**  
Paso igual con vendedores se separo en una tabla diferente estos datos para no repetir  
**PRODUCTOS**   
Los productos se pasaron a otra tabla para guardar una sola vez su código, nombre y categoría.  
**VENTAS**  
Se creó una tabla de ventas para guardar la información general de cada compra, como fecha, cliente, vendedor y método de pago.

**DETALLE VENTAS**  
Se creó la tabla detalle\_venta para conectar las ventas con los productos y guardar cuánto se compró, el precio y el descuento,Aquí sí se dejó la clave compuesta, porque una venta puede tener varios productos.  
**4\.**  
**1-CLIENTES**  
La clave primaria de clientes es cliente\_doc, porque identifica de manera única a cada cliente.  
**2-VENDEDORES**  
La clave primaria de vendedores es vendedor\_id, ya que cada vendedor tiene un identificador único.  
**3-PRODUCTOS**  
La clave primaria de productos es producto\_codigo, porque cada producto tiene un código único.  
**4-VENTAS**   
La clave primaria de ventas es venta\_id, ya que cada venta debe tener un identificador único.  
cliente\_doc es clave foránea porque conecta la venta con el cliente.  
**5-DETALLES VENTAS**  
La clave primaria es compuesta (venta\_id, producto\_codigo), porque juntos identifican cada detalle de venta.  
venta\_id es clave foránea porque conecta con la tabla ventas.

**PASO 4\. APLICACIÓN DE 3FN.**

**Tabla categorias**

CREATE TABLE categorias (  
    categoria\_id SERIAL PRIMARY KEY,  
    nombre VARCHAR(80) UNIQUE  
);

**Nueva productos**  
CREATE TABLE productos (  
    producto\_codigo VARCHAR(10) PRIMARY KEY,  
    producto\_nombre VARCHAR(100),  
    categoria\_id INT,

    FOREIGN KEY (categoria\_id) REFERENCES categorias(categoria\_id)  
);

**EXPLICACION** 

**1** En este paso revisé si había datos que dependían de otros datos y no directamente de la clave principal,Encontré que la categoría dependía del producto y no de la venta, lo que generaba una dependencia transitiva.  
2  
**Tabla categorias**

CREATE TABLE categorias (  
    categoria\_id SERIAL PRIMARY KEY,  
    nombre VARCHAR(80) UNIQUE

3\. También revisé si era necesario separar ciudades y zonas,En este caso decidí no hacerlo porque solo funcionan como información descriptiva y no como un catálogo independiente,Si el sistema manejara muchas ciudades o zonas, sí sería buena idea separarlas.

4  
cliente\_doc → datos del cliente  
vendedor\_id → datos del vendedor  
producto\_codigo → producto\_nombre, categoria\_id  
venta\_id → fecha\_venta, cliente\_doc, vendedor\_id, metodo\_pago  
venta\_id → fecha\_venta, cliente\_doc, vendedor\_id, metodo\_pago  
(venta\_id, producto\_codigo) → cantidad, precio\_unitario, descuento

**PASO 5.DISEÑO ENTIDAD RELACIÓN.**  
**![][image1]**

## **PASO 6\. IMPLEMENTACIÓN FÍSICA EN POSTGRESQL**

En este paso se creó la base de datos ya normalizada en PostgreSQL usando **`CREATE TABLE`**.

Aquí fue donde pasamos todo lo que hicimos en la normalización a tablas reales.

También se agregaron las restricciones para mantener el orden y evitar errores:

* PRIMARY KEY para identificar cada registro.  
* FOREIGN KEY para conectar unas tablas con otras.  
* NOT NULL para obligar a que ciertos datos no queden vacíos.  
* UNIQUE para evitar datos repetidos.  
* CHECK para validar ciertas reglas.

Se crearon estas tablas:

* clientes  
* vendedores  
* categorias  
* productos  
* ventas  
* detalle\_venta

Después de eso se insertaron los datos ya organizados.

La idea fue no repetir información como:

* clientes  
* vendedores  
* categorías  
* productos

Así la base quedó más limpia, organizada y fácil de manejar.

---

## **PASO 7\. VALIDACIÓN CON CONSULTAS SQL**

En este paso se hicieron consultas para comprobar que todo estuviera funcionando bien.

| CONSULTA  | PARA QUE SIRVE |
| :---- | :---- |
| Reconstruir total de ventas  | Sirve para sacar cuánto costó cada venta sumando los productos vendidos.  |
| Productos más vendidos  | Sirve para ver cuáles productos se vendieron más.  |
| Ventas por vendedor  | Sirve para saber cuantas ventas hizo cada vendedor y cuanto vendió |
| Historial de compras por cliente  | Sirve para revisar qué ha comprado un cliente.  |
| Registros huérfanos  | Sirve para verificar que no existan detalles de ventas sin producto o venta asociada.  |

Con estas consultas se confirmó que:

* La base quedó bien organizada.  
* Las relaciones entre tablas funcionan.  
* No hay datos sueltos o dañados.  
* Todo quedó bien conectado.

**7\. PLANTILLA ANALISIS DEPENDENCIAS FUNCIONALES.**

| DEPENDENCIA FUNCIONAL | TIPO | ACCION DE NORMALIZACION |
| :---- | :---- | :---- |
| cliente\_doc → cliente\_nombre, cliente\_email, cliente\_telefono, cliente\_direccion  | Dependencia parcial  | Se creó la tabla **clientes** para guardar la información del cliente una sola vez y evitar duplicados en las ventas.  |
| vendedor\_id → vendedor\_nombre, vendedor\_zona  | Dependencia parcial  | Se creó la tabla **vendedores** para almacenar la información de cada vendedor de forma independiente.  |
| producto\_codigo → producto\_nombre, categoria  | Dependencia total  | porque esos atributos dependen directamente de la venta.  |
| venta\_id \+ producto\_codigo → cantidad, precio\_unitario, descuento  | Dependencia total (clave compuesta)  | Se creó la tabla **detalle\_venta** para registrar los detalles específicos de cada producto dentro de una venta.  |
| venta\_id → fecha\_venta, cliente\_doc, vendedor\_id, metodo\_pago  | Dependencia total  | Se creó la tabla **ventas** porque esos atributos dependen directamente de la venta.  |

[image1]: <data:image/png;base64,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>