--오라클함수
--1. 문자처리함수
--LENGTH, LENGTHB(길이구함), SUBSTR(문자자름), INSTR(위치구함)
--LPAD, RPAD(채우는거), LTRIM, RTRIM

--@실습문제 
-- 다음문자열에서 앞뒤 모든 숫자를 제거하세요.
-- '982341678934509hello89798739273402'
SELECT RTRIM(LTRIM('982341678934509hello89798739273402', '0123456789'),'0123456789')
FROM DUAL;

--@실습문제
--사원명에서 성만 중복없이 사전순으로 출력하세요.
SELECT SUBSTR(EMP_NAME,1,1) "EMP_NAME"
FROM EMPLOYEE
ORDER BY EMP_NAME ASC;
--중복없이 출력하기
SELECT DISTINCT SUBSTR(EMP_NAME,1,1) "EMP_NAME"
FROM EMPLOYEE
ORDER BY EMP_NAME ASC;

-- @실습문제
-- employee 테이블에서 남자만 사원번호, 사원명, 주민번호, 연봉을 나타내세요.
-- 주민번호의 뒷6자리는 *처리하세요.
SELECT EMP_ID, EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*'), SALARY*12
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '1';

--SELECT EMP_ID, EMP_NAME, SUBSTR(EMP_NO,1,8)||'******', SALARY*12
SELECT EMP_ID, EMP_NAME, CONCAT(SUBSTR(EMP_NO,1,8),'******'), SALARY*12
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '1';

--2. 숫자처리함수
--@실습문제
--EMPLOYEE 테이블에서 이름, 근무 일수를 출력해보시오 
--(SYSDATE를 사용하면 현재 시간 출력)
SELECT EMP_NAME, SYSDATE-HIRE_DATE, FLOOR(SYSDATE-HIRE_DATE), ROUND(SYSDATE-HIRE_DATE)
FROM EMPLOYEE;

--3. 날짜처리함수
--@실습문제
--EMPLOYEE테이블에서 사원의 이름, 입사일, 입사 후 3개월이 된 날짜를 조회하시오
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3)
FROM EMPLOYEE;
--@실습문제
--EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무 개월수를 조회하시오
SELECT EMP_NAME, HIRE_DATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))"PERIOD"
FROM EMPLOYEE;
--@실습문제
--ex) EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사월의 마지막날을 조회하세요
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;
--@실습문제
--ex) EMPLOYEE 테이블에서 사원 이름, 입사 년도, 입사 월, 입사 일을 조회하시오
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE)||'년'"입사 년도", EXTRACT(MONTH FROM HIRE_DATE)||'월'"입사 월", EXTRACT(DAY FROM HIRE_DATE)||'일'"입사 일"
FROM EMPLOYEE;

--@실습문제
/*
     오늘부로 일용자씨가 군대에 끌려갑니다.
     군복무 기간이 1년 6개월을 한다라고 가정하면
     첫번째,제대일자를 구하시고,
     두번째,제대일자까지 먹어야할 짬밥의 그릇수를 구합니다.
     (단, 1일 3끼를 먹는다고 한다.)
*/
SELECT ADD_MONTHS(SYSDATE, 18)"제대일자", (ADD_MONTHS(SYSDATE, 18)-SYSDATE)*3 "짬밥수"
FROM DUAL;
--4. 형변환함수



-- @함수 최종실습문제
--1. 직원명과 이메일, 이메일 길이를 출력하시오
--	ex)  홍길동 , hong@kh.or.kr   	  13
SELECT EMP_NAME "직원명", EMAIL "이메일", LENGTH(EMAIL) "이메일 길이"
FROM EMPLOYEE;
--이메일의 길이가 15보다 적은 데이터를 검색해보시오
SELECT *
FROM EMPLOYEE
WHERE LENGTH(EMAIL) < 15;

--2. 직원의 이름과 이메일 주소 중 아이디 부분만 출력하시오
--	ex) 노옹철	no_hc
--	ex) 정중하	jung_jh
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL,'@',-1,1)) 
FROM EMPLOYEE;
SELECT EMAIL, INSTR(EMAIL,'@',1,1)
FROM EMPLOYEE;

--3. 60년대에 태어난 직원명과 년생, 보너스 값을 출력하시오. 
--그때 보너스 값이 null인 경우에는 0 이라고 출력 되게 만드시오
--	    직원명    년생      보너스
--	ex) 선동일	    1962	    0.3
--	ex) 송은희	    1963  	    0
SELECT TO_DATE(SUBSTR(EMP_NO,1,2),'RR') FROM EMPLOYEE;
SELECT EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) FROM EMPLOYEE;

SELECT EMP_NAME"직원명", '19'||SUBSTR(EMP_NO,1,2)"년생" , NVL(BONUS,0)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 1, 1)=6;

--다시보기
--4. '010' 핸드폰 번호를 쓰지 않는 사람의 수를 출력하시오 (뒤에 단위는 명을 붙이시오)
--	   인원
--	ex) 3명
SELECT EMP_NAME
FROM EMPLOYEE;
WHERE PHONE;
--미해결

--5. 직원명과 입사년월을 출력하시오 
--	단, 아래와 같이 출력되도록 만들어 보시오
--	    직원명		입사년월
--	ex) 전형돈		2012년 12월
--	ex) 전지연		1997년 3월
SELECT EMP_NAME"직원명", EXTRACT(YEAR FROM HIRE_DATE)||'년 '||EXTRACT(MONTH FROM HIRE_DATE)||'월' "입사년월"
FROM EMPLOYEE;

