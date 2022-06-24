CREATE TABLE products
(
    id          INTEGER      NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    description VARCHAR(512)
);

ALTER TABLE products
    AUTO_INCREMENT = 101;

INSERT INTO products
VALUES (default, "scooter", "Small 2-wheel scooter"),
       (default, "car battery", "12V car battery"),
       (default, "12-pack drill bits", "12-pack of drill bits with sizes ranging from #40 to #3"),
       (default, "hammer", "12oz carpenter's hammer"),
       (default, "hammer", "14oz carpenter's hammer"),
       (default, "hammer", "16oz carpenter's hammer"),
       (default, "rocks", "box of assorted rocks"),
       (default, "jacket", "water resistent black wind breaker"),
       (default, "spare tire", "24 inch spare tire");


INSERT INTO products
VALUES (default, "scooter1", "Small 2-wheel scooter");
INSERT INTO products
VALUES (default, "scooter2", "Small 2-wheel scooter");
INSERT INTO products
VALUES (default, "scooter3", "Small 2-wheel scooter");
INSERT INTO products
VALUES (default, "scooter4", "Small 2-wheel scooter");
