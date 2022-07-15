SHOW DATABASES;  /* DB 종류 보여줘 결과화면   */

USE MYSQL;  /* MYSQL 사용 */


SELECT HOST , USER FROM USER;/* mysql 중요 db */

CREATE TABLE employees
(EMPLOYEE_ID int(10) , /* 컬럼 - 사번 정수 10자리 */
employee_name varchar(20),/* 컬럼 - 이름 문자열 20바이트 */
salary decimal(10 , 2),/*컬럼 - 급여 실수(전체 10자리 중 소수점 2자리)*/
hire_date date,/*컬럼 - 날짜 (년도 월 일 요일) */
department_id int(5) /*컬럼 - 부서번호 정수 5자리 */
 );
 
select * from employees; 

insert into employees values(100, '이사원' , 45000.99, now(), 10);-- 현재날짜리턴
insert into employees values(101, '김사원' , 45000.99, now(), 10);
insert into employees values(102, '최사원' , 45000.99, now(), 10);
insert into employees values(200, '박대리' , 55000.99, '2020-12-12', 10);
insert into employees values(201, '홍대리' , 55000.99, '2020-07-12', 10);
insert into employees values(203, '최대리' , 55000.99, '2021-07-12', 10);
insert into employees values(300, '김과장' , 65000.99, '2010-12-12', 10);
insert into employees values(301, '이과장' , 65000.99, '2010-06-12', 10);
insert into employees values(302, '최부장' , 75000.99, '2009-06-12', 10);
insert into employees values(303, '박이사' , 85000.99, '2008-12-12', 10);

insert into employees values(303, '박이사' , 85000.99, '12-12/2008', 10);

use mysql;
select * from employees; 
/* 여러줄 주석 */
-- 한줄 주석

select employee_id,employee_name from employees;-- 사번 이름
select employee_id,employee_name, phone_number from employees;-- 오류
select distinct department_id from employees; -- employees 테이블의 사원들의 속한 부서 코드 종류만 나열
/*오라클만 가능. mysql은 concate('',"")
select '사번은 ' || employee_id 
|| ' 이고 이름은 ' || employee_name || "입니다" 
from employees;*/ -- 사번은 xx 이고 이름은 xxxx입니다.

-- 이름, 연봉 조회, 단 연봉은 급여의 12배로 출력
select employee_name, salary * 12 from employees;

/*  >=  >, < , <=, =, != , 
* / + - ,
   */
-- 이름, 급여 조회하되 급여 50000 이상인 사원만 조회
select employee_name, salary from employees
where salary >= 50000 ; 

-- 이름이 이사원이고 급여가 40000 사원 이름과 급여 조회
  select employee_name, salary from employees
  where employee_name='이사원' and salary = 40000;

-- 입사일이 2008-12-12  이거나 급여가 10000 이상인 사원의 입사일, 급여, 이름 조회
select hire_date, salary, employee_name
from employees
where hire_date = '2008-12-12' or salary >= 10000;

-- 이름이 최씨인 사원의 이름과 보너스 조회. 보너스는 급여의 5% 
-- like -문자열 패턴 유사 , %:값의 자릿수 무관, 모든 문자 무관  , _ :1자리, 모든 문자 무관 
select employee_name +'명', salary*0.05 
from employees
where employee_name like '최__';



-- 입사일이 2020년도 입사한 사원의 이름과 입사일 조회(날짜 대소비교. 크다-최근/작다-오래)
-- 날짜 대소비교 (마치 숫자) / 패턴 비교(마치 문자)
select employee_name, hire_date
from employees
where hire_date >= '2020-01-01' and hire_date <= '2020-12-31';

select employee_name, hire_date
from employees
where hire_date like '2020______'; -- -월2-일2-->6자리

-- where hire_date like '%12'; 

-- 급여가 5만 이상이고 7만 이하의 사원 이름과 급여 조회
-- between ~ and -구간 연산자 . 범위 연산자
select employee_name, salary
from employees
-- where salary between 50000 and 70000;
 where salary >= 50000 and salary <= 70000;

-- and or like between~and 
-- 사번이 100, 300, 250, 204 사원의 사번과 이름 조회


select * from employees
where employee_id = 100
or employee_id = 300
or employee_id = 250
or employee_id = 204;  

-- 목록 연산자 in (,,,,,)
select * from employees
where employee_id in (100, 300, 250, 204, 500, 600);

-- employees 테이블 데이터 5개 
insert into employees values(400, '최신입' , 40000.0, null, null);
insert into employees values(401, '김신입' , 40000.0, now(), 20);
insert into employees values(402, '오신입' , 40000.0, now(), 30);
insert into employees values(403, '강신입' , 40000.0, now(), 40);
insert into employees values(404, '최신입' , 40000.0, null, null);

select * from employees;

-- 입사일 없는 사원 조회
select * from employees
where hire_date is null;

-- 부서 배정받은 못한 사원 조회 
select * from employees
where department_id is not null;

-- 조회시 ALIAS(조회 임시 사용 다른 컬럼명)  
-- 오라클 '' , 자바 "", MYSQL '' +""

insert into employees values(405, '김경력' , null, now(), 30);
SELECT EMPLOYEE_NAME 사원명, SALARY 월급, ifnull(salary, 1000)*12 '사원의 연봉' FROM EMPLOYEES;


-- 조회시 두개 이상의 컬럼 연결  . concat
-- xxxx 사원은 xxx의 월급을 받습니다.
select concat(employee_name , ' 사원은 ', salary , '의 월급을 받습니다.') '급여 정보'
from employees;


-- order by
-- 사번 낮은 - 높은 ..
select * from employees
order by employee_id asc;

-- 사번 높 - 낮은 ..
select * from employees
order by employee_id desc;

select * from employees
order by employee_id;

-- 급여 많은 사원부터 조회. 동일 급여 사원은 사번 큰 사원부터
select * from employees
order by salary desc , employee_id desc;

select employee_id, salary from employees
order by 2 desc , 1 desc;

-- 급여 포함(null데이터 asc-처음, desc-마지막)
sELECT employee_id , salary FROM employees
ORDER BY salary ;

-- 급여 많은 사원부터 상위 3명만 조회
select employee_name, salary
from employees
order by salary desc
limit  3;

-- 급여 많은 사원부터 정렬하되 상위 4,5,6,7번째 많은 사원만 조회
-- 게시판 1페이지 선택 - 1-10개 
--      2페이지       11-20개 
select employee_name, salary
from employees
order by salary desc
limit 3, 4; -- 3번인덱스부터 4개

show databases;
use mysql;

select database();
show tables;

create table emp_copy (select employee_name, salary, hire_date from employees);
show tables;
select * from emp_copy;



