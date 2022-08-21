ALTER SESSION SET current_schema = sa_customers;

-- Creating temp tables
CREATE TABLE temp_first_names
(
    first_name VARCHAR2(30 CHAR)
);

CREATE TABLE temp_last_names
(
    last_name VARCHAR2(30 CHAR)
);

-- Inserting fist and last names into temp tables
-- FIRST NAMES
INSERT INTO temp_first_names VALUES('James');
INSERT INTO temp_first_names VALUES('Robert');
INSERT INTO temp_first_names VALUES('John');
INSERT INTO temp_first_names VALUES('Michael');
INSERT INTO temp_first_names VALUES('David');
INSERT INTO temp_first_names VALUES('William');
INSERT INTO temp_first_names VALUES('Richard');
INSERT INTO temp_first_names VALUES('Joseph');
INSERT INTO temp_first_names VALUES('Thomas');
INSERT INTO temp_first_names VALUES('Charles');
INSERT INTO temp_first_names VALUES('Christopher');
INSERT INTO temp_first_names VALUES('Daniel');
INSERT INTO temp_first_names VALUES('Matthew');
INSERT INTO temp_first_names VALUES('Anthony');
INSERT INTO temp_first_names VALUES('Mark');
INSERT INTO temp_first_names VALUES('Donald');
INSERT INTO temp_first_names VALUES('Steven');
INSERT INTO temp_first_names VALUES('Paul');
INSERT INTO temp_first_names VALUES('Andrew');
INSERT INTO temp_first_names VALUES('Joshua');
INSERT INTO temp_first_names VALUES('Kenneth');
INSERT INTO temp_first_names VALUES('Kevin');
INSERT INTO temp_first_names VALUES('Brian');
INSERT INTO temp_first_names VALUES('George');
INSERT INTO temp_first_names VALUES('Timothy');
INSERT INTO temp_first_names VALUES('Ronald');
INSERT INTO temp_first_names VALUES('Edward');
INSERT INTO temp_first_names VALUES('Jason');
INSERT INTO temp_first_names VALUES('Jeffrey');
INSERT INTO temp_first_names VALUES('Ryan');
INSERT INTO temp_first_names VALUES('Jacob');
INSERT INTO temp_first_names VALUES('Gary');
INSERT INTO temp_first_names VALUES('Nicho');
INSERT INTO temp_first_names VALUES('Eric');
INSERT INTO temp_first_names VALUES('Jonat');
INSERT INTO temp_first_names VALUES('Stephen');
INSERT INTO temp_first_names VALUES('Larry');
INSERT INTO temp_first_names VALUES('Justin');
INSERT INTO temp_first_names VALUES('Scott');
INSERT INTO temp_first_names VALUES('Brandon');
INSERT INTO temp_first_names VALUES('Benja');
INSERT INTO temp_first_names VALUES('Samuel');
INSERT INTO temp_first_names VALUES('Gregory');
INSERT INTO temp_first_names VALUES('Alexan');
INSERT INTO temp_first_names VALUES('Frank');
INSERT INTO temp_first_names VALUES('Patrick');
INSERT INTO temp_first_names VALUES('Raymond');
INSERT INTO temp_first_names VALUES('Jack');
INSERT INTO temp_first_names VALUES('Dennis');
INSERT INTO temp_first_names VALUES('Jerry');
INSERT INTO temp_first_names VALUES('Tyler');
INSERT INTO temp_first_names VALUES('Aaron');
INSERT INTO temp_first_names VALUES('Jose');
INSERT INTO temp_first_names VALUES('Adam');
INSERT INTO temp_first_names VALUES('Nathan');
INSERT INTO temp_first_names VALUES('Henry');
INSERT INTO temp_first_names VALUES('Douglas');
INSERT INTO temp_first_names VALUES('Zachary');
INSERT INTO temp_first_names VALUES('Peter');
INSERT INTO temp_first_names VALUES('Kyle');
INSERT INTO temp_first_names VALUES('Ethan');
INSERT INTO temp_first_names VALUES('Walter');
INSERT INTO temp_first_names VALUES('Noah');
INSERT INTO temp_first_names VALUES('Jeremy');
INSERT INTO temp_first_names VALUES('Christ');
INSERT INTO temp_first_names VALUES('Keith');
INSERT INTO temp_first_names VALUES('Roger');
INSERT INTO temp_first_names VALUES('Terry');
INSERT INTO temp_first_names VALUES('Gerald');
INSERT INTO temp_first_names VALUES('Harold');
INSERT INTO temp_first_names VALUES('Sean');
INSERT INTO temp_first_names VALUES('Austin');
INSERT INTO temp_first_names VALUES('Carl');
INSERT INTO temp_first_names VALUES('Arthur');
INSERT INTO temp_first_names VALUES('Lawres');
INSERT INTO temp_first_names VALUES('Dylan');
INSERT INTO temp_first_names VALUES('Jesse');
INSERT INTO temp_first_names VALUES('Jordan');
INSERT INTO temp_first_names VALUES('Bryan');
INSERT INTO temp_first_names VALUES('Billy');
INSERT INTO temp_first_names VALUES('Joe');
INSERT INTO temp_first_names VALUES('Bruce');
INSERT INTO temp_first_names VALUES('Gabriel');
INSERT INTO temp_first_names VALUES('Logan');
INSERT INTO temp_first_names VALUES('Albert');
INSERT INTO temp_first_names VALUES('Willie');
INSERT INTO temp_first_names VALUES('Alan');
INSERT INTO temp_first_names VALUES('Juan');
INSERT INTO temp_first_names VALUES('Wayne');
INSERT INTO temp_first_names VALUES('Elijah');
INSERT INTO temp_first_names VALUES('Randy');
INSERT INTO temp_first_names VALUES('Roy');
INSERT INTO temp_first_names VALUES('Vincent');
INSERT INTO temp_first_names VALUES('Ralph');
INSERT INTO temp_first_names VALUES('Eugene');
INSERT INTO temp_first_names VALUES('Russell');
INSERT INTO temp_first_names VALUES('Bobby');
INSERT INTO temp_first_names VALUES('Mason');
INSERT INTO temp_first_names VALUES('Philip');
INSERT INTO temp_first_names VALUES('Louis');
INSERT INTO temp_first_names VALUES('Mary');
INSERT INTO temp_first_names VALUES('Patricia');
INSERT INTO temp_first_names VALUES('Jennifer');
INSERT INTO temp_first_names VALUES('Linda');
INSERT INTO temp_first_names VALUES('Elizabeth');
INSERT INTO temp_first_names VALUES('Barbara');
INSERT INTO temp_first_names VALUES('Susan');
INSERT INTO temp_first_names VALUES('Jessica');
INSERT INTO temp_first_names VALUES('Sarah');
INSERT INTO temp_first_names VALUES('Karen');
INSERT INTO temp_first_names VALUES('Lisa');
INSERT INTO temp_first_names VALUES('Nancy');
INSERT INTO temp_first_names VALUES('Betty');
INSERT INTO temp_first_names VALUES('Margaret');
INSERT INTO temp_first_names VALUES('Sandra');
INSERT INTO temp_first_names VALUES('Ashley');
INSERT INTO temp_first_names VALUES('Kimberly');
INSERT INTO temp_first_names VALUES('Emily');
INSERT INTO temp_first_names VALUES('Donna');
INSERT INTO temp_first_names VALUES('Michelle');
INSERT INTO temp_first_names VALUES('Carol');
INSERT INTO temp_first_names VALUES('Amanda');
INSERT INTO temp_first_names VALUES('Dorothy');
INSERT INTO temp_first_names VALUES('Melissa');
INSERT INTO temp_first_names VALUES('Deborah');
INSERT INTO temp_first_names VALUES('Stephanie');
INSERT INTO temp_first_names VALUES('Rebecca');
INSERT INTO temp_first_names VALUES('Sharon');

