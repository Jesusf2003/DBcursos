-- Creación de la base de datos

/* Validando la existencia de la base de datos dbMesajil */
IF db_id('dbMesajil') IS NOT NULL
    PRINT '*** Si existe la base de datos ***'
ELSE
    PRINT '--- No existe la base de datos, procederé a crearla ---'
GO

USE MASTER

CREATE DATABASE dbMesajil
GO

-- Creación de las tablas

/* Poner en uso la base de datos */
USE dbMesajil
GO

CREATE TABLE USUARIO(
    CODEMP      CHAR(6) PRIMARY KEY NOT NULL,
    NOMEMP      VARCHAR(80) NOT NULL,
    APEEMP      VARCHAR(80) NOT NULL,
    CELEMP      CHAR(9) NOT NULL,
    DNIEMP      CHAR(8) NOT NULL,
    NIVCAREMP   CHAR(1) NOT NULL,
    TIPCAREMP   VARCHAR(100) NOT NULL,
    EMAEMP      VARCHAR(50) NOT NULL,
    CODUBI      CHAR(6) NOT NULL
)
GO

CREATE TABLE VENTA(
    CODVENT     CHAR(6) PRIMARY KEY NOT NULL,
    FECVENT     DATE NOT NULL DEFAULT GETDATE(),
    TIPVENT     CHAR(1),
    CODEMP      CHAR(6),
    CODCLI      CHAR(6)
)
GO

CREATE TABLE PRODUCTO(
    CODPROD     CHAR(6) PRIMARY KEY NOT NULL,
    NOMPROD     VARCHAR(80) NOT NULL,
    MARPROD     VARCHAR(80) NOT NULL,
    DESPROD     VARCHAR(500) NOT NULL,
    FECPROD     DATE NOT NULL DEFAULT GETDATE(),
    PREPROD     DECIMAL(10,2) NOT NULL,
    CATPROD     VARCHAR(30) NOT NULL,
    STOCKPROD   INT NOT NULL
)
GO

CREATE TABLE CLIENTE(
    CODCLI      CHAR(6) PRIMARY KEY NOT NULL,
    NOMCLI      VARCHAR(80) NOT NULL,
    APECLI      VARCHAR(80) NOT NULL,
    CELCLI      CHAR(9) NOT NULL,
    DNICLI      CHAR(8) NOT NULL,
    EMACLI      VARCHAR(50) NOT NULL,
    DIRCLI      VARCHAR(100) NOT NULL,
    CODUBI      CHAR(6)
)
GO

CREATE TABLE UBIGEO(
    CODUBI      CHAR(6) PRIMARY KEY NOT NULL,
    DEPUBI      VARCHAR(60) NOT NULL,
    PROUBI      VARCHAR(60) NOT NULL,
    DISUBI      VARCHAR(60) NOT NULL
)
GO

CREATE TABLE VENTADETALLE(
    CODVENTDET      CHAR(6) PRIMARY KEY NOT NULL,
    CANTVENTDET     INT NOT NULL,
    CODVENT         CHAR(6) NOT NULL,
    CODPROD         CHAR(6) NOT NULL
)
GO

CREATE TABLE HISTORICOVENTA(
    CODHISTVENT     CHAR(6) PRIMARY KEY NOT NULL,
    FECHISTVENT     DATETIME NULL DEFAULT GETDATE(),
    CODVENTHISTVENT INT NOT NULL,
    CODPRODHISTVENT INT NOT NULL,
    STOCKANTTPROD INT NOT NULL,
    CANTVENTHISTVENT INT NOT NULL,
    STOCKACTPROD INT,
    TOTVENTHISTVENT DECIMAL
)
GO

-- Creación de las relaciones

/*Relaciones entre las tablas (UBIGEO - USUARIO) */
ALTER TABLE USUARIO
    ADD CONSTRAINT UBIGEO_USUARIO FOREIGN KEY (CODUBI) REFERENCES UBIGEO (CODUBI)
GO

/*Relaciones entre las tablas (USUARIO - VENTA) */
ALTER TABLE VENTA
    ADD CONSTRAINT USUARIO_VENTA FOREIGN KEY (CODEMP) REFERENCES USUARIO (CODEMP)
GO

/*Relaciones entre las tablas (CLIENTE - VENTA) */
ALTER TABLE VENTA
    ADD CONSTRAINT CLIENTE_VISTA FOREIGN KEY (CODCLI) REFERENCES CLIENTE (CODCLI)
