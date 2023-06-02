--INSERT
--테이블에 데이터 추가
--INSERT INTO 테이블명(컬럼명1,컬럼명2....)
--VALUES(테이터1,테이터2,....)
INSERT INTO HUMAN(PNAME, AGE) VALUES('테스트2',23);
--데이터 추가시 컬럼명을 안쓰면, 전체 컬럼에 해당하는 값을 작성
--작성 순서는 테이블 생성시 작성한 컬럼 순서 대로 값을 나열
INSERT INTO HUMAN VALUES('홍씨',44);

--회원테이블에 데이터 추가 5건
INSERT INTO MEMBER(MEMBER_ID,MEMBER_PASSWD,MEMBER_NAME,MEMBER_AGE,MEMBER_GENDER)
VALUES('A0001','Q1W2E3R4','김씨1',22,'F');
INSERT INTO MEMBER(MEMBER_ID,MEMBER_PASSWD,MEMBER_NAME,MEMBER_AGE,MEMBER_GENDER)
VALUES('A0002','Q1W2E3R4','김씨2',33,'M');
INSERT INTO MEMBER(MEMBER_ID,MEMBER_PASSWD,MEMBER_NAME,MEMBER_AGE,MEMBER_GENDER)
VALUES('A0003','Q1W2E3R4','김씨3',44,'F');
INSERT INTO MEMBER(MEMBER_ID,MEMBER_PASSWD,MEMBER_NAME,MEMBER_AGE,MEMBER_GENDER)
VALUES('A0004','Q1W2E3R4','김씨4',55,'M');
INSERT INTO MEMBER(MEMBER_ID,MEMBER_PASSWD,MEMBER_NAME,MEMBER_AGE,MEMBER_GENDER)
VALUES('A0005','Q1W2E3R4','김씨5',66,'M');

--학생테이블에 데이터 추가 2건
INSERT INTO STUDENT VALUES('20201111','홍씨','경제학과',3.2);
INSERT INTO STUDENT VALUES('20202222','김씨','경영학과',1.2);

--사원테이블
--사번, 이름, 직급, 부서명, 입사일, 연봉
CREATE TABLE EMPLOYEE(
	EMP_NO CHAR(4) PRIMARY KEY,
	EMP_NAME VARCHAR2(30),
	EMP_POSITION VARCHAR2(30),
	EMP_DEPARTMENT VARCHAR2(30),
	EMP_DATE DATE,
	EMP_SALARY INTEGER
);
--사원 테이블 데이터 추가
INSERT INTO EMPLOYEE 
VALUES('AAA1','홍길동','사원','회계부','2022/03/01',3200);

--다중 INSERT문
--학생 테이블에 데이터 3건을 추가
insert all
    into student(std_no,std_name,std_major,std_score) 
    values('20221116','홍길동','정치외교학과',3.31)
    into student(std_no,std_name,std_major,std_score)
    values('20221117','김길동','경제학과',3.21)
    into student(std_no,std_name,std_major,std_score)
    values('20221118','박길동','경영학과',3.11)
select * from dual;
--조회
--HUMAN 테이블에서 나이가 20 이상인 사람을 조회
SELECT * FROM HUMAN WHERE AGE >= 20;
--HUMAN 테이블에서 성이 신씨인 사람만 조회
SELECT * FROM HUMAN WHERE PNAME LIKE '신%';

--HUMAN 테이블에서 30대이거나 이름에 '훈'이 들어가는 사람만 조회 
SELECT * FROM HUMAN 
WHERE PNAME LIKE '%훈%' OR AGE BETWEEN 30 AND 39;
--이름이 4글자 이면서 마지막 글자가 '은'으로 끝나는 사람을 조회
-- 한글자 와일드 카드 문자가 _ 이다
SELECT * FROM HUMAN 
WHERE PNAME LIKE '___은';

--MEMBER 테이블에서 나이가 50세 이상이면서 성별 남자인 사람만 조회
SELECT * FROM MEMBER 
WHERE MEMBER_AGE >= 50 AND MEMBER_GENDER <> 'F';

--MEMBER 테이블에서 나이가 많은 순으로 조회, 여자만 조회
SELECT * FROM MEMBER
WHERE MEMBER_GENDER = 'F'
ORDER BY MEMBER_AGE DESC;

--수정
--회원 테이블에서 나이가 50이상인 회원들의 비밀번호를 123456으로 수정
UPDATE MEMBER
SET MEMBER_PASSWD = '123456'
WHERE MEMBER_AGE >= 50;

--회원 테이블에서 모든 회원의 나이를 2씩 감소, 나이는 음수 및 0이 나올수 없다.
UPDATE MEMBER SET MEMBER_AGE = MEMBER_AGE - 2
WHERE MEMBER_AGE - 2 > 0;

--학생 테이블에서 평점이 1미만 학생들의 점수를 0.5씩 올려서 수정








