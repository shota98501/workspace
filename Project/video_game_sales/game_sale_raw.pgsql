CREATE TABLE project.gamesale_raw(
rank INT,
name VARCHAR(50),
platform VARCHAR(50),
year numeric(5,1),
genre VARCHAR(50),
publisher VARCHAR(50),
jpsale numeric(4,2)
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