
-- create table / alter/ drop
-- create table (테이블컬럼명, 컬럼명 타입(길이));
--  drop table 테이블명 ;
-- alter table 테이블명 - 컬럼 1개 추가, 수정, 컬럼 1개 삭제 
-- sql + 데이터 길이  제약조건 설정 
create table member(
	id varchar(30),
    password int(4),
    name varchar(30),
    phone char(13),
    email varchar(30),
    legdate datetime
    
);

insert into member values('id1',1111,'홍길동','010-1234-5678','hong@multi.com','2022-07-15 15:15:13');
insert into member values('id2',2222,'박길동','010-5678-1234','hong@tech.net',now());
insert into member values('id3','222222','박길동','010-5678-1234','hong@tech.net',now());
insert into member values('id4','4444','김한국','010-5678-1234','kim@tech.net',curdate());

select * from member;

-- 폰번호 국번 1234인 회원 id, phone , password 조회, 단 암호 "-"
select id, phone, insert(password,1,char_length(password),repeat('-',char_length(password))) '비밀번호' from member where substr(phone,5,4) ='1234';

create table c_member(
	id varchar(30) primary key,
    password integer(4) not null,
    name varchar(30),
    phone char(13) unique,
    email varchar(30) check(email like '%@%'),
    legdate datetime
);
select * from c_member;

-- 제약조건 효력 발생 
insert into c_member values('id1',1111,'홍길동','010-1234-5678','hong@multi.com','2022-07-15 15:15:13');
insert into c_member values('id2',2222,'박길동','010-5678-1233','hong@tech.net',now());
insert into c_member values('id3','222222','박길동','010-5678-1235','hong@tech.net',now());
insert into c_member values('id4','4444','김한국','010-5678-1236','kim@tech.net',curdate());
insert into c_member values('id5','4444','김한국','010-5678-1239','kim/tech.net',curdate());

-- 메모 테이블 정의 
/* id1 1111 홍길동 ... 제목 내용 글쓴시각 메모번호*/
create table c_memo(
	memo_id int primary key auto_increment,
    title varchar(50) not null,
    contents varchar(4000),
    time datetime default now(),
    writer varchar(30) 
);

-- 제약조건 추가/ 삭제/ 수정 가능 - 이미 테이블 데이터저장중이라면 조심해서 사용해야함 
-- 하기전에 백업본 받아야함 . 
-- create table backup(select*from c_memo);

delete from c_memo where memo_id=2;
alter table c_memo add constraint foreign key(writer) references c_member(id);

insert into c_memo values(1,'1번글제목','1번글 내용',default,'id2');
insert into c_memo (title, contents, time, writer) values('4번글제목','4번글 내용',default,'id3');
insert into c_memo (title, contents, time, writer) values('5번글제목',null,default,'id3');

select * from c_memo;

-- 이름이 홍길동인 사람이 회원가입해서 글쓴게 있으면 제목, 내용 조회 
-- 회원명 글제목 글내용 
select u.name '회원명', m.title '글제목', m.contents '글내용' from c_memo m 
inner join c_member u on m.writer = u.id
where u.name = '홍길동';  

-- foreign key - 다른테이블 컬럼 참조 
-- c_memo.writer (자식) c_member.id (부모)
-- 부모테이블에 존재하지 않는 데이터 자식도 사용 불가능 
-- 부모데이터 삭제시 자식데이터 처리설정하지 않으면 불가능 
delete from c_member where id='id1';
-- 부모데이터 삭제시 자식데이터도 삭제하겠다.
-- foreign key 삭제후 다시 만들거임
-- alter table c_memo add constraint
-- alter table c_memo drop foreign key 테이블명_컬럼명_ibk_1;
alter table c_memo drop foreign key c_memo_ibfk_1;
select * from information_schema.table_constraints where table_name = 'c_memo';
alter table c_memo add constraint foreign key(writer) references c_member(id) on delete cascade on update cascade;
-- 관계만 끊어!
alter table c_memo add constraint foreign key(writer) references c_member(id) on delete no action on update cascade;

show keys from c_memo;