

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS articles;
DROP TABLE IF EXISTS suggestions;

CREATE TABLE products (
    id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    emoji       VARCHAR(16)  NOT NULL DEFAULT '',
    description TEXT         NOT NULL,
    price       DECIMAL(10,2) NOT NULL DEFAULT 0,
    currency    VARCHAR(8)   NOT NULL DEFAULT '₽',
    url         VARCHAR(512) NOT NULL DEFAULT '',
    image       VARCHAR(512) NOT NULL DEFAULT '',
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FULLTEXT KEY ft_products (name, description)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE articles (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    title      VARCHAR(255) NOT NULL,
    content    TEXT         NOT NULL,
    created_at TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FULLTEXT KEY ft_articles (title, content)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE suggestions (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    text       VARCHAR(255) NOT NULL,
    sort_order INT          NOT NULL DEFAULT 0,
    is_active  TINYINT(1)   NOT NULL DEFAULT 1,
    PRIMARY KEY (id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;
