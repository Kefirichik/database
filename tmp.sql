CREATE TABLE Books(
    isbn_id VARCHAR(255) PRIMARY KEY,
    publish_year INT NOT NULL,
    book_name VARCHAR(255) NOT NULL
);

CREATE TABLE Authors(
    author_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL
);

CREATE TABLE Readers(
    reader_id SERIAL PRIMARY KEY,
    phone_number VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255) NOT NULL
);

CREATE TABLE Loan(
    vidacha_id SERIAL PRIMARY KEY,	
    isbn_id VARCHAR(255),
    reader_id INT,
    borrow_date DATE NOT NULL,
    plan_return_date DATE NOT NULL,
    actual_return_date DATE,

    FOREIGN KEY (isbn_id) REFERENCES Books(isbn_id),
    FOREIGN KEY (reader_id) REFERENCES Readers(reader_id)
);

CREATE TABLE Authorship(
    isbn_id VARCHAR(255),
    author_id INT,

    PRIMARY KEY (isbn_id, author_id),
    FOREIGN KEY (isbn_id) REFERENCES Books(isbn_id),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

INSERT INTO Readers (full_name, phone_number) VALUES
('Анна Петрова', '+7-900-111-22-33'),
('Иван Соколов', '+7-900-222-33-44'),
('Мария Ким', '+7-900-333-44-55'),
('Олег Васильев', '+7-900-444-55-66');

INSERT INTO Books (isbn_id, book_name, publish_year) VALUES
('978-5-17-118366-8', 'Мастер и Маргарита', 1967),
('978-5-389-06256-6', 'Преступление и наказание', 1866),
('978-5-04-116716-3', 'Война и мир', 1869),
('978-5-699-12014-7', 'Золотой теленок', 1931),
('978-5-389-03713-7', 'Пикник на обочине', 1972);

INSERT INTO Authors (full_name) VALUES
('Михаил Булгаков'),
('Федор Достоевский'),
('Лев Толстой'),
('Илья Ильф'),
('Евгений Петров'),
('Аркадий Стругацкий'),
('Борис Стругацкий');

INSERT INTO authorship (isbn_id, author_id) VALUES
('978-5-17-118366-8', (SELECT author_id FROM authors WHERE full_name = 'Михаил Булгаков')),
('978-5-389-06256-6', (SELECT author_id FROM authors WHERE full_name = 'Федор Достоевский')),
('978-5-04-116716-3', (SELECT author_id FROM authors WHERE full_name = 'Лев Толстой')),
('978-5-699-12014-7', (SELECT author_id FROM authors WHERE full_name = 'Илья Ильф')),
('978-5-699-12014-7', (SELECT author_id FROM authors WHERE full_name = 'Евгений Петров')),
('978-5-389-03713-7', (SELECT author_id FROM authors WHERE full_name = 'Аркадий Стругацкий')),
('978-5-389-03713-7', (SELECT author_id FROM authors WHERE full_name = 'Борис Стругацкий'));

INSERT INTO Loan (reader_id, isbn_id, borrow_date, plan_return_date, actual_return_date) VALUES
((SELECT reader_id FROM readers WHERE full_name = 'Анна Петрова'), '978-5-17-118366-8', '2026-09-01', '2026-09-15', '2026-09-10'),
((SELECT reader_id FROM readers WHERE full_name = 'Иван Соколов'), '978-5-389-06256-6', '2026-09-03', '2026-09-17', NULL),
((SELECT reader_id FROM readers WHERE full_name = 'Мария Ким'), '978-5-04-116716-3', '2026-09-05', '2026-09-19', '2026-09-18'),
((SELECT reader_id FROM readers WHERE full_name = 'Олег Васильев'), '978-5-699-12014-7', '2026-09-07', '2026-09-21', NULL),
((SELECT reader_id FROM readers WHERE full_name = 'Анна Петрова'), '978-5-389-03713-7', '2026-09-09', '2026-09-23', NULL),
((SELECT reader_id FROM readers WHERE full_name = 'Мария Ким'), '978-5-699-12014-7', '2026-08-20', '2026-09-03', '2026-09-01');

UPDATE readers
SET phone_number = '+7-982-596-09-69'
WHERE full_name = 'Мария Ким';

UPDATE loan
SET actual_return_date = '2026-09-17'
WHERE reader_id = (SELECT reader_id FROM readers WHERE full_name = 'Иван Соколов');

INSERT INTO readers (full_name, phone_number) VALUES
('Мтвей Карлов','8-800-535-35-35');
DELETE FROM readers WHERE full_name = 'Мтвей Карлов'

-- DROP TABLE IF EXISTS authors CASCADE;
-- DROP TABLE IF EXISTS authorship CASCADE;
-- DROP TABLE IF EXISTS books CASCADE;
-- DROP TABLE IF EXISTS loan CASCADE;
-- DROP TABLE IF EXISTS readers CASCADE;
