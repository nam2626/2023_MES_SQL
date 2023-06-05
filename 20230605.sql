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





