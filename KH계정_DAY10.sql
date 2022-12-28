SELECT * FROM EMPLOYEE;
SET SERVEROUTPUT ON;
DECLARE
    VENAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_NAME, SALARY
    INTO VENAME, VSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&�����ȣ';
    IF(VSALARY >= 1000000)
    THEN DBMS_OUTPUT.PUT_LINE('�̸� : '||VENAME);
    ELSIF(VSALARY < 2000000)
    THEN DBMS_OUTPUT.PUT_LINE('���̰��Դϴ�');
    ELSE DBMS_OUTPUT.PUT_LINE('������ �޽��ϴ�.');
    END IF;
--EXCEPTION
END;
/
--��
SELECT * FROM EMPLOYEE;
SET SERVEROUTPUT ON;
DECLARE
    VENAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_NAME, SALARY
    INTO VENAME, VSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&�����ȣ';
    IF(VSALARY >= 1000000)
    THEN DBMS_OUTPUT.PUT_LINE('�̸� : '||VENAME);
    ELSIF(VSALARY < 2000000)
    THEN DBMS_OUTPUT.PUT_LINE('���̰��Դϴ�');
    ELSE DBMS_OUTPUT.PUT_LINE('������ �޽��ϴ�.');
    END IF;
--EXCEPTION
END;
/
-------------------------------------------------------

DECLARE
    VSAL EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT SALARY
    INTO VSAL
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';
    VSAL := VSAL / 1000000;
    CASE FLOOR(VSAL)
        WHEN 0 THEN DBMS_OUTPUT.PUT_LINE('F����Դϴ�.');
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('E����Դϴ�.');
        WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('D����Դϴ�.');
        WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('c����Դϴ�.');
        WHEN 4 THEN DBMS_OUTPUT.PUT_LINE('B����Դϴ�.');
        ELSE DBMS_OUTPUT.PUT_LINE('A����Դϴ�.');
    END CASE;
END;
/

-- 1. ��������, SELECT��� ������ ���
-- 2. IF THEN END IF; �Ẹ��
-- 3. CASE END CAE; �Ẹ��
---------�����Ұ�
-- # PL/SQL �ݺ���
-- 1. LOOP END LOOP;
-- 2. FOR END LOOP;
-- 3. WHILE LOOP;

--## �⺻ LOOP��
DECLARE
    N NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N+1;
        IF N > 5 THEN EXIT;
        END IF;
    END LOOP;
END;
/

--## FOR LOOP
-- ī��Ʈ�� ������ �ڵ����� �����(DECLARE�ʿ����)
-- ���� ������ ������ �ʿ䰡 ����.
-- ī��Ʈ ���� �ڵ����� 1�� ������. REVERSE�� ����ϸ� 1�� ������.
BEGIN
    FOR N IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/
--## REVERSE
BEGIN
    FOR N IN REVERSE 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/
-- EMPLOYEE���̺��� �����ȣ�� 201, 202, 203, 204�� ������
-- �̸��� �޿��� ����Ͻÿ�.
DECLARE
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    FOR N IN 1..4 LOOP
        SELECT EMP_NAME, SALARY
        INTO VNAME, SALARY
        FROM EMPLOYEE
        WHERE EMP_ID = 200 + N;
        DBMS_OUTPUT.PUT_LINE('�̸� : '||VNAME);
        DBMS_OUTPUT.PUT_LINE('�޿� : '||SALARY);
    END LOOP;
END;
/

-- �ǽ�����
-- ����ڷκ��� 2~9������ ���� �Է¹޾� ������ ����Ͻÿ�
--1.
DECLARE
    DAN NUMBER;
BEGIN
    DAN := '&��';
    FOR N IN 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN||' * '||N||' = '||DAN*N);
    END LOOP;
END;
/
--2.
DECLARE
    DAN NUMBER;
    N NUMBER := 1;
BEGIN
    DAN := '&��';
    LOOP
        DBMS_OUTPUT.PUT_LINE(DAN||' * '||N||' = '||DAN*N);
        N := N + 1;
        IF (N > 9) THEN EXIT;
        END IF;
    END LOOP;
END;
/
--3.
DECLARE
    DAN NUMBER;
    N NUMBER := 1;
BEGIN
    DAN := '&��';
    WHILE N <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE(DAN||' * '||N||' = '||DAN*N);
        N := N + 1;
    END LOOP;
END;
/
--# ����ó��
--DECLARE
--BEGIN
--EXCEPTION
--END;
--/
-- # Exception�� ����
/*
    1. ACCESS_INTO_NULL
    2. CASE_NOT_FOUND
    3. COLLECTION_IS_NULL
    4. CURSOR_ALREADY_OPEN
    ...
    5. LOGIN_DENIED
    6. NO_DATA_FOUND
*/
/*
    EXCEPTION
        WHEN �����̸�1 THEN ó������1
        WHEN �����̸�2 THEN ó������2
    END;
    /
*/
-- PL/SQL�� ���õ� ����Ŭ ��ü
-- FUNCTION, PROCEDURE, CURSOR, PACKAGE, TRIGGER, JOB, ...
