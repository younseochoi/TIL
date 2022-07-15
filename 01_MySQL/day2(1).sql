select user();
-- use empdb;
select database();
-- 6개 테이블 생성 - empdb 내부 

-- 107명
select * from employees;
select sum(salary) from employees; -- 1개
SELECT  SUM(salary), AVG(SALARY), COUNT(SALARY), MAX(SALARY), MIN(SALARY) FROM employees; -- 1개

-- 숫자 문자 날짜 크다 - 작다 
-- 문자 사전 순서 앞 - 작다 , 뒤 - 크다
SELECT MAX(FIRST_NAME), MIN(FIRST_NAME), COUNT(FIRST_NAME) FROM EMPLOYEES;
SELECT MAX(HIRE_DATE), MIN(HIRE_DATE), COUNT(HIRE_DATE) FROM EMPLOYEES;

-- COUNT(컬럼명) -- 컬럼 NOT NULL 갯수
SELECT COUNT(HIRE_DATE), COUNT(DEPARTMENT_ID), COUNT(COMMISSION_PCT), COUNT(*) FROM EMPLOYEES;

SELECT FIRST_NAME, DEPARTMENT_ID FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

-- 72 + 35 - 107
SELECT FIRST_NAME, COMMISSION_PCT FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

-- 집계함수 결과 1개. SELECT 절 다른 컬럼 같이 조회 X
SELECT SALARY, SUM(SALARY) FROM EMPLOYEES; -- 의미 없다
SELECT SALARY FROM EMPLOYEES;

