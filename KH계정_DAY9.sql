--@�ǽ�����
--kh���� ������ �� employee, job, department���̺��� �Ϻ������� 
--����ڿ��� �����Ϸ��� �Ѵ�.
-- ������̵�, �����, ���޸�, �μ���, �����ڸ�, �Ի����� �÷������� 
--��(v_emp_info)�� (�б� ��������) �����Ͽ���.
CREATE OR REPLACE VIEW V_EMP_INFO
AS SELECT E.EMP_ID AS ������̵�, E.EMP_NAME AS �����, J.JOB_NAME AS ���޸�
, D.DEPT_TITLE AS �μ���, M.EMP_NAME AS �����ڸ�, E.HIRE_DATE AS �Ի���
FROM EMPLOYEE E
LEFT JOIN JOB J USING (JOB_CODE)
LEFT JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID
LEFT JOIN EMPLOYEE M ON M.EMP_ID = E.MANAGER_ID;

DROP VIEW V_EMP_INFO;

-- VIEW �ɼ�
-- VIEW�� ���� �Ŀ� �����ؾߵ� ��� ���� �� ������ؾ���
-- 1. OR REPLACE
--> ������ �䰡 �����ϸ� �並 ��������.
-- 2. FORCE/NOFORCE
-- �⺻���� NOFORCE�� �����Ǿ� ����.
CREATE OR REPLACE FORCE VIEW V_FORCE_SOMETHING
AS SELECT EMP_ID, EMP_NO FROM NOTHING_TBL;
-- 3. WITH CHECK OPTION
--> WHERE�� ���ǿ� ����� �÷��� ���� �������� ���ϰ� ��.
CREATE OR REPLACE VIEW V_EMP_D5
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' WITH CHECK OPTION;
ROLLBACK;

UPDATE V_EMP_D5 SET DEPT_CODE = 'D2'
WHERE SALARY >= 2500000;
-- 4. WITH READ ONLY
-- ������ �����ϴ� �ɼ�. ���� VIEW�� ������ ������
CREATE VIEW V_INFO
AS SELECT EMP_NAME, EMP_ID, JOB_CODE
FROM EMPLOYEE
WITH READ ONLY;

--@�ǽ�����
--���� ��ǰ�ֹ��� ����� ���̺� TBL_ORDER�� �����, ������ ���� �÷��� �����ϼ���
-- ORDER_NO(�ֹ�NO) : PK
-- USER_ID(�����̵�)
-- PRODUCT_ID(�ֹ���ǰ���̵�)
-- PRODUCT_CNT(�ֹ�����) 
-- ORDER_DATE : DEFAULT SYSDATE
CREATE TABLE TBL_ORDER(
    ORDER_NO NUMBER CONSTRAINT ORDER_NO_PK PRIMARY KEY,
    USER_ID VARCHAR2(40),
    PRODUCT_ID VARCHAR2(40),
    PRODUCT_CNT NUMBER,
    ORDER_DATE DATE DEFAULT SYSDATE
);
COMMENT ON COLUMN TBL_ORDER.ORDER_NO IS '�ֹ�NO';
COMMENT ON COLUMN TBL_ORDER.USER_ID IS '�����̵�';
COMMENT ON COLUMN TBL_ORDER.PRODUCT_ID IS '�ֹ���ǰ���̵�';
COMMENT ON COLUMN TBL_ORDER.PRODUCT_CNT IS '�ֹ�����';

-- ORDER_NO�� ������ SEQ_ORDER_NO�� �����, ���� �����͸� �߰��ϼ���.(����ð� ����)
-- * kang���� saewookkang��ǰ�� 5�� �ֹ��ϼ̽��ϴ�.
-- * gam���� gamjakkang��ǰ�� 30�� �ֹ��ϼ̽��ϴ�.
-- * ring���� onionring��ǰ�� 50�� �ֹ��ϼ̽��ϴ�.
CREATE SEQUENCE SEQ_ORDER_NO;
INSERT INTO TBL_ORDER
VALUES(SEQ_ORDER_NO.NEXTVAL, 'kang', 'saewookkang', 5, DEFAULT);
INSERT INTO TBL_ORDER
VALUES(SEQ_ORDER_NO.NEXTVAL, 'gam', 'gamjakkang', 30, DEFAULT);
INSERT INTO TBL_ORDER
VALUES(SEQ_ORDER_NO.NEXTVAL, 'ring', 'onionring', 50, DEFAULT);
COMMIT;

