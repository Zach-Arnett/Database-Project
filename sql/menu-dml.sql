-- DML file
-- Inserts example data into the database, clearing all previous data

-- ----------Clear Previous Data
DELETE FROM places;
DELETE FROM fulfilled_by;
DELETE FROM offers;
DELETE FROM contains;
DELETE FROM consists_of;
DELETE FROM customer;
DELETE FROM order_info;
DELETE FROM hours;
DELETE FROM dining_location;
DELETE FROM food_items;
DELETE FROM allergens;
DELETE FROM ingredients;


-- ----------Reference Tables (No foreign keys)
-- (customer_ID (auto increments), email, password, created_at (auto generates), kent_ID, first_name, last_name, phone_number, payment_token)
ALTER TABLE customer AUTO_INCREMENT = 1; -- Ensures incrementing starts from 1
INSERT INTO customer (email, password, created_at, kent_ID, first_name, last_name, phone_number, payment_token) VALUES ('jsmith@kent.edu', '$2y$10$ZtHWIPQ.lWm6KRDSPRZtbeP9i1DOGKl.VQ4DIWUPxn/HltxqQqDou', '2024-04-23 19:22:44', '123456789', 'John', 'Smith', '440-123-1234', 'A1B2C3D4E');
INSERT INTO customer (email, password, created_at, kent_ID, first_name, last_name, phone_number, payment_token) VALUES ('tswift@kent.edu', '$2y$10$xVS.mAjSRvUXMPPyXKhhi.3mzGV8x2Kw7tDzY5Hi.FbRcczT50.mm', '2024-04-23 19:27:12', '222222222', 'Taylor', 'Swift', '440-333-4444', 'ABCD12345');
-- (order_ID (auto increments), order_number, ME_order)
ALTER TABLE order_info AUTO_INCREMENT = 1; -- Ensures incrementing starts from 1
INSERT INTO order_info (order_number, ME_order) VALUES ('001', FALSE);
INSERT INTO order_info (order_number, ME_order) VALUES ('101', FALSE);
INSERT INTO order_info (order_number, ME_order) VALUES ('997', FALSE);
-- (location_name, ME_location)
INSERT INTO dining_location VALUES ('Rosie''s Diner', TRUE);
INSERT INTO dining_location VALUES ('Rosie''s Deli', TRUE);
INSERT INTO dining_location VALUES ('Metropolitan Deli (Eastway)', TRUE);
INSERT INTO dining_location VALUES ('Metropolitan Deli (HUB)', TRUE);
INSERT INTO dining_location VALUES ('Einstein Bagels', TRUE);
INSERT INTO dining_location VALUES ('Grill 72', TRUE);
INSERT INTO dining_location VALUES ('Wild Blue', FALSE);
INSERT INTO dining_location VALUES ('Hippie Chick''n', TRUE);
INSERT INTO dining_location VALUES ('Homeslice', TRUE);
INSERT INTO dining_location VALUES ('Tahini', TRUE);
INSERT INTO dining_location VALUES ('George T. Simon III Cafe', TRUE);
INSERT INTO dining_location VALUES ('Starbucks (Library)', FALSE);
INSERT INTO dining_location VALUES ('Starbucks (Esplanade)', FALSE);
-- (location_name, day, status, open_time, close_time)
INSERT INTO hours VALUES ('Rosie''s Diner',                   'Sunday',      'Open', '11:00:00', '01:00:00');
INSERT INTO hours VALUES ('Rosie''s Diner',                   'Monday',      'Open', '09:00:00', '01:00:00');
INSERT INTO hours VALUES ('Rosie''s Diner',                   'Tuesday',     'Open', '09:00:00', '01:00:00');
INSERT INTO hours VALUES ('Rosie''s Diner',                   'Wednesday',   'Open', '09:00:00', '01:00:00');
INSERT INTO hours VALUES ('Rosie''s Diner',                   'Thursday',    'Open', '09:00:00', '01:00:00');
INSERT INTO hours VALUES ('Rosie''s Diner',                   'Friday',      'Open', '09:00:00', '01:00:00');
INSERT INTO hours VALUES ('Rosie''s Diner',                   'Saturday',    'Open', '11:00:00', '01:00:00');
INSERT INTO hours VALUES ('Rosie''s Deli',                    'Sunday',      'Open', '11:00:00', '01:00:00');
INSERT INTO hours VALUES ('Rosie''s Deli',                    'Monday',      'Open', '09:00:00', '01:00:00');
INSERT INTO hours VALUES ('Rosie''s Deli',                    'Tuesday',     'Open', '09:00:00', '01:00:00');
INSERT INTO hours VALUES ('Rosie''s Deli',                    'Wednesday',   'Open', '09:00:00', '01:00:00');
INSERT INTO hours VALUES ('Rosie''s Deli',                    'Thursday',    'Open', '09:00:00', '01:00:00');
INSERT INTO hours VALUES ('Rosie''s Deli',                    'Friday',      'Open', '09:00:00', '01:00:00');
INSERT INTO hours VALUES ('Rosie''s Deli',                    'Saturday',    'Open', '11:00:00', '01:00:00');
INSERT INTO hours VALUES ('Metropolitan Deli (Eastway)',      'Sunday',      'Open', '12:00:00', '21:00:00');
INSERT INTO hours VALUES ('Metropolitan Deli (Eastway)',      'Monday',      'Open', '10:00:00', '22:00:00');
INSERT INTO hours VALUES ('Metropolitan Deli (Eastway)',      'Tuesday',     'Open', '10:00:00', '22:00:00');
INSERT INTO hours VALUES ('Metropolitan Deli (Eastway)',      'Wednesday',   'Open', '10:00:00', '22:00:00');
INSERT INTO hours VALUES ('Metropolitan Deli (Eastway)',      'Thursday',    'Open', '10:00:00', '22:00:00');
INSERT INTO hours VALUES ('Metropolitan Deli (Eastway)',      'Friday',      'Open', '10:00:00', '22:00:00');
INSERT INTO hours VALUES ('Metropolitan Deli (Eastway)',      'Saturday',    'Open', '12:00:00', '21:00:00');
INSERT INTO hours VALUES ('Metropolitan Deli (HUB)',          'Sunday',      'Closed', NULL, NULL);
INSERT INTO hours VALUES ('Metropolitan Deli (HUB)',          'Monday',      'Open', '10:30:00', '17:00:00');
INSERT INTO hours VALUES ('Metropolitan Deli (HUB)',          'Tuesday',     'Open', '10:30:00', '17:00:00');
INSERT INTO hours VALUES ('Metropolitan Deli (HUB)',          'Wednesday',   'Open', '10:30:00', '17:00:00');
INSERT INTO hours VALUES ('Metropolitan Deli (HUB)',          'Thursday',    'Open', '10:30:00', '17:00:00');
INSERT INTO hours VALUES ('Metropolitan Deli (HUB)',          'Friday',      'Open', '10:30:00', '17:00:00');
INSERT INTO hours VALUES ('Metropolitan Deli (HUB)',          'Saturday',    'Open', '10:30:00', '15:00:00');
INSERT INTO hours VALUES ('Einstein Bagels',                  'Sunday',      'Closed', NULL, NULL);
INSERT INTO hours VALUES ('Einstein Bagels',                  'Monday',      'Open', '07:00:00', '15:00:00');
INSERT INTO hours VALUES ('Einstein Bagels',                  'Tuesday',     'Open', '07:00:00', '15:00:00');
INSERT INTO hours VALUES ('Einstein Bagels',                  'Wednesday',   'Open', '07:00:00', '15:00:00');
INSERT INTO hours VALUES ('Einstein Bagels',                  'Thursday',    'Open', '07:00:00', '15:00:00');
INSERT INTO hours VALUES ('Einstein Bagels',                  'Friday',      'Open', '07:00:00', '15:00:00');
INSERT INTO hours VALUES ('Einstein Bagels',                  'Saturday',    'Open', '09:00:00', '15:00:00');
INSERT INTO hours VALUES ('Grill 72',                         'Sunday',      'Closed', NULL, NULL);
INSERT INTO hours VALUES ('Grill 72',                         'Monday',      'Open', '08:00:00', '20:00:00');
INSERT INTO hours VALUES ('Grill 72',                         'Tuesday',     'Open', '08:00:00', '20:00:00');
INSERT INTO hours VALUES ('Grill 72',                         'Wednesday',   'Open', '08:00:00', '20:00:00');
INSERT INTO hours VALUES ('Grill 72',                         'Thursday',    'Open', '08:00:00', '20:00:00');
INSERT INTO hours VALUES ('Grill 72',                         'Friday',      'Open', '08:00:00', '20:00:00');
INSERT INTO hours VALUES ('Grill 72',                         'Saturday',    'Open', '11:00:00', '18:00:00');
INSERT INTO hours VALUES ('Wild Blue',                        'Sunday',      'Closed', NULL, NULL);
INSERT INTO hours VALUES ('Wild Blue',                        'Monday',      'Open', '10:30:00', '20:00:00');
INSERT INTO hours VALUES ('Wild Blue',                        'Tuesday',     'Open', '10:30:00', '20:00:00');
INSERT INTO hours VALUES ('Wild Blue',                        'Wednesday',   'Open', '10:30:00', '20:00:00');
INSERT INTO hours VALUES ('Wild Blue',                        'Thursday',    'Open', '10:30:00', '20:00:00');
INSERT INTO hours VALUES ('Wild Blue',                        'Friday',      'Open', '10:30:00', '20:00:00');
INSERT INTO hours VALUES ('Wild Blue',                        'Saturday',    'Open', '10:30:00', '18:00:00');
INSERT INTO hours VALUES ('Hippie Chick''n',                  'Sunday',      'Closed', NULL, NULL);
INSERT INTO hours VALUES ('Hippie Chick''n',                  'Monday',      'Open', '10:30:00', '20:00:00');
INSERT INTO hours VALUES ('Hippie Chick''n',                  'Tuesday',     'Open', '10:30:00', '20:00:00');
INSERT INTO hours VALUES ('Hippie Chick''n',                  'Wednesday',   'Open', '10:30:00', '20:00:00');
INSERT INTO hours VALUES ('Hippie Chick''n',                  'Thursday',    'Open', '10:30:00', '20:00:00');
INSERT INTO hours VALUES ('Hippie Chick''n',                  'Friday',      'Open', '10:30:00', '20:00:00');
INSERT INTO hours VALUES ('Hippie Chick''n',                  'Saturday',    'Open', '10:30:00', '18:00:00');
INSERT INTO hours VALUES ('Homeslice',                        'Sunday',      'Closed', NULL, NULL);
INSERT INTO hours VALUES ('Homeslice',                        'Monday',      'Open', '11:00:00', '18:00:00');
INSERT INTO hours VALUES ('Homeslice',                        'Tuesday',     'Open', '11:00:00', '18:00:00');
INSERT INTO hours VALUES ('Homeslice',                        'Wednesday',   'Open', '11:00:00', '18:00:00');
INSERT INTO hours VALUES ('Homeslice',                        'Thursday',    'Open', '11:00:00', '18:00:00');
INSERT INTO hours VALUES ('Homeslice',                        'Friday',      'Open', '11:00:00', '18:00:00');
INSERT INTO hours VALUES ('Homeslice',                        'Saturday',    'Open', '11:00:00', '15:00:00');
INSERT INTO hours VALUES ('Tahini',                           'Sunday',      'Closed', NULL, NULL);
INSERT INTO hours VALUES ('Tahini',                           'Monday',      'Open', '11:30:00', '21:00:00');
INSERT INTO hours VALUES ('Tahini',                           'Tuesday',     'Open', '11:30:00', '21:00:00');
INSERT INTO hours VALUES ('Tahini',                           'Wednesday',   'Open', '11:30:00', '21:00:00');
INSERT INTO hours VALUES ('Tahini',                           'Thursday',    'Open', '11:30:00', '21:00:00');
INSERT INTO hours VALUES ('Tahini',                           'Friday',      'Open', '11:30:00', '21:00:00');
INSERT INTO hours VALUES ('Tahini',                           'Saturday',    'Closed', NULL, NULL);
INSERT INTO hours VALUES ('George T. Simon III Cafe',         'Sunday',      'Open', '12:00:00', '16:00:00');
INSERT INTO hours VALUES ('George T. Simon III Cafe',         'Monday',      'Open', '07:30:00', '17:00:00');
INSERT INTO hours VALUES ('George T. Simon III Cafe',         'Tuesday',     'Open', '07:30:00', '17:00:00');
INSERT INTO hours VALUES ('George T. Simon III Cafe',         'Wednesday',   'Open', '07:30:00', '17:00:00');
INSERT INTO hours VALUES ('George T. Simon III Cafe',         'Thursday',    'Open', '07:30:00', '17:00:00');
INSERT INTO hours VALUES ('George T. Simon III Cafe',         'Friday',      'Open', '07:30:00', '17:00:00');
INSERT INTO hours VALUES ('George T. Simon III Cafe',         'Saturday',    'Closed', NULL, NULL);
INSERT INTO hours VALUES ('Starbucks (Library)',              'Sunday',      'Open', '13:00:00', '22:00:00');
INSERT INTO hours VALUES ('Starbucks (Library)',              'Monday',      'Open', '08:00:00', '23:00:00');
INSERT INTO hours VALUES ('Starbucks (Library)',              'Tuesday',     'Open', '08:00:00', '23:00:00');
INSERT INTO hours VALUES ('Starbucks (Library)',              'Wednesday',   'Open', '08:00:00', '23:00:00');
INSERT INTO hours VALUES ('Starbucks (Library)',              'Thursday',    'Open', '08:00:00', '23:00:00');
INSERT INTO hours VALUES ('Starbucks (Library)',              'Friday',      'Open', '08:00:00', '17:00:00');
INSERT INTO hours VALUES ('Starbucks (Library)',              'Saturday',    'Open', '09:00:00', '17:00:00');
INSERT INTO hours VALUES ('Starbucks (Esplanade)',            'Sunday',      'Closed', NULL, NULL);
INSERT INTO hours VALUES ('Starbucks (Esplanade)',            'Monday',      'Open', '08:00:00', '16:00:00');
INSERT INTO hours VALUES ('Starbucks (Esplanade)',            'Tuesday',     'Open', '08:00:00', '16:00:00');
INSERT INTO hours VALUES ('Starbucks (Esplanade)',            'Wednesday',   'Open', '08:00:00', '16:00:00');
INSERT INTO hours VALUES ('Starbucks (Esplanade)',            'Thursday',    'Open', '08:00:00', '16:00:00');
INSERT INTO hours VALUES ('Starbucks (Esplanade)',            'Friday',      'Open', '08:00:00', '16:00:00');
INSERT INTO hours VALUES ('Starbucks (Esplanade)',            'Saturday',    'Closed', NULL, NULL);
-- (item_name, cost, item_type, ME_item)
INSERT INTO food_items VALUES ('Burger', 7.99, 'Main', TRUE);
INSERT INTO food_items VALUES ('Quesadilla', 8.99, 'Main', TRUE);
INSERT INTO food_items VALUES ('Breakfast Sandwich', 7.99, 'Main', TRUE);
INSERT INTO food_items VALUES ('Pizza', 10.99, 'Main', TRUE);
INSERT INTO food_items VALUES ('Chicken Tenders', 6.99, 'Main', TRUE);
INSERT INTO food_items VALUES('Crispy Chicken Sandwich', 7.99, 'Main', TRUE); -- Start new items
INSERT INTO food_items VALUES('Pancakes', 6.99, 'Main', TRUE);
INSERT INTO food_items VALUES('Grilled Chicken Wrap', 5.49, 'Main', TRUE);
INSERT INTO food_items VALUES('Grilled Chicken Bacon Ranch Wrap', 5.49, 'Main', FALSE);
INSERT INTO food_items VALUES('Meatball Sub', 9.50, 'Main', TRUE);
INSERT INTO food_items VALUES('Philly Cheese Steak', 9.50, 'Main', TRUE);
INSERT INTO food_items VALUES('Grilled Cheese', 4.49, 'Main', TRUE);
INSERT INTO food_items VALUES('Chicken Philly', 8.99, 'Main', TRUE); -- End new items
INSERT INTO food_items VALUES ('Italian Sub', 9.49, 'Main', TRUE);
INSERT INTO food_items VALUES ('Mozzarella Sticks', 5.49, 'Main', TRUE);
INSERT INTO food_items VALUES ('Salmon Avocado Roll', 9.99, 'Main', FALSE);
INSERT INTO food_items VALUES ('Falafel Wrap', 10.19, 'Main', TRUE);
INSERT INTO food_items VALUES ('The Black Squirrel', 9.49, 'Main', TRUE);
INSERT INTO food_items VALUES ('Metropolitan Express', 9.59, 'Main', TRUE);
INSERT INTO food_items VALUES ('Fried Egg', 6.59, 'Main', TRUE);
INSERT INTO food_items VALUES ('Hot Dog', 7.59, 'Main', TRUE);
INSERT INTO food_items VALUES ('Salad', 7.49, 'Main', TRUE);
INSERT INTO food_items VALUES ('Shawarma', 7.49, 'Main', TRUE);
INSERT INTO food_items VALUES ('Black Forest Ham & Swiss on a Gluten Free Bun', '7.99', 'Main', TRUE);
INSERT INTO food_items VALUES ('Chicken Bacon Club', '7.19', 'Main', TRUE);
INSERT INTO food_items VALUES ('PB&J', '4.19', 'Main', TRUE);