--
SELECT FIRST_NAME, DEPARTMENT_ID, SALARY FROM EMPLOYEES;
-- 모든 부서의 사원 급여 총합
SELECT SUM(SALARY) FROM EMPLOYEES;
-- 90번 부서에 급여 총합
SELECT SUM(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = 90;

-- 모든 부서에 대해 각 부서별 급여 총합 조회
SELECT DEPARTMENT_ID, SUM(SALARY) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 모든 부서에 대해 각 부서별 급여 총합 조회하되 급여 총합이 100000 이상인 결과만 조회
-- WHERE 절에는 집계함수조건ㅅ기 불가능(GROUP BY 이전 WHERE 먼저 실행)
-- HAVING절  집계함수 조건식
SELECT DEPARTMENT_ID, SUM(SALARY) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING SUM(SALARY) >=100000;

/* FROM - WHERE - GROUP BY - HAVING - SELECT - ORDER BY */

-- JOB_ID-직종코드(문자)

SELECT FIRST_NAME, JOB_ID FROM EMPLOYEES;

-- 직종별로 사원의 급여 평균을 구하되(GROUP BY)
-- IT_PROG 직종은 제외하고 조회(WHEREH )
-- 조회 컬럼은 직종코드 , 부서평균급여 조회 - SELECT 
-- 부서평균급여가 많은 직종부터 보여주도록 조회 - ORDER BY 

SELECT JOB_ID 직종코드, AVG(SALARY) '부서 평균 급여'
FROM EMPLOYEES
WHERE JOB_ID != 'IT_PROG'
GROUP BY JOB_ID
ORDER BY AVG(SALARY) DESC;
-- ORDER BY 2 DESC;
-- ORDER BY '부서 평균 급여' DESC;

SELECT * FROM EMPLOYEES;

-- 2006년 이후 입사 사원에 대해서 부서별 보너스 평균 상황
-- 보너스 = SALARY  + SALARY* COMMISSION_PCT 계산
-- 보너스는 받지 못하는 사원 제외,  소속 부서 없는 사원 제외
 
SELECT HIRE_DATE FROM EMPLOYEES ;-- 2002-01-01 00:00:00  >= 2006-01-01 00:00:00

SELECT DEPARTMENT_ID, AVG(SALARY + SALARY*COMMISSION_PCT)   FROM EMPLOYEES 
WHERE HIRE_DATE >= '2006-01-01 00:00:00' 
AND COMMISSION_PCT IS NOT NULL
AND DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID;

SELECT HIRE_DATE, DEPARTMENT_ID  FROM EMPLOYEES 
WHERE HIRE_DATE >= '2006-01-01 00:00:00' 
AND COMMISSION_PCT IS NOT NULL
AND DEPARTMENT_ID IS NOT NULL;



SELECT HIRE_DATE FROM EMPLOYEES 
WHERE HIRE_DATE LIKE '2006%'; -- 2006년도 입사

-- 219p
/* DQL - SELECT - 조회
   DML - INSERT DELETE UPDATE - 저장 삭제 수정
===> 레코드들 대상
   DDL - 사용자 생성 DB 생성 테이블 생성
===> 테이블 DB 사용자alter   
*/

-- 사용자명, 암호 대소문자 구분 
-- 테이블 정의+데이터저장 107개
CREATE TABLE EMP_COPY 
(SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE FROM EMPLOYEES);

SELECT COUNT(*) FROM EMP_COPY;
SELECT COUNT(*) FROM EMPLOYEES;

DESCRIBE EMP_COPY;
DESCRIBE EMPLOYEES;

--  1, 이사원, 15000, '2000-12-10 00:00:00'
INSERT INTO EMP_COPY VALUES(1, '사원', '이' , 15000,  '2000-12-10 00:00:00');
INSERT INTO EMP_COPY VALUES(2, '길동', '홍' , 25000,  '2022-12-12');
INSERT INTO EMP_COPY VALUES(3, '대리', '홍' , 26000,  now());
INSERT INTO EMP_COPY VALUES(4, '신입', '홍' , 10000,  current_date());

-- 나열되지 않는 컬럼 자동 null 
INSERT INTO EMP_COPY(employee_id, HIRE_DATE, last_name) VALUES(5, NOW(), '김' );

-- 명시 null
INSERT INTO EMP_COPY VALUES(6, null, '박' , null,  now());

-- 테이블 정의 동시에 데이터 복사
CREATE TABLE EMP_COPY 
(SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE FROM EMPLOYEES);

-- 테이블은 정의되어있고 데이터만 복사
insert into emp_copy 
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, HIRE_DATE FROM EMPLOYEES;

SELECT * FROM EMP_COPY WHERE EMPLOYEE_ID <=10;

-- 
update emp_copy
set salary =15000 , first_name='수정'
where employee_id=6;

SELECT * FROM EMP_COPY WHERE EMPLOYEE_ID <=10;

-- update emp_copy
-- set salary =15000 , first_name='수정'; -- 107 + 6 ==> 113

-- delete from emp_copy; -- emp_copy 모든 레코드 삭제(테이블구조 남아있다)

delete from emp_copy where employee_id = 6;
SELECT * FROM EMP_COPY WHERE EMPLOYEE_ID <=10;

-- update / delete -- 시간 경과 데이터 쌓여간다 . 
-- 매일 /매주/ 매월
-- 백업 (export) / 복원(import=restore)


insert ignore into emp_copy values(6, '부장','심', 50000, '2020');

insert into emp_copy values(6, '부장','심', 50000, now());

-- employee_id 컬럼 정의시(create table) unique
-- employee_id int(5) unique 전제조건
insert into emp_copy values(6, '부장','심', 50000, now())
on duplicate key update hire_date = now() ;


select * from emp_copy where employee_id <=10;

select * from emp_copy
order by salary desc
limit 10;

select * from emp_copy 
where first_Name='부장'
order by 1 desc;

update emp_copy
set salary = salary + salary * 0.2
where first_Name='부장'-- 4
limit 2; 

select * from emp_copy where first_Name='부장';

-- select / insert / update / delete 








insert ignore into emp_copy values(11, '부장', '이', 25000, '2020');
insert ignore into emp_copy values(12, '부장', '이', 25000, current_date());
insert ignore into emp_copy values(13, '부장', '이', 25000, current_date());
select * from emp_copy where employee_id>=10 and employee_id<=20;




SELECT DEPARTMENT_ID, SUBSTR(HIRE_DATE, 6, 2), SUM(SALARY+SALARY*COMMISSION_PCT)
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL AND DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID, SUBSTR(HIRE_DATE, 6, 2)
HAVING SUM(SALARY+SALARY*COMMISSION_PCT) <= 100000
ORDER BY 3 DESC;

SELECT SUBSTR(HIRE_DATE, 6, 2) FROM EMPLOYEES;

set @var1 = "test";
select @var1;

select char_length('조성희'), length('조성희'), bit_length('조성희');