-- �ǽ�����2
--KH_MEMBER ���̺��� ����
--�÷�
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

--�̶� �ش� ������� ������ INSERT �ؾ� ��
--ID ���� JOIN_COM�� SEQUENCE �� �̿��Ͽ� ������ �ְ��� ��
--ID���� 500 �� ���� �����Ͽ� 10�� �����Ͽ� ���� �ϰ��� ��
--JOIN_COM ���� 1������ �����Ͽ� 1�� �����Ͽ� ���� �ؾ� ��
--(ID ���� JOIN_COM ���� MAX�� 10000���� ����)
CREATE SEQUENCE SEQ_KH_MEM_ID
START WITH 500
INCREMENT BY 10
MAXVALUE 10000;

CREATE SEQUENCE SEQ_KH_MEM_COM
MAXVALUE 10000;

--	MEMBER_ID	MEMBER_NAME	 MEMBER_AGE	 MEMBER_JOIN_COM	
--	500		        ȫ�浿		20		        1
--	510		        �踻��		30		        2
--	520		        �����		40		        3
--	530		        ����		24		        4
INSERT INTO KH_MEMBER
VALUES(SEQ_KH_MEM_ID.NEXTVAL, 'ȫ�浿', 20, SEQ_KH_MEM_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES(SEQ_KH_MEM_ID.NEXTVAL, '�踻��', 30, SEQ_KH_MEM_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES(SEQ_KH_MEM_ID.NEXTVAL, '�����', 40, SEQ_KH_MEM_COM.NEXTVAL);
INSERT INTO KH_MEMBER
VALUES(SEQ_KH_MEM_ID.NEXTVAL, '����', 24, SEQ_KH_MEM_COM.NEXTVAL);

SELECT * FROM USER_SEQUENCES;
SELECT * FROM USER_VIEWS;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMPLOYEE';
SELECT * FROM USER_TABLES;
-- ������ ��ųʸ�(DD, DATA DICTIONARY)
--> �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺�
--> ������ ��ųʸ��� ����ڰ� ���̺��� �����ϰų� ����ڸ� �����ϴ� ����
-- �۾��� �� �� �����ͺ��̽� ������ ���� �ڵ����� ���ŵǴ� ���̺�
-- ����. ����ڴ� �����͵�ųʸ��� ������ ���� �����ϰų� ������ �� ����.
-- ������ ��ųʸ� �ȿ��� �߿��� ������ ���� �ֱ� ������ ����ڴ� �̸� Ȱ���ϱ� ����
-- ������ ��ųʸ� ��(�������̺�)�� ����ϰ� ��.
-- ������ ��ųʸ� ���� ����1
-- 1. USER_XXXX
--> �ڽ�(����)�� ������ ��ü � ���� ���� ��ȸ����
-- ����ڰ� �ƴ� DB���� �ڵ����� / �������ִ� ���̸� USER_�ڿ� ��ü���� �Ἥ ��ȸ��.
-- 2. ALL_XXXX
--> �ڽ��� ������ �����ϰų� ������ �ο����� ��ü � ���� ���� ��ȸ����
-- 3. DBA_XXXX
--> �����ͺ��̽� �����ڸ� ������ ������ ��ü � ���� ���� ��ȸ����
-- (DBA�� ��� ������ �����ϹǷ� �ᱹ DB�� �ִ� ��� ��ü�� ���� ��ȸ ����)
-- �Ϲݻ���ڴ� ������.

-- 1. VIEW
--> DATA DICTIONARY VIEW
-- 2. SEQUENCE
-- 3. ROLE

--### ROLE
--> ����ڿ��� ���� ���� ������ �ѹ��� �ο��� �� �ִ� �����ͺ��̽� ��ü
--> ����ڿ��� ������ �ο��� �� �Ѱ��� �ο��ϰ� �ȴٸ� ���Ѻο� �� ȸ���� ������ �����ϹǷ� ���!
-- ex. GRANT CONNECT, RESOURCE TO KH;
-- ���Ѱ� ���õ� ��ɾ�� �ݵ�� SYSTEM���� ����!
-- CONNECT, RESOURCE ���̴�. ���� ������ �������� ���ִ�.
-- ���� �ʿ��� ������ ��� ������ �� ���ϰ� �ο�, ȸ���� �� ���ϴ�!!
-- ROLE
-- CONNECT�� : CREATE SESSION
-- RESOURCE�� : CREATE CLUSTER, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TABLE
--             CREATE TRIGGER, CREATE TYPE, CREATE INDEXTYPE, CREATE OPERATOR;
-- SYSTEM���� ��ȸ����, SYS�� ��ȸ�ؾ� CONNECT, RESOURCE �ѿ� ���� ������ ����.
-- 1. KH���� ��ȸ��
-- 2. SYSTEM���� ��ȸ�ȵ�
-- 3. KH���� �ο��޾Ұ�, SYSTEM���� �ο���������.
SELECT * FROM ROLE_SYS_PRIVS
WHERE ROLE = 'CONNECT';
-- ROLE ����
CREATE ROLE ROLE_PUBLIC_EMP;
-- �̰� �Ұ���
GRANT SELECT ON KH.V_EMP_INFO TO ROLE_PUBLIC_EMP;
-- Role�߿� ADMIN_OPTION�� YES�� ���� ���Ѻο� ����
-- �����
GRANT ROLE_PUBLIC_EMP TO ������;
SELECT * FROM USER_SYS_PRIVS;

-- 4. INDEX
-- SQL��ɹ��� ó���ӵ��� ����Ű�� ���ؼ� �÷��� ���ؼ� �����ϴ� ����Ŭ ��ü
--> key-value���·� ������ �Ǹ� key���� �ε����� ���� �÷���, value���� ���� �����
-- �ּҰ��� �����.
-- * ���� : �˻��ӵ��� �������� �ý��ۿ� �ɸ��� ���ϸ� �ٿ��� �ý��� ��ü ������ ����ų �� ����.
-- * ���� : 1. �ε����� ���� �߰� ��������� �ʿ��ϰ�, �ε����� �����ϴµ� �ð��� �ɸ�
--         2. �������� �����۾�(INSERT/UPDATE/DELETE)�� ���� �Ͼ�� ���̺� INDEX ������
--            ������ �������ϰ� �߻��� �� ����.
-- SELECT�� �� ���Ǵ� BUFFER CACHE�� �÷����� �۾�
-- ���� ����ϴ� �÷��� ���� ������ �ҷ����� �۾�
-- * � �÷��� �ε����� ����� ������?
-- �����Ͱ��� �ߺ��� ���� ���� ������ �����Ͱ��� ������ �÷��� ����� ���� ���� ����.
-- �׸��� ���� ���Ǵ� �÷��� ����� ����.
-- * ȿ������ �ε��� ��� ��
-- where���� ���� ���Ǵ� �÷��� �ε��� ����
--> ��ü ������ �߿��� 10% ~ 15% �̳��� �����͸� �˻��ϴ� ���, �ߺ��� ���� ���� �÷��̾�� ��.
--> �� �� �̻��� �÷� WHERE���̳� ����(join)�������� ���� ���Ǵ� ���
--> �� �� �Էµ� �������� ������ ���� �Ͼ�� �ʴ� ���
--> �� ���̺� ����� ������ �뷮�� ����� Ŭ ���
-- * ��ȿ������ �ε��� ��� ��
--> �ߺ����� ���� �÷��� ���� �ε���
--> NULL���� ���� �÷��� ���� �ε���
-- �ε��� ���� ��ȸ
SELECT * FROM USER_INDEXES
WHERE TABLE_NAME = 'EMPLOYEE';
-- �ѹ��� ������ �ʾ����� PK, UNIQUE �������� �÷��� �ڵ����� ������ �̸��� �ε����� ������
-- INDEX ����
-- CREATE INDEX �ε����� ON ���̺��(�÷���1, �÷���2, ...);
SELECT * FROM EMPLOYEE WHERE EMP_NAME = '������';
-- ����Ŭ �÷�, Ʃ���� �� ����ϰ� F10���� ���డ����.
CREATE INDEX IDX_EMP_NAME ON EMPLOYEE(EMP_NAME);
-- �ε��� ����
DROP INDEX IDX_EMP_NAME;


--����4
--���� ������ ��ձ޿����� ���ų� ���� �޿��� �޴� ������ 
--�̸�, �����ڵ�, �޿�, �޿���� ��ȸ
SELECT EMP_NAME AS �̸�, JOB_CODE AS �����ڵ�, SALARY AS �޿�, �޿����
FROM EMPLOYEE
WHERE ;

--����5
--�μ��� ��� �޿��� 2200000 �̻��� �μ���, ��� �޿� ��ȸ
--��, ��� �޿��� �Ҽ��� ����, �μ����� ���� ��� '����'ó��

--����6
--������ ���� ��պ��� ���� �޴� ���ڻ����
--�����,���޸�,�μ���,������ �̸� ������������ ��ȸ�Ͻÿ�
--���� ��� => (�޿�+(�޿�*���ʽ�))*12    
-- �����,���޸�,�μ���,������ EMPLOYEE ���̺��� ���� ����� ������

-- PL/SQL
--> Oracle's Procedural Language Extension to SQL�� ����
--> ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���ν�
-- SQL�� ������ �����Ͽ� SQL���峻���� ������ ����, ����ó��, �ݺ�ó�� ���� ������

--## PL/SQL�� ����(�͸���)
-- 1. �����(����)
-- DECLARE : ������ ����� �����ϴ� �κ�
-- 2. �����(�ʼ�)
-- BEGIN : ���, �ݺ���, �Լ� ���� �� ���� ���
-- 3. ����ó����(����)
-- EXCEPTION : ���ܻ��� �߻��� �ذ��ϱ� ���� ���� ���
-- END; -- ��� ����
-- /    -- PL/SQL ���� �� ����

SET SERVEROUTPUT ON;
-- SQLDeveloper�� ���ٰ� ���� �� �����ؾ���
-- �����ߴµ� �ȳ����� �� (DBMS_OUTPUT.PUT_LINE�����µ�...)

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/

-- '������' �̶�� ����� EMP_ID���� �����Ͽ� ID��� ������ �־��ְ� PUT_LINE�� ���� �����
--���� '������' �̶�� ����� ������ 'No Data!!!' ��� ���� ������ ����ϵ��� ��
--�ٽ��غ���
DECLARE
    vId NUMBER;
BEGIN
    SELECT EMP_ID
    INTO vId
    FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE('ID='|| vId);
EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No Data!!');
END;
/

--## ��������
-- ������ [CONSTANT] �ڷ���(����Ʈũ��) [NOT NULL] [:=�ʱⰪ];

--## ������ ����
-- �Ϲݺ���, ���, %TYPE, %ROWTYPE, ���ڵ�(RECORD)

--## ���
-- �Ϲݺ����� �����ϳ� CONSTANT��� Ű���尡 �ڷ��� �տ� �ٰ�
-- ����ÿ� ���� �Ҵ����־����.
DECLARE
    EMPNO NUMBER := 507;
    ENAME VARCHAR2(20) := '�Ͽ���';
BEGIN
    DBMS_OUTPUT.PUT_LINE('��� : '|| EMPNO);
    DBMS_OUTPUT.PUT_LINE('�̸� : '|| ENAME);
END;
/

DECLARE
    USER_NAME VARCHAR2(20) := '�Ͽ���';
    MNAME CONSTANT VARCHAR2(20) := '�����';
BEGIN
    USER_NAME := '�̿���';
    DBMS_OUTPUT.PUT_LINE('�̸� : '|| USER_NAME);
    --MNAME := '�����';
    --PLS-00363: expression 'MNAME' cannot be used as an assignment target
    --CONSTANT���̶� �ٲ� �� ����.
    DBMS_OUTPUT.PUT_LINE('��� : '|| MNAME);
END;
/

-- PL/SQL������ SELECT��
--> SQL������ ����ϴ� ��ɾ �״�� ����� �� ������ SELECT���� ����� ���� ����
-- ������ �Ҵ��ϱ� ���� �����.
-- ����1)
-- PL/SQL�� SELECT������ EMPLOYEE ���̺��� �ֹι�ȣ�� �̸� ��ȸ�ϱ�
DECLARE
    VEMPNO EMPLOYEE.EMP_NO%TYPE;    --EMP_NO�� ������Ÿ���� ������
    VENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_NO AS �ֹι�ȣ, EMP_NAME AS �̸�
    INTO VEMPNO, VENAME
    FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE('�ֹε�Ϲ�ȣ : '||VEMPNO);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VENAME);
