set serveroutput on;
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

--1
declare
v_myage number := '&x';
begin
  if v_myage <= 5 then
  dbms_output.put_line('balita');
  elsif v_myage <= 12 then
  dbms_output.put_line('anak2');
  elsif v_myage <= 17 then
  dbms_output.put_line('remaja');
  elsif v_myage <= 55 then
  dbms_output.put_line('dewasa');
  else
  dbms_output.put_line('lansia');
  end if;
end;
/
--3
DECLARE
  v_myage NUMBER := '&x';
  v_txt VARCHAR2(50);
BEGIN
  CASE 
    WHEN v_myage <= 5 THEN v_txt:= 'balita';
    WHEN v_myage <= 12 THEN v_txt:= 'anak2';
    WHEN v_myage <= 17 THEN v_txt:= 'remaja';
    WHEN v_myage <= 55 THEN v_txt:= 'dewasa';
    ELSE v_txt:= 'lansia';
  END CASE;
  DBMS_OUTPUT.PUT_LINE(v_txt);
END;
/
------------------------------------------------------------------------------------
--1
declare
 v_myage number := &umur;
begin
  if v_myage < 6 then
  dbms_output.put_line(v_myage || ' tahun, maka balita.');
  elsif v_myage between 6 and 12 then
  dbms_output.put_line(v_myage || ' tahun, maka anak-anak.');
  elsif v_myage between 13 and 17 then
  dbms_output.put_line(v_myage || ' tahun, maka remaja.');
  elsif v_myage between 18 and 55 then
  dbms_output.put_line(v_myage || ' tahun, maka dewasa.');
  else
  dbms_output.put_line(v_myage || ' tahun, maka lansia.'); 
  end if;
end;
/

--2
declare
  ln emp.last_name%type;
  sal emp.salary%type;
  naik int;
begin
  select last_name, salary into ln, sal
  from emp
  where employee_id = &x;
  if sal <15000 then
    naik := sal + (sal*0.10);
    dbms_output.put_line('Last Name : ' || ln);
    dbms_output.put_line('Salary telah dinaikan 10% dari ' || sal || ' menjadi ' || naik);
  else
    dbms_output.put_line('Last Name : ' || ln);
    dbms_output.put_line('Salary tidak dinaikan 10% dikarenakan salary sebesar ' || sal);
  end if;
end;
/

--3 
declare
 v_myage number := &umur;
begin
  case 
    when v_myage < 6 then
    dbms_output.put_line(v_myage || ' tahun, maka balita.');
    when v_myage between 6 and 12 then
    dbms_output.put_line(v_myage || ' tahun, maka anak-anak.'); 
    when v_myage between 13 and 17 then
    dbms_output.put_line(v_myage || ' tahun, maka remaja.');
    when v_myage between 18 and 55 then
    dbms_output.put_line(v_myage || ' tahun, maka dewasa.'); 
    else
    dbms_output.put_line(v_myage || ' tahun, maka lansia.'); 
  end case;
end;
/

declare
 v_myage number := &umur;
 ket varchar2(30);
begin 
 ket := case 
    when v_myage < 6 then 'tahun, maka balita.'
    when v_myage between 6 and 12 then 'tahun, maka anak-anak.'
    when v_myage between 13 and 17 then 'tahun, maka remaja.'
    when v_myage between 18 and 55 then 'tahun, maka dewasa.'
    else 'tahun, maka lansia.' 
  end;
  dbms_output.put_line(v_myage || ' ' || ket);
end;
/

declare
 v_myage number := &umur;
 ket varchar2(30);
begin 
 ket := case 
  when v_myage < 6 then 'tahun, maka balita.'
  when v_myage between 6 and 12 then 'tahun, maka anak-anak.'  
  when v_myage between 13 and 17 then 'tahun, maka remaja.'
  when v_myage between 18 and 55 then 'tahun, maka dewasa.'
  else 'tahun, maka lansia.'
  end;
  dbms_output.put_line(v_myage || ' ' || ket);
end;
  /


--4
declare
  ln emp.last_name%type;
  sal emp.salary%type;
  naik int;
begin
  select last_name, salary into ln, sal
  from emp
  where employee_id = &x;
  case
    when sal <15000 then
    naik := sal + (sal*0.10);
    dbms_output.put_line('Last Name : ' || ln);
    dbms_output.put_line('Salary telah dinaikan 10% dari ' || sal || ' menjadi ' || naik);
  else
    dbms_output.put_line('Last Name : ' || ln);
    dbms_output.put_line('Salary tidak dinaikan 10% dikarenakan salary sebesar ' || sal);
  end case;
end;
/