INSERT INTO food_items VALUES ('Cookie', '1.59', 'Side', TRUE);
INSERT INTO food_items VALUES ('Croissant', '2.39', 'Side', TRUE);
INSERT INTO food_items VALUES ('Donut', '1.59', 'Side', TRUE);
INSERT INTO food_items VALUES ('Fries', 1.59, 'Side', TRUE);
INSERT INTO food_items VALUES ('Curly Fries', 1.59, 'Side', TRUE);
INSERT INTO food_items VALUES ('Potato Chips', 1.59, 'Side', TRUE);
INSERT INTO food_items VALUES ('Yogurt', 1.59, 'Side', TRUE);
INSERT INTO food_items VALUES ('Side Salad', 1.99, 'Side', TRUE);
INSERT INTO food_items VALUES ('Assorted Fruit', 1.49, 'Side', TRUE);

INSERT INTO food_items VALUES ('Cappuccino', '3.19', 'Drink', TRUE);
INSERT INTO food_items VALUES ('Espresso Shot', '1.99', 'Drink', FALSE);
INSERT INTO food_items VALUES ('Hot Chocolate', '3.49', 'Drink', TRUE);
INSERT INTO food_items VALUES ('Fountain Drink', 1.59, 'Drink', TRUE);
INSERT INTO food_items VALUES ('Dr. Pepper', 1.59, 'Drink', TRUE);
INSERT INTO food_items VALUES ('Pepsi', 1.59, 'Drink', TRUE);
INSERT INTO food_items VALUES ('Strawberry Bubble Tea', 5.49, 'Drink', FALSE);
INSERT INTO food_items VALUES ('Bottled Water', 1.29, 'Drink', TRUE);
INSERT INTO food_items VALUES ('Caramel Macchiato', 6.00, 'Drink', FALSE);
INSERT INTO food_items VALUES ('Cold Brew', 6.00, 'Drink', FALSE);
INSERT INTO food_items VALUES ('Light Roast', 2.00, 'Drink', FALSE);
INSERT INTO food_items VALUES ('Dark Roast', 2.00, 'Drink', FALSE);
INSERT INTO food_items VALUES ('Pink Drink', 5.00, 'Drink', FALSE);
INSERT INTO food_items VALUES ('Grilled Cheese (Side)', 3.49, 'Side', FALSE);
INSERT INTO food_items VALUES ('Chocolate Cake Pop', 5.29, 'Side', FALSE);
INSERT INTO food_items VALUES ('Coffee Cake', 4.59, 'Side', FALSE);

