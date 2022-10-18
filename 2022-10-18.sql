-- DQL(질의어) 데이터조회

--전체데이터
select empno,ename,job,mgr,hiredate,sal,comm,deptno
from emp;

--전체 컬럼 검색
select * from emp;

--부분컬럼 데이터
select empno,ename,sal
from emp;

select deptno from emp;

select DISTINCT(deptno) from emp; --distinct 중복제어?

select job from emp;
select DISTINCT(job) from emp;

SELECT ename,sal from emp;
--  +,-,*,/ 나머지 연산자는 없다. 컬럼을 대상으로 연산한다.
--null값은 연산이 불가하다
-- 컬럼에 별칭을 사용할 수 있다.
select ename,sal,sal *12+comm,comm from emp;
select ename 사원명,sal,sal *12+nvl(comm,0) as 연봉,comm from emp;

desc emp;

----------------------------------------------------------------------------

-- 데이터 정렬
-- select 컬럼명
-- from 테이블명
-- order by 컬럼명(정렬 기준이 되는 값) asc/desc;
-- 숫자: 1~ 10
-- 날짜: 과거날짜~ 최근날짜
-- 문자: 사전순서
select * from emp order by sal asc; --오름차순
select * from emp order by sal desc; --내림차순
--오름차순은 생략가능하다

select * from emp order by hiredate asc;
select * from emp order by hiredate desc;


--조건검색 
-- select 컬럼명
-- from 테이블명
-- where 조건식(컬럼명=값);
-- 조건식 = <,>,=,!=,<>,<=,>=,and,or

-- 문자를 조건절에 사용할때
-- 대소문자
-- ''
select * from emp where sal >=3000;
select * from emp where deptno =30 and job = 'SAILSMAN' and empno = 7499;
select * from emp where ename = 'FORD'; --검색시에 데이터는 대소문자를 가리기때문에 유의해서 검색해야한다.

-- 날짜를 조건절에 사용할때
-- ''
-- 날짜도 크기가 있다.
-- 80/12/20 -> 1980 12 20 시간 분 초 요일
select * from emp where HIREDATE < '1982/01/01';

--or: 두개 이상의 조건중에 하나 이상 참인 경우에 실행
select * from emp where deptno = 10 or sal > 2000;

--not 논리부정 연산자

select * from emp where sal != 3000;
select * from emp where not sal = 3000;

--and or
--범위조건을 표현할 때 사용
select * from emp where sal >= 1000 and sal<=3000;
select * from emp where sal <=1000 or sal >=3000;

--between and 
select * from emp where sal between 1000 and 3000; -- select * from emp where sal >= 1000 and sal<=3000; 와 같은 의미

--in
select * from emp where sal = 800 or sal = 3000 or sal = 5000;
select * from emp where sal in(800,3000,5000);

--like연산자
--값의 일부만 가지고 데이터를 조회한다.
--와이드 카드를 사용한다 (%,_)
-- %: 모든 문자를 대체한다
-- _: 한 문자를 대체한다
select * from emp where ename like 'F%';
select * from emp where ename like '%O%';
select * from emp where ename like '___D';
select * from emp where ename like 'S___%';

--null 연산자
--is null / is not null
select * from emp where comm is not null;


-- ---------------
-- 집합연산자
-- 두 개의 select 구문을 사용한다
-- 컬럼의 갯수가 동일해야한다.
-- 컬럼의 타입이 동일해야한다.
-- 컬럼의 이름은 상관없다.
-- 합집합, 차집합, 교집합
-- UNION  MINUS  INTERSECT
select empno, ename,sal,deptno from emp where deptno = 10;
select empno, ename,sal,deptno from emp where deptno = 20;

select empno, ename,sal,deptno from emp where deptno = 10 union --(합집합)
select empno, ename,sal,deptno from emp where deptno = 20;

select empno, ename,sal,deptno from emp where deptno = 10 union all
select empno, ename,sal,deptno from emp where deptno = 10;
-- 중복되면 하나만 출력해준다. 하지만 all을 붙이면 중복되더라도 출력해준다

select empno, ename,sal,deptno from emp MINUS --(차집합)
select empno, ename,sal,deptno from emp where deptno = 10;

select empno, ename,sal,deptno from emp INTERSECT --(교집합)
select empno, ename,sal,deptno from emp where deptno = 10;


--1번문제
select * from emp where ename like '%S';

--2번문제
select empno,ename,job,sal,deptno from emp where job = 'SALESMAN';

--3번문제
--집합연산자 사용x
select empno,ename,job,sal,deptno from emp where deptno between 20 and 30 and sal >=2000;
select empno,ename,job,sal,deptno from emp where deptno in(20,30) and sal >=2000;
--집합연산자 사용
select empno,ename,job,sal,deptno from emp  INTERSECT --(합집합)
select empno,ename,job,sal,deptno from emp where deptno != 10 and sal >=2000;

select empno,ename,job,sal,deptno from emp where deptno  = 20 and sal >2000  INTERSECT --(합집합)
select empno,ename,job,sal,deptno from emp where deptno  = 30 and sal >2000;

--4번문제
select * from emp where sal < 2000 or sal > 3000;

--5번문제
select ename,empno,sal,deptno from emp where ename like '%E%' and sal not between 1000 and 2000 and deptno = 30;

--6번문제
select * from emp where job = 'MANAGER' and ename not like '_L%' or job ='CLERK' and ename not like '_L%';


