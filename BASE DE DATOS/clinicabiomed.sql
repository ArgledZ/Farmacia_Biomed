-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-06-2022 a las 00:54:35
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `clinicabiomed`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `identificarEmpleado` (IN `user` CHAR(20), IN `pass` CHAR(20))   select P.id_persona,P.Nom_persona,P.Ape_persona,P.numero_identificacion,
E.Id_cargo,E.Id_estadoempleado,E.Usuario,E.Clave
from Empleado E INNER JOIN persona P ON E.Id_persona=P.Id_persona where E.Usuario=user and E.Clave=pass$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerporid` (IN `dn` INT(11))   SELECT P.id_persona,P.Nom_persona,P.Ape_persona,P.Id_tipo_documento,P.numero_identificacion,P.edad_persona,P.Nacionalidad_persona,P.Empresa_persona,P.Correo_persona,P.Telf_persona,P.Fecha_naci_persona,P.Dir_persona,P.Sex_persona,P.eliminado,
E.Id_cargo,E.Id_estadoempleado,E.Usuario,E.Clave,C.des_cargo,ES.des_estadoempleado,TD.Des_tipo_documento
 FROM empleado E 
 INNER JOIN persona P ON E.Id_persona=P.Id_persona 
 INNER JOIN tipo_documento TD ON P.Id_tipo_documento=TD.Id_tipo_documento 
 INNER JOIN cargo C ON E.Id_cargo=C.Id_cargo 
 INNER JOIN estado_empleado ES ON E.Id_estadoempleado=ES.Id_estadoempleado 
 WHERE P.id_persona=dn$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pabuscarcliente` (IN `dn` VARCHAR(20))   SELECT P.id_persona,P.Nom_persona,P.Ape_persona,P.Id_tipo_documento,P.numero_identificacion,P.edad_persona,P.Nacionalidad_persona,P.Empresa_persona,P.Correo_persona,P.Telf_persona,P.Fecha_naci_persona,P.Dir_persona,P.Sex_persona,P.eliminado,C.Fec_regis_cliente,C.Puntos,TD.Des_tipo_documento
 FROM cliente C 
 INNER JOIN persona P ON C.Id_persona=P.Id_persona 
 INNER JOIN tipo_documento TD ON P.Id_tipo_documento=TD.Id_tipo_documento 
 WHERE P.numero_identificacion LIKE CONCAT('%', dn , '%') OR  P.Ape_persona LIKE CONCAT('%', dn , '%') AND P.eliminado=0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pabuscarempleado` (IN `dn` VARCHAR(20))   SELECT P.id_persona,P.Nom_persona,P.Ape_persona,P.Id_tipo_documento,P.numero_identificacion,P.edad_persona,P.Nacionalidad_persona,P.Empresa_persona,P.Correo_persona,P.Telf_persona,P.Fecha_naci_persona,P.Dir_persona,P.Sex_persona,P.eliminado,
E.Id_cargo,E.Id_estadoempleado,E.Usuario,E.Clave,C.des_cargo,ES.des_estadoempleado,TD.Des_tipo_documento
 FROM empleado E 
 INNER JOIN persona P ON E.Id_persona=P.Id_persona 
 INNER JOIN tipo_documento TD ON P.Id_tipo_documento=TD.Id_tipo_documento 
 INNER JOIN cargo C ON E.Id_cargo=C.Id_cargo 
 INNER JOIN estado_empleado ES ON E.Id_estadoempleado=ES.Id_estadoempleado 
 WHERE P.numero_identificacion LIKE CONCAT('%', dn , '%') OR  P.Ape_persona LIKE CONCAT('%', dn , '%') AND P.eliminado=0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pabuscarproducto` (IN `dn` VARCHAR(20))   BEGIN
SELECT L.id_lote,L.stock,L.Fecha_vencimiento,PR.Id_persona,PR.Nom_persona AS nomproveedor,P.Id_producto,P.Reg_sanitario,P.Nombre_producto,P.Precio_compra,P.Precio_venta,P.Concentracion_producto,P.eliminado,C.Id_Categoria,C.Des_categoria
FROM lote L
INNER JOIN producto P ON l.Id_producto=p.Id_producto
INNER JOIN categoria C ON P.Id_Categoria=C.Id_Categoria 
INNER JOIN persona PR ON l.Id_persona=PR.Id_persona
WHERE P.Nombre_producto LIKE CONCAT('%', dn , '%') AND P.eliminado=0 AND L.lote_eliminado=0  OR P.Concentracion_producto LIKE CONCAT('%', dn , '%') AND P.eliminado=0 AND L.lote_eliminado=0;
update lote set lote_eliminado=1 where stock=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `paeliminarpersona` (IN `cod_persona` INT(3), IN `valor` INT(1))   update Persona set eliminado=valor
 where Id_persona=cod_persona$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `paeliminarproducto` (IN `cod_producto` INT(3), IN `valor` INT(1))   update producto set eliminado=valor
 where Id_producto=cod_producto$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `painsertarcliente` (IN `Nom` VARCHAR(80), IN `Ape` VARCHAR(80), IN `id_tipodoc` INT(3), IN `numiden` CHAR(20), IN `edadp` VARCHAR(20), IN `naciona` CHAR(30), IN `empre` CHAR(50), IN `email` CHAR(50), IN `telf` CHAR(20), IN `direc` VARCHAR(100), IN `sexo` CHAR(1))   BEGIN
insert into persona (Nom_persona,Ape_persona,Id_tipo_documento,Numero_identificacion,Fecha_naci_persona,Nacionalidad_persona,Empresa_persona,Correo_persona,Telf_persona,Dir_persona,Sex_persona) values (Nom,Ape,id_tipodoc,numiden,edadp,naciona,empre,email,telf,direc,sexo);
 SET @ultimoID = (SELECT MAX(Id_persona) FROM persona);
insert into cliente (Id_persona,Fec_regis_cliente) values (@ultimoID, CURDATE());
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `painsertarempleado` (IN `Nom` VARCHAR(80), IN `Ape` VARCHAR(80), IN `id_tipodoc` INT(3), IN `numiden` CHAR(20), IN `edadp` VARCHAR(20), IN `naciona` CHAR(30), IN `empre` CHAR(50), IN `email` CHAR(50), IN `telf` CHAR(20), IN `direc` VARCHAR(100), IN `sexo` CHAR(1), IN `cargo` INT(3), IN `estadoem` INT(3), IN `usu` CHAR(20), IN `pass` CHAR(20))   BEGIN
insert into persona (Nom_persona,Ape_persona,Id_tipo_documento,Numero_identificacion,Fecha_naci_persona,Nacionalidad_persona,Empresa_persona,Correo_persona,Telf_persona,Dir_persona,Sex_persona) values (Nom,Ape,id_tipodoc,numiden,edadp,naciona,empre,email,telf,direc,sexo);
 SET @ultimoID = (SELECT MAX(Id_persona) FROM persona);
insert into empleado (Id_persona,Id_cargo,Id_estadoempleado,Usuario,Clave) values (@ultimoID,cargo,estadoem,usu,pass);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `painsertarnuevolote` (IN `proid` INT(11), IN `stk` INT(3), IN `proveid` INT(3), IN `fven` DATE)   BEGIN
insert into lote (Id_producto,stock,id_persona,Fecha_vencimiento) values (proid, stk,proveid,fven);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `painsertarproducto` (IN `cat` INT(3), IN `re` VARCHAR(50), IN `nom` CHAR(80), IN `prec` DECIMAL(12,2), IN `preve` DECIMAL(12,2), IN `conce` CHAR(50), IN `stk` INT(3), IN `proveid` INT(3), IN `fven` DATE)   BEGIN
insert into producto (Id_categoria,Reg_sanitario,Nombre_producto,Precio_compra,Precio_venta,Concentracion_producto) values (cat,re,nom,prec,preve,conce);
SET @ultimoID = (SELECT MAX(Id_producto) FROM producto);
insert into lote (Id_producto,stock,id_persona,Fecha_vencimiento) values (@ultimoID, stk,proveid,fven);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `palistarcargo` ()   select * from cargo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `palistarcategoria` ()   select * from categoria$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `palistarcliente` ()   SELECT P.id_persona,P.Nom_persona,P.Ape_persona,P.Id_tipo_documento,P.numero_identificacion,P.edad_persona,P.Nacionalidad_persona,P.Empresa_persona,P.Correo_persona,P.Telf_persona,P.Fecha_naci_persona,P.Dir_persona,P.Sex_persona,C.Fec_regis_cliente,C.Puntos,TD.Des_tipo_documento
 FROM cliente C 
 INNER JOIN persona P ON C.Id_persona=P.Id_persona 
 INNER JOIN tipo_documento TD ON P.Id_tipo_documento=TD.Id_tipo_documento 
 WHERE P.eliminado=0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `palistarempleado` ()   SELECT P.id_persona,P.Nom_persona,P.Ape_persona,P.Id_tipo_documento,P.numero_identificacion,P.edad_persona,P.Nacionalidad_persona,P.Empresa_persona,P.Correo_persona,P.Telf_persona,P.Fecha_naci_persona,P.Dir_persona,P.Sex_persona,
E.Id_cargo,E.Id_estadoempleado,E.Usuario,E.Clave,C.des_cargo,ES.des_estadoempleado,TD.Des_tipo_documento
 FROM empleado E 
 INNER JOIN persona P ON E.Id_persona=P.Id_persona 
 INNER JOIN tipo_documento TD ON P.Id_tipo_documento=TD.Id_tipo_documento 
 INNER JOIN cargo C ON E.Id_cargo=C.Id_cargo 
 INNER JOIN estado_empleado ES ON E.Id_estadoempleado=ES.Id_estadoempleado 
 WHERE P.eliminado=0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `palistarestadoempleado` ()   select * from estado_empleado$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `palistarlote` ()   BEGIN
SELECT L.id_lote,L.stock,L.Fecha_vencimiento,PR.Id_persona,PR.Nom_persona AS nomproveedor,P.Id_producto,P.Reg_sanitario,P.Nombre_producto,P.Precio_compra,P.Precio_venta,P.Concentracion_producto,P.eliminado,C.Id_Categoria,C.Des_categoria
FROM lote L
INNER JOIN producto P ON l.Id_producto=p.Id_producto
INNER JOIN categoria C ON P.Id_Categoria=C.Id_Categoria 
INNER JOIN persona PR ON l.id_persona=PR.Id_persona
WHERE P.eliminado=0;
update lote set lote_eliminado=1 where stock=0;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `palistarproducto` ()   SELECT P.Id_producto,P.Reg_sanitario,P.Nombre_producto,P.Precio_compra,P.Precio_venta,P.Concentracion_producto,P.eliminado,C.Id_Categoria,C.Des_categoria
FROM producto P
INNER JOIN categoria C ON P.Id_Categoria=C.Id_Categoria 
WHERE P.eliminado=0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `palistarproveedor` ()   SELECT P.id_persona,P.Nom_persona,P.Ape_persona,P.Id_tipo_documento,TD.Des_tipo_documento,P.numero_identificacion,P.edad_persona,P.Nacionalidad_persona,P.Empresa_persona,P.Correo_persona,P.Telf_persona,P.Fecha_naci_persona,P.Dir_persona,P.Sex_persona,PR.Observacion
 FROM proveedor PR 
 INNER JOIN persona P ON PR.Id_persona=P.Id_persona
INNER JOIN tipo_documento TD ON P.Id_tipo_documento=TD.Id_tipo_documento
 WHERE P.eliminado=0$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `palistartipodocumento` ()   select * from tipo_documento$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pamodificarcliente` (IN `cod` INT(3), IN `Nom` VARCHAR(80), IN `Ape` VARCHAR(80), IN `id_tipodoc` INT(3), IN `numiden` CHAR(20), IN `edadp` CHAR(3), IN `naciona` CHAR(30), IN `empre` CHAR(50), IN `email` CHAR(50), IN `telf` CHAR(20), IN `direc` VARCHAR(100), IN `sexo` CHAR(1))   BEGIN

update persona set Nom_persona=Nom,Ape_persona=Ape,Id_tipo_documento=id_tipodoc,Numero_identificacion=numiden,Edad_persona=edadp,Nacionalidad_persona=naciona,Empresa_persona=empre,Correo_persona=Email,Telf_persona=telf,Dir_persona=direc,Sex_persona=sexo
where Id_persona=cod;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pamodificarempleado` (IN `cod` INT(3), IN `Nom` VARCHAR(80), IN `Ape` VARCHAR(80), IN `id_tipodoc` INT(3), IN `numiden` CHAR(20), IN `edadp` VARCHAR(20), IN `naciona` CHAR(30), IN `empre` CHAR(50), IN `email` CHAR(50), IN `telf` CHAR(20), IN `direc` VARCHAR(100), IN `sexo` CHAR(1), IN `cargo` INT(3), IN `estadoem` INT(3), IN `usu` CHAR(20), IN `pass` CHAR(20))   BEGIN

update persona set Nom_persona=Nom,Ape_persona=Ape,Id_tipo_documento=id_tipodoc,Numero_identificacion=numiden,Fecha_naci_persona=edadp,Nacionalidad_persona=naciona,Empresa_persona=empre,Correo_persona=Email,Telf_persona=telf,Dir_persona=direc,Sex_persona=sexo
where Id_persona=cod;
update empleado set Id_cargo=cargo,Id_estadoempleado=estadoem,Usuario=usu,Clave=pass
where Id_persona=cod ;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pamodificarproducto` (IN `cod` INT(3), IN `cat` INT(3), IN `re` VARCHAR(50), IN `nom` CHAR(80), IN `prec` DECIMAL(12,3), IN `preve` DECIMAL(12,2), IN `conce` CHAR(50), IN `cantstock` INT(3), IN `proveid` INT(3), IN `fven` DATE, IN `codlote` INT(3))   BEGIN

update producto set Id_categoria=cat,Reg_sanitario=re,Nombre_producto=nom,Precio_compra=prec,Precio_venta=preve,Concentracion_producto=conce
where Id_producto=cod;
update lote set stock=cantstock,id_persona=proveid,Fecha_vencimiento=fven
where Id_lote=codlote;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bitacora`
--

