CREATE TABLE `clientes` (
`id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
`nombres` varchar(50) NOT NULL,
`apellidos` varchar(50) NOT NULL,
`telefono` varchar(15) NULL,
`direccion` varchar(120) NULL,
PRIMARY KEY (`id`) 
)
ENGINE = InnoDB;
CREATE TABLE `formaPago` (
`id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
`tipoVenta` varchar(20) NOT NULL,
PRIMARY KEY (`id`) 
)
ENGINE = InnoDB;
CREATE TABLE `usuarios` (
`id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
`nombreUsuario` varchar(50) NOT NULL,
`password` varchar(50) NOT NULL,
`permiso` varchar(50) NOT NULL,
PRIMARY KEY (`id`) 
)
ENGINE = InnoDB;
CREATE TABLE `categorias` (
`id` smallint UNSIGNED NOT NULL AUTO_INCREMENT,
`nombre` varchar(50) NOT NULL,
`descripcion` varchar(120) NULL,
PRIMARY KEY (`id`) 
)
ENGINE = InnoDB;
CREATE TABLE `laboratorios` (
`id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
`nombre` varchar(50) NOT NULL,
`descripcion` varchar(255) NULL,
PRIMARY KEY (`id`) 
)
ENGINE = InnoDB;
CREATE TABLE `productos` (
`id` mediumint UNSIGNED NOT NULL AUTO_INCREMENT,
`codigoBarra` varchar(20) NULL,
`nombre` varchar(50) NOT NULL,
`precioCompra` decimal(11,2) UNSIGNED NOT NULL,
`precioVenta` decimal(11,2) UNSIGNED NOT NULL,
`fechaVencimiento` date NOT NULL,
`stock` decimal(10,2) UNSIGNED NOT NULL,
`categoria` smallint UNSIGNED NULL,
`laboratorio` mediumint UNSIGNED NULL,
`ubicacion` varchar(120) NULL,
`descripcion` varchar(120) NULL,
PRIMARY KEY (`id`) 
)
ENGINE = InnoDB;
CREATE TABLE `facturas` (
`id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
`credito` int UNSIGNED NULL,
`nombre_comprador` varchar(50) NULL,
`fecha` date NULL,
`tipoVenta` smallint UNSIGNED NULL,
`impuestoISV` decimal(11,2) UNSIGNED NULL,
`totalFactura` decimal(11,2) UNSIGNED NULL,
PRIMARY KEY (`id`) 
)
ENGINE = InnoDB;
CREATE TABLE `detalleFactura` (
`id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
`factura` bigint UNSIGNED NULL,
`producto` mediumint UNSIGNED NULL,
`precioProducto` decimal(11,2) NULL,
`cantidadProducto` decimal(11,2) UNSIGNED NULL,
`totalVenta` decimal(11,2) UNSIGNED NULL,
PRIMARY KEY (`id`) 
)
ENGINE = InnoDB;
CREATE TABLE `gastos` (
`id` int UNSIGNED NOT NULL AUTO_INCREMENT,
`monto` decimal(11,2) UNSIGNED NULL,
`fecha` date NULL,
`descripcion` varchar(255) NULL,
PRIMARY KEY (`id`) 
);
CREATE TABLE `creditos` (
`id` int UNSIGNED NOT NULL AUTO_INCREMENT,
`cliente` mediumint UNSIGNED NULL,
`estado` varchar(100) NULL,
`fecha` date NULL,
PRIMARY KEY (`id`) 
);
CREATE TABLE `pagosCreditos` (
`id` int UNSIGNED NOT NULL AUTO_INCREMENT,
`credito` int UNSIGNED NULL,
`monto` decimal(11,2) UNSIGNED NULL,
`fecha` date NULL,
PRIMARY KEY (`id`) 
);

ALTER TABLE `facturas` ADD FOREIGN KEY (`credito`) REFERENCES `creditos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `facturas` ADD FOREIGN KEY (`tipoVenta`) REFERENCES `formaPago` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `creditos` ADD FOREIGN KEY (`cliente`) REFERENCES `clientes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `productos` ADD FOREIGN KEY (`categoria`) REFERENCES `categorias` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `productos` ADD FOREIGN KEY (`laboratorio`) REFERENCES `laboratorios` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `pagosCreditos` ADD FOREIGN KEY (`credito`) REFERENCES `creditos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `detalleFactura` ADD FOREIGN KEY (`factura`) REFERENCES `facturas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `detalleFactura` ADD FOREIGN KEY (`producto`) REFERENCES `productos` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;


insert into formapago values(null,'Efectivo');
insert into usuarios values(null, 'cesar','4957','Administrador');

DELIMITER //
CREATE PROCEDURE agregarProductoStock(IN idP INT, IN cantidadIngresar FLOAT)
BEGIN
  UPDATE productos SET stock = stock + cantidadIngresar WHERE id = idP;
END //

DELIMITER //
CREATE PROCEDURE venderProductoStock(IN idP INT, IN cantidadVender FLOAT)
BEGIN
  UPDATE productos SET stock = stock - cantidadVender WHERE id = idP;
END //
