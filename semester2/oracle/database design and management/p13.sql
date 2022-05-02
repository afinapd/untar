set serveroutput on

/* 
Trigger

Trigger: program yang disimpan, yang secara otomatis dijalankan ketika
beberapa event (peristiwa) terjadi.

*/

--contoh 1

create table log_table(
user_id     varchar(50),
logon_date  date
);

create table emp1 as select * from employees;
/

--trigger
CREATE OR REPLACE TRIGGER log_sal_change_trigg
AFTER UPDATE OF salary ON emp1 
BEGIN
  INSERT INTO log_table (user_id, logon_date)
  VALUES (USER, SYSDATE);
END;
/
select * from log_table;

--anonymous block
update emp1
set salary = 7600
where employee_id = 178;

select salary from emp1 where employee_id = 178;

/*
Database triggers compare to application triggers

- database trigger : dijalankan secara otomatis setiap kali ada event
yang terjadi pada skema atau database

- database trigger: dibuat dan disimpan dalam database sperti  proc, func,
dan pkg

- application triggers: dijalankan setiap kali peristiwa terrentu
terjadi dalam suatu aplikasi. con: saat search di google kita klik
tombol seach

- application trigger: bisa mengarah ke database, tapi mereka ini bukan
bagian dari db.
*/

/*
event pemicu trigger:
- DML pada table
- DML pada view, dengan instead of trigger
- statement, DDL. contoh create dan alter
- sistem event db, seperti saat user masuk ke dalam db atau DBA memetikan db
*/

/*
type of trigger
trigger dapat berupa
1. row-level: trigger aktif 1x untuk setiap baris yang dipengaruhi oleh statement
trigger
2. statement-level: trigger aktif 1x untuk seluruh statement
*/

/*
contoh:
aturan dari perusaahn tidak memperbolehkan jika update job_id karyawan,
maka tidak boleh seperti sebelumnya
con : emp_1 dudlunya IT PROG, lalu nanti saat diupdate ump_1 tidak diperbolehkan
untuk menjadi IT_PROG lagi.
*/

CREATE OR REPLACE TRIGGER chk_sal_trigger
AFTER UPDATE OF job_id ON emp1 
for each row
declare v_job_count integer;
BEGIN
  select count(*) into v_job_count
  from job_history
  where job_id = :OLD.job_id
  and job_id = :NEW.job_id;
  
  if v_job_count > 0 then
  raise_application_error(-20201, 'this employee has already done this job');
  end if;
END;
/

update emp1 set job_id = 'IT_PROG'
where job_id = 'IT_PROG';

select * from emp1 where job_id = 'IT_PROG';

/*
DML trigger: trigger yang aktif saat ada statmen DML(insert, update, atau delete)
DML trigger dibagi menjadi 2 kondisi:
1. saat kapan dijalankan
- before
- after
- instead of the triggering SML statment

2. berapa kali trigger dijalankna
- statment trigger: satu kali untuk seluruh statemnt DML
- row trigger: satu kali setiap baris yang terpengaruh oleh DML
*/

/*
sytax statment trigger DML

CREATE [OR REPLACE] TRIGGER trigger_name
timing
event1 [OR event2 OR event3] ON object_name
trigger_body

ket:
- timing: saat trigger yang aktif ada kaitannya dengan triggering event
contoh: BEFORE, AFTER, INTEAD OF

- event: operasi DML yang menyebabkan trigger untuk aktif
contoh: insert, update [OF column], dan delete
 UPDATE of salary, commition_pct
 
- object_name: table ataua view yang dihubungkan oleh trigger

- trigger_body: tidnakan yang dilakukan oleh trigger didefinisikan dalam
anonymous bloc
*/

/*
penjelasan timing:
- before: trigger body dijalankan sebelum memicu event statement DML
pada table
contoh: sebelum kita melakukan update, trigger sudah diaktifkan dulu

- after: trigger body dijalankan setelah memicu event statement DML
pada table
contoh: trigger aktif setelah kita aftae salary, lalu trigger akan inter data
ke log table

- intead of: digunakan pada view. trigger body dijalankan dari pada memicu
DML event pada view
*/

/*
Statement trigger:
- aktif 1x untuk setiap statement yang memicu trigger saat dijalankan
(walaupuntidak ada baris yang terpengaruh)

- defaul dari trigger DML

- aktif 1x walaupun tidak ada baris yang terpengaruh

- berguna jika trigger body tidak perlu memproses nilai column dari baris
yang terpengaruh
*/

/*
misalkan trigger update pada table employees untuk mencatat user yang melakukan
update dan kapa. walaupun tidak ada table yang terupdate akan tetap tercatat ke
table log
*/

create table log_table(
user_id     varchar(50),
logon_date  date
);

create table emp1 as select * from employees;
/

--trigger
CREATE OR REPLACE TRIGGER log_sal_change_trigg
AFTER UPDATE OF salary ON emp1 
BEGIN
  INSERT INTO log_table (user_id, logon_date)
  VALUES (USER, SYSDATE);
END;
/
select * from log_table;

drop table log_table;

--anonymous block
update emp1
set salary = 7600
where employee_id = 199;

select salary from emp1 where employee_id = 199;

/*
- membuat trigger untuk memeriksa apakah user bisa melakukan insert table
atau tidak
- ketentuan: tidak boleh insert dihari selasa dan rabu
*/

select to_char(sysdate, 'dy') from dual;

create or replace trigger secure_emp
before insert on emp1
begin
  if to_char(sysdate, 'dy') in ('tue', 'wed') then
  raise_application_error(-20500, 'you may insert into employees table only monday
  thursday, or friday');
  end if;
end;
/
desc emp1;

insert into emp1(
employee_id,
last_name,
first_name,
email,
hire_date,
job_id,
salary,
department_id
) values(
300,
'Smith',
'Rob',
'RSMITH',
sysdate,
'IT_PROG',
4500,
60);

/
delete from emp1 where employee_id = 300;

/
create table dept1 as select * from departments;


create table log_dept_tb(
which_user  varchar(100),
when_done   date
);

create or replace trigger log_dept_changes
  after insert or update or delete on dept1
begin
insert into log_dept_tb(which_user, when_done)
values(user, sysdate);
--commit;
end;
/
--commit, rollback, dan savepoint tidak diperblehkan di trigger body
insert into dept1 values(55, 'games', 124, 2222);
select * from log_dept_tb;

