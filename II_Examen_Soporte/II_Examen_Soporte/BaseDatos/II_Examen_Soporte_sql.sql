CREATE DATABASE soporte

USE soporte

CREATE TABLE usuarios
(
	usuarioid INT IDENTITY (1,1),
	nombre VARCHAR(50) NOT NULL,
	correo VARCHAR(50) NOT NULL,
	telefono VARCHAR(50) NOT NULL,
	CONSTRAINT pk_usuarioid PRIMARY KEY(usuarioid),
)

CREATE PROCEDURE agregarusuario
@nombre VARCHAR(50),
@correo VARCHAR(50),
@telefono VARCHAR(50)
AS
	BEGIN
	INSERT INTO usuarios (nombre,correo,telefono) VALUES(@nombre,@correo,@telefono)
	END
EXECUTE agregarusuario 'Pablo','pbo25@gmail.com','33559988'
SELECT * FROM usuarios

CREATE TABLE equipos
(
	equipoid INT IDENTITY (1000,2),
	tipoequipo VARCHAR(50),
	modelo VARCHAR(50),
	usuarioid INT,
	CONSTRAINT pk_equipoid PRIMARY KEY(equipoid),
	CONSTRAINT fk_usuarioid FOREIGN KEY(usuarioid) REFERENCES usuarios(usuarioid),
)

CREATE TABLE reparaciones
(
	reparacionid INT IDENTITY (2000,5),
	equipoid INT,
	fechasolicitud DATETIME NOT NULL CONSTRAINT df_fechasolicitud DEFAULT GETDATE(),
	estado VARCHAR(50) NOT NULL,
	CONSTRAINT pk_reparacionid PRIMARY KEY(reparacionid),
	CONSTRAINT fk_equipoid FOREIGN KEY(equipoid) REFERENCES equipos(equipoid),
)

CREATE TABLE detallesreparacion
(
	detalleid INT IDENTITY (3000,10),
	reparacionid INT,
	descripcion VARCHAR(50),
	fechainicio DATETIME NOT NULL CONSTRAINT df_fechainicio DEFAULT GETDATE(),
	fechafin DATETIME NOT NULL CONSTRAINT df_fechafin DEFAULT GETDATE(),
	CONSTRAINT pk_detalleid PRIMARY KEY(detalleid),
	CONSTRAINT fk_reparacionid FOREIGN KEY(reparacionid) REFERENCES reparaciones(reparacionid),
)

CREATE TABLE tecnicos
(
	tecnicoid INT IDENTITY (5000,25),
	nombre VARCHAR(50) NOT NULL,
	especialidad VARCHAR(50) NOT NULL,
	CONSTRAINT pk_tecnicoid PRIMARY KEY(tecnicoid),
)

CREATE TABLE asignaciones
(
	asignacionid INT IDENTITY (4000,15),
	reparacionid INT,
	tecnicoid INT,
	fechaasignacion DATETIME NOT NULL CONSTRAINT df_asignacion DEFAULT GETDATE(),
	CONSTRAINT pk_asignacionid PRIMARY KEY(asignacionid),
	CONSTRAINT fk_reparacionid2 FOREIGN KEY(reparacionid) REFERENCES reparaciones(reparacionid),
	CONSTRAINT fk_tecnicoid FOREIGN KEY(tecnicoid) REFERENCES tecnicos(tecnicoid),
)