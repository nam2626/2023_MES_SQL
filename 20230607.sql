--외부 조인
--학생정보 조회시 학번, 이름, 학과명, 평점 조회 --> 일치하는 학과번호가 없어도 조회
SELECT S.STD_NO, S.STD_NAME, S.STD_SCORE, M.MAJOR_NAME 
FROM STUDENT S , MAJOR M 
WHERE S.MAJOR_NO = M.MAJOR_NO(+);

--일치하지 않는 학과번호를 가지고 있는 학생 정보만 조회 - 학번, 이름, 평점 조회
SELECT S.STD_NO, S.STD_NAME, S.STD_SCORE
FROM STUDENT S , MAJOR M 
WHERE S.MAJOR_NO = M.MAJOR_NO(+) AND M.MAJOR_NO IS NULL;

--NVL 함수 : 해당 컬럼 값이 NULL일 때 나타낼 값, NULL이 아니면 저장되어 있는 값을 조회
SELECT NVL(NULL,'널값입니다.'), NULL FROM DUAL; 
--일치하지 않는 학과번호를 가지고 있는 학생 정보만 조회 - 학번, 이름, 평점, 학과명 조회
--일치하지 않는 학과명은 '학과번호가 잘못되었습니다' 라고 조회
SELECT S.STD_NO, S.STD_NAME, S.STD_SCORE,
		NVL(M.MAJOR_NAME, '학과번호가 잘못되었습니다.')
FROM STUDENT S , MAJOR M 
WHERE S.MAJOR_NO = M.MAJOR_NO(+) AND M.MAJOR_NO IS NULL;

--학생들중 장학금을 받는 학생들의 정보를 조회
--학번 이름 평점 학과명 장학금 금액
SELECT S.STD_NO, S.STD_NAME, S.STD_SCORE, M.MAJOR_NAME, SS.MONEY
FROM STUDENT S, MAJOR M, STUDENT_SCHOLARSHIP SS 
WHERE S.MAJOR_NO = M.MAJOR_NO(+) AND S.STD_NO = SS.STD_NO;

--학생들중 장학금을 못받는 학생들의 정보를 조회
--학번 이름 학과 평점 조회
SELECT S.STD_NO, S.STD_NAME, S.STD_SCORE, M.MAJOR_NAME
FROM STUDENT S, MAJOR M, STUDENT_SCHOLARSHIP SS 
WHERE S.MAJOR_NO = M.MAJOR_NO(+) AND S.STD_NO = SS.STD_NO(+)
AND SS.MONEY IS NULL;

--학과명, 평점의 평균(소수 2자리)
--단, 학과번호가 일치하지 않는 학과명은 학과코드 오류로 조회
SELECT NVL(M.MAJOR_NAME,'학과코드 오류'), TRUNC(AVG(S.STD_SCORE),2)
FROM STUDENT S, MAJOR M
WHERE S.MAJOR_NO = M.MAJOR_NO(+)
GROUP BY NVL(M.MAJOR_NAME,'학과코드 오류'); 

--장학금을 받는 학생들을 기준으로 학과별 인원수를 조회
--학과명, 인원수 --> 학과 번호가 일치하지 않는 학과명은 '학과코드 오류'로 대체
SELECT NVL(M.MAJOR_NAME,'학과코드 오류'), COUNT(*)
FROM STUDENT s , MAJOR m , STUDENT_SCHOLARSHIP ss 
WHERE S.STD_NO = SS.STD_NO AND S.MAJOR_NO = M.MAJOR_NO(+)
GROUP BY NVL(M.MAJOR_NAME,'학과코드 오류')
ORDER BY COUNT(*) DESC;

