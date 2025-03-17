-- Se establece que el cliente entregue código en codificación UTF8
SET client_encoding TO UTF8;

-- Se fuerza a que los resultados de toda query se presenten en tablas
\pset tuples_only false

-- Se crea la tabla para solicitud
CREATE TABLE solicitud (
    numero_solicitud VARCHAR(50) UNIQUE,
    fecha DATE,
    numero_tramite VARCHAR(6) CHECK (numero_tramite ~ '^[0-9]{6}$'),
    numero_referencia VARCHAR(6) CHECK (numero_referencia ~ '^[0-9]{6}$'), 
    marca INT NOT NULL
);
COMMENT ON TABLE solicitud IS 'Tabla que almacena las solicitudes';
COMMENT ON COLUMN solicitud.numero_solicitud IS 'Número único que identifica unívocamente las solicitudes';
COMMENT ON COLUMN solicitud.fecha IS 'Fecha que indica el día en que se registró la solicitud';
COMMENT ON COLUMN solicitud.numero_tramite IS 'Número de trámite asignado por el SAPI';
COMMENT ON COLUMN solicitud.numero_referencia IS 'Número de referencia asignado por el SAPI';
COMMENT ON COLUMN solicitud.marca IS 'Llave foránea a la marca que se está registrando';

-- Se crea la tabla solicita
CREATE TABLE solicita(
    fk_solicitud VARCHAR(50) NOT NULL,
    fk_solicitante INT NOT NULL
);
COMMENT ON TABLE solicita IS 'Tabla intermedia que conecta las solicitudes con los solicitantes';
COMMENT ON COLUMN solicita.fk_solicitud IS 'Llave foránea a solicitud';
COMMENT ON COLUMN solicita.fk_solicitante IS 'Llave foránea a solicitante';

-- Se crea la tabla para solicitante
CREATE TABLE solicitante (
    id_solicitante SERIAL PRIMARY KEY,
    tipo VARCHAR(20),
    documento VARCHAR(50),
    correo VARCHAR(200),
    fax VARCHAR(100),
    telefono VARCHAR(200),
    celular VARCHAR(200),
    domicilio VARCHAR(500),
    pais_dom VARCHAR(100),
    pais_nac VARCHAR(100)
);
COMMENT ON TABLE solicitante IS 'Tabla que almacena las solicitantes registrados en el SAPI';
COMMENT ON COLUMN solicitante.id_solicitante IS 'Clave primaria que identifica a los solicitantes, es un entero serial';
COMMENT ON COLUMN solicitante.tipo IS 'Determina si el solicitante es Persona Natural o Persona Jurídica';
COMMENT ON COLUMN solicitante.documento IS 'Número de identificación del solicitante';
COMMENT ON COLUMN solicitante.correo IS 'Dirección de correo electrónico del solicitante';
COMMENT ON COLUMN solicitante.fax IS 'Dirección de fax del solicitante';
COMMENT ON COLUMN solicitante.telefono IS 'Numero de teléfono del solicitante';
COMMENT ON COLUMN solicitante.celular IS 'Número de celular del solicitante';
COMMENT ON COLUMN solicitante.domicilio IS 'Dirección de domicilio del solicitante';
COMMENT ON COLUMN solicitante.num_agente IS 'Llave foránea al número de agente que usa el SAPI para identificar a los apoderados';
COMMENT ON COLUMN solicitante.pais_dom IS 'País de domicilio del solicitante';
COMMENT ON COLUMN solicitante.pais_nac IS 'País de nacionalidad del solicitante';

-- Se crea la tabla para una especializacion de solicitante llamada solicitante_natural
CREATE TABLE solicitante_natural (
    id_solicitante INT NOT NULL,
    nombre VARCHAR(100)
);
COMMENT ON TABLE solicitante_natural IS 'Tabla en donde se registran los solicitantes que sean personas naturales';
COMMENT ON COLUMN solicitante_natural.id_solicitante IS 'Clave foránea que apunta a su respectivo solicitantes';
COMMENT ON COLUMN solicitante_natural.nombre IS 'Nombre del solicitante natural';

-- Se crea la tabla para una especializacion de solicitante llamada solicitante_natural
CREATE TABLE solicitante_juridico (
    id_solicitante INT NOT NULL,
    razon_social VARCHAR(100),
    tipo VARCHAR(20),
    pertenencia_del_estado varchar(10),
    tipo_pc varchar(20),
    origen_pr varchar(20)
);
COMMENT ON TABLE solicitante_juridico IS 'Tabla en donde se registran los solicitantes que sean personas jurídicos';
COMMENT ON COLUMN solicitante_juridico.id_solicitante IS 'Clave foránea que apunta a su respectivo solicitantes';
COMMENT ON COLUMN solicitante_juridico.razon_social IS 'Razón social del solicitante';
COMMENT ON COLUMN solicitante_juridico.tipo IS 'Distingue al solicitante jurídico en uno de los siguientes tres tipos: público, privado o propiedad colectiva';
COMMENT ON COLUMN solicitante_juridico.pertenencia_del_estado IS 'Pertenencia del estado es un atributo que solo se rellena cuando el tipo sea público, indicando un porcentaje que representa cuánto de la empresa le pertenece al estado ';
COMMENT ON COLUMN solicitante_juridico.tipo_pc IS 'Hace referencia a tipo propiedad colectiva, que es un valor entre ocho tipos distintos. Solo se rellena para cuando tipo es propiedad colectiva';
COMMENT ON COLUMN solicitante_juridico.origen_pr IS 'Solo se rellena cuando el tipo es privado, indica si la empresa privada es de origen nacional o extranjero';

