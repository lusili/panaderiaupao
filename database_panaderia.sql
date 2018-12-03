/*
 Navicat Premium Data Transfer

 Source Server         : SERVER CHINA
 Source Server Type    : MySQL
 Source Server Version : 50560
 Source Host           : 54.190.56.175:3306
 Source Schema         : database_panaderia

 Target Server Type    : MySQL
 Target Server Version : 50560
 File Encoding         : 65001

 Date: 24/11/2018 15:22:32
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for acceso
-- ----------------------------
DROP TABLE IF EXISTS `acceso`;
CREATE TABLE `acceso`  (
  `idacceso` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `fechaacceso` datetime NOT NULL,
  PRIMARY KEY (`idacceso`) USING BTREE,
  INDEX `frk_idpersona02`(`idpersona`) USING BTREE,
  CONSTRAINT `frk_idpersona02` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for almacenes
-- ----------------------------
DROP TABLE IF EXISTS `almacenes`;
CREATE TABLE `almacenes`  (
  `idalmacen` int(11) NOT NULL AUTO_INCREMENT,
  `idsucursal` int(11) NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `direccion` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `telefono` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idalmacen`) USING BTREE,
  INDEX `idsucursal`(`idsucursal`) USING BTREE,
  CONSTRAINT `almacenes_ibfk_1` FOREIGN KEY (`idsucursal`) REFERENCES `sucursales` (`idsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for auditoria
-- ----------------------------
DROP TABLE IF EXISTS `auditoria`;
CREATE TABLE `auditoria`  (
  `idauditoria` int(11) NOT NULL AUTO_INCREMENT,
  `idoperacion` int(11) NOT NULL,
  `idtabla` int(11) NOT NULL,
  `tabla` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `idpersona` int(11) NULL DEFAULT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idauditoria`) USING BTREE,
  INDEX `frk_idoperacion01`(`idoperacion`) USING BTREE,
  INDEX `frk_idpersona01`(`idpersona`) USING BTREE,
  CONSTRAINT `frk_idoperacion01` FOREIGN KEY (`idoperacion`) REFERENCES `operaciones` (`idoperacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `frk_idpersona01` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for categorias
-- ----------------------------
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias`  (
  `idcategoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sigla` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NULL DEFAULT NULL,
  `fecharegistro` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`idcategoria`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for comprobantes
-- ----------------------------
DROP TABLE IF EXISTS `comprobantes`;
CREATE TABLE `comprobantes`  (
  `idcomprobante` int(11) NOT NULL AUTO_INCREMENT,
  `idtransaccion` int(11) NOT NULL,
  `valorventa` int(11) NOT NULL,
  `idserie` int(11) NOT NULL,
  `ncorrelativo` int(11) NOT NULL,
  `ncomprobante` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fechaemision` date NOT NULL,
  `fechavencimiento` date NOT NULL,
  `idpersona` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `idpedido` int(11) NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `idmoneda` int(11) NOT NULL,
  `descuento` decimal(10, 4) NOT NULL,
  `subtotal` decimal(10, 4) NOT NULL,
  `igv` decimal(10, 4) NOT NULL,
  `total` decimal(10, 4) NOT NULL,
  `fechacancelado` date NOT NULL,
  `situacionpago` int(11) NOT NULL,
  `totalcancelado` decimal(10, 4) NOT NULL,
  `idcomprobanterelacionado` int(11) NOT NULL,
  `ncomprobanterelacionado` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idcomprobante`) USING BTREE,
  INDEX `idserie`(`idserie`) USING BTREE,
  INDEX `idtransaccion`(`idtransaccion`) USING BTREE,
  CONSTRAINT `comprobantes_ibfk_2` FOREIGN KEY (`idtransaccion`) REFERENCES `transacciones` (`idtransaccion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `comprobantes_ibfk_1` FOREIGN KEY (`idserie`) REFERENCES `series` (`idserie`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for detallescomprobantes
-- ----------------------------
DROP TABLE IF EXISTS `detallescomprobantes`;
CREATE TABLE `detallescomprobantes`  (
  `iddetallecomprobante` int(11) NOT NULL,
  `idcomprobante` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `idunidadequivalente` int(11) NOT NULL,
  `idprecio` int(11) NOT NULL,
  `cantidad` decimal(10, 4) NOT NULL,
  `subtotal` decimal(10, 4) NOT NULL,
  `igv` decimal(10, 4) NOT NULL,
  `total` decimal(10, 4) NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`iddetallecomprobante`) USING BTREE,
  INDEX `idcomprobante`(`idcomprobante`) USING BTREE,
  INDEX `idproducto`(`idproducto`) USING BTREE,
  INDEX `idunidadequivalente`(`idunidadequivalente`) USING BTREE,
  INDEX `idprecio`(`idprecio`) USING BTREE,
  CONSTRAINT `detallescomprobantes_ibfk_1` FOREIGN KEY (`idcomprobante`) REFERENCES `comprobantes` (`idcomprobante`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `detallescomprobantes_ibfk_2` FOREIGN KEY (`idproducto`) REFERENCES `productos` (`idproducto`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `detallescomprobantes_ibfk_3` FOREIGN KEY (`idunidadequivalente`) REFERENCES `unidadesquivalentes` (`idunidadequivalente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `detallescomprobantes_ibfk_4` FOREIGN KEY (`idprecio`) REFERENCES `precios` (`idprecio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for detallespedidos
-- ----------------------------
DROP TABLE IF EXISTS `detallespedidos`;
CREATE TABLE `detallespedidos`  (
  `iddetallepedido` int(11) NOT NULL AUTO_INCREMENT,
  `idproducto` int(11) NOT NULL,
  `idunidadequivalente` int(11) NOT NULL,
  `idprecio` int(11) NOT NULL,
  `cantidad` decimal(10, 4) NOT NULL,
  `descuento` decimal(10, 4) NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`iddetallepedido`) USING BTREE,
  INDEX `idunidadequivalente`(`idunidadequivalente`) USING BTREE,
  INDEX `idproducto`(`idproducto`) USING BTREE,
  INDEX `idprecio`(`idprecio`) USING BTREE,
  CONSTRAINT `detallespedidos_ibfk_1` FOREIGN KEY (`idunidadequivalente`) REFERENCES `unidadesquivalentes` (`idunidadequivalente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `detallespedidos_ibfk_2` FOREIGN KEY (`idproducto`) REFERENCES `productos` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `detallespedidos_ibfk_3` FOREIGN KEY (`idprecio`) REFERENCES `precios` (`idprecio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for direcciones
-- ----------------------------
DROP TABLE IF EXISTS `direcciones`;
CREATE TABLE `direcciones`  (
  `iddireccion` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `ubicacion` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `referencia` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`iddireccion`) USING BTREE,
  INDEX `idpersona`(`idpersona`) USING BTREE,
  CONSTRAINT `direcciones_ibfk_1` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for empresas
-- ----------------------------
DROP TABLE IF EXISTS `empresas`;
CREATE TABLE `empresas`  (
  `idempresa` int(11) NOT NULL AUTO_INCREMENT,
  `razonsocial` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `idtipodocumentoidentidad` int(11) NOT NULL,
  `ruc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `direccion` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `telefono` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idempresa`) USING BTREE,
  INDEX `frk_idtipodocumentoidentidad01`(`idtipodocumentoidentidad`) USING BTREE,
  CONSTRAINT `frk_idtipodocumentoidentidad01` FOREIGN KEY (`idtipodocumentoidentidad`) REFERENCES `tiposdocumentoidentidad` (`idtipodocumentoidentidad`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for monedas
-- ----------------------------
DROP TABLE IF EXISTS `monedas`;
CREATE TABLE `monedas`  (
  `idmoneda` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sigla` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idmoneda`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for movimientos
-- ----------------------------
DROP TABLE IF EXISTS `movimientos`;
CREATE TABLE `movimientos`  (
  `idmovimiento` int(11) NOT NULL AUTO_INCREMENT,
  `idtipomovimiento` int(11) NOT NULL,
  `iddetallecomprobante` int(11) NOT NULL,
  `cantidadactual` decimal(10, 4) NOT NULL,
  `cantidadingreso` decimal(10, 4) NOT NULL,
  `cantidadsalida` decimal(10, 4) NOT NULL,
  `cantidadfinal` decimal(10, 4) NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idmovimiento`) USING BTREE,
  INDEX `idtipomovimiento`(`idtipomovimiento`) USING BTREE,
  CONSTRAINT `movimientos_ibfk_1` FOREIGN KEY (`idtipomovimiento`) REFERENCES `tiposmovimientos` (`idtipomovimiento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for operaciones
-- ----------------------------
DROP TABLE IF EXISTS `operaciones`;
CREATE TABLE `operaciones`  (
  `idoperacion` int(11) NOT NULL AUTO_INCREMENT,
  `operacion` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`idoperacion`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of operaciones
-- ----------------------------
INSERT INTO `operaciones` VALUES (1, 'INSERT');
INSERT INTO `operaciones` VALUES (2, 'UPDATE');
INSERT INTO `operaciones` VALUES (3, 'DELETE');

-- ----------------------------
-- Table structure for pedidos
-- ----------------------------
DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE `pedidos`  (
  `idpedido` int(11) NOT NULL,
  `idpersona` int(11) NOT NULL,
  `fechapedido` date NOT NULL,
  `iddireccion` int(11) NOT NULL,
  `idtelefono` int(11) NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`idpedido`) USING BTREE,
  INDEX `idpersona`(`idpersona`) USING BTREE,
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for perfiles
-- ----------------------------
DROP TABLE IF EXISTS `perfiles`;
CREATE TABLE `perfiles`  (
  `idperfil` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sigla` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idperfil`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of perfiles
-- ----------------------------
INSERT INTO `perfiles` VALUES (1, 'CLIENTE', 'CLI', 1, '2018-11-04 17:59:38');
INSERT INTO `perfiles` VALUES (2, 'ADMINISTRADOR', 'ADMIN', 1, '2018-11-04 17:59:58');

-- ----------------------------
-- Table structure for personas
-- ----------------------------
DROP TABLE IF EXISTS `personas`;
CREATE TABLE `personas`  (
  `idpersona` int(11) NOT NULL AUTO_INCREMENT,
  `apellidopaterno` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `apellidomaterno` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `idtipodocuentoidentidad` int(11) NOT NULL,
  `ndocumento` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idpersona`) USING BTREE,
  INDEX `idtipodocuentoidentidad`(`idtipodocuentoidentidad`) USING BTREE,
  CONSTRAINT `personas_ibfk_1` FOREIGN KEY (`idtipodocuentoidentidad`) REFERENCES `tiposdocumentoidentidad` (`idtipodocumentoidentidad`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for personasperfiles
-- ----------------------------
DROP TABLE IF EXISTS `personasperfiles`;
CREATE TABLE `personasperfiles`  (
  `idpersonaperfil` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `idperfil` int(11) NOT NULL,
  `cuenta` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `clave` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idpersonaperfil`) USING BTREE,
  INDEX `idpersona`(`idpersona`) USING BTREE,
  INDEX `idperfil`(`idperfil`) USING BTREE,
  CONSTRAINT `personasperfiles_ibfk_1` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `personasperfiles_ibfk_2` FOREIGN KEY (`idperfil`) REFERENCES `perfiles` (`idperfil`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for precios
-- ----------------------------
DROP TABLE IF EXISTS `precios`;
CREATE TABLE `precios`  (
  `idprecio` int(11) NOT NULL AUTO_INCREMENT,
  `idproducto` int(11) NOT NULL,
  `idunidadmedida` int(11) NOT NULL,
  `idtipoprecio` int(11) NOT NULL,
  `idmoneda` int(11) NOT NULL,
  `precio` decimal(10, 8) NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idprecio`) USING BTREE,
  INDEX `idproducto`(`idproducto`) USING BTREE,
  INDEX `idunidadmedida`(`idunidadmedida`) USING BTREE,
  INDEX `idtipoprecio`(`idtipoprecio`) USING BTREE,
  INDEX `idmoneda`(`idmoneda`) USING BTREE,
  CONSTRAINT `precios_ibfk_4` FOREIGN KEY (`idmoneda`) REFERENCES `monedas` (`idmoneda`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `precios_ibfk_1` FOREIGN KEY (`idproducto`) REFERENCES `productos` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `precios_ibfk_2` FOREIGN KEY (`idunidadmedida`) REFERENCES `unidadesmedida` (`idunidadmedida`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `precios_ibfk_3` FOREIGN KEY (`idtipoprecio`) REFERENCES `tiposprecios` (`idprecio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for productos
-- ----------------------------
DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos`  (
  `idproducto` int(11) NOT NULL AUTO_INCREMENT,
  `idcategoria` int(11) NOT NULL,
  `nombreproducto` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idproducto`) USING BTREE,
  INDEX `frk_idcategoria01`(`idcategoria`) USING BTREE,
  CONSTRAINT `frk_idcategoria01` FOREIGN KEY (`idcategoria`) REFERENCES `categorias` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for productosalmacenes
-- ----------------------------
DROP TABLE IF EXISTS `productosalmacenes`;
CREATE TABLE `productosalmacenes`  (
  `idproductoalmacen` int(11) NOT NULL AUTO_INCREMENT,
  `idalmacen` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `totalingresos` decimal(10, 8) NOT NULL,
  `totalsalidas` decimal(10, 8) NOT NULL,
  `cantidad` decimal(10, 8) NOT NULL,
  PRIMARY KEY (`idproductoalmacen`) USING BTREE,
  INDEX `idalmacen`(`idalmacen`) USING BTREE,
  INDEX `idproducto`(`idproducto`) USING BTREE,
  CONSTRAINT `productosalmacenes_ibfk_1` FOREIGN KEY (`idalmacen`) REFERENCES `almacenes` (`idalmacen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `productosalmacenes_ibfk_2` FOREIGN KEY (`idproducto`) REFERENCES `productos` (`idproducto`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for proveedor
-- ----------------------------
DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE `proveedor`  (
  `idproveedor` int(11) NOT NULL AUTO_INCREMENT,
  `razonsocial` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `idtipodocumentoidentidad` int(11) NOT NULL,
  `ndocumento` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `direccion` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idproveedor`) USING BTREE,
  INDEX `idtipodocumentoidentidad`(`idtipodocumentoidentidad`) USING BTREE,
  CONSTRAINT `proveedor_ibfk_1` FOREIGN KEY (`idtipodocumentoidentidad`) REFERENCES `tiposdocumentoidentidad` (`idtipodocumentoidentidad`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for series
-- ----------------------------
DROP TABLE IF EXISTS `series`;
CREATE TABLE `series`  (
  `idserie` int(11) NOT NULL AUTO_INCREMENT,
  `idalmacen` int(11) NOT NULL,
  `idtipocomprobante` int(11) NOT NULL,
  `nserie` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `inicio` int(11) NOT NULL,
  `fin` int(11) NOT NULL,
  `correlativo` int(11) NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idserie`) USING BTREE,
  INDEX `idtipocomprobante`(`idtipocomprobante`) USING BTREE,
  INDEX `idalmacen`(`idalmacen`) USING BTREE,
  CONSTRAINT `series_ibfk_2` FOREIGN KEY (`idalmacen`) REFERENCES `almacenes` (`idalmacen`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `series_ibfk_1` FOREIGN KEY (`idtipocomprobante`) REFERENCES `tiposcomprobantes` (`idtipocomprobante`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sucursales
-- ----------------------------
DROP TABLE IF EXISTS `sucursales`;
CREATE TABLE `sucursales`  (
  `idsucursal` int(11) NOT NULL AUTO_INCREMENT,
  `idempresa` int(11) NOT NULL,
  `razonsocial` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sede` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `direccion` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `telefono` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idsucursal`) USING BTREE,
  INDEX `idempresa`(`idempresa`) USING BTREE,
  CONSTRAINT `sucursales_ibfk_1` FOREIGN KEY (`idempresa`) REFERENCES `empresas` (`idempresa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for telefonos
-- ----------------------------
DROP TABLE IF EXISTS `telefonos`;
CREATE TABLE `telefonos`  (
  `idtelefono` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `numerotelefono` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idtelefono`) USING BTREE,
  INDEX `idpersona`(`idpersona`) USING BTREE,
  CONSTRAINT `telefonos_ibfk_1` FOREIGN KEY (`idpersona`) REFERENCES `personas` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tiposcomprobantes
-- ----------------------------
DROP TABLE IF EXISTS `tiposcomprobantes`;
CREATE TABLE `tiposcomprobantes`  (
  `idtipocomprobante` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sigla` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`idtipocomprobante`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tiposcomprobantes
-- ----------------------------
INSERT INTO `tiposcomprobantes` VALUES (1, 'SIN DOCUMENTO', 'SD', 1, '2018-11-18 19:15:16');

-- ----------------------------
-- Table structure for tiposdocumentoidentidad
-- ----------------------------
DROP TABLE IF EXISTS `tiposdocumentoidentidad`;
CREATE TABLE `tiposdocumentoidentidad`  (
  `idtipodocumentoidentidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombredocumento` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sigla` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `longitud` int(11) NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idtipodocumentoidentidad`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tiposmovimientos
-- ----------------------------
DROP TABLE IF EXISTS `tiposmovimientos`;
CREATE TABLE `tiposmovimientos`  (
  `idtipomovimiento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sigla` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idtipomovimiento`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tiposmovimientos
-- ----------------------------
INSERT INTO `tiposmovimientos` VALUES (1, 'INGRESO', 'ING', 1, '2018-11-12 21:36:58');
INSERT INTO `tiposmovimientos` VALUES (2, 'SALIDA', 'SAL', 1, '2018-11-12 21:37:11');

-- ----------------------------
-- Table structure for tiposprecios
-- ----------------------------
DROP TABLE IF EXISTS `tiposprecios`;
CREATE TABLE `tiposprecios`  (
  `idprecio` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sigla` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idprecio`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tiposprecios
-- ----------------------------
INSERT INTO `tiposprecios` VALUES (1, 'COMPRA', 'COM', 1, '2018-11-11 11:17:53');
INSERT INTO `tiposprecios` VALUES (2, 'VENTA', 'VEN', 1, '2018-11-11 11:18:07');

-- ----------------------------
-- Table structure for tipounidades
-- ----------------------------
DROP TABLE IF EXISTS `tipounidades`;
CREATE TABLE `tipounidades`  (
  `idtipounidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sigla` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`idtipounidad`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tipounidades
-- ----------------------------
INSERT INTO `tipounidades` VALUES (1, 'BASE', 'BA', 1, '2018-11-05 20:50:07');
INSERT INTO `tipounidades` VALUES (2, 'EQUIVALENTE', 'EQ', 1, '2018-11-05 20:50:24');

-- ----------------------------
-- Table structure for transacciones
-- ----------------------------
DROP TABLE IF EXISTS `transacciones`;
CREATE TABLE `transacciones`  (
  `idtransaccion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sigla` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idtransaccion`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of transacciones
-- ----------------------------
INSERT INTO `transacciones` VALUES (1, 'COMPRA', 'COMP', 1, '2018-11-12 21:31:52');
INSERT INTO `transacciones` VALUES (2, 'VENTA', 'VENT', 1, '2018-11-12 21:32:09');
INSERT INTO `transacciones` VALUES (3, 'DEVOLUCION', 'DEV', 1, '2018-11-12 21:32:32');
INSERT INTO `transacciones` VALUES (4, 'INVENTARIO', 'INV', 1, '2018-11-12 21:32:58');
INSERT INTO `transacciones` VALUES (5, 'INGRESO POR AJUSTE', 'IXA', 1, '2018-11-12 21:33:26');
INSERT INTO `transacciones` VALUES (6, 'SALIDA POR AJUSTO', 'SXA', 1, '2018-11-12 21:33:46');
INSERT INTO `transacciones` VALUES (7, 'PEDIDO', 'PED', 1, '2018-11-12 21:34:36');

-- ----------------------------
-- Table structure for unidadesmedida
-- ----------------------------
DROP TABLE IF EXISTS `unidadesmedida`;
CREATE TABLE `unidadesmedida`  (
  `idunidadmedida` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sigla` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`idunidadmedida`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for unidadesquivalentes
-- ----------------------------
DROP TABLE IF EXISTS `unidadesquivalentes`;
CREATE TABLE `unidadesquivalentes`  (
  `idunidadequivalente` int(11) NOT NULL AUTO_INCREMENT,
  `idtipounidad` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `idunidadequivale` int(11) NOT NULL,
  `factor` decimal(10, 4) NOT NULL,
  `idunidadmedida` int(11) NOT NULL,
  `estado` int(11) NOT NULL,
  `fecharegistro` datetime NOT NULL,
  PRIMARY KEY (`idunidadequivalente`) USING BTREE,
  INDEX `frk_idunidadequivalente01`(`idunidadequivale`) USING BTREE,
  INDEX `frk_unidadmedida02`(`idunidadmedida`) USING BTREE,
  INDEX `idtipounidad`(`idtipounidad`) USING BTREE,
  CONSTRAINT `unidadesquivalentes_ibfk_1` FOREIGN KEY (`idtipounidad`) REFERENCES `tipounidades` (`idtipounidad`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `frk_idunidadequivalente01` FOREIGN KEY (`idunidadequivale`) REFERENCES `unidadesmedida` (`idunidadmedida`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `frk_unidadmedida02` FOREIGN KEY (`idunidadmedida`) REFERENCES `unidadesmedida` (`idunidadmedida`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Procedure structure for SP_actualizar_almacenes
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_almacenes`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_almacenes`(in _idalmacen int(11),
in _idsucursal int(11),
in _nombre VARCHAR(255),
in _direccion VARCHAR(255),
in _telefono VARCHAR(255),
in _estado int(11),
in _idpersona int(11))
begin

update almacenes set 
idsucursal=_idsucursal,
nombre=_nombre,
direccion=_direccion,
telefono=_estado,
estado=_estado
where idalmacen=_idalmacen;

select ROW_COUNT() as _nfila_afectada;

call SP_registrar_auditoria(2,_idalmacen,"SUCURSALES",_idpersona);

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_categoria
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_categoria`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_categoria`(in _idcategoria int(11),
in _nombre VARCHAR(255),
in _sigla VARCHAR(255),
in _estado int(11),
in _idpersona int(11))
begin 

update categorias set 
nombre=_nombre,
sigla=_sigla,
estado=_estado
where idcategoria=_idcategoria;

select ROW_COUNT() as _nfila_afectada;

call SP_registrar_auditoria(2,_idcategoria,"CATEGORIAS",_idpersona);

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_direccion
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_direccion`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_direccion`(in _iddireccion int(11),
in _idpersona int(11),
in _ubicacion VARCHAR(255),
in _referencia VARCHAR(255),
in _estado int(11),
in _idpersonaa int(11))
begin 

update direcciones SET
idpersona=_idpersona,
ubicacion=_ubicacion,
referencia=_referencia,
estado=_estado
where iddireccion=_iddireccion;

SELECT ROW_COUNT() as _nfila_afectada;

call registrar_auditoria(2,_iddireccion,"DIRECCIONES",_idpersonaa);

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_empresa
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_empresa`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_empresa`(in _idempresa int(11),
in _razonsocial VARCHAR(255),
in _idtipodocumentoidentidad int(11),
in _ruc VARCHAR(255),
in _direccion VARCHAR(255),
in _telefono VARCHAR(255),
in _estado int(11),
in _idpersona int(11))
begin


update empresas set 
razonsocial=_razonsocial,
idtipodocumentoidentidad=_idtipodocumentoidentidad,
ruc=_ruc,
direccion=_direccion,
telefono=_telefono,
estado=_estado
where idempresa=_idempresa ;

SELECT ROW_COUNT() as _nfila_afectada;

call SP_registrar_auditoria(2,_idempresa,"EMPRESAS",_idpersona);

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_moneda
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_moneda`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_moneda`(in _idmoneda int(11),
in _nombre VARCHAR(255),
in _sigla VARCHAR(255),
in _estado int(11),
in _idpersona int(11))
begin

update moneda set 
nombre=_nombre,
sigla=_sigla,
estado=_estado
where idmoneda=_idmoneda;

select ROW_COUNT() as _nfila_afectada;

call SP_registrar_auditoria(2,_idmoneda,"MONEDAS",_idpersona);

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_persona
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_persona`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_persona`(in _idpersona int(11),
in _idperfil int(11),
in _apellidopaterno VARCHAR(255),
in _apellidopmaterno VARCHAR(255),
in _nombre VARCHAR(255),
in _idtipodocumentoidentidad int(11),
in _ndocumento VARCHAR(255),
in _cuenta VARCHAR(255),
in _clave VARCHAR(255),
in _estado int(11),
in _idpersonaactu int(11))
begin

UPDATE persona set
apellidopaterno=_apellidopaterno,
apellidomaterno=_apellidopmaterno,
nombre=_nombre,
idtipodocuentoidentidad=_idtipodocumentoidentidad,
ndocumento=_ndocumento,
estado=_estado
where idpersona=_idpersona;

select ROW_COUNT() as _nfila_afectada;


call SP_registrar_auditoria(2,_idpersona,"PERSONA",_idpersonaactu);

update personasperfiles set 
cuenta=_cuenta,
clave=_clave,
estado=_estado
where idpersona=_idpersona and idperfil=_idperfil;


call registrar_auditoria(2,
(select idpersonaperfil
from personasperfiles
where idpersona=_idpersona and idperfil=_idperfil),
"PERSONASPERFILES",
_idpersonaactu);

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_personasperfiles
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_personasperfiles`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_personasperfiles`(in _idpersonaperfil int(11),
in _idpersona int(11),
in _idperfil int(11),
in _cuenta VARCHAR(255),
in _clave VARCHAR(255),
in _estado int(11),
in _idpersonaact int(11))
begin

update personasperfiles set
idpersona=_idpersona,
idperfil=_idperfil,
cuenta=_cuenta,
clave=_clave,
estado=_estado
where idpersonaperfil=_idpersonaperfil;

select ROW_COUNT() as _nfila_afectada;

call SP_registrar_auditoria(2,_idpersonaperfil,"PERSONASPERFILES",_idpersonaact);

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_precio
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_precio`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_precio`(in _idprecio int(11),
in _idproducto int(11),
in _idunidadmedida int(11),
in _idtipoprecio int(11),
in _idmoneda int(11),
in _precio decimal(10,8),
in _estado int(11),
in _idpersona int(11))
begin

update precios set 
idproducto=_idproducto,
idunidadmedida=_idunidadmedida,
idtipoprecio=_idtipoprecio,
idmoneda=_idmoneda,
precio=_precio,
estado=_estado
where idprecio=_idprecio;

select ROW_COUNT() as _nfila_afectada;

call SP_registrar_auditoria(2,_idprecio,"PRECIOS",_idpersona);

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_proveedor
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_proveedor`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_proveedor`(in _idproveedor int(11),
in _razonsocial VARCHAR(255),
in _idtipodocumentoidentidad int(11),
in _ndocumento VARCHAR(255),
in _direccion VARCHAR(255),
in _estado int(11),
in _idpersona int(11))
begin

update proveedor set 
razonsocial=_razonsocial,
idtipodocumentoidentidad=_idtipodocumentoidentidad,
ndocumento=_ndocumento,
direccion=_direccion,
estado=_estado
where idproveedor=_idproveedor;

select ROW_COUNT() as _nfila_afectada;

call registrar_auditoria(2,_idproveedor,"PROVEEDOR",_idpersona);

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_serie
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_serie`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_serie`(in _idserie int(11),
in _idalmacen int(11),
in _idtipocomprobante int(11),
in _nserie VARCHAR(255),
in _inicio int(11),
in _fin int(11),
in _correlativo int(11),
in _estado int(11),
in _idpersona int(11))
begin

update serie set 
idalmacen=_idalmacen,
idtipocomprobante=_idtipocomprobante,
nserie=_nserie,
inicio=_inicio,
fin=_fin,
correlativo=_correlativo,
estado=_estado
where idserie=_idserie;

SELECT ROW_COUNT() as _nfila_afectada;

call registrar_auditoria(2,_idserie,"DIRECCIONES",_idpersona);

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_sucursal
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_sucursal`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_sucursal`(in _idsucursal int(11),
in _idempresa int(11),
in _razonsocial VARCHAR(255),
in _sede VARCHAR(255),
in _direccion VARCHAR(255),
in _telefono VARCHAR(255),
in _estado int(11),
in _idpersona int(11))
begin

update sucursales set 
idempresa=_idempresa,
razonsocial=_razonsocial,
sede=_sede,
direccion=_direccion,
telefono=_telefono,
estado=_estado
where idsucursal=_idsucursal;

select ROW_COUNT() as _nfila_afectada;

call SP_registrar_auditoria(2,_idsucursal,"SUCURSALES",_idpersona);

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_telefono
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_telefono`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_telefono`(in _idtelefono int(11),
in _idpersona int(11),
in _numerotelefono VARCHAR(255),
in _estado int(11),
in _idpersonaa int(11))
begin 

UPDATE telefonos set 
idpersona=_idpersona,
numerotelefono=_numerotelefono,
estado=_estado
where idtelefono=_idtelefono;

SELECT ROW_COUNT() as _nfila_afectada;

call registrar_auditoria(2,_idtelefono,"TELEFONOS",_idpersonaa);

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_tipocomprobante
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_tipocomprobante`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_tipocomprobante`(in _idtipocomprobante int(11),
in _nombre VARCHAR(255),
in _sigla VARCHAR(255),
in _estado int(11),
in _idpersona int(11))
begin 


update tiposcomprobantes set
nombre=_nombre,
sigla=_sigla,
estado=_estado
where idtipocomprobante=_idtipocomprobante;

SELECT ROW_COUNT() as _nfila_afectada;

call registrar_auditoria(2,_idtipocomprobante,"TIPOSCOMPROBANTE",_idpersona);


end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_tipodocumentoidentidad
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_tipodocumentoidentidad`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_tipodocumentoidentidad`(in _idtipodocumentoidentidad int(11),
in _nombredocumento VARCHAR(255),
in _sigla VARCHAR(255),
in _longitud int(11),
in _estado int(11),
in _idpersona int(11))
begin

update tiposdocumentoidentidad set 
nombredocumento=_nombredocumento,
sigla=_sigla,
longitud=_longitud,
estado=_estado
where idtipodocumentoidentidad=_idtipodocumentoidentidad;

select ROW_COUNT() as _nfila_afectada;

call SP_registrar_auditoria(2,_idtipodocumentoidentidad,"TIPOSDOCUMENTOIDENTIDAD",_idpersona);

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_transaccion
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_transaccion`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_transaccion`(in _idtransaccion int(11),
in _nombre VARCHAR(255),
in _sigla VARCHAR(255),
in _estado int(11),
in _idpersona int(11))
begin 

update transacciones set
nombre=_nombre,
sigla=_sigla,
estado=_estado
where idtransaccion=_idtransaccion;

select ROW_COUNT() as _nfila_afectada;

call SP_registrar_auditoria(2,_idtransaccion,"CATEGORIAS",_idpersona);

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_actualizar_unidadmedida
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_actualizar_unidadmedida`;
delimiter ;;
CREATE PROCEDURE `SP_actualizar_unidadmedida`(in _idunidadmedida int(11),
in _nombre VARCHAR(255),
in _sigla VARCHAR(255),
in _estado int(11),
in _idpersona int(11))
begin

update unidadesmedida set 
nombre=_nombre,
sigla=_sigla,
estado=_estado
where idunidadmedida=_idunidadmedida;

select ROW_COUNT() as _nfila_afectada;

call SP_registrar_auditoria(2,_idunidadmedida,"PERSONAS",_idpersona);

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_almacen
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_almacen`;
delimiter ;;
CREATE PROCEDURE `SP_listar_almacen`()
begin

select 
a.idalmacen,
a.idsucursal,
a.nombre,
s.razonsocial,
a.direccion,
a.telefono,
if(a.estado=0,'ACTIVO','NO ACTIVO') as estado
from almacenes a
INNER JOIN sucursales s on a.idsucursal=s.idsucursal;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_almacenxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_almacenxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_almacenxestado`()
begin

select 
a.idalmacen,
a.idsucursal,
a.nombre,
s.razonsocial,
a.direccion,
a.telefono,
a.estado
from almacenes a
INNER JOIN sucursales s on a.idsucursal=s.idsucursal
where a.estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_almacenxidalmacenxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_almacenxidalmacenxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_almacenxidalmacenxestado`(in _idalmacen int(11))
begin

select 
a.idalmacen,
a.idsucursal,
a.nombre,
s.razonsocial,
a.direccion,
a.telefono,
a.estado
from almacenes a
INNER JOIN sucursales s on a.idsucursal=s.idsucursal
where a.idalmacen=_idalmacen and a.estado=1 ;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_almacenxidsucursalxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_almacenxidsucursalxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_almacenxidsucursalxestado`(in _idsucursal int(11))
begin

select 
a.idalmacen,
a.idsucursal,
a.nombre,
s.razonsocial,
a.direccion,
a.telefono,
a.estado
from almacenes a
INNER JOIN sucursales s on a.idsucursal=s.idsucursal
where a.idsucursal=_idsucursal and a.estado=1 ;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_categoria
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_categoria`;
delimiter ;;
CREATE PROCEDURE `SP_listar_categoria`()
begin

select 
idcategoria,
nombre,
sigla,
if(estado=1,'ACTIVO','NO ACTIVO') as estado
from categorias;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_categoriaxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_categoriaxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_categoriaxestado`()
begin

select 
idcategoria,
nombre,
sigla,
estado
from categorias
where estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_direccion
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_direccion`;
delimiter ;;
CREATE PROCEDURE `SP_listar_direccion`()
begin

select 
d.iddireccion,
d.idpersona,
p.apellidopaterno,
p.apellidomaterno,
p.nombre,
d.ubicacion,
d.referencia,
if(d.estado=1,'ACTIVO','NO ACTIVO') as estado
from direcciones d
INNER JOIN persona p on d.idpersona=p.idpersona;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_direccionxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_direccionxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_direccionxestado`()
begin

select 
d.iddireccion,
d.idpersona,
p.apellidopaterno,
p.apellidomaterno,
p.nombre,
d.ubicacion,
d.referencia,
d.estado
from direcciones d
INNER JOIN persona p on d.idpersona=p.idpersona
where d.estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_direccionxiddireccionxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_direccionxiddireccionxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_direccionxiddireccionxestado`(in _iddireccion int(11))
begin

select 
d.iddireccion,
d.idpersona,
p.apellidopaterno,
p.apellidomaterno,
p.nombre,
d.ubicacion,
d.referencia,
d.estado
from direcciones d
INNER JOIN persona p on d.idpersona=p.idpersona
where d.iddirecion=_iddireccion and d.estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_direccionxidpersonaxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_direccionxidpersonaxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_direccionxidpersonaxestado`(in _idpersona int(11))
begin

select 
d.iddireccion,
d.idpersona,
p.apellidopaterno,
p.apellidomaterno,
p.nombre,
d.ubicacion,
d.referencia,
d.estado
from direcciones d
INNER JOIN persona p on d.idpersona=p.idpersona
where d.idpersona=_idpersona and d.estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_empresa
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_empresa`;
delimiter ;;
CREATE PROCEDURE `SP_listar_empresa`()
begin

select 
e.idempresa,
e.razonsocial,
e.idtipodocumentoidentidad,
t.sigla,
e.ruc,
e.direccion,
e.telefono,
if(e.estado,'ACTIVO','NO ACTIVO') as estado
from empresas e
INNER JOIN tiposdocumentoidentidad t on e.idtipodocumentoidentidad=t.idtipodocumentoidentidad;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_empresaxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_empresaxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_empresaxestado`()
begin

select 
e.idempresa,
e.razonsocial,
e.idtipodocumentoidentidad,
t.sigla,
e.ruc,
e.direccion,
e.telefono,
e.estado
from empresas e
INNER JOIN tiposdocumentoidentidad t on e.idtipodocumentoidentidad=t.idtipodocumentoidentidad
where e.estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_empresaxidestadoxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_empresaxidestadoxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_empresaxidestadoxestado`(in _idempresa int(11))
begin

select 
e.idempresa,
e.razonsocial,
e.idtipodocumentoidentidad,
t.sigla,
e.ruc,
e.direccion,
e.telefono,
e.estado
from empresas e
INNER JOIN tiposdocumentoidentidad t on e.idtipodocumentoidentidad=t.idtipodocumentoidentidad
where e.estado=1 and e.idempresa=_idempresa;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_monedaxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_monedaxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_monedaxestado`()
begin

select 
nombre,
sigla,
estado
from monedas
where estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_monedaxidmonedaxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_monedaxidmonedaxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_monedaxidmonedaxestado`(in _idmoneda int(11))
begin

select 
nombre,
sigla,
estado
from monedas
where idmoneda=_idmoneda and estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_perfilxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_perfilxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_perfilxestado`()
begin

select 
idperfil,
sigla
from perfiles
where estado=1;#estado 1 activo

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_personaxcuentaxclavexestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_personaxcuentaxclavexestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_personaxcuentaxclavexestado`(in _idperfil int(11),
in _cuenta VARCHAR(255),
in _clave VARCHAR(255))
begin

declare _idpersonaperfil  int(11)  default 0;
declare _idacceso int(11) default 0;

set _idpersonaperfil=(

select ifnull(idpersonaperfil,0)
from personasperfiles
where cuenta=_cuenta and clave=_clave and idperfil=_idperfil
);


if(_idpersona>0)then

	select 
	p.idpersona,
	pf.idperfil,
	f.sigla as fsigla,
	p.apellidopaterno,
	p.apellidomaterno,
	p.nombre,
	p.idtipodocuentoidentidad,
	t.sigla as tsigla,
	p.ndocumento,
	f.cuenta,
	f.clave,
	p.estado
	from personasperfiles pf
	INNER JOIN personas p on pf.idpersona=p.idpersona
	INNER JOIN perfiles f on pf.idperfil=f.idperfil
	INNER JOIN tiposdocumentoidentidad t on p.idtipodocuentoidentidad=t.idtipodocuentoidentidad	
	where pf.cuenta=_cuenta and pf.clave=_clave and pf.idperfil=_idperfil;
	
	insert into acceso(
		idpersona,
		fechaacceso
	)
	values(
		(select idpersona from personasperfiles where idpersonaperfil=_idpersonaperfil),
		NOW()
	);
	
	set _idacceso=(select LAST_INSERT_ID());
	
	call SP_registrar_auditoria(1,_idacceso,"ACCESO",(select idpersona from personasperfiles where idpersonaperfil=_idpersonaperfil));
	

end if;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_precio
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_precio`;
delimiter ;;
CREATE PROCEDURE `SP_listar_precio`()
begin

select 
p.idprecio,
p.idproducto,
pro.nombreproducto,
p.idunidadmedida,
u.sigla as usigla,
p.idtipoprecio,
t.sigla as tsigla,
p.idmoneda,
m.sigla as msigla,
p.precio,
if(p.estado=1,'ACTIVO','NO ACTIVO') as estado
from precios p
INNER JOIN productos pro on p.idproducto=pro.idproducto
INNER JOIN unidadesmedida u on p.idunidadmedida=u.idunidadmedida
INNER JOIN tiposprecios t on p.idtipoprecio=t.idtipoprecio
INNER JOIN monedas m on p.idmoneda=m.idmoneda;
	
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_precioxidproducto
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_precioxidproducto`;
delimiter ;;
CREATE PROCEDURE `SP_listar_precioxidproducto`(in _idproducto int(11))
begin

select 
p.idprecio,
p.idproducto,
pro.nombreproducto,
p.idunidadmedida,
u.sigla as usigla,
p.idtipoprecio,
t.sigla as tsigla,
p.idmoneda,
m.sigla as msigla,
p.precio,
p.estado
from precios p
INNER JOIN productos pro on p.idproducto=pro.idproducto
INNER JOIN unidadesmedida u on p.idunidadmedida=u.idunidadmedida
INNER JOIN tiposprecios t on p.idtipoprecio=t.idtipoprecio
INNER JOIN monedas m on p.idmoneda=m.idmoneda
where p.idproducto=_idproducto;
	
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_precioxidproductoxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_precioxidproductoxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_precioxidproductoxestado`(in _idproducto int(11))
begin

select 
p.idprecio,
p.idproducto,
pro.nombreproducto,
p.idunidadmedida,
u.sigla as usigla,
p.idtipoprecio,
t.sigla as tsigla,
p.idmoneda,
m.sigla as msigla,
p.precio,
p.estado
from precios p
INNER JOIN productos pro on p.idproducto=pro.idproducto
INNER JOIN unidadesmedida u on p.idunidadmedida=u.idunidadmedida
INNER JOIN tiposprecios t on p.idtipoprecio=t.idtipoprecio
INNER JOIN monedas m on p.idmoneda=m.idmoneda
where p.idproducto=_idproducto and p.estado=1;
	
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_precioxidproductoxidtipoprecio
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_precioxidproductoxidtipoprecio`;
delimiter ;;
CREATE PROCEDURE `SP_listar_precioxidproductoxidtipoprecio`(in _idproducto int(11),
in _idtipoprecio int(11))
begin

select 
p.idprecio,
p.idproducto,
pro.nombreproducto,
p.idunidadmedida,
u.sigla as usigla,
p.idtipoprecio,
t.sigla as tsigla,
p.idmoneda,
m.sigla as msigla,
p.precio,
p.estado
from precios p
INNER JOIN productos pro on p.idproducto=pro.idproducto
INNER JOIN unidadesmedida u on p.idunidadmedida=u.idunidadmedida
INNER JOIN tiposprecios t on p.idtipoprecio=t.idtipoprecio
INNER JOIN monedas m on p.idmoneda=m.idmoneda
where p.idproducto=_idproducto and p.idtipoprecio=_idtipoprecio;
	
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_precioxidproductoxidtipoprecioxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_precioxidproductoxidtipoprecioxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_precioxidproductoxidtipoprecioxestado`(in _idproducto int(11),
in _idtipoprecio int(11))
begin

select 
p.idprecio,
p.idproducto,
pro.nombreproducto,
p.idunidadmedida,
u.sigla as usigla,
p.idtipoprecio,
t.sigla as tsigla,
p.idmoneda,
m.sigla as msigla,
p.precio,
p.estado
from precios p
INNER JOIN productos pro on p.idproducto=pro.idproducto
INNER JOIN unidadesmedida u on p.idunidadmedida=u.idunidadmedida
INNER JOIN tiposprecios t on p.idtipoprecio=t.idtipoprecio
INNER JOIN monedas m on p.idmoneda=m.idmoneda
where p.idproducto=_idproducto and p.idtipoprecio=_idtipoprecio and p.estado=1;
	
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_precioxidproductoxidtipoprecioxidunidadmedida
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_precioxidproductoxidtipoprecioxidunidadmedida`;
delimiter ;;
CREATE PROCEDURE `SP_listar_precioxidproductoxidtipoprecioxidunidadmedida`(in _idproducto int(11),
in _idtipoprecio int(11),
in _idunidadmedida int(11))
begin

select 
p.idprecio,
p.idproducto,
pro.nombreproducto,
p.idunidadmedida,
u.sigla as usigla,
p.idtipoprecio,
t.sigla as tsigla,
p.idmoneda,
m.sigla as msigla,
p.precio,
p.estado
from precios p
INNER JOIN productos pro on p.idproducto=pro.idproducto
INNER JOIN unidadesmedida u on p.idunidadmedida=u.idunidadmedida
INNER JOIN tiposprecios t on p.idtipoprecio=t.idtipoprecio
INNER JOIN monedas m on p.idmoneda=m.idmoneda
where p.idproducto=_idproducto and p.idtipoprecio=_idtipoprecio and p.idunidadmedia=_idunidadmedida;
	
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_precioxidproductoxidtipoprecioxidunidadmedidaxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_precioxidproductoxidtipoprecioxidunidadmedidaxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_precioxidproductoxidtipoprecioxidunidadmedidaxestado`(in _idproducto int(11),
in _idtipoprecio int(11),
in _idunidadmedida int(11))
begin

select 
p.idprecio,
p.idproducto,
pro.nombreproducto,
p.idunidadmedida,
u.sigla as usigla,
p.idtipoprecio,
t.sigla as tsigla,
p.idmoneda,
m.sigla as msigla,
p.precio,
p.estado
from precios p
INNER JOIN productos pro on p.idproducto=pro.idproducto
INNER JOIN unidadesmedida u on p.idunidadmedida=u.idunidadmedida
INNER JOIN tiposprecios t on p.idtipoprecio=t.idtipoprecio
INNER JOIN monedas m on p.idmoneda=m.idmoneda
where p.idproducto=_idproducto 
and p.idtipoprecio=_idtipoprecio 
and p.idunidadmedia=_idunidadmedida
and p.estado=1;
	
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_proveedor
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_proveedor`;
delimiter ;;
CREATE PROCEDURE `SP_listar_proveedor`()
begin

select 
p.idproveedor,
p.razonsocial,
p.idtipodocumentoidentidad,
t.nombredocumento,
t.sigla,
p.ndocumento,
p.direccion,
if(p.estado=1,'ACTIVO','NO ACTIVO') as estado
from proveedor p
INNER JOIN tiposdocumentoidentidad t on p.idtipodocumentoidentidad=t.idtipodocumentoidentidad;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_proveedorxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_proveedorxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_proveedorxestado`()
begin

select 
p.idproveedor,
p.razonsocial,
p.idtipodocumentoidentidad,
t.nombredocumento,
t.sigla,
p.ndocumento,
p.direccion,
p.estado
from proveedor p
INNER JOIN tiposdocumentoidentidad t on p.idtipodocumentoidentidad=t.idtipodocumentoidentidad
where p.estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_proveedorxndocumentoxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_proveedorxndocumentoxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_proveedorxndocumentoxestado`(in _ndocumento VARCHAR(255))
begin

select 
p.idproveedor,
p.razonsocial,
p.idtipodocumentoidentidad,
t.nombredocumento,
t.sigla,
p.ndocumento,
p.direccion,
p.estado
from proveedor p
INNER JOIN tiposdocumentoidentidad t on p.idtipodocumentoidentidad=t.idtipodocumentoidentidad
where p.ndocumento like concat('%',_ndocumento,'%') and p.estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_proveedorxrazonsocialxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_proveedorxrazonsocialxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_proveedorxrazonsocialxestado`(in _razonsocial VARCHAR(255))
begin

select 
p.idproveedor,
p.razonsocial,
p.idtipodocumentoidentidad,
t.nombredocumento,
t.sigla,
p.ndocumento,
p.direccion,
p.estado
from proveedor p
INNER JOIN tiposdocumentoidentidad t on p.idtipodocumentoidentidad=t.idtipodocumentoidentidad
where p.razonsocial like concat('%',_razonsocial,'%') and p.estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_serie
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_serie`;
delimiter ;;
CREATE PROCEDURE `SP_listar_serie`()
begin

select 
s.idserie,
s.idalmacen,
s.idtipocomprobante,
t.nombre,
t.sigla,
s.nserie,
s.inicio,
s.fin,
s.correlativo,
if(s.estado=1,'ACTIVO','NO ACTIVO') as estado
from serie s
INNER JOIN tiposcomprobantes t on s.idtipocomprobante=t.idtipocomprobante;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_seriexestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_seriexestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_seriexestado`()
begin

select 
s.idserie,
s.idalmacen,
s.idtipocomprobante,
t.nombre,
t.sigla,
s.nserie,
s.inicio,
s.fin,
s.correlativo,
s.estado
from serie s
INNER JOIN tiposcomprobantes t on s.idtipocomprobante=t.idtipocomprobante
where s.estado=1;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_seriexidtipocomprobantexestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_seriexidtipocomprobantexestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_seriexidtipocomprobantexestado`(in _idtipocomprobante int(11))
begin

select 
s.idserie,
s.idalmacen,
s.idtipocomprobante,
t.nombre,
t.sigla,
s.nserie,
s.inicio,
s.fin,
s.correlativo,
s.estado
from serie s
INNER JOIN tiposcomprobantes t on s.idtipocomprobante=t.idtipocomprobante
where s.idtipocomprobante and s.estado=1;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_sucursal
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_sucursal`;
delimiter ;;
CREATE PROCEDURE `SP_listar_sucursal`()
begin

select 
s.idsucursal,
s.idempresa,
e.razonsocial as erazonsocial,
s.razonsocial,
s.sede,
s.direccion,
s.telefono,
if(s.estado=1,'ACTIVO','NO ACTIVO') as estado
from sucursales s
INNER JOIN empresas e on s.idempresa=e.idempresa;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_sucursalxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_sucursalxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_sucursalxestado`()
begin

select 
s.idsucursal,
s.idempresa,
e.razonsocial as erazonsocial,
s.razonsocial,
s.sede,
s.direccion,
s.telefono,
s.estado
from sucursales s
INNER JOIN empresas e on s.idempresa=e.idempresa
where s.estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_sucursalxidempresaxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_sucursalxidempresaxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_sucursalxidempresaxestado`(in _idempresa int(11))
begin

select 
s.idsucursal,
s.idempresa,
e.razonsocial as erazonsocial,
s.razonsocial,
s.sede,
s.direccion,
s.telefono,
s.estado
from sucursales s
INNER JOIN empresas e on s.idempresa=e.idempresa
where s.idempresa=_idempresa and  s.estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_sucursalxidsucursalxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_sucursalxidsucursalxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_sucursalxidsucursalxestado`(in _idsucursal int(11))
begin

select 
s.idsucursal,
s.idempresa,
e.razonsocial as erazonsocial,
s.razonsocial,
s.sede,
s.direccion,
s.telefono,
s.estado
from sucursales s
INNER JOIN empresas e on s.idempresa=e.idempresa
where s.idsucursal=_idsucursal and  s.estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_telefono
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_telefono`;
delimiter ;;
CREATE PROCEDURE `SP_listar_telefono`()
begin

select 
t.idtelefono,
t.idpersona,
p.apellidopaterno,
p.apellidomaterno,
p.nombre,
t.numerotelefono,
if(t.estado=1,'ACTIVO','NO ACTIVO') as estado
from telefono t
INNER JOIN persona p on t.idpersona=p.idpersona;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_telefonoxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_telefonoxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_telefonoxestado`()
begin

select 
t.idtelefono,
t.idpersona,
p.apellidopaterno,
p.apellidomaterno,
p.nombre,
t.numerotelefono,
t.estado
from telefono t
INNER JOIN persona p on t.idpersona=p.idpersona
where t.estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_telefonoxidpersonaxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_telefonoxidpersonaxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_telefonoxidpersonaxestado`(in _idpersona int(11))
begin

select 
t.idtelefono,
t.idpersona,
p.apellidopaterno,
p.apellidomaterno,
p.nombre,
t.numerotelefono,
t.estado
from telefono t
INNER JOIN persona p on t.idpersona=p.idpersona
where t.idpersona=_idpersona and t.estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_telefonoxidtelefonoxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_telefonoxidtelefonoxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_telefonoxidtelefonoxestado`(in _idtelefono int(11))
begin

select 
t.idtelefono,
t.idpersona,
p.apellidopaterno,
p.apellidomaterno,
p.nombre,
t.numerotelefono,
t.estado
from telefono t
INNER JOIN persona p on t.idpersona=p.idpersona
where t.idtelefono=_idtelefono and t.estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_tipocomprobante
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_tipocomprobante`;
delimiter ;;
CREATE PROCEDURE `SP_listar_tipocomprobante`()
begin

select 
idtipocomprobante,
nombre,
sigla,
if(estado=1,'ACTIVO','NO ACTIVO') as estado;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_tipocomprobantexestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_tipocomprobantexestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_tipocomprobantexestado`()
begin

select 
idtipocomprobante,
nombre,
sigla,
estado
from tiposcomprobantes
where estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_tipocomprobantexidtipocomprobantexestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_tipocomprobantexidtipocomprobantexestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_tipocomprobantexidtipocomprobantexestado`(in _idtipocomprobante int(11))
begin

select 
idtipocomprobante,
nombre,
sigla,
estado
from tiposcomprobantes
where idtipocomprobante=_idtipocomprobante and estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_tipodocumentoidentidad
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_tipodocumentoidentidad`;
delimiter ;;
CREATE PROCEDURE `SP_listar_tipodocumentoidentidad`()
begin

select 
idtipodocumentoidentidad,
nombredocumento,
sigla,
longitud,
if(estado=1,'ACTIVO','NO ACTIVO') as estado
from tiposdocumentoidentidad;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_tipodocumentoidentidadxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_tipodocumentoidentidadxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_tipodocumentoidentidadxestado`()
begin

select 
idtipodocumentoidentidad,
nombredocumento,
sigla,
longitud,
estado
from tiposdocumentoidentidad
where estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_tipomovimiento
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_tipomovimiento`;
delimiter ;;
CREATE PROCEDURE `SP_listar_tipomovimiento`()
begin 

select 
idtipomovimiento,
nombre,
sigla,
if(estado=1,'ACTIVO','NO ACTIVO') as estado
from tiposmovimientos;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_tipomovimientoxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_tipomovimientoxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_tipomovimientoxestado`()
begin 

select 
idtipomovimiento,
nombre,
sigla,
estado
from tiposmovimientos
where estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_tipoprecio
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_tipoprecio`;
delimiter ;;
CREATE PROCEDURE `SP_listar_tipoprecio`()
begin

select 
idprecio,
nombre,
sigla,
if(estado=1,'ACTIVO','NO ACTIVO') as estado
from tiposprecios;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_tipoprecioxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_tipoprecioxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_tipoprecioxestado`()
begin

select 
idprecio,
nombre,
sigla,
estado
from tiposprecios
where estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_transaccion
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_transaccion`;
delimiter ;;
CREATE PROCEDURE `SP_listar_transaccion`()
begin

select 
idtransaccion,
nombre,
sigla,
if(estado=1,'ACTIVO','NO ACTIVO')  as estado
from transacciones;


end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_transaccionxestado
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_transaccionxestado`;
delimiter ;;
CREATE PROCEDURE `SP_listar_transaccionxestado`()
begin

select 
idtransaccion,
nombre,
sigla,
estado
from transacciones
where estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_transaccionxestadoxidtransaccion
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_transaccionxestadoxidtransaccion`;
delimiter ;;
CREATE PROCEDURE `SP_listar_transaccionxestadoxidtransaccion`(in _idtransaccion int(11))
begin

select 
idtransaccion,
nombre,
sigla,
estado
from transacciones
where idtransaccion=_idtransaccion and estado=1;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_listar_unidadmedida
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_listar_unidadmedida`;
delimiter ;;
CREATE PROCEDURE `SP_listar_unidadmedida`()
begin
select
idunidadmedida,
nombre,
sigla,
if(estado=1,'ACTIVO','NO ACTIVO') as estado
from unidadesmedida;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registar_almacen
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registar_almacen`;
delimiter ;;
CREATE PROCEDURE `SP_registar_almacen`(in _idsucursal int(11),
in _nombre VARCHAR(255),
in _direccion VARCHAR(255),
in _telefono VARCHAR(255),
in _idpersona int(11))
begin 

declare _id int(11) default 0;

insert into almacenes(
idsucursal,
nombre,
direccion,
telefono,
estado,
fecharegistro
)
values(
_idsucursal,
_nombre,
_direccion,
_telefono,
1,
NOW()
);

set _id=(SELECT LAST_INSERT_ID());

call SP_registrar_auditoria(1,_id,"ALMACENES",_idpersona);

select _id as _id;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_auditoria
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_auditoria`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_auditoria`(in _idoperacion int(11),
in _idtabla int(11),
in _tabla VARCHAR(255),
in _idpersona int(11))
begin

insert into auditoria(
idoperacion,
idtabla,
tabla,
idpersona,
fecharegistro
)
VALUEs(
_idoperacion,
_idtabla,
_tabla,
_idpersona,
NOW()
);
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_categoria
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_categoria`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_categoria`(in _nombre VARCHAR(255),
in _sigla VARCHAR(255),
in _idpersona int(11))
begin

declare _id int(11) DEFAULT 0;

INSERT into categorias(
nombre,
sigla,
estado,
fecharegistro
)
VALUES(
_nombre,
_sigla,
1,
NOW()
);

set _id =(SELECT LAST_INSERT_ID());

call SP_registrar_auditoria(1,_id,"CATEGORIAS",_idpersona);

select _id as _id;


end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_direccion
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_direccion`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_direccion`(in _idpersona int(11),
in _ubicacion VARCHAR(255),
in _referencia VARCHAR(255),
in _idpersonar int(11))
begin

declare _id int(11) default 0;

insert into direcciones(
idpersona,
ubicacion,
referencia,
estado,
fecharegistro
)values(
_idpersona,
_ubicacion,
_referencia,
1,
NOW()
);

set _id=(select LAST_INSERT_ID());

call SP_registrar_auditoria(1,_id,"DIRECCIONES",_idpersonar);

select _id as _id;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_empresa
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_empresa`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_empresa`(in _razonsocial VARCHAR(255),
in _idtipodocumentoidentidad int(11),
in _ruc VARCHAR(255),
in _direccion VARCHAR(255),
in _telefono VARCHAR(255),
in _idpersona int(11))
begin

declare _existeempresa int(11) default 0;
declare _id int(11) default 0;

set _existeempresa=(
select count(idempresa)
from empresas
where ruc=_ruc
);

if(_existeempresa=0)then

insert into empresas(
razonsocial,
idtipodocumentoidentidad,
ruc,
direccion,
telefono,
estado,
fecharegistro
)
VALUES(
_razonsocial,
_idtipodocumentoidentidad,
_ruc,
_direccion,
_telefono,
1,
NOW()
);

set _id=(select LAST_INSERT_ID());

call SP_registrar_auditoria(1,_id,"EMPRESAS",_idpersona);

else

set _id=-1;

end if;


select _id as _id;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_moneda
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_moneda`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_moneda`(in _nombre VARCHAR(255),
in _sigla VARCHAR(255),
in _idpersona int(11))
begin

declare _existemoneda int(11) default 0;
declare _id int(11) DEFAULT 0;

set _existemoneda=(
select count(idmoneda)
from monedas
where sigla=_sigla
);

if(_existemoneda=0)then

insert INTO monedas(
nombre,
sigla,
estado,
fecharegistro
)
VALUES(
_nombre,
_sigla,
1,
NOW()
);

set _id=(select LAST_INSERT_ID());

call SP_registrar_auditoria(1,_id,"MONEDA",_idpersona);

else

set _id=-1;

end if;

select _id as _id;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_persona
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_persona`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_persona`(in _idperfil int(11),
in _apellidopaterno VARCHAR(255),
in _apellidomaterno VARCHAR(255),
in _nombre VARCHAR(255),
in _idtipodocumentoidentidad int(11),
in _ndocumento VARCHAR(255),
in _cuenta VARCHAR(255),
in _clave VARCHAR(255),
in _idpersonareg int(11))
begin

declare _id int(11) default -1;
declare _idpersonaperfil int(11) default -1;
declare _existendocumento int(11) default 0;

set _existendocumento=(
select COUNT(idpersona)
from persona
where ndocumento=_existendocumento
);

if(_existendocumento=0)then

	insert into persona(
	idperfil,
	apellidopaterno,
	apellidomaterno,
	nombre,
	idtipodocuentoidentidad,
	ndocumento,
	estado,
	fecharegistro
	)
	values(
	_idperfil,
	_apellidopaterno,
	_apellidomaterno,
	_nombre,
	_idtipodocumentoidentidad,
	_ndocumento,
	1,
	NOW()
	);
	
	set _id=(SELECT LAST_INSERT_ID());
	
	if(_idpersonareg=0)then 
		set _idpersonareg=_id ; 
	end if;
	
	call SP_registrar_auditoria(1,_id,"PERSONA",_idpersonareg);
	
	insert into personasperfiles(
		idpersona,
		idperfil,
		cuenta,
		clave,
		estado,
		fecharegistro
	)values(
		_id,
		_idperfil,
		_cuenta,
		_clave,
		1,
		NOW()
	);
	
	set _idpersonaperfil=(SELECT LAST_INSERT_ID());
	call SP_registrar_auditoria(1,_idpersonaperfil,"PERSONASPERFILES",_idpersonareg);
	
else

	set _id=-2;#ndocumento ya existe;
	
end if;


select _id as _id;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_personasperfiles
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_personasperfiles`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_personasperfiles`(in _idpersona int(11),
in _idperfil int(11),
in _cuenta VARCHAR(255),
in _clave VARCHAR(255),
in _idpersonaact int(11))
begin 

declare _id int(11) default 0;
declare _cuentaexiste int(11) DEFAULT 0;

set _cuentaexiste=(
select count(idpersonaperfil)
from personasperfiles
where cuenta=_cuenta and idpersona=_idpersona and idperfil=_idperfil);


if(_cuentaexiste=0)then

	insert into personasperfiles(
		idpersona,
		idperfil,
		cuenta,
		clave,
		estado,
		fecharegistro
	)values(
		_idpersona,
		_idperfil,
		_cuenta,
		_clave,
		1,
		NOW()
	);

	SET _id=(SELECT LAST_INSERT_ID());

	call SP_registrar_auditoria(1,_id,"PERSONASPERFILES",_idpersonaact);
	
	
else

set _id=-1;

end if;

select _id as _id;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_precio
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_precio`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_precio`(in _idproducto int(11),
in _idunidadmedida int(11),
in _idtipoprecio int(11),
in _idmoneda int(11),
in _precio decimal(10,4),
in _idpersona int(11))
begin

declare _unidadmedidaexiste int(11) DEFAULT 0;
declare _id int(11) default 0;

set _unidadmedidaexiste=(
select COUNT(idprecio)
from precios 
where idproducto=_idproducto
and idunidadmedida=_idunidadmedida
and idmoneda=_idmoneda
);

if(_unidadmedidaexiste=0)then

	insert into precios(
		idproducto,
		idunidadmedida,
		idtipoprecio,
		idmoneda,
		precio,
		estado,
		fecharegistro
	)
	values(
		_idproducto,
		_idunidadmedida,
		_idtipoprecio,
		_idmoneda,
		_precio,
		1,
		NOW()
	);
	
	set _id=(SELECT LAST_INSERT_ID());
	
	call registrar_auditoria(1,_id,"PRECIOS",_idpersona);

	
else

	set _id=-1;
	
end if;

select _id as _id;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_producto
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_producto`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_producto`(in _idcategoria int(11),
in _nombreproducto VARCHAR(255),
in _descripcion VARCHAR(255),
in _idunidadmedida int(11),
in _idpersona int(11))
begin

declare _id int(11) DEFAULT 0;

insert INTO productos(
idcategoria,
nombreproducto,
descripcion,
estado,
fecharegistro
)
VALUEs(
_idcategoria,
_nombreproducto,
_descripcion,
1,
NOW()
);

set _id=(SELECT LAST_INSERT_ID());

call SP_registrar_auditoria(1,_id,"PRODUCTOS",_idpersona);

insert into unidadesquivalentes(
idtipounidad,
idproducto,
idunidadequivale,
factor,
idunidadmedida,
estado,
fecharegistro
)
values(
1,
_id,
_idunidadmedida,
1,
_idunidadmedida,
1,
NOW()
);

call SP_registrar_auditoria(1,_id,"UNIDADEQUIVALENTES",_idpersona);

select _id as _id;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_proveedor
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_proveedor`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_proveedor`(in _razonsocial VARCHAR(255),
in _idtipodocumentoidentidad int(11),
in _ndocumento VARCHAR(255),
in _direccion VARCHAR(255),
in _idpersona int(11))
begin

declare _existendocumento int(11);
declare _id int(11) default 0;

set _existendocumento=(
select COUNT(idproveedor)
from proveedor
where ndocumento=_ndocumento
);

if(_existendocumento=0)then

insert into proveedor(
razonsocial,
idtipodocumentoidentidad,
ndocumento,
direccion,
estado,
fecharegistro
)values(
_razonsocial,
_idtipodocumentoidentidad,
_ndocumento,
_direccion,
1,
NOW()
);

set _id=(select LAST_INSERT_ID());

call SP_registrar_auditoria(1,_id,"PROVEEDOR",_idpersona);	

else

set _id=-1;

end if;

select _id as _id;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_serie
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_serie`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_serie`(in _idalmacen int(11),
in _idtipocomprobante int(11),
in _nserie VARCHAR(255),
in _inicio int(11),
in _fin int(11),
in _correlativo int(11),
in _idpersona int(11))
begin 

declare _existeserie int(11) DEFAULT 0;
declare _id int(11) default 0;

set _existeserie=(
select count(idserie)
from series
where nserie=_nserie and idalmacen=_idalmacen
);

if(_existeserie=0)then

insert into series(
idalmacen,
idtipocomprobante,
nserie,
inicio,
fin,
correlativo,
estado,
fecharegistro
)VALUES(
_idalmacen,
_idtipocomprobante,
_nserie,
_inicio,
_fin,
1,
NOW()
);

set _id=(select LAST_INSERT_ID());

call SP_registrar_auditoria(1,_id,"SERIES",_idpersona);

else

set _id=-1;

end if;

select _id as _id;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_sucursal
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_sucursal`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_sucursal`(in _idempresa int(11),
in _razonsocial VARCHAR(255),
in _sede VARCHAR(255),
in _direccion VARCHAR(255),
in _telefono VARCHAR(255),
in _idpersona int(11))
begin 

declare _id int(11) DEFAULT 0;

insert into sucursales(
idempresa,
razonsocial,
sede,
direccion,
telefono,
estado,
fecharegistro
)values(
_idempresa,
_razonsocial,
_sede,
_direccion,
_telefono,
1,
NOW()
);

set _id=(SELECT LAST_INSERT_ID());

call SP_registrar_auditoria(1,_id,"SUCURSALES",_idpersona);

select _id as _id;


end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_telefono
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_telefono`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_telefono`(in _idpersona int(11),
in _numerotelefono VARCHAR(255),
in _idpersonar int(11))
begin

declare _existenumerotelefono int(11);
declare _id int(11);


set _existenumerotelefono=(
select count(idtelefono)
from telefonos
where numerotelefono=_numerotelefono
);

if(_existenumerotelefono=0)then

insert into telefonos(
idpersona,
numerotelefono,
estado,
fecharegistro
)values(
_idpersona,
_numerotelefono,
1,
NOW()
);

set _id=(select LAST_INSERT_ID());

call SP_registrar_auditoria(1,_id,"TELEFONOS",_idpersonar);

else

set _id=-1;

end if ;

select _id as _id;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_tipocomprobante
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_tipocomprobante`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_tipocomprobante`(in _nombre VARCHAR(255),
in _sigla VARCHAR(255),
in _idpersona int(11))
begin 

declare _existesigla int(11) default 0;
declare _id int(11) default 0;	

set _existesigla=(
select count(idtipocomprobante)
from tiposcomprobantes
where sigla=_sigla
);

if(_existesigla=0)then

insert into tiposcomprobantes(
nombre,
sigla,
estado,
fecharegistro
)VALUES(
_nombre,
_sigla,
1,
NOW()
);

set _id=(select LAST_INSERT_ID());

call SP_registrar_auditoria(1,_id,"TIPOSCOMPROBANTES",_idpersona);

else

set _id=-1;

end if;

select _id as _id;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_tipodocumentoidentidad
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_tipodocumentoidentidad`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_tipodocumentoidentidad`(in _nombredocumento VARCHAR(255),
in _sigla VARCHAR(255),
in _longitud int(11),
in _idpersona int(11))
begin

declare _siglaexiste int(11) default 0;
declare _id int(11) default 0;

set _siglaexiste=(
select count(idtipodocumentoidentidad)
from tiposdocumentoidentidad
where sigla=_sigla
);

if(_siglaexiste=0)then

	insert into tiposdocumentoidentidad(
	nombredocumento,
	sigla,
	longitud,
	estado,
	fecharegistro
	)values(
	_nombredocumento,
	_sigla,
	_longitud,
	1,
	NOW()
	);

	set _id=(select LAST_INSERT_ID());

	call SP_registrar_auditoria(1,_id,"TIPOSDOCUMENTOIDENTIDAD",_idpersona);
	
else

	set _id=-1;

end if;

select _id as _id;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_transaccion
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_transaccion`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_transaccion`(in _nombre VARCHAR(255),
in _sigla VARCHAR(255),
in _idpersona int(11))
begin

declare _siglaexiste int(11) default 0;
declare _id int(11) default 0;

set _siglaexiste=(
select ifnull(idtransaccion,0)
from transacciones
where sigla=_idsigla
);

if(_siglaexiste=0)then

	insert into transacciones(
		nombre,
		sigla,
		estado,
		fecharegistro
	)VALUES(
		_nombre,
		_sigla,
		1,
		NOW()
	);
	
	
	set _id=(select LAST_INSERT_ID());
	
	call SP_registrar_auditoria(1,_id,"TRANSACCIONES",_idpersona);

else

set _id=-1;

end if;

select _id as _id;

end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_registrar_unidadmedida
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_registrar_unidadmedida`;
delimiter ;;
CREATE PROCEDURE `SP_registrar_unidadmedida`(in _nombre VARCHAR(255),
in _sigla VARCHAR(255),
in _idpersona int(11))
begin

declare _id int(11) DEFAULT 0;
declare _existesigla int(11) DEFAULT 0;

set _existesigla=(SELECT count(idunidadmedida)
from unidadmedida 
where sigla=_sigla
);

if(_existesigla=0)then

	insert INTO unidadesmedida(
	nombre,
	sigla,
	estado,
	fecharegistro
	)
	values(
	_nombre,
	_sigla,
	1,
	NOW()
	);

	set _id=(SELECT LAST_INSERT_ID());
	
	call SP_registrar_auditoria(1, _id, "UNIDADESMEDIDA", _idpersona);

else
	
	set _id= -1;
	
end if;

select _id as _id;

end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
