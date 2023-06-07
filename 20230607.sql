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
SELECT NVL(M.MAJOR_NAME,'학과코드 오류'), S.STD_SCORE
FROM STUDENT S, MAJOR M
WHERE S.MAJOR_NO = M.MAJOR_NO(+);
GROUP BY 


