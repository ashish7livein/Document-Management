
    create table `users`(
       `user_id` INT UNSIGNED not null AUTO_INCREMENT,
       `username` VARCHAR(45) not null unique,
       `password` CHAR(44) not null,
       `last_name` VARCHAR(35),
       `first_name` VARCHAR(35),
       `occupation` VARCHAR(35),
       `email` VARCHAR(255),
       `created` TIMESTAMP default 0,
       `changed` TIMESTAMP,
        primary key (`user_id`)
    );

  