INSERT INTO food_items VALUES ('Plain Bagel', 2.50, 'Main', FALSE); -- This and down are new menu items
INSERT INTO food_items VALUES ('Everything Bagel', 2.99, 'Main', FALSE);
INSERT INTO food_items VALUES ('Six Cheese Bagel', 2.99, 'Main', FALSE);
INSERT INTO food_items VALUES ('Tiger Roll', 8.99, 'Main', FALSE);
INSERT INTO food_items VALUES ('Poke Nigiri', 9.99, 'Main', FALSE);
INSERT INTO food_items VALUES ('Sushi', 7.49, 'Main', FALSE);

-- (ingredient_name)
INSERT INTO ingredients VALUES ('Cheese');
INSERT INTO ingredients VALUES ('Chocolate');
INSERT INTO ingredients VALUES ('Beef');
INSERT INTO ingredients VALUES ('Tomato');
INSERT INTO ingredients VALUES ('Pickle');
INSERT INTO ingredients VALUES ('Ketchup');
INSERT INTO ingredients VALUES ('Lettuce');
INSERT INTO ingredients VALUES ('Chicken');
INSERT INTO ingredients VALUES ('Egg');
INSERT INTO ingredients VALUES ('Pepperoni');
INSERT INTO ingredients VALUES ('Salami');
INSERT INTO ingredients VALUES ('Ham');
INSERT INTO ingredients VALUES ('Salmon');
INSERT INTO ingredients VALUES ('Avocado');
INSERT INTO ingredients VALUES ('Sesame');
INSERT INTO ingredients VALUES ('Falafel');
INSERT INTO ingredients VALUES ('Hummus');
INSERT INTO ingredients VALUES ('Milk');
INSERT INTO ingredients VALUES ('Caramel');
INSERT INTO ingredients VALUES ('Coffee');
INSERT INTO ingredients VALUES ('Roast Beef');
INSERT INTO ingredients VALUES ('Smoked Cheddar');
INSERT INTO ingredients VALUES ('Onion Jam');
INSERT INTO ingredients VALUES ('Horsey Sauce');
INSERT INTO ingredients VALUES ('Wheatberry Bread');
INSERT INTO ingredients VALUES ('Bacon');
INSERT INTO ingredients VALUES ('Ranch');
INSERT INTO ingredients VALUES ('Cheddar Cheese');
INSERT INTO ingredients VALUES ('Spinach');
INSERT INTO ingredients VALUES ('Red Onions');
INSERT INTO ingredients VALUES ('Canola (Oil)');
INSERT INTO ingredients VALUES ('Beef Hot Dog');
INSERT INTO ingredients VALUES ('Hot Dog Bun');
INSERT INTO ingredients VALUES ('Pizza Dough');
INSERT INTO ingredients VALUES ('Mushroom');
INSERT INTO ingredients VALUES ('Marinara Sauce');
INSERT INTO ingredients VALUES ('Bagel');
INSERT INTO ingredients VALUES ('Sausage');
INSERT INTO ingredients VALUES ('Biscuit');
INSERT INTO ingredients VALUES ('English Muffin');
INSERT INTO ingredients VALUES ('Potato');
INSERT INTO ingredients VALUES ('Strawberry');
INSERT INTO ingredients VALUES ('Sourdough Bread');
INSERT INTO ingredients VALUES ('Tapioca Pearls');
INSERT INTO ingredients VALUES ('Flour');
INSERT INTO ingredients VALUES ('Tortilla'); 
INSERT INTO ingredients VALUES ('Pancake Mix');
INSERT INTO ingredients VALUES ('Mozzarella Cheese');
INSERT INTO ingredients VALUES ('Pepperjack Cheese');
INSERT INTO ingredients VALUES ('Italian Dressing');
INSERT INTO ingredients Values ('Propellant');
INSERT INTO ingredients VALUES ('Bread');
INSERT INTO ingredients VALUES ('Wrap');
INSERT INTO ingredients VALUES ('Hamburger Bun');
INSERT INTO ingredients VALUES ('Peanuts');

