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
