CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

DESC USER_GRADE;

INSERT INTO USER_GRADE
VALUES(10, '일반회원');
INSERT INTO USER_GRADE
VALUES(20, '우수회원');
INSERT INTO USER_GRADE
VALUES(30, '특별회원');

--여기서부터 자식작업
CREATE TABLE USER_FOREIGNKEY(
    USER_NO NUMBER CONSTRAINT USER_NO_PK PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER CONSTRAINT GRADE_CODE_FK REFERENCES USER_GRADE(GRADE_CODE)
);

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'USER_FOREIGNKEY';

INSERT INTO USER_FOREIGNKEY
VALUES(1, 'user01', 'pass01','일용자', '남', 'user01@iei.com', 10);
INSERT INTO USER_FOREIGNKEY
VALUES(2, 'user02', 'pass02','이용자', '남', 'user02@iei.com', 20);
INSERT INTO USER_FOREIGNKEY
VALUES(3, 'user03', 'pass03','삼용자', '남', 'user03@iei.com', 30);
INSERT INTO USER_FOREIGNKEY
VALUES(4, 'user04', 'pass04','사용자', '남', 'user04@iei.com', 40);
SELECT GRADE_CODE, GRADE_NAME FROM USER_GRADE;

SELECT EMP_NAME, SALARY, SALARY*12 "연봉(보너스 미포함)", BONUS, (SALARY*BONUS + SALARY*12) AS "연봉(보너스 포함)"
FROM EMPLOYEE
WHERE SALARY > 3000000 AND EMP_NAME = '선동일';

--SALARY를 기준으로 오름차순정렬(ASC)
--SALARY를 기준으로 내림차순정렬(DESC)
--NULL을 포함하는 컬럼정렬?
--ASC일때 NULL은 맨 아래에, DESC일때 NULL은 맨 위에
SELECT EMP_NAME, SALARY, SALARY*12 "연봉(보너스 미포함)", BONUS, (SALARY*BONUS + SALARY*12) AS "연봉(보너스 포함)"
FROM EMPLOYEE
WHERE SALARY > 3000000 OR EMP_NAME = '선동일'
ORDER BY BONUS ASC;
--FROM -> WHERE -> SELECT -> ORDER BY
--ORDER BY는 맨 마지막에 실행된다.

--BETWEEN A AND B, 비교연산자
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SALARY > 2000000 AND SALARY < 6000000;
WHERE SALARY BETWEEN 2000000 AND 6000000;

--OR를 대신하는 연산자
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8';
WHERE DEPT_CODE IN('D6', 'D8');

--IS NULL / IS NOT NULL연산자(NULL값인 애들만 OR NULL값이 아닌 애들만)
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

--LIKE연산자
--전씨 성을 가진 직원의 이름과 급여를 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

--EMPLOYEE테이블에서 이름의 끝이 연으로 끝나는 사원의 이름을 출력하시오.
--와일드카드
--1. % : 0개 이상의 모든 문자를 매칭
--2. _(언더바) : 하나의 자리에 해당하는 모든 문자를 매칭
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '__연';


-- 실습문제
--1. EMPLOYEE 테이블에서 이름 끝이 연으로 끝나는 사원의 이름을 출력하시오
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

--2. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를
--출력하시오
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--3. EMPLOYEE 테이블에서 메일주소의 's'가 들어가면서, DEPT_CODE가 D9 또는 D6이고
--고용일이 90/01/01 ~ 01/12/01이면서, 월급이 270만원이상인 사원의 전체 정보를 출력하시오
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '%s%' 
AND DEPT_CODE IN ('D9', 'D6') 
AND HIRE_DATE BETWEEN '90/01/01' AND '01/12/01'
AND SALARY >= 2700000;

--4. EMPLOYEE 테이블에서 EMAIL ID 중 @ 앞자리가 5자리인 직원을 조회한다면?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';

--5. EMPLOYEE 테이블에서 EMAIL ID 중 '_' 앞자리가 3자리인 직원을 조회한다면?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
--미해결

--6. 관리자(MANAGER_ID)도 없고 부서 배치(DEPT_CODE)도 받지 않은  직원의 이름 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--7. 부서배치를 받지 않았지만 보너스를 지급하는 직원 전체 정보 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