INSERT INTO ingredients VALUES ('Imitation Crab'); -- This and below are new ingredients
INSERT INTO ingredients VALUES ('Shrimp');
INSERT INTO ingredients VALUES ('Tuna');
INSERT INTO ingredients VALUES ('Rice');
INSERT INTO ingredients VALUES ('Soy Sauce');
INSERT INTO ingredients VALUES ('Sesame Seeds');
INSERT INTO ingredients VALUES ('Butter');

-- (ingredient_name, allergen)
INSERT INTO allergens VALUES ('Cheese', 'Dairy');
INSERT INTO allergens VALUES ('Egg', 'Egg');
INSERT INTO allergens VALUES ('Sesame', 'Sesame');
INSERT INTO allergens VALUES ('Falafel', 'Sesame');
INSERT INTO allergens VALUES ('Milk', 'Dairy');
INSERT INTO allergens VALUES ('Ranch', 'Dairy');
INSERT INTO allergens VALUES ('Smoked Cheddar', 'Dairy');
INSERT INTO allergens VALUES ('Cheddar Cheese', 'Dairy');
INSERT INTO allergens VALUES ('Wheatberry Bread', 'Wheat');
INSERT INTO allergens VALUES ('Hot Dog Bun', 'Wheat');
INSERT INTO allergens VALUES ('Hot Dog Bun', 'Soy');
INSERT INTO allergens VALUES ('Pizza Dough', 'Dairy');
INSERT INTO allergens VALUES ('Pizza Dough', 'Soy');
INSERT INTO allergens VALUES ('Pizza Dough', 'Wheat');
INSERT INTO allergens VALUES ('Bagel', 'Sesame');
INSERT INTO allergens VALUES ('Bagel', 'Wheat');
INSERT INTO allergens VALUES ('Biscuit', 'Wheat');
INSERT INTO allergens VALUES ('English Muffin', 'Wheat');
INSERT INTO allergens VALUES ('Sourdough Bread', 'Wheat');
INSERT INTO allergens VALUES ('Flour', 'Wheat');
INSERT INTO allergens VALUES ('Pepperjack Cheese', 'Dairy');
INSERT INTO allergens VALUES ('Pancake Mix', 'Dairy');
INSERT INTO allergens VALUES ('Pancake Mix', 'Soy');
INSERT INTO allergens VALUES ('Pancake Mix', 'Wheat');
INSERT INTO allergens VALUES ('Peanuts', 'Peanuts');

