SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS user;
CREATE TABLE user 
(
    id BIGINT AUTO_INCREMENT, 
    email VARCHAR(50),
    username VARCHAR(20),
    gender VARCHAR(6),
    age INT,
    password CHAR(65),
    start_date DATE,
    PRIMARY KEY (id,email,username)
) ENGINE=INNODB;;

SET FOREIGN_KEY_CHECKS=1;


/*
CREATE TABLE user (
    `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARBINARY(32) NOT NULL,
    `created` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
    PRIMARY KEY (user_id),
    UNIQUE KEY (name),
    KEY (created)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

*/
