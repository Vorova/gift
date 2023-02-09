CREATE SCHEMA IF NOT EXISTS gift_repository;
CREATE SCHEMA IF NOT EXISTS order_repository;

CREATE TABLE IF NOT EXISTS gift_repository.category
(
    id          SMALLSERIAL PRIMARY KEY,
    title       VARCHAR(64),
    description VARCHAR(128)
);

CREATE TABLE IF NOT EXISTS gift_repository.gift
(
    id                SERIAL PRIMARY KEY,
    title             VARCHAR(64)                 NOT NULL,
    short_description VARCHAR(128)                NOT NULL,
    description       VARCHAR(256)                NOT NULL,
    date_creation     TIMESTAMP     DEFAULT now() NOT NULL,
    pre_order         BOOLEAN       DEFAULT FALSE,
    status            VARCHAR(6)    DEFAULT 'new',
    count             SMALLINT      DEFAULT 0,
    gift_cost         NUMERIC(7, 2) DEFAULT 0.0,
    sale              SMALLINT      DEFAULT 0,
    category_id       SMALLINT REFERENCES gift_repository.category
);

CREATE TABLE IF NOT EXISTS gift_repository.image
(
    id         BIGSERIAL PRIMARY KEY,
    image_path VARCHAR(64) NOT NULL,
    is_main    BOOLEAN DEFAULT false,
    gift_id    BIGINT REFERENCES gift_repository.gift
);

CREATE TABLE IF NOT EXISTS gift_repository.characteristic
(
    id       BIGSERIAL PRIMARY KEY,
    property VARCHAR(64)  NOT NULL,
    value    VARCHAR(128) NOT NULL,
    gift_id  BIGINT REFERENCES gift_repository.gift
);

CREATE TABLE IF NOT EXISTS order_repository.order_no
(
    id         BIGSERIAL PRIMARY KEY,
    contact_no VARCHAR(32),
    address    VARCHAR(128),
    sum        NUMERIC(7, 2) DEFAULT 0.0 CHECK ( sum > 0.01 ),
    status     VARCHAR(8)    DEFAULT 'new'
);

CREATE TABLE IF NOT EXISTS order_repository.order_item
(
    id          BIGSERIAL PRIMARY KEY,
    cost        NUMERIC(7, 2)              NOT NULL CHECK ( cost > 0.01 ),
    order_no_id BIGINT REFERENCES order_repository.order_no NOT NULL,
    gift_id     BIGINT REFERENCES gift_repository.gift
);