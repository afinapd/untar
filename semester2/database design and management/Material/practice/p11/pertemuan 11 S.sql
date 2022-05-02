--data dictionary
/*
-setiap database oracle berisi data dictionary(kamus data).

-semua objek seperti table, views, users, privilege user, procedures, function
dll sudah terdaftar dalam data dictionary secara otomatis saat objek2 itu dicreate
atau dibuat.

-jika nantinya ada objek yang di alter atau di drop, maka data dictionary akan
diupdate secara otomatis didalam database.

data dictionary ada 3 class table.
2 yang bisa kita select buat melihat info dari dictionary 

- USER_* tables berisi info tentang objek yang kita miliki,
biasanya yang kita create.
con: USER_TABLES, USER_INDEXES.

- ALL_* tables berisi info tentang objek yang privilegenya kita punya untuk 
kita pake.
con: ALL_TABLES, ALL_INDEXES.

class ke-3 yang bisa kita select dari dictionary itu biasanya hanya tersedia
buat DBA(Database Administrator).

- DBA_* table berisi info semua yang ada didalam database, tidak memperdulikan
isinya itu milik siapa.

con: DBA_TABLES, DBA_INDEXES.

*/
--describe semua table yang privileges kita punya.
describe all_tables;
desc all_tables;

-- melihat daftar table dan ownernya
select table_name, owner from all_tables;

--melihat tipe dan nama objek
select object_type, object_name from user_objects;

--menghitung jumlah tipe objek berdasarkan tipe objek
select object_type, count(*)
from user_objects
group by object_type;

--contoh view dictionary
select count(*)
from dict
where table_name like 'USER%';

select count(*)
from dict
where table_name like 'USER%IND%';

--Managing procedures dan function

--handled exception
--procedure contoh 1
create or replace procedure add_department(
p_name varchar2,
p_mgr number,
p_loc number
) is

begin

insert into departments(department_id, department_name, manager_id, location_id)
values(departments_seq.nextval, p_name, p_mgr, p_loc);
dbms_output.put_line('Added dept: ' || p_name);

exception
when others then
dbms_output.put_line('error adding dept: ' || p_name);
end;
/

--main
begin

add_department('Media', 100, 1800);
add_department('Editing', 99, 1800);
add_department('Advertising', 101, 1800);
end;
/

select * from departments;
select * from user_sequences;
rollback;

--exception not handled
--procedure
create or replace procedure add_department_noex(
p_name varchar2,
p_mgr number,
p_loc number
) is

begin

insert into departments(department_id, department_name, manager_id, location_id)
values(departments_seq.nextval, p_name, p_mgr, p_loc);
dbms_output.put_line('Added dept: ' || p_name);

end;
/
--main
begin

add_department_noex('Media', 100, 1800);
add_department_noex('Editing', 99, 1800);
add_department_noex('Advertising', 101, 1800);
end;
/

select * from departments;

delete from departments
where department_id in (730, 750, 760, 780);

/*
removing procedure dan function
caranya:

drop PROCEDURE proc_name;
drop FUNCTION func_name;

*/

drop procedure add_department_noex;


--melihat nama subprogram dalam table user_object

--procedure
select object_name
from user_objects
where object_type = 'PROCEDURE';

--function
select object_name
from user_objects
where object_type = 'FUNCTION';

--melihat source code pada user_source table
--procedure
select text from user_source
where name = 'JR'
order by line;

select text from user_source
where name = 'TAX'
order by line;