GO

/*Relaciones entre las tablas (UBIGEO - CLIENTE) */
ALTER TABLE CLIENTE
    ADD CONSTRAINT UBIGEO_CLIENTE FOREIGN KEY (CODUBI) REFERENCES UBIGEO (CODUBI)
GO

/*Relaciones entre las tablas (VENTA - VENTADETALLE) */
ALTER TABLE VENTADETALLE
    ADD CONSTRAINT VENTA_VENTADETALLE FOREIGN KEY (CODVENT) REFERENCES VENTA (CODVENT)
GO

/*Relaciones entre las tablas (PRODUCTO - VENTADETALLE) */
ALTER TABLE VENTADETALLE
    ADD CONSTRAINT PRODUCTO_VENTADETALLE FOREIGN KEY (CODPROD) REFERENCES PRODUCTO(CODPROD)
GO

-- Inserción de datos

INSERT INTO USUARIO
    (CODEMP, NOMEMP, APEEMP, CELEMP, DNIEMP,
    NIVCAREMP, TIPCAREMP, EMAEMP, CODUBI)
VALUES
    ('000001', 'José', 'Aricochea', '991213215', '78964541', 'A', 'Registrar los datos del jefe de sucursal', 'jose@mesajil.com', '110205'),
    ('000002', 'Ramón', 'Chumpitaz', '993344117', '87224544', 'J', 'Registrar a los equipos', 'ramon@mesajil.com', '110204'),
    ('000003', 'María', 'Huamán', '998454445', '97451254', 'V', 'Registrar las ventas realizadas', 'maria@mesajil.com', '110201'),
    ('000004', 'José', 'Máximo', '998532532', '78326561', 'J', 'Registrar a los vendedores', 'jose@mesajil.com', '140105'),
    ('000005', 'Francisco', 'Soriano', '923151451', '78321546', 'V', 'Genera el reporte de ventas.', 'francisco@mesajil.com', '140405')
GO

INSERT INTO VENTA
    (CODVENT, TIPVENT, CODEMP, CODCLI)
VALUES
    ('000001', 'D', '000001', '000001'),
    ('000002', 'D', '000002', '000002'),
    ('000003', 'D', '000003', '000003'),
    ('000004', 'D', '000004', '000004'),
    ('000005', 'D', '000005', '000005')
GO

INSERT INTO PRODUCTO
    (CODPROD, NOMPROD, MARPROD, DESPROD, PREPROD, CATPROD, STOCKPROD)
VALUES
    ('000001', 'Gaming G G203', 'Logitech', 'Aprovecha al máximo tu tiempo de juego con el mouse G203 para juegos disponible en una variedad de vibrantes colores', 127.68, 'Mouse', 139),
    ('000002', 'SMART TV HAIER 32″ HD LE32K6500DA', 'Hair', 'El televisor ideal para cualquier ambiente. HAIER tiene para ti este increíble y práctico Smart TV HD de 32 pulgadas modelo LE32K6500DA con el que podrás pasar lindos momentos con tus amigos y familia.', 794.01, 'Pantalla', 5),
    ('000003', 'Docking Station HP USB-C Dock G4', 'hp', 'Maximice la productividad en la oficina con una conexión de cable USB-C ™ a la estación de acoplamiento HP USB-C G4 lista para empresas.', 534.66, 'Sin Categoría', 4),
    ('000004', 'All In One HP 24-DD0012LA AMD 3150U', 'hp', 'HP All-in-One combina la potencia de una computadora con la belleza de una pantalla delgada y moderna en un dispositivo confiable.', 2517.69, 'Pantalla', 19),
    ('000005', 'CANON Pixma G6010 Multifuncional de Sistema Continuo USB Wifi', 'Canon', 'Experimente la impresión de bajo costo y alta productividad con los tanques de tinta integrados', 1057.35, 'Impresora', 15)
GO

INSERT INTO CLIENTE
    (CODCLI, NOMCLI, APECLI, CELCLI, DNICLI, EMACLI, DIRCLI, CODUBI)
