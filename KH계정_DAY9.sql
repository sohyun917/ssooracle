--@실습문제
--kh계정 소유의 한 employee, job, department테이블의 일부정보를 
--사용자에게 공개하려고 한다.
-- 사원아이디, 사원명, 직급명, 부서명, 관리자명, 입사일의 컬럼정보를 
--뷰(v_emp_info)를 (읽기 전용으로) 생성하여라.
CREATE OR REPLACE VIEW V_EMP_INFO
AS SELECT E.EMP_ID AS 사원아이디, E.EMP_NAME AS 사원명, J.JOB_NAME AS 직급명
, D.DEPT_TITLE AS 부서명, M.EMP_NAME AS 관리자명, E.HIRE_DATE AS 입사일
FROM EMPLOYEE E
LEFT JOIN JOB J USING (JOB_CODE)
LEFT JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID
LEFT JOIN EMPLOYEE M ON M.EMP_ID = E.MANAGER_ID;

DROP VIEW V_EMP_INFO;

-- VIEW 옵션
-- VIEW를 만든 후에 수정해야될 경우 삭제 후 재생성해야함
-- 1. OR REPLACE
--> 생성한 뷰가 존재하면 뷰를 갱신해줌.
-- 2. FORCE/NOFORCE
-- 기본값은 NOFORCE로 지정되어 있음.
CREATE OR REPLACE FORCE VIEW V_FORCE_SOMETHING
AS SELECT EMP_ID, EMP_NO FROM NOTHING_TBL;
-- 3. WITH CHECK OPTION
--> WHERE절 조건에 사용한 컬럼의 값을 수정하지 못하게 함.
CREATE OR REPLACE VIEW V_EMP_D5
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' WITH CHECK OPTION;
ROLLBACK;

UPDATE V_EMP_D5 SET DEPT_CODE = 'D2'
WHERE SALARY >= 2500000;
-- 4. WITH READ ONLY
-- 수정을 방해하는 옵션. 원래 VIEW는 수정이 가능함
CREATE VIEW V_INFO
AS SELECT EMP_NAME, EMP_ID, JOB_CODE
FROM EMPLOYEE
WITH READ ONLY;

--@실습문제
--고객이 상품주문시 사용할 테이블 TBL_ORDER를 만들고, 다음과 같이 컬럼을 구성하세요
-- ORDER_NO(주문NO) : PK
-- USER_ID(고객아이디)
-- PRODUCT_ID(주문상품아이디)
-- PRODUCT_CNT(주문개수) 
-- ORDER_DATE : DEFAULT SYSDATE
CREATE TABLE TBL_ORDER(
    ORDER_NO NUMBER CONSTRAINT ORDER_NO_PK PRIMARY KEY,
    USER_ID VARCHAR2(40),
    PRODUCT_ID VARCHAR2(40),
    PRODUCT_CNT NUMBER,
    ORDER_DATE DATE DEFAULT SYSDATE
);
COMMENT ON COLUMN TBL_ORDER.ORDER_NO IS '주문NO';
COMMENT ON COLUMN TBL_ORDER.USER_ID IS '고객아이디';
COMMENT ON COLUMN TBL_ORDER.PRODUCT_ID IS '주문상품아이디';
COMMENT ON COLUMN TBL_ORDER.PRODUCT_CNT IS '주문개수';

-- ORDER_NO은 시퀀스 SEQ_ORDER_NO을 만들고, 다음 데이터를 추가하세요.(현재시각 기준)
-- * kang님이 saewookkang상품을 5개 주문하셨습니다.
-- * gam님이 gamjakkang상품을 30개 주문하셨습니다.
-- * ring님이 onionring상품을 50개 주문하셨습니다.
CREATE SEQUENCE SEQ_ORDER_NO;
INSERT INTO TBL_ORDER
VALUES(SEQ_ORDER_NO.NEXTVAL, 'kang', 'saewookkang', 5, DEFAULT);
INSERT INTO TBL_ORDER
VALUES(SEQ_ORDER_NO.NEXTVAL, 'gam', 'gamjakkang', 30, DEFAULT);
INSERT INTO TBL_ORDER
VALUES(SEQ_ORDER_NO.NEXTVAL, 'ring', 'onionring', 50, DEFAULT);
COMMIT;

