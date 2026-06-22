DROP TABLE project.gamesale_raw;

CREATE TABLE project.gamesale_raw(
rank INT,
name VARCHAR(500),
platform VARCHAR(500),
year numeric(5,1),
genre VARCHAR(500),
publisher VARCHAR(500),
jpsale numeric(4,2),
nasale numeric(4,2),
eusale numeric(4,2),
othersale numeric(4,2),
globalsale numeric(4,2)
);

CREATE TABLE project.products(
    rank INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50),
    platform VARCHAR(50),
    genre VARCHAR(50),
    publisher VARCHAR(50)
);

CREATE TABLE project.sales(
    year numeric(5,1),
    jpsale numeric(4,2)
);