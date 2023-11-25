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

EXECUTE agregarusuario 'Karla','kgomez@yahoo.com','22556987'

CREATE PROCEDURE modificarusuario
@codigo INT,
@nombre VARCHAR(50),
@correo VARCHAR(50),
@telefono VARCHAR(50)
AS
	BEGIN
	UPDATE usuarios SET nombre=@nombre,correo=@correo,telefono=@telefono WHERE usuarioid=@codigo
	END

EXECUTE modificarusuario 3, 'Ana','anamaria@gmail.com','85884312'


CREATE PROCEDURE borrarusuario
@codigo INT
AS
	BEGIN
	DELETE usuarios WHERE usuarioid=@codigo
	END

EXECUTE borrarusuario 4

CREATE PROCEDURE consultarusuarios
@codigo INT
AS
	BEGIN
	SELECT * FROM usuarios WHERE usuarioid=@codigo
	END

EXECUTE consultarusuarios 5

SELECT * FROM usuarios


/*-------------------EQUIPOS-----------------------------*/



CREATE TABLE equipos
(
	equipoid INT IDENTITY (1000,2),
	tipoequipo VARCHAR(50),
	modelo VARCHAR(50),
	usuarioid INT,
	CONSTRAINT pk_equipoid PRIMARY KEY(equipoid),
	CONSTRAINT fk_usuarioid FOREIGN KEY(usuarioid) REFERENCES usuarios(usuarioid),
)

CREATE PROCEDURE agregarequipo
@tipoequipo VARCHAR(50),
@modelo VARCHAR(50),
@usuarioid INT
AS
	BEGIN
	INSERT INTO equipos (tipoequipo,modelo,usuarioid) VALUES(@tipoequipo,@modelo,@usuarioid)
	END

EXECUTE agregarequipo 'Tablet','Samsung',1


CREATE PROCEDURE modificarequipo
@codigoequipo INT,
@tipoequipo VARCHAR(50),
@modelo VARCHAR(50),
@codigousuario INT
AS
	BEGIN
	UPDATE equipos SET tipoequipo=@tipoequipo,modelo=@modelo WHERE equipoid=@codigoequipo AND usuarioid=@codigousuario
	END

EXECUTE modificarequipo 1002, 'Tablet','Samsung',1

CREATE PROCEDURE borrarequipo
@codigoequipo INT,
@codigousuario INT
AS
	BEGIN
	DELETE equipos WHERE equipoid=@codigoequipo AND usuarioid=@codigousuario
	END

EXECUTE borrarequipo 1002,1


CREATE PROCEDURE consultaequipos
@codigoequipo INT
AS 
	BEGIN
	SELECT * FROM equipos WHERE equipoid=@codigoequipo
	END

EXECUTE consultaequipos 1004

SELECT * FROM equipos



/*-------------------------------------------------*/




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

/*---------------------TECNICOS-------------------------------*/

CREATE TABLE tecnicos
(
	tecnicoid INT IDENTITY (5000,25),
	nombre VARCHAR(50) NOT NULL,
	especialidad VARCHAR(50) NOT NULL,
	CONSTRAINT pk_tecnicoid PRIMARY KEY(tecnicoid),
)
 
CREATE PROCEDURE agregartecnico
@nombre VARCHAR(50),
@especialidad VARCHAR(50)
AS
	BEGIN
	INSERT INTO tecnicos (nombre,especialidad) VALUES(@nombre,@especialidad)
	END

EXECUTE agregartecnico 'Mariana','UPS'


CREATE PROCEDURE modificartecnico
@codigotecnico INT,
@nombre VARCHAR(50),
@especialidad VARCHAR(50)
AS
	BEGIN
	UPDATE tecnicos SET nombre=@nombre,especialidad=@especialidad WHERE tecnicoid=@codigotecnico
	END

EXECUTE modificartecnico 5050, 'Javier','Microchips'

CREATE PROCEDURE borrartecnico
@codigotecnico INT
AS
	BEGIN
	DELETE tecnicos WHERE tecnicoid=@codigotecnico
	END

EXECUTE borrartecnico 5075

CREATE PROCEDURE consultatecnicos
@codigotecnico INT
AS 
	BEGIN
	SELECT * FROM tecnicos WHERE tecnicoid=@codigotecnico
	END

EXECUTE consultatecnicos 5025

SELECT * FROM tecnicos



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