-- 7장. 임시 변수 선언 - conneciton 종료
set @var1 = '문자열';
set @var2 = 100;
set @var3 = 10 / 2;
set @var4 = '2003-06-17 00:00:00';

select @var1, @var2, @var3, @var4;

select hire_date, first_Name
from employees
where hire_date = @var4;

select hire_date, first_Name
from employees
where hire_date = @var4;

-- 함수
-- 집계함수-다중행함수=그룹함수(여러개의 행 모여서 결과 1개 리턴) - group by, having

-- 10의 행 - 결과 10개 리턴


-- 형변환 - cast , convert, format 

select 10, cast(10 as decimal(10, 5)) , convert(10 , decimal(10, 5)) , format(10, 5);
select avg(salary), cast(avg(salary) as signed integer), 
convert(avg(salary) , signed integer), 
format(avg(salary), 0) 
from employees;

-- date : 4자리념연도-2자리월-2자리일 
select cast('2022$07$14' as date);
select cast('2022$07$14' as time);
select cast('2022:09:11 12:23:45' as time);
select cast('20221212' as date);

--  오류 select cast(hire_date as year) from emplyees;

-- 자동형변환=암시적형변환 ( '문자열'-> '4자리-2자리-2자리숫자'->자동날짜)
--  '문자열' --> "숫자구성", "숫자와.구성" "문자시작숫자" (숫자적용)연산자 포함  
select '8818.5678' + 1;
select "100" + "200" ; -- 300
select "100가나다" + "가나다200가나다" ; -- 100 + 0
select 0=0; -- 같으면 1, 다르면 0 
select 0 = "MYSQL0";

select CONCAT("100" , "200") ; -- 100200


-- 조건
-- IFNULL , NULLIF, IF, CASE 
-- IFNULL(데이터, 변환값) - 리턴결과 2개중 하나(NULL이면 변환값, NOT NULL이면 원래의데이터값)
SELECT COMMISSION_PCT, IFNULL(COMMISSION_PCT, '보너스없음') FROM EMPLOYEES;

--  NULLIF(데이터1, 데이터2) - 리턴결과는 데이터1과 데이터2 동일하면 NULL 리턴. 다르면 데이터1 리턴
SELECT NULLIF(100, 100), NULLIF(100, 200);

-- IF(조건, 참결과, 거짓결과 )
SELECT IF(10>20, "크다", "작거나 같다");

-- 사원들 보너스 받는 직원, 받지 못한하는 직원 
/*사원명  본너스지급유무
KELLY   받는다
,,,     못받는다
*/

SELECT FIRST_NAME, COMMISSION_PCT, IF(COMMISSION_PCT IS NULL, '못받는다', '받는다') 
FROM EMPLOYEES;


-- 급여가 15000 이상이면 '임원', 
-- 15000미만 10000 이상이면 '부장', 
-- 10000 미만 5000 이상 '과장'
-- 나머지 '대리나 사원'
/*
사원명   급여      직급 
KELLY   13000    부장
*/
SELECT FIRST_NAME 사원명, SALARY 급여,
IF(SALARY >= 15000, '임원',
IF(SALARY >= 10000,'부장', 
IF(SALARY >= 5000, '과장','대리나 사원') 
) 
) 직급
FROM EMPLOYEES
ORDER BY 급여 DESC  ;

-- CASE 문법 문장 ;
SET @casevar = 200;
select
CASE  @casevar
WHEN 1 then '1이다'
when 10 then '10이다'
when 100 then '100이다'
else '모른다'
end;

 -- 급여가 15000 이상이면 '임원', 
-- 15000미만 10000 이상이면 '부장', 
-- 10000 미만 5000 이상 '과장'
-- 나머지 '대리나 사원'

/*
사원명   급여      직급 
KELLY   13000    부장
*/

select first_name 사원명, salary 급여,
case 
when  salary >= 15000 then '임원'
when  salary >= 10000 then '부장'
when salary >= 5000 then '과장'
else '대리나 사원'
end 직급 from employees;

 SELECT DATABASE(), USER(), CURRENT_USER(), VERSION() ;

-- 함수(사용자정의) + 내장함수
-- 문자
select ascii('a') , char(65); 
set @charvar1 = "java";
set @charvar2 = "자바"; -- 자바 한글 2바이트(db 한글 3바이트) 

select bit_length(@charvar1), length(@charvar1),  char_length(@charvar1),
bit_length(@charvar2), length(@charvar2),  char_length(@charvar2);

-- 사원 테이블에서 이름이 3글자로 이루어진 사원의 이름만 출력
select first_name from employees where char_length(first_name) = 3;

-- cancat-두개문자열 합침
select concat('a', 'b', 'cc') , concat_ws(':', 'b', 'cc',"ddd"); -- b:cc


