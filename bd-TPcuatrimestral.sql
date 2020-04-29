drop database if exists `bd_stock`;
CREATE DATABASE IF NOT EXISTS `bd_stock` DEFAULT CHARACTER SET latin1;
USE `bd_stock` ;

--
-- Table structure for table `persona`
--
CREATE TABLE `persona` (
`idPersona` int NOT NULL AUTO_INCREMENT,
`dni` INT NOT NULL,
`nombre` VARCHAR(45) NULL DEFAULT NULL,
`apellido` VARCHAR(45) NULL DEFAULT NULL,
`fechaDeNacimiento` DATE NULL DEFAULT NULL,
PRIMARY KEY (`idPersona`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;

--
-- Table structure for table `cliente`
--
CREATE TABLE `cliente` (
  `idCliente` INT NOT NULL,
  `email` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`idCliente`),
  CONSTRAINT `fk_cliente_1` FOREIGN KEY (`idCliente`) REFERENCES `persona` (`idPersona`)
  ON DELETE NO ACTION ON UPDATE NO ACTION
  ) ENGINE = InnoDB DEFAULT CHARSET = latin1;

--
-- Table structure for table `stock`
--
CREATE TABLE `stock` (
`idStock` INT NOT NULL AUTO_INCREMENT,
`cantidad` INT DEFAULT NULL,
PRIMARY KEY (`idStock`)
) ENGINE = InnoDB DEFAULT CHARSET = latin1;


-- 
-- Table structure for table `solicitud_stock`
-- 
CREATE TABLE `solicitud_stock` (
  `idSolicitudStock` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE  DEFAULT NULL,
  `cantidad` INT DEFAULT NULL,
  `aceptado` TINYINT DEFAULT NULL,
  PRIMARY KEY (`idSolicitudStock`)
 ) ENGINE = InnoDB DEFAULT CHARSET = latin1;
--
-- Table structure for table `local`
--
CREATE TABLE `local` (
  `idLocal` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) DEFAULT NULL,
  `latitud` DOUBLE DEFAULT NULL,
  `longitud` FLOAT DEFAULT NULL,
  `telefono` DOUBLE DEFAULT NULL,
  `stock_idStock` INT,
  `soli_idSolicitudStock` INT,
  PRIMARY KEY (`idLocal`),
  CONSTRAINT `fk_local_stock1` FOREIGN KEY (`stock_idStock`) REFERENCES `stock` (`idStock`),
  CONSTRAINT `fk_local_solicitudStock1` FOREIGN KEY (`soli_idSolicitudStock`)  REFERENCES `solicitud_stock` (`idSolicitudStock`)
  ON DELETE NO ACTION ON UPDATE NO ACTION
  ) ENGINE = InnoDB DEFAULT CHARSET = latin1;
