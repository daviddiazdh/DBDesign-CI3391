ALTER TABLE solicitud 
ADD CONSTRAINT fk_marca FOREIGN KEY (marca) REFERENCES marca(id_marca);

ALTER TABLE prioriza
ADD CONSTRAINT fk_prioridad FOREIGN KEY (prioridad) REFERENCES prioridad_extranjera(id_prioridad);

ALTER TABLE prioriza
ADD CONSTRAINT fk_solicitud FOREIGN KEY (solicitud) REFERENCES solicitud(numero_solicitud);

ALTER TABLE signo
ADD CONSTRAINT fk_marca FOREIGN KEY (marca) REFERENCES marca(id_marca);

ALTER TABLE pais
ADD CONSTRAINT fk_prioridad_pais FOREIGN KEY (fk_prioridad) REFERENCES prioridad_extranjera(id_prioridad);

ALTER TABLE solicitante
ADD CONSTRAINT pk_solicitante PRIMARY KEY (documento_tipo, documento_numero);

ALTER TABLE solicita
ADD CONSTRAINT fk_solicitud FOREIGN KEY (fk_solicitud) REFERENCES solicitud(numero_solicitud);

ALTER TABLE solicita
ADD CONSTRAINT fk_solicitante 
FOREIGN KEY (fk_solicitante_tipo, fk_solicitante_numero) REFERENCES solicitante(documento_tipo, documento_numero);

ALTER TABLE solicitante_natural
ADD CONSTRAINT fk_solicitante 
FOREIGN KEY (documento_tipo, documento_numero) REFERENCES solicitante(documento_tipo, documento_numero);

ALTER TABLE solicitante_natural
ADD CONSTRAINT pk_solicitante_natural PRIMARY KEY (documento_tipo, documento_numero);