CREATE TABLE `bitacora` (
  `Id_bitacora` int(6) NOT NULL,
  `tabla` char(30) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `ejecutor` varchar(20) NOT NULL,
  `actividad_realizada` varchar(50) NOT NULL,
  `informacion_actual` text DEFAULT NULL,
  `informacion_anterior` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `bitacora`
--

INSERT INTO `bitacora` (`Id_bitacora`, `tabla`, `fecha`, `ejecutor`, `actividad_realizada`, `informacion_actual`, `informacion_anterior`) VALUES
(1, '0', '2022-04-25 02:20:37', 'root@localhost', 'Se inserto nuevo cargo', 'Informacion actual:aaaaa', NULL),
(2, 'CARGO', '2022-04-25 02:26:42', 'root@localhost', 'Se inserto nuevo cargo', 'Informacion actual:BE', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

CREATE TABLE `cargo` (
  `Id_cargo` int(3) NOT NULL,
  `des_cargo` char(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cargo`
--

INSERT INTO `cargo` (`Id_cargo`, `des_cargo`) VALUES
(1, 'Gerente'),
(2, 'Farmaceutico');

--
-- Disparadores `cargo`
--
DELIMITER $$
CREATE TRIGGER `Insertacargo` AFTER INSERT ON `cargo` FOR EACH ROW BEGIN
INSERT INTO
bitacora(tabla,ejecutor,actividad_realizada,informacion_actual)VALUES("CARGO",CURRENT_USER,"Se inserto nuevo cargo",concat("Informacion actual:",NEW.des_cargo));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `Id_Categoria` int(3) NOT NULL,
  `Des_categoria` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`Id_Categoria`, `Des_categoria`) VALUES
(1, 'Jarabes'),
(2, 'Analgesicos'),
(3, 'Otros'),
(4, 'Tabletas'),
(5, 'Capsulas'),
(6, 'Ampollas'),
(7, 'Crema'),
(8, 'Gotas'),
(9, 'Sobres'),
(11, 'Spray'),
(12, 'Comprimidos'),
(13, 'Ovulos'),
(15, 'AMPULAS'),
(16, 'SUSPENSION'),
(17, 'FRASCO'),
(18, 'PROCEDIMIENTOS'),
(19, 'AEROSOL'),
(20, 'inhalador'),
(22, 'ranitidina'),
(23, 'GRAGEAS'),
(24, 'TAB. EFERVESCENTES'),
(26, 'POLVO PARA SOL. INYECTABLE'),
(27, 'SOLUCION INYECTABLE'),
(28, 'JALEA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `Id_persona` int(11) NOT NULL,
  `Fec_regis_cliente` date NOT NULL,
  `Puntos` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`Id_persona`, `Fec_regis_cliente`, `Puntos`) VALUES
(1, '2022-05-24', 0),
(2, '2022-05-24', 0),
(3, '2022-05-24', 0),
(4, '2022-05-24', 0),
(5, '2022-05-24', 0),
(6, '2022-05-24', 0),
(7, '2022-05-24', 0),
(8, '2022-05-24', 0),
(9, '2022-05-24', 0),
(10, '2022-05-24', 0),
(11, '2022-05-24', 0),
(12, '2022-05-24', 0),
(13, '2022-05-24', 0),
(14, '2022-05-24', 0),
(15, '2022-05-24', 0),
(16, '2022-05-24', 0),
(17, '2022-05-24', 0),
(18, '2022-05-24', 0),
(19, '2022-05-24', 0),
(20, '2022-05-24', 0),
(21, '2022-05-24', 0),
(22, '2022-05-24', 0),
(23, '2022-05-24', 0),
(24, '2022-05-24', 0),
(25, '2022-05-24', 0),
(26, '2022-05-24', 0),
(27, '2022-05-24', 0),
(28, '2022-05-24', 0),
(29, '2022-05-24', 0),
(30, '2022-05-24', 0),
(31, '2022-05-24', 0),
(32, '2022-05-24', 0),
(33, '2022-05-24', 0),
(34, '2022-05-24', 0),
(35, '2022-05-24', 0),
(36, '2022-05-24', 0),
(37, '2022-05-24', 0),
(38, '2022-05-24', 0),
(39, '2022-05-24', 0),
(40, '2022-05-24', 0),
(41, '2022-05-24', 0),
(42, '2022-05-24', 0),
(43, '2022-05-24', 0),
(44, '2022-05-24', 0),
(45, '2022-05-24', 0),
(46, '2022-05-24', 0),
(47, '2022-05-24', 0),
(48, '2022-05-24', 0),
(49, '2022-05-24', 0),
(50, '2022-05-24', 0),
(51, '2022-05-24', 0),
(52, '2022-05-24', 0),
(53, '2022-05-24', 0),
(54, '2022-05-24', 0),
(55, '2022-05-24', 0),
(56, '2022-05-24', 0),
(57, '2022-05-24', 0),
(58, '2022-05-24', 0),
(59, '2022-05-24', 0),
(60, '2022-05-24', 0),
(61, '2022-05-24', 0),
(62, '2022-05-24', 0),
(63, '2022-05-24', 0),
(64, '2022-05-24', 0),
(65, '2022-05-24', 0),
(66, '2022-05-24', 0),
(67, '2022-05-24', 0),
(68, '2022-05-24', 0),
(69, '2022-05-24', 0),
(70, '2022-05-24', 0),
(71, '2022-05-24', 0),
(72, '2022-05-24', 0),
(73, '2022-05-24', 0),
(74, '2022-05-24', 0),
(75, '2022-05-24', 0),
(76, '2022-05-24', 0),
(77, '2022-05-24', 0),
(78, '2022-05-24', 0),
(79, '2022-05-24', 0),
(80, '2022-05-24', 0),
(81, '2022-05-24', 0),
(82, '2022-05-24', 0),
(83, '2022-05-24', 0),
(84, '2022-05-24', 0),
(85, '2022-05-24', 0),
(86, '2022-05-24', 0),
(87, '2022-05-24', 0),
(88, '2022-05-24', 0),
(89, '2022-05-24', 0),
(90, '2022-05-24', 0),
(91, '2022-05-24', 0),
(92, '2022-05-24', 0),
(93, '2022-05-24', 0),
(94, '2022-05-24', 0),
(95, '2022-05-24', 0),
(96, '2022-05-24', 0),
(97, '2022-05-24', 0),
(98, '2022-05-24', 0),
(99, '2022-05-24', 0),
(100, '2022-05-24', 0),
(101, '2022-05-24', 0),
(102, '2022-05-24', 0),
(103, '2022-05-24', 0),
(104, '2022-05-24', 0),
(105, '2022-05-24', 0),
(106, '2022-05-24', 0),
(107, '2022-05-24', 0),
(108, '2022-05-24', 0),
(109, '2022-05-24', 0),
(110, '2022-05-24', 0),
(111, '2022-05-24', 0),
(112, '2022-05-24', 0),
(113, '2022-05-24', 0),
(114, '2022-05-24', 0),
(115, '2022-05-24', 0),
(116, '2022-05-24', 0),
(117, '2022-05-24', 0),
(118, '2022-05-24', 0),
(119, '2022-05-24', 0),
(120, '2022-05-24', 0),
(121, '2022-05-24', 0),
(122, '2022-05-24', 0),
(123, '2022-05-24', 0),
(124, '2022-05-24', 0),
(125, '2022-05-24', 0),
(126, '2022-05-24', 0),
(127, '2022-05-24', 0),
(128, '2022-05-24', 0),
(129, '2022-05-24', 0),
(130, '2022-05-24', 0),
(131, '2022-05-24', 0),
(132, '2022-05-24', 0),
(133, '2022-05-24', 0),
(134, '2022-05-24', 0),
(135, '2022-05-24', 0),
(136, '2022-05-24', 0),
(137, '2022-05-24', 0),
(138, '2022-05-24', 0),
(139, '2022-05-24', 0),
(140, '2022-05-24', 0),
(141, '2022-05-24', 0),
(142, '2022-05-24', 0),
(143, '2022-05-24', 0),
(144, '2022-05-24', 0),
(145, '2022-05-24', 0),
(146, '2022-05-24', 0),
(147, '2022-05-24', 0),
(148, '2022-05-24', 0),
(149, '2022-05-24', 0),
(150, '2022-05-24', 0),
(151, '2022-05-24', 0),
(152, '2022-05-24', 0),
(153, '2022-05-24', 0),
(154, '2022-05-24', 0),
(155, '2022-05-24', 0),
(156, '2022-05-24', 0),
(157, '2022-05-24', 0),
(158, '2022-05-24', 0),
(159, '2022-05-24', 0),
(160, '2022-05-24', 0),
(161, '2022-05-24', 0),
(162, '2022-05-24', 0),
(163, '2022-05-24', 0),
(164, '2022-05-24', 0),
(165, '2022-05-24', 0),
(166, '2022-05-24', 0),
(167, '2022-05-24', 0),
(168, '2022-05-24', 0),
(169, '2022-05-24', 0),
(170, '2022-05-24', 0),
(171, '2022-05-24', 0),
(172, '2022-05-24', 0),
(173, '2022-05-24', 0),
(174, '2022-05-24', 0),
(175, '2022-05-24', 0),
(176, '2022-05-24', 0),
(177, '2022-05-24', 0),
(178, '2022-05-24', 0),
(179, '2022-05-24', 0),
(180, '2022-05-24', 0),
(181, '2022-05-24', 0),
(182, '2022-05-24', 0),
(183, '2022-05-24', 0),
(184, '2022-05-24', 0),
(185, '2022-05-24', 0),
(186, '2022-05-24', 0),
(187, '2022-05-24', 0),
(188, '2022-05-24', 0),
(189, '2022-05-24', 0),
(190, '2022-05-24', 0),
(191, '2022-05-24', 0),
(192, '2022-05-24', 0),
(193, '2022-05-24', 0),
(194, '2022-05-24', 0),
(195, '2022-05-24', 0),
(196, '2022-05-24', 0),
(197, '2022-05-24', 0),
(198, '2022-05-24', 0),
(199, '2022-05-24', 0),
(200, '2022-05-24', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `Id_doc_compra` int(3) NOT NULL,
  `Id_lote` int(3) NOT NULL,
  `Id_producto` int(3) NOT NULL,
  `Cantidad` int(3) NOT NULL,
  `Precio_compra` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `Id_doc_venta` int(3) NOT NULL,
  `Id_producto` int(3) NOT NULL,
  `Cantidad` int(3) NOT NULL,
  `Precio_venta` decimal(12,2) NOT NULL,
  `Precio_compra` decimal(12,2) NOT NULL,
  `Utilidad` decimal(12,2) NOT NULL,
  `Utilidades` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documento_compra`
--

CREATE TABLE `documento_compra` (
  `Id_doc_compra` int(3) NOT NULL,
  `Id_estado_compra` int(3) NOT NULL,
  `Proveedor_persona_idpersona` int(3) NOT NULL,
  `Empleado_persona_idpersona` int(3) NOT NULL,
  `Factura` char(15) NOT NULL,
  `Guia_remision` char(15) NOT NULL,
  `Fecha_compra` date NOT NULL,
  `Importe_total` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documento_venta`
--

CREATE TABLE `documento_venta` (
  `Id_doc_venta` int(3) NOT NULL,
  `Empleado_persona_idpersona` int(3) NOT NULL,
  `Cliente_persona_idpersona` int(3) NOT NULL,
  `Id_tipo_documento_venta` int(3) NOT NULL,
  `Fecha_venta` date NOT NULL,
  `Hora_venta` time NOT NULL,
  `Serie_documento` char(4) NOT NULL,
  `Numero_documento` char(10) NOT NULL,
  `Importe_total` decimal(15,2) NOT NULL,
  `Importe_pagado` decimal(15,2) NOT NULL,
  `vuelto` decimal(15,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `Id_persona` int(11) NOT NULL,
  `Id_cargo` int(3) NOT NULL,
  `Id_estadoempleado` int(3) NOT NULL,
  `Usuario` char(20) NOT NULL,
  `Clave` char(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`Id_persona`, `Id_cargo`, `Id_estadoempleado`, `Usuario`, `Clave`) VALUES
(202, 1, 1, 'admin', '0906'),
(201, 2, 2, 'gustavo', '123'),
(203, 1, 1, 'gcamo', '0508');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_compra`
--

CREATE TABLE `estado_compra` (
  `Id_estado_compra` int(3) NOT NULL,
  `Des_estado_compra` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_empleado`
--

CREATE TABLE `estado_empleado` (
  `Id_estadoempleado` int(3) NOT NULL,
  `des_estadoempleado` char(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `estado_empleado`
--

INSERT INTO `estado_empleado` (`Id_estadoempleado`, `des_estadoempleado`) VALUES
(1, 'Activo'),
(2, 'Inactivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kardex`
--

CREATE TABLE `kardex` (
  `Id_kardex` int(3) NOT NULL,
  `Id_producto` int(3) NOT NULL,
  `Empleado_persona_idpersona` int(3) NOT NULL,
  `Movimiento` varchar(50) NOT NULL,
  `Cantidad` int(3) NOT NULL,
  `Fecha` date NOT NULL,
  `Hora` time NOT NULL,
  `Stock_antiguo` int(3) NOT NULL,
  `Stock_actual` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lote`
--

CREATE TABLE `lote` (
  `Id_lote` int(11) NOT NULL,
  `Id_producto` int(11) NOT NULL,
  `stock` int(10) NOT NULL,
  `Id_persona` int(11) NOT NULL,
  `Fecha_vencimiento` date NOT NULL,
  `lote_eliminado` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `lote`
--

INSERT INTO `lote` (`Id_lote`, `Id_producto`, `stock`, `Id_persona`, `Fecha_vencimiento`, `lote_eliminado`) VALUES
(1, 58, 10, 198, '2025-05-30', 0),
(2, 59, 3, 198, '2025-05-01', 0),
(3, 60, 3, 198, '2025-05-01', 0),
(4, 68, 16, 198, '2025-05-01', 0),
(5, 69, 6, 198, '2025-05-01', 0),
(6, 71, 8, 198, '2025-05-01', 0),
(7, 74, 6, 198, '2025-05-01', 0),
(8, 76, 6, 198, '2025-05-01', 0),
(9, 83, 6, 198, '2025-05-01', 0),
(10, 86, 6, 198, '2025-05-01', 0),
(11, 89, 3, 198, '2025-05-01', 0),
(12, 90, 3, 198, '2025-05-01', 0),
(13, 91, 3, 198, '2025-05-01', 0),
(14, 92, 3, 198, '2025-05-01', 0),
(15, 93, 6, 198, '2025-05-01', 0),
(16, 94, 8, 198, '2025-05-01', 0),
(17, 95, 6, 198, '2025-05-01', 0),
(18, 96, 6, 198, '2025-05-01', 0),
(19, 98, 6, 198, '2025-05-01', 0),
(20, 102, 4, 198, '2025-05-01', 0),
(21, 107, 6, 198, '2025-05-01', 0),
(22, 115, 5, 198, '2025-05-01', 0),
(23, 116, 4, 198, '2025-05-01', 0),
(24, 118, 6, 198, '2025-05-01', 0),
(25, 126, 1, 198, '2025-05-01', 0),
(26, 127, 6, 198, '2025-05-01', 0),
(27, 134, 8, 198, '2025-05-01', 0),
(28, 136, 6, 198, '2025-05-01', 0),
(29, 139, 5, 198, '2025-05-01', 0),
(30, 143, 4, 198, '2025-05-01', 0),
(31, 151, 1, 198, '2025-05-01', 0),
(32, 152, 3, 198, '2025-05-01', 0),
(33, 158, 3, 198, '2025-05-01', 0),
(34, 167, 1, 198, '2025-05-01', 0),
(35, 183, 6, 198, '2025-05-01', 0),
(36, 184, 3, 198, '2025-05-01', 0),
(37, 187, 17, 198, '2025-05-01', 0),
(38, 193, 4, 198, '2025-05-01', 0),
(39, 194, 3, 198, '2025-05-01', 0),
(40, 195, 3, 198, '2025-05-01', 0),
(41, 196, 3, 198, '2025-05-01', 0),
(42, 197, 3, 198, '2025-05-01', 0),
(43, 198, 3, 198, '2025-05-01', 0),
(44, 199, 3, 198, '2025-05-01', 0),
(45, 204, 4, 198, '2025-05-01', 0),
(46, 206, 4, 198, '2025-05-01', 0),
(47, 207, 4, 198, '2025-05-01', 0),
(48, 208, 7, 198, '2025-05-01', 0),
(49, 217, 6, 198, '2025-05-01', 0),
(50, 220, 3, 198, '2025-05-01', 0),
(51, 221, 6, 198, '2025-05-01', 0),
(52, 225, 7, 198, '2025-05-01', 0),
(53, 226, 6, 198, '2025-05-01', 0),
(54, 227, 4, 198, '2025-05-01', 0),
(55, 231, 15, 198, '2025-05-01', 0),
(56, 235, 3, 198, '2025-05-01', 0),
(57, 236, 3, 198, '2025-05-01', 0),
(58, 238, 3, 198, '2025-05-01', 0),
(59, 241, 5, 198, '2025-05-01', 0),
(60, 243, 3, 198, '2025-05-01', 0),
(61, 252, 4, 198, '2025-05-01', 0),
(62, 266, 4, 198, '2025-05-01', 0),
(63, 271, 8, 198, '2025-05-01', 0),
(64, 274, 1, 198, '2025-05-01', 0),
(65, 275, 5, 198, '2025-05-01', 0),
(66, 276, 4, 198, '2025-05-01', 0),
(67, 277, 27, 198, '2025-05-01', 0),
(68, 284, 3, 198, '2025-05-01', 0),
(69, 286, 7, 198, '2025-05-01', 0),
(70, 287, 9, 198, '2025-05-01', 0),
(71, 291, 4, 198, '2025-05-01', 0),
(72, 292, 12, 198, '2025-05-01', 0),
(73, 299, 3, 198, '2025-05-01', 0),
(74, 302, 3, 198, '2025-05-01', 0),
(75, 303, 1, 198, '2025-05-01', 0),
(76, 309, 3, 198, '2025-05-01', 0),
(77, 310, 3, 198, '2025-05-01', 0),
(78, 311, 3, 198, '2025-05-01', 0),
(79, 312, 3, 198, '2025-05-01', 0),
(80, 314, 5, 198, '2025-05-01', 0),
(81, 315, 6, 198, '2025-05-01', 0),
(82, 316, 4, 198, '2025-05-01', 0),
(83, 317, 4, 198, '2025-05-01', 0),
(84, 319, 6, 198, '2025-05-01', 0),
(85, 321, 3, 198, '2025-05-01', 0),
(86, 326, 4, 198, '2025-05-01', 0),
(87, 327, 4, 198, '2025-05-01', 0),
(88, 328, 4, 198, '2025-05-01', 0),
(89, 329, 5, 198, '2025-05-01', 0),
(90, 332, 3, 198, '2025-05-01', 0),
(91, 334, 6, 198, '2025-05-01', 0),
(92, 335, 1, 198, '2025-05-01', 0),
(93, 343, 5, 198, '2025-05-01', 0),
(94, 344, 4, 198, '2025-05-01', 0),
(95, 346, 3, 198, '2025-05-01', 0),
(96, 348, 4, 198, '2025-05-01', 0),
(97, 350, 3, 198, '2025-05-01', 0),
(98, 351, 3, 198, '2025-05-01', 0),
(99, 352, 3, 198, '2025-05-01', 0),
(100, 353, 3, 198, '2025-05-01', 0),
(101, 354, 3, 198, '2025-05-01', 0),
(102, 358, 18, 198, '2025-05-01', 0),
(103, 359, 18, 198, '2025-05-01', 0),
(104, 360, 18, 198, '2025-05-01', 0),
(105, 361, 6, 198, '2025-05-01', 0),
(106, 364, 4, 198, '2025-05-01', 0),
(107, 366, 18, 198, '2025-05-01', 0),
(108, 367, 3, 198, '2025-05-01', 0),
(109, 368, 3, 198, '2025-05-01', 0),
(110, 369, 18, 198, '2025-05-01', 0),
(111, 370, 12, 198, '2025-05-01', 0),
(112, 371, 6, 198, '2025-05-01', 0),
(113, 372, 4, 198, '2025-05-01', 0),
(114, 375, 1, 198, '2025-05-01', 0),
(115, 378, 6, 198, '2025-05-01', 0),
(116, 379, 3, 198, '2025-05-01', 0),
(117, 380, 3, 198, '2025-05-01', 0),
(118, 382, 17, 198, '2025-05-01', 0),
(119, 383, 4, 198, '2025-05-01', 0),
(120, 389, 17, 198, '2025-05-01', 0),
(121, 390, 7, 198, '2025-05-01', 0),
(122, 391, 5, 198, '2025-05-01', 0),
(123, 392, 3, 198, '2025-05-01', 0),
(124, 394, 12, 198, '2025-05-01', 0),
(125, 396, 6, 198, '2025-05-01', 0),
(126, 397, 1, 198, '2025-05-01', 0),
(127, 401, 4, 198, '2025-05-01', 0),
(128, 404, 6, 198, '2025-05-01', 0),
(129, 405, 18, 198, '2025-05-01', 0),
(130, 406, 6, 198, '2025-05-01', 0),
(131, 407, 16, 198, '2025-05-01', 0),
(132, 408, 16, 198, '2025-05-01', 0),
(133, 409, 3, 198, '2025-05-01', 0),
(134, 411, 3, 198, '2025-05-01', 0),
(135, 418, 19, 198, '2025-05-01', 0),
(136, 419, 3, 198, '2025-05-01', 0),
(137, 420, 3, 198, '2025-05-01', 0),
(138, 423, 6, 198, '2025-05-01', 0),
(139, 426, 9, 198, '2025-05-01', 0),
(140, 431, 4, 198, '2025-05-01', 0),
(141, 435, 5, 198, '2025-05-01', 0),
(142, 436, 4, 198, '2025-05-01', 0),
(143, 439, 1, 198, '2025-05-01', 0),
(144, 442, 12, 198, '2025-05-01', 0),
(145, 448, 8, 198, '2025-05-01', 0),
(146, 450, 1, 198, '2025-05-01', 0),
(147, 451, 8, 198, '2025-05-01', 0),
(148, 456, 6, 198, '2025-05-01', 0),
(149, 459, 4, 198, '2025-05-01', 0),
(150, 461, 6, 198, '2025-05-01', 0),
(151, 463, 6, 198, '2025-05-01', 0),
(152, 465, 4, 198, '2025-05-01', 0),
(153, 466, 4, 198, '2025-05-01', 0),
(154, 467, 4, 198, '2025-05-01', 0),
(155, 469, 1, 198, '2025-05-01', 0),
(156, 470, 3, 198, '2025-05-01', 0),
(157, 471, 13, 198, '2025-05-01', 0),
(158, 475, 4, 198, '2025-05-01', 0),
(159, 480, 3, 198, '2025-05-01', 0),
(160, 485, 4, 198, '2025-05-01', 0),
(161, 486, 16, 198, '2025-05-01', 0),
(162, 489, 7, 198, '2025-05-01', 0),
(163, 490, 4, 198, '2025-05-01', 0),
(164, 493, 4, 198, '2025-05-01', 0),
(165, 494, 3, 198, '2025-05-01', 0),
(166, 496, 5, 198, '2025-05-01', 0),
(167, 497, 4, 198, '2025-05-01', 0),
(168, 501, 1, 198, '2025-05-01', 0),
(169, 512, 6, 198, '2025-05-01', 0),
(170, 513, 1, 198, '2025-05-01', 0),
(171, 514, 1, 198, '2025-05-01', 0),
(172, 515, 5, 198, '2025-05-01', 0),
(173, 516, 6, 198, '2025-05-01', 0),
(174, 517, 5, 198, '2025-05-01', 0),
(175, 518, 6, 198, '2025-05-01', 0),
(176, 519, 3, 198, '2025-05-01', 0),
(177, 522, 7, 198, '2025-05-01', 0),
(178, 525, 12, 198, '2025-05-01', 0),
(179, 526, 6, 198, '2025-05-01', 0),
(180, 528, 5, 198, '2025-05-01', 0),
(181, 536, 1, 198, '2025-05-01', 0),
(182, 539, 12, 198, '2025-05-01', 0),
(183, 541, 4, 198, '2025-05-01', 0),
(184, 542, 4, 198, '2025-05-01', 0),
(185, 543, 6, 198, '2025-05-01', 0),
(186, 544, 6, 198, '2025-05-01', 0),
(187, 548, 17, 198, '2025-05-01', 0),
(188, 549, 8, 198, '2025-05-01', 0),
(189, 551, 20, 198, '2025-05-01', 0),
(190, 554, 16, 198, '2025-05-01', 0),
(191, 555, 4, 198, '2025-05-01', 0),
(192, 556, 4, 198, '2025-05-01', 0),
(193, 560, 3, 198, '2025-05-01', 0),
(194, 562, 4, 198, '2025-05-01', 0),
(195, 563, 6, 198, '2025-05-01', 0),
(196, 565, 6, 198, '2025-05-01', 0),
(197, 566, 1, 198, '2025-05-01', 0),
(198, 568, 1, 198, '2025-05-01', 0),
(199, 570, 9, 198, '2025-05-01', 0),
(200, 572, 6, 198, '2025-05-01', 0),
(201, 573, 3, 198, '2025-05-01', 0),
(202, 575, 4, 198, '2025-05-01', 0),
(203, 578, 8, 198, '2025-05-01', 0),
(204, 579, 8, 198, '2025-05-01', 0),
(205, 581, 3, 198, '2025-05-01', 0),
(206, 591, 1, 198, '2025-05-01', 0),
(207, 594, 18, 198, '2025-05-01', 0),
(208, 597, 18, 198, '2025-05-01', 0),
(209, 600, 1, 198, '2025-05-01', 0),
(210, 601, 3, 198, '2025-05-01', 0),
(211, 602, 6, 198, '2025-05-01', 0),
(212, 603, 1, 198, '2025-05-01', 0),
(213, 604, 1, 198, '2025-05-01', 0),
(214, 605, 3, 198, '2025-05-01', 0),
(215, 606, 3, 198, '2025-05-01', 0),
(216, 609, 6, 198, '2025-05-01', 0),
(217, 610, 7, 198, '2025-05-01', 0),
(218, 612, 3, 198, '2025-05-01', 0),
(219, 615, 3, 198, '2025-05-01', 0),
(220, 616, 4, 198, '2025-05-01', 0),
(221, 618, 1, 198, '2025-05-01', 0),
(222, 619, 6, 198, '2025-05-01', 0),
(223, 620, 6, 198, '2025-05-01', 0),
(224, 621, 6, 198, '2025-05-01', 0),
(225, 622, 1, 198, '2025-05-01', 0),
(226, 629, 6, 198, '2025-05-01', 0),
(227, 630, 4, 198, '2025-05-01', 0),
(228, 632, 6, 198, '2025-05-01', 0),
(229, 634, 3, 198, '2025-05-01', 0),
(230, 636, 6, 198, '2025-05-01', 0),
(231, 638, 6, 198, '2025-05-01', 0),
(232, 639, 4, 198, '2025-05-01', 0),
(233, 641, 3, 198, '2025-05-01', 0),
(234, 645, 3, 198, '2025-05-01', 0),
(235, 647, 4, 198, '2025-05-01', 0),
(236, 648, 3, 198, '2025-05-01', 0),
(237, 649, 5, 198, '2025-05-01', 0),
(238, 650, 4, 198, '2025-05-01', 0),
(239, 651, 1, 198, '2025-05-01', 0),
(240, 652, 4, 198, '2025-05-01', 0),
(241, 653, 4, 198, '2025-05-01', 0),
(242, 654, 3, 198, '2025-05-01', 0),
(243, 655, 4, 198, '2025-05-01', 0),
(244, 656, 1, 198, '2025-05-01', 0),
(245, 658, 5, 198, '2025-05-01', 0),
(246, 659, 9, 198, '2025-05-01', 0),
(247, 661, 8, 198, '2025-05-01', 0),
(248, 663, 8, 198, '2025-05-01', 0),
(249, 664, 4, 198, '2025-05-01', 0),
(250, 667, 1, 198, '2025-05-01', 0),
(251, 668, 4, 198, '2025-05-01', 0),
(252, 671, 7, 198, '2025-05-01', 0),
(253, 678, 3, 198, '2025-05-01', 0),
(254, 686, 4, 198, '2025-05-01', 0),
(255, 687, 4, 198, '2025-05-01', 0),
(256, 688, 4, 198, '2025-05-01', 0),
(257, 690, 3, 198, '2025-05-01', 0),
(258, 692, 3, 198, '2025-05-01', 0),
(259, 698, 6, 198, '2025-05-01', 0),
(260, 699, 6, 198, '2025-05-01', 0),
(261, 705, 9, 198, '2025-05-01', 0),
(262, 706, 9, 198, '2025-05-01', 0),
(263, 707, 4, 198, '2025-05-01', 0),
(264, 708, 1, 198, '2025-05-01', 0),
(265, 709, 1, 198, '2025-05-01', 0),
(266, 711, 1, 198, '2025-05-01', 0),
(267, 712, 8, 198, '2025-05-01', 0),
(268, 713, 3, 198, '2025-05-01', 0),
(269, 716, 8, 198, '2025-05-01', 0),
(270, 717, 4, 198, '2025-05-01', 0),
(271, 719, 16, 198, '2025-05-01', 0),
(272, 720, 11, 198, '2025-05-01', 0),
(273, 722, 6, 198, '2025-05-01', 0),
(274, 723, 6, 198, '2025-05-01', 0),
(275, 726, 12, 198, '2025-05-01', 0),
(276, 728, 5, 198, '2025-05-01', 0),
(277, 729, 4, 198, '2025-05-01', 0),
(278, 730, 1, 198, '2025-05-01', 0),
(279, 731, 16, 198, '2025-05-01', 0),
(280, 733, 1, 198, '2025-05-01', 0),
(281, 737, 9, 198, '2025-05-01', 0),
(282, 739, 7, 198, '2025-05-01', 0),
(283, 740, 4, 198, '2025-05-01', 0),
(284, 742, 6, 198, '2025-05-01', 0),
(285, 749, 20, 198, '2025-05-01', 0),
(286, 753, 4, 198, '2025-05-01', 0),
(287, 754, 6, 198, '2025-05-01', 0),
(288, 757, 4, 198, '2025-05-01', 0),
(289, 763, 1, 198, '2025-05-01', 0),
(290, 764, 3, 198, '2025-05-01', 0),
(291, 766, 1, 198, '2025-05-01', 0),
(292, 767, 4, 198, '2025-05-01', 0),
(293, 768, 3, 198, '2025-05-01', 0),
(294, 769, 7, 198, '2025-05-01', 0),
(295, 770, 16, 198, '2025-05-01', 0),
(296, 771, 3, 198, '2025-05-01', 0),
(297, 772, 8, 198, '2025-05-01', 0),
(298, 774, 4, 198, '2025-05-01', 0),
(299, 775, 5, 198, '2025-05-01', 0),
(300, 779, 5, 198, '2025-05-01', 0),
(301, 780, 4, 198, '2025-05-01', 0),
(302, 781, 4, 198, '2025-05-01', 0),
(303, 785, 4, 198, '2025-05-01', 0),
(304, 786, 4, 198, '2025-05-01', 0),
(305, 788, 3, 198, '2025-05-01', 0),
(306, 789, 3, 198, '2025-05-01', 0),
(307, 790, 1, 198, '2025-05-01', 0),
(308, 791, 7, 198, '2025-05-01', 0),
(309, 793, 1, 198, '2025-05-01', 0),
(310, 794, 16, 198, '2025-05-01', 0),
(311, 795, 4, 198, '2025-05-01', 0),
(312, 798, 4, 198, '2025-05-01', 0),
(313, 799, 4, 198, '2025-05-01', 0),
(314, 801, 6, 198, '2025-05-01', 0),
(315, 802, 4, 198, '2025-05-01', 0),
(316, 803, 4, 198, '2025-05-01', 0),
(317, 804, 1, 198, '2025-05-01', 0),
(318, 807, 4, 198, '2025-05-01', 0),
(319, 812, 6, 198, '2025-05-01', 0),
(320, 813, 6, 198, '2025-05-01', 0),
(321, 814, 16, 198, '2025-05-01', 0),
(322, 820, 4, 198, '2025-05-01', 0),
(323, 821, 6, 198, '2025-05-01', 0),
(324, 823, 4, 198, '2025-05-01', 0),
(325, 824, 4, 198, '2025-05-01', 0),
(326, 825, 4, 198, '2025-05-01', 0),
(327, 826, 3, 198, '2025-05-01', 0),
(328, 830, 4, 198, '2025-05-01', 0),
(329, 832, 4, 198, '2025-05-01', 0),
(330, 833, 5, 198, '2025-05-01', 0),
(331, 834, 1, 198, '2025-05-01', 0),
(332, 835, 7, 198, '2025-05-01', 0),
(333, 836, 3, 198, '2025-05-01', 0),
(334, 838, 7, 198, '2025-05-01', 0),
(335, 839, 5, 198, '2025-05-01', 0),
(336, 841, 6, 198, '2025-05-01', 0),
(337, 842, 6, 198, '2025-05-01', 0),
(338, 843, 5, 198, '2025-05-01', 0),
(339, 845, 26, 198, '2025-05-01', 0),
(340, 846, 3, 198, '2025-05-01', 0),
(341, 847, 4, 198, '2025-05-01', 0),
(342, 848, 4, 198, '2025-05-01', 0),
(343, 849, 5, 198, '2025-05-01', 0),
(344, 850, 4, 198, '2025-05-01', 0),
(345, 851, 4, 198, '2025-05-01', 0),
(346, 853, 3, 198, '2025-05-01', 0),
(347, 855, 6, 198, '2025-05-01', 0),
(348, 856, 26, 198, '2025-05-01', 0),
(349, 857, 6, 198, '2025-05-01', 0),
(350, 858, 6, 198, '2025-05-01', 0),
(351, 860, 6, 198, '2025-05-01', 0),
(352, 861, 5, 198, '2025-05-01', 0),
(353, 863, 6, 198, '2025-05-01', 0),
(354, 864, 5, 198, '2025-05-01', 0),
(355, 865, 9, 198, '2025-05-01', 0),
(356, 867, 12, 198, '2025-05-01', 0),
(357, 868, 6, 198, '2025-05-01', 0),
(358, 869, 5, 198, '2025-05-01', 0),
(359, 871, 4, 198, '2025-05-01', 0),
(360, 872, 4, 198, '2025-05-01', 0),
(361, 874, 16, 198, '2025-05-01', 0),
(362, 875, 6, 198, '2025-05-01', 0),
(363, 876, 12, 198, '2025-05-01', 0),
(364, 877, 7, 198, '2025-05-01', 0),
(365, 878, 5, 198, '2025-05-01', 0),
(366, 879, 6, 198, '2025-05-01', 0),
(367, 880, 6, 198, '2025-05-01', 0),
(368, 881, 6, 198, '2025-05-01', 0),
(369, 882, 4, 198, '2025-05-01', 0),
(370, 883, 6, 198, '2025-05-01', 0),
(371, 884, 6, 198, '2025-05-01', 0),
(372, 886, 6, 198, '2025-05-01', 0),
(373, 887, 27, 198, '2025-05-01', 0),
(374, 888, 4, 198, '2025-05-01', 0),
(375, 889, 6, 198, '2025-05-01', 0),
(376, 890, 6, 198, '2025-05-01', 0),
(377, 893, 6, 198, '2025-05-01', 0),
(378, 903, 6, 198, '2025-05-01', 0),
(379, 904, 6, 198, '2025-05-01', 0),
(380, 905, 4, 198, '2025-05-01', 0),
(381, 906, 5, 198, '2025-05-01', 0),
(382, 907, 7, 198, '2025-05-01', 0),
(383, 908, 6, 198, '2025-05-01', 0),
(384, 909, 4, 198, '2025-05-01', 0),
(385, 910, 4, 198, '2025-05-01', 0),
(386, 911, 4, 198, '2025-05-01', 0),
(387, 912, 5, 198, '2025-05-01', 0),
(388, 913, 5, 198, '2025-05-01', 0),
(389, 914, 4, 198, '2025-05-01', 0),
(390, 915, 6, 198, '2025-05-01', 0),
(391, 916, 4, 198, '2025-05-01', 0),
(392, 917, 6, 198, '2025-05-01', 0),
(393, 919, 3, 198, '2025-05-01', 0),
(394, 920, 3, 198, '2025-05-01', 0),
(395, 921, 26, 198, '2025-05-01', 0),
(396, 922, 6, 198, '2025-05-01', 0),
(397, 923, 6, 198, '2025-05-01', 0),
(398, 924, 6, 198, '2025-05-01', 0),
(399, 926, 6, 198, '2025-05-01', 0),
(400, 927, 12, 198, '2025-05-01', 0),
(401, 928, 1, 198, '2025-05-01', 0),
(402, 929, 1, 198, '2025-05-01', 0),
(403, 930, 12, 198, '2025-05-01', 0),
(404, 931, 1, 198, '2025-05-01', 0),
(405, 932, 5, 198, '2025-05-01', 0),
(406, 934, 6, 198, '2025-05-01', 0),
(407, 935, 6, 198, '2025-05-01', 0),
(408, 936, 6, 198, '2025-05-01', 0),
(409, 937, 4, 198, '2025-05-01', 0),
(410, 938, 7, 198, '2025-05-01', 0),
(411, 939, 5, 198, '2025-05-01', 0),
(412, 940, 6, 198, '2025-05-01', 0),
(413, 941, 6, 198, '2025-05-01', 0),
(414, 942, 4, 198, '2025-05-01', 0),
(415, 943, 4, 198, '2025-05-01', 0),
(416, 944, 6, 198, '2025-05-01', 0),
(417, 945, 5, 198, '2025-05-01', 0),
(418, 947, 5, 198, '2025-05-01', 0),
(419, 948, 5, 198, '2025-05-01', 0),
(420, 949, 5, 198, '2025-05-01', 0),
(421, 950, 4, 198, '2025-05-01', 0),
(422, 951, 4, 198, '2025-05-01', 0),
(423, 952, 1, 198, '2025-05-01', 0),
(424, 953, 16, 198, '2025-05-01', 0),
(425, 954, 16, 198, '2025-05-01', 0),
(426, 956, 4, 198, '2025-05-01', 0),
(427, 957, 6, 198, '2025-05-01', 0),
(428, 958, 4, 198, '2025-05-01', 0),
(429, 959, 3, 198, '2025-05-01', 0),
(430, 960, 3, 198, '2025-05-01', 0),
(431, 961, 3, 198, '2025-05-01', 0),
(432, 962, 3, 198, '2025-05-01', 0),
(433, 963, 3, 198, '2025-05-01', 0),
(434, 964, 3, 198, '2025-05-01', 0),
(435, 965, 3, 198, '2025-05-01', 0),
(436, 966, 5, 198, '2025-05-01', 0),
(437, 967, 3, 198, '2025-05-01', 0),
(438, 968, 3, 198, '2025-05-01', 0),
(439, 969, 4, 198, '2025-05-01', 0),
(440, 970, 3, 198, '2025-05-01', 0),
(441, 971, 3, 198, '2025-05-01', 0),
(442, 972, 3, 198, '2025-05-01', 0),
(443, 973, 3, 198, '2025-05-01', 0),
(444, 974, 3, 198, '2025-05-01', 0),
(445, 975, 3, 198, '2025-05-01', 0),
(446, 976, 4, 198, '2025-05-01', 0),
(447, 977, 8, 198, '2025-05-01', 0),
(448, 978, 9, 198, '2025-05-01', 0),
(449, 979, 1, 198, '2025-05-01', 0),
(450, 980, 12, 198, '2025-05-01', 0),
(451, 981, 3, 199, '2025-05-01', 0),
(452, 982, 4, 199, '2025-05-01', 0),
(453, 983, 3, 199, '2025-05-01', 0),
(454, 985, 1, 199, '2025-05-01', 0),
(455, 986, 4, 199, '2025-05-01', 0),
(456, 987, 4, 199, '2025-05-01', 0),
(457, 988, 6, 199, '2025-05-01', 0),
(458, 989, 3, 199, '2025-05-01', 0),
(459, 990, 3, 199, '2025-05-01', 0),
(460, 991, 3, 199, '2025-05-01', 0),
(461, 992, 1, 199, '2025-05-01', 0),
(462, 993, 12, 199, '2025-05-01', 0),
(463, 994, 12, 199, '2025-05-01', 0),
(464, 995, 5, 199, '2025-05-01', 0),
(465, 997, 4, 199, '2025-05-01', 0),
(466, 998, 1, 199, '2025-05-01', 0),
(467, 999, 4, 199, '2025-05-01', 0),
(468, 1000, 4, 199, '2025-05-01', 0),
(469, 1001, 3, 199, '2025-05-01', 0),
(470, 1002, 4, 199, '2025-05-01', 0),
(471, 1003, 3, 199, '2025-05-01', 0),
(472, 1004, 3, 199, '2025-05-01', 0),
(473, 1005, 3, 199, '2025-05-01', 0),
(474, 1006, 12, 199, '2025-05-01', 0),
(475, 1007, 6, 199, '2025-05-01', 0),
(476, 1008, 5, 199, '2025-05-01', 0),
(477, 1009, 4, 199, '2025-05-01', 0),
(478, 1010, 16, 199, '2025-05-01', 0),
(479, 1011, 5, 199, '2025-05-01', 0),
(480, 1012, 7, 199, '2025-05-01', 0),
(481, 1013, 3, 199, '2025-05-01', 0),
(482, 1014, 9, 199, '2025-05-01', 0),
(483, 1015, 3, 199, '2025-05-01', 0),
(484, 1016, 1, 199, '2025-05-01', 0),
(485, 1017, 6, 199, '2025-05-01', 0),
(486, 1018, 8, 199, '2025-05-01', 0),
(487, 1019, 3, 199, '2025-05-01', 0),
(488, 1020, 4, 199, '2025-05-01', 0),
(489, 1021, 3, 199, '2025-05-01', 0),
(490, 1022, 1, 199, '2025-05-01', 0),
(491, 1023, 27, 199, '2025-05-01', 0),
(492, 1024, 4, 199, '2025-05-01', 0),
(493, 1025, 6, 199, '2025-05-01', 0),
(494, 1026, 4, 199, '2025-05-01', 0),
(495, 1027, 5, 199, '2025-05-01', 0),
(496, 1028, 5, 199, '2025-05-01', 0),
(497, 1029, 4, 199, '2025-05-01', 0),
(498, 1030, 26, 199, '2025-05-01', 0),
(499, 1031, 4, 199, '2025-05-01', 0),
(500, 1032, 1, 199, '2025-05-01', 0),
(501, 1033, 4, 199, '2025-05-01', 0),
(502, 1034, 6, 199, '2025-05-01', 0),
(503, 1035, 28, 199, '2025-05-01', 0),
(504, 1036, 26, 199, '2025-05-01', 0),
(505, 1037, 26, 199, '2025-05-01', 0),
(506, 1038, 4, 199, '2025-05-01', 0),
(507, 1039, 4, 199, '2025-05-01', 0),
(508, 1040, 3, 199, '2025-05-01', 0),
(509, 1041, 6, 199, '2025-05-01', 0),
(510, 1042, 26, 199, '2025-05-01', 0),
(511, 1043, 4, 199, '2025-05-01', 0),
(512, 1044, 4, 199, '2025-05-01', 0),
(513, 1045, 4, 199, '2025-05-01', 0),
(514, 1046, 6, 199, '2025-05-01', 0),
(515, 1048, 12, 199, '2025-05-01', 0),
(516, 1049, 8, 199, '2025-05-01', 0),
(517, 1050, 4, 199, '2025-05-01', 0),
(518, 1052, 26, 199, '2025-05-01', 0),
(519, 1053, 26, 199, '2025-05-01', 0),
(520, 1054, 6, 199, '2025-05-01', 0),
(521, 1055, 4, 199, '2025-05-01', 0),
(522, 1056, 4, 199, '2025-05-01', 0),
(523, 1057, 8, 199, '2025-05-01', 0),
(524, 1058, 4, 199, '2025-05-01', 0),
(525, 1059, 4, 199, '2025-05-01', 0),
(526, 1060, 3, 199, '2025-05-01', 0),
(527, 1061, 4, 199, '2025-05-01', 0),
(528, 1062, 5, 199, '2025-05-01', 0),
(529, 1063, 4, 199, '2025-05-01', 0),
(530, 1064, 6, 199, '2025-05-01', 0),
(531, 1065, 9, 199, '2025-05-01', 0),
(532, 1066, 16, 199, '2025-05-01', 0),
(533, 1067, 4, 199, '2025-05-01', 0),
(534, 1069, 4, 199, '2025-05-01', 0),
(535, 1070, 4, 199, '2025-05-01', 0),
(536, 1071, 7, 199, '2025-05-01', 0),
(537, 1072, 4, 199, '2025-05-01', 0),
(538, 1073, 12, 199, '2025-05-01', 0),
(539, 1074, 6, 199, '2025-05-01', 0),
(540, 1075, 4, 199, '2025-05-01', 0),
(541, 1076, 3, 199, '2025-05-01', 0),
(542, 1077, 4, 199, '2025-05-01', 0),
(543, 1078, 16, 199, '2025-05-01', 0),
(544, 1079, 6, 199, '2025-05-01', 0),
(545, 1080, 6, 199, '2025-05-01', 0),
(546, 1081, 6, 199, '2025-05-01', 0),
(547, 1082, 6, 199, '2025-05-01', 0),
(548, 1083, 4, 199, '2025-05-01', 0),
(549, 1084, 5, 199, '2025-05-01', 0),
(550, 1085, 4, 199, '2025-05-01', 0),
(556, 58, 100, 199, '2022-06-30', 0),
(557, 1091, 0, 199, '2022-06-30', 1),
(558, 1091, 200, 198, '2023-06-30', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `Id_persona` int(11) NOT NULL,
  `Nom_persona` varchar(50) NOT NULL,
  `Ape_persona` varchar(100) NOT NULL,
  `Id_tipo_documento` int(3) NOT NULL,
  `Numero_identificacion` varchar(20) NOT NULL,
  `Edad_persona` int(3) NOT NULL,
  `Nacionalidad_persona` char(30) NOT NULL,
  `Empresa_persona` char(50) NOT NULL,
  `Correo_persona` char(50) NOT NULL,
  `Telf_persona` char(20) NOT NULL,
  `Fecha_naci_persona` date NOT NULL,
  `Dir_persona` varchar(100) NOT NULL,
  `Sex_persona` char(1) NOT NULL,
  `eliminado` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`Id_persona`, `Nom_persona`, `Ape_persona`, `Id_tipo_documento`, `Numero_identificacion`, `Edad_persona`, `Nacionalidad_persona`, `Empresa_persona`, `Correo_persona`, `Telf_persona`, `Fecha_naci_persona`, `Dir_persona`, `Sex_persona`, `eliminado`) VALUES
(1, 'OSCAR', 'GALVEZ DELGADO', 4, '72195255', 45, 'Colombiana', 'no aplica', 'OSCAR@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(2, 'SARAI', 'MORE TELLO CIELO ', 1, '0', 45, 'Peruana', 'no aplica', 'SARAI@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(3, 'JORGE ARMANDO', 'MAYANGA CHAPO?AN ', 1, '75728143', 45, 'Peruana', 'no aplica', 'JORGE ARMANDO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(4, 'DEYRON FABIAN', 'MANAYAY GUTIERREZ ', 1, '0', 45, 'Peruana', 'no aplica', 'DEYRON FABIAN@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(5, 'JOSELYN', 'DE LA CRUZ RECUENCO ', 1, '0', 45, 'Peruana', 'no aplica', 'JOSELYN@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(6, 'ELVA', 'CHUNGA MINGUILLO ', 1, '0', 45, 'Peruana', 'no aplica', 'ELVA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(7, 'LUCIA MERCEDES', 'QUESQUEN CHAMBERGO', 1, '75562962', 45, 'Peruana', 'no aplica', 'LUCIA MERCEDES@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(8, 'JORGE SAUL', 'MORENO VELASQUEZ', 1, '62813547', 45, 'Peruana', 'no aplica', 'JORGE SAUL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(9, 'HECTOR MAXIMO', 'ORTIZ VILLEGAS', 1, '5', 45, 'Peruana', 'no aplica', 'HECTOR MAXIMO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(10, 'VERONICA', 'ENEQUE MAURO', 1, '6', 45, 'Peruana', 'no aplica', 'VERONICA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(11, 'FLOR ELENA', 'SANTAMARIA IPANAQUE', 1, '7', 45, 'Peruana', 'no aplica', 'FLOR ELENA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(12, 'JESUS SEBATIAN', 'TEJADA ALCALDE', 1, '62862966', 45, 'Peruana', 'no aplica', 'JESUS SEBATIAN@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(13, 'ESTEBAN SEGUNDO', 'QUESADA CHUNGA', 1, '17447508', 45, 'Peruana', 'no aplica', 'ESTEBAN SEGUNDO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(14, 'ALFREDO', 'MONTALVO CABRERA', 1, '10', 45, 'Peruana', 'no aplica', 'ALFREDO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(15, 'ROSA CONCEPCION', 'MENDOZA DE SIESQUEN', 1, '17411391', 45, 'Peruana', 'no aplica', 'ROSA CONCEPCION@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(16, 'EDGAR JAVIER', 'VALDERA CHUNGA', 1, '177', 45, 'Peruana', 'no aplica', 'EDGAR JAVIER@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(17, 'MARIA DEL SOCORRO', 'AGUIRRE ESTEVES', 1, '17404164', 45, 'Peruana', 'no aplica', 'MARIA DEL SOCORRO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(18, 'ANGELICA ANALI', 'ALCANTARA ROJAS', 1, '46368899', 45, 'Peruana', 'no aplica', 'ANGELICA ANALI@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(19, 'MARCO ANTONIO', 'ESCRIBANO NUNURA', 1, '17438481', 45, 'Peruana', 'no aplica', 'MARCO ANTONIO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(20, 'ZAIRA DAYAN', 'GINES SILVA', 1, '14', 45, 'Peruana', 'no aplica', 'ZAIRA DAYAN@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(21, 'CRISTEL', 'PANTA QUEZADA', 1, '72787992', 45, 'Peruana', 'no aplica', 'CRISTEL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(22, 'INGRID', 'MORI CHAPO?AN', 1, '15', 45, 'Peruana', 'no aplica', 'INGRID@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(23, 'FLOR', 'VILCHEZ MACALOPU', 1, '4632845', 45, 'Peruana', 'no aplica', 'FLOR@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(24, 'SOLEDAD', 'QUEVEDO LLANOS', 1, '17411513', 45, 'Peruana', 'no aplica', 'SOLEDAD@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(25, 'ROSA LUZ ANGELI', 'DIAZ DE CAMPOS', 1, '17', 45, 'Peruana', 'no aplica', 'ROSA LUZ ANGELI@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(26, 'ANDER YOHIRO', 'SEGUNDO LLAGUENTO', 1, '81060089', 45, 'Peruana', 'no aplica', 'ANDER YOHIRO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(27, 'DORIS', 'ALDANA ZULUETA', 1, '17429877', 45, 'Peruana', 'no aplica', 'DORIS@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(28, 'YEYKO', 'ORDINOLA REQUEJO', 1, '18', 45, 'Peruana', 'no aplica', 'YEYKO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(29, 'PAULA', 'CHUNGA DE QUIROZ', 1, '19', 45, 'Peruana', 'no aplica', 'PAULA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(30, 'GENOVEVA', 'AGUILAR MONJE', 1, '20', 45, 'Peruana', 'no aplica', 'GENOVEVA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(31, 'RAFAELA', 'MORE CASTILLO', 1, '21', 45, 'Peruana', 'no aplica', 'RAFAELA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(32, 'ALEXIS', 'MENDOZA QUEVEDO', 1, '43146970', 45, 'Peruana', 'no aplica', 'ALEXIS@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(33, 'EMMA ISABEL', 'RIVADENEYRA GOMEZ', 1, '17427391', 45, 'Peruana', 'no aplica', 'EMMA ISABEL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(34, 'MARIA ROSALIA', 'DIAZ RUFASTO', 1, '16795433', 45, 'Peruana', 'no aplica', 'MARIA ROSALIA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(35, 'BRAYAN', 'PANTA GUEVARA', 1, '22', 45, 'Peruana', 'no aplica', 'BRAYAN@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(36, 'AZUM', 'CAMACHO RUIZ', 1, '23', 45, 'Peruana', 'no aplica', 'AZUM@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(37, 'MARIA', 'SILVA LLAQUE', 1, '17639004', 45, 'Peruana', 'no aplica', 'MARIA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(38, 'RONALD', 'PISCOYA MORALES', 1, '42011032', 45, 'Peruana', 'no aplica', 'RONALD@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(39, 'MARGARITA', 'SANCHEZ VENTURA', 1, '24', 45, 'Peruana', 'no aplica', 'MARGARITA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(40, 'ROBERTO', 'PUESCAS CRUZ', 1, '42020531', 45, 'Peruana', 'no aplica', 'ROBERTO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(41, 'JOHANN', 'CAJO TENORIO', 1, '63090844', 45, 'Peruana', 'no aplica', 'JOHANN@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(42, 'HANA MARISOL', 'VILLEGAS LAZARO', 1, '42', 45, 'Peruana', 'no aplica', 'HANA MARISOL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(43, 'MARCOS ANTONIO', 'CHANAME BELLODAS', 1, '27', 45, 'Peruana', 'no aplica', 'MARCOS ANTONIO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(44, 'JOSE MARIA', 'LINARES GUEVARA', 1, '28', 45, 'Peruana', 'no aplica', 'JOSE MARIA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(45, 'KATHERINE', 'RACCHUMI VALDIVIEZO', 1, '47621724', 45, 'Peruana', 'no aplica', 'KATHERINE@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(46, 'MARIA ISABEL', 'CARBONEL RUIZ ', 1, '17639263', 45, 'Peruana', 'no aplica', 'MARIA ISABEL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(47, 'GUSTAVO', 'DIAZ MANAYAY', 1, '29', 45, 'Peruana', 'no aplica', 'GUSTAVO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(48, 'GABRIEL', 'MIO TIRADO', 1, '30', 45, 'Peruana', 'no aplica', 'GABRIEL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(49, 'BRIANA', 'MORALES PERALTA', 1, '31', 45, 'Peruana', 'no aplica', 'BRIANA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(50, 'ALEJANDRO', 'CARRANZACHEPE', 1, '32', 45, 'Peruana', 'no aplica', 'ALEJANDRO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(51, 'WALTER', 'LOZANO TORRES', 1, '17429603', 45, 'Peruana', 'no aplica', 'WALTER@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(52, 'FREDESVINDA', 'SENCIE CHAFIO', 1, '17411411', 45, 'Peruana', 'no aplica', 'FREDESVINDA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(53, 'KIARA', 'MONTENEGRO SUAREZ', 1, '33', 45, 'Peruana', 'no aplica', 'KIARA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(54, 'GARCIA VALERIANO', 'LENY', 1, '41847719', 45, 'Peruana', 'no aplica', 'GARCIA VALERIANO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(55, 'REYES GUILLERMO', 'ALEXIS ORLANDO ', 1, '34', 45, 'Peruana', 'no aplica', 'REYES GUILLERMO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(56, 'MARTHA', 'GUILLERMO BRENIS', 1, '17414716', 45, 'Peruana', 'no aplica', 'MARTHA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(57, 'ZULMA YANETH', 'FERNANDEZ RAMIREZ', 1, '44897540', 45, 'Peruana', 'no aplica', 'ZULMA YANETH@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(58, 'JESUS', 'GUILLERMO TEMOCHE', 1, '17402525', 45, 'Peruana', 'no aplica', 'JESUS@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(59, 'BRAYAM', 'LESCANO CARLOS', 1, '59', 45, 'Peruana', 'no aplica', 'BRAYAM@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(60, 'YOSWUAR', 'BELLODAS PURISACA', 1, '36', 45, 'Peruana', 'no aplica', 'YOSWUAR@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(61, 'JOSELYN DAYNA', 'MENDOZA LLAMO', 1, '61560391', 45, 'Peruana', 'no aplica', 'JOSELYN DAYNA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(62, 'NAHOMI', 'CARMONA PANTA', 1, '39', 45, 'Peruana', 'no aplica', 'NAHOMI@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(63, 'MARISOL', 'TEMOCHE CASTILLO', 1, '80305831', 45, 'Peruana', 'no aplica', 'MARISOL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(64, 'JULIO CESAR', 'RAMOS SANCHEZ', 1, '17639554', 45, 'Peruana', 'no aplica', 'JULIO CESAR@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(65, 'MARIA ROSARIO', 'CHEPE PISCOYA', 1, '17447912', 45, 'Peruana', 'no aplica', 'MARIA ROSARIO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(66, 'MARIA GENOVEVA', 'PURIHUAMAN ACOSTA', 1, '8728446', 45, 'Peruana', 'no aplica', 'MARIA GENOVEVA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(67, 'CELESTE GUADAL', 'CHICOMA ANGELES', 1, '41', 45, 'Peruana', 'no aplica', 'CELESTE GUADAL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(68, 'RAFELA FERNADA', 'ARCE GUTIERREZ', 1, '81074915', 45, 'Peruana', 'no aplica', 'RAFELA FERNADA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(69, 'KAREN ALEJANDRA', 'MONTALVO MORI', 1, '44', 45, 'Peruana', 'no aplica', 'KAREN ALEJANDRA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(70, 'BLANCA FLOR', 'BERRIOS FERNANDEZ', 1, '17435067', 45, 'Peruana', 'no aplica', 'BLANCA FLOR@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(71, 'DAYANA', 'CABRERA VALLEJOS', 1, '45', 45, 'Peruana', 'no aplica', 'DAYANA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(72, 'TOMASA', 'ACOSTA SANDOVAL', 1, '17405123', 45, 'Peruana', 'no aplica', 'TOMASA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(73, 'ROSA KARINA', 'RUIZ DE ALDAY', 1, '17446844', 45, 'Peruana', 'no aplica', 'ROSA KARINA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(74, 'AMERICA  NICOLE', 'GUEVARA OLAYA', 1, '47', 45, 'Peruana', 'no aplica', 'AMERICA  NICOLE@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(75, 'ASUNCIONA', 'ZE?A GUILLERMO', 1, '17408061', 45, 'Peruana', 'no aplica', 'ASUNCIONA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(76, 'RONALD MAXIMILIANO', 'MESONES ACOSTA', 1, '48', 45, 'Peruana', 'no aplica', 'RONALD MAXIMILIANO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(77, 'VALENTINA', 'SEGURA PISCOYA', 1, '49', 45, 'Peruana', 'no aplica', 'VALENTINA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(78, 'SALOME KRIXIA', 'JIMENEZ SANCHEZ', 1, '51', 45, 'Peruana', 'no aplica', 'SALOME KRIXIA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(79, 'JONATAN', 'CESPEDES CAMACHO', 1, '72664425', 45, 'Peruana', 'no aplica', 'JONATAN@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(80, 'NARCIZO', 'MORENO IPANAQUE', 1, '17414827', 45, 'Peruana', 'no aplica', 'NARCIZO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(81, 'YOLANDA', 'LOPEZ SALCEDO', 1, '17420039', 45, 'Peruana', 'no aplica', 'YOLANDA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(82, 'MARIA VIOLETA', 'CARRASCO DIAZ', 1, '17408008', 45, 'Peruana', 'no aplica', 'MARIA VIOLETA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(83, 'XARUMI YASBELL', 'TEJADA TEMOCHE', 1, '52', 45, 'Peruana', 'no aplica', 'XARUMI YASBELL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(84, 'UMERCINDA', 'PURISACA COLLAZOS', 1, '17447008', 45, 'Peruana', 'no aplica', 'UMERCINDA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(85, 'AYME ABIGAIL', 'TORO DELGADO', 1, '55', 45, 'Peruana', 'no aplica', 'AYME ABIGAIL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(86, 'KARINA DEL MILAGRO', 'HUAMAN JUAREZ', 1, '42766521', 45, 'Peruana', 'no aplica', 'KARINA DEL MILAGRO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(87, 'MARITZA DEL SOCORRO', 'BARANDIARAN FERNANDEZ', 1, '17446641', 45, 'Peruana', 'no aplica', 'MARITZA DEL SOCORRO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(88, 'MARGARITA', 'BERNILLA NAYRA', 1, '57', 45, 'Peruana', 'no aplica', 'MARGARITA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(89, 'FABRIZZIO ZAMIR', 'LLAGUENTO LEON', 1, '63493033', 45, 'Peruana', 'no aplica', 'FABRIZZIO ZAMIR@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(90, 'SANDRA', 'TELLO GALLOSO', 1, '42689664', 45, 'Peruana', 'no aplica', 'SANDRA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(91, 'HECTOR GABRIEL', 'VIDES MINGUILLO', 1, '59', 45, 'Peruana', 'no aplica', 'HECTOR GABRIEL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(92, 'ISIDORA', 'RAMOS SUCLUPE', 1, '17402319', 45, 'Peruana', 'no aplica', 'ISIDORA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(93, 'ALEJANDRO', 'CARRANZA CHEPE', 1, '60', 45, 'Peruana', 'no aplica', 'ALEJANDRO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(94, 'MARIA', 'CHANAME PICON', 1, '17452300', 45, 'Peruana', 'no aplica', 'MARIA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(95, 'IRENE', 'ADANAQUE GONZALES', 1, '61', 45, 'Peruana', 'no aplica', 'IRENE@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(96, 'MARTHA OTILIA', 'GUZMAN SIALER', 1, '62', 45, 'Peruana', 'no aplica', 'MARTHA OTILIA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(97, 'LUZMILA', 'CORNETERO BANCES', 1, '17409191', 45, 'Peruana', 'no aplica', 'LUZMILA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(98, 'PAULA', 'SALCEDO CARMONA', 1, '17434426', 45, 'Peruana', 'no aplica', 'PAULA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(99, 'OLGA', 'PORTOCARRERO CHAMBERGO', 1, '17435721', 45, 'Peruana', 'no aplica', 'OLGA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(100, 'OSWALDO', 'RAMIREZ CARLOS', 1, '17435883', 45, 'Peruana', 'no aplica', 'OSWALDO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(101, 'GONZALO', 'SILVA ALDANA', 1, '40968597', 45, 'Peruana', 'no aplica', 'GONZALO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(102, 'XIOMARA', 'RAMIREZ MENDO', 1, '63', 45, 'Peruana', 'no aplica', 'XIOMARA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(103, 'KEYSI ANALI', 'LA CHIRA PEREZ', 1, '62922726', 45, 'Peruana', 'no aplica', 'KEYSI ANALI@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(104, 'MARIBEL', 'BURGA TELLO', 1, '17433033', 45, 'Peruana', 'no aplica', 'MARIBEL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(105, 'MIGUEL ANGEL', 'GUTIERREZ TEMOCHE', 1, '40118478', 45, 'Peruana', 'no aplica', 'MIGUEL ANGEL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(106, 'MARIA MERCEDES', 'MORI TENORIO', 1, '43450925', 45, 'Peruana', 'no aplica', 'MARIA MERCEDES@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(107, 'ADRIANO FERNANDO', 'LEON SUYSUY', 1, '67', 45, 'Peruana', 'no aplica', 'ADRIANO FERNANDO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(108, 'RODRIGO FERNANDO', 'LEON SUYSUY', 1, '68', 45, 'Peruana', 'no aplica', 'RODRIGO FERNANDO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(109, 'MARIA ESPERANZA', 'BARRERA LOPEZ', 1, '17404135', 45, 'Peruana', 'no aplica', 'MARIA ESPERANZA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(110, 'LEONARDO', 'VENTURA GAMARRA', 1, '70', 45, 'Peruana', 'no aplica', 'LEONARDO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(111, 'DAVID', 'BERNILLA ACU?A', 1, '71', 45, 'Peruana', 'no aplica', 'DAVID@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(112, 'MANUEL', 'REUPO CHAMBERGO', 1, '72', 45, 'Peruana', 'no aplica', 'MANUEL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(113, 'NINFA', 'VASQUEZ GONZALES', 1, '73', 45, 'Peruana', 'no aplica', 'NINFA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(114, 'ROXANA', 'CARLOS ROJAS', 1, '74', 45, 'Peruana', 'no aplica', 'ROXANA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(115, 'FELIX', 'DE LA CRUZ VELASQUEZ', 1, '17428616', 45, 'Peruana', 'no aplica', 'FELIX@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(116, 'CLAUDIA', 'VILLEGAS CHICOMA', 1, '76', 45, 'Peruana', 'no aplica', 'CLAUDIA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(117, 'YENI', 'MONJE MACALOPU', 1, '40672524', 45, 'Peruana', 'no aplica', 'YENI@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(118, 'MOISES', 'BUSTAMANTE CARMONA', 1, '17433481', 45, 'Peruana', 'no aplica', 'MOISES@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(119, 'JOSE', 'RAMIREZ PALACIOS', 1, '17405382', 45, 'Peruana', 'no aplica', 'JOSE@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(120, 'JOHARY', ' DE LA CRUZ SANCHEZ', 1, '78', 45, 'Peruana', 'no aplica', 'JOHARY@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(121, 'MARIA', 'PISCOYA DE GUILLERMO', 1, '17402339', 45, 'Peruana', 'no aplica', 'MARIA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(122, 'FIORELLA ESPERANZA', 'SIADEN SANCHEZ', 1, '82', 45, 'Peruana', 'no aplica', 'FIORELLA ESPERANZA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(123, 'MARCOS', 'CHANAME JUAREZ', 1, '17454234', 45, 'Peruana', 'no aplica', 'MARCOS@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(124, 'LUZ ANGELES', 'MONTALVO SALAZAR', 1, '83', 45, 'Peruana', 'no aplica', 'LUZ ANGELES@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(125, 'JEAN POOL', 'RAMIREZ LUCERO', 1, '84', 45, 'Peruana', 'no aplica', 'JEAN POOL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(126, 'HENRY', 'MONTALVO DIAZ', 1, '41644310', 45, 'Peruana', 'no aplica', 'HENRY@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(127, 'ALISON', 'IDROGO MEO?O', 1, '61543014', 45, 'Peruana', 'no aplica', 'ALISON@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(128, 'MARIA FERNANDA', 'MANAYAY CARLOS', 1, '62862856', 45, 'Peruana', 'no aplica', 'MARIA FERNANDA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(129, 'JORGE', 'REUPO CHAVARRI', 1, '17409157', 45, 'Peruana', 'no aplica', 'JORGE@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(130, 'MERLI', 'FARRO PUEMAPE', 1, '42183645', 45, 'Peruana', 'no aplica', 'MERLI@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(131, 'JESUS ANTONIO ', 'RIVAS ALCALDE', 1, '89', 45, 'Peruana', 'no aplica', 'JESUS ANTONIO @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(132, 'LUIS CRISTOFER ', 'MESONES REYES', 1, '90', 45, 'Peruana', 'no aplica', 'LUIS CRISTOFER @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(133, 'CRISTOFER DANILSON', 'ORTIZ SIESQUEN ', 1, '91', 45, 'Peruana', 'no aplica', 'CRISTOFER DANILSON@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(134, 'NAOMI YOVANA ', 'TARRILLO RAMIREZ', 1, '92', 45, 'Peruana', 'no aplica', 'NAOMI YOVANA @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(135, 'KIRAN KAHORI', 'CHENTA RAMOS', 1, '93', 45, 'Peruana', 'no aplica', 'KIRAN KAHORI@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(136, 'MANUEL', 'SIESQUEN SILVA', 1, '40714306', 45, 'Peruana', 'no aplica', 'MANUEL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(137, 'PAULA YOLANDA', 'DIAZ RUIZ', 1, '17427838', 45, 'Peruana', 'no aplica', 'PAULA YOLANDA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(138, 'PETRONILA', 'CASIANO CHAVESTA', 1, '17408764', 45, 'Peruana', 'no aplica', 'PETRONILA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(139, 'CRISTINA ', 'PAICO HUAMAN', 1, '17430472', 45, 'Peruana', 'no aplica', 'CRISTINA @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(140, 'FRANCISCA', 'VALDERA LLONTOP', 1, '17404071', 45, 'Peruana', 'no aplica', 'FRANCISCA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(141, 'ELIAS', 'ASALDE BENITES', 1, '17423267', 45, 'Peruana', 'no aplica', 'ELIAS@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(142, 'JEMIMA NICOLLE', 'LUCERO LLONTOP', 1, '61804759', 45, 'Peruana', 'no aplica', 'JEMIMA NICOLLE@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(143, 'JUANA ROSA', 'ACOSTA SANTISTEBAN', 1, '17405358', 45, 'Peruana', 'no aplica', 'JUANA ROSA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(144, 'ROBERTO', 'ZULOETA GONZALES', 1, '17447746', 45, 'Peruana', 'no aplica', 'ROBERTO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(145, 'PERCY JHONATAN', 'NI?OPE SANCHEZ', 1, '73664062', 45, 'Peruana', 'no aplica', 'PERCY JHONATAN@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(146, 'THIAGO ', 'MONTENEGRO VASQUEZ', 1, '96', 45, 'Peruana', 'no aplica', 'THIAGO @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(147, 'FREDY FABIAN', 'FLORES SIADEN', 1, '97', 45, 'Peruana', 'no aplica', 'FREDY FABIAN@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(148, 'GANSS JORDAN', 'RENTERIA MEO?O', 1, '98', 45, 'Peruana', 'no aplica', 'GANSS JORDAN@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(149, 'MAGALY', 'DEL  MAESTRO MORALES', 1, '44333400', 45, 'Peruana', 'no aplica', 'MAGALY@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(150, 'EDWIN ', 'OLAYA FLORES', 1, '41468512', 45, 'Peruana', 'no aplica', 'EDWIN @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(151, 'YOLANDA ', 'BONILLA AGURTO', 1, '17410692', 45, 'Peruana', 'no aplica', 'YOLANDA @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(152, 'ELVA ', 'CHIROQUE IZAGA ', 1, '17445889', 45, 'Peruana', 'no aplica', 'ELVA @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(153, 'VERONICA ', 'CASTRO MACALOPU', 1, '40712708', 45, 'Peruana', 'no aplica', 'VERONICA @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(154, 'RAFAEL', 'CHAFI MINGUILLO', 1, '99', 45, 'Peruana', 'no aplica', 'RAFAEL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(155, 'ELMER', 'PURIZACA COBE?AS', 1, '41152521', 45, 'Peruana', 'no aplica', 'ELMER@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(156, 'MARIA ESTHER ', 'MANAYAY CAYACA ', 1, '100', 45, 'Peruana', 'no aplica', 'MARIA ESTHER @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(157, 'BRIANA', 'ESPINOZA BARBA ', 1, '101', 45, 'Peruana', 'no aplica', 'BRIANA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(158, 'JOSUE', 'VASQUEZ GAMONAL', 1, '102', 45, 'Peruana', 'no aplica', 'JOSUE@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(159, 'JOSE', 'HERRERA RELAYZA', 1, '17420002', 45, 'Peruana', 'no aplica', 'JOSE@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(160, 'MARIA ', 'ALBURUQUEQUE BRENIS', 1, '17402872', 45, 'Peruana', 'no aplica', 'MARIA @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(161, 'MANUELA', 'LEONARDO BONILLA', 1, '161', 45, 'Peruana', 'no aplica', 'MANUELA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(162, 'SARAI', 'CAJUSOL SANTAMARIA', 1, '104', 45, 'Peruana', 'no aplica', 'SARAI@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(163, 'NICOLL MIRELLY', 'GINES CADENA', 1, '77885772', 45, 'Peruana', 'no aplica', 'NICOLL MIRELLY@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(164, 'MILAGROS ESTEFANIA', 'SAMAME RODRIGUEZ', 1, '73584104', 45, 'Peruana', 'no aplica', 'MILAGROS ESTEFANIA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(165, 'CONCEPCION', 'TARRILLO CARRANZA', 1, '33570682', 45, 'Peruana', 'no aplica', 'CONCEPCION@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(166, 'DANIEL', 'FERNANDEZ FERNANDEZ', 1, '166', 45, 'Peruana', 'no aplica', 'DANIEL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(167, 'ANICETA', 'SANCHEZ MANAYAY', 1, '107', 45, 'Peruana', 'no aplica', 'ANICETA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(168, 'DIANA CAROLINA', 'CARRASCO AQUINO', 1, '73658977', 45, 'Peruana', 'no aplica', 'DIANA CAROLINA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(169, 'CARMEN', 'VASQUEZ GREYCI', 1, '108', 45, 'Peruana', 'no aplica', 'CARMEN@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(170, 'ROSARIO', 'PISCOYA BANCES', 1, '17433657', 45, 'Peruana', 'no aplica', 'ROSARIO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(171, 'ALICIA', 'ESPINOZA DELGADO', 1, '17400348', 45, 'Peruana', 'no aplica', 'ALICIA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(172, 'JUANA', 'VENTURA VIDAURRE', 1, '109', 45, 'Peruana', 'no aplica', 'JUANA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(173, 'EDWIN MANUEL', 'BALLONA CORNETERO', 1, '62922799', 45, 'Peruana', 'no aplica', 'EDWIN MANUEL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(174, 'KEREN CESIA', 'SANTAMARIA ZAMBRANO', 1, '110', 45, 'Peruana', 'no aplica', 'KEREN CESIA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(175, 'SAMUEL JOSIAS', 'MANALLAY SANTISTEBAN', 1, '43949360', 45, 'Peruana', 'no aplica', 'SAMUEL JOSIAS@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(176, 'ROSA', 'BANCES FLORES', 1, '111', 45, 'Peruana', 'no aplica', 'ROSA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(177, 'JOSE LUIS ', 'BANCES FARFAN', 1, '112', 45, 'Peruana', 'no aplica', 'JOSE LUIS @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(178, 'ANDREA', 'NECIOSUP BOBADILLA', 1, '113', 45, 'Peruana', 'no aplica', 'ANDREA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(179, 'ELKY SOLEDAD', 'HOYOS NU?EZ', 1, '17432844', 45, 'Peruana', 'no aplica', 'ELKY SOLEDAD@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(180, 'JOSE LUIS ', 'PAZ TEMOCHE', 1, '17452222', 45, 'Peruana', 'no aplica', 'JOSE LUIS @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(181, 'MARIO JHOVANY', 'REYES GUILLERMO', 1, '114', 45, 'Peruana', 'no aplica', 'MARIO JHOVANY@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(182, 'FRANK CARLOS', 'SAMAME BUSTAMANTE', 1, '43598798', 45, 'Peruana', 'no aplica', 'FRANK CARLOS@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(183, 'JOSE DANIEL', 'MORI SANTAMARIA', 1, '115', 45, 'Peruana', 'no aplica', 'JOSE DANIEL@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(184, 'HILDA', 'CARLOS ROJAS', 1, '47830611', 45, 'Peruana', 'no aplica', 'HILDA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(185, 'JUAN JOSE', 'SANDOVAL MARCELO', 1, '17452782', 45, 'Peruana', 'no aplica', 'JUAN JOSE@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(186, 'JAZURY DEL MILAGRO', 'VILCABANA CHAVESTA', 1, '116', 45, 'Peruana', 'no aplica', 'JAZURY DEL MILAGRO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(187, 'JUAN HILARION', 'GIL NECIOSUP', 1, '17408962', 45, 'Peruana', 'no aplica', 'JUAN HILARION@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(188, 'YESENIA NATALI', 'RUIZ MORENO', 1, '42846961', 45, 'Peruana', 'no aplica', 'YESENIA NATALI@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(189, 'KEVIN ALEXANDER', 'PAZ CASIANO', 1, '76442354', 45, 'Peruana', 'no aplica', 'KEVIN ALEXANDER@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(190, 'PAULINA', 'CARLOS RAMIREZ', 1, '118', 45, 'Peruana', 'no aplica', 'PAULINA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(191, 'KAMILA YIDA', 'SUYSUY RUMICHE', 1, '119', 45, 'Peruana', 'no aplica', 'KAMILA YIDA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(192, 'JHONATAN DAVID ', 'MONTERO VENTURA', 1, '120', 45, 'Peruana', 'no aplica', 'JHONATAN DAVID @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(193, 'GABRIELA YUDITH', 'GUTIERREZ BALCAZAR', 1, '121', 45, 'Peruana', 'no aplica', 'GABRIELA YUDITH@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(194, 'CARMEN DEL PILAR', 'SALAZAR BACA', 1, '8684127', 45, 'Peruana', 'no aplica', 'CARMEN DEL PILAR@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(195, 'ANGHELO', 'VILLEGAS MANAYAY', 1, '122', 45, 'Peruana', 'no aplica', 'ANGHELO@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(196, 'DAYANA', 'GUERRERO MANAYAY', 1, '73678402', 45, 'Peruana', 'no aplica', 'DAYANA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(197, 'ADOLFO MATIAS ', 'MARCELO DIAZ', 1, '124', 45, 'Peruana', 'no aplica', 'ADOLFO MATIAS @gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(198, 'RUTH ESMERALDA', 'CARBONEL SIADEN', 1, '73607530', 45, 'Peruana', 'no aplica', 'RUTH ESMERALDA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(199, 'GREYSS XIOMARA', 'FLORES SEGUNDO', 1, '126', 45, 'Peruana', 'no aplica', 'GREYSS XIOMARA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(200, 'DIANA VALENTINA', 'MANAYAY MONJA', 1, '63090623', 45, 'Peruana', 'no aplica', 'DIANA VALENTINA@gmail.com', '985136795', '2000-09-30', 'Ferre?afe', 'M', 0),
(201, 'Gustavo Adolfo', 'Requejo Mejia', 1, '46746888', 30, 'Peruana', 'Biomed', 'Gustavo@gmail.com', '985136795', '1992-01-28', 'Ferreñafe', 'M', 0),
(202, 'Alex Eduardo', 'Ramirez Mejia', 4, '17446515', 45, 'Peruana', 'no aplica', 'Alex@gmail.com', '985136795', '1972-01-03', 'Ferreñafe', 'M', 0),
(203, 'Juan Tomás Gerald', 'Carranza Morales', 1, '72695477', 0, 'Peruana', 'ARGLED', 'gcamo@hotmail.com', '912816198', '1999-08-05', 'Mz R Lt 5 URB Vista Alegre - Galilea - Carretera a ferreñafe', 'M', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `Id_producto` int(4) NOT NULL,
  `Id_Categoria` int(3) NOT NULL,
  `Reg_sanitario` varchar(50) CHARACTER SET utf8 NOT NULL,
  `Nombre_producto` varchar(80) CHARACTER SET utf8 NOT NULL,
  `Precio_compra` decimal(15,2) NOT NULL,
  `Precio_venta` decimal(15,2) NOT NULL,
  `Concentracion_producto` varchar(80) CHARACTER SET utf8 NOT NULL,
  `eliminado` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`Id_producto`, `Id_Categoria`, `Reg_sanitario`, `Nombre_producto`, `Precio_compra`, `Precio_venta`, `Concentracion_producto`, `eliminado`) VALUES
(58, 3, 'EE-06501', 'AGUA DESTILADA', '0.40', '1.00', 'AGUA DESTILADA DE 5 ml', 0),
(59, 3, '', 'Aguja Nº 23', '0.10', '0.20', '', 0),
(60, 3, '', 'Aguja Nº 22', '0.10', '0.20', '', 0),
(68, 16, 'EE-06461', 'MOVULAN 250 mg', '14.60', '20.00', 'Amoxicilina 250 mg +Acido Clavulamico 62.5 mg/5 ml', 0),
(69, 6, 'EE-04442', 'CLORFENAMINA', '0.69', '2.50', 'Clorenamina 10 mg', 0),
(71, 8, '', 'DEXAOFTAL', '9.50', '14.50', 'dexametasona 1 mg/ml', 0),
(74, 6, 'en-00412', 'Dextrosa  33   ,3%', '2.00', '4.00', 'Destroxa de 33 ,3%', 0),
(76, 6, 'EE-03353', 'DICLOFENACO', '3.55', '6.00', 'Diclofenaco 75 mg', 0),
(83, 6, 'EE-03960', 'FUROSEMIDA', '2.00', '4.50', 'Furosemida 20 mg', 0),
(86, 6, 'EE-03777', 'KETOPROFFENO', '2.00', '6.00', 'Ketoprofeno 100 mg/ 2 ml', 0),
(89, 3, 'DM12259', 'JERINGAS TUBERCULINA', '0.30', '1.00', '', 0),
(90, 3, 'DM  12564E', 'JERINGA DE 3CC', '0.20', '0.50', '', 0),
(91, 3, 'DM 13531E', 'JERINGA DE 5CC', '0.20', '0.50', '', 0),
(92, 3, 'DM-4832E', 'JERINGA DE 20 CC', '0.50', '1.00', '', 0),
(93, 6, 'EE-08988', 'LIDOCAINA', '3.00', '8.00', 'Lidocaina 2%', 0),
(94, 8, '', 'OTOMICIM', '13.00', '18.00', '', 0),
(95, 6, 'EE-03297', 'DOLO NEUROBION FORTE   DC', '38.50', '47.00', 'VIT. B1+VIT. B6+VIT. B12  Y DICLOFENACO', 0),
(96, 6, 'Nº EE-08467', 'METAMIZOL SODICO', '2.00', '6.00', 'metamizol 1 gr/ 2 ml', 0),
(98, 6, 'EE- 09101', 'METOCLOPRAMIDA', '1.00', '4.00', 'Metoclopramida 10mg/ 2ml', 0),
(102, 4, 'R.S-EN-03839', 'REPRIMAN', '0.20', '0.50', 'metamizol 500 mg', 0),
(107, 6, 'EN-05155', 'GRAVICOR', '1.50', '3.00', 'Dimenhidrinato 50 mg/ 5 ml', 0),
(115, 5, 'EN-01152', 'DOXCIL', '1.70', '3.00', 'Dobesilato de calcio 500 mg', 0),
(116, 4, 'EN-03041', 'Flexol', '2.00', '2.80', 'Meloxicam de 15 mg', 0),
(118, 6, 'EE-05817', 'HIDROCORTISONA 250 mg', '12.70', '18.00', 'Hidrocortisona 250 mg', 0),
(126, 1, 'EN-04394', 'CEFALEXINA', '5.50', '10.00', ' 250 mg/ 5 ml', 0),
(127, 6, '', 'Diazepam', '1.00', '3.50', 'Diazepam 10 mg / 2ml', 0),
(134, 8, 'EN-06677', 'Clenbuvent', '18.08', '23.00', 'Clenbuterol + Ambroxol', 0),
(136, 6, '', 'Cloruro de Sodio de 10 ml', '0.90', '2.00', 'Cloruro de sodio 9/000', 0),
(139, 5, 'EN-03996', 'Urotan -D', '1.10', '1.90', 'Diclofenaco, Fenazopiridina', 0),
(143, 4, 'EN-05359', 'GEMFIBROZILO', '0.35', '0.70', 'Gemfibrozilo 600 mg', 0),
(151, 1, 'EN- 00435', 'LACTULOSA', '14.00', '20.00', 'Lactolosa 3.33g/ 5ml', 0),
(152, 3, 'DM7148E', 'GASA ESTERIL', '0.80', '2.00', 'Gasa de 10 x 10 x 5 esteril', 0),
(158, 3, '', 'Mascarilla Nebulizacion Adulto', '8.00', '12.00', 'Mascarilla para nebulizar', 0),
(167, 1, 'EN-00780', 'ELITON CIP AP', '23.99', '30.00', 'Sulfato Ferroso +B1+B2+B6', 0),
(183, 6, 'EE-06981', 'CEFTRIMAX', '7.54', '13.00', 'ceftriaxona 1 gr', 0),
(184, 3, '', 'Electrolight', '2.60', '3.50', ' 800 ml', 0),
(187, 17, 'EN-02537', 'SUERO FISIOLOGICO  1 LT', '4.80', '8.50', 'Clor. sodio  de 9 % ', 0),
(193, 4, 'EN-03779', 'Alprazolam', '0.10', '0.30', '0.5 mg', 0),
(194, 3, 'DM0246N', 'Nylon Azul 2-0', '5.00', '9.00', 'Nylon 75 cm', 0),
(195, 3, 'DM 0246N', 'Nylon Azul 3-0', '3.50', '7.00', 'Nylon 75 cm', 0),
(196, 3, 'DM 0246N', 'Nylon Aul 4-0', '3.50', '7.00', 'Nylon 75 cm', 0),
(197, 3, '', 'Seda negra 3-0', '4.50', '8.50', 'Seda de 75 cm', 0),
(198, 3, 'DM3167E', 'Bisturi N° 21', '0.40', '2.00', '', 0),
(199, 3, 'DM3167E', 'Bisturi N° 23', '0.40', '2.00', '', 0),
(204, 4, 'EE-00064', 'ATORVASTATINA 40MG', '0.65', '1.00', 'Atorvastatina 40mg', 0),
(206, 4, 'EE-07712', 'PENTRAX DUO', '1.80', '2.50', 'Amoxicilina 1000 mg ', 0),
(207, 4, 'EE- 04078', 'KETESSE', '2.40', '4.00', 'Dexketoprofeno 25 mg', 0),
(208, 7, ' EN-05905', 'C-derm', '11.00', '17.00', 'clotrimazol, Gentam, Betamet', 0),
(217, 6, ' Nº22867', 'CEFACROL 1 gr', '14.38', '17.00', ' ceftriaxona 1 gr', 0),
(220, 3, 'DM18213E', 'Guante Quirurgico N° 8', '1.70', '3.00', '', 0),
(221, 6, 'E-10970 :', 'Plidan Compuesto', '19.00', '25.00', 'plidan  compuesto  NF', 0),
(225, 7, 'EE-03950', 'ACIDO FUSIDICO', '18.80', '24.00', '2%', 0),
(226, 6, 'EE- 01344', 'Betametasona    INDIVIDUAL', '6.40', '10.50', 'betametasona 4 mg/ ml', 0),
(227, 4, 'EE-07532', 'PENTRAX AC', '3.20', '4.50', 'Amoxicilina 875 mg +Acido Clavulamico 125mg/5 ml', 0),
(231, 15, '', 'VACUNA GEL NB', '3.74', '6.50', 'PROBIOTICA', 0),
(235, 3, 'DM17144E', 'ESPARADRAPO ', '3.60', '6.00', '5 X 2.5. cm', 0),
(236, 3, '', 'ALCOHOL 96º', '0.80', '1.30', '120 ml', 0),
(238, 3, 'DM 0025 N', 'VENDAS  N° 5', '2.00', '4.00', '', 0),
(241, 5, 'EN-07755', 'ESSOMAXX 40', '0.80', '1.50', 'Esomeprazol 40 mg', 0),
(243, 3, 'DM 6082 E', 'MASCARILLA CON RESERVORIO', '4.00', '8.00', '', 0),
(252, 4, '', 'Tiazid', '1.30', '2.00', '25 mg', 0),
(266, 4, '', 'SIMTAS - 20', '1.60', '2.60', '', 0),
(271, 8, 'r.s. Nº N-2679', 'REPRIMAN', '9.00', '13.50', 'metamizol 400 mg/ 1 ml', 0),
(274, 1, ' EN-03275', 'CEFACLOR', '18.00', '24.00', 'Cefacrol 250 mg/ 5 ml', 0),
(275, 5, '', 'Modul Compuesto', '0.80', '1.50', '', 0),
(276, 4, 'EN-07322', 'REDEX  ', '1.56', '2.80', 'Clorzoxazona 250 mg+DICLOFENACO SODICO 50mg', 0),
(277, 27, 'EE-02546', 'CIPROF- 200', '4.50', '8.00', 'Ciprofloxaciono 200 mg/ 100 ml', 0),
(284, 3, 'N-19432', 'ELECTRORAL PEDIATRICO', '11.00', '16.00', '', 0),
(286, 7, '', 'HEMORSAN', '21.00', '26.00', '', 0),
(287, 9, 'EN-07233', 'ACETILCISTEINA 600 mg', '1.20', '2.20', 'acetilcisteina 600 mg', 0),
(291, 4, 'EN-00112', 'GRAVEX', '0.45', '0.90', 'dIMENHIDRINATO 50 mg', 0),
(292, 12, '', 'PRECID 50 mg', '1.00', '2.00', 'Prednisona 50 mg', 0),
(299, 3, '', 'SONDA FOLEY#14', '5.00', '10.00', '', 0),
(302, 3, '', 'CATGUT CRÓMICO 0-3', '6.00', '10.00', '', 0),
(303, 1, 'EN-01635', 'CLARITROMICINA 250 mg', '15.00', '24.00', '250 MG/5 ML', 0),
(309, 3, '', 'Mascarilla Nebulizacion Pedia.', '8.00', '12.00', 'mascarilla para nebulizar', 0),
(310, 3, '', 'Bisturi N° 24', '0.00', '2.00', '', 0),
(311, 3, '', 'Bisturi N° 15', '0.30', '2.00', '', 0),
(312, 3, 'DM 8077E', 'Bisturi N° 10', '0.40', '2.00', '', 0),
(314, 5, 'N-  26017', 'FLATUZYM', '0.80', '1.50', 'Flatuzym', 0),
(315, 6, 'EE - 80207', 'AMIKACINA 500 mg', '2.00', '6.00', 'Amikacina 500 mg', 0),
(316, 4, 'NºEE-01614', 'CLOPIDOGREL', '1.10', '1.90', '75 mg', 0),
(317, 4, 'Nº EN-06688', 'LEVOGRAM', '0.50', '1.30', 'Levocetiricina 5 mg', 0),
(319, 6, 'EE-08106', 'MUXATIL 300 mg', '14.00', '18.00', 'Acetilcisteina 300 mg/3ml', 0),
(321, 3, 'DM  12489E', 'BOLSA COLECTORA  NIÑOS', '0.66', '1.00', '', 0),
(326, 4, 'EN- 02735', 'LOSARTAN 50 mg', '0.20', '0.50', 'Losartan 50 mg', 0),
(327, 4, 'Nº En-01791', 'AMLODIPINO  10MG', '0.20', '0.40', '10 MG', 0),
(328, 4, 'EN-05437', 'ATORVASTATINA 40 mg', '0.66', '1.00', 'Atorvastatina 40 mg', 0),
(329, 5, 'EE-04782', 'CLINDAPHARM', '0.50', '1.00', 'Clindamicina 300 mg', 0),
(332, 3, '', 'Bisturi N° 20', '0.40', '2.00', '', 0),
(334, 6, 'EE-05103', 'LINCOMICINA 600 mg/ 2 ml', '2.40', '6.40', '600 mg/ 2ml', 0),
(335, 1, 'NN-31234/15', 'TONICO INTI', '24.00', '29.50', '200 ml', 0),
(343, 5, 'EN-02428', 'FLUCONT', '0.90', '3.00', 'Fluconazol 150  mg', 0),
(344, 4, 'EN-03825', 'CARBAMAZEPINA', '0.15', '0.50', '200 mg', 0),
(346, 3, 'EE-02643', 'ACTERIL', '15.00', '20.00', 'SALBUTAMOL 5MG/ML', 0),
(348, 4, 'EE-08567', 'TINIDAZOL', '1.00', '1.70', 'Tinidazol 500 mg', 0),
(350, 3, 'MG-100CV-WB', 'volutrol', '3.20', '7.00', '', 0),
(351, 3, 'DM   -18586e', 'equipo de venoclisis', '1.50', '2.50', '', 0),
(352, 3, 'DM 15153E', 'Guante Quirurgico N° 7.5', '1.70', '3.00', 'GUANTE N° 7.5', 0),
(353, 3, 'DM 8132E', 'GUANTE QUIRURGICO 7 1/2', '1.70', '3.00', '', 0),
(354, 3, 'SIN REGISTRO', 'ELECTROLIGHT  475', '1.85', '2.50', '400 ML', 0),
(358, 18, '', 'Intramuscular', '1.00', '1.00', 'Intramuscular', 0),
(359, 18, '', 'Endovenoso', '5.00', '5.00', 'Endovenoso', 0),
(360, 18, '', 'Prueba de Sensibilidad', '5.00', '8.00', 'Prueba de Sensibilidad', 0),
(361, 6, '', 'MELSOL', '7.65', '12.50', 'meloxican 15mg', 0),
(364, 4, '', 'ESPECTRIM BALSAMICO', '0.50', '1.00', '', 0),
(366, 18, '', 'Colocacion de Via', '20.00', '20.00', '', 0),
(367, 3, '', 'GLUCOSA PARA PRUEBA TOLERANCI', '6.50', '10.00', '', 0),
(368, 3, '', 'AGUA MINERAL', '0.60', '1.00', '', 0),
(369, 18, '', 'TOMA DE PRESION', '0.00', '1.00', '', 0),
(370, 12, 'EE-01329', 'BUSCAPINA COMPUESTA', '1.20', '1.90', 'hiocina-n-butilbromuro-paacetamol', 0),
(371, 6, 'EE-08476', 'atropina 0.5 mg', '2.00', '4.50', 'Atropina 0.5 mg', 0),
(372, 4, 'NG-2131', 'PREDNISONA  50mg', '0.80', '1.50', 'Prednisona 50 mg', 0),
(375, 1, 'EN-08329', 'ENTEROXOL', '14.83', '20.00', 'Furazolidona 50 mg/ 15 ml', 0),
(378, 6, 'EE- 00360', 'HIDROCORTISONA 100 mg', '6.90', '12.00', 'Hidrocortisona 100 mg', 0),
(379, 3, '', 'VENDAS  N° 6', '1.80', '3.00', '', 0),
(380, 3, '', 'NYLON AZUL N°5/0', '3.60', '8.00', '', 0),
(382, 17, 'EN- 02523', 'DEXTROSA 5%', '4.50', '13.00', 'solucion   INYECTABLE 5%', 0),
(383, 4, 'EE-03039', 'CAPTOPRIL 50 mg.', '0.25', '0.50', 'captopril 50 mg', 0),
(389, 17, '', 'ENERUP PREMIUM', '35.00', '45.00', '', 0),
(390, 7, 'EE-00866', 'DICLOFENACO GEL  1%', '4.62', '7.50', 'Diclofenaco 1%', 0),
(391, 5, '', 'GRAVOL  CB', '2.50', '3.20', 'Dimenhidrinato 50 mg', 0),
(392, 3, 'DM 13531E', 'JERINGA 10 ml', '0.30', '1.00', '', 0),
(394, 12, 'EN-  00090', 'TERBICEL', '2.60', '3.80', 'Terbinafina 250 mg', 0),
(396, 6, 'EE-01017', 'FLUIMUCIL', '13.50', '18.00', 'Acetilcisteina 300 mg/dl', 0),
(397, 1, 'RS EN-03980', 'BISMOSAN', '9.80', '15.00', 'subsalicilato de bismuto 87.33 mg', 0),
(401, 4, '', 'NOXON 200 mg', '3.10', '4.50', 'Nitazoxanida 200 mg', 0),
(404, 6, 'EN-04277', 'CLORURO DE POTASIO  (KALIUM)', '1.90', '5.00', 'CLORURO DE POTASIO 20%', 0),
(405, 18, '', 'NEBULIZACION', '0.00', '20.00', '', 0),
(406, 6, 'EE-00897', 'CLORURO DE  SODIO 20%', '2.16', '5.00', 'cLORURO DE SODIO 20%', 0),
(407, 16, 'NG- 1949', 'SOLUCION POLIELECTROLITICA', '13.50', '19.00', 'GLUCOSA ANHIRRA  LACTADO DE SODIO', 0),
(408, 16, 'Nº En-08115', 'ZITROBAC Pediatrico', '7.00', '12.00', 'Azitromicina 200 mg/ 5 ml', 0),
(409, 3, 'DM12793E', 'ABOCAT N° 24', '1.70', '3.00', 'ABOCAT N° 24', 0),
(411, 3, 'DM 17307E', 'VENDAS N° 4', '1.20', '3.00', '', 0),
(418, 19, ' N°EE- 01904', 'SALBUSEV  HFA 200', '8.10', '13.50', 'SALBUTAMOL 100 mcg/dosis', 0),
(419, 3, '', 'AEROCAMARA PEDIATRICA', '9.00', '13.50', '', 0),
(420, 3, 'DM0493N', 'AEROCAMARA ADULTO', '9.00', '13.50', '', 0),
(423, 6, '', 'MEROPENEM 500 mg', '16.00', '24.00', '500 mg.', 0),
(426, 9, 'EN- 06826', 'MUXATIL 200 mg', '1.30', '2.50', 'acetilcisteina 200 mg', 0),
(431, 4, '', 'UVEXIL 200 mg', '2.60', '3.00', 'flavoxato clorhidrato', 0),
(435, 5, ' EE-02329', 'AMOXICILINA 500 mg', '0.60', '1.20', 'amoxicilina 500 mg', 0),
(436, 4, 'EN-07388', 'LOVOFLOXACINO 500 mg', '0.64', '2.50', 'LEVOFLOXACINO 500 mg', 0),
(439, 1, 'EN-00312', 'FLUIMAX', '18.24', '23.50', 'ACETILCISTEINA 100 mg/ 5 ml', 0),
(442, 12, '', 'NISOPREX', '1.10', '1.60', 'Prednisona 20 mg', 0),
(448, 8, 'EN-01373', 'ZETALER', '23.78', '28.50', 'CETIRIZINA 10 mg', 0),
(450, 1, 'EN- 07976', 'CETIRIZINA', '4.10', '9.50', 'Cetirizina Diclorhidrato 5 mg/ 5 ml', 0),
(451, 8, '', 'ZETALER . D', '24.25', '29.30', 'Cetirizina- Pseudoefedrina', 0),
(456, 6, '', 'SUCROFER 100 mg/ 5 ml', '4.00', '15.00', 'hierro sucrosa', 0),
(459, 4, 'EN-06857', 'NOXON  500-mg', '3.50', '6.00', 'Nitazoxanida 500 mg', 0),
(461, 6, 'EE-03316', 'GENTAMICINA 160 mg', '3.00', '8.00', 'Gentamicina 160 mG', 0),
(463, 6, 'EE-00751', 'PENICILINA BENZATINICA', '3.00', '10.00', 'Penicilina1 200,000', 0),
(465, 4, 'EN-01323', 'ENALAPRIL 10 mg', '0.10', '0.20', 'Enalapril 10 mg', 0),
(466, 4, 'EN-04768', 'ENALAPRIL 20 mg', '0.10', '0.30', 'Enalapril 20 mg', 0),
(467, 4, 'EN-01460', 'HIDROCLOROTIAZIDA 25 mg', '0.10', '0.30', 'Hidroclorotiazida 25 mg', 0),
(469, 1, '', 'FUROXONA', '23.30', '28.00', 'Furazolidona 16.66 mg/ 5 ml', 0),
(470, 3, '', 'HIDRAX', '10.50', '15.00', '', 0),
(471, 13, 'N- 20872', 'GYNOVAL', '3.15', '4.70', 'TINIDAZOL + MICONAZOL', 0),
(475, 4, ' EN- 05986', 'NAPROXENO', '0.30', '0.60', 'Naproxeno  550MG', 0),
(480, 3, '', '', '0.00', '0.00', '', 0),
(485, 4, 'RS Nº EE-07610', 'ACICLAV 500 mg', '1.87', '2.50', 'amoxilina 500 mg + Ac Clavulamico 125', 0),
(486, 16, '', 'FURAZOLIDONA', '2.80', '7.00', '50 mg/15 ml', 0),
(489, 7, '', 'DESTOLIT', '24.10', '30.00', '', 0),
(490, 4, 'EN-00722', 'DEFLAZACORT 6 mg', '0.90', '2.10', 'Deflazacort 6 mg', 0),
(493, 4, 'EN-04121', 'CEFADROXILO', '0.78', '1.50', 'tabletas 500 mg', 0),
(494, 3, 'DM 7082E', 'BOLSA COLECTORA ADULTO', '3.50', '5.00', '2 LITROS', 0),
(496, 5, 'EN - 04084', 'CEFALEXINA', '0.40', '0.80', 'CEFALEXINA 500 mg', 0),
(497, 4, 'EN-0493', 'GLIBENCLAMIDA', '0.10', '0.30', 'Glibenclamida 5 mg', 0),
(501, 1, 'EN-02670', 'ELITON FORTE', '28.00', '35.00', 'Hierro+Nicotinamida+ Vit. b2+ Vit B 2 , B6', 0),
(512, 6, 'EE-02422', 'PENICILINA G SODICA', '3.00', '6.00', '1000000 UI', 0),
(513, 1, 'EN-03530', 'EXAZOL FORTE', '12.00', '17.00', 'SULFAMETOXAZOL + TRIMETOPRIMA 400/80/5 ml', 0),
(514, 1, ' EN-07095', 'EXAZOL', '8.20', '12.20', 'SULFAMETOXAZOL + TRIMETOPRIMA 200/40/5 ml', 0),
(515, 5, '', 'ROWATINEX', '1.40', '2.50', '', 0),
(516, 6, 'R.S. N°E-15042', 'NEUROBION DC 10000', '26.00', '36.00', 'TRIAMINA   VIT.B1  , PIRIDOXINA   VIT. B6,CIANOCOB', 0),
(517, 5, 'DE - 2776', 'HEPADINE FORTE', '0.90', '1.70', 'TIAMINA, RIBOFLAVINA, PIRIDOXINA', 0),
(518, 6, '', 'HEPABIONTA', '11.60', '16.60', 'Piridoxina, Cianocobalamina, Nicotinamida', 0),
(519, 3, 'DM15480E', 'LLAVE TRIPLE VIA CON EXTENSION', '1.50', '3.00', '', 0),
(522, 7, 'ee-00922', ' sulfadiazina de  plata 1%', '9.78', '15.00', 'sulfadiazida de plata 1 %', 0),
(525, 12, '', 'HIDROXIPLUS', '6.60', '10.00', 'Hidroxicloroquina sulfato 400 mg', 0),
(526, 6, 'EE-03278', 'MEROPENEM 1 gr', '22.00', '32.00', 'MEROPENEM 1 gr', 0),
(528, 5, 'EE - 01340', 'AMSULOSINA', '0.90', '1.90', 'Tamsulosina 0,4 mg', 0),
(536, 1, 'R.S.Nº EN-04342', 'REPRIMAN', '10.50', '15.50', 'Metamizol sodico 250 mg/ml', 0),
(539, 12, '', 'COXICAM', '0.00', '1.00', 'miloxicam 15 mgl', 0),
(541, 4, 'EN-04808', 'CEFACLOR', '1.70', '2.70', 'Cefaclor 500 mg', 0),
(542, 4, 'EN-05601', 'CLONAZEPAM ', '0.20', '0.50', 'CLONAZEPAM 0.5 mg', 0),
(543, 6, 'EE-04282', 'MELOXICAM  15 mg', '3.00', '6.00', 'meloxican 15  mg/ 1.5 ml', 0),
(544, 6, 'EE-05687', 'RILATEN', '9.00', '17.00', 'Rociverina 20 mg/2ml', 0),
(548, 17, '', 'FRASCOS PARA HECES', '0.50', '1.00', '', 0),
(549, 8, '', 'OTIDOL', '10.98', '16.00', 'Polimixina + neomicina', 0),
(551, 20, 'Nº EE-01941', 'BECLOMETASONA', '17.85', '23.00', '250mcg/dosis', 0),
(554, 16, '', 'ACI BASIC', '18.50', '24.00', 'Magaldrato 800mg + simeticona 60 mg/ 10 ml', 0),
(555, 4, ' EN-02802', 'ACICLOVIR 200 mg', '0.30', '0.80', 'aciclovir 200 mg', 0),
(556, 4, 'RS Nº EN-01793', 'ACICLOVIR 400 mg', '0.30', '1.00', 'Aciclovir 400 mg', 0),
(560, 3, '', 'OBSERVACION', '0.00', '30.00', '', 0),
(562, 4, ' EN-04767', 'PREDNISONA 20 mg', '0.20', '0.80', 'Prednisona 20 mg', 0),
(563, 6, 'EN-05928', 'ACEPOT', '18.00', '25.00', 'Betametasiona 1 gr', 0),
(565, 6, 'EE- 06293', 'OXACILINA', '2.70', '7.50', 'Oxacilina 1 gr', 0),
(566, 1, 'EE-00691', 'IBUPROFENO', '3.67', '7.00', 'IBUPROFENO 100 mg/ 5 ml', 0),
(568, 1, '', 'NEO SILENAI', '26.50', '31.00', 'DEXTROMETORFANO, CLORFENAMINA, FENILEFRINA', 0),
(570, 9, 'EN- 06657', 'FLUIMAX 600 mg', '1.80', '2.40', 'acetilcisteina 600 mg', 0),
(572, 6, 'EE- 08437', 'QUETOROL INDIVIDUAL', '10.00', '17.00', 'QUETOROLACO  60 mg', 0),
(573, 3, '', 'CAUTERIZACION', '20.00', '20.00', '', 0),
(575, 4, '', 'ERGONEX', '0.90', '2.00', 'ERgotamina 1 mg + Cafeina 100 mg', 0),
(578, 8, '', 'CIPROGRAM 0.3 %', '25.00', '45.00', 'Ciprofloxacino', 0),
(579, 8, '', 'HIDROTEARS', '29.80', '45.00', 'Hipromelosa 0.3 %', 0),
(581, 3, '', 'ESPARADRAPO2.5 X 2 YARDAS', '1.80', '3.50', '2.5 Cm X 2 YARDAS', 0),
(591, 1, 'EN-03712', 'CEFADROXILO', '13.33', '18.00', 'Cefadroxilo 250 mg/dl', 0),
(594, 18, '', 'ADMINISTRACION MEDICAMENTOS.', '0.00', '30.00', '', 0),
(597, 18, '', 'ADMIN  MEDICAM - OBSERVAC', '0.00', '50.00', '', 0),
(600, 1, '', 'NEO NISOPREX', '21.50', '27.00', 'Prednisolona 15 mg/ ml', 0),
(601, 3, '', 'TERMOMETROS', '2.16', '3.50', '', 0),
(602, 6, '', 'IMIPENEM', '26.50', '35.00', 'IMIPENEN  500 mg', 0),
(603, 1, '', 'SULPHYTRIM', '8.50', '15.00', 'sulfametoxazol 200 mg+ trimetoprima 40 mg/ 5 ml', 0),
(604, 1, '', 'SULPHYTRIM BALSAMICO', '11.50', '16.00', 'sulfametoxazol 200 mg+ trimetoprima 40 mg+ Guaifen', 0),
(605, 3, '', 'SUCUTANEA', '1.00', '2.00', '', 0),
(606, 3, '', 'BOMBILLA JEBE N° 4', '5.60', '9.00', '', 0),
(609, 6, '', 'DICLOFLAME', '1.00', '5.00', 'Diclofenaco 75 mg', 0),
(610, 7, 'EN-03474', 'TERFITIL', '6.00', '11.00', 'Terbinafina 1%', 0),
(612, 3, '', 'RETIRO DE PUNTOS', '20.00', '20.00', '', 0),
(615, 3, '', 'SUBCUTANEA', '0.00', '2.00', '', 0),
(616, 4, 'Nº EN-07848', 'TRIMAX 500 mg', '2.00', '4.00', 'Azitromicina 500 mg', 0),
(618, 1, 'EN -01476', 'SUCRALEX', '27.40', '33.00', 'SUCRALFATO-1g / 5 ml', 0),
(619, 6, 'EE-03297', 'DOLO NEUROBION FORTE DC', '36.60', '46.00', 'VIT B1, VIT B6, VIT B12, Diclofenaco', 0),
(620, 6, '', 'DEXA - NEUROBION DC', '25.50', '35.00', 'LOT. M66484', 0),
(621, 6, '', 'VISINERAL', '16.50', '22.00', '', 0),
(622, 1, 'EN.-05482', 'CLORANFENICOL 250 mg', '6.70', '12.00', 'ANTIBACTERIANO 250MG-5ML', 0),
(629, 6, 'EE-01106', 'LINCOMICINA ', '2.00', '4.00', 'Lincomicina 600 mg/ 2 ml', 0),
(630, 4, 'EE-05588', 'METFORMINA 850 mg', '0.10', '0.30', 'Metformina clorhidrato 850 mg', 0),
(632, 6, 'EE-00011', 'CLINDAMICINA 600 mg', '2.15', '6.00', 'Clindamicina 600 mg/ 4 ml', 0),
(634, 3, '', 'SONDA FOLEY TRIPLE VI#16A', '5.00', '10.00', '', 0),
(636, 6, 'EE- 02025', 'TRAMAL SC', '11.00', '16.00', 'Tramadol 100 mg/ 2ml', 0),
(638, 6, 'EN-07146', 'REDEX   PLUS', '17.60', '22.60', 'DICLOFENACO SODICO75MG ORFEDRINA CITRAT60MGO 60MG', 0),
(639, 4, 'R.S-EE-00633', 'ACICLOVIR 800MG', '1.20', '2.50', 'Aciclovir  800 mg', 0),
(641, 3, '', 'ENDOVENOSO T. NOCHE', '10.00', '10.00', '', 0),
(645, 3, 'BE-00409', 'ENTEROGERMINA', '3.24', '5.00', '', 0),
(647, 4, 'EN-05046', 'CLORFENAMINA MALEATO', '0.10', '0.40', 'CLORFENAMINA MALEATO 4MG', 0),
(648, 3, 'DM 0025 N', 'VENDAS  N° 3', '1.00', '3.00', 'VENDAS ELASTICAS', 0),
(649, 5, 'EN-02717', 'CLORANFENICOL', '0.50', '1.00', '500 mg.', 0),
(650, 4, '', 'AZITROMICINA', '1.50', '3.50', 'Azitromicina 500 mg', 0),
(651, 1, 'EN-07766', 'NOCIDEX', '18.50', '25.00', 'Magaldrato 400 mg/ simeticona 30 mg', 0),
(652, 4, 'N-23990', 'PLIDOMAX  COMPUESTO', '0.80', '2.00', 'ANTIESPASMODICO  ANALGESICO', 0),
(653, 4, 'EE-02568', 'CIPROCTAL  500 mg', '0.30', '1.00', 'CIPROFLOXACINO  500MG', 0),
(654, 3, '', 'AEROCAMARA NEONATAL', '9.00', '14.00', '', 0),
(655, 4, 'EE-05684', 'DEFLAZACORT 30 mg', '2.40', '5.00', 'Deflazacort 30 mg', 0),
(656, 1, '', 'CLENBUVENT FORTE', '19.60', '26.00', '', 0),
(658, 5, 'BE-00796', 'FLORATIL', '3.26', '5.20', 'Saccharomyces boulardii', 0),
(659, 9, '', 'FLORATIL', '3.42', '5.20', 'POLVO PARA SUSPENSION  ORAL', 0),
(661, 8, 'EN-01192', 'GENTAMICINA-0,3%', '4.00', '8.00', 'GENTRAMICINA-0,3%', 0),
(663, 8, 'EN-00670', 'PARACETAMOL', '2.00', '5.00', 'PARACETAMOL  100MG/ML', 0),
(664, 4, '', 'HIDROCLOROTIAZIDA 50 mg', '0.20', '0.60', '', 0),
(667, 1, 'EN-0 3469', 'MUCOCETIL', '15.00', '20.00', 'acetilcisteina 100 mg/ 5 ml', 0),
(668, 4, '', 'LEVOQUIN 750', '2.90', '8.50', 'Levofloxacino 750 mg', 0),
(671, 7, 'EN-05441', 'NOTIPHARM', '6.00', '15.00', 'Clotrimazol 1.0 + Gentamicina 0.1 gr + Betametason', 0),
(678, 3, 'EE-03853', 'SALES DE REHIDRATACION', '1.50', '3.00', 'CLORURO DESODIO2.6g+CLORURO DE POTASIO 1.5g+citrat', 0),
(686, 4, 'EN- 01879', 'CLARITROMICINA 500 mg', '1.20', '2.20', 'Claritromicina 500 mg', 0),
(687, 4, '', 'TENSOFLEXIL', '0.90', '2.00', 'Clorzoxazona 250 mg', 0),
(688, 4, '', 'LEVOQUIN 500 mg', '1.70', '5.00', 'Levofloxacino 500 mg', 0),
(690, 3, 'DM  0089E', 'ESPARADRAPO ', '3.30', '6.00', 'Esparadrapo 5.0 mt x 2.5 cm', 0),
(692, 3, 'DM 12793E', 'ABOCAT N° 20', '1.80', '3.00', '', 0),
(698, 6, 'EE-03340', 'FLODIN', '8.70', '13.70', 'Meloxicam 15mg/1.5 ml', 0),
(699, 6, 'EE-00669', 'CEFAZOLINA 1 G', '2.00', '5.00', 'CEFAZOLINA SODICA 1GR.', 0),
(705, 9, 'EN-07044', 'MUCOASMAT 200', '2.00', '2.80', 'Acetilcisteina 200 mg', 0),
(706, 9, 'EN-07361', 'MUCOASMAT 600', '2.00', '2.80', 'Acetilcisteina 600 mg', 0),
(707, 4, 'N-23547', 'DOLO EXTRA FUERTE', '0.55', '1.00', 'Diclofenaco 50 mg + Paracetamol 500 mg', 0),
(708, 1, 'N-26113', 'SINFLEMAX COMPUESTO ADULTO', '13.70', '18.80', 'Ambroxol 15 mg/5 ml + clenbuterol 0.01 mg/ 5 ml', 0),
(709, 1, 'N -26367', 'SINFLEMAX COMPUESTO PEDIATRICO', '12.70', '18.00', 'Ambroxol 7.5 mg/5 ml + clenbuterol 0.005 mg/ 5 ml', 0),
(711, 1, 'EN- 03889', 'ROXTRIM FORTE', '8.50', '14.00', 'Sulfametoxazol + trimetoprima 400+80 mg/ 5 ml', 0),
(712, 8, '', 'FRAMIDEX', '8.20', '14.50', 'Dexametasona 0.1% + Framicetina 1%', 0),
(713, 3, '', 'FRASCO PARA ORINA', '0.50', '1.00', '', 0),
(716, 8, 'RS Nº EN-05341', 'AEROX', '9.20', '14.20', 'Simeticona 80 mg/dl', 0),
(717, 4, 'EN-06358', 'KETODOL 10 mg', '0.35', '1.00', 'ketorolaco 10 mg', 0),
(719, 16, 'EN-07779', 'DOLITO', '6.50', '11.50', 'IBUPROFENO 100  mg / 5 ml', 0),
(720, 11, 'EE-01731', 'SALBUTAMOL', '6.50', '13.00', 'Salbutamol 100 mcg / 200 dosis', 0),
(722, 6, 'E-22774', 'DIPRIREX', '6.00', '11.00', '', 0),
(723, 6, 'EE-07351', 'KETODOL', '2.36', '6.50', 'ketorolaco 60 mg', 0),
(726, 12, 'EE-04369', 'FLODIN FLEX', '3.20', '4.50', ' Meloxicam + Pridinol mesilato', 0),
(728, 5, 'N-23255', 'ARTICOX', '0.70', '1.50', 'CELECOXIB 200 mg', 0),
(729, 4, 'EN-01248', 'GASELAB', '0.80', '1.50', 'SIMETICONA  80MG', 0),
(730, 1, 'EN-01058', 'HIZALAB', '12.60', '17.60', 'CETIRIZINA  DICLORHIDRATO  5MG-5ML', 0),
(731, 16, 'EN- 03103', 'ZOLIDONE  FORTE', '12.50', '17.50', 'FURAZOLIDONA  50 MG/5ML', 0),
(733, 1, 'RS Nº EE-09189', 'SEBCLAV', '17.76', '24.00', 'Amoxicilina + Acido clavulamico', 0),
(737, 9, '', 'ALFLOREX', '3.10', '4.10', 'Sobres de 20 mg', 0),
(739, 7, 'EE- 04273', 'TERBINAFINA 1%', '7.00', '12.00', 'Terbinafina 1%', 0),
(740, 4, '', '', '0.00', '0.00', '', 0),
(742, 6, '', 'CIROZEP', '1.00', '2.00', 'DIAZEPAM 10MG/2ML', 0),
(749, 20, 'EE - 03056', 'BROMURO  IPRATROPIO', '22.00', '27.00', 'AEROSOL PARA INHALACION 20MCG', 0),
(753, 4, 'EN-00184', 'ZITROLAB', '2.00', '3.20', 'AZITROMICINA  500 MG', 0),
(754, 6, 'EN- 03724', 'ORFENADRINA CITRATO', '1.30', '5.00', 'Orfenadrina citrato 60 mg/2 ml', 0),
(757, 4, '', '', '0.00', '0.00', '', 0),
(763, 1, 'EE-00472', 'AMBROXOL 15MG  /5ML', '5.00', '9.00', 'EXPECTORANTE  MUCOLITICO', 0),
(764, 3, '', 'AEROCAMARA NIÑO', '8.00', '13.50', '', 0),
(766, 1, 'EN-00611', 'AMBROXOL 30 mg/ 5 ml', '3.50', '9.00', 'Ambroxol 30 mg', 0),
(767, 4, 'EN-03876', 'GARDIL 500 mg', '3.19', '5.50', 'Nitazoxanida 500 mg', 0),
(768, 3, '', 'OBSERVACION 6 HORAS', '0.00', '40.00', '', 0),
(769, 7, 'RS EE-04601', 'ACICLOVIR 15  gr.', '6.00', '10.00', 'Aciclovir  5 %', 0),
(770, 16, 'EE-07375', 'ANMOL', '2.00', '6.00', 'PARACETAMOL  120 mg/5 ml', 0),
(771, 3, '', 'ESPECULO', '1.20', '5.00', '', 0),
(772, 8, '', 'GASEOPHAR', '8.20', '15.00', 'SIMETICONA  80 MG/ML', 0),
(774, 4, 'EN-02480', 'FLAXEL', '0.80', '1.50', 'Celecoxib  200 mg', 0),
(775, 5, 'Nº EN-02164', 'DICLOXACILINA', '0.50', '1.00', 'DICLOXACILINA 500 MG', 0),
(779, 5, 'EE-06748', 'CLINDAMICINA', '0.88', '1.50', 'CLINDAMICINA 300MG', 0),
(780, 4, 'EN-04525', 'PRENIXIN 50 mg', '0.80', '1.50', 'PREDNISONA 50 mg', 0),
(781, 4, '', 'MYCTRIM FORTE', '0.90', '1.50', 'sulfametoxazol 800 mg + trimetoprima 160 mg', 0),
(785, 4, '', '', '0.00', '0.00', '', 0),
(786, 4, 'EN-04550', 'PARACETAMOL 500 MG', '0.10', '0.30', 'PARACTRAMOL 500 MG', 0),
(788, 3, '', 'LUO FU SHAN LIANG', '30.00', '40.00', '', 0),
(789, 3, '', 'TE´CHINO', '30.00', '40.00', 'INFUCION TE CHINO', 0),
(790, 1, 'EN-08235', 'PARACETAMOL', '3.10', '8.50', 'Paracetamol 120 mg/5 ml', 0),
(791, 7, '', 'TERBICEL 1%', '13.50', '20.00', 'Terbinafina clorhidrato 1%', 0),
(793, 1, 'EN-01069', 'GARDIL', '17.40', '23.50', 'Nitazoxanida 100 mg/ 5 ml', 0),
(794, 16, 'EE-07394', 'GESIC', '2.50', '7.50', 'ibuprofeno 100 mg/5 ml', 0),
(795, 4, 'EE-00557', 'IBUPROFENO', '0.35', '0.70', 'IBUPROFENO 400MG', 0),
(798, 4, 'EE-06168', 'ACICLAV 875 mg', '3.00', '5.00', 'amoxicilina 875 mg+125mg', 0),
(799, 4, 'EG-559', 'MEBENDAZOL', '0.30', '0.50', 'MEBENDAZOL 100MG', 0),
(801, 6, '', 'CEFEPIME', '14.00', '16.00', 'CEFEPIME 1 gr', 0),
(802, 4, 'EE-02608', 'LEVOFLOXACINO 500', '2.10', '4.00', 'Levofloxacino 500 mg', 0),
(803, 4, 'EE-03318', 'LEVOZINE 750', '3.00', '7.00', 'Levofloxacino 750 mg', 0),
(804, 1, '', 'DIZOLVIN', '5.00', '11.00', 'Ambroxol 30 mg', 0),
(807, 4, 'N- 25230', 'URONOX PLUS', '1.00', '1.80', 'Fenazopiridina 100 mg/ Ciprofloxacino 500 mg', 0),
(812, 6, 'R.S. EN-05509', 'KETACORT', '1.50', '6.50', 'KETOROLACO TROMETAMINA 60MG', 0),
(813, 6, 'EN-06763', 'UROMINOK', '1.70', '6.50', 'Amikacina 500 mg/2ml', 0),
(814, 16, 'EN-03155', 'ZITROCOM', '15.00', '20.00', 'AZITROMICINA 200 MG/5ML', 0),
(820, 4, 'E-21578', 'NEUROBION 5000', '2.50', '3.80', 'Tiamina, Piridoxina Cianocobalamina', 0),
(821, 6, 'EE-00876', 'TRAMADOL  100 mg', '1.50', '4.00', 'Tramadol 100 mg', 0),
(823, 4, 'EE-00557', 'IBUPROFENO', '0.70', '1.00', 'IBUPROFENO 400MG T', 0),
(824, 4, 'N- 24247', 'TERBILAB', '1.50', '3.70', 'Terbinafina clorhidrato 250 mg', 0),
(825, 4, 'N-25496', 'NASTILAB', '0.40', '1.20', 'Paracetamol, Dextrometorfano, Fenilefrina,, Bromhe', 0),
(826, 3, '', 'MASCARILLAS KN95', '1.00', '2.00', 'mascarilla de 5 plieges', 0),
(830, 4, 'EE-00715', 'ESOMEPRAZOL 40 mg', '0.90', '1.80', 'Esomeprazol 40 mg', 0),
(832, 4, 'EE- 06796', 'LEVOPHARM 500', '1.00', '4.00', 'Levofloxacino 500 mg', 0),
(833, 5, 'EN-06709', 'OMEPRAZOL 20 mg', '0.10', '1.00', 'Omeprazol 20 mg', 0),
(834, 1, 'EN-05865', 'TUSPULMIN', '7.00', '12.00', 'Dextrometorfano 15 mg/5 ml', 0),
(835, 7, 'EN- 05122', 'MUPIROCINA CREMA', '16.40', '23.00', 'Mupirocinaa 2%', 0),
(836, 3, 'DM12793E', 'ABOCAT Nº 18', '0.80', '3.00', 'Abocat 18', 0),
(838, 7, 'EE-05897', 'CLOTRINESTEN 1%', '5.60', '10.00', 'Clotrimazol 1%', 0),
(839, 5, 'EN-06650', 'ALERGIZINA', '0.40', '1.00', 'Cetirizina clorhidrato 10 mg', 0),
(841, 6, 'EE- 03330', '0MEPRAZOL 40mg', '3.50', '7.00', 'Omeprazol 40 mg', 0),
(842, 6, ' EE-03909', 'RONEM 1 gr', '25.00', '33.00', 'meropenem 1gr', 0),
(843, 5, 'EE-01354', 'GABAPENTINA 300 mg', '0.50', '0.80', 'Gabapentina 300 mg', 0),
(845, 26, 'Nº EE-07885', 'CEFTRIAXONA', '1.62', '6.00', 'Ceftriaxona 1 gr', 0),
(846, 3, 'DM0345N', 'VENDAS Nº 02', '1.00', '3.50', '', 0),
(847, 4, 'EN-01946', 'PREDNISONA 20 mg', '0.40', '0.80', 'Prednisona 20 mg', 0),
(848, 4, 'EE - 04818', 'METFORMINA', '0.22', '0.50', 'Metformina  850MG', 0),
(849, 5, 'EE-07269', 'GASTRIZOL', '1.00', '2.50', 'Esomeprazol 40 mg', 0),
(850, 4, 'EE-03016', 'KEFDYL', '0.70', '1.50', 'Cefadroxilo 500 mg', 0),
(851, 4, 'EE-03633', 'AMOXYSEVEN', '1.40', '2.40', 'Amoxicilina 500 mg + Ac. Clavulamico 125 mg', 0),
(853, 3, '', 'CERTIFICADO MEDICO', '18.00', '26.00', '', 0),
(855, 6, 'EE-05871', 'TACBANEN 1 gr', '29.00', '40.00', 'Meropenem 1 gr', 0),
(856, 26, 'EE-00870', 'RONEM 500 mg', '20.00', '30.00', 'Meropenem 500 mg', 0),
(857, 6, 'EN-04995', 'KETOPAN 100 mg/ INTRAVENOSO', '3.20', '7.00', 'Ketoprofeno 100 mg', 0),
(858, 6, 'EN-03947', 'BETACORT DEPOT', '16.97', '22.80', 'Betametasona 5mg + 2 mg', 0),
(860, 6, 'EE-07042', 'LINCOMAX', '4.00', '6.50', 'Lincomicina 600 mg/2ml', 0),
(861, 5, 'EN-04099', 'DOBEXILAB', '1.50', '2.00', 'Dobesilato calcico 500 mg', 0),
(863, 6, 'EE-06337', 'DEXAMETASONA  FOSFFATO', '8.31', '13.50', 'Dexametasona 8 mg', 0),
(864, 5, 'EN-02296', 'DOXICICLINA', '0.45', '1.00', 'Doxiciclina 100 mg', 0),
(865, 9, 'EN- 06665', 'FLUIMAX 200 mg', '1.20', '2.00', 'Acetilcisteina 200 mg', 0),
(867, 12, 'E-10848', 'DORIXINA RELAX', '1.17', '2.50', 'Clonixinato de lisina 125 mg', 0),
(868, 6, 'EE-02942', 'NEUROBION 1000', '17.20', '25.20', 'Tiamina + Cianocobalamina', 0),
(869, 5, 'EN-04686', 'VICLORAX', '0.60', '1.20', 'Doxiciclina 100 mg', 0),
(871, 4, 'EN- 06678', 'PARADOLO', '0.40', '0.50', 'Paracetamol 500 mg', 0),
(872, 4, 'EE-08607', 'METRONIDAZOL', '0.20', '0.70', '500 mg', 0),
(874, 16, 'EN-07443', 'GASTRORAL', '14.90', '22.00', 'Magaldrato 800 mg +Simeticona 600mg /10 ml', 0),
(875, 6, 'EE-04737', 'DIFECLOX  75 mg/3 ml', '1.80', '4.00', 'Diclofenaco 75 mg', 0),
(876, 12, 'EE-05744', 'PLIDAN COMPUESTO NF', '1.00', '2.00', 'PARGEVERINA CLORHIDRATO 10 MG CLONIXINATO DE LISIN', 0),
(877, 7, 'EE-05850', 'METACAIN 2% ', '12.50', '18.50', 'LIDOCAINA CLORHIDRATO 2%', 0),
(878, 5, 'EN- 02815', 'AMOXICILINA 500 mg', '0.60', '1.20', 'Amoxicilina 500 mg', 0),
(879, 6, 'EN- 00934', 'BETAMETASONA', '6.50', '10.50', 'Betametasona 4 mg', 0),
(880, 6, 'EE-07103', 'AMICLAF 10 mg', '1.30', '4.00', 'Clorfenamina 10 mg', 0),
(881, 6, 'PHARMAGEN; LOTE 180608', 'EE-02239', '10.00', '14.00', 'POLVO PARA  SUSPENCION INYECTABLE 1GR', 0),
(882, 4, 'EE-05339', 'GLIBENCLAMIDA', '0.10', '0.30', 'Glibenclamida 5 mg', 0),
(883, 6, 'EE-02654', 'HYOS - B20', '2.50', '5.00', 'HIOSCINA  20 mg/ml', 0),
(884, 6, 'EN-03178', 'BETAMETASONA', '4.00', '9.50', 'Betametasona 4 mg', 0),
(886, 6, 'EE-02694', 'RANITIDINA', '1.80', '4.00', 'RANITIDINA 50 MG/2ML', 0),
(887, 27, 'EE-02369', 'METRONIDAZOL', '3.50', '5.50', 'solucion   INYECTABLE 500mg/100ml', 0),
(888, 4, 'EE-06089', 'OMETAB - 20', '0.50', '1.00', 'OMEPRAZOL 20MG', 0),
(889, 6, 'EE- 05437', 'ULCETOM   50 mg', '1.50', '4.00', 'Ranitidina  50 mg/2 ml', 0),
(890, 6, 'EE-06474', 'DEXCORTIL', '0.60', '5.00', 'Dexametasona 4mg/2ml', 0),
(893, 6, 'EE-07240', 'FUROSEMAX', '0.60', '4.50', 'Furosemida  20mg/2ML', 0),
(903, 6, 'EN- 02555', 'KETORGES', '1.20', '6.30', 'Ketorolaco 60 mg/ 2 ml', 0),
(904, 6, 'EE-06940', 'ITUBIOT - F', '7.50', '12.50', 'Amikacina 1 gr', 0),
(905, 4, 'EE- 02179', 'GLIBENCLAMIDA', '0.10', '0.30', 'Glibenclamida 5 mg', 0),
(906, 5, 'EN- 02310', 'FLUCONAZOL', '0.90', '2.30', 'Fluconazol 150 mg', 0),
(907, 7, 'EN- 00023', 'ACICLOVIR 5 gr', '2.00', '6.00', 'Aciclovir 5%', 0),
(908, 6, 'EE-05485', 'OMEPRAZOL', '5.50', '9.00', 'OMEPRAZOL 40mg', 0),
(909, 4, 'EE- 06265', 'QUITALER', '1.00', '1.80', 'Levocetirizina 5 mg', 0),
(910, 4, 'EN- 01899', 'ENALAPRIL 20 mg', '0.10', '0.30', 'Enalapril 20 mg', 0),
(911, 4, 'EN- 02481', 'GEMFIBROZILO', '0.40', '0.80', 'Gemfibrozilo 600 mg', 0),
(912, 5, 'EE- 07545', 'PREGADOL', '0.80', '1.50', 'Pregabalina 75 mg', 0),
(913, 5, 'EE- 06286', 'SIFACOX 200', '0.50', '1.20', 'Celecoxib 200 mg', 0),
(914, 4, 'EN- 02966', 'CLARITROMICINA 500 mg', '1.00', '2.00', 'Claritromicina 500 mg', 0),
(915, 6, 'EN- 01814', 'DIMENHIDRINATO', '1.00', '2.00', 'Dimenhidrinato 50 mg/ 5 ml', 0),
(916, 4, 'EE-01919', 'CAPTOPRIL 25 mg', '0.20', '0.40', 'Captopril 25 mg', 0),
(917, 6, 'EN-04627', 'BROMURO DE HIOSCINA', '2.00', '5.00', 'Bromuro de Hioscina 20 mg', 0),
(919, 3, 'DM 0080N', 'AEROCAMARA ADULTO', '7.50', '13.50', 'AEROCAMARA  ADULTO', 0),
(920, 3, 'NINGUNO', 'PROTECTOR FACIAL', '2.00', '3.00', 'PLASTICO', 0),
(921, 26, 'EE-04963', 'CELOVAN 500', '7.50', '12.50', 'Vancomicina 500 mg', 0),
(922, 6, 'BE-00588', 'PROLONGIN 40 mg', '18.00', '28.00', 'Enoxaparina 40 mg', 0),
(923, 6, 'EN-06087', 'ANALGYN', '1.20', '6.00', 'Metamizol 1gr', 0),
(924, 6, 'EE- 00969', 'M-VAT', '12.00', '17.00', 'Mecobalamina 500 ug/ml', 0),
(926, 6, 'EN-07254', 'ANEURIN', '16.00', '21.00', 'aneurin  10000', 0),
(927, 12, ': EE-01596', 'CLARITROMICINA', '1.40', '2.30', 'claritromicina   500mg.', 0),
(928, 1, 'EN-03797', 'SINFLEMAX- A', '13.53', '18.50', 'ambroxol  clorhidrato  30mg/5ml', 0),
(929, 1, 'N-24342', 'SINFLEMAX-P', '12.00', '17.00', 'ambroxol clorhidrato  15mg/5ml', 0),
(930, 12, 'EN-08148', 'LORATADINA 10 mg', '0.15', '0.40', 'Loratadina   10 mg', 0),
(931, 1, 'EN-01418', 'ALERGILAB', '14.80', '20.00', 'levocetirizina  2,5mg/5ml', 0),
(932, 5, 'N 8317617 N', 'BIOPROST', '50.00', '60.00', 'suplemento  alimenticio', 0),
(934, 6, 'EN-02972', 'CLINDAMICINA', '2.43', '6.00', 'clindamicina 600 mg', 0),
(935, 6, 'EN-05351', 'LINCOVAS', '1.40', '4.00', 'lincomicina 600/2ml', 0),
(936, 6, 'EN03947', 'BETACORT  DEPOT 5MG+2MG', '15.00', '20.00', 'betametasona  ', 0),
(937, 4, 'EN-04550', 'PARACETAMOL  500  MG', '0.10', '0.30', 'paracetamol', 0),
(938, 7, 'CIFARMA  :LOTE:2107G730', 'BETAMETASONA 0.05%', '2.15', '7.00', 'betametasona  0.05 %', 0),
(939, 5, 'EE-04096', 'PLIDOCHECK  PLUS', '0.60', '1.00', 'ibuprofeno400MG', 0),
(940, 6, 'EE-09391', 'B-VAT FORTE', '21.00', '27.00', 'vitaminas  del complejo  b', 0),
(941, 6, 'EG-6252', 'AMIKACINA  500MG/2ML', '1.80', '4.00', 'amikacina 500mg', 0),
(942, 4, 'EN-05337', 'ATORVASTATINA  20 mg', '0.24', '0.50', 'atorvastatina  20 mg', 0),
(943, 4, 'DE-2462', 'VITAMINA C 500 mg', '0.50', '1.00', 'vitamina  C 500mg+zinc 5mg', 0),
(944, 6, 'EE- 01810', 'HIERRONIM', '9.80', '16.00', 'HIERRO 100 mg/5 ml', 0),
(945, 5, 'EN- 07577', 'GASEOVET MS', '1.00', '1.70', 'Simeticona 40 mg + Magaldrato 800 mg', 0),
(947, 5, 'N8307619N/NAVTPR', 'OVARINE', '50.00', '60.00', 'SUPLEMENTO  ALIMENTICIO', 0),
(948, 5, 'EE-03414', 'MOVILIL', '0.30', '0.60', 'piroxicam 20mg', 0),
(949, 5, 'EN-07385', 'ESSOMAXX 20', '0.70', '1.40', 'esomeprazol 20mg', 0),
(950, 4, 'NO:PON/DRUGS/PP/4562/94', 'AZITROMICINA', '1.20', '3.50', 'azitromicina  500mg', 0),
(951, 4, 'EN:06814', 'SIMETILUX', '0.52', '2.00', 'simeticona 80mg', 0),
(952, 1, 'GABBLAN :LOTE2062550', 'NISACORTEC', '12.00', '17.00', 'prednisona 5mg/5ml', 0),
(953, 16, 'EE-08683', 'CEFOTRIX', '18.00', '25.00', 'cefadroxilo 250mg/5ML', 0),
(954, 16, 'EE-08683', 'CEFOTRIX', '18.00', '25.00', 'cefadroxilo 250mg/5ML', 0),
(956, 4, 'EN-01180', 'EVOX', '2.30', '5.00', 'levofloxacino 500mg', 0),
(957, 6, 'EE-07884', 'PASMODAN', '1.50', '5.00', 'butilbromuro de  hioscina 20mg/ml', 0),
(958, 4, 'EE-05330', 'ETORICOXIB 60', '2.60', '5.00', 'etoricoxib  60mg', 0),
(959, 3, 'SIN REGISTRO', 'PAPEL TOALLA', '2.00', '2.50', '--------', 0),
(960, 3, 'OTROS', 'CEPILLO DENTAL', '2.00', '2.50', '--------', 0),
(961, 3, 'OTROS', 'JABON NEKO', '1.70', '2.20', '--------', 0),
(962, 3, 'SIN REGISTRO', 'PAPEL HIGIENICO', '0.85', '1.20', '--------', 0),
(963, 3, 'SIN REGISTRO', 'PASTA DENTAL', '1.20', '1.50', 'FAMILY DOCTOR', 0),
(964, 3, 'SIN REGISTRO', 'PEINE', '1.00', '1.30', '--------', 0),
(965, 3, 'OTROS', 'TOALLITAS HUMEDAS', '2.50', '3.00', 'POCOYO', 0),
(966, 5, 'EN-03389', 'CELEVIT', '0.70', '1.50', 'Celecoxib 200 mg', 0),
(967, 3, 'DM3101E', 'SONDA FOLEY 18', '3.00', '8.00', '--------', 0),
(968, 3, 'FITONE LATEX LOTE:131218', 'PRESERVATIVO', '0.52', '1.00', '--------', 0),
(969, 4, 'EN-07124', 'CLARIXLAB', '1.50', '2.30', 'Claritromicina 500 mg', 0),
(970, 3, 'EE-03414', 'ABOCAT N° 16', '1.80', '4.00', 'ABOCAT N° 16', 0),
(971, 3, 'BE00877', 'POLIGELINA 3.5%', '52.00', '70.00', 'Poligelina 3.5%', 0),
(972, 3, '--------------', 'OXIGENO 1 m3', '25.00', '50.00', 'OXIGENO METRO CUBICO', 0),
(973, 3, 'OTROS', 'SONDA DE ASPIRACION ADULTO', '4.00', '6.00', 'sonda de aspiracion', 0),
(974, 3, 'OTROS', 'SONDA DE ASPIRACION PEDIATRICO', '4.00', '6.00', 'sonda de aspiracion', 0),
(975, 3, 'DM12757E', 'CANULA NASAL DE OXIGENO (BIGOTERA)', '3.00', '5.00', '--------', 0),
(976, 4, 'EN-03312', 'PRIDEMIN', '0.80', '1.30', 'Mosaprida citrato 5 mg', 0),
(977, 8, 'EN-05602', 'SEDOTROPINA ', '21.50', '30.00', 'Sedotropina 1 mg/ml', 0),
(978, 9, 'EN-06800', 'MUXATIL  600 mg', '2.35', '3.70', 'ACETILCISTEINA  600 mg', 0),
(979, 1, 'EN-08331', 'MUXATIL 100 mg', '15.90', '21.00', 'Acetilcisteina 100 mg', 0),
(980, 12, 'EN-06040', 'LOSARTAN  POTASICO 50 MG', '0.17', '0.70', 'losartan potasico', 0),
(981, 3, 'EN-02537', 'SUERO FISIOLOGICO 100 ml', '3.90', '6.00', 'SUERO FISIOL 9%', 0),
(982, 4, 'EE-04183', 'CIPRONOR', '0.50', '1.00', 'CIPROFLOXACINO  500 MG', 0),
(983, 3, 'DM7647E', 'SONDA NASOGASTRICA 14', '2.00', '5.00', '--------', 0),
(985, 1, 'EN-01295', 'AVALLERT', '8.80', '14.00', 'Loratadina 5mg/5 ml', 0),
(986, 4, 'EE-02399', 'MUVETT S', '2.00', '3.00', 'Trimebutina maleato 200mg', 0),
(987, 4, 'DN- 0334', 'CALCIO + D3', '0.50', '0.90', 'Calcio + vit d3 400 UI', 0),
(988, 6, 'EN- 00001', 'LOMOH - 40', '21.50', '26.50', 'Enoxaparina 40 mg', 0),
(989, 3, 'DM035N', 'VENDA N° 12', '1.00', '3.00', '--------', 0),
(990, 3, 'KARIFRAN', 'DM0345N', '1.50', '3.00', '--------', 0),
(991, 3, 'EE-04598', 'CIROCAINA 2%', '12.50', '18.00', 'Lidocaina 2%', 0),
(992, 1, 'EN- 06528', 'MEJORALITO', '7.50', '12.50', 'Paracetamol 160 mg/ml', 0),
(993, 12, 'EE-045645', 'ASPIRINA 500 mg', '0.55', '1.00', 'Acido acetilsalicilico 500 mg', 0),
(994, 12, 'EE-06231', 'ASPIRINA 100 mg', '0.58', '1.10', 'Acido acetilsalicilico 100 mg', 0),
(995, 5, 'EE-07065', 'TAMSULOSINA  CLORHIDRATO', '0.70', '1.20', 'TAMSULOSINA 0.4MG', 0),
(997, 4, 'EE- 04735', 'TINIDAZOL', '1.20', '1.70', 'Tinidazol 500 mg', 0),
(998, 1, 'EN- 02989', 'NONPIRON', '6.94', '11.20', 'Ibuprofeno 40 mg/dl', 0),
(999, 4, 'EN- 06361', 'ETORICOXIB 120', '2.00', '3.00', 'Etoricoxib 120 mg', 0),
(1000, 4, 'EN- 02077', 'CHAO', '0.80', '1.50', 'Paracetamol + Dextrometorfano', 0),
(1001, 3, 'OTROS', 'PRACTIPAÑAL ADULTO', '0.40', '2.00', '----------', 0),
(1002, 4, 'EN- 06090', 'TANACTRIM 750 mg', '2.70', '6.00', 'levofloxacino 750mg', 0),
(1003, 3, 'DM6340E', 'STERI - STRIP (AZUL)', '7.00', '13.00', '12 mm X 100 mm', 0),
(1004, 3, 'DM6340E', 'STERI - STRIP (NARANJA)', '7.00', '13.00', '6 mm X 100 mm', 0),
(1005, 3, 'DM6340E', 'STERI - STRIP (ROJO)', '4.70', '9.00', '6 mm X 75 mm', 0),
(1006, 12, 'EE-02343', 'LASIX 40 mg', '0.70', '1.30', 'Furosemida 40 mg', 0),
(1007, 6, 'N - 23134', 'PARGEVIN COMPUESTO', '11.50', '17.50', 'Pargeverina 15mg + clonixinato lisina 100 mg', 0),
(1008, 5, 'EE- 01922', 'NEOALERGINE PLUS', '0.33', '0.70', 'Cetirizina 10 mg', 0),
(1009, 4, 'EE- 01434', 'SERTRALINA 50 mg', '0.43', '1.00', 'Sertralina 50 mg', 0),
(1010, 16, 'EN-05353', 'ULCOFLUX', '23.30', '28.50', 'SUCRALFATO 1GR/5ML', 0),
(1011, 5, 'EN- 01957', 'UROFURIN 100 mg', '1.60', '2.10', 'Nitrofurantoina 100 mg', 0),
(1012, 7, 'EE-08590', 'QUEMACURAN', '8.39', '14.00', 'SULADIAZINA DE PLATA 1%', 0),
(1013, 3, 'EE-04171', 'FISIOFER 40 mg', '5.70', '9.70', 'HIERRO 40 mg/15 ml', 0),
(1014, 9, 'EE-04103', 'EFETAMOL 1gr', '1.25', '2.50', 'Paracetamol 1gr', 0),
(1015, 3, 'DM310E', 'SONDA FOLEY 12', '3.00', '10.00', '--------', 0),
(1016, 1, 'EN - 04330', 'METRADOL', '4.90', '10.00', 'Ibuprofeno 100 mg', 0),
(1017, 6, 'EE- 06529', 'METOCLONYL', '1.40', '4.00', 'Metoclopramida 10 mg', 0),
(1018, 8, 'EN-05968', 'GASEOVET FORTE', '23.00', '28.00', 'Simeticona 100 mg/ml', 0),
(1019, 3, 'DM 18217E', 'ABOCAT 22', '1.25', '3.00', '--------', 0),
(1020, 4, 'EN-07896', 'COLMAR   FORTE', '0.40', '1.00', 'dicloenaco sodico 50mg+paracetamol 500mg', 0),
(1021, 3, '--------------', '----------', '6.00', '10.00', '----------', 0),
(1022, 1, 'EN-01844', 'PREDNISONA', '5.00', '10.00', 'prednisona 5mg/5ml', 0),
(1023, 27, 'EE-02546', 'CIPROFF-20', '4.55', '8.00', 'ciproloxacino  200mg./100ml', 0),
(1024, 4, 'EN-08089', 'SINALERG', '0.31', '0.80', 'Levocetirizina 5 mg', 0),
(1025, 6, 'EN-03703', 'KETOROLACO 60 mg', '1.30', '6.30', 'Ketorolaco 60 mg', 0),
(1026, 4, 'EN-04908', 'DOLOSCIENS', '1.90', '2.50', 'ketoprofeno  100mg', 0),
(1027, 5, 'EN  -06709', 'OMEPRAZOL', '0.15', '1.00', 'Omeprazol 20 mg', 0),
(1028, 5, 'EN-01163', 'DICLOMAX', '0.60', '1.20', 'DICLOXACILINA  500MG.', 0),
(1029, 4, 'EE-04916', 'BONACOXIB', '2.33', '4.50', 'ETORICOXIB  120MG', 0),
(1030, 26, 'EE-02876', 'CEFATRIAX', '2.00', '6.00', 'CEFTRIAXONA  I G.', 0),
(1031, 4, 'EN-01804', 'AGRAFIL', '2.75', '4.50', 'SILDENAFILO  50MG', 0),
(1032, 1, 'EN-01283', 'CLAVUNIL', '18.60', '23.50', 'Amoxicilina 250mg/ ac clavulamico 62.5', 0),
(1033, 4, 'EE- 06563', 'LEVOPHARM 750', '2.15', '5.00', 'Levofloxacino 750 mg', 0),
(1034, 6, 'EE-02614', 'ARTRICAM', '5.00', '10.00', 'Meloxicam 15 mg', 0),
(1035, 28, 'EE-05505', 'XILOCAINA', '13.02', '18.50', 'Lidocaina 2%', 0),
(1036, 26, 'EE-08690', 'PENICILINA  SODICA', '1.00', '6.00', 'PENICILINA   SODICA    1000 000', 0),
(1037, 26, 'EE-08690', 'BENCILPENICILINA  SODICA', '1.00', '6.00', 'bencilpenicilina  sodica   1000 000', 0),
(1038, 4, 'EN- 06630', 'ATORVASTATINA  20 mg', '0.20', '0.40', 'Atorvastatina 20 mg', 0),
(1039, 4, 'EN-06875', 'ESPASMEX', '0.80', '1.20', 'Bromuro de escopolamina 10 mg', 0),
(1040, 3, 'DM9607E', 'AGUJA N° 18', '0.10', '0.20', '--------', 0),
(1041, 6, 'EN-00116', 'RYLAMAX 1gr', '6.00', '11.00', 'Ceftriaxona 1 gr', 0),
(1042, 26, 'EE-06293', 'OXACILINA', '3.00', '5.00', 'oxacilina 1gr', 0),
(1043, 4, 'EN-03965', 'HIOSIMOL', '0.72', '1.50', 'paracetamol 500mg/hioscina butil bromuro 10mg', 0),
(1044, 4, 'EN-05614', 'DEXALAB', '0.84', '1.20', 'Dexametasona 4 mg', 0),
(1045, 4, 'EE-00676', 'KETOPROFENO', '0.40', '1.00', 'ketoprofeno  100mg', 0),
(1046, 6, 'EE-09196', 'CLORFEDAN', '1.00', '2.50', 'clorffenamina 10mg/ml', 0),
(1048, 12, 'EN-06555', 'CIPROFLOXACINO', '0.22', '1.50', 'CIPROFLOXACINO  500 MG', 0),
(1049, 8, 'EN-01575', 'VALMETAF', '6.60', '11.00', 'SIMETICONA 100 MG/ML', 0),
(1050, 4, 'EE-09154', 'REFLUPRAZOL', '0.70', '1.80', 'esomeprazol  40 mg', 0),
(1052, 26, 'EE-02498', 'CEFTRIAXONA 1gr', '1.50', '6.00', 'Ceftriaxona 1 gr', 0),
(1053, 26, 'EE-08417', 'ceftazidima 1 GR', '4.50', '7.50', 'Ceftazidima 1 gr', 0),
(1054, 6, 'EE-09053', 'DEXAMETASONA', '0.40', '5.00', 'Dexametasona 4 mg', 0),
(1055, 4, 'EN-03572', 'PARACETAMOL', '0.09', '0.30', 'paracetamol 500mg', 0),
(1056, 4, 'PHARMAGEN', 'PANTOPRAZOL 40 mg', '1.80', '3.00', 'Pantoprazol 40 mg', 0),
(1057, 8, 'RD- 3960', 'IVERMED', '27.00', '38.00', 'Ivermectina 6 mg', 0),
(1058, 4, 'EN-04846', 'LEVOSCIENS', '0.80', '1.30', 'LEVOCETIRIZINA  DICLORHIDRATO  5MG', 0),
(1059, 4, 'EN- 04239', 'FLOXISCIENS', '0.80', '1.50', 'CIPROFLOXACINO  500 mg', 0),
(1060, 3, 'DM0132N', 'CATGUT 2/0 ', '6.00', '10.00', '', 0),
(1061, 4, 'EN-06567', 'GASTROLUD', '1.10', '2.00', 'Pantoprazol 40 mg', 0),
(1062, 5, 'EE-08491', 'DEVREN', '2.20', '3.50', 'KETOPROFENO  150MG', 0),
(1063, 4, 'EN-01897', 'LIZINALER', '1.15', '2.10', 'LEVOCETIRIZINA DICLORHIDRATO  5MG', 0),
(1064, 6, 'EE01634', 'TRAMADOL', '2.60', '5.00', 'TRAMADOL  100MG/2ML', 0),
(1065, 9, 'EE-03071', 'SECNIZOL', '18.30', '25.00', 'Secnidazol 2 gr', 0),
(1066, 16, 'EN-06493', 'AZITROLIT', '10.99', '17.00', 'AZITROMICINA 200 MG/5ML', 0),
(1067, 4, 'EE-04914', 'BONACOXIB', '1.50', '3.00', 'etoricoxib  60mg', 0),
(1069, 4, 'EE-07313', 'LEVOGLOB', '1.30', '2.50', 'levofloxacino 500mg', 0),
(1070, 4, 'EN-01157', 'NISACORTEC', '0.79', '1.40', 'PREDNISONA 20MG', 0),
(1071, 7, 'EE-05958', 'MUROCYN', '15.81', '22.00', 'MUPIROCINA   2%', 0),
(1072, 4, 'EE-08795', 'SEBCLAV', '1.20', '2.50', 'AMOXICILINA+ACIDO  CLAVULANICO  500MG+125MG', 0),
(1073, 12, 'EN-06534', 'ALGIAS', '0.36', '0.80', 'KETOROLACO TROMETAMINA 10MG', 0),
(1074, 6, 'EE-01344', 'BETAMETASONA    ', '4.70', '9.50', 'BETAMETASONA 4MG ML', 0),
(1075, 4, 'EE-03678', 'DOLO  NEUROBION  FORTE', '2.30', '3.60', 'diclofenaco  sodico  vitamina B1 VITAMINA B6  VITA', 0),
(1076, 3, 'EN-04735', 'GENSARNA', '8.00', '13.00', 'Benzoato de Bencilo 25%', 0),
(1077, 4, 'EE-04405', 'TERBINAFINA', '1.72', '3.00', 'trebinafina  250mg', 0),
(1078, 16, 'ROXFARMA  LOTE:2110951', 'EN-03186', '9.50', '15.00', 'sulfametoxazol +trimetoprima  200+40mg/5ml', 0),
(1079, 6, 'EE-02907', 'DEXTROSA 33', '1.50', '3.50', 'DEXTROSA                  33.3%  20ML', 0),
(1080, 6, 'EN-03637', 'DECORTEN', '5.34', '10.00', 'Dexametasona 4 mg /2ML', 0),
(1081, 6, 'EN-00490', 'KETANEN', '1.20', '5.00', 'KETOROLACO  TROMETAMINA', 0),
(1082, 6, 'EE-09099', 'LIDOCAINA 2%', '3.60', '7.00', 'SIN  PRESERVANTE  2%', 0),
(1083, 4, 'EE-0421', 'XIMAGEN', '2.70', '4.00', 'Cefuroxima 500 mg', 0),
(1084, 5, 'EE-09401', 'PREGAPHARM', '1.00', '2.00', 'Pregabalina 75 mg', 0),
(1085, 4, 'EN- 08324', 'COLMAR RELAX', '1.50', '2.50', '-------', 0),
(1091, 7, 'em-1025', 'gustavo', '1.50', '2.50', 'concentracion', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `Id_persona` int(3) NOT NULL,
  `Observacion` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`Id_persona`, `Observacion`) VALUES
(198, 'Ninguna'),
(199, 'Ninguna');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documento`
--

CREATE TABLE `tipo_documento` (
  `Id_tipo_documento` int(3) NOT NULL,
  `Des_tipo_documento` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_documento`
--

INSERT INTO `tipo_documento` (`Id_tipo_documento`, `Des_tipo_documento`) VALUES
(1, 'LIBRETA ELECTORAL O DNI'),
(2, 'CARNET DE EXTRANJERIA'),
(3, 'REG. UNICO DE CONTRIBUYENTES'),
(4, 'PASAPORTE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documento_venta`
--

CREATE TABLE `tipo_documento_venta` (
  `Id_tipo_documento_venta` int(3) NOT NULL,
  `Des_tipo_documento` char(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_documento_venta`
--

INSERT INTO `tipo_documento_venta` (`Id_tipo_documento_venta`, `Des_tipo_documento`) VALUES
(1, 'BOLETA'),
(2, 'FACTURA');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bitacora`
--
ALTER TABLE `bitacora`
  ADD PRIMARY KEY (`Id_bitacora`);

--
-- Indices de la tabla `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`Id_cargo`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`Id_Categoria`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD KEY `FK_Id_persona` (`Id_persona`);

--
-- Indices de la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD KEY `FK_Id_producto` (`Id_producto`),
  ADD KEY `FK_Id_doc_compra` (`Id_doc_compra`),
  ADD KEY `FK_Id_lote` (`Id_lote`);

--
-- Indices de la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD KEY `FK_Id_producto` (`Id_producto`),
  ADD KEY `FK_Id_doc_venta` (`Id_doc_venta`);

--
-- Indices de la tabla `documento_compra`
--
ALTER TABLE `documento_compra`
  ADD PRIMARY KEY (`Id_doc_compra`),
  ADD KEY `FK_Id_estado_compra` (`Id_estado_compra`),
  ADD KEY `FK_Id_proveedor` (`Proveedor_persona_idpersona`),
  ADD KEY `FK_Empleado_persona_idpersona` (`Empleado_persona_idpersona`);

--
-- Indices de la tabla `documento_venta`
--
ALTER TABLE `documento_venta`
  ADD PRIMARY KEY (`Id_doc_venta`),
  ADD KEY `FK_Id_tipo_documento` (`Id_tipo_documento_venta`),
  ADD KEY `FK_Empleado_persona_idpersona` (`Empleado_persona_idpersona`),
  ADD KEY `FK_Cliente_persona_idpersona` (`Cliente_persona_idpersona`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD KEY `FK_Id_cargo` (`Id_cargo`),
  ADD KEY `FK_Id_estadoempleado` (`Id_estadoempleado`),
  ADD KEY `FK_Empleado_persona_idpersona` (`Id_persona`);

--
-- Indices de la tabla `estado_compra`
--
ALTER TABLE `estado_compra`
  ADD PRIMARY KEY (`Id_estado_compra`);

--
-- Indices de la tabla `estado_empleado`
--
ALTER TABLE `estado_empleado`
  ADD PRIMARY KEY (`Id_estadoempleado`);

--
-- Indices de la tabla `kardex`
--
ALTER TABLE `kardex`
  ADD PRIMARY KEY (`Id_kardex`),
  ADD KEY `FK_Id_producto` (`Id_producto`),
  ADD KEY `FK_Empleado_persona_idpersona` (`Empleado_persona_idpersona`);

--
-- Indices de la tabla `lote`
--
ALTER TABLE `lote`
  ADD PRIMARY KEY (`Id_lote`),
  ADD KEY `FK_Id_producto` (`Id_producto`),
  ADD KEY `FK_Id_Proveedor_persona` (`Id_persona`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`Id_persona`),
  ADD KEY `FK_Id_tipo_documento` (`Id_tipo_documento`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`Id_producto`),
  ADD KEY `FK_Id_Categoria` (`Id_Categoria`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD KEY `FK_Id_persona` (`Id_persona`);

--
-- Indices de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  ADD PRIMARY KEY (`Id_tipo_documento`);

--
-- Indices de la tabla `tipo_documento_venta`
--
ALTER TABLE `tipo_documento_venta`
  ADD PRIMARY KEY (`Id_tipo_documento_venta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `bitacora`
--
ALTER TABLE `bitacora`
  MODIFY `Id_bitacora` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `cargo`
--
ALTER TABLE `cargo`
  MODIFY `Id_cargo` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `Id_Categoria` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `documento_compra`
--
ALTER TABLE `documento_compra`
  MODIFY `Id_doc_compra` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `documento_venta`
--
ALTER TABLE `documento_venta`
  MODIFY `Id_doc_venta` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_compra`
--
ALTER TABLE `estado_compra`
  MODIFY `Id_estado_compra` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_empleado`
--
ALTER TABLE `estado_empleado`
  MODIFY `Id_estadoempleado` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `kardex`
--
ALTER TABLE `kardex`
  MODIFY `Id_kardex` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lote`
--
ALTER TABLE `lote`
  MODIFY `Id_lote` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=559;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `Id_persona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12938;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `Id_producto` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1092;

--
-- AUTO_INCREMENT de la tabla `tipo_documento`
--
ALTER TABLE `tipo_documento`
  MODIFY `Id_tipo_documento` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_documento_venta`
--
ALTER TABLE `tipo_documento_venta`
  MODIFY `Id_tipo_documento_venta` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`Id_persona`) REFERENCES `persona` (`Id_persona`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`Id_producto`) REFERENCES `producto` (`Id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`Id_doc_compra`) REFERENCES `documento_compra` (`Id_doc_compra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_compra_ibfk_3` FOREIGN KEY (`Id_lote`) REFERENCES `lote` (`Id_lote`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`Id_producto`) REFERENCES `producto` (`Id_producto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`Id_doc_venta`) REFERENCES `documento_venta` (`Id_doc_venta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `documento_compra`
--
ALTER TABLE `documento_compra`
  ADD CONSTRAINT `documento_compra_ibfk_1` FOREIGN KEY (`Id_estado_compra`) REFERENCES `estado_compra` (`Id_estado_compra`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `documento_compra_ibfk_2` FOREIGN KEY (`Empleado_persona_idpersona`) REFERENCES `empleado` (`Id_persona`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `documento_compra_ibfk_3` FOREIGN KEY (`Proveedor_persona_idpersona`) REFERENCES `proveedor` (`Id_persona`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `documento_venta`
--
ALTER TABLE `documento_venta`
  ADD CONSTRAINT `documento_venta_ibfk_1` FOREIGN KEY (`Id_tipo_documento_venta`) REFERENCES `tipo_documento_venta` (`Id_tipo_documento_venta`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `documento_venta_ibfk_2` FOREIGN KEY (`Cliente_persona_idpersona`) REFERENCES `cliente` (`Id_persona`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `documento_venta_ibfk_3` FOREIGN KEY (`Empleado_persona_idpersona`) REFERENCES `empleado` (`Id_persona`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`Id_estadoempleado`) REFERENCES `estado_empleado` (`Id_estadoempleado`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `empleado_ibfk_2` FOREIGN KEY (`Id_cargo`) REFERENCES `cargo` (`Id_cargo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `kardex`
--
ALTER TABLE `kardex`
  ADD CONSTRAINT `kardex_ibfk_1` FOREIGN KEY (`Id_producto`) REFERENCES `producto` (`Id_producto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `lote`
--
ALTER TABLE `lote`
  ADD CONSTRAINT `lote_ibfk_1` FOREIGN KEY (`Id_producto`) REFERENCES `producto` (`Id_producto`),
  ADD CONSTRAINT `lote_ibfk_2` FOREIGN KEY (`Id_persona`) REFERENCES `proveedor` (`Id_persona`);

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`Id_tipo_documento`) REFERENCES `tipo_documento` (`Id_tipo_documento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`Id_Categoria`) REFERENCES `categoria` (`Id_Categoria`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD CONSTRAINT `proveedor_ibfk_1` FOREIGN KEY (`Id_persona`) REFERENCES `persona` (`Id_persona`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
