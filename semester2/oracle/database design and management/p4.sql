set serveroutput on;

--slide 18 4.1
declare
v_myage number := 31;

begin
  if v_myage < 11 then
  dbms_output.put_line('i am a child');
  else
  dbms_output.put_line('i am a adult');
  end if;
end;
/

--slide 22 4.1
declare
v_myage number := '&x';

begin
  if v_myage < 11 then
  dbms_output.put_line('i am a child');
  elsif v_myage < 20 then
  dbms_output.put_line('i am a young');
  elsif v_myage < 30 then
  dbms_output.put_line('i am a twenties');
  elsif v_myage < 40 then
  dbms_output.put_line('i am a thirties');
  else
  dbms_output.put_line('i am a mature');
  end if;
end;
/
--slide 28 4.1
DECLARE
v_myage NUMBER       := 31;
v_myfirstname VARCHAR2(11) := 'Christopher';
BEGIN
IF v_myfirstname = 'Christopher' AND v_myage < 11 THEN
DBMS_OUTPUT.PUT_LINE('I am a child named Christopher');  
END IF;
END;
/

DECLARE v_myage NUMBER:=31;
BEGIN 
IF v_myage < 11 THEN
DBMS_OUTPUT.PUT_LINE('I am a child');  
ELSE 
DBMS_OUTPUT.PUT_LINE('I am not a child');
END IF;
END;
/

DECLARE
  v_num NUMBER := '&x';
  v_txt VARCHAR2(50);
BEGIN 
  CASE v_num 
    WHEN 20 THEN v_txt:= 'number equals 20';
    WHEN 17 THEN v_txt:= 'number equals 17';
    WHEN 15 THEN v_txt:= 'number equals 15';
    WHEN 13 THEN v_txt:= 'number equals 13';
    WHEN 10 THEN v_txt:= 'number equals 10';
    ELSE v_txt:= 'some other number';
  END CASE;
  DBMS_OUTPUT.PUT_LINE(v_txt);
END;

/

--Case Statement
--slide 8 4.2
DECLARE
  v_num NUMBER := 15;
  v_txt VARCHAR2(50);
BEGIN CASE 
  WHEN v_num> 20 THEN v_txt:= 'greater than 20';
  WHEN v_num> 15 THEN v_txt:= 'greater than 15';
  ELSE v_txt:= 'less than 16';
  END CASE;
  DBMS_OUTPUT.PUT_LINE(v_txt);
END;
/

--slide 9 4.2
DECLARE 
  v_out_var VARCHAR2(15);
  v_in_var NUMBER := '&x';
BEGIN
  IF v_in_var= 1 THEN v_out_var:= 'Low value';
  ELSIF v_in_var= 50 THEN v_out_var:= 'Middle value';
  ELSIF v_in_var= 99 THEN v_out_var:= 'High value';
  ELSE v_out_var:= 'Other value';
  END IF;
  DBMS_OUTPUT.PUT_LINE(v_in_var);
  DBMS_OUTPUT.PUT_LINE(v_out_var);
END;
/

DECLARE
  v_out_var VARCHAR2(15);
  v_in_var NUMBER;
BEGIN
  v_out_var:= CASE v_in_var 
  WHEN 1  THEN 'Low value'
  WHEN 50 THEN 'Middle value'
  WHEN 99 THEN 'High value'
  ELSE 'Other value'
  END;
END;

/
--Case Expression
--16 4.2
DECLARE
  v_grade CHAR(1) := upper('&x');
  v_appraisal VARCHAR2(20);
BEGIN v_appraisal:= CASE v_grade
  WHEN 'A' THEN 'Excellent'
  WHEN 'B' THEN 'Very Good'
  WHEN 'C' THEN 'Good'
  ELSE 'No such grade'
  END;
  DBMS_OUTPUT.PUT_LINE('Grade: ' || v_grade||', Appraisal: ' || v_appraisal);
END;
/

--15 4.2
DECLARE
  v_grade CHAR(1) := upper('&x');
  v_appraisal VARCHAR2(20);
BEGIN v_appraisal:= CASE 
  WHEN v_grade = 'A' THEN 'Excellent'
  WHEN v_grade in ('B','C') THEN 'Good'
  ELSE 'No such grade'
  END;
  DBMS_OUTPUT.PUT_LINE('Grade: ' || v_grade||', Appraisal: ' || v_appraisal);
END;


--assigment
-- soal 1
/*buat program untuk menerima input umur dari user dengan ketentuan :
-jika umur kurang dari 5 maka keterangan output balita.
-jika umur 6 sampai 12 maka keterangan output anak2.
-jika umur 13 sampai 17 maka keterangan output remaja.
-jika umur 18 sampai 55 maka keterangan output dewasa.
-jika umur lebih dari 55 maka keterangan output lansia.
*/

--soal 2
/* buat sebuah table emp dari table employees, lalu
buat blok program untuk mendapatkan data last_name dan gaji
seorang karyawan, ketentuannya :
-jika gaji < 15000, maka output gaji baru diberi
kenaikan 10% dari gaji saat ini.
-jika gaji >= 15000 maka tidak ada
kenaikan gaji.
berdasarkan employee id (input dari user).
(memakai table emp).*/