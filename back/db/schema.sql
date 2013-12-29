SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS user;
CREATE TABLE user 
(
    id BIGINT AUTO_INCREMENT, 
    twitter_id INT,
    facebook_id INT,
    image_url VARCHAR(100),
    screen_name VARCHAR(20),
    lang VARCHAR(10),
    created_at DATETIME,
    INDEX (twitter_id),
    PRIMARY KEY (id)
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
