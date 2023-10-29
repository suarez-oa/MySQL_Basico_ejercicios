-- 1 Ejercicios. Realización de consultas SQL
DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  id_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- 1.1.3 Consultas sobre una tabla
-- 1 Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre
FROM producto;

-- 2 Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio
FROM producto;

-- 3 Lista todas las columnas de la tabla producto.
SELECT *
FROM producto;

-- 4 Lista el nombre de los productos y precio , el precio en euros (los que no tienen centavos ) 
-- y el precio en dólares estadounidenses (USD - los que contienen centavos).
SELECT nombre, precio AS USD
FROM producto
WHERE precio LIKE '%.%';

SELECT nombre, precio AS €_EUROS
FROM producto
WHERE precio NOT LIKE '%.%';

-- 5 Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). 
-- Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.
SELECT nombre AS nombre_de_producto, precio AS euros 
FROM producto
WHERE precio NOT LIKE '%.%';

SELECT nombre AS nombre_de_producto, precio AS dólares 
FROM producto
WHERE precio LIKE '%.%';

-- 6 Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.
SELECT upper(nombre) AS nombre, precio
FROM producto;

-- 7 Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.
SELECT lower(nombre) AS nombre, precio 
FROM producto ;

-- 8 Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas 
-- los dos primeros caracteres del nombre del fabricante.
SELECT nombre AS NombreFabricante, UPPER(LEFT(nombre, 2)) AS DosPrimerosCaracteresEnMayusculas 
FROM fabricante; 

-- 9 Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT nombre, round(precio) AS precio_redondeado
FROM producto;

-- 10 Lista los nombres y los precios de todos los productos de la tabla producto, 
-- truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
SELECT nombre, TRUNCATE(precio, 0) AS PrecioTruncado
FROM producto;

-- 11 Lista el identificador de los fabricantes que tienen productos en la tabla producto.
SELECT f.id
FROM fabricante f
INNER JOIN producto p ON f.id = p.id_fabricante;

-- 12 Lista el identificador de los fabricantes que tienen productos en la tabla producto, 
-- eliminando los identificadores que aparecen repetidos.
SELECT DISTINCT f.id
FROM fabricante f
INNER JOIN producto p ON f.id = p.id_fabricante;

-- 13 Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre
FROM fabricante 
ORDER BY nombre ASC;

-- 14 Lista los nombres de los fabricantes ordenados de forma descendente.
SELECT nombre 
FROM fabricante 
ORDER BY nombre DESC;

-- 15 Lista los nombres de los productos ordenados en primer lugar por el 
-- nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre, precio
FROM producto
ORDER BY nombre ASC, precio DESC;

-- 16 Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT *
FROM fabricante 
LIMIT 5;

-- 17 Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla 
-- fabricante. La cuarta fila también se debe incluir en la respuesta.
SELECT *
FROM fabricante
LIMIT 3 OFFSET 3;