-- 문자열 검색 ( 문자를 데이터로 주고 해당 위치 리턴 / 해당 위치를 주고 문자 리턴
select elt(2, '일', '둘', '3'); -- 2번째 문자 
select substring("일이삼사", 1, 2); -- 1번부터 2개 문자
select field('둘', '일', '둘', '3'); -- '둘' 이라는 문자 인덱스 (1~)
select find_in_set('이', '일,이,삼,사'); -- 2
select instr("일이삼사" , "이"); -- 2
select locate( "삼사", "일이삼사"); -- 3

-- employees 테이블에서 2006년 입사자 찾기
-- 1. like 2. 2006/01/01 사이 2006/12/31   3. 2006이 1번 문자인지 확인  4. 1번 문자가 2006 확인
select hire_date from employees where hire_date like '2006%';
select hire_date from employees where hire_date >='2006-01-01' and hire_date <='2006-12-31';
select hire_date from employees where instr(hire_date, '2006') = 1;
select hire_date from employees where substr(hire_date,1,4) = '2006'; 
SELECT hire_date from employees where  LEFT(HIRE_DATE, 4) = '2006';
SELECT hire_date from employees where  year(HIRE_DATE) = '2006'; -- 24
SELECT hire_date from employees where date_format(hire_date, '%Y')='2006';


-- 6월 입사자 찾기
select hire_date from employees where hire_date like '_____06%';
#select hire_date from employees where hire_date >='2006-06-01' and hire_date <='2006-06-31';

select hire_date, instr(hire_date, '06') from employees order by 2 desc; 

-- 2006-06 월 입사자
select hire_date from employees where instr(hire_date, '-06') = 5 ;
select hire_date from employees where substr(hire_date,6,2) = '06';
select hire_date from employees where month(hire_date) = '6'; -- 11
select hire_date from employees where date_format(hire_date, '%c')='6';


-- format ( 숫자 소수점 이하 ',' - 문자데이터 변환 기능 유사)
select 123456.7890, format(123456.7890 , 0);

select format(avg(salary) , 0) from employees; -- 반올림 

-- BIN , HEX, OCT -- 2, 16, 8진수 변환

-- INSERT - 지정 숫자 갯수만큼 삭제하고 새로운 추가
SELECT 'ABCDEF', INSERT('ABCDEF', 3, 2, '-');

-- REPEAT 
SELECT REPEAT('ABC', 10);

-- 데이터베이스 암호저장컬럼 존재 
SELECT FIRST_NAME, PHONE_NUMBER FROM EMPLOYEES ;
/*이름     폰번호
KELLY   011.111.****(12개 구성 - 뒤 4개)*/

SELECT FIRST_NAME 이름, INSERT(PHONE_NUMBER, 9, 4, REPEAT("*", 4))  폰번호 FROM EMPLOYEES ;

/*이름   첫문자는 그대로, 나머지 '*'-이름 문자 갯수-1만큼  */

SELECT INSERT(FIRST_NAME, 2, CHAR_LENGTH(FIRST_NAME)-1, REPEAT('*', CHAR_LENGTH(FIRST_NAME)-1) )
 FROM EMPLOYEES;

SELECT INSERT('ABCDEF', 3, 2, "*") ; -- AB*EF
SELECT REPLACE('ABCDEF', 'CD',  "*") ; -- AB*EF

-- LEFT , RIGHT
SELECT LEFT("MYSQL", 3) , RIGHT("MYSQL", 3), SUBSTRING("MYSQL", 2, 3);

-- UPPER , LOWER (MYSQL SELECT 문자열 알파벳 값 비교 대소문자 구분X, USER명, 암호 대소문자 구분X)
-- (ORACLE SELECT 문자열 알파벳 값 비교 대소문자 구분O)
SELECT 'kEllY', UPPER('kEllY'), LOWER('kEllY');

-- LPAD, RPAD, LTRIM, RTRIL, TRIM

-- REPEAT , REPLACE, SUBSTRING


-- 숫자
-- 수학공식
SELECT FORMAT(1234.5678, 0), CAST(1234.5678 AS SIGNED INTEGER); -- 1,235 , 1235

-- ROUND

-- TRUNCATE 
SELECT 1234.5678, ROUND(1234.5678 , 3), TRUNCATE( 1234.5678 , 3);
SELECT 1234.5678, ROUND(1234.5678 , 2), TRUNCATE( 1234.5678 , 2);
SELECT 1234.5678, ROUND(1234.5678 , 0), TRUNCATE( 1234.5678 , 0);
SELECT 1234.5678, ROUND(1234.5678 , -1), TRUNCATE( 1234.5678 , -1);-- 십자리표현
SELECT 1234.5678, ROUND(1234.5678 , -2), TRUNCATE( 1234.5678 , -2);
SELECT 1234.5678, ROUND(1234.5678 , -3), TRUNCATE( 1234.5678 , -3);

-- MOD( 나머지함수 )
-- + - * / (자바 %연산자(나머지) - MYSQL LIKE 값 표현 )

SELECT MOD(100, 3);

-- EMPLOYEES 테이블 사번컬럼 값이 홀수이면 홀수사번 출력, 짝수이면 짝수사번 '사번의성격'
 SELECT EMPLOYEE_ID 사번, 
 IF(MOD(EMPLOYEE_ID, 2)=0 , "짝수사번", "홀수사번") 사번의성격  
 FROM EMPLOYEES
 ORDER BY 2;
 
-- 날짜 - year 함수
-- 현재날짜와 시각
SELECT NOW(), SYSDATE(), CURDATE(), CURTIME();
SELECT DATE(NOW()), TIME(NOW());

-- 년 월 일 시 분 초 
SELECT Year(now()), month(now()), day(now()), hour(now()), minute(now()), second(now());

-- 날짜 사이 더하기 빼기
-- 어제 날짜, 내일날짜  
select CURDATE() 오늘날짜, subdate(curdate() , interval 1 day ) 어제날짜, 
adddate(curdate() , interval 1 day ) 내일날짜, 
adddate(curdate(), interval 1 month) 한달후날짜,
adddate(curdate(), interval 1  year) '1년후날짜' ;

-- addtime, subtime
select addtime('2002-12-12 19:00:00', "2:00:00");

-- 두 날짜 사이의 날짜 차이
select datediff(now(), '2022-06-30'); -- 14일
select timediff(time(now()), '15:00:00'); -- 시 분 초

-- 두 날짜 사이의 개월 차이
select period_diff('202307','202207');

-- 요일 - 날짜시간 기본 형식 요일 빠져있다
-- dayofweek / weekday
-- dayofweek  요일정보 1~: 일요일 
-- weekday 요일정보 : 0~:월요일
select now(), dayofweek(now()), weekday(now()); 

-- case 절 이용 + weekday

select now() 현재시각, 
case weekday(now())
 when 0 then "월요일"
 when 1 then "화요일"
 when 2 then "수요일"
 else "목금토일중 하나"
end 현재요일;

-- date_format() / format(숫자, 소수점이하자릿수)

-- 자바 SimpleDateFormat('yyyy-MM-dd HH:mm:ss')

select date_format('2022-07-07', '%y/%c/%e %W %H-%i-%S');
select date_format('2022-07-07', '%Y');
select date_format('2022-07-07', '%W');
select date_format('2022-07-07', '%c');

/*
%Y - 4자리연도  %y-2
%m - 2자리월  %c 1 또는 2자리 %M-영문월이름
%d - 2자리일 %e 1 또는 2자리 

%a - 영문 요일. 3글자 축약
%W - 영문 전체 요일

%H - 24시간 시간  %I - 12시간 
%i - 2자리분 
%S - 2자리초
*/


select hire_date from employees;

-- 202212
select hire_date , period_diff(date_format(now(),"%Y%m") , date_format(hire_date, '%Y%m')) 입사경과개월수 from employees;

-- 229 * 30
-- 모든 사원에 대하여 입사경과일수
select first_name, hire_date , datediff(now(), hire_date) 입사경과일수,
truncate(datediff(now(), hire_date)/7,0) 입사경과주수,
truncate(datediff(now(), hire_date)/365,0) 입사경과년수
 from employees ; 
-- 모든 사원에 대하여 입사경과주수


-- join

select first_name 사원명, employees.department_id 부서코드, department_name 부서명
from employees, departments
where employees.department_id = departments.department_id
order by 1;

-- 모든 사원에 대해 부서명 조회
select first_name 사원명, e.department_id 부서코드, department_name 부서명
from employees e, departments d
where e.department_id = d.department_id
order by 1;

-- 이름에 'le' 포함 사원들만 부서명 조회
select first_name 사원명, e.department_id 부서코드, department_name 부서명
from employees e, departments d
where e.department_id = d.department_id
and instr(first_name, 'le') >= 1
order by 1;

-- 이름에 'le' 포함 사원들만 부서명 조회
select first_name 사원명, e.department_id 부서코드, department_name 부서명
from employees e inner join departments d on e.department_id = d.department_id
where instr(first_name, 'le') >= 1
order by 1;




/*select first_name 사원명, department_id 부서코드 -- adam  50
from employees
order by 1;

select department_id 부서코드, department_name 부서명 -- 50 shipping
from departments
order by 1;
*/

