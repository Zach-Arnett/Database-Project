-- DDL file
-- Creates the database schema

-- ----------Reference Tables (No Foreign Keys)
CREATE TABLE IF NOT EXISTS customer(
    customer_ID     INT  auto_increment NOT NULL,
    email           VARCHAR(255) UNIQUE NOT NULL,
    password        VARCHAR(255) NOT NULL,
    created_at      DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    kent_ID         VARCHAR(9),
    first_name      VARCHAR(30) NOT NULL,
    last_name       VARCHAR(30) NOT NULL,
    phone_number    VARCHAR(12),
    payment_token   VARCHAR(9) NOT NULL,
    PRIMARY KEY (customer_ID)
);
ALTER TABLE customer AUTO_INCREMENT=1;


CREATE TABLE IF NOT EXISTS order_info(
    order_ID        INT  auto_increment NOT NULL,
    order_number    VARCHAR(3) NOT NULL,
    ME_order        BOOLEAN NOT NULL,
    PRIMARY KEY (order_ID)
);
ALTER TABLE order_info AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS dining_location(
    location_name   VARCHAR(50) NOT NULL,
    ME_location     BOOLEAN NOT NULL,
    PRIMARY KEY (location_name)
);
-- References dining_location
CREATE TABLE IF NOT EXISTS hours(
    location_name   VARCHAR(50) NOT NULL,
    day             ENUM('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday') NOT NULL,
    status          VARCHAR(10) NOT NULL,
    open_time       TIME,
    close_time      TIME,
    PRIMARY KEY (location_name, day),
    FOREIGN KEY (location_name) REFERENCES dining_location (location_name)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS food_items(
    item_name       VARCHAR(50) NOT NULL,
    cost            DECIMAL(5, 2) NOT NULL check (cost >= 0),
    item_type       ENUM('Main', 'Side', 'Drink') NOT NULL,
    ME_item         BOOLEAN NOT NULL,
    PRIMARY KEY (item_name)
);

CREATE TABLE IF NOT EXISTS ingredients(
    ingredient_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (ingredient_name)
);
-- References ingredients
CREATE TABLE IF NOT EXISTS allergens(
    ingredient_name VARCHAR(50) NOT NULL,
    allergen        VARCHAR(50) NOT NULL,
    PRIMARY KEY (ingredient_name, allergen),
    FOREIGN KEY (ingredient_name) REFERENCES ingredients (ingredient_name)
        ON DELETE CASCADE
);


-- ----------Referencing Tables (Multiple Foreign Keys)
CREATE TABLE IF NOT EXISTS places(
    customer_ID     INT NOT NULL,
    order_ID        INT NOT NULL,
    PRIMARY KEY (customer_ID, order_ID),
    FOREIGN KEY (customer_ID) REFERENCES customer (customer_ID) ,
    FOREIGN KEY (order_ID) REFERENCES order_info (order_ID)
);

CREATE TABLE IF NOT EXISTS fulfilled_by(
    order_ID        INT NOT NULL,
    location_name   VARCHAR(50) NOT NULL,
    PRIMARY KEY (order_ID, location_name),
    FOREIGN KEY (order_ID) REFERENCES order_info (order_ID),
    FOREIGN KEY (location_name) REFERENCES dining_location (location_name)
);

CREATE TABLE IF NOT EXISTS consists_of(
    order_ID        INT NOT NULL,
    item_name       VARCHAR(50) NOT NULL,
    quantity        INT NOT NULL,
    PRIMARY KEY (order_ID, item_name),
    FOREIGN KEY (order_ID) REFERENCES order_info (order_ID),
    FOREIGN KEY (item_name) REFERENCES food_items (item_name)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS offers(
    location_name   VARCHAR(50) NOT NULL,
    item_name       VARCHAR(50) NOT NULL,
    PRIMARY KEY (location_name, item_name),
    FOREIGN KEY (location_name) REFERENCES dining_location (location_name)
        ON DELETE CASCADE,
    FOREIGN KEY (item_name) REFERENCES food_items (item_name)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS contains(
    item_name       VARCHAR(50) NOT NULL,
    ingredient_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (item_name, ingredient_name),
    FOREIGN KEY (item_name) REFERENCES food_items (item_name)
        ON DELETE CASCADE,
    FOREIGN KEY (ingredient_name) REFERENCES ingredients (ingredient_name)
        ON DELETE CASCADE
);