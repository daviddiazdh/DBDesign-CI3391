ALTER TABLE solicitud 
ADD CONSTRAINT fk_marca FOREIGN KEY (marca) REFERENCES marca(id_marca);

ALTER TABLE solicitante
ADD CONSTRAINT fk_pais_dom FOREIGN KEY (pais_dom) REFERENCES pais(nombre),
ADD CONSTRAINT fk_pais_nac FOREIGN KEY (pais_nac) REFERENCES pais(nombre);

ALTER TABLE prioriza
ADD CONSTRAINT fk_prioridad FOREIGN KEY (prioridad) REFERENCES prioridad_extranjera(numero_prioridad),
ADD CONSTRAINT fk_solicitud FOREIGN KEY (solicitud) REFERENCES solicitud(numero_solicitud);

ALTER TABLE signo
ADD CONSTRAINT fk_marca FOREIGN KEY (marca) REFERENCES marca(id_marca);

ALTER TABLE prioridad_extranjera
ADD CONSTRAINT fk_pais FOREIGN KEY (fk_pais) REFERENCES pais(nombre),
ADD CONSTRAINT pk_numero_prioridad PRIMARY KEY (numero_prioridad);

ALTER TABLE solicita
ADD CONSTRAINT fk_solicitud FOREIGN KEY (fk_solicitud) REFERENCES solicitud(numero_solicitud),
ADD CONSTRAINT fk_solicitante FOREIGN KEY (fk_solicitante) REFERENCES solicitante(id_solicitante),
ADD CONSTRAINT pk_solicita PRIMARY KEY (fk_solicitud, fk_solicitante);

ALTER TABLE solicitante_natural
ADD CONSTRAINT fk_solicitante
FOREIGN KEY (id_solicitante) REFERENCES solicitante(id_solicitante);

ALTER TABLE solicitante_natural
ADD CONSTRAINT pk_solicitante_natural PRIMARY KEY (id_solicitante);

ALTER TABLE solicitante_juridico
ADD CONSTRAINT fk_solicitante FOREIGN KEY (id_solicitante) REFERENCES solicitante(id_solicitante),
ADD CONSTRAINT pk_solicitante_juridico PRIMARY KEY (id_solicitante),
ADD CONSTRAINT chk_tipo_juridico CHECK(
    tipo ~* 'PÚBLICO' OR
    tipo ~* 'PUBLICO' OR
    tipo ~* 'PRIVADO' OR
    tipo ~* 'ASOCIACIÓN DE PROPIEDAD COLECTIVA' OR
    tipo ~* 'ASOCIACION DE PROPIEDAD COLECTIVA'
),
ADD CONSTRAINT chk_tipo CHECK(
    tipo ~* 'Público' AND pertenencia_del_estado IN (
        'Estatal', 
        'Mixta 51% o más', 
        'Mixta 50% o menos'
        ) OR
    tipo ~* 'Privado' AND origen_pr IN (
        'Nacional', 
        'Extranjera') OR
    tipo ~* 'Asociación de propiedad colectiva' AND tipo_pc IN (
        'Empresa de propiedad social directa comunal', 
        'Cooperativa', 
        'Empresa de propiedad social indirecta comunal', 
        'Consejo comunal',
        'Unidad productiva familiar', 
        'Comuna',
        'Conglomerado',
        'Grupo de intercambio solidario')
);

ALTER TABLE apoderado
ADD CONSTRAINT fk_pais_dom FOREIGN KEY (pais_dom) REFERENCES pais(nombre),
ADD CONSTRAINT fk_pais_nac FOREIGN KEY (pais_nac) REFERENCES pais(nombre);

ALTER TABLE apodera
ADD CONSTRAINT fk_solicitante FOREIGN KEY (fk_solicitante) REFERENCES solicitante(id_solicitante),
ADD CONSTRAINT fk_apoderado FOREIGN KEY (fk_apoderado) REFERENCES apoderado(num_agente),
ADD CONSTRAINT pk_apodera PRIMARY KEY (fk_apoderado, fk_solicitante);

ALTER TABLE representa
ADD CONSTRAINT fk_solicitante FOREIGN KEY (fk_solicitante) REFERENCES solicitante(id_solicitante),
ADD CONSTRAINT fk_representante FOREIGN KEY (fk_representante) REFERENCES representante(documento),
ADD CONSTRAINT pk_representa PRIMARY KEY (fk_representante, fk_solicitante);

ALTER TABLE marca
ADD CONSTRAINT tipo_marca CHECK (
    tipo IN ('MP','NC','MS', 'DC', 'MC','DO','LC')
);
