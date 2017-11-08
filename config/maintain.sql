DELETE FROM ttrss_user_entries USING ttrss_entries, ttrss_user_entries WHERE id = ref_id AND date_entered < DATE_SUB(NOW(), INTERVAL 14 DAY) AND marked = FALSE and unread =0;

DELETE FROM ttrss_entries WHERE (SELECT COUNT(int_id) FROM ttrss_user_entries WHERE ref_id = id) = 0;
