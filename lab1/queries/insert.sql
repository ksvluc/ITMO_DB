INSERT INTO Locations (latitude, longitude, description) VALUES
    (45.123456, -93.123456, 'Лесная зона'),
    (45.124500, -93.124500, 'Открытая поляна'),
    (45.123600, -93.123600, 'Место, где растёт большой дуб'),
    (45.123800, -93.123800, 'Место, где стоит высокая сосна'),
    (45.124000, -93.124000, 'Участок земли с сухим грунтом'),
    (45.124200, -93.124200, 'Зелёная поляна с влажной травой');

INSERT INTO Animals (species, status, age) VALUES
    ('Отнелий', 'Резкий', 5),
    ('Отнелий', 'Дерзкий', 4);

INSERT INTO Trees (species, height, location_id) VALUES
    ('Дуб', 15.75, 3),
    ('Сосна', 20.30, 4);

INSERT INTO Ground (ground_type, condition, location_id) VALUES
    ('Грунт', 'Сухой', 5),
    ('Трава', 'Влажная', 6);

INSERT INTO Observations (animal_id, location_id, timestamp) VALUES
    (1, 3, '2025-03-24 08:30:00'),
    (1, 5, '2025-03-24 08:45:00'),
    (2, 4, '2025-03-24 09:00:00');

INSERT INTO Movements (animal_id, from_location_id, to_location_id, timestamp) VALUES
    (1, 3, 5, '2025-03-24 08:40:00'),
    (2, 4, 6, '2025-03-24 09:10:00');