VALUES
    ('000001', 'Josemaría', 'Anchante', '997224546', '58462357', 'chema@mesajil.com', 'Av. Los olivos', '140401'),
    ('000002', 'Rosa', 'Rodríguez', '991233245', '87713295', 'rosa@mesajil.com', 'Av. Simón Bolívar', '140404'),
    ('000003', 'Alberto', 'Chumpitáz', '992165465', '87465412', 'alberto@mesajil.com', 'Av. 2 de mayo', '110204'),
    ('000004', 'María', 'Gonzáles', '881313544', '65989887', 'maria@mesajil.com', 'Av. La unión', '140104'),
    ('000005', 'Jesús', 'Ramíres', '991575145', '45121457', 'jesus@mesajil.com', 'Av. Los olivos', '110201')
GO

INSERT INTO UBIGEO
    (CODUBI, DEPUBI, PROUBI, DISUBI)
VALUES
    ('140401','Lima', 'Cañete', 'San Vicente de Cañete'),
    ('140402','Lima', 'Cañete', 'Asia'),
    ('140403','Lima', 'Cañete', 'Calango'),
    ('140404','Lima', 'Cañete', 'Cerro Azul'),
    ('140405','Lima', 'Cañete', 'Chilca'),
    ('140101','Lima', 'Lima', 'Chorrillos'),
    ('140102','Lima', 'Lima', 'Comas'),
    ('140103','Lima', 'Lima', 'Pucusana'),
    ('140104','Lima', 'Lima', 'Rimac'),
    ('140105','Lima', 'Lima', 'Lurin'),
    ('110201','Lima', 'Chincha', 'Chavin'),
    ('110202','Lima', 'Chincha', 'Alto Laran'),
    ('110203','Lima', 'Chincha', 'El carmen'),
    ('110204','Lima', 'Chincha', 'Pueblo nuevo'),
    ('110205','Lima', 'Chincha', 'Tambo de mora')
GO

INSERT INTO VENTADETALLE
    (CODVENTDET, CANTVENTDET, CODVENT, CODPROD)
VALUES
    ('000001', 5, '000001', '000001'),
    ('000002', 3, '000002', '000002'),
    ('000003', 4, '000003', '000003'),
    ('000004', 2, '000004', '000004'),
    ('000005', 1, '000005', '000005')
GO

-- Creación de las vistas

/* Vendedor */
CREATE VIEW vwVENTAS
AS
SELECT
    TOP(100) V.CODVENT,
    V.FECVENT AS 'Fecha',
    UPPER(C.APECLI) + ', ' + C.NOMCLI AS 'Cliente',
    UPPER(VEN.APEEMP) + ', ' + VEN.NOMEMP AS 'Vendedor',
    PRO.NOMPROD AS 'Producto',
    pro.MARPROD as 'Marca',
    VD.CANTVENTDET AS 'Cantidad',
    PRO.CATPROD AS 'Categoría',
    PRO.PREPROD AS 'Precio Unitario',
    VD.CANTVENTDET * PRO.PREPROD AS 'Sub Total'
FROM VENTA AS V
    INNER JOIN VENTADETALLE AS VD
    ON V.CODVENT = VD.CODVENT
    INNER JOIN dbo.CLIENTE AS C
    ON V.CODCLI = C.CODCLI
    INNER JOIN USUARIO AS VEN
    ON V.CODEMP = VEN.CODEMP
    INNER JOIN PRODUCTO AS PRO
    ON VD.CODPROD = PRO.CODPROD
ORDER BY
    v.FECVENT DESC
GO

/* Jefe de sucursal */

CREATE VIEW vwPRODUCTO
AS
SELECT
    P.NOMPROD AS 'Producto',
    P.FECPROD AS 'Fecha de llegada',
    P.MARPROD AS 'Marca',
    P.CATPROD AS 'Categoría',
    P.STOCKPROD AS 'Stock actual'
FROM PRODUCTO AS P
--ORDER BY P.FECPROD ASC
GO

/* Administrador */
CREATE VIEW vwUSUARIOS
AS
SELECT
    --Registrar usuarios, accesos, inventario, ventas order by fechaventa
    TOP 10 CONCAT(UPPER(U.APEEMP), ', ', U.NOMEMP) AS 'Vendedor',
    VD.CANTVENTDET as 'Cant. Venta',
    P.NOMPROD AS 'Producto',
    P.MARPROD AS 'Marca'
FROM VENTA AS V
    INNER JOIN USUARIO AS U
    ON V.CODVENT = U.CODEMP
    INNER JOIN VENTADETALLE AS VD
    ON V.CODVENT = VD.CODVENTDET
    INNER JOIN PRODUCTO AS P
    ON V.CODVENT = P.CODPROD
ORDER BY VD.CANTVENTDET ASC
GO