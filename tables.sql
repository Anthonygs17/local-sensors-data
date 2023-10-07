CREATE TABLE microcontrolador(
	id SERIAL,
	modelo VARCHAR(255) NOT NULL,
	granja VARCHAR(255) NOT NULL,
	nucleo INT NOT NULL,
	galpon INT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE sensor (
	id SERIAL,
	tipo VARCHAR(255) NOT NULL,
	modelo VARCHAR(255) NOT NULL,
	microcontrolador_id INT NOT NULL,
	pin INT NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (microcontrolador_id) REFERENCES microcontrolador (id)
);

CREATE TABLE sensor_data (
  	id SERIAL,
	datetime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    sensor_id INT NOT NULL,
	valor DECIMAL(10,2) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (sensor_id) REFERENCES sensor (id)
);


INSERT INTO microcontrolador (modelo, granja, nucleo, galpon) VALUES ('rpi pico w', 'SAN SANTIAGO', 1, 1);
INSERT INTO sensor (tipo, modelo, microcontrolador_id, pin) VALUES ('temperatura', 'ds18b20', 1, 1);
INSERT INTO sensor (tipo, modelo, microcontrolador_id, pin) VALUES ('temperatura', 'ds18b20', 1, 2);
INSERT INTO sensor (tipo, modelo, microcontrolador_id, pin) VALUES ('temperatura', 'ds18b20', 1, 3);
INSERT INTO sensor (tipo, modelo, microcontrolador_id, pin) VALUES ('humedad', 'dht22', 1, 4);
INSERT INTO sensor (tipo, modelo, microcontrolador_id, pin) VALUES ('humedad', 'dht22', 1, 5);
INSERT INTO sensor (tipo, modelo, microcontrolador_id, pin) VALUES ('humedad', 'dht22', 1, 6);
INSERT INTO sensor (tipo, modelo, microcontrolador_id, pin) VALUES ('co2', 'mh-z19b', 1, 7);
INSERT INTO sensor (tipo, modelo, microcontrolador_id, pin) VALUES ('co2', 'mh-z19b', 1, 8);
INSERT INTO sensor (tipo, modelo, microcontrolador_id, pin) VALUES ('co2', 'mh-z19b', 1, 9);


SELECT id FROM sensor WHERE microcontrolador_id = 1 and pin = 1;
INSERT INTO sensor_data (sensor_id, valor) VALUES (1, 25.64);
