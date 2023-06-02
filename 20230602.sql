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

