--6. 직원명과 주민번호를 조회하시오
--	단, 주민번호 9번째 자리부터 끝까지는 '*' 문자로 채워서출력 하시오
--	ex) 홍길동 771120-1******
SELECT EMP_NAME"직원명", SUBSTR(EMP_NO,1,8)||'******'"주민번호"
FROM EMPLOYEE;

--다시보기
--7. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
SELECT EMP_NAME"직원명", JOB_CODE"직급코드", TO_CHAR((SALARY*12+(SALARY*NVL(BONUS,0))),'L999,999,999')"연봉", NVL(BONUS,0)
FROM EMPLOYEE;


--8. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원중에 조회함.
--   사번 사원명 부서코드 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D9') AND EXTRACT(YEAR FROM HIRE_DATE)=2004;

--9. 직원명, 입사일, 오늘까지의 근무일수 조회 
--	* 주말도 포함 , 소수점 아래는 버림
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE-HIRE_DATE)
FROM EMPLOYEE;

--다시보기
--10. 직원명, 부서코드, 생년월일, 나이(만) 조회
--   단, 생년월일은 주민번호에서 추출해서, 
--   ㅇㅇㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--   나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
--	* 주민번호가 이상한 사람들은 제외시키고 진행 하도록(200,201,214 번 제외)
--	* HINT : NOT IN 사용
SELECT TO_CHAR(TO_DATE('19'||EMP_NO),'YYYY"년" MM"월" DD"일"') FROM EMPLOYEE;
SELECT EMP_NAME, DEPT_CODE, '19'||SUBSTR(EMP_NO,1,2)||'년 ' ||SUBSTR(EMP_NO,3,2)||'월 '||SUBSTR(EMP_NO,5,2)||'일' "생년월일",
--문자처리함수
EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR'))||'년 '||
EXTRACT(MONTH FROM TO_DATE(SUBSTR(EMP_NO,3,2),'MM'))||'월 '||
EXTRACT(DAY FROM TO_DATE(SUBSTR(EMP_NO,5,2),'DD'))||'일'"생년월일2",
--날짜처리함수
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) AS "나이(만)",
--날짜처리함수
EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(EMP_NO,1,2))) AS 나이,
--문자처리함수
EXTRACT(YEAR FROM SYSDATE) - (DECODE(SUBSTR(EMP_NO,8,1),'1',1900,'2',1900,'3',2000,'4',2000) + TO_NUMBER(SUBSTR(EMP_NO,1,2))) AS 나이2
FROM EMPLOYEE
WHERE EMP_ID NOT IN(200, 201, 214);
--나이조회부터 다시하기

--11. 사원명과, 부서명을 출력하세요.
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회하고, 부서코드 기준으로 오름차순 정렬함.
SELECT EMP_NAME"사원명",
DECODE(DEPT_CODE,'D5','총무부','D6','기획부','D9','영업부') "부서명"
--CASE WHEN DEPT_CODE = 'D5' THEN '총무부'
  --  WHEN DEPT_CODE = 'D6' THEN '기획부'
    --WHEN DEPT_CODE = 'D9' THEN '영업부' END "부서명"
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D9')
ORDER BY DEPT_CODE ASC;

------------------------------------------------------------------------------------
-- 최종 실습 문제
-- 문제1. 
-- 입사일이 5년 이상, 10년 이하인 직원의 이름,주민번호,급여,입사일을 검색하여라
SELECT EMP_NAME AS 이름, EMP_NO AS 주민번호, SALARY AS 급여, HIRE_DATE AS 입사일
FROM EMPLOYEE
WHERE CEIL((SYSDATE-HIRE_DATE)/365) BETWEEN 5 AND 10;

-- 문제2.
-- 재직중이 아닌 직원의 이름,부서코드, 고용일, 근무기간, 퇴직일을 검색하여라 
--(퇴사 여부 : ENT_YN)
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE, (ENT_DATE-HIRE_DATE), ENT_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'Y';

-- 문제3.
-- 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수(소수점X)를 근속년수가 오름차순으로 정렬하여 출력하여라
-- 단, 급여는 50% 인상된 급여로 출력되도록 하여라.
SELECT EMP_NAME, SALARY*1.5, CEIL((SYSDATE-HIRE_DATE)/365)"근속년수"
FROM EMPLOYEE
--WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) >= 10
WHERE CEIL((SYSDATE-HIRE_DATE)/365) >=10
ORDER BY 3 ASC;

-- 문제4.
-- 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 검색 하시오
SELECT EMP_NAME, EMAIL, PHONE, SALARY
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '99/01/01' AND '10/01/01' AND SALARY <= 2000000;

-- 문제5.
-- 급여가 2000000원 ~ 3000000원 인 여직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 출력하여라
-- 단, 부서코드가 null인 사람은 부서코드가 '없음' 으로 출력 하여라.
SELECT EMP_NAME, EMP_NO, SALARY, NVL(DEPT_CODE,'없음')
FROM EMPLOYEE
WHERE (SALARY BETWEEN 2000000 AND 3000000)  
--AND (SUBSTR(EMP_NO,8,1) = 2)AND (SUBSTR(EMP_NO,4,1) = 4)
AND EMP_NO LIKE '__04__-2%'
ORDER BY EMP_NO DESC;

-- 문제6.
-- 남자 사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 
-- 1000일 마다(소수점 제외) 
-- 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 출력하여라.
-- 단, 이름 순으로 오름 차순 정렬하여 출력하여라.
SELECT EMP_NAME, FLOOR(SYSDATE-HIRE_DATE), SUBSTR(FLOOR(SYSDATE-HIRE_DATE),-4,1)*SALARY*0.1 "특별 보너스"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1)=1 AND BONUS IS NULL
ORDER BY EMP_NAME ASC;