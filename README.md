# Instrucciones para ejecutar los scripts

## 1. Crear el contenedor en Docker

Primero se debe levantar PostgreSQL con Docker:

```bash
docker run --name postgres_normalizacion -e POSTGRES_PASSWORD=123456 -e POSTGRES_DB=ventas_db -p 5432:5432 -d postgres
```

Con esto se crea el contenedor y la base de datos.

---

## 2. Conectarse a PostgreSQL

Después se abre pgAdmin o cualquier cliente PostgreSQL y se conecta con:

* **Host:** localhost
* **Puerto:** 5432
* **Base de datos:** ventas_db
* **Usuario:** postgres
* **Contraseña:** 123456

---

## 3. Ejecutar el modelo

Se ejecuta primero:

```sql
01_modelo.sql
```

Este script crea todas las tablas y define claves primarias y foráneas.

---

## 4. Insertar los datos

Luego se ejecuta:

```sql
02_datos.sql
```

Este script inserta los datos ya normalizados.

---

## 5. Ejecutar las consultas

Por último:

```sql
03_consultas.sql
```

Este script valida que todo esté funcionando correctamente.

---

# Decisiones principales

Durante el desarrollo se tomaron estas decisiones:

* Separar clientes, vendedores, productos y categorías para evitar duplicados.
* Crear la tabla `detalle_venta` para relacionar ventas con productos.
* Usar claves primarias para identificar registros.
* Usar claves foráneas para conectar las tablas.
* Separar categorías de productos para eliminar dependencias transitivas.
* Mantener la base de datos en **3FN**.

Con esto la base quedó más organizada, limpia y fácil de consultar.
