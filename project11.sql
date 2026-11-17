-- create a table for stock_name including the company's name,
-- public (1) or provate (0) , and based in USA (1) or not (0)
CREATE TABLE stock_name (
    name VARCHAR(50),
    public INTEGER,
    USA INTEGER
);

-- create a table for message if the comany is public or private 
-- and if the company is in the USA or not
CREATE TABLE stock_pub_con (
    Message VARCHAR(100)
);

-- create a table for inventory to add the company names 
-- and the default 0 for their availability in our portfolio
INSERT INTO inventory (item_name, availability) VALUES 
('Tesla', 0),
('OpenAI', 0),
('VW', 0),
('Mistral', 0),
('Total', 0);

-- create a trigger to display a message for pubic/private and USA/ not USA 
-- after inserting data on the table stock_name
CREATE TRIGGER trigger_stock 
AFTER INSERT ON stock_name
FOR EACH ROW 
BEGIN
    INSERT INTO stock_pub_con (Message)
    VALUES (
        CASE 
            WHEN NEW.public = 1 AND NEW.USA = 1 THEN NEW.name || ' is public and American'
            WHEN NEW.public = 0 AND NEW.USA = 1 THEN NEW.name || ' is private and American'
            WHEN NEW.public = 1 AND NEW.USA = 0 THEN NEW.name || ' is public and non-American'
            WHEN NEW.public = 0 AND NEW.USA = 0 THEN NEW.name || ' is private and non-American'
            ELSE COALESCE(NEW.name, 'Unknown') || ' is unknown'
        END
    );
END;

-- create trigger to update availabity when the company is added to the portfolio
CREATE TRIGGER trigger_update_inventory
AFTER INSERT ON stock_name
FOR EACH ROW
BEGIN
    UPDATE inventory 
    SET availability = 1 
    WHERE item_name = NEW.name;
END;

-- inserting the data into stock_name table
INSERT INTO stock_name VALUES ('Tesla', 1, 1);
INSERT INTO stock_name VALUES ('OpenAI', 0, 1);
INSERT INTO stock_name VALUES ('VW', 1, 0);
INSERT INTO stock_name VALUES ('Mistral', 0, 0);
INSERT INTO stock_name VALUES ('Total', 1, 0);
 
-- check the program
SELECT * FROM stock_pub_con;
SELECT * FROM inventory;