-- Se crea la tabla para apoderado
CREATE TABLE apoderado(
    num_agente INT UNIQUE,
    ctc_telefono VARCHAR(20),
    ctc_celular VARCHAR(20),
    ctc_correo VARCHAR(200),
    ctc_fax VARCHAR(50),
    domicilio VARCHAR(300),
    nombre VARCHAR(50),
    documento VARCHAR(20),
    num_poder VARCHAR(50),
    pais_dom VARCHAR(100),
    pais_nac VARCHAR(100)
);

CREATE TABLE apodera(
    fk_apoderado INT,
    fk_solicitante INT,
    numero_poder VARCHAR(11)
);

CREATE TABLE representante(
    documento VARCHAR(12) PRIMARY KEY,
    nombre VARCHAR(80)
);

CREATE TABLE representa(
    fk_representante VARCHAR(12),
    fk_solicitante INT
);


-- Se crea la tabla para marca
CREATE TABLE marca (
    id_marca SERIAL PRIMARY KEY,
    tipo VARCHAR(40),
    aplicar_marca VARCHAR(40),
    clase_internacional INT,
    distingue VARCHAR(7000)
);
COMMENT ON TABLE marca IS 'Tabla en donde se registran las marcas que se esperan registrar en una solicitud';
COMMENT ON COLUMN marca.id_marca IS 'Atributo clave postizo, que se utiliza de forma serial para diferenciar entre marcas';
COMMENT ON COLUMN marca.tipo IS 'Distingue a la marca en uno de siete distintos tipos: marca del producto, nombre comercial, marca de servicio, denominación comercial, marca colectiva, denominación de origen, lema comercial';
COMMENT ON COLUMN marca.aplicar_marca IS 'Solo se rellena en caso de que el tipo de marca sea lema comercial, e indica...';
COMMENT ON COLUMN marca.clase_internacional IS 'Es un entero que sigue un estandar mundial para representar el tipo de mercado que ocupa la marca';
COMMENT ON COLUMN marca.distingue IS 'Es una descripción muy detallada de aquello que hace a la marca distintiva';


-- Se crea la tabla intermedia prioriza que conecta prioridad_extranjera con solicitud
CREATE TABLE prioriza (
    prioridad VARCHAR(100) NOT NULL,
    solicitud VARCHAR(50) NOT NULL
);
COMMENT ON TABLE prioriza IS 'Tabla intermedia que conecta las prioridades extranjeras con las solicitudes';
COMMENT ON COLUMN prioriza.prioridad IS 'Llave foránea que hace referencia a la prioridad extranjera de una solicitud';
COMMENT ON COLUMN prioriza.solicitud IS 'Llave foránea que hace referencia a la solicitud';

-- Se crea la tabla para prioridad_extranjera
CREATE TABLE prioridad_extranjera (
    numero_prioridad VARCHAR(100) NOT NULL UNIQUE,
    fecha DATE,
    fk_pais VARCHAR(100)
);
COMMENT ON TABLE prioridad_extranjera IS 'Tabla en la que se registran las prioridades extranjeras de las distintas solicitudes';
COMMENT ON COLUMN prioridad_extranjera.numero_prioridad IS 'Clave primaria que identifica a las prioridades extranjeras, sigue un estandar';
COMMENT ON COLUMN prioridad_extranjera.fecha IS 'Indica la fecha en la que se aprobó la prioridad extranjera';
COMMENT ON COLUMN prioridad_extranjera.fk_pais IS 'Llave foránea que apunta al país en donde se aprobó la prioridad extranjera';


-- Se crea la tabla para signo
CREATE TABLE signo (
    id_signo SERIAL PRIMARY KEY,
    marca INT NOT NULL,
    tipo VARCHAR(12),
    nombre VARCHAR(100),
    imagen VARCHAR(200),
    descripcion VARCHAR(4000)
);
COMMENT ON TABLE signo IS 'Tabla en la que se registran los signos que a su vez se asocian a la marca que se quiere solicitar';
COMMENT ON COLUMN signo.id_signo IS 'Clave postiza serial que se usa para identificar a los signos';
COMMENT ON COLUMN signo.marca IS 'Llave foránea que apunta a la marca asociada al signo';
COMMENT ON COLUMN signo.tipo IS 'Distingue al signo en uno de tres tipos distintos: Denominativo, gráfico y mixto';
COMMENT ON COLUMN signo.nombre IS 'Indica el nombre del signo, solo se rellena si el tipo es denominativo o mixto';
COMMENT ON COLUMN signo.imagen IS 'URL a la imagen del signo, solo se rellena si el tipo es gráfico o mixto';
COMMENT ON COLUMN signo.descripcion IS 'Texto que describe el aspecto de la imagen del signo, por tanto, solo se rellena si el tipo es gráfico o mixto';

-- Se crea la tabla para pais
CREATE TABLE pais (
    nombre VARCHAR(100) PRIMARY KEY
);
COMMENT ON TABLE pais IS 'Tabla en la que se registran los países';
COMMENT ON COLUMN pais.nombre IS 'Indica el nombre del país';