------------------------------------------------------------------------------------
--4.1

declare
  v_name wf_countries.country_name%type;
  v_population wf_countries.population%type;
begin
  select country_name, population into v_name, v_population
  from wf_countries
  where country_id = &x;
  if v_population > 1000000000 then
    dbms_output.put_line('Population ' || v_name || ' is greater than 1 billion');
    elsif v_population > 0 then
    dbms_output.put_line('Population ' || v_name || ' is greater than 0');
    elsif v_population = 0 then
    dbms_output.put_line('Population ' || v_name || ' is 0');
    else
    dbms_output.put_line(' No data for this country');
  end if;
end;
/
DECLARE
   v_country_id			wf_countries.country_name%TYPE :=1; 
   v_ind_date			  wf_countries.date_of_independence%TYPE; 
   v_natl_holiday	  wf_countries.national_holiday_date%TYPE;
BEGIN
   SELECT country_name, date_of_independence, national_holiday_date
   FROM wf_countries
   WHERE country_id in (672, 964, 34, 1); 
   IF v_ind_date IS NOT NULL THEN
      DBMS_OUTPUT.PUT_LINE(v_ind_date || v_natl_holiday || 'A');
   ELSIF v_natl_holiday IS NOT NULL THEN 
      DBMS_OUTPUT.PUT_LINE(v_ind_date||v_natl_holiday ||'B');
   ELSIF v_natl_holiday IS NULL AND v_ind_date IS NULL THEN 
      DBMS_OUTPUT.PUT_LINE(v_ind_date||v_natl_holiday ||'C');
   END IF;
END;
/
DECLARE
   v_num1	NUMBER(3) := 123;
   v_num2	NUMBER;
BEGIN
   IF v_num1 != v_num2 THEN
      DBMS_OUTPUT.PUT_LINE('The two numbers are not equal'); 
   ELSE
      DBMS_OUTPUT.PUT_LINE('The two numbers are equal'); 
   END IF;
END;
/

declare
  v_year number(4) := &x;
begin
  if (v_year mod 4 = 0 and v_year mod 100 != 0) or v_year mod 400 = 0 then
    dbms_output.put_line(v_year || ' is a leap year');
    else
    dbms_output.put_line(v_year || ' is not a leap year');
  end if;
end;

/
declare
   v_country_name	wf_countries.country_name%type := '&x' ;
   v_airports		  wf_countries.airports%type;
begin
   select airports into v_airports 
   from wf_countries
   where country_name = v_country_name; 
   case
      when v_airports between 0 and 100 then
      dbms_output.put_line(v_country_name || ' : There are 100 or fewer airports.');
      when v_airports between 101 and 1000 then
      dbms_output.put_line(v_country_name || ' : There are between 101 and 1,000 airports.');
      when v_airports between 1001 and 10000 then
      dbms_output.put_line(v_country_name || ' : There are between 1,001 and 10,000 airports.');
      when v_airports > 10000 then
      dbms_output.put_line(v_country_name || ' : There are more than 10,000 airports.');
      else 
      dbms_output.put_line(v_country_name || ' : The number of airports is not available for this country.');
   end case; 
end;

/

declare
   v_country_name           wf_countries.country_name%type :='&x'; 
   v_coastline              wf_countries.coastline %type;
   v_coastline_description	varchar2(50); 
begin
   select coastline into v_coastline from wf_countries
   where country_name = v_country_name; 
   v_coastline_description := case
      when v_coastline = 0 then 'no coastline'
      when v_coastline < 1000 then 'a small coastline'
      when v_coastline < 10000 then 'a mid-range coastline'
      else 'a large coastline'
      end;
   dbms_output.put_line('Country ' || v_country_name || ' has '|| v_coastline_description); 
end;

/

declare
   v_currency_code          wf_countries.currency_code%type :='&x';
begin
   select count(currency_code) into v_currency_code from wf_countries
   where currency_code = v_currency_code; 
    case
      when v_currency_code > 20 then
      dbms_output.put_line('More than 20 countries'); 
      when v_currency_code between 10 and 20 then
      dbms_output.put_line('Between 10 and 20 countries'); 
      when v_currency_code < 10 then
      dbms_output.put_line('Fewer than 10 countries'); 
    end case;
end;
/
DECLARE
   x BOOLEAN := TRUE; 
   y BOOLEAN := TRUE; 
   v_color VARCHAR(20) := 'Red'; 
BEGIN
   IF (x AND y)
      THEN v_color := 'White'; 
   ELSE
      v_color := 'Black'; 
   END IF;
DBMS_OUTPUT.PUT_LINE(v_color); 
END;