-- 실습문제2
--KH_MEMBER 테이블을 생성
--컬럼
--MEMBER_ID	NUNBER
--MEMBER_NAME	VARCHAR2(20)
--MEMBER_AGE	NUMBER
--MEMBER_JOIN_COM	NUMBER
CREATE TABLE KH_MEMBER(
    MEMBER_ID NUMBER,
    MEMBER_NAME VARCHAR2(20),
    MEMBER_AGE NUMBER,
    MEMBER_JOIN_COM NUMBER
);

--이때 해당 사원들의 정보를 INSERT 해야 함
--ID 값과 JOIN_COM은 SEQUENCE 를 이용하여 정보를 넣고자 함
--ID값은 500 번 부터 시작하여 10씩 증가하여 저장 하고자 함
--JOIN_COM 값은 1번부터 시작하여 1씩 증가하여 저장 해야 함
--(ID 값과 JOIN_COM 값의 MAX는 10000으로 설정)
CREATE SEQUENCE SEQ_KH_MEM_ID
START WITH 500
INCREMENT BY 10
MAXVALUE 10000;

CREATE SEQUENCE SEQ_KH_MEM_COM
MAXVALUE 10000;

--	MEMBER_ID	MEMBER_NAME	 MEMBER_AGE	 MEMBER_JOIN_COM	
--	500		        홍길동		20		        1
--	510		        김말똥		30		        2
--	520		        삼식이		40		        3
--	530		        고길똥		24		        4
INSERT INTO KH_MEMBER
VALUES(SEQ_KH_MEM_ID.NEXTVAL, '홍길동', 20, SEQ_KH_MEM_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES(SEQ_KH_MEM_ID.NEXTVAL, '김말똥', 30, SEQ_KH_MEM_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES(SEQ_KH_MEM_ID.NEXTVAL, '삼식이', 40, SEQ_KH_MEM_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES(SEQ_KH_MEM_ID.NEXTVAL, '고길똥', 24, SEQ_KH_MEM_COM.NEXTVAL);

SELECT * FROM USER_SEQUENCES;
SELECT * FROM USER_VIEWS;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMPLOYEE';
SELECT * FROM USER_TABLES;
-- 데이터 딕셔너리(DD, DATA DICTIONARY)
--> 자원을 효율적으로 관리하기 위한 다양한 정보를 저장하는 시스템 테이블
--> 데이터 딕셔너리는 사용자가 테이블을 생성하거나 사용자를 변경하는 등의
-- 작업을 할 때 데이터베이스 서버에 의해 자동으로 갱신되는 테이블
-- 주의. 사용자는 데이터딕셔너리의 내용을 직접 수정하거나 삭제할 수 없음.
-- 데이터 딕셔너리 안에는 중요한 정보가 많이 있기 때문에 사용자는 이를 활용하기 위해
-- 데이터 딕셔너리 뷰(가상테이블)를 사용하게 됨.
-- 데이터 딕셔너리 뷰의 종류1
-- 1. USER_XXXX
--> 자신(계정)이 소유한 객체 등에 관한 정보 조회가능
-- 사용자가 아닌 DB에서 자동생성 / 관리해주는 것이며 USER_뒤에 객체명을 써서 조회함.
-- 2. ALL_XXXX
--> 자신의 계정이 소유하거나 권한을 부여받은 객체 등에 관한 정보 조회가능
-- 3. DBA_XXXX
--> 데이터베이스 관리자만 접근이 가능한 객체 등에 관한 정보 조회가능
-- (DBA는 모든 접근이 가능하므로 결국 DB에 있는 모든 객체에 대한 조회 가능)
-- 일반사용자는 못쓴다.

-- 1. VIEW
--> DATA DICTIONARY VIEW
-- 2. SEQUENCE
-- 3. ROLE

--### ROLE
--> 사용자에게 여러 개의 권한을 한번에 부여할 수 있는 데이터베이스 객체
--> 사용자에게 권한을 부여할 때 한개씩 부여하게 된다며 권한부여 및 회수의 관리가 불편하므로 사용!
-- ex. GRANT CONNECT, RESOURCE TO KH;
-- 권한과 관련된 명령어는 반드시 SYSTEM에서 수행!
-- CONNECT, RESOURCE 롤이다. 롤은 권한이 여러개가 모여있다.
-- 롤은 필요한 권한을 묶어서 관리할 때 편하고 부여, 회수할 때 편하다!!
-- ROLE
-- CONNECT롤 : CREATE SESSION
-- RESOURCE롤 : CREATE CLUSTER, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TABLE
--             CREATE TRIGGER, CREATE TYPE, CREATE INDEXTYPE, CREATE OPERATOR;
-- SYSTEM에서 조회가능, SYS로 조회해야 CONNECT, RESOURCE 롤에 대한 권한이 보임.
-- 1. KH에서 조회됨
-- 2. SYSTEM에서 조회안됨
-- 3. KH에는 부여받았고, SYSTEM에는 부여받지않음.
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'CONNECT';
-- ROLE 생성
CREATE ROLE ROLE_PUBLIC_EMP;
-- 이건 불가능
GRANT SELECT ON KH.V_EMP_INFO TO ROLE_PUBLIC_EMP;
-- Role중에 ADMIN_OPTION이 YES인 것은 권한부여 가능
-- 사용방법
GRANT ROLE_PUBLIC_EMP TO 계정명;
SELECT * FROM USER_SYS_PRIVS;

-- 4. INDEX
-- SQL명령문의 처리속도를 향상시키기 위해서 컬럼에 대해서 생성하는 오라클 객체
--> key-value형태로 생성이 되며 key에는 인덱스로 만들 컬럼값, value에는 행이 저장된
-- 주소값이 저장됨.
-- * 장점 : 검색속도가 빨라지고 시스템에 걸리는 부하를 줄여서 시스템 전체 성능을 향상시킬 수 있음.
-- * 단점 : 1. 인덱스를 위한 추가 저장공간이 필요하고, 인덱스를 생성하는데 시간이 걸림
--         2. 데이터의 변경작업(INSERT/UPDATE/DELETE)이 자주 일어나는 테이블에 INDEX 생성시
--            오히려 성능저하가 발생할 수 있음.
-- SELECT할 때 사용되는 BUFFER CACHE에 올려놓는 작업
-- 자주 사용하는 컬럼에 대해 빠르게 불러오는 작업
-- * 어떤 컬럼에 인덱스를 만들면 좋을까?
-- 데이터값이 중복된 것이 없는 고유한 데이터값을 가지는 컬럼에 만드는 것이 제일 좋다.
-- 그리고 자주 사용되는 컬럼에 만들면 좋다.
-- * 효율적인 인덱스 사용 예
-- where절에 자주 사용되는 컬럼에 인덱스 생성
--> 전체 데이터 중에서 10% ~ 15% 이내의 데이터를 검색하는 경우, 중복이 많지 않은 컬럼이어야 함.
--> 두 개 이상의 컬럼 WHERE절이나 조인(join)조건으로 자주 사용되는 경우
--> 한 번 입력된 데이터의 변경이 자주 일어나지 않는 경우
--> 한 테이블에 저장된 데이터 용량이 상당히 클 경우
-- * 비효율적인 인덱스 사용 예
--> 중복값이 많은 컬럼에 사용된 인덱스
--> NULL값이 많은 컬럼에 사용된 인덱스
-- 인덱스 정보 조회
SELECT * FROM USER_INDEXES
WHERE TABLE_NAME = 'EMPLOYEE';
-- 한번도 만들지 않았으나 PK, UNIQUE 제약조건 컬럼은 자동으로 동일한 이름의 인덱스를 생성함
-- INDEX 생성
-- CREATE INDEX 인덱스명 ON 테이블명(컬럼명1, 컬럼명2, ...);
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '송종기';
-- 오라클 플랜, 튜닝할 때 사용하고 F10으로 실행가능함.
CREATE INDEX IDX_EMP_NAME ON EMPLOYEE(EMP_NAME);
-- 인덱스 삭제
DROP INDEX IDX_EMP_NAME;


--문제4
--같은 직급의 평균급여보다 같거나 많은 급여를 받는 직원의 
--이름, 직급코드, 급여, 급여등급 조회
SELECT EMP_NAME AS 이름, JOB_CODE AS 직급코드, SALARY AS 급여, 급여등급
FROM EMPLOYEE
WHERE ;

--문제5
--부서별 평균 급여가 2200000 이상인 부서명, 평균 급여 조회
--단, 평균 급여는 소수점 버림, 부서명이 없는 경우 '인턴'처리

--문제6
--직급의 연봉 평균보다 적게 받는 여자사원의
--사원명,직급명,부서명,연봉을 이름 오름차순으로 조회하시오
--연봉 계산 => (급여+(급여*보너스))*12    
-- 사원명,직급명,부서명,연봉은 EMPLOYEE 테이블을 통해 출력이 가능함

-- PL/SQL
--> Oracle's Procedural Language Extension to SQL의 약자
--> 오라클 자체에 내장되어 있는 절차적 언어로써
-- SQL의 단점을 보완하여 SQL문장내에서 변수의 정의, 조건처리, 반복처리 등을 지원함

--## PL/SQL의 구조(익명블록)
-- 1. 선언부(선택)
-- DECLARE : 변수나 상수를 선언하는 부분
-- 2. 실행부(필수)
-- BEGIN : 제어문, 반복문, 함수 정의 등 로직 기술
-- 3. 예외처리부(선택)
-- EXCEPTION : 예외사항 발생시 해결하기 위한 문장 기술
-- END; -- 블록 종료
-- /    -- PL/SQL 종료 및 실행

SET SERVEROUTPUT ON;
-- SQLDeveloper를 껐다가 켰을 때 실행해야함
-- 실행했는데 안나왔을 때 (DBMS_OUTPUT.PUT_LINE적었는데...)

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/

-- '선동일' 이라는 사람의 EMP_ID값을 추출하여 ID라는 변수에 넣어주고 PUT_LINE을 통해 출력함
--만약 '선동일' 이라는 사람이 없으면 'No Data!!!' 라는 예외 구문을 출력하도록 함
--다시해보기
DECLARE
    vId NUMBER;
BEGIN
    SELECT EMP_ID
    INTO vId
    FROM EMPLOYEE
    WHERE EMP_NAME = '선동일';
    DBMS_OUTPUT.PUT_LINE('ID='|| vId);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No Data!!');
END;
/

--## 변수선언
-- 변수명 [CONSTANT] 자료형(바이트크기) [NOT NULL] [:=초기값];

--## 변수의 종류
-- 일반변수, 상수, %TYPE, %ROWTYPE, 레코드(RECORD)

--## 상수
-- 일반변수와 유사하나 CONSTANT라는 키워드가 자료형 앞에 붙고
-- 선언시에 값을 할당해주어야함.
DECLARE
    EMPNO NUMBER := 507;
    ENAME VARCHAR2(20) := '일용자';
BEGIN
    DBMS_OUTPUT.PUT_LINE('사번 : '|| EMPNO);
    DBMS_OUTPUT.PUT_LINE('이름 : '|| ENAME);
END;
/

DECLARE
    USER_NAME VARCHAR2(20) := '일용자';
    MNAME CONSTANT VARCHAR2(20) := '삼용자';
BEGIN
    USER_NAME := '이용자';
    DBMS_OUTPUT.PUT_LINE('이름 : '|| USER_NAME);
    --MNAME := '사용자';
    --PLS-00363: expression 'MNAME' cannot be used as an assignment target
    --CONSTANT값이라 바꿀 수 없다.
    DBMS_OUTPUT.PUT_LINE('상수 : '|| MNAME);
END;
/

-- PL/SQL문에서 SELECT문
--> SQL문에서 사용하는 명령어를 그대로 사용할 수 있으며 SELECT쿼리 결과로 나온 값을
-- 변수에 할당하기 위해 사용함.
-- 예제1)
-- PL/SQL의 SELECT문으로 EMPLOYEE 테이블에서 주민번호와 이름 조회하기
DECLARE
    VEMPNO EMPLOYEE.EMP_NO%TYPE;    --EMP_NO의 데이터타입을 가져옴
    VENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_NO AS 주민번호, EMP_NAME AS 이름
    INTO VEMPNO, VENAME
    FROM EMPLOYEE
    WHERE EMP_NAME = '송종기';
    DBMS_OUTPUT.PUT_LINE('주민등록번호 : '||VEMPNO);
    DBMS_OUTPUT.PUT_LINE('이름 : '||VENAME);
END;
/

--예제 2)
--송중기 사원의 사원번호, 이름, 급여, 입사일을 출력하시오
DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VHDATE EMPLOYEE.HIRE_DATE%TYPE;
BEGIN
    SELECT EMP_ID AS 사원번호, EMP_NAME AS 이름, SALARY AS 급여, HIRE_DATE AS 입사일
    INTO VEMPID, VNAME, VSALARY, VHDATE
    FROM EMPLOYEE
    WHERE EMP_NAME = '송종기';
    DBMS_OUTPUT.PUT_LINE('사원번호 : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('입사일 : '||VHDATE);
END;
/

--예제 3)
--사원번호를 입력 받아서 사원의 사원번호, 이름, 급여, 입사일을 출력하시오
DECLARE
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VHDATE EMPLOYEE.HIRE_DATE%TYPE;
BEGIN
    SELECT EMP_NAME, SALARY, HIRE_DATE
    INTO VNAME, VSALARY, VHDATE
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';
    DBMS_OUTPUT.PUT_LINE('이름 : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('입사일 : '||VHDATE);
END;
/

--## 간단 실습 1 ##
-- 해당 사원의 사원번호를 입력시
-- 이름,부서코드,직급코드가 출력되도록 PL/SQL로 만들어 보시오.
DECLARE
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPTCODE EMPLOYEE.DEPT_CODE%TYPE;
    VJOBCODE EMPLOYEE.JOB_CODE%TYPE;
BEGIN
    SELECT EMP_NAME, DEPT_CODE, JOB_CODE
    INTO VNAME, VDEPTCODE, VJOBCODE
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';
    DBMS_OUTPUT.PUT_LINE('이름 : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('부서코드 : '||VDEPTCODE);
    DBMS_OUTPUT.PUT_LINE('직급코드 : '||VJOBCODE);
END;
/
--## 간단 실습 2 ##
-- 해당 사원의 사원번호를 입력시
-- 이름,부서명,직급명이 출력되도록 PL/SQL로 만들어 보시오
DECLARE
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPTTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    VJOBNAME JOB.JOB_NAME%TYPE;
BEGIN
    SELECT EMP_NAME, DEPT_TITLE, JOB_NAME
    INTO VNAME, VDEPTTITLE, VJOBNAME
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    LEFT JOIN JOB USING(JOB_CODE)
    WHERE EMP_ID = '&EMPID';
    DBMS_OUTPUT.PUT_LINE('이름 : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : '||VDEPTTITLE);
    DBMS_OUTPUT.PUT_LINE('직급명 : '||VJOBNAME);
END;
/

--### PL/SQL의 선택문
-- 모든 문장들은 기술한 순서대로 순차적으로 수행됨
-- 문장을 선택적으로 수행하려면 IF문을 사용하면됨
-- IF ~ THEN ~ END IF;문

--예제1) 사원번호를 가지고 사원의 사번,이름,급여,보너스율을 출력하고
-- 보너스율이 없으면 '보너스를 지급받지 않는 사원입니다' 를 출력하시오
 DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VBONUS EMPLOYEE.BONUS%TYPE;
 BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO VEMPID, VNAME, VSALARY, VBONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '202';
    DBMS_OUTPUT.PUT_LINE('사번 : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||VSALARY);
    IF (VBONUS <> 0)
    THEN DBMS_OUTPUT.PUT_LINE('보너스율 : '||VBONUS);
    ELSE DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;
 END;
 /

--예제2) 사원 코드를 입력 받았을때 사번,이름,직급코드,직급명,소속 값을 출력하시오
--그때, 소속값은 J1,J2 는 임원진, 그외에는 일반직원으로 출력되게 하시오
DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VJOBCODE EMPLOYEE.JOB_CODE%TYPE;
    VJOBNAME JOB.JOB_NAME%TYPE;
    VTEAM VARCHAR2(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
    INTO VEMPID, VNAME, VJOBCODE, VJOBNAME
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
    WHERE EMP_ID = '&EMPID';
    IF (VJOBCODE IN ('J1','J2'))
    THEN VTEAM := '임원진';
    ELSE VTEAM := '일반직원';
    END IF;
    DBMS_OUTPUT.PUT_LINE('사번 : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('직급코드 : '||VJOBCODE);
    DBMS_OUTPUT.PUT_LINE('직급명 : '||VJOBNAME);
    DBMS_OUTPUT.PUT_LINE('소속 : '||VTEAM);
END;
/

--## 간단 실습 1 ##
-- 사원 번호를 가지고 해당 사원을 조회
-- 이때 사원명,부서명 을 출력하여라.
-- 만약 부서가 없다면 부서명을 출력하지 않고,
-- '부서가 없는 사원 입니다' 를 출력하고
-- 부서가 있다면 부서명을 출력하여라.
DECLARE
    VEMPNAME EMPLOYEE.EMP_NAME%TYPE;
    VDTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    VDCODE DEPARTMENT.DEPT_ID%TYPE;
BEGIN
    SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE
    INTO VEMPNAME, VDCODE, VDTITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&사원번호';
    DBMS_OUTPUT.PUT_LINE('이름 : '||VEMPNAME);
    IF(VDCODE IS NOT NULL)
    THEN DBMS_OUTPUT.PUT_LINE('부서 : '||VDTITLE);
    ELSE DBMS_OUTPUT.PUT_LINE('부서가 없는 사원입니다.');
    END IF;
END;
/

--## 간단 실습2 ##
--사번을 입력 받은 후 급여에 따라 등급을 나누어 출력하도록 하시오 
--그때 출력 값은 사번,이름,급여,급여등급을 출력하시오

--0만원 ~ 99만원 : F
--100만원 ~ 199만원 : E
--200만원 ~ 299만원 : D
--300만원 ~ 399만원 : C
--400만원 ~ 499만원 : B
--500만원 이상(그외) : A

--ex) 200
--사번 : 200
--이름 : 선동일
--급여 : 8000000
--등급 : A
DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VRANK CHAR(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO VEMPID, VNAME, VSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    IF(VSALARY >=0 AND VSALARY <=990000) THEN VRANK := 'F';
    ELSIF(VSALARY >=1000000 AND VSALARY <=1990000) THEN VRANK := 'E';
    ELSIF(VSALARY >=2000000 AND VSALARY <=2990000) THEN VRANK := 'D';
    ELSIF(VSALARY >=3000000 AND VSALARY <=3990000) THEN VRANK := 'C';
    ELSIF(VSALARY >=4000000 AND VSALARY <=4990000) THEN VRANK := 'B';
    ELSE VRANK := 'A';
    END IF;
    DBMS_OUTPUT.PUT_LINE('사번 : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('등급 : '||VRANK);
END;
/

--CASE문
-- CASE변수
--      WHEN 값1 THEN 실행문1;
--      WHEN 값2 THEN 실행문2;
--      ELSE 실행문3;
-- END CASE;
DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VRANK CHAR(20);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO VEMPID, VNAME, VSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    VSALARY := VSALARY / 10000;
    CASE VSALARY
        WHEN (VSALARY >= 0 AND VSALARY <= 99) THEN VRANK := 'F';
        WHEN (VSALARY BETWEEN 100 AND 199) THEN VRANK := 'E';
        WHEN (VSALARY >= 200 AND VSALARY <= 299) THEN VRANK := 'D';
        WHEN (VSALARY BETWEEN 300 AND 399) THEN VRANK := 'C';
        WHEN (VSALARY BETWEEN 400 AND 499) THEN VRANK := 'B';
        ELSE VRANK := 'A';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('사번 : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('이름 : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '||VSALARY||'만원');
    DBMS_OUTPUT.PUT_LINE('등급 : '||VRANK);
END;
/

--쌤
DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VENAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    SGRADE VARCHAR2(3);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO VEMPID, VENAME, VSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&검색할사번';
    VSALARY := VSALARY / 10000;
    CASE       
        WHEN (VSALARY >= 0 AND VSALARY <= 99)    THEN SGRADE := 'F';
        WHEN (VSALARY BETWEEN 100 AND 199)       THEN SGRADE := 'E';
        WHEN (VSALARY BETWEEN 200 AND 299)       THEN SGRADE := 'D';
        WHEN (VSALARY >= 300 AND VSALARY <= 399) THEN SGRADE := 'C';
        WHEN (VSALARY >= 400 AND VSALARY <= 499) THEN SGRADE := 'B';
        ELSE SGRADE := 'A';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('사번 : '|| VEMPID);
    DBMS_OUTPUT.PUT_LINE('이름 : '|| VENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : '|| VSALARY || '만원');
    DBMS_OUTPUT.PUT_LINE('등급 : '|| SGRADE);
END;
/
--CASE문에서 범위로 넣을경우 CASE옆에 변수 없이 써줘야하고
--값으로 하는 경우 CASE옆에 변수를 써줘야해