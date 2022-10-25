-- ��

drop view sal_view;
--��� ��ü�� �̸��� �ߺ��� �� ����.

-- or replace�� �̹� �����ϴ� ��ü�� �ٲ� ������ �ݿ��� �� �並 ����� ���� �� ����Ѵ�.
-- ���� �Ǽ��� ������ ������ �ִٸ� �並 ����� �ʿ� ���� or replace�� �̿��Ͽ� ����(�����)�Ͽ� ����� �� �ִ�.
-- �並 ������ �� or replace�� �����´ٸ� �� ��� ������ �� ���� ����.

-- ���� �ڵ带 ��������ʰ� �Ʒ� �ڵ带 �����ϸ� ������ ����� �ȴ�.
create or replace view sal_view(dname,min_sal,max_sal)
as
select d.dname, min(sal),max(sal) 
from emp e inner join dept d
on e.deptno = d.deptno 
group by d.dname;

create or replace view sal_view(dname,min_sal,max_sal,avg_sal)
as
select d.dname, min(sal),max(sal), avg(sal) as avg_sal 
from emp e inner join dept d
on e.deptno = d.deptno 
group by d.dname;

select * from sal_view;


----------------------------------------------------

-- with check option
create or replace view view_chk30
as
select empno, ename, sal, comm, deptno
from emp_copy
where deptno = 30 with check option; --�� ������ �������� ���� ���ϰ� �϶�� ��. �������� �÷��� �������� ���ϰ� �Ѵ�.

update view_chk30
set deptno = 10;
-- ���� WITH CHECK OPTION�� ���ǿ� ���� �˴ϴ�


-- with read only
create or replace view view_read30
as
select empno, ename, sal, comm, deptno
from emp_copy
where deptno = 30 with read only; --��� �÷��� ���� CRUD �� C U D�� �Ұ����ϴ�(��ȸ�� ����)

update view_read30
set deptno = 10;
-- �б� ���� �信���� DML �۾��� ������ �� �����ϴ�.(insert, update, delete)
select * from view_read30;


-- ���� Ȱ��
-- TOP - N ��ȸ�ϱ�
-- rownum(�ǻ��÷�)
select * from emp;

--�Ի����� ���� ���� 5���� ����� ��ȸ
select ename, hiredate
from (SELECT ENAME,hiredate FROM EMP ORDER BY hiredate asc)
WHERE ROWNUM <=5;
-- ����� �ڵ�
select * from emp
order by hiredate asc;

select * from emp
where hiredate <= '81/05/01';

desc emp;

select rownum,empno,ename,hiredate
from emp
where rownum <= 5
order by hiredate asc;

create or replace view view_hiredate
as 
select empno, ename, hiredate
from emp
order by hiredate asc;

select * from view_hiredate;

select rownum, empno, ename,hiredate
from view_hiredate
where rownum >=1 and rownum <=5; --rownum�� �������� ���� ���� �ݵ�� 1�� �����ϴ� ���ǽ��� ������ �Ѵ�.

create or replace view view_hiredate_rm
as
select rownum rm, empno, ename,hiredate --rownum�� ��Ī�� �ο����־�� �ֹ߼��� �������� �� ���̺� ��밡���ϴ�.
from view_hiredate;

select rm, empno, ename, hiredate
from view_hiredate_rm;

select rm, empno, ename, hiredate
from view_hiredate_rm
where rm >=2 and rm <=5;


-- �ζ��κ�(��ȸ�� ��)
    -- �������� �� ����ǰ� ���� ���̻� ������� ����.
    -- ������ �� ������ ��� ����ϴ� �뵵.
    -- ����Ŭ�� �������� �ʴ´�.
-- select (select)-> �Ϲ�����
-- from (select)-> �ζ��κ�   --�츮�� �̹��� �غ���~
-- where (select)-> ��������

select rm, b.*
from (select rownum rm, a.* 
        from (
            select empno,ename,hiredate from emp order by hiredate asc
            )a
      )b
where rm >= 2 and rm <= 5;
--�� ��� ������ ������� ��� ������ ���� ������.
-- a,b�� ������ ���� ����Ͽ� �ڿ� �ִ� ���� ������ ���� �ʾƵ� �ȴ�.

--����~~~~~~~~~~~
--�Ի����� ���� ���� 5���� ��ȸ�ϼ���. �ζ��κ� �������� ���弼��.
select empno, ename, hiredate
from (select empno, ename, hiredate
        from(
            select empno, ename, hiredate from emp order by hiredate asc
            )
        )
where rownum <= 5;


-- ������ ��ü
-- �ڵ����� ��ȣ�� ������Ű�� ��ɼ���
-- create, drop
-- nextval, currval

-- ��� ���(�ɼ��� ������ �������)
-- create sequence ��������
-- start with ���۰� =>1
-- increment by ����ġ =>1
-- maxvalue �ִ밪 => 10�� 1027��
-- minvalue �ּҰ� => 10�� -1027��


--10���� �����Ͽ� 10�� �����ϴ� ������
create sequence dept_deptno_seq
increment by 10
start with 10;

select dept_deptno_seq.nextval
from dual;

select dept_deptno_seq.currval
from dual;


create sequence emp_seq
start with 1
increment by 1
maxvalue 1000;

drop table emp01;

create table emp01
as
select empno,ename,hiredate from emp
where 1 !=1;

select * from emp01;

insert into emp01
values(emp_seq.nextval,'hong',sysdate);
-- empno���� ���� 2�� �Ǵµ�, �̰� ����Ŭ �����̴�. 1�� �ְ� �ʹٸ� ���� ���� 0���� ������ �ȴ�.






