INSERT INTO allergens VALUES ('Butter', 'Dairy'); -- This and down are new allergens
INSERT INTO allergens VALUES ('Salmon', 'Fish');
INSERT INTO allergens VALUES ('Tuna', 'Fish');
INSERT INTO allergens VALUES ('Imitation Crab', 'Shellfish');
INSERT INTO allergens VALUES ('Shrimp', 'Shellfish');
INSERT INTO allergens VALUES ('Soy Sauce', 'Soy');
INSERT INTO allergens VALUES ('Sesame Seeds', 'Sesame');


-- ----------Referencing Tables (Multiple Foreign Keys)
-- (customer_ID, order_ID)
INSERT INTO places VALUES (1, 1);
INSERT INTO places VALUES (1, 2);
INSERT INTO places VALUES (2, 3);
-- (order_ID, location_name)
INSERT INTO fulfilled_by VALUES (1, 'Rosie''s Diner');
INSERT INTO fulfilled_by VALUES (2, 'Grill 72');
INSERT INTO fulfilled_by VALUES (3, 'Rosie''s Diner');
-- (order_ID, item_name, quantity)
INSERT INTO consists_of VALUES (1, 'Burger', 2);
INSERT INTO consists_of VALUES (2, 'Burger', 1);
INSERT INTO consists_of VALUES (3, 'Quesadilla', 1);
-- (location_name, item_name)
INSERT INTO offers VALUES ('Rosie''s Diner', 'Burger');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Quesadilla');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Breakfast Sandwich');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Chicken Tenders');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Mozzarella Sticks');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Fries');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Yogurt');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Side Salad');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Assorted Fruit');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Dr. Pepper');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Pepsi');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Bottled Water');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Crispy Chicken Sandwich');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Pancakes');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Grilled Chicken Wrap');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Grilled Chicken Bacon Ranch Wrap');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Meatball Sub');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Philly Cheese Steak');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Grilled Cheese');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Chicken Philly');
INSERT INTO offers VALUES ('Rosie''s Diner', 'Italian Sub');

INSERT INTO offers VALUES ('Rosie''s Deli', 'Pizza');
INSERT INTO offers VALUES ('Rosie''s Deli', 'Potato Chips');
INSERT INTO offers VALUES ('Rosie''s Deli', 'Side Salad');
INSERT INTO offers VALUES ('Rosie''s Deli', 'Assorted Fruit');
INSERT INTO offers VALUES ('Rosie''s Deli', 'Dr. Pepper');
INSERT INTO offers VALUES ('Rosie''s Deli', 'Pepsi');
INSERT INTO offers VALUES ('Rosie''s Deli', 'Bottled Water');

INSERT INTO offers VALUES ('Metropolitan Deli (Eastway)', 'Italian Sub');
INSERT INTO offers VALUES ('Metropolitan Deli (Eastway)', 'The Black Squirrel');
INSERT INTO offers VALUES ('Metropolitan Deli (Eastway)', 'Metropolitan Express');
INSERT INTO offers VALUES ('Metropolitan Deli (Eastway)', 'Salad');
INSERT INTO offers VALUES ('Metropolitan Deli (Eastway)', 'Potato Chips');
INSERT INTO offers VALUES ('Metropolitan Deli (Eastway)', 'Assorted Fruit');
INSERT INTO offers VALUES ('Metropolitan Deli (Eastway)', 'Fountain Drink');
INSERT INTO offers VALUES ('Metropolitan Deli (Eastway)', 'Bottled Water');

