DROP TYPE IF EXISTS subscriptions_target_enum CASCADE;
CREATE TYPE subscriptions_target_enum AS ENUM ('user', 'community');

DROP TABLE IF EXISTS subscriptions CASCADE;
CREATE TABLE IF NOT EXISTS subscriptions (
    id SERIAL PRIMARY KEY,
    subscriber_id INT NOT NULL,
    subscribed_to_id INT NOT NULL,
    subscription_target subscriptions_target_enum NOT NULL
);