--
-- Table structure for table `empleado`
--
CREATE TABLE `empleado` (
  `idEmpleado` INT NOT NULL,
  `franjaHoraria` VARCHAR(45) DEFAULT NULL,
  `tipoEmpleado` TINYINT DEFAULT NULL,
  `local_idLocal` INT,
  PRIMARY KEY (`idEmpleado`),
  CONSTRAINT `fk_empleado_persona1` FOREIGN KEY (`idEmpleado`) REFERENCES `persona` (`idPersona`)
  ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleado_local1` FOREIGN KEY (`local_idLocal`) REFERENCES `local` (`idLocal`)
  ON DELETE NO ACTION ON UPDATE NO ACTION
  ) ENGINE = InnoDB DEFAULT CHARSET = latin1;

--
-- Table structure for table `carrito`
--
CREATE TABLE `carrito` (
`idCarrito` INT NOT NULL AUTO_INCREMENT,
`fecha` DATE,
`total` FLOAT DEFAULT NULL,
`cliente-idCliente` INT NOT NULL,
PRIMARY KEY (`idCarrito`),
CONSTRAINT `fk_carrito_1` FOREIGN KEY (`cliente-idCliente`) REFERENCES `cliente` (`idCliente`)
ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = latin1;


--
-- Table structure for table `factura`
--
CREATE TABLE `factura` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE,
  `total` DOUBLE,
  `cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idFactura`),
  CONSTRAINT `fk_factura_cliente1` FOREIGN KEY (`cliente_idCliente`) REFERENCES `cliente` (`idCliente`)
  ON DELETE NO ACTION ON UPDATE NO ACTION 
  ) ENGINE = InnoDB DEFAULT CHARSET = latin1;

--
-- Table structure for table `lote`
--
CREATE TABLE `lote` (
  `idLote` INT NOT NULL AUTO_INCREMENT,
  `cantidadInicial` INT DEFAULT NULL,
  `cantidadActual` INT DEFAULT NULL,
  `fechaIngreso` DATE DEFAULT NULL,
  `estado` TINYINT DEFAULT NULL,
  `stock_idStock` INT,
  PRIMARY KEY (`idLote`),
  CONSTRAINT `fk_lote_stock1` FOREIGN KEY (`stock_idStock`) REFERENCES `stock` (`idStock`)
  ON DELETE NO ACTION ON UPDATE NO ACTION
  ) ENGINE = InnoDB DEFAULT CHARSET = latin1;


--
-- Table structure for table `pedido`
--
CREATE TABLE `pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `cantidad` INT  DEFAULT NULL,
  `subtotal` FLOAT DEFAULT NULL,
  `aceptado` TINYINT DEFAULT NULL,
  `idVendedor` INT,
  `carrito_idCarrito` INT,
  PRIMARY KEY (`idPedido`),
  CONSTRAINT `fk_pedido_vendedor1` FOREIGN KEY (`idVendedor`) REFERENCES `empleado` (`idEmpleado`)
  ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_carrito1` FOREIGN KEY (`carrito_idCarrito`) REFERENCES `carrito` (`idCarrito`)
  ON DELETE NO ACTION ON UPDATE NO ACTION
  ) ENGINE = InnoDB DEFAULT CHARSET = latin1;

--
-- Table structure for table `producto`
--
CREATE TABLE `producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) DEFAULT NULL,
  `descripcion` VARCHAR(45) DEFAULT NULL,
  `precio` FLOAT DEFAULT NULL,
  `fechaAlta` DATE DEFAULT NULL,
  `pedido_idPedido` INT,
  PRIMARY KEY (`idProducto`),  
  CONSTRAINT `fk_producto_pedido1` FOREIGN KEY (`pedido_idPedido`) REFERENCES `pedido` (`idPedido`)
  ON DELETE NO ACTION ON UPDATE NO ACTION
  ) ENGINE = InnoDB DEFAULT CHARACTER SET = latin1;

--
-- Table structure for table `clientesXLocales`
--
CREATE TABLE `clientesXLocales` (
  `local_idLocal` INT NOT NULL AUTO_INCREMENT,
  `cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`cliente_idCliente`, `local_idLocal`),
  CONSTRAINT `fk_clientesXLocales_local1` FOREIGN KEY (`local_idLocal`) REFERENCES `local` (`idLocal`)
  ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientesXLocales_cliente1` FOREIGN KEY (`cliente_idCliente`) REFERENCES `cliente` (`idCliente`)
  ON DELETE NO ACTION ON UPDATE NO ACTION
  ) ENGINE = InnoDB;

--
-- Table structure for table `productosXLotes`
--
CREATE TABLE `productosXLotes` (
  `lote_idLote` INT NOT NULL AUTO_INCREMENT,
  `producto_idProducto` INT NOT NULL,
  PRIMARY KEY (`lote_idLote`, `producto_idProducto`),
  CONSTRAINT `fk_productosXLotes_lote1` FOREIGN KEY (`lote_idLote`) REFERENCES `lote` (`idLote`)
  ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_productosXLotes_producto1` FOREIGN KEY (`producto_idProducto`) REFERENCES `producto` (`idProducto`)
  ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;
