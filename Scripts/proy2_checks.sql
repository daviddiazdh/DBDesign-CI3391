ALTER TABLE solicitud 
ADD CONSTRAINT fk_marca FOREIGN KEY (marca) REFERENCES marca(id_marca);

ALTER TABLE solicitante
ADD CONSTRAINT fk_apoderado FOREIGN KEY (num_agente) REFERENCES apoderado(num_agente);

ALTER TABLE solicitante
ADD CONSTRAINT fk_pais_dom FOREIGN KEY (pais_dom) REFERENCES pais(nombre);

ALTER TABLE solicitante
ADD CONSTRAINT fk_pais_nac FOREIGN KEY (pais_nac) REFERENCES pais(nombre);

ALTER TABLE prioriza
ADD CONSTRAINT fk_prioridad FOREIGN KEY (prioridad) REFERENCES prioridad_extranjera(numero_prioridad);

ALTER TABLE prioriza
ADD CONSTRAINT fk_solicitud FOREIGN KEY (solicitud) REFERENCES solicitud(numero_solicitud);

ALTER TABLE signo
ADD CONSTRAINT fk_marca FOREIGN KEY (marca) REFERENCES marca(id_marca);

ALTER TABLE prioridad_extranjera
ADD CONSTRAINT fk_pais FOREIGN KEY (fk_pais) REFERENCES pais(nombre);

ALTER TABLE prioridad_extranjera
ADD CONSTRAINT pk_numero_prioridad PRIMARY KEY (numero_prioridad);

ALTER TABLE solicita
ADD CONSTRAINT fk_solicitud FOREIGN KEY (fk_solicitud) REFERENCES solicitud(numero_solicitud);

ALTER TABLE solicita
ADD CONSTRAINT fk_solicitante 
FOREIGN KEY (fk_solicitante) REFERENCES solicitante(id_solicitante);

ALTER TABLE solicitante_natural
ADD CONSTRAINT fk_solicitante 
FOREIGN KEY (id_solicitante) REFERENCES solicitante(id_solicitante);

ALTER TABLE solicitante_natural
ADD CONSTRAINT pk_solicitante_natural PRIMARY KEY (id_solicitante);

ALTER TABLE solicitante_juridico
ADD CONSTRAINT fk_solicitante 
FOREIGN KEY (id_solicitante) REFERENCES solicitante(id_solicitante);

ALTER TABLE solicitante_juridico
ADD CONSTRAINT pk_solicitante_juridico PRIMARY KEY (id_solicitante);

ALTER TABLE apoderado
ADD CONSTRAINT fk_pais_dom FOREIGN KEY (pais_dom) REFERENCES pais(nombre);

ALTER TABLE apoderado
ADD CONSTRAINT fk_pais_nac FOREIGN KEY (pais_nac) REFERENCES pais(nombre);

--ALTER TABLE solicitante_juridico
--ADD CONSTRAINT fk_solicitante 
--FOREIGN KEY (documento_tipo, documento_numero) REFERENCES solicitante(documento_tipo, documento_numero);

--ALTER TABLE solicitante_juridico
--ADD CONSTRAINT pk_solicitante_juridico PRIMARY KEY (documento_tipo, documento_numero);
