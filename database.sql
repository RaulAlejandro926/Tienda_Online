-- Base de Datos Tienda Multimarca
CREATE DATABASE IF NOT EXISTS tienda_online;
USE tienda_online;

-- Tablas Relacionales
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE marcas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    categoria_id INT,
    marca_id INT,
    imagen VARCHAR(255),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id),
    FOREIGN KEY (marca_id) REFERENCES marcas(id)
);

CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    direccion_envio TEXT NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Registros de Categorías
INSERT INTO categorias (id, nombre) VALUES 
(1, 'Ropa'), (2, 'Cosméticos'), (3, 'Calzado'), (4, 'Celulares');

-- Registros de Marcas
INSERT INTO marcas (id, nombre, categoria_id) VALUES 
(1, 'Zara', 1), (2, 'Levi\'s', 1), (3, 'L\'Oréal', 2), (4, 'Maybelline', 2),
(5, 'MAC', 2), (6, 'Nike', 3), (7, 'Adidas', 3), (8, 'Puma', 3),
(9, 'Apple', 4), (10, 'Samsung', 4);

-- Registros de Productos (10 Mínimo por Categoría)
INSERT INTO productos (nombre, precio, stock, categoria_id, marca_id, imagen) VALUES 
-- ROPA (Categoría 1)
('Camisa Oxford Slim', 49.99, 20, 1, 1, 'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?w=300'),
('Jeans 501 Original', 79.99, 35, 1, 2, 'https://images.unsplash.com/photo-1542272604-780c36856d67?w=300'),
('Chaqueta de Cuero Bikers', 119.99, 15, 1, 1, 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=300'),
('Sudadera Hooded Casual', 59.90, 40, 1, 1, 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?w=300'),
('Pantalón Chino Beige', 45.00, 25, 1, 2, 'https://images.unsplash.com/photo-1473966968600-fa801b869a1a?w=300'),
('Chaqueta Mezclilla Trucker', 89.50, 18, 1, 2, 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=300'),
('Vestido Elegante de Noche', 99.99, 12, 1, 1, 'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=300'),
('Abrigo de Lana Invierno', 149.00, 10, 1, 1, 'https://images.unsplash.com/photo-1544441893-675973e31985?w=300'),
('Playera Básica Algodón', 19.99, 50, 1, 2, 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=300'),
('Suéter Tejido Cuello Alto', 64.99, 22, 1, 1, 'https://images.unsplash.com/photo-1620799140408-edc6dcb6d633?w=300'),

-- COSMÉTICOS (Categoría 2)
('Labial Color Riche Matte', 18.50, 50, 2, 3, 'https://images.unsplash.com/photo-1586495777744-4413f21062fa?w=300'),
('Base Liquid SuperStay 24H', 24.99, 40, 2, 4, 'https://images.unsplash.com/photo-1631729371254-42c2892f0e6e?w=300'),
('Máscara Lash Sensational', 14.90, 60, 2, 4, 'https://images.unsplash.com/photo-1560700146-eb71864b2808?w=300'),
('Paleta Sombras Studio Fix', 45.00, 20, 2, 5, 'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?w=300'),
('Sérum Facial Ácido Hialurónico', 32.00, 30, 2, 3, 'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300'),
('Rubor Compacto Fit Me', 12.99, 45, 2, 4, 'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=300'),
('Delineador Infaillible Gel', 16.50, 35, 2, 3, 'https://images.unsplash.com/photo-1597225244660-1cd128c64284?w=300'),
('Iluminador Extra Dimension', 38.00, 15, 2, 5, 'https://images.unsplash.com/photo-1599733589046-10c005739ef9?w=300'),
('Corrector Camouflage High Coverage', 15.99, 40, 2, 4, 'https://images.unsplash.com/photo-1616683693504-3ea7e9ad6fec?w=300'),
('Crema Anti-Edad Revitalift', 29.99, 28, 2, 3, 'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=300'),

-- CALZADO (Categoría 3)
('Zapatillas Ultraboost Light', 160.00, 25, 3, 7, 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=300'),
('Tenis Air Max 270', 140.00, 30, 3, 6, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300'),
('Tenis Suede Classic', 85.00, 35, 3, 8, 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=300'),
('Tenis Jordan Retro 1', 180.00, 12, 3, 6, 'https://images.unsplash.com/photo-1552346154-21d32810aba3?w=300'),
('Tenis Stan Smith Vintage', 95.00, 40, 3, 7, 'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=300'),
('Botas Chelsea de Cuero', 110.00, 18, 3, 6, 'https://images.unsplash.com/photo-1638247025967-b4e38f787b76?w=300'),
('Tenis RS-X Efekt', 115.00, 20, 3, 8, 'https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=300'),
('Zapatillas Metcon 8', 130.00, 22, 3, 6, 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=300'),
('Tenis NMD R1 Primeblue', 145.00, 15, 3, 7, 'https://images.unsplash.com/photo-1515955656352-a1fa3ffcd111?w=300'),
('Sandalias Clog Futuro', 49.99, 50, 3, 8, 'https://images.unsplash.com/photo-1603808033192-082d6919d3e1?w=300'),

-- CELULARES (Categoría 4)
('iPhone 15 Pro Max 256GB', 1199.00, 15, 4, 9, 'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=300'),
('Galaxy S24 Ultra 512GB', 1299.00, 12, 4, 10, 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=300'),
('iPhone 14 128GB Midnight', 699.00, 25, 4, 9, 'https://images.unsplash.com/photo-1663499482523-1c0c1bae4ce1?w=300'),
('Galaxy A54 5G 256GB', 449.00, 40, 4, 10, 'https://images.unsplash.com/photo-1565849904461-04a58ad377e0?w=300'),
('iPhone 13 128GB Starlight', 599.00, 30, 4, 9, 'https://images.unsplash.com/photo-1632661674596-df8be070a5c5?w=300'),
('Galaxy Z Flip 5 256GB', 999.00, 10, 4, 10, 'https://images.unsplash.com/photo-1580910051074-3eb694886505?w=300'),
('iPhone 15 128GB Pink', 799.00, 20, 4, 9, 'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=300'),
('Galaxy S23 FE 128GB', 599.00, 18, 4, 10, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300'),
('iPhone SE 3ra Gen 64GB', 429.00, 35, 4, 9, 'https://images.unsplash.com/photo-1567581935884-3349723552ca?w=300'),
('Galaxy Z Fold 5 512GB', 1799.00, 8, 4, 10, 'https://images.unsplash.com/photo-1546054454-aa26e2b734c7?w=300');