--학과별 제적 대상자를 인원수를 조회
--점수가 1.5 미만인 대상자들이 제적 대상자
--단, 학과번호가 일치하지 않는 학과명은 학과코드 오류로 조회
--학과명, 제적대상자 인원수, 정렬은 제적대상자 인원수가 높은 순서대로 조회
SELECT NVL(M.MAJOR_NAME,'학과코드 오류'), COUNT(*)
FROM STUDENT S, MAJOR M
WHERE S.MAJOR_NO = M.MAJOR_NO(+) AND S.STD_SCORE < 1.5
GROUP BY NVL(M.MAJOR_NAME,'학과코드 오류')
ORDER BY COUNT(*) DESC;
----------------------------------------------------------
-----서브 쿼리
----------------------------------------------------------
--학생 정보 조회
--학번 이름 학과명 평점
SELECT S.STD_NO, S.STD_NAME, S.STD_SCORE, 
(SELECT M.MAJOR_NAME FROM MAJOR M WHERE S.MAJOR_NO = M.MAJOR_NO)
FROM STUDENT S;

--학생정보 출력시 학과번호가 일치하지 않는 학생을 조회
SELECT * FROM STUDENT S
WHERE S.MAJOR_NO IN(SELECT M.MAJOR_NO FROM MAJOR M);

SELECT * FROM STUDENT S
WHERE S.MAJOR_NO NOT IN(SELECT M.MAJOR_NO FROM MAJOR M);

--학생정보 출력시 학번, 이름, 학과명, 평점, 학과명이 공학이 포함된 정보만 조회
--서브쿼리
SELECT S.STD_NO, S.STD_NAME, S.STD_SCORE,
(SELECT M.MAJOR_NAME FROM MAJOR M WHERE S.MAJOR_NO = M.MAJOR_NO)
FROM STUDENT S
WHERE S.MAJOR_NO IN(
SELECT M.MAJOR_NO FROM MAJOR M WHERE M.MAJOR_NAME LIKE '%공학%' );
--조인
SELECT S.STD_NO, S.STD_NAME, S.STD_SCORE, M.MAJOR_NAME 
FROM STUDENT S, MAJOR M
WHERE S.MAJOR_NO = M.MAJOR_NO(+) AND M.MAJOR_NAME LIKE '%공학%'; 

SELECT * 
FROM (
 SELECT S.STD_NO, S.STD_NAME, M.MAJOR_NAME, S.STD_SCORE 
 FROM STUDENT S, MAJOR M
 WHERE S.MAJOR_NO = M.MAJOR_NO(+)
)
WHERE MAJOR_NAME LIKE '%공학%';

--학생 테이블에 있는 모든 학생 정보를 조회
--단 전체 평점의 평균 이하인 학생들을 조회
SELECT * FROM STUDENT
WHERE STD_SCORE <= (SELECT AVG(STD_SCORE) FROM STUDENT);

--위에 결과를 LOW_STUDENT라는 테이블로 생성해서 데이터를 저장
CREATE TABLE LOW_STUDENT
AS
SELECT * FROM STUDENT
WHERE STD_SCORE <= (SELECT AVG(STD_SCORE) FROM STUDENT);

--장학금을 받는 학생들을 조회 (서브쿼리 이용해서 조회)
SELECT * FROM STUDENT
WHERE STD_NO IN(SELECT STD_NO FROM STUDENT_SCHOLARSHIP);
--학생들중 장학금을 못받는 학생들의 정보를 조회
--학번 이름 학과명 평점 조회
SELECT S.STD_NO, S.STD_NAME, S.STD_SCORE, M.MAJOR_NAME
FROM STUDENT S, MAJOR M
WHERE S.MAJOR_NO = M.MAJOR_NO(+) 
AND S.STD_NO NOT IN(SELECT SS.STD_NO FROM STUDENT_SCHOLARSHIP SS);

--학생들중 장학금을 못받는 학생들의 정보를 조회
--학과별 인원수를 출력 --> 학과명, 인원수
SELECT M.MAJOR_NAME, COUNT(*)
FROM STUDENT S, MAJOR M
WHERE S.MAJOR_NO = M.MAJOR_NO(+) 
AND S.STD_NO NOT IN(SELECT SS.STD_NO FROM STUDENT_SCHOLARSHIP SS)
GROUP BY M.MAJOR_NAME;









