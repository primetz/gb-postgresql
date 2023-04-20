DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    phone VARCHAR(15) UNIQUE,
    main_photo_id INT,
    created_at TIMESTAMP NOT NULL DEFAULT current_timestamp
);

DROP TABLE IF EXISTS messages;
CREATE TABLE IF NOT EXISTS messages (
    id SERIAL PRIMARY KEY,
    from_user_id INT NOT NULL,
    to_user_id INT NOT NULL,
    body TEXT,
    is_important BOOLEAN,
    is_delivered BOOLEAN,
    created_at TIMESTAMP NOT NULL DEFAULT current_timestamp
);

DROP TYPE IF EXISTS friendship_statuses_enum;
CREATE TYPE friendship_statuses_enum AS ENUM ('requested', 'confirmed', 'rejected');

DROP TABLE IF EXISTS friendship;
CREATE TABLE IF NOT EXISTS friendship (
    id SERIAL PRIMARY KEY,
    requested_by_user_id INT NOT NULL,
    requested_to_user_id INT NOT NULL,
    status friendship_statuses_enum NOT NULL DEFAULT 'requested',
    requested_at TIMESTAMP NOT NULL DEFAULT current_timestamp,
    confirmed_at TIMESTAMP
);

DROP TABLE IF EXISTS communities;
CREATE TABLE IF NOT EXISTS communities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(120) UNIQUE,
    creator_id INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT current_timestamp
);

DROP TABLE IF EXISTS communities_users;
CREATE TABLE IF NOT EXISTS communities_users (
    community_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT current_timestamp,
    PRIMARY KEY (community_id, user_id)
);

DROP TABLE IF EXISTS photo;
CREATE TABLE IF NOT EXISTS photo (
    id SERIAL PRIMARY KEY,
    url VARCHAR(250) NOT NULL UNIQUE,
    owner_id INT NOT NULL,
    description VARCHAR(250) NOT NULL,
    uploaded_at TIMESTAMP NOT NULL DEFAULT current_timestamp,
    size INT NOT NULL
);

DROP TABLE IF EXISTS video;
CREATE TABLE IF NOT EXISTS video (
    id SERIAL PRIMARY KEY,
    url VARCHAR(250) NOT NULL UNIQUE,
    owner_id INT NOT NULL,
    description VARCHAR(250) NOT NULL,
    uploaded_at TIMESTAMP NOT NULL DEFAULT current_timestamp,
    size INT NOT NULL
);
