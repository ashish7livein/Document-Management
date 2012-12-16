create trigger `folders_before_insert` BEFORE INSERT ON `folders` 
for each row begin 
	set new.`created` = CURRENT_TIMESTAMP; 
	set new.`changed` = CURRENT_TIMESTAMP; 
end 