INSERT INTO offers VALUES ('Metropolitan Deli (HUB)', 'Italian Sub');
INSERT INTO offers VALUES ('Metropolitan Deli (HUB)', 'The Black Squirrel');
INSERT INTO offers VALUES ('Metropolitan Deli (HUB)', 'Metropolitan Express');
INSERT INTO offers VALUES ('Metropolitan Deli (HUB)', 'Salad');
INSERT INTO offers VALUES ('Metropolitan Deli (HUB)', 'Assorted Fruit');
INSERT INTO offers VALUES ('Metropolitan Deli (HUB)', 'Potato Chips');
INSERT INTO offers VALUES ('Metropolitan Deli (HUB)', 'Fountain Drink');
INSERT INTO offers VALUES ('Metropolitan Deli (HUB)', 'Bottled Water');

INSERT INTO offers VALUES ('Einstein Bagels', 'Breakfast Sandwich');
INSERT INTO offers VALUES ('Einstein Bagels', 'Potato Chips'); 
INSERT INTO offers VALUES ('Einstein Bagels', 'Assorted Fruit'); 
INSERT INTO offers VALUES ('Einstein Bagels', 'Fountain Drink');
INSERT INTO offers VALUES ('Einstein Bagels', 'Bottled Water');

INSERT INTO offers VALUES ('Grill 72', 'Burger');
INSERT INTO offers VALUES ('Grill 72', 'Fried Egg');
INSERT INTO offers VALUES ('Grill 72', 'Hot Dog');
INSERT INTO offers VALUES ('Grill 72', 'Fries');
INSERT INTO offers VALUES ('Grill 72', 'Potato Chips'); 
INSERT INTO offers VALUES ('Grill 72', 'Fountain Drink');
INSERT INTO offers VALUES ('Grill 72', 'Bottled Water');

INSERT INTO offers VALUES ('Wild Blue', 'Salmon Avocado Roll');
INSERT INTO offers VALUES ('Wild Blue', 'Fountain Drink'); 
INSERT INTO offers VALUES ('Wild Blue', 'Bottled Water'); 

INSERT INTO offers VALUES ('Hippie Chick''n', 'Chicken Tenders');
INSERT INTO offers VALUES ('Hippie Chick''n', 'Curly Fries');
INSERT INTO offers VALUES ('Hippie Chick''n', 'Fountain Drink');
INSERT INTO offers VALUES ('Hippie Chick''n', 'Bottled Water');

INSERT INTO offers VALUES ('Homeslice', 'Pizza');
INSERT INTO offers VALUES ('Homeslice', 'Potato Chips');
INSERT INTO offers VALUES ('Homeslice', 'Fountain Drink');
INSERT INTO offers VALUES ('Homeslice', 'Bottled Water');

INSERT INTO offers VALUES ('Tahini', 'Falafel Wrap');
INSERT INTO offers VALUES ('Tahini', 'Salad');
INSERT INTO offers VALUES ('Tahini', 'Fries');
INSERT INTO offers VALUES ('Tahini', 'Yogurt');
INSERT INTO offers VALUES ('Tahini', 'Side Salad');
INSERT INTO offers VALUES ('Tahini', 'Dr. Pepper');
INSERT INTO offers VALUES ('Tahini', 'Pepsi');
INSERT INTO offers VALUES ('Tahini', 'Strawberry Bubble Tea');
INSERT INTO offers VALUES ('Tahini', 'Bottled Water');
INSERT INTO offers VALUES ('Tahini', 'Burger');
INSERT INTO offers VALUES ('Tahini', 'Shawarma');

INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Breakfast Sandwich');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Italian Sub');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Salad');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Potato Chips');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Assorted Fruit');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Dr. Pepper');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Pepsi');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Bottled Water');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Black Forest Ham & Swiss on a Gluten Free Bun');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Cappuccino');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Chicken Bacon Club');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Cookie');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Croissant');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Donut');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Espresso Shot');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'Hot Chocolate');
INSERT INTO offers VALUES ('George T. Simon III Cafe', 'PB&J');

INSERT INTO offers VALUES ('Starbucks (Library)', 'Caramel Macchiato');
INSERT INTO offers VALUES ('Starbucks (Library)', 'Cold Brew');
INSERT INTO offers VALUES ('Starbucks (Library)', 'Bottled Water');
INSERT INTO offers VALUES ('Starbucks (Library)', 'Dark Roast');
INSERT INTO offers VALUES ('Starbucks (Library)', 'Light Roast');
INSERT INTO offers VALUES ('Starbucks (Library)', 'Pink Drink');
INSERT INTO offers VALUES ('Starbucks (Library)', 'Breakfast Sandwich');
INSERT INTO offers VALUES ('Starbucks (Library)', 'Chocolate Cake Pop');
INSERT INTO offers VALUES ('Starbucks (Library)', 'Grilled Cheese (Side)');
INSERT INTO offers VALUES ('Starbucks (Library)', 'Coffee Cake');

INSERT INTO offers VALUES ('Starbucks (Esplanade)', 'Caramel Macchiato');
INSERT INTO offers VALUES ('Starbucks (Esplanade)', 'Cold Brew');
INSERT INTO offers VALUES ('Starbucks (Esplanade)', 'Bottled Water');
INSERT INTO offers VALUES ('Starbucks (Esplanade)', 'Dark Roast');
INSERT INTO offers VALUES ('Starbucks (Esplanade)', 'Light Roast');
INSERT INTO offers VALUES ('Starbucks (Esplanade)', 'Pink Drink');
INSERT INTO offers VALUES ('Starbucks (Esplanade)', 'Coffee Cake');
INSERT INTO offers VALUES ('Starbucks (Esplanade)', 'Chocolate Cake Pop');