-- 18 Lista el nombre y el precio del producto más barato. 
-- (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio
FROM producto
ORDER BY precio ASC
LIMIT 1;

-- 19 Lista el nombre y el precio del producto más caro. 
-- (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio
FROM producto
ORDER BY precio DESC
LIMIT 1;

-- 20 Lista el nombre de todos los productos del fabricante cuyo identificador 
-- de fabricante es igual a 2.
SELECT nombre, id_fabricante
FROM producto
WHERE id_fabricante = 2;

-- 21 Lista el nombre de los productos que tienen un precio menor o igual a 120€.
SELECT nombre, precio
FROM producto
WHERE precio <= 120;

-- 22 Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
SELECT nombre, precio
FROM producto
WHERE precio >= 400;

-- 23 Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
SELECT nombre, precio
FROM producto
WHERE precio < 400;

-- 24 Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
SELECT nombre, precio
FROM producto 
WHERE precio >= 80 AND  precio <= 300;

-- 25 Lista todos los productos que tengan un precio entre 60€ y 200€. 
-- Utilizando el operador BETWEEN.
SELECT nombre, precio
FROM producto
WHERE precio BETWEEN 60 AND 200;

-- 26 Lista todos los productos que tengan un precio mayor que 200€ y que 
-- el identificador de fabricante sea igual a 6.
SELECT nombre, precio, id_fabricante
FROM producto
WHERE precio > 200 AND id_fabricante = 6;

-- 27 Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. 
-- Sin utilizar el operador IN.
SELECT *
FROM producto
WHERE id_fabricante = 1 OR id_fabricante = 3 OR id_fabricante = 5;

-- 28 Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. 
-- Utilizando el operador IN.
SELECT *
FROM producto
WHERE id_fabricante IN (1,3,5);

-- 29 Lista el nombre y el precio de los productos en céntimos 
-- (Habrá que multiplicar por 100 el valor del precio). 
-- Cree un alias para la columna que contiene el precio que se llame céntimos.
SELECT nombre, precio * 100 AS centimos
FROM producto;

-- 30 Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
SELECT nombre
FROM fabricante
WHERE nombre LIKE 'S%';

-- 31 Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
SELECT nombre 
FROM fabricante
WHERE nombre LIKE '%e';

-- 32 Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
SELECT nombre
FROM fabricante 
WHERE nombre LIKE '%w%';

-- 34 Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
SELECT nombre
FROM fabricante
WHERE length(nombre) = 4;

-- 35 Devuelve una lista con el nombre de todos los productos que contienen la cadena 
-- Portátil en el nombre.
SELECT nombre 
FROM producto
WHERE nombre LIKE '%Portatil%';

-- 36 Devuelve una lista con el nombre de todos los productos que contienen 
-- la cadena Monitor en el nombre y tienen un precio inferior a 215 €.
SELECT nombre, precio
FROM producto 
WHERE nombre LIKE '%Monitor%' AND precio < 215;

-- 37 Lista el nombre y el precio de todos los productos que tengan un 
-- precio mayor o igual a 180€. Ordene el resultado en primer lugar 
-- por el precio (en orden descendente) y en segundo lugar por el nombre 
-- (en orden ascendente).
SELECT nombre, precio
FROM producto
WHERE precio >= 180 
ORDER BY precio DESC, nombre ASC; 



-- 1.1.4 Consultas multitabla (Composición interna)
-- Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.

-- 1 Devuelve una lista con el nombre del producto, precio y nombre de fabricante de 
-- todos los productos de la base de datos.
SELECT p.nombre, p.precio, f.nombre
FROM producto p, fabricante f
WHERE f.id = p.id_fabricante;

-- 2 Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos 
-- los productos de la base de datos. Ordene el resultado por el nombre del fabricante, 
-- por orden alfabético.
SELECT p.nombre, p.precio, f.nombre
FROM producto p, fabricante f 
WHERE f.id = p.id_fabricante
ORDER BY f.nombre ASC;

-- 3 Devuelve una lista con el identificador del producto, nombre del producto, 
-- identificador del fabricante y nombre del fabricante, de todos 
-- los productos de la base de datos.
SELECT p.id, p.nombre, p.id_fabricante, f.nombre
FROM producto p, fabricante f
WHERE f.id = p.id_fabricante;

-- 4 Devuelve el nombre del producto, su precio y el nombre de su fabricante, 
-- del producto más barato.
SELECT p.nombre, p.precio, f.nombre
FROM producto p, fabricante f
WHERE f.id = p.id_fabricante 
ORDER BY p.precio ASC 
LIMIT 1;

-- 5 Devuelve el nombre del producto, su precio y el nombre de su fabricante, 
-- del producto más caro.
SELECT p.nombre, p.precio, f.nombre
FROM producto p, fabricante f
WHERE f.id = p.id_fabricante 
ORDER BY p.precio DESC 
LIMIT 1;

-- 6 Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT p.*, f.nombre
FROM producto p, fabricante f
WHERE f.id = p.id_fabricante AND  f.nombre LIKE '%lenovo%';

-- 7 Devuelve una lista de todos los productos del fabricante Crucial 
-- que tengan un precio mayor que 200.
SELECT p.*, f.nombre
FROM producto p, fabricante f
WHERE f.id = p.id_fabricante AND  f.nombre LIKE '%Crucial%' AND p.precio >200;

-- 8 Devuelve un listado con el nombre y el precio de todos los productos de los 
-- fabricantes cuyo nombre termine por la vocal e.
SELECT p.nombre, p.precio, f.nombre
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre LIKE '%e';

-- 9 Devuelve un listado con el nombre y el precio de todos los productos cuyo 
-- nombre de fabricante contenga el carácter w en su nombre.
SELECT p.nombre, p.precio, f.nombre
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre LIKE '%w%';

-- 10 Devuelve un listado con el nombre de producto, precio y nombre de fabricante, 
-- de todos los productos que tengan un precio mayor o igual a 180. 
-- Ordene el resultado en primer lugar por el precio (en orden descendente) 
-- y en segundo lugar por el nombre del fabricante (en orden ascendente)
SELECT p.nombre, p.precio, f.nombre
FROM producto p 
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE p.precio >= 180
ORDER BY  p.precio DESC, f.nombre  ASC;