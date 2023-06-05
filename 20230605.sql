--그룹 함수 : SUM, AVG, COUNT, MAX, MIN, STDDEV, VARIANCE
--SUM(컬럼명) : 그룹을 묶은 기준으로 해당 컬럼을 가지고 합을 구함
--학과별 평점 총합을 조회 - SUM
SELECT STD_MAJOR, SUM(STD_SCORE) FROM STUDENT GROUP BY STD_MAJOR;
--학과명이 동일한 기준으로 묶어서 조회를 하기 떄문에 묶이지 않는 컬럼은 조회용으로 쓸수 없다.
SELECT STD_MAJOR, STD_NAME,SUM(STD_SCORE) 
FROM STUDENT GROUP BY STD_MAJOR;
--학과별 평점의 평균을 조회
SELECT STD_MAJOR, TRUNC(AVG(STD_SCORE),2) AS AVG_SCORE 
FROM STUDENT GROUP BY STD_MAJOR;
--학과별 평점의 최대값/최소값 조회
SELECT STD_MAJOR, MAX(STD_SCORE), MIN(STD_SCORE)
FROM STUDENT GROUP BY STD_MAJOR;
--학과별 인원수를 조회
SELECT STD_MAJOR, COUNT(*)
FROM STUDENT GROUP BY STD_MAJOR;
--학과별 평점의 분산, 표준편차 조회
SELECT STD_MAJOR, STDDEV(STD_SCORE), VARIANCE(STD_SCORE)
FROM STUDENT GROUP BY STD_MAJOR;
--전체 인원을 대상으로 평점, 인원수, 최대값, 최소값
SELECT AVG(STD_SCORE), COUNT(*), MAX(STD_SCORE), MIN(STD_SCORE)
FROM STUDENT;
--학과별 인원수를 조회, 단 평점이 3.0 이상인 학생들만 대상으로 인원수를 조회
SELECT STD_MAJOR, COUNT(*)
FROM STUDENT
WHERE STD_SCORE >= 3.0
GROUP BY STD_MAJOR;
--학과별 평점의 평균을 조회, 단 학과별 인원수가 100명 이상인 학과들만 대상으로 조회
SELECT STD_MAJOR, AVG(STD_SCORE)
FROM STUDENT
GROUP BY STD_MAJOR HAVING COUNT(*) >= 100;
--학생이름이 C로 시작하는 학생들의 평점의 평균과 인원수를 출력
--SUBSTR, COUNT, AVG
SELECT SUBSTR(STD_NAME,1,1), COUNT(*), AVG(STD_SCORE)
FROM STUDENT
GROUP BY SUBSTR(STD_NAME,1,1) HAVING SUBSTR(STD_NAME,1,1) = 'C';
--학과별 지원금 배정, 90명 이상만 지원
--인당 20000원씩 지원, 지원금 컬럼은 인원수 * 20000
--학과명, 인원수, 지원금 
SELECT STD_MAJOR, COUNT(*), COUNT(*) * 20000
FROM STUDENT
GROUP BY STD_MAJOR
HAVING COUNT(*) >= 90;
--약품 판매 테이블
CREATE TABLE DRUG_SELL(
	SELL_NO NUMBER,
	DRUG_NAME VARCHAR2(100),
	DRUG_MAKER VARCHAR2(100),
	SELL_DATE DATE,
	SELL_EA NUMBER(3),
	DRUG_PRICE NUMBER
);

--제약사만 조회, 중복된 내용을 제외하고 조회
--DISTINCT 중복된 내용을 제외하는 키워드
SELECT DISTINCT DRUG_MAKER FROM DRUG_SELL;
--제약사별 판매 개수 평균을 조회
SELECT DRUG_MAKER, FLOOR(AVG(SELL_EA))
FROM DRUG_SELL
GROUP BY DRUG_MAKER;
--제약사별 판매하는 약품 개수를 조회
SELECT DRUG_MAKER, COUNT(DISTINCT DRUG_NAME)
FROM DRUG_SELL
GROUP BY DRUG_MAKER;

SELECT DISTINCT DRUG_NAME FROM DRUG_SELL WHERE DRUG_MAKER ='Antigen Laboratories, Inc.';