-- LAST NAMES
INSERT INTO temp_last_names VALUES('Smith');
INSERT INTO temp_last_names VALUES('Johnson');
INSERT INTO temp_last_names VALUES('Williams');
INSERT INTO temp_last_names VALUES('Brown');
INSERT INTO temp_last_names VALUES('Jones');
INSERT INTO temp_last_names VALUES('Garcia');
INSERT INTO temp_last_names VALUES('Miller');
INSERT INTO temp_last_names VALUES('Davis');
INSERT INTO temp_last_names VALUES('Rodriguez');
INSERT INTO temp_last_names VALUES('Martinez');
INSERT INTO temp_last_names VALUES('Hernandez');
INSERT INTO temp_last_names VALUES('Lopez');
INSERT INTO temp_last_names VALUES('Gonzalez');
INSERT INTO temp_last_names VALUES('Wilson');
INSERT INTO temp_last_names VALUES('Anderson');
INSERT INTO temp_last_names VALUES('Thomas');
INSERT INTO temp_last_names VALUES('Taylor');
INSERT INTO temp_last_names VALUES('Moore');
INSERT INTO temp_last_names VALUES('Jackson');
INSERT INTO temp_last_names VALUES('Martin');
INSERT INTO temp_last_names VALUES('Lee');
INSERT INTO temp_last_names VALUES('Perez');
INSERT INTO temp_last_names VALUES('Thompson');
INSERT INTO temp_last_names VALUES('White');
INSERT INTO temp_last_names VALUES('Harris');
INSERT INTO temp_last_names VALUES('Sanchez');
INSERT INTO temp_last_names VALUES('Clark');
INSERT INTO temp_last_names VALUES('Ramirez');
INSERT INTO temp_last_names VALUES('Lewis');
INSERT INTO temp_last_names VALUES('Robinson');
INSERT INTO temp_last_names VALUES('Walker');
INSERT INTO temp_last_names VALUES('Young');
INSERT INTO temp_last_names VALUES('Allen');
INSERT INTO temp_last_names VALUES('King');
INSERT INTO temp_last_names VALUES('Wright');
INSERT INTO temp_last_names VALUES('Scott');
INSERT INTO temp_last_names VALUES('Torres');
INSERT INTO temp_last_names VALUES('Nguyen');
INSERT INTO temp_last_names VALUES('Hill');
INSERT INTO temp_last_names VALUES('Flores');
INSERT INTO temp_last_names VALUES('Green');
INSERT INTO temp_last_names VALUES('Adams');
INSERT INTO temp_last_names VALUES('Nelson');
INSERT INTO temp_last_names VALUES('Baker');
INSERT INTO temp_last_names VALUES('Hall');
INSERT INTO temp_last_names VALUES('Rivera');
INSERT INTO temp_last_names VALUES('Campbell');
INSERT INTO temp_last_names VALUES('Mitchell');
INSERT INTO temp_last_names VALUES('Carter');
INSERT INTO temp_last_names VALUES('Roberts1');

ALTER SESSION SET current_schema = sa_customers;

-- Generating customers
INSERT INTO sa_customer_data
    SELECT first_name,
           last_name,
           '+37529' || to_char(7911280 + rownum) AS phone,
           CASE
             WHEN TRUNC(dbms_random.value(1,6)) BETWEEN 1 AND 3
                THEN 'Belarus'
             WHEN TRUNC(dbms_random.value(1,6)) = 4
                THEN 'Ukraine'
             WHEN TRUNC(dbms_random.value(1,6)) = 5
                THEN 'Kazakhstan'
             ELSE 'Russian Federation'
           END AS country,
           first_name || last_name || '@gmail.com' AS email,
           to_date('01.01.1980', 'DD.MM.YYYY') + dbms_random.value(1, 8000) AS birthday
    FROM temp_first_names, temp_last_names;
    
-- Droping temp tables
DROP TABLE temp_first_names;
DROP TABLE temp_last_names;

COMMIT;