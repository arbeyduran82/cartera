--
-- Base de datos: `cartera`
--
CREATE DATABASE IF NOT EXISTS cartera;
USE cartera;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Articulos`
--

CREATE TABLE `Articulos` (
  `codigo` int(10) NOT NULL PRIMARY KEY,
  `descripcion` varchar(90) NOT NULL,
  `precio_compra` decimal(19,0) NOT NULL,
  `Creditoscodigo` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Celulares`
--

CREATE TABLE `Celulares` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `celular` bigint(13) NOT NULL,
  `Personascedula` int(11) NOT NULL,
  `Descripcionesid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Creditos`
--

CREATE TABLE `Creditos` (
  `codigo` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `monto` decimal(10,2) NOT NULL,
  `cantidad_cuotas` int(11) NOT NULL,
  `Personascedula` int(11) NOT NULL,
  `interes` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Descripciones`
--

CREATE TABLE `Descripciones` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `descripcion` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Direcciones`
--

CREATE TABLE `Direcciones` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `direccion` varchar(120) NOT NULL,
  `barrio` varchar(25) NOT NULL,
  `Personascedula` int(11) NOT NULL,
  `Descripcionesid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Pagos`
--

CREATE TABLE `Pagos` (
  `id` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `monto` decimal(10,2) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Personascedula` int(11) NOT NULL,
  `Creditoscodigo` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Personas`
--

CREATE TABLE `Personas` (
  `cedula` int(11) PRIMARY KEY NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `apellido` varchar(120) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `correo` varchar(120) UNIQUE KEY DEFAULT NULL,
  `Usuariosid` int(11) NOT NULL,
  `Zonasid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Usuarios`
--

CREATE TABLE `Usuarios` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `usuario` varchar(10) UNIQUE KEY NOT NULL,
  `password` varchar(150) NOT NULL,
  `estado` char(1) NOT NULL COMMENT 'Bolean' DEFAULT 1,
  `perfil` varchar(15) NOT NULL DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* insert default user */
INSERT INTO Usuarios (usuario,password,estado,perfil,fecha_creacion) value ("admin",sha1(md5("admin")),"1","1",NOW());

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Usuarios_Zonas`
--

CREATE TABLE `Usuarios_Zonas` (
  `Usuariosid` int(11) NOT NULL,
  `Zonasid` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Zonas`
--

CREATE TABLE `Zonas` (
  `id` int(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `descripcion` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Articulos`
--
ALTER TABLE `Articulos`
  ADD KEY `FKArticulos1` (`Creditoscodigo`);

--
-- Indices de la tabla `Celulares`
--
ALTER TABLE `Celulares`
  ADD KEY `FKCelulares1` (`Personascedula`),
  ADD KEY `FKCelulares2` (`Descripcionesid`);

--
-- Indices de la tabla `Creditos`
--
ALTER TABLE `Creditos`
  ADD KEY `FKCreditos1` (`Personascedula`);

--
-- Indices de la tabla `Direcciones`
--
ALTER TABLE `Direcciones`
  ADD KEY `FKDireccione1` (`Personascedula`),
  ADD KEY `FKDireccione2` (`Descripcionesid`);

--
-- Indices de la tabla `Pagos`
--
ALTER TABLE `Pagos`
  ADD KEY `FKPagos1` (`Personascedula`),
  ADD KEY `FKPagos2` (`Creditoscodigo`);

--
-- Indices de la tabla `Personas`
--
ALTER TABLE `Personas`
  ADD KEY `FKPersonas1` (`Usuariosid`),
  ADD KEY `FKPersonas2` (`Zonasid`);

--
-- Indices de la tabla `Usuarios_Zonas`
--
ALTER TABLE `Usuarios_Zonas`
  ADD PRIMARY KEY (`Usuariosid`,`Zonasid`),
  ADD KEY `FKUsuarios1` (`Zonasid`);

--
-- Indices de la tabla `Zonas`
--

--
-- Filtros para la tabla `Articulos`
--
ALTER TABLE `Articulos`
  ADD CONSTRAINT `FKArticulos1` FOREIGN KEY (`Creditoscodigo`) REFERENCES `Creditos` (`codigo`);

--
-- Filtros para la tabla `Celulares`
--
ALTER TABLE `Celulares`
  ADD CONSTRAINT `FKCelulares1` FOREIGN KEY (`Personascedula`) REFERENCES `Personas` (`cedula`),
  ADD CONSTRAINT `FKCelulares2` FOREIGN KEY (`Descripcionesid`) REFERENCES `Descripciones` (`id`);

--
-- Filtros para la tabla `Creditos`
--
ALTER TABLE `Creditos`
  ADD CONSTRAINT `FKCreditos1` FOREIGN KEY (`Personascedula`) REFERENCES `Personas` (`cedula`);

--
-- Filtros para la tabla `Direcciones`
--
ALTER TABLE `Direcciones`
  ADD CONSTRAINT `FKDireccione1` FOREIGN KEY (`Personascedula`) REFERENCES `Personas` (`cedula`),
  ADD CONSTRAINT `FKDireccione2` FOREIGN KEY (`Descripcionesid`) REFERENCES `Descripciones` (`id`);

--
-- Filtros para la tabla `Pagos`
--
ALTER TABLE `Pagos`
  ADD CONSTRAINT `FKPagos1` FOREIGN KEY (`Personascedula`) REFERENCES `Personas` (`cedula`),
  ADD CONSTRAINT `FKPagos2` FOREIGN KEY (`Creditoscodigo`) REFERENCES `Creditos` (`codigo`);

--
-- Filtros para la tabla `Personas`
--
ALTER TABLE `Personas`
  ADD CONSTRAINT `FKPersonas1` FOREIGN KEY (`Zonasid`) REFERENCES `Zonas` (`id`),
  ADD CONSTRAINT `FKPersonas2` FOREIGN KEY (`Usuariosid`) REFERENCES `Usuarios` (`id`);

--
-- Filtros para la tabla `Usuarios_Zonas`
--
ALTER TABLE `Usuarios_Zonas`
  ADD CONSTRAINT `FKUsuarios1` FOREIGN KEY (`Usuariosid`) REFERENCES `Usuarios` (`id`),
  ADD CONSTRAINT `FKUsuarios2` FOREIGN KEY (`Zonasid`) REFERENCES `Zonas` (`id`);
