create trigger `documents_before_update` BEFORE UPDATE ON `documents` 
for each row begin 
		set new.`created` = old.`created`; 
		set new.`changed` = CURRENT_TIMESTAMP; 
end 
       