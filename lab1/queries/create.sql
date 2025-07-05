CREATE TABLE Locations (
                           location_id SERIAL PRIMARY KEY,
                           latitude NUMERIC(9, 6) NOT NULL,
                           longitude NUMERIC(9, 6) NOT NULL,
                           description TEXT
);

CREATE TABLE Animals (
                         animal_id SERIAL PRIMARY KEY,
                         species VARCHAR(50) NOT NULL,
                         status VARCHAR(50) NOT NULL,
                         age INTEGER NOT NULL
);

CREATE TABLE Trees (
                       tree_id SERIAL PRIMARY KEY,
                       species VARCHAR(50) NOT NULL,
                       height NUMERIC(5, 2) NOT NULL,
                       location_id INT NOT NULL,
                       CONSTRAINT fk_location_tree FOREIGN KEY (location_id) REFERENCES Locations(location_id) on delete set null on update cascade
);

CREATE TABLE Ground (
                        ground_id SERIAL PRIMARY KEY,
                        ground_type VARCHAR(50) NOT NULL,
                        condition VARCHAR(50) NOT NULL,
                        location_id INT NOT NULL,
                        CONSTRAINT fk_location_ground FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

CREATE TABLE Observations (
                              observation_id SERIAL PRIMARY KEY,
                              animal_id INT NOT NULL,
                              location_id INT NOT NULL,
                              timestamp TIMESTAMP NOT NULL DEFAULT NOW(),
                              CONSTRAINT fk_animal_observation FOREIGN KEY (animal_id) REFERENCES Animals(animal_id) ON DELETE CASCADE ON UPDATE CASCADE,
                              CONSTRAINT fk_location_observation FOREIGN KEY (location_id) REFERENCES Locations(location_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Movements (
                           movement_id SERIAL PRIMARY KEY,
                           animal_id INT NOT NULL,
                           from_location_id INT NOT NULL,
                           to_location_id INT NOT NULL,
                           timestamp TIMESTAMP NOT NULL DEFAULT NOW(),
                           CONSTRAINT fk_animal_movement FOREIGN KEY (animal_id) REFERENCES Animals(animal_id) ON DELETE CASCADE ON UPDATE CASCADE,
                           CONSTRAINT fk_from_location FOREIGN KEY (from_location_id) REFERENCES Locations(location_id) ON DELETE CASCADE ON UPDATE CASCADE,
                           CONSTRAINT fk_to_location FOREIGN KEY (to_location_id) REFERENCES Locations(location_id) ON DELETE CASCADE ON UPDATE CASCADE,
                           CONSTRAINT chk_different_locations CHECK (from_location_id <> to_location_id)
);

CREATE OR REPLACE FUNCTION check_movement_timestamp()
    RETURNS TRIGGER AS $$
DECLARE
last_observation_timestamp TIMESTAMP;
BEGIN
SELECT MAX(timestamp) INTO last_observation_timestamp
FROM Observations
WHERE animal_id = NEW.animal_id;

IF last_observation_timestamp IS NOT NULL AND NEW.timestamp < last_observation_timestamp THEN
        RAISE EXCEPTION 'Время перемещения (%) не может быть раньше последнего наблюдения (%)', NEW.timestamp, last_observation_timestamp;
END IF;

RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_movement_time
    BEFORE INSERT OR UPDATE ON Movements
                         FOR EACH ROW EXECUTE FUNCTION check_movement_timestamp();

