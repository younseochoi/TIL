Select first_name,department_name, employees.department_id from employees 
inner join departments on employees.department_id= departments.department_id;

-- 4장 데이터베이스 모델링 이론 개념 - 현실 세계 데이터 
-- 1개 테이블 데이터 정의하지 말자!

-- 테이블 alias 사용                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
Select first_name,e.department_id, department_name from employees e
inner join departments d on e.department_id= d.department_id;

-- 부서이름 별 급여 총합  //이거 sql 한번확인 !!!!!!!!!!!!!!
Select d.department_name 부서이름, sum(e.salary) '부서명별 급여 총합' ,d.department_id from employees e
inner join departments d on e.department_id= d.department_id 
group by d.department_name, d.department_id having sum(e.salary) >= 100000 
order by d.department_name;

-- 부서코드 별 급여 총합  - 조인안해도됨 
Select e.department_id 부서이름, sum(e.salary) '부서코드별 급여 총합' from employees e
group by e.department_id having sum(e.salary) >= 100000 
order by e.department_id;

-- 세개의 테이블 조인 
/* from A inner join B on A.ID= B.ID
B inner join C on B.C_ID = C.C_ID */

-- 사원명, 근무 도시명 , 국가명 조회
desc employees;
desc departments;
desc locations;
desc countries;

select * from locations location_id;

select e.first_name , l.city, c.country_name from employees e inner join departments d on e.department_id = d.department_id 
inner join locations l on d.location_id = l.location_id
inner join countries c on c.country_id = l.country_id;

-- 사원명 , 부서명, 도시명, 국가명 , 50,80,100 번 부서에 한해서 , 급여가 5000이상인 사람 
select e.first_name 사원명, d.department_name '부서명' ,l.city '도시명', c.country_name '국가명', e.salary '급여' ,e.department_id '부서코드'
from employees e inner join departments d on e.department_id= d.department_id
inner join locations l on d.location_id = l.location_id 
inner join countries c on l.country_id = c.country_id 
where e.department_id in (50,80,100) and e.salary >= 5000;
 
-- join outer join / inner join 
select first_name, employees.department_id, department_name
from employees inner join departments 
on employees.department_id = departments.department_id;

select count(*) from employees;
select count(department_id) from employees; -- 컬럼 not null 갯수
select * from employees where department_id is null;

-- inner join -join 2개 테이블 모두 존재하고 조건에 일치하는 데이터만 합침
-- outer join -  2개 테이블 모두 존재하고 조건에 일치하지않아도 데이터만 합침
-- left outer join / right outer join
select first_name, e.department_id, department_name from employees e left outer join departments d
on e.department_id = d.department_id order by department_name;

select first_name, e.department_id, department_name from employees e right outer join departments d
on e.department_id = d.department_id order by department_id; -- departments에 있으면 다 가져와 

-- 사원들에 부서명조 조회하되 부서 소속되지 않은사람은 부서코드 '-' , 부서명 소속부서없음 출력
select first_name, ifnull(e.department_id,'-'), ifnull(department_name,'소속부서 없음') from employees e left outer join departments d 
on e.department_id = d.department_id order by first_name;

select distinct first_name, ifnull(first_name,'부서원 없음'), d.department_id, d.department_name from employees e right outer join departments d 
on e.department_id = d.department_id order by first_name;
-- self join 
-- 사원 본인 사번 - employee_id , manager_id 사번들은 모두 employees에 있음. 
select employee_id , first_name, manager_id
from employees where first_name like 'ke%';

select employee_id, first_name 
from employees where employee_id =122;

-- 상사가 없는 직원은 제외하고 출력 
select me.first_name,me.manager_id, manager.employee_id, manager.first_name 
from employees me inner join employees manager on me.manager_id = manager.employee_id; -- me에서 상사찾고 ㅡmanager에서 employee_id 찾음 

-- 상사 없는 직원 포함하고 출력
select employee_id , first_name from employees where manager_id is null; -- 100 Steven

select me.first_name,me.manager_id, manager.employee_id, manager.first_name 
from employees me left outer join employees manager on me.manager_id = manager.employee_id; -- me에서 상사찾고 ㅡmanager에서 employee_id 찾음 

-- 부하직원 없는 직원들도 다 포함 
select ifnull(me.first_name,'신입사원'),me.manager_id, manager.employee_id, manager.first_name 
from employees me right outer join employees manager on me.manager_id = manager.employee_id; -- me에서 상사찾고 ㅡmanager에서 employee_id 찾음 

-- union/ union all /not in/ in 
-- subquery 사용 where 절 조건 단일 행 서브쿼리 =/ 여러행 서브쿼리 in 

create table emp_dept_50 
(select * from employees where department_id = 50);
create table emp_job_man(select * from employees where job_id like '%MAN%');

select * from emp_dept_50;
-- 3-- 50번나 매니직종

-- select employee_id first_name, job_id, deapartent from emp_job_man, union;
-- Substring 
-- insert 

-- 이름이 kelly 와 같은 부서 근무사원 이름 ,부서코드 조회 
select first_name, department_id from employees
where department_id = (select department_id from employees where first_name = 'kelly');

-- 이름이 kelly 와 같은 부서이면서 같은 직종인 근무사원 이름 ,부서코드 조회 
select first_name, department_id, job_id from employees
where (department_id,job_id)= (select department_id,job_id from employees where first_name = 'kelly') and first_name != 'kelly';

-- 이거 왜 이상하게 나오지??????!!!!!!!!!!!!! 
select first_name, department_id, job_id from employees
where (department_id,job_id) not in (select department_id,job_id from employees where first_name = 'peter') ;
-- (department_id,job_id) IN ....==> 2개 모두가 같을 때에만 조회. (department_id,job_id) NOT IN ....==> 1개 또는 2개 모두가 같지 않을 때 조회.
select department_id,job_id from employees where first_name = 'peter';

select first_name, department_id from employees where salary = (select truncate(avg(salary),-2) from employees);