INSERT INTO offers VALUES ('Einstein Bagels', 'Six Cheese Bagel'); -- New Items here down
INSERT INTO offers VALUES ('Einstein Bagels', 'Plain Bagel');
INSERT INTO offers VALUES ('Einstein Bagels', 'Everything Bagel');
INSERT INTO offers VALUES ('Wild Blue', 'Tiger Roll');
INSERT INTO offers VALUES ('Wild Blue', 'Poke Nigiri');
INSERT INTO offers VALUES ('Wild Blue', 'Sushi');


-- (item_name, ingredient_name)
INSERT INTO contains VALUES ('Burger', 'Cheese');
INSERT INTO contains VALUES ('Burger', 'Beef');
INSERT INTO contains VALUES ('Burger', 'Tomato');
INSERT INTO contains VALUES ('Burger', 'Pickle');
INSERT INTO contains VALUES ('Burger', 'Ketchup');
INSERT INTO contains VALUES ('Burger', 'Lettuce');
INSERT INTO contains VALUES ('Coffee Cake', 'Coffee');
INSERT INTO contains VALUES ('Coffee Cake', 'Egg');
INSERT INTO contains VALUES ('Coffee Cake', 'Milk');
INSERT INTO contains VALUES ('Coffee Cake', 'Flour');
INSERT INTO contains VALUES ('Light Roast', 'Coffee');
INSERT INTO contains VALUES ('Dark Roast', 'Coffee');
INSERT INTO contains VALUES ('Pink Drink', 'Coffee');
INSERT INTO contains VALUES ('Pink Drink', 'Strawberry');
INSERT INTO contains VALUES ('Pink Drink', 'Milk');
INSERT INTO contains VALUES ('Strawberry Bubble Tea', 'Strawberry');
INSERT INTO contains VALUES ('Strawberry Bubble Tea', 'Tapioca Pearls');
INSERT INTO contains VALUES ('Chocolate Cake Pop', 'Chocolate');
INSERT INTO contains VALUES ('Chocolate Cake Pop', 'Milk');
INSERT INTO contains VALUES ('Chocolate Cake Pop', 'Egg');
INSERT INTO contains VALUES ('Chocolate Cake Pop', 'Flour');
INSERT INTO contains VALUES ('Quesadilla', 'Cheese');
INSERT INTO contains VALUES ('Quesadilla', 'Chicken');
INSERT INTO contains VALUES ('Breakfast Sandwich', 'Cheese');
INSERT INTO contains VALUES ('Breakfast Sandwich', 'Egg');
INSERT INTO contains VALUES ('Breakfast Sandwich', 'Bacon');
INSERT INTO contains VALUES ('Breakfast Sandwich', 'Ham');
INSERT INTO contains VALUES ('Breakfast Sandwich', 'Bagel');
INSERT INTO contains VALUES ('Breakfast Sandwich', 'Sausage');
INSERT INTO contains VALUES ('Breakfast Sandwich', 'Biscuit');
INSERT INTO contains VALUES ('Breakfast Sandwich', 'English Muffin');
INSERT INTO contains VALUES ('Pizza', 'Cheese');
INSERT INTO contains VALUES ('Pizza', 'Pepperoni');
INSERT INTO contains VALUES ('Pizza', 'Pizza Dough');
INSERT INTO contains VALUES ('Pizza', 'Chicken');
INSERT INTO contains VALUES ('Pizza', 'Mushroom');
INSERT INTO contains VALUES ('Pizza', 'Marinara Sauce');
INSERT INTO contains VALUES ('Pizza', 'Bacon');
INSERT INTO contains VALUES ('Chicken Tenders', 'Chicken');
INSERT INTO contains VALUES ('Italian Sub', 'Cheese');
INSERT INTO contains VALUES ('Italian Sub', 'Tomato');
INSERT INTO contains VALUES ('Italian Sub', 'Lettuce');
INSERT INTO contains VALUES ('Italian Sub', 'Pepperoni');
INSERT INTO contains VALUES ('Italian Sub', 'Salami');
INSERT INTO contains VALUES ('Italian Sub', 'Ham');
INSERT INTO contains VALUES ('Mozzarella Sticks', 'Cheese');
INSERT INTO contains VALUES ('Salmon Avocado Roll', 'Salmon');
INSERT INTO contains VALUES ('Salmon Avocado Roll', 'Avocado');
INSERT INTO contains VALUES ('Salmon Avocado Roll', 'Sesame');
INSERT INTO contains VALUES ('Falafel Wrap', 'Falafel');
INSERT INTO contains VALUES ('Falafel Wrap', 'Hummus');
INSERT INTO contains VALUES ('Falafel Wrap', 'Pickle');
INSERT INTO contains VALUES ('Caramel Macchiato', 'Milk');
INSERT INTO contains VALUES ('Caramel Macchiato', 'Caramel');
INSERT INTO contains VALUES ('Caramel Macchiato', 'Coffee');
INSERT INTO contains VALUES ('Cold Brew', 'Coffee');
INSERT INTO contains VALUES ('The Black Squirrel', 'Roast Beef');
INSERT INTO contains VALUES ('The Black Squirrel', 'Smoked Cheddar');
INSERT INTO contains VALUES ('The Black Squirrel', 'Onion Jam');
INSERT INTO contains VALUES ('The Black Squirrel', 'Lettuce');
INSERT INTO contains VALUES ('The Black Squirrel', 'Horsey Sauce');
INSERT INTO contains VALUES ('The Black Squirrel', 'Wheatberry Bread');
INSERT INTO contains VALUES ('Metropolitan Express', 'Chicken');
INSERT INTO contains VALUES ('Metropolitan Express', 'Bacon');
INSERT INTO contains VALUES ('Metropolitan Express', 'Ranch');
INSERT INTO contains VALUES ('Metropolitan Express', 'Cheddar Cheese');
INSERT INTO contains VALUES ('Metropolitan Express', 'Spinach');
INSERT INTO contains VALUES ('Metropolitan Express', 'Red Onions');
INSERT INTO contains VALUES ('Fried Egg', 'Egg');
INSERT INTO contains VALUES ('Fried Egg', 'Canola (Oil)');
INSERT INTO contains VALUES ('Hot Dog', 'Beef Hot Dog');
INSERT INTO contains VALUES ('Hot Dog', 'Hot Dog Bun');
INSERT INTO contains VALUES ('Fries', 'Potato');
INSERT INTO contains VALUES ('Curly Fries', 'Potato');
INSERT INTO contains VALUES ('Potato Chips', 'Potato');
INSERT INTO contains VALUES ('Yogurt', 'Milk');
INSERT INTO contains VALUES ('Salad', 'Lettuce');
INSERT INTO contains VALUES ('Salad', 'Chicken');
INSERT INTO contains VALUES ('Salad', 'Spinach');
INSERT INTO contains VALUES ('Side Salad', 'Lettuce');
INSERT INTO contains VALUES ('Side Salad', 'Chicken');
INSERT INTO contains VALUES ('Side Salad', 'Spinach');
INSERT INTO contains VALUES ('Crispy Chicken Sandwich', 'Chicken'); -- Extra ingredients listed from here down
INSERT INTO contains VALUES ('Crispy Chicken Sandwich', 'Hamburger Bun');
INSERT INTO contains VALUES ('Crispy Chicken Sandwich', 'Tomato');
INSERT INTO contains VALUES ('Crispy Chicken Sandwich', 'Red Onions');
INSERT INTO contains VALUES ('Crispy Chicken Sandwich', 'Lettuce');
INSERT INTO contains VALUES ('Pancakes', 'Pancake Mix');
INSERT INTO contains VALUES ('Crispy Chicken Sandwich', 'Propellant');
INSERT INTO contains VALUES ('Grilled Chicken Wrap', 'Tortilla');
INSERT INTO contains VALUES ('Grilled Chicken Wrap', 'Egg');
INSERT INTO contains VALUES ('Grilled Chicken Wrap', 'Chicken');
INSERT INTO contains VALUES ('Grilled Chicken Wrap', 'Lettuce');
INSERT INTO contains VALUES ('Grilled Chicken Wrap', 'Cheese');
INSERT INTO contains VALUES ('Grilled Chicken Bacon Ranch Wrap', 'Chicken');
INSERT INTO contains VALUES ('Grilled Chicken Bacon Ranch Wrap', 'Tortilla');
INSERT INTO contains VALUES ('Grilled Chicken Bacon Ranch Wrap', 'Bacon');
INSERT INTO contains VALUES ('Grilled Chicken Bacon Ranch Wrap', 'Ranch');
INSERT INTO contains VALUES ('Meatball Sub', 'Beef');
INSERT INTO contains VALUES ('Meatball Sub', 'Wheatberry Bread');
INSERT INTO contains VALUES ('Meatball Sub', 'Cheese');
INSERT INTO contains VALUES ('Philly Cheese Steak', 'Beef');
INSERT INTO contains VALUES ('Philly Cheese Steak', 'Cheese');
INSERT INTO contains VALUES ('Philly Cheese Steak', 'Red Onions');
INSERT INTO contains VALUES ('Philly Cheese Steak', 'Wheatberry Bread');
INSERT INTO contains VALUES ('Grilled Cheese', 'Bread');
INSERT INTO contains VALUES ('Grilled Cheese', 'Cheese');
INSERT INTO contains VALUES ('Grilled Cheese', 'Sourdough Bread');
INSERT INTO contains VALUES ('Chicken Philly', 'Chicken');
INSERT INTO contains VALUES ('Chicken Philly', 'Cheese');
INSERT INTO contains VALUES ('Chicken Philly', 'Wheatberry Bread');
INSERT INTO contains VALUES ('Chicken Philly', 'Red Onions');
INSERT INTO contains VALUES ('Shawarma', 'Chicken');
INSERT INTO contains VALUES ('Shawarma', 'Pickle');
INSERT INTO contains VALUES ('Shawarma', 'Wrap');
INSERT INTO contains VALUES ('Black Forest Ham & Swiss on a Gluten Free Bun', 'Cheese');
INSERT INTO contains VALUES ('Black Forest Ham & Swiss on a Gluten Free Bun', 'Ham');
INSERT INTO contains VALUES ('Cappuccino', 'Milk');   
INSERT INTO contains VALUES ('Chicken Bacon Club', 'Bacon');   
INSERT INTO contains VALUES ('Chicken Bacon Club', 'Chicken');   
INSERT INTO contains VALUES ('Cookie', 'Egg');   
INSERT INTO contains VALUES ('Cookie', 'Milk');
INSERT INTO contains VALUES ('Donut', 'Egg');
INSERT INTO contains VALUES ('PB&J', 'Peanuts');


