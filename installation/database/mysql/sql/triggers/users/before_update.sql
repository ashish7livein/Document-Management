create trigger `users_before_update` BEFORE UPDATE ON `users` 
for each row begin 
		set new.`created` = old.`created`; 
		set new.`changed` = CURRENT_TIMESTAMP; 
end 
       