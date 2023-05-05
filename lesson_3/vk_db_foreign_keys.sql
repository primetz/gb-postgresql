-- Поле main_photo_id в таблице users ссылается на поле id в таблице photo.
ALTER TABLE users
    ADD CONSTRAINT users_photo_id_fk
        FOREIGN KEY (main_photo_id) REFERENCES photo (id);

-- Поле owner_id в таблице photo ссылается на поле id в таблице users.
ALTER TABLE photo
    ADD CONSTRAINT photo_users_id_fk
        FOREIGN KEY (owner_id) REFERENCES users (id);

-- Поле from_user_id в таблице messages ссылается на поле id в таблице users.
ALTER TABLE messages
    ADD CONSTRAINT messages_from_users_id_fk
        FOREIGN KEY (from_user_id) REFERENCES users (id);

-- Поле to_user_id в таблице messages ссылается на поле id в таблице users.
ALTER TABLE messages
    ADD CONSTRAINT messages_to_users_id_fk
        FOREIGN KEY (to_user_id) REFERENCES users (id);

-- Пользователь не может писать самому себе.
ALTER TABLE messages
    ADD CONSTRAINT messages_to_self_check
        CHECK ( from_user_id != to_user_id );

-- Поле requested_by_user_id в таблице friendship ссылается на поле id в таблице users.
ALTER TABLE friendship
    ADD CONSTRAINT friendship_from_users_id_fk
        FOREIGN KEY (requested_by_user_id) REFERENCES users (id);

-- Поле requested_to_user_id в таблице friendship ссылается на поле id в таблице users.
ALTER TABLE friendship
    ADD CONSTRAINT friendship_to_users_id_fk
        FOREIGN KEY (requested_to_user_id) REFERENCES users (id);

-- Пользователь не может отправить запрос на дружбу самому себе.
ALTER TABLE friendship
    ADD CONSTRAINT friendship_to_self_check
        CHECK ( requested_by_user_id != requested_to_user_id );

-- Поле creator_id в таблице communities ссылается на поле id в таблице users.
ALTER TABLE communities
    ADD CONSTRAINT communities_users_id_fk
        FOREIGN KEY (creator_id) REFERENCES users (id);

-- Поле community_id в таблице communities_users ссылается на поле id в таблице communities.
ALTER TABLE communities_users
    ADD CONSTRAINT communities_users_communities_id_fk
        FOREIGN KEY (community_id) REFERENCES communities (id);

-- Поле user_id в таблице communities_users ссылается на поле id в таблице users.
ALTER TABLE communities_users
    ADD CONSTRAINT communities_users_id_fk
        FOREIGN KEY (user_id) REFERENCES users (id);

-- Поле owner_id в таблице video ссылается на поле id в таблице users.
ALTER TABLE video
    ADD CONSTRAINT video_users_id_fk
        FOREIGN KEY (owner_id) REFERENCES users (id);

-- Поле subscriber_id в таблице subscriptions ссылается на поле id в таблице users.
ALTER TABLE subscriptions
    ADD CONSTRAINT subscriptions_subscriber_id_fk
        FOREIGN KEY (subscriber_id) REFERENCES users (id);

ALTER TABLE subscriptions
    ADD CONSTRAINT subscriptions_subscribed_to_id_fk
        FOREIGN KEY (subscribed_to_id) REFERENCES users (id);
