create table book(
	bookNo char(10) not null primary key,
    bookTitle varchar(30) not null,
	bookAuthor varchar (20),
    bookYear date,
    bookPrice int,
    bookPublisher varchar(10)
);

insert into book values ('B001', '자바프로그래밍', '홍길동', date('2021-01-01') ,30000 ,'멀티출판사');
insert into book values ('B002', 'MYSQL이해', '나이해', date('2022-01-01') ,25000 ,'캠퍼스출판');
insert into book values ('B003', 'SPRING 활용', '김고수', date('2021-01-01') ,45000 ,'디지털출판사');

select * from book;