END;
/

--���� 2)
--���߱� ����� �����ȣ, �̸�, �޿�, �Ի����� ����Ͻÿ�
DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VHDATE EMPLOYEE.HIRE_DATE%TYPE;
BEGIN
    SELECT EMP_ID AS �����ȣ, EMP_NAME AS �̸�, SALARY AS �޿�, HIRE_DATE AS �Ի���
    INTO VEMPID, VNAME, VSALARY, VHDATE
    FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE('�����ȣ : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('�Ի��� : '||VHDATE);
END;
/

--���� 3)
--�����ȣ�� �Է� �޾Ƽ� ����� �����ȣ, �̸�, �޿�, �Ի����� ����Ͻÿ�
DECLARE
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VHDATE EMPLOYEE.HIRE_DATE%TYPE;
BEGIN
    SELECT EMP_NAME, SALARY, HIRE_DATE
    INTO VNAME, VSALARY, VHDATE
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('�Ի��� : '||VHDATE);
END;
/

--## ���� �ǽ� 1 ##
-- �ش� ����� �����ȣ�� �Է½�
-- �̸�,�μ��ڵ�,�����ڵ尡 ��µǵ��� PL/SQL�� ����� ���ÿ�.
DECLARE
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VDEPTCODE EMPLOYEE.DEPT_CODE%TYPE;
    VJOBCODE EMPLOYEE.JOB_CODE%TYPE;