INSERT INTO contains VALUES ('Plain Bagel', 'Butter'); -- This and down are new items
INSERT INTO contains VALUES ('Plain Bagel', 'Bagel');
INSERT INTO contains VALUES ('Everything Bagel', 'Butter');
INSERT INTO contains VALUES ('Everything Bagel', 'Bagel');
INSERT INTO contains VALUES ('Everything Bagel', 'Sesame Seeds');
INSERT INTO contains VALUES ('Six Cheese Bagel', 'Butter');
INSERT INTO contains VALUES ('Six Cheese Bagel', 'Bagel');
INSERT INTO contains VALUES ('Six Cheese Bagel', 'Cheese');
INSERT INTO contains VALUES ('Six Cheese Bagel', 'Cheddar Cheese');
INSERT INTO contains VALUES ('Poke Nigiri', 'Salmon');
INSERT INTO contains VALUES ('Poke Nigiri', 'Tuna');
INSERT INTO contains VALUES ('Tiger Roll', 'Shrimp');
INSERT INTO contains VALUES ('Tiger Roll', 'Avocado');
INSERT INTO contains VALUES ('Tiger Roll', 'Rice');
INSERT INTO contains VALUES ('Sushi', 'Rice');
INSERT INTO contains VALUES ('Sushi', 'Salmon');
INSERT INTO contains VALUES ('Sushi', 'Avocado');
INSERT INTO contains VALUES ('Sushi', 'Soy Sauce');


