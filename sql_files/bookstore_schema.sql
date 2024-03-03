CREATE TABLE IF NOT EXISTS books (
    isbn VARCHAR(13) PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    publisher VARCHAR(255),
    publication_year INTEGER,
    genre VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INTEGER
);

CREATE TABLE IF NOT EXISTS customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    street_address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INTEGER REFERENCES customers(customer_id),
  order_date TIMESTAMP,
  total_amount DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES orders(order_id),
  book_id VARCHAR(13) REFERENCES books(isbn),
  quantity INTEGER NOT NULL,
  unit_price DECIMAL(10,2),
  total_price DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS authors (
  author_id SERIAL PRIMARY KEY,
  name VARCHAR(255)

);

-- Decided to go with tags instead of genres since genres can be a tag
CREATE TABLE IF NOT EXISTS tags (
  tag_id SERIAL PRIMARY KEY,
  tag_name VARCHAR(255) UNIQUE,
  tag_description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS reviews (
  review_id SERIAL PRIMARY KEY,
  book_id VARCHAR(13) REFERENCES books(isbn),
  customer_id INTEGER REFERENCES customers(customer_id),
  review_text TEXT,
  review_rating INTEGER CHECK (review_rating >= 0 AND review_rating <= 5),
  review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS transactions (
  transaction_id SERIAL PRIMARY KEY,
  order_id INTEGER REFERENCES orders(order_id),
  payment_method VARCHAR(255),
  payment_amount DECIMAL(10,2),
  transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_status VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS addresses (
  address_id SERIAL PRIMARY KEY,
  customer_id INTEGER REFERENCES customers(customer_id),
  street_address VARCHAR(255),
  city VARCHAR(255),
  state_name VARCHAR(255),
  postal_code VARCHAR(255),
  country VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS inventory (
  inventory_id SERIAL PRIMARY KEY,
  book_id VARCHAR(13),
  quantity INTEGER,
  last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Junction table for books and authors
CREATE TABLE IF NOT EXISTS book_authors (
    book_id VARCHAR(13) REFERENCES books(isbn),
    author_id INTEGER REFERENCES authors(author_id),
    PRIMARY KEY (book_id, author_id)
);

--Junction table for books and tags
CREATE TABLE IF NOT EXISTS book_tags (
  book_id VARCHAR(13) REFERENCES books(isbn),
  tag_id INTEGER REFERENCES tags(tag_id),
  PRIMARY KEY (book_id, tag_id)
);