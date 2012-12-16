create trigger `folders_before_update` BEFORE UPDATE ON `folders` 
for each row begin 
		set new.`created` = old.`created`; 
		set new.`changed` = CURRENT_TIMESTAMP; 
end 
       