create table `documents`(
       `document_id` INT UNSIGNED not null AUTO_INCREMENT,
       `folder_id` INT UNSIGNED not null,
       `document_name` VARCHAR(45) not null,
       `content_type` VARCHAR(25),
       `abstraction` VARCHAR(30),
       `created` TIMESTAMP default 0,
       `changed` TIMESTAMP,
        primary key (`document_id`)
    );

    
    alter table `documents`  
        add index `documents_folder_id`(`folder_id`), 
        add constraint `folder_folder_id` 
        foreign key (`folder_id`) 
        references `folders`(`folder_id`);
       