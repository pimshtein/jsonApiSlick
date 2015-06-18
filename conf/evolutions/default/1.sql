# Users and category schema

# --- !Ups

CREATE TABLE user (
  id BIGINT NOT NULL,
  category_id BIGINT DEFAULT NULL,
  name VARCHAR(255) NOT NULL,
  patronymic VARCHAR(255) DEFAULT NULL,
  surname VARCHAR(255) DEFAULT NULL,
  address text DEFAULT NULL,
  dob DATE DEFAULT NULL,
  sex TINYINT DEFAULT NULL,
  fill decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE category (
  id BIGINT NOT NULL,
  title VARCHAR(255) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TRIGGER setFillOnInsert BEFORE INSERT ON user
FOR EACH ROW
  BEGIN
    DECLARE countNotNull INT DEFAULT 0;;
IF NEW.name IS NOT NULL
THEN
SET countNotNull = countNotNull + 1;;
END IF;;
IF NEW.patronymic IS NOT NULL
THEN
SET countNotNull = countNotNull + 1;;
END IF;;
IF NEW.surname IS NOT NULL
THEN
SET countNotNull = countNotNull + 1;;
END IF;;
IF NEW.address IS NOT NULL
THEN
SET countNotNull = countNotNull + 1;;
END IF;;
IF NEW.dob IS NOT NULL
THEN
SET countNotNull = countNotNull + 1;;
END IF;;
IF NEW.sex IS NOT NULL
THEN
SET countNotNull = countNotNull + 1;;
END IF;;
SET NEW.fill = CAST((countNotNull * 100 / 6) AS DECIMAL(5,2));;
END;

CREATE TRIGGER setFillOnUpdate BEFORE UPDATE ON user
FOR EACH ROW
  BEGIN
    DECLARE countNotNull INT DEFAULT 0;;
IF NEW.name IS NOT NULL
THEN
SET countNotNull = countNotNull + 1;;
END IF;;
IF NEW.patronymic IS NOT NULL
THEN
SET countNotNull = countNotNull + 1;;
END IF;;
IF NEW.surname IS NOT NULL
THEN
SET countNotNull = countNotNull + 1;;
END IF;;
IF NEW.address IS NOT NULL
THEN
SET countNotNull = countNotNull + 1;;
END IF;;
IF NEW.dob IS NOT NULL
THEN
SET countNotNull = countNotNull + 1;;
END IF;;
IF NEW.sex IS NOT NULL
THEN
SET countNotNull = countNotNull + 1;;
END IF;;
SET NEW.fill = CAST((countNotNull * 100 / 6) AS DECIMAL(5,2));;
END;

ALTER TABLE user
ADD PRIMARY KEY (id);

ALTER TABLE category
ADD PRIMARY KEY (id);

ALTER TABLE user
ADD CONSTRAINT `fk-user-category_id-category-id` FOREIGN KEY (category_id) REFERENCES category (id) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE user
MODIFY id BIGINT NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

ALTER TABLE category
MODIFY id BIGINT NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

# --- !Downs

ALTER TABLE user DROP PRIMARY KEY;
ALTER TABLE user DROP FOREIGN KEY `fk-user-category_id-category-id`;
DROP TRIGGER insertFill;
DROP TRIGGER updateFill;
DROP TABLE user;
ALTER TABLE category DROP PRIMARY KEY;
DROP TABLE category;

