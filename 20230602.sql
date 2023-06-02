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
UPDATE STUDENT SET STD_SCORE = STD_SCORE + 0.5
WHERE STD_SCORE < 1;


--학생 테이블에서 평짐이 1점 미만인 학생들의 이름을 제적으로 수정
UPDATE STUDENT SET STD_NAME = '제적'
WHERE STD_SCORE < 1;

--사원 테이블에서 직급이 사원인 직원들의 급여를 100씩 차감
UPDATE EMPLOYEE SET EMP_SALARY = EMP_SALARY - 100
WHERE EMP_POSITION = '사원';

--삭제
DELETE FROM HUMAN;
--학생 테이블에서 학생 이름이 '제적'인 학생을 전부 삭제
DELETE FROM STUDENT WHERE STD_NAME = '제적';
DELETE FROM STUDENT WHERE STD_NAME LIKE '제적';

--dual 임시테이블, 값을 확인 하는 용도
SELECT 'Hello' FROM dual;
--문자열 함수
--INITCAP : 각 단어별 첫글자만 대문자로 변경
SELECT INITCAP('hello') FROM dual;
SELECT INITCAP('hello hello') FROM dual;
--LOWER : 알파벳 모두 소문자로 변경
--UPPER : 알파벳 모두 대문자로 변경
select LOWER('Hello World'), UPPER('Hello World') from dual;
--LENGTH : 글자 개수를 구하는 함수
--LENGTHB : 글자 바이트수 구하는 함수
select LENGTH('HELLO'), LENGTH('안녕하세요') from dual;
select LENGTHB('HELLO'), LENGTHB('안녕하세요') from dual;
--CONCAT : 두 문자열을 하나로 합치기
select CONCAT('Hello','World') from dual;
--전화번호 데이터가 '010' '1111' '1234'를 CONCAT 함수를 이용해서 하나의 문자열로 합치기
SELECT CONCAT('010',CONCAT('1111','1234')) FROM dual; 
--문자열 붙이는 연산자 ||
select '010' || '1111' || '1234' from dual;
SELECT std_no || std_name || std_major || std_score FROM STUDENT;

SELECT * FROM user_tables;
--전체 테이블 삭제하기 위해 drop table 테이블명; --> 모든 테이블의 drop문을 조회를 이용해서 작성
SELECT 'drop table ' || TABLE_NAME || ';' FROM USER_TABLES;
--문자열 추출
--SUBSTR : 문자열 부분 추출(문자 기준으로 추출)
select substr('1234567890', 5,4) from dual;
select substr('안녕하세요',2,3) from dual;
--주민등록번호 '841113-1246121' --> '841113-1******' 마스킹 처리
SELECT SUBSTR('841113-1246121',1,8) || '******' FROM dual; 
--바이트 단위로 문자열 추출
SELECT SUBSTRB('안녕하세요',2,3) FROM DUAL;
SELECT SUBSTRB('ABCDEFG',2,3) FROM DUAL;
--문자열 검색 INSTR - 검색결과가 있으면 0보다 큰 값, 검색 결과가 없으면 0
select instr('abcdefg','cd') from dual;
select instr('abcdefg','cdf') from dual;
--HELLO WORLD에 공백이 있는지 체크
select instr('HELLO WORLD',' ') from dual;
--테이블 NAME 컬럼에 공백을 넣지 않는 조건
--check(instr(NAME,' ') = 0) -->이런 형태로 테이블의 제약조건에 들어감
--문자열 바꾸기
select replace('AAAAAAABBBBBCCCC','B','F') from dual;
--학생테이블에서 데이터들 중 이름 컬럼에 공백이 있는 학생의 이름을 공백을 '-' 변경하는 업데이트 하시오.
UPDATE STUDENT SET std_name = REPLACE(std_name,' ','-')
WHERE instr(std_name, ' ') != 0;

--LPAD, RPAD --> 원하는 문자열 개수만큼 남은 부분에 지정한 문자열로 채워주는 함수
SELECT RPAD('871211-1',14,'*') FROM DUAL;
SELECT LPAD('871211-1',14,'*') FROM DUAL;
SELECT LPAD('ABC',10,'1234') FROM DUAL;
SELECT RPAD('ABC',10,'1234') FROM DUAL;

--TRIM : 필요없는 좌우 공백을 제거
SELECT TRIM('    A A B     ') FROM DUAL;
SELECT length(TRIM('    A A B     ')) FROM DUAL;

--LTRIM, RTRIM : 좌우에 지정한 문자열을 제거
SELECT LTRIM('AAAABBBBBCCCCCDDDDDDAAAAA','A') FROM DUAL;
SELECT RTRIM('AAAABBBBBCCCCCDDDDDDAAAAA','A') FROM DUAL;
-----------------------------------------------------------------------------------
--ROUND : 원하는 자리수에서 반올림
select round(123.456,-2) from dual;
select round(123.456,-1) from dual;
select round(123.456,0) from dual;
select round(123.456,1) from dual;
select round(123.456,2) from dual;
--TRUNC : 원하는 자리수에서 데이터를 자름
select trunc(123.456,-2) from dual;
select trunc(123.456,-1) from dual;
select trunc(123.456,0) from dual;
select trunc(123.456,1) from dual;
select trunc(123.456,2) from dual;
--올림 : ceil, 내림 : floor
select ceil(123.456), floor(123.456) from dual;
--나머지 나누기
select mod(5, 4) from dual;
--POWER(N,M) : N의 M승
SELECT POWER(2,10) FROM DUAL;
--TO_NUMBER('문자열') : 문자열을 숫자로 바꿔주는 함수
select '123' + 123, TO_NUMBER('123') + 123 from dual;
---------------------------------------------------------
--날짜시간
--현재 날짜 시간 조회
SELECT SYSDATE FROM dual;
--오라클에서 지정된 현재 날짜 시간의 출력 포멧을 변경
ALTER SESSION SET nls_date_format = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET nls_date_format = 'YY/MM/DD';
--오늘 날짜부터 지정날짜까지 남은 개월 수
SELECT abs(MONTHS_BETWEEN(sysdate,'2023-12-31')) FROM dual; 
--지정 날짜로부터 몇 개월 후 날짜
select add_months(sysdate,2) from dual;
--주어진 날짜 기준으로 돌아오는 날짜(원하는 요일)
select next_day(sysdate,'토') from dual;
--주어진 날짜 기준으로 날짜가 속한 달의 마지막 날
select last_day(sysdate) from dual;
--내일 날짜 출력
select sysdate + 1 from dual;
--문자열을 날짜로 변경
SELECT TO_DATE('2022-12-31','YYYY-MM-DD') FROM dual; 
--연말까지 D-DAY 출력
select ceil(to_date('2023-12-31','YYYY-MM-DD') - sysdate) from dual;
--TO_CHAR(데이터, '형식') 문자열로 변환
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'MON MONTH DY DAY') FROM DUAL;




