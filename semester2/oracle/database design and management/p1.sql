set serveroutput on;
--https://www.oracletutorial.com/plsql-tutorial/plsql-case-statement/

DECLARE 
   message  varchar2(20):= 'Hello, World!'; 
BEGIN 
   dbms_output.put_line(message); 
END; 
/ 

--DATA TYPES
DECLARE 
   SUBTYPE name IS char(20); 
   SUBTYPE message IS varchar2(100); 
   salutation name; 
   greetings message; 
BEGIN 
   salutation := 'Reader '; 
   greetings := 'Welcome to the World of PL/SQL'; 
   dbms_output.put_line('Hello ' || salutation || greetings); 
END; 
/

--exception-handling
DECLARE
      v_result NUMBER;
BEGIN
   v_result := 1 / 0;
   EXCEPTION
      WHEN ZERO_DIVIDE THEN --exception is raised when an attempt is made to divide a number by zero.
         DBMS_OUTPUT.PUT_LINE( SQLERRM ); --function returns the error message
END;
/

--VARIABLES
DECLARE 
   -- Global variables  
   num1 number := 95;  
   num2 number := 85;  
BEGIN  
   num1 := num1 + num2;
   dbms_output.put_line('Outer Variable num1: ' || num1); 
   dbms_output.put_line('Outer Variable num2: ' || num2);  
   DECLARE  
      -- Local variables 
      num1 number := 195;  
      num2 number := 185;  
   BEGIN  
      dbms_output.put_line('Inner Variable num1: ' || num1); 
      dbms_output.put_line('Inner Variable num2: ' || num2); 
   END;  
END; 
/ 

--Constants and Literals
DECLARE 
   -- constant declaration 
   pi constant number := 3.141592654; 
   -- other declarations 
   radius number(5,2);  
   dia number(5,2);  
   circumference number(7, 2); 
   area number (10, 2); 
BEGIN  
   -- processing 
   radius := 9.5;  
   dia := radius * 2;  
   circumference := 2.0 * pi * radius; 
   area := pi * radius * radius; 
   -- output 
   dbms_output.put_line('Radius: ' || radius); 
   dbms_output.put_line('Diameter: ' || dia); 
   dbms_output.put_line('Circumference: ' || circumference); 
   dbms_output.put_line('Area: ' || area); 
END; 
/ 

DECLARE
  n_sales NUMBER := 300000;
  n_commission NUMBER( 10, 2 ) := 0; --precision 10, scale 2 example : 12345678.90
BEGIN
  IF n_sales > 200000 THEN
    n_commission := n_sales * 0.1;
  ELSIF n_sales <= 200000 AND n_sales > 100000 THEN 
    n_commission := n_sales * 0.05;
  ELSIF n_sales <= 100000 AND n_sales > 50000 THEN 
    n_commission := n_sales * 0.03;
  ELSE
    n_commission := n_sales * 0.02;
  END IF;
    dbms_output.put_line(n_commission);
END;
/


BEGIN
dbms_output.put_line('hello world');
END;
/