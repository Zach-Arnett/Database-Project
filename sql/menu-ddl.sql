-- DDL file
-- Creates the database schema

-- ----------Reference Tables (No Foreign Keys)
CREATE TABLE IF NOT EXISTS customer(
    customer_ID     int  auto_increment,
    email           varchar(255) UNIQUE,
    password        varchar(255) NOT NULL,
    created_at      datetime DEFAULT CURRENT_TIMESTAMP,
    kent_ID         varchar(9),
    first_name      varchar(30),
    last_name       varchar(30),
    phone_number    varchar(12),
    payment_token   varchar(9),
    primary key (customer_ID)
);
ALTER TABLE customer AUTO_INCREMENT=1;


CREATE TABLE IF NOT EXISTS order_info(
    order_ID        int  auto_increment,
    order_number    varchar(3),
    ME_order        bit(1),
    primary key (order_ID)
);
ALTER TABLE order_info AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS dining_location(
    location_name   varchar(50),
    ME_location     bit(1),
    primary key (location_name)
);
-- References dining_location
CREATE TABLE IF NOT EXISTS hours(
    location_name   varchar(50),
    day             ENUM('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'),
    status          varchar(10),
    open_time       time,
    close_time      time,
    primary key (location_name, day),
    foreign key (location_name) references dining_location (location_name)
        on delete cascade
);

CREATE TABLE IF NOT EXISTS food_items(
    item_name       varchar(50),
    cost            decimal(5, 2) check (cost >= 0),
    item_type       ENUM('Main', 'Side', 'Drink'),
    ME_item         bit(1),
    primary key (item_name)
);

CREATE TABLE IF NOT EXISTS ingredients(
    ingredient_name varchar(50),
    primary key (ingredient_name)
);
-- References ingredients
CREATE TABLE IF NOT EXISTS allergens(
    ingredient_name varchar(50),
    allergen        varchar(50),
    primary key (ingredient_name, allergen),
    foreign key (ingredient_name) references ingredients (ingredient_name)
        on delete cascade
);


-- ----------Referencing Tables (Multiple Foreign Keys)
CREATE TABLE IF NOT EXISTS places(
    customer_ID     int,
    order_ID        int,
    primary key (customer_ID, order_ID),
    foreign key (customer_ID) references customer (customer_ID) ,
    foreign key (order_ID) references order_info (order_ID)
);

CREATE TABLE IF NOT EXISTS fulfilled_by(
    order_ID        int,
    location_name   varchar(50),
    primary key (order_ID, location_name),
    foreign key (order_ID) references order_info (order_ID),
    foreign key (location_name) references dining_location (location_name)
);

CREATE TABLE IF NOT EXISTS consists_of(
    order_ID        int,
    item_name       varchar(50),
    quantity        int,
    primary key (order_ID, item_name),
    foreign key (order_ID) references order_info (order_ID),
    foreign key (item_name) references food_items (item_name)
        on delete cascade
);

CREATE TABLE IF NOT EXISTS offers(
    location_name   varchar(50),
    item_name       varchar(50),
    primary key (location_name, item_name),
    foreign key (location_name) references dining_location (location_name)
        on delete cascade,
    foreign key (item_name) references food_items (item_name)
        on delete cascade
);

CREATE TABLE IF NOT EXISTS contains(
    item_name       varchar(50),
    ingredient_name varchar(50),
    primary key (item_name, ingredient_name),
    foreign key (item_name) references food_items (item_name)
        on delete cascade,
    foreign key (ingredient_name) references ingredients (ingredient_name)
        on delete cascade
);