BEGIN
    SELECT EMP_NAME, DEPT_CODE, JOB_CODE
    INTO VNAME, VDEPTCODE, VJOBCODE
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMPID';
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : '||VDEPTCODE);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : '||VJOBCODE);
END;
/
--## ���� �ǽ� 2 ##
-- �ش� ����� �����ȣ�� �Է½�
-- �̸�,�μ���,���޸��� ��µǵ��� PL/SQL�� ����� ���ÿ�
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
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : '||VDEPTTITLE);
    DBMS_OUTPUT.PUT_LINE('���޸� : '||VJOBNAME);
END;
/

--### PL/SQL�� ���ù�
-- ��� ������� ����� ������� ���������� �����
-- ������ ���������� �����Ϸ��� IF���� ����ϸ��
-- IF ~ THEN ~ END IF;��

--����1) �����ȣ�� ������ ����� ���,�̸�,�޿�,���ʽ����� ����ϰ�
-- ���ʽ����� ������ '���ʽ��� ���޹��� �ʴ� ����Դϴ�' �� ����Ͻÿ�
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
    DBMS_OUTPUT.PUT_LINE('��� : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY);
    IF (VBONUS <> 0)
    THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� : '||VBONUS);
    ELSE DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
 END;
 /

--����2) ��� �ڵ带 �Է� �޾����� ���,�̸�,�����ڵ�,���޸�,�Ҽ� ���� ����Ͻÿ�
--�׶�, �ҼӰ��� J1,J2 �� �ӿ���, �׿ܿ��� �Ϲ��������� ��µǰ� �Ͻÿ�
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
    THEN VTEAM := '�ӿ���';
    ELSE VTEAM := '�Ϲ�����';
    END IF;
    DBMS_OUTPUT.PUT_LINE('��� : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : '||VJOBCODE);
    DBMS_OUTPUT.PUT_LINE('���޸� : '||VJOBNAME);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : '||VTEAM);
