create table `folders`(
       `folder_id` INT UNSIGNED not null AUTO_INCREMENT,
       `user_id` INT UNSIGNED not null,
       `foldername` VARCHAR(45) not null,
       `created` TIMESTAMP default 0,
       `changed` TIMESTAMP,
        primary key (`folder_id`)
    );

    
    alter table `folders`  
        add index `folders_user_id`(`user_id`), 
        add constraint `folder_user_id` 
        foreign key (`user_id`) 
        references `users`(`user_id`);
       