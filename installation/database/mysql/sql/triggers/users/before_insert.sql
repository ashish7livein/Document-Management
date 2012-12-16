create trigger `users_before_insert` BEFORE INSERT ON `users` 
for each row begin 
	set new.`created` = CURRENT_TIMESTAMP; 
	set new.`changed` = CURRENT_TIMESTAMP; 
end 
