show tables;
select * from member;
select * from c_member;
select * from c_memo;

insert into c_member values('id1',1111,'홍길동','010-2341-2539','hong.@a.com',now());
insert into c_member values('id11',1111,'홍길동','010-2341-2530','hong.@a.com',now());

delete from c_member where id = 'id1';
insert into c_memo (title, contents, time, writer ) values ('추가제목','추가내용',default, 'id11');
insert into member values('id_jdbc1' ,1234, '김회원', '010-1234-1234' , 'kim@mem.net', now());

select id, name,email,phone, DATE_FORMAT(legdate,'%y/%m/%d %h시 %i분 %s초') from member;

select password, insert(password,1,char_length(password),repeat('*',char_length(password))) from member;

select employee_id, first_name, salary, hire_date from employees where employee_id between 100 and 199 ;
-- employees 에서 사번, 이름, 급여, 입사일, 조회하되 사번이 100번대 (100~199)

show tables;
desc employees;
desc departments;
select *from departments;
desc jobs;


select e.first_name ,d.department_name ,l.city from employees e 
inner join departments d on e.department_id = d.department_id 
inner join locations l on d.location_id= l.location_id;

select salary from employees where first_name='William';

select employee_id, first_name, salary from employees 
where salary > any (select salary from employees where first_name='William'); -- 윌리엄 두사람나와서 두사람중 하나의 급여중에 아무거나 크면됨 

