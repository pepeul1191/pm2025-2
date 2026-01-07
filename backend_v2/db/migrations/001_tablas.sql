-- Tabla countries
CREATE TABLE countries (
    id INTEGER PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    male_demonym VARCHAR(40),
    female_demonym VARCHAR(40),
    flag_image VARCHAR(100)
);

-- Tabla users
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    username VARCHAR(30) NOT NULL,
    password VARCHAR(40) NOT NULL,
    first_names VARCHAR(50) NOT NULL,
    last_names VARCHAR(50) NOT NULL,
    email VARCHAR(30) NOT NULL,
    birth_date DATE,
    profile_picture VARCHAR(100),
    sex BOOLEAN,
    reset_key VARCHAR(30),
    country_id INTEGER,
    FOREIGN KEY (country_id) REFERENCES countries(id)
);

-- Tabla devices
CREATE TABLE devices (
    id INTEGER PRIMARY KEY,
    brand VARCHAR(30),
    type VARCHAR(30),
    user_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Tabla publishers
CREATE TABLE publishers (
    id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    logo VARCHAR(100)
);

-- Tabla books
CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    title VARCHAR(60) NOT NULL,
    isbn VARCHAR(30),
    pages INTEGER,
    publication_year INTEGER,
    edition_year INTEGER,
    synopsis TEXT,
    cover_image VARCHAR(100),
    pdf VARCHAR(100),
    publisher_id INTEGER,
    FOREIGN KEY (publisher_id) REFERENCES publishers(id)
);

-- Tabla authors
CREATE TABLE authors (
    id INTEGER PRIMARY KEY,
    full_name VARCHAR(60),
    birth_date DATE,
    image VARCHAR(100)
);

-- Tabla genres
CREATE TABLE genres (
    id INTEGER PRIMARY KEY,
    name VARCHAR(30)
);

-- Tabla reviews
CREATE TABLE reviews (
    id INTEGER PRIMARY KEY,
    rating INTEGER,
    comment TEXT,
    review_date DATETIME,
    user_id INTEGER,
    book_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

-- Tabla intermedia books_authors
CREATE TABLE books_authors (
    id INTEGER PRIMARY KEY,
    book_id INTEGER,
    author_id INTEGER,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (author_id) REFERENCES authors(id)
);

-- Tabla intermedia books_genres
CREATE TABLE books_genres (
    id INTEGER PRIMARY KEY,
    book_id INTEGER,
    genre_id INTEGER,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);