END;
/

--## ���� �ǽ� 1 ##
-- ��� ��ȣ�� ������ �ش� ����� ��ȸ
-- �̶� �����,�μ��� �� ����Ͽ���.
-- ���� �μ��� ���ٸ� �μ����� ������� �ʰ�,
-- '�μ��� ���� ��� �Դϴ�' �� ����ϰ�
-- �μ��� �ִٸ� �μ����� ����Ͽ���.
DECLARE
    VEMPNAME EMPLOYEE.EMP_NAME%TYPE;
    VDTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    VDCODE DEPARTMENT.DEPT_ID%TYPE;
BEGIN
    SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE
    INTO VEMPNAME, VDCODE, VDTITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&�����ȣ';
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VEMPNAME);
    IF(VDCODE IS NOT NULL)
    THEN DBMS_OUTPUT.PUT_LINE('�μ� : '||VDTITLE);
    ELSE DBMS_OUTPUT.PUT_LINE('�μ��� ���� ����Դϴ�.');
    END IF;
END;
/

--## ���� �ǽ�2 ##
--����� �Է� ���� �� �޿��� ���� ����� ������ ����ϵ��� �Ͻÿ� 
--�׶� ��� ���� ���,�̸�,�޿�,�޿������ ����Ͻÿ�

--0���� ~ 99���� : F
--100���� ~ 199���� : E
--200���� ~ 299���� : D
--300���� ~ 399���� : C
--400���� ~ 499���� : B
--500���� �̻�(�׿�) : A

