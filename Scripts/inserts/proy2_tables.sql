-- Se crea la tabla para solicitud
CREATE TABLE solicitud (
    numero_solicitud SERIAL PRIMARY KEY,
    fecha DATE,
    numero_tramite INT NOT NULL,
    numero_referencia INT NOT NULL, 
    marca INT NOT NULL,
    estado VARCHAR(100)
);

-- Se crea la tabla para solicita
CREATE TABLE solicita(
    fk_solicitud INT NOT NULL,
    fk_solicitante INT NOT NULL
);

-- Se crea la tabla para solicitante
CREATE TABLE solicitante (
    id_solicitante SERIAL PRIMARY KEY,
    tipo VARCHAR(16),
    documento VARCHAR(15),
    correo VARCHAR(160),
    fax VARCHAR(100),
    telefono VARCHAR(200),
    celular VARCHAR(200),
    domicilio VARCHAR(500)
);

-- Se crea la tabla para una especializacion de solicitante llamada natural
CREATE TABLE solicitante_natural (
    id_solicitante INT NOT NULL,
    nombre VARCHAR(100)
);

-- Se crea la tabla para una especializacion de solicitante llamada natural
CREATE TABLE solicitante_juridico (
    id_solicitante INT NOT NULL,
    razon_social VARCHAR(100),
    tipo VARCHAR(20),
    pertenencia_del_estado varchar(10),
    tipo_pc varchar(20),
    origen_pr varchar(20)
);

CREATE TABLE representante(
    documento VARCHAR(20),
    ctc_telefono VARCHAR(20),
    ctc_celular VARCHAR(20),
    ctc_correo VARCHAR(200),
    ctc_fax VARCHAR(50),
    domicilio VARCHAR(300),
    nombre VARCHAR(50),
    num_agente VARCHAR(50),
    num_poder VARCHAR(50),
    pais_dom VARCHAR(80),
    pais_nac VARCHAR(80)
);

-- Se crea la tabla para marca
CREATE TABLE marca (
    id_marca SERIAL PRIMARY KEY,
    tipo VARCHAR(40),
    aplicar_marca VARCHAR(40),
    clase_internacional VARCHAR(40),
    distingue VARCHAR(200)
);

-- Se crea la tabla intermedia prioriza que conecta prioridad_extranjera con solicitud
CREATE TABLE prioriza (
    prioridad INT NOT NULL,
    solicitud INT NOT NULL
);

-- Se crea la tabla para prioridad_extranjera
CREATE TABLE prioridad_extranjera (
    id_prioridad SERIAL PRIMARY KEY,
    numero_prioridad INT NOT NULL,
    fecha VARCHAR(20)
);

-- Se crea la tabla para signo
CREATE TABLE signo (
    id_signo SERIAL PRIMARY KEY,
    marca INT NOT NULL,
    tipo VARCHAR(12),
    nombre VARCHAR(100),
    imagen VARCHAR(100),
    decripcion VARCHAR(200)
);

-- Se crea la tabla para pais
CREATE TABLE pais (
    nombre VARCHAR(100),
    fk_prioridad INT NOT NULL
);