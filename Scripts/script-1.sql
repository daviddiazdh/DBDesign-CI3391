CREATE TABLE solicitud (
    numero_solicitud SERIAL PRIMARY KEY,
    fecha VARCHAR(50),
    numero_tramite INT NOT NULL,
    numero_referencia INT NOT NULL, 
    marca INT NOT NULL
);

CREATE TABLE solicita(
    fk_solicitud INT NOT NULL,
    fk_solicitante_tipo VARCHAR(9) NOT NULL,
    fk_solicitante_numero INT NOT NULL
);

CREATE TABLE solicitante (
    documento_tipo VARCHAR(9) NOT NULL,
    documento_numero INT NOT NULL,
    correo VARCHAR(160),
    fax VARCHAR(100),
    telefono VARCHAR(200)
);

CREATE TABLE solicitante_natural (
    documento_tipo VARCHAR(9) NOT NULL,
    documento_numero INT NOT NULL,
    nombre VARCHAR(100),
    celular VARCHAR(14)
);

CREATE TABLE marca (
    id_marca SERIAL PRIMARY KEY,
    tipo VARCHAR(40),
    aplicar_marca VARCHAR(40),
    clase_internacional VARCHAR(40),
    distingue VARCHAR(200)
);

CREATE TABLE prioriza (
    prioridad INT NOT NULL,
    solicitud INT NOT NULL
);

CREATE TABLE prioridad_extranjera (
    id_prioridad SERIAL PRIMARY KEY,
    numero_prioridad INT NOT NULL,
    fecha VARCHAR(20)
);

CREATE TABLE signo (
    id_signo SERIAL PRIMARY KEY,
    marca INT NOT NULL,
    tipo VARCHAR(12),
    nombre VARCHAR(100),
    imagen VARCHAR(100),
    decripcion VARCHAR(200)
);

CREATE TABLE pais (
    nombre VARCHAR(100),
    fk_prioridad INT NOT NULL
);

INSERT INTO solicitud (fecha, numero_tramite, numero_referencia, marca) VALUES ('martes', 0, 0, 1);

INSERT INTO marca (tipo, aplicar_marca, clase_internacional, distingue) VALUES ('denominativo', 'hola', 'chao', 'es bonito');

INSERT INTO prioridad_extranjera (numero_prioridad, fecha) VALUES (2500, '20/04');

SELECT * FROM solicitud;

SELECT * FROM marca;