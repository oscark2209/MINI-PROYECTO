SELECT venta_id,
       SUM((cantidad * precio_unitario) - descuento) AS total_calculado
FROM detalle_venta
GROUP BY venta_id;

SELECT p.producto_codigo,
       p.producto_nombre,
       SUM(d.cantidad) AS unidades_vendidas
FROM detalle_venta d
JOIN productos p
ON d.producto_codigo = p.producto_codigo
GROUP BY p.producto_codigo, p.producto_nombre
ORDER BY unidades_vendidas DESC;

SELECT vd.vendedor_id,
       vd.vendedor_nombre,
       COUNT(v.venta_id) AS cantidad_ventas,
       SUM((d.cantidad * d.precio_unitario) - d.descuento) AS valor_total
FROM vendedores vd
JOIN ventas v
ON vd.vendedor_id = v.vendedor_id
JOIN detalle_venta d
ON v.venta_id = d.venta_id
GROUP BY vd.vendedor_id, vd.vendedor_nombre;

SELECT c.cliente_doc,
       c.cliente_nombre,
       v.venta_id,
       v.fecha_venta,
       p.producto_nombre,
       d.cantidad
FROM clientes c
JOIN ventas v
ON c.cliente_doc = v.cliente_doc
JOIN detalle_venta d
ON v.venta_id = d.venta_id
JOIN productos p
ON d.producto_codigo = p.producto_codigo
WHERE c.cliente_doc = 'CC101';