--ex) 200
--��� : 200
--�̸� : ������
--�޿� : 8000000
--��� : A
DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VNAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    VRANK CHAR(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO VEMPID, VNAME, VSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    IF(VSALARY >=0 AND VSALARY <=990000) THEN VRANK := 'F';
    ELSIF(VSALARY >=1000000 AND VSALARY <=1990000) THEN VRANK := 'E';
    ELSIF(VSALARY >=2000000 AND VSALARY <=2990000) THEN VRANK := 'D';
    ELSIF(VSALARY >=3000000 AND VSALARY <=3990000) THEN VRANK := 'C';
    ELSIF(VSALARY >=4000000 AND VSALARY <=4990000) THEN VRANK := 'B';
    ELSE VRANK := 'A';
    END IF;
    DBMS_OUTPUT.PUT_LINE('��� : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('��� : '||VRANK);
END;
/

--CASE��
-- CASE����
--      WHEN ��1 THEN ���๮1;
--      WHEN ��2 THEN ���๮2;
--      ELSE ���๮3;
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
    WHERE EMP_ID = '&���';
    VSALARY := VSALARY / 10000;
    CASE VSALARY
        WHEN (VSALARY >= 0 AND VSALARY <= 99) THEN VRANK := 'F';
        WHEN (VSALARY BETWEEN 100 AND 199) THEN VRANK := 'E';
        WHEN (VSALARY >= 200 AND VSALARY <= 299) THEN VRANK := 'D';
        WHEN (VSALARY BETWEEN 300 AND 399) THEN VRANK := 'C';
        WHEN (VSALARY BETWEEN 400 AND 499) THEN VRANK := 'B';
        ELSE VRANK := 'A';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('��� : '||VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||VNAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||VSALARY||'����');
    DBMS_OUTPUT.PUT_LINE('��� : '||VRANK);
END;
/

--��
DECLARE
    VEMPID EMPLOYEE.EMP_ID%TYPE;
    VENAME EMPLOYEE.EMP_NAME%TYPE;
    VSALARY EMPLOYEE.SALARY%TYPE;
    SGRADE VARCHAR2(3);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO VEMPID, VENAME, VSALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&�˻��һ��';
    VSALARY := VSALARY / 10000;
    CASE       
        WHEN (VSALARY >= 0 AND VSALARY <= 99)    THEN SGRADE := 'F';
        WHEN (VSALARY BETWEEN 100 AND 199)       THEN SGRADE := 'E';
        WHEN (VSALARY BETWEEN 200 AND 299)       THEN SGRADE := 'D';
        WHEN (VSALARY >= 300 AND VSALARY <= 399) THEN SGRADE := 'C';
        WHEN (VSALARY >= 400 AND VSALARY <= 499) THEN SGRADE := 'B';
        ELSE SGRADE := 'A';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('��� : '|| VEMPID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '|| VENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '|| VSALARY || '����');
    DBMS_OUTPUT.PUT_LINE('��� : '|| SGRADE);
END;
/
--CASE������ ������ ������� CASE���� ���� ���� ������ϰ�
--������ �ϴ� ��� CASE���� ������ �������