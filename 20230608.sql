--인덱스 생성 예제
CREATE INDEX CAR_SELL_IDX
ON CAR_SELL(CAR_NO);

--인덱스 삭제
DROP INDEX CAR_SELL_IDX;

--인덱스 리빌딩
ALTER INDEX CAR_SELL_IDX REBUILD;

--사용자가 만든 개체 조회
SELECT * FROM USER_OBJECTS;
--사용자가 만든 테이블
SELECT * FROM USER_TABLES;
--사용자가 만든 인덱스
SELECT * FROM USER_INDEXES;
--사용자가 만든 제약조건
SELECT * FROM USER_CONSTRAINTS;

--시퀸스
CREATE SEQUENCE MEMBER_ROW_SEQ;
--번호 발급
SELECT MEMBER_ROW_SEQ.NEXTVAL FROM DUAL;
--마지막에 뽑은 번호를 확인
SELECT MEMBER_ROW_SEQ.CURRVAL FROM DUAL;
--시퀸스 삭제
DROP SEQUENCE MEMBER_ROW_SEQ;

--시작값 100, 최대값 120, 최소값 100, 증가값 1, 순환
CREATE SEQUENCE TEST_SEQ
START WITH 100
MAXVALUE 120
MINVALUE 100
INCREMENT BY 1
NOCYCLE ;

DROP SEQUENCE TEST_SEQ;

SELECT TEST_SEQ.NEXTVAL FROM DUAL;

--CAR_SELL 테이블에 판매 번호로 사용할 시퀸스를 작성
--1증가, 순환 X, 현재 저장된값 기준으로 생성
SELECT MAX(car_sell_no) FROM car_sell;

CREATE SEQUENCE car_sell_seq
START WITH 4001
INCREMENT BY 1
NOMAXVALUE
NOCYCLE;

--CAR_SELL 테이블에 데이터 5건 저장 - SEQUENCE와 INSERT 문으로 저장
INSERT INTO CAR_SELL 
VALUES(CAR_SELL_SEQ.NEXTVAL, 'xg8606iy', SYSDATE, 30, 
(SELECT CAR_PRICE FROM CAR WHERE CAR_NO = 'xg8606iy') * 30);

--사용자 생성
CREATE USER 아이디 IDENTIFIED BY 암호;
--권한 부여 : RESOURCE(개체 생성 수정 삭제), CONNECT(접속), DBA(DB 관리자 권한)
--		   CREATE VIEW(뷰 생성 / 삭제 권한)
GRANT 권한... TO 사용자;
GRANT CREATE VIEW TO SCOTT;
--권한을 회수
REVOKE 권한.... FROM 사용자;

--VIEW
--학생정보 조회, 평점이 평균 이상인 학생만 조회
--학번 이름 학과명 평점
CREATE VIEW AVG_UP_STUDENT_VIEW
AS
SELECT S.STD_NO, S.STD_NAME, S.STD_SCORE, M.MAJOR_NAME
FROM STUDENT S, MAJOR M
WHERE S.MAJOR_NO = M.MAJOR_NO
AND S.STD_SCORE >= (SELECT AVG(STD_SCORE) FROM STUDENT);

SELECT * FROM AVG_UP_STUDENT_VIEW;

--평점이 평균 이상인 학생들을 기준으로 학과별 인원수를 출력
SELECT MAJOR_NAME, COUNT(*)
FROM AVG_UP_STUDENT_VIEW GROUP BY MAJOR_NAME;

--자동차 판매 테이블, 자동차 테이블, 자동차 제조사 테이블
--판매번호, 자동차 이름, 자동차 제조사 이름, 판매일, 판매개수, 판매금액(CAR_SELL)
CREATE OR REPLACE VIEW CAR_SELL_VIEW
AS
SELECT CS.CAR_SELL_NO, C.CAR_NAME, CS.CAR_SELL_DATE,
CM.CAR_MAKER_NAME, CS.CAR_SELL_EA, CS.CAR_SELL_PRICE 
FROM CAR C, CAR_MAKER CM, CAR_SELL CS
WHERE C.CAR_MAKER_NO = CM.CAR_MAKER_NO AND C.CAR_NO = CS.CAR_NO;

--월별 최다 판매 차량 대수를 조회








