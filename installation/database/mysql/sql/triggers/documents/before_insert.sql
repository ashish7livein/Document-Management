create trigger `documents_before_insert` BEFORE INSERT ON `documents` 
for each row begin 
	set new.`created` = CURRENT_TIMESTAMP; 
	set new.`changed` = CURRENT_TIMESTAMP; 
end 