--월별 약품 판매 개수 총합, 평균을 조회 -- 평균은 올림처리해서 조회
--to_char 이용
SELECT TO_CHAR(SELL_DATE,'MM'), SUM(SELL_EA), CEIL(AVG(SELL_EA))
FROM DRUG_SELL
GROUP BY TO_CHAR(SELL_DATE,'MM');
--년도별/월별 약품 판매 개수 총합, 평균을 조회 -- 평균은 올림처리해서 조회
--to_char 이용
SELECT TO_CHAR(SELL_DATE,'YYYY'),TO_CHAR(SELL_DATE,'MM'), SUM(SELL_EA), CEIL(AVG(SELL_EA))
FROM DRUG_SELL
GROUP BY TO_CHAR(SELL_DATE,'YYYY'),TO_CHAR(SELL_DATE,'MM');
SELECT TO_CHAR(SELL_DATE,'YYYY/MM'), SUM(SELL_EA), CEIL(AVG(SELL_EA))
FROM DRUG_SELL
GROUP BY TO_CHAR(SELL_DATE,'YYYY/MM');
--요일별, 약품별 판매 개수 총합을 조회
SELECT TO_CHAR(SELL_DATE,'DY'),DRUG_NAME, SUM(SELL_EA)
FROM DRUG_SELL 
GROUP BY TO_CHAR(SELL_DATE,'DY'),DRUG_NAME;
--제약사, 월별 판매 개수 총합을 조회, 단 판매개수가 건당 30이상인 데이터만 대상으로 잡음
SELECT DRUG_MAKER, TO_CHAR(SELL_DATE,'MM'), SUM(SELL_EA) 
FROM DRUG_SELL
WHERE SELL_EA >= 30
GROUP BY DRUG_MAKER, TO_CHAR(SELL_DATE,'MM');
-----------------------------------------------------------------
----조인(Join)
-----------------------------------------------------------------
CREATE TABLE TABLE_A(
	CODE CHAR(1),
	NUM NUMBER(1)
);
CREATE TABLE TABLE_B(
	CODE CHAR(1),
	VAL CHAR(1)
);

insert into table_a values('A',1);
insert into table_a values('B',2);
insert into table_a values('C',3);
insert into table_a values('F',5);

insert into table_b values('A','+');
insert into table_b values('B','-');
insert into table_b values('C','*');
insert into table_b values('D','$');
insert into table_b values('E','#');

--동일 조인
SELECT A.CODE, A.NUM, B.VAL
FROM TABLE_A A, TABLE_B B
WHERE A.CODE = B.CODE;

--자연 조인
SELECT * FROM TABLE_A NATURAL JOIN TABLE_B;

--교차 조인
SELECT * FROM TABLE_A CROSS JOIN TABLE_B;

--외부 조인
--LEFT JOIN
SELECT A.*, B.*
FROM TABLE_A A, TABLE_B B
WHERE A.CODE = B.CODE(+);
--RIGHT JOIN
SELECT A.*, B.*
FROM TABLE_A A, TABLE_B B
WHERE A.CODE(+) = B.CODE;

--불일치 쿼리
--두 테이블간 조인으로 조회시 일치하지 않는 데이터를 조회하는 것을 불일치 쿼리
SELECT A.*, B.*
FROM TABLE_A A, TABLE_B B
WHERE A.CODE = B.CODE(+) AND B.CODE IS NULL;

SELECT A.*, B.*
FROM TABLE_A A, TABLE_B B
WHERE A.CODE(+) = B.CODE AND A.CODE IS NULL;

--학생 테이블을 이용해서 조인을 연습
--학과 테이블 작성
--학과명을 학생 테이블에서 저장된 데이터를 가져와서 생성
--1. 학생 테이블에서 학과명만 조회, 단 학과명은 중복된 데이터를 제거
SELECT DISTINCT STD_MAJOR FROM STUDENT;
--2. 1번 작업 결과에서 행번호를 붙여서 조회
SELECT ROWNUM AS MAJOR_NO, STD_MAJOR AS MAJOR_NAME
FROM (SELECT DISTINCT STD_MAJOR FROM STUDENT);

CREATE TABLE MAJOR
AS
SELECT ROWNUM AS MAJOR_NO, STD_MAJOR AS MAJOR_NAME
FROM (SELECT DISTINCT STD_MAJOR FROM STUDENT);
--3. 학생 테이블에 학과번호 컬럼을 추가
ALTER TABLE STUDENT ADD MAJOR_NO NUMBER DEFAULT 0;
--4. 학생 테이블에 학과 번호를 학과 테이블에서 학과명으로 검색해서 조회된 학과번호를 업데이트
UPDATE STUDENT 
SET MAJOR_NO = 
(SELECT MAJOR_NO FROM MAJOR WHERE MAJOR_NAME = STD_MAJOR);
--5. 학생테이블에 있는 학과명 컬럼을 삭제
ALTER TABLE STUDENT DROP COLUMN STD_MAJOR;

--장학금 테이블
CREATE TABLE STUDENT_SCHOLARSHIP(
    SCHOLARSHIP_NO NUMBER,
    STD_NO CHAR(8),
    MONEY NUMBER);
   
--학생 테이블, 학과 테이블을 이용해서 전체 테이블 내용을 조회
--학번, 이름, 학과명, 평점 -> 동일 조인 이용
SELECT s.STD_NO , s.STD_NAME , m.MAJOR_NAME , s.STD_SCORE 
FROM STUDENT s , MAJOR m 
WHERE s.MAJOR_NO = m.MAJOR_NO ;



