CREATE DATABASE dbHospital
DROP DATABASE dbHospital
GO
use dbHospital;
use master;

-- Crear las tablas
CREATE SCHEMA PACIENTE
GO

CREATE TABLE paciente.paciente(
	CODPAC			int not null identity(1,1),
	NOMPAC			varchar(120) not null,
	APEPATPAC		varchar(120) not null,
	APEMATPAC		varchar(120) not null,
	FECNACPAC		date not null,
	SEXPAC			char(1) not null,
	DNIPAC			char(8),
	TELEFPAC		varchar(9),
	EMAILPAC		varchar(100),
	DOMPAC			varchar(120) not null,
	UBIGEOPAC		char(6) not null,
	FECREGPAC		datetime,
	OBSERVPAC		varchar(150)
	constraint codpac primary key(codpac)
)
GO

CREATE SCHEMA HISTORIA
GO

CREATE TABLE historia.HISTORIA(
	CODHIST		INT NOT NULL identity(1,1),
	FECHIST		datetime not null,
	OBSHIST		varchar(1800) not null,
	constraint codhist primary key(codhist)
)
GO

CREATE TABLE paciente.HISTORIA_PACIENTE(
	CODHIST int not null,
	CODPAC	int not null,
	CODMED	int not null,
	constraint coshist primary key(codhist)
)
GO

CREATE TABLE HISTORIA.TURNO(
	CODTUR		int not null identity(1,1),
	FECTUR		DATETIME,
	ESTTUR		smallint,
	OBSTUR		varchar(500),
	constraint codtur primary key (codtur)
)
GO

CREATE TABLE paciente.TURNO_PACIENTE(
	CODTUR		int not null,
	CODPAC		int	not null,
	CODMED		int not null
)
GO

CREATE TABLE paciente.UBIGEO(
	CODUB		char(6) not null,
	DISTUB		varchar(60),
	PROVUB		varchar(60),
	DEPUB		varchar(60),
	CONSTRAINT codub primary key(codub)
)
GO

CREATE SCHEMA MEDICO
GO

CREATE TABLE medico.ESPECIALIDAD(
	CODESP		int not null identity(1,1),
	NOMESP		varchar(80) not null,
	OBSESP		varchar(100),
	constraint codesp primary key(codesp)
)
GO

CREATE TABLE MEDICO.MEDICO(
	CODMED			int not null identity(1,1),
	NOMMED			varchar(120) not null,
	APEPATMED		varchar(120) not null,
	APEMATMED		varchar(120) not null,
	FECNACMED		date not null,
	SEXMED			char(1) not null,
	DNIMED			char(8) not null,
	TELEFMED		varchar(9),
	EMAILMED		varchar(120),
	DOMMED			varchar(120) not null,
	UBIGEOMED		char(6) not null,
	FECREGMED		datetime,
	OBSERVMED		varchar(180),
	constraint codmed primary key(codmed)
)
GO

CREATE TABLE MEDICO.MEDICO_ESPECIALIDAD(
	CODMED		int not null,
	CODESP		int not null,
	DESCESP		varchar(1000)
)
GO