CREATE ROLE vk_role;

CREATE ROLE vk_user WITH LOGIN PASSWORD 'secret';

GRANT vk_role TO vk_user;

CREATE DATABASE vk OWNER vk_role;

CREATE DATABASE vk_staging OWNER vk_role;
