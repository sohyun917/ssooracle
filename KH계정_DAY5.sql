--ORACLE DAY05
--그룹함수
--여러개의 값이 들어가서 한 행의 결과만 나오는 함수
--SUM, AVG, COUNT, MAX, MIN

--@실습예제
--1. [EMPLOYEE] 테이블에서 남자 사원의 급여 총 합을 계산
SELECT TO_CHAR(SUM(SALARY),'L999,999,999,999')"급여 총 합"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

--2. [EMPLOYEE]테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉을 계산
SELECT TO_CHAR(SUM(SALARY*12 + SALARY*NVL(BONUS,0)),'L999,999,999,999')"보너스 포함 연봉"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--3. [EMOLOYEE]테이블에서 전 사원의 보너스 평균을 소수 둘째자리에서 반올림하여 구하여라
SELECT ROUND(AVG(NVL(BONUS,0)),2)
FROM EMPLOYEE;

--4. [EMPLOYEE] 테이블에서 D5 부서에 속해 있는 사원의 수를 조회
SELECT COUNT(EMP_NAME)"사원의 수"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--EX) EMPLOYEE 테이블에 저장된 데이터의 수를 구하시오
SELECT COUNT(*) --속도가 가장 빠름
FROM EMPLOYEE;

--5. [EMPLOYEE] 테이블에서 사원들이 속해있는 부서의 수를 조회 (NULL은 제외됨)
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

--6. [EMPLOYEE] 테이블에서 사원 중 가장 높은 급여와 가장 낮은 급여를 조회
SELECT TO_CHAR(MAX(SALARY),'L999,999,999,999')"최대", TO_CHAR(MIN(SALARY),'L999,999,999,999')"최소"
FROM EMPLOYEE;

--7. [EMPLOYEE] 테이블에서 가장 오래된 입사일과 가장 최근 입사일을 조회하시오
SELECT MAX(HIRE_DATE)"최근 입사일", MIN(HIRE_DATE)"오래된 입사일"
FROM EMPLOYEE;

--#GROUP BY 절
--별도의 그룹 지정없이 사용한 그룹함수는 단 한개의 결과값만 산출하기 때문에
--그룹함수를 이용하여 여러개의 결과값을 산출하기 위해서는
--그룹함수가 적용될 그룹의 기준을 GROUP BY절에 기술하여 사용해야함.
--EX) 부서별로 급여합을 구하고싶다
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE;

--EX) 직급별로 급여합 구하기
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

--[EMPLOYEE] 테이블에서 부서코드 그룹별 급여의 합계, 그룹별 급여의 평균(정수처리),
--인원수를 조회하고, 부서코드 순으로 정렬
SELECT DEPT_CODE"부서코드", TO_CHAR(SUM(SALARY),'L999,999,999')"합계", TO_CHAR(ROUND(AVG(SALARY)),'L999,999,999')"평균", COUNT(*)"인원수"
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--[EMPLOYEE] 테이블에서 부서코드 그룹별, 보너스를 지급받는 사원 수를 조회하고 
--부서코드 순으로 정렬. BONUS컬럼의 값이 존재한다면, 그 행을 1로 카운팅.
--보너스를 지급받는 사원이 없는 부서도 있음.
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--@실습문제
--1. EMPLOYEE 테이블에서 직급이 J1을 제외하고, 직급별 사원수 및 평균급여를 출력하세요.
SELECT JOB_CODE"직급코드",COUNT(EMP_NAME)"직급별 사원수", TO_CHAR(ROUND(AVG(SALARY)),'L999,999,999,999')"평균급여"
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

--2. EMPLOYEE테이블에서 직급이 J1을 제외하고,  
--입사년도별 인원수를 조회해서, 입사년 기준으로 오름차순 정렬하세요.
SELECT EXTRACT(YEAR FROM HIRE_DATE)"입사년도", COUNT(EMP_NAME)"인원수"
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
ORDER BY EXTRACT(YEAR FROM HIRE_DATE) ASC;

--3. [EMPLOYEE] 테이블에서 EMP_NO의 8번째 자리가 1, 3 이면 '남', 
--2, 4 이면 '여'로 결과를 조회하고,
-- 성별별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 
--인원수로 내림차순을 정렬 하시오
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남','3','남','2','여','4','여')"성별",
ROUND(AVG(SALARY))"평균", SUM(SALARY)"급여합계", COUNT(EMP_NAME)"인원수"
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','남','3','남','2','여','4','여')
ORDER BY COUNT(EMP_NAME) DESC;

--4. 부서내 성별 인원수를 구하세요.
SELECT DEPT_CODE"부서코드", COUNT(EMP_NAME)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
--미해결

--5. 부서별 급여 평균이 3,000,000원(버림적용) 이상인  부서들에 대해서 
--부서명, 급여평균을 출력하세요.
SELECT DEPT_CODE, AVG(SALARY)"평균"
FROM EMPLOYEE
GROUP BY DEPT_CODE
WHERE (평균 >= 3000000);
--미해결
