ALTER TABLE solicitud 
ADD CONSTRAINT fk_marca FOREIGN KEY (marca) REFERENCES marca(id_marca);

ALTER TABLE prioriza
ADD CONSTRAINT fk_prioridad FOREIGN KEY (prioridad) REFERENCES prioridad_extranjera(id_prioridad);

ALTER TABLE prioriza
ADD CONSTRAINT fk_solicitud FOREIGN KEY (solicitud) REFERENCES solicitud(numero_solicitud);