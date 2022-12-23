--@DQL���սǽ�����
--����1. ��������ο� ���� ������� ����� �̸�,�μ��ڵ�,�޿��� ����Ͻÿ�.
SELECT EMP_NAME AS �̸�, DEPT_CODE AS �μ��ڵ�, SALARY AS �޿�
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '���������';

--����2. 
--��������ο� ���� ����� �� ���� ������ ���� ����� �̸�,�μ��ڵ�,�޿��� ����Ͻÿ�
--���Ŀ���Ẹ��
SELECT EMP_NAME AS �̸�, DEPT_CODE AS �μ��ڵ�, SALARY AS �޿�
, (SELECT SALARY FROM EMPLOYEE WHERE SALARY = E.SALARY)
FROM EMPLOYEE E
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '���������';


SELECT EMP_NAME AS �̸�, DEPT_CODE AS �μ��ڵ�, SALARY AS �޿�
FROM EMPLOYEE E
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '���������'
AND SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_TITLE = '���������');

--����3. 
--�Ŵ����� �ִ� ����߿� ������ ��ü��� ����� �Ѱ� ���,�̸�,�Ŵ��� �̸�, ������ ���Ͻÿ�.
SELECT EMP_ID AS ���, EMP_NAME AS �̸�,
(SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID) AS �Ŵ����̸�, SALARY AS����
FROM EMPLOYEE E
WHERE MANAGER_ID IS NOT NULL AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);


-- ##�������
-- ### 1. TOP-N �м�
-- ### 2. WITH
-- ### 3. ������ ���� (Hierarchical Query)
-- ### 4. ������ �Լ�
-- #### 4.1 ���� �Լ�

-- JOIN�� ����3
-- 1. ��ȣ���� (CROSS JOIN)
-- ī���̼� ��(Cartensial Product)��� ��
-- ���εǴ� ���̺��� �� ����� ��� ���ε� ���ι��
-- �ٽø���, �� �� ���̺��� ��� ��� �ٸ��� ���̺��� ��� ���� ���� ��Ŵ
-- ��� ����� ���� ���ϹǷ� ����� �� ���̺��� �÷����� ���� ������ ����.
-- 4 * 3 = 12
SELECT EMP_NAME AS �����, DEPT_TITLE AS �μ���
FROM EMPLOYEE CROSS JOIN DEPARTMENT;
--@�ǽ�����
--�Ʒ�ó�� �������� �ϼ���.
----------------------------------------------------------------
-- �����ȣ    �����     ����    ��տ���    ����-��տ���
----------------------------------------------------------------
SELECT EMP_ID AS �����ȣ, EMP_NAME AS �����, SALARY AS ����
, AVG_SAL AS ��տ���, (CASE WHEN SALARY - AVG_SAL > 0 THEN '+' END) || (SALARY - AVG_SAL) AS "����-��տ���"
FROM EMPLOYEE CROSS JOIN (SELECT ROUND(AVG(SALARY))"AVG_SAL" FROM EMPLOYEE);



-- 2. �������� (SELF JOIN)
SELECT EMP_ID AS ���, EMP_NAME AS �̸�,
(SELECT EMP_NAME FROM EMPLOYEE WHERE EMP_ID = E.MANAGER_ID) AS �Ŵ����̸�, SALARY AS����
FROM EMPLOYEE E
WHERE MANAGER_ID IS NOT NULL AND SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);
-- ��������� �̿��� �Ŵ��� �̸� ���ϱ� ��� ���� ���� ���������� �̿��ؼ� ���� �� ����.
SELECT E.EMP_ID, E.EMP_NAME, M.EMP_NAME, E.SALARY
FROM EMPLOYEE E
JOIN EMPLOYEE M
ON M.EMP_ID = E.MANAGER_ID;
-- # ��������
-- ## 1. CHECK
-- ��������
-- 1. ���̺� USER_CHECK, CHAR(1) �Ǽ�
-- 2. CHAR(1) -> CHAR(3)
-- 3. INSERT INTO, 4���� ����
-- 4. CHECK ����, �̹� ������� ���̺��̶� ALTER TABLE
-- 5. BUT M,F�� �� �־ DELETE FROM, 4���� ����
-- 6. ALTER TABLE ADD�� �������� �߰�
-- 7. INSERT INTO �ؼ� M, F�� ������ �� Ȯ��('��','��'�� ��)
CREATE TABLE USER_CHECK(
    USER_NO NUMBER PRIMARY KEY,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_GENDER CHAR(1) CONSTRAINT GENDER_VAL CHECK(USER_GENDER IN('��', '��'))
);
DROP TABLE USER_CHECK;
--�̹� ���̺��� ����� ���� ���¿��� ���������� �����ϴ� ���
ALTER TABLE USER_CHECK
MODIFY USER_GENDER CHAR(3);
ALTER TABLE USER_CHECK
ADD CONSTRAINT GENDER_VAL CHECK(USER_GENDER IN('��','��'));
DELETE FROM USER_CHECK;
INSERT INTO USER_CHECK
VALUES ('1','�Ͽ���','��');
INSERT INTO USER_CHECK
VALUES ('2','�̿���','��');
INSERT INTO USER_CHECK
VALUES ('3','�����','M');
INSERT INTO USER_CHECK
VALUES ('4','�����','F');

-- ## 2. DEFAULT
CREATE TABLE USER_DEFAULT(
    USER_NO NUMBER CONSTRAINT USER_NO_PK_ PRIMARY KEY,
    USER_NAME VARCHAR2(30) NOT NULL,
    USER_DATE DATE DEFAULT SYSDATE,
    USER_YN CHAR(1) DEFAULT 'Y'
);
DROP TABLE USER_DEFAULT;
--DROP�����ʰ� �������� �߰��ϴ� ���
ALTER TABLE USER_DEFAULT
ADD USER_DATE DEFAULT SYSDATE;
INSERT INTO USER_DEFAULT
VALUES(1, '�Ͽ���', DEFAULT, DEFAULT);
INSERT INTO USER_DEFAULT
VALUES(2, '�̿���', DEFAULT, DEFAULT);


--## TCL
-- Ʈ������̶�?
-- �Ѳ����� ����Ǿ�� �� �ּ��� �۾� ������ ����, 
-- �ϳ��� Ʈ��������� �̷���� �۾����� �ݵ�� �Ѳ����� �Ϸᰡ �Ǿ�� �ϸ�,
-- �׷��� ���� ��쿡�� �Ѳ����� ��� �Ǿ�� ��
-- TCL�� ����
-- 1. COMMIT : Ʈ����� �۾��� ���� �Ϸ� �Ǹ� ���� ������ ������ ���� (��� savepoint ����)
-- 2. ROLLBACK : Ʈ����� �۾��� ��� ����ϰ� ���� �ֱ� commit �������� �̵�
-- 3. SAVEPOINT : ���� Ʈ����� �۾� ������ �̸��� ������, �ϳ��� Ʈ����� �ȿ��� ������ ������ ����
-- >> ROLLBACK TO ���̺�����Ʈ�� : Ʈ����� �۾��� ����ϰ� savepoint �������� �̵�


--## DCL(Data Control Language)
-- ������ ����� --> System�������� �ؾ߸� ��
-- DB �� ���� ����, ���Ἲ, ���� �� DBMS�� �����ϱ� ���� ���
-- ���Ἲ�̶� ��Ȯ��, �ϰ����� �����ϴ� ��
-- ������� �����̳� ������ ���� ���� ó��
--## DCL�� ����
-- 1. GRANT : ���Ѻο�
-- 2. REVOKE : ����ȸ��
-- GRANT CONNECT, RESOURCE TO STUDENT; -- System�������� �����ؼ� �ؾ���!
-- CONNECT, RESOURCE�� ���̴�. ���� ������ �������� ���ִ�.
-- ���� �ʿ��� ������ ��� ������ �� ���ϰ� �ο�, ȸ���� �� ���ϴ�!
-- CONNECT�� : CREATE SESSION
-- RESOURCE�� : CREATE CLUSTER, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TABLE
--             CREATE TRIGGER, GREATE TYPE, GREATE INDEXTYPE, CREATE OPERATOR;

--## Oracle Object
-- DB�� ȿ�������� ���� �Ǵ� �����ϰ� �ϴ� ���
--## Oracle Object�� ����
-- ���̺�(TABLE), ��(VIEW), ������(SEQUENCE), �ε���(INDEX), ��Ű��(PACKAGE), 
-- ���ν���(PROCEDUAL), �Լ�(FUNCTION), Ʈ����(TRIGGER), ���Ǿ�(SYNONYM), 
-- �����(USER)

--### 1. VIEW
--> �ϳ� �̻��� ���̺��� ���ϴ� �����͸� �����Ͽ� ������ ���̺��� ����� �ִ°�
-- �ٸ� ���̺� �ִ� �����͸� ������ ���̸�, ������ ��ü�� �����ϰ� �ִ� ���� �ƴ�
-- ��, ������ġ ���� ���������� �������� �ʰ� �������̺�� �������
-- �������� ���� ���̺���� ��ũ ����
--> �並 ����ϸ� Ư�� ����ڰ� ���� ���̺� �����Ͽ� ��� �����͸� ���� �ϴ� ���� ������ �� ����.
-- �ٽø���, ���� ���̺��� �ƴ� �並 ���� Ư�� �����͸� �������� ����.
--> �並 ����� ���ؼ��� ������ �ʿ���. RESOURCE�ѿ��� ���ԵǾ����� ����!!(����)
-- GRANT CREATE VIEW TO KH; (�ý��۰������� ����)
-- VIEW�����ϱ�
CREATE VIEW V_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

CREATE VIEW V_EMP_READ
AS SELECT EMP_ID, DEPT_TITLE FROM EMPLOYEE JOIN DEPARTMET ON DEPT_CODE = DEPT_ID;


-- VIEW����
UPDATE V_EMPLOYEE
SET DEPT_CODE = 'D8'
WHERE EMP_ID = 200;

UPDATE V_EMPLOYEE
SET SALARY = 600000
WHERE EMP_ID = 200;

-- VIEW�����ϱ�
DROP VIEW V_EMPLOYEE;

--### 2. Sequence(������)
-- ���������� ���� ���� �ڵ����� �����ϴ� ��ü�� �ڵ� ��ȣ �߻���(ä����)�� ������ ��
-- CREATE SEQUENCE ��������
-- ���������� �ɼ��� 6���� ����! START WITH, INCREMENT BY, MAXVALUE, MINVALUE, CYCLE, CACHE
SELECT * FROM USER_DEFAULT;
COMMIT;
DELETE FROM USER_DEFAULT;
INSERT INTO USER_DEFAULT
VALUES(1, '�Ͽ���', DEFAULT, DEFAULT);
-- ������ ����(�ڵ���ȣ�߻��� ����)
CREATE SEQUENCE SEQ_USERNO;
-- ������� ������ Ȯ��
SELECT * FROM USER_SEQUENCES;
-- �����
INSERT INTO USER_DEFAULT
VALUES(SEQ_USERNO.NEXTVAL,'khuser01', DEFAULT, DEFAULT);
SELECT * FROM USER_DEFAULT;
INSERT INTO USER_DEFAULT
VALUES(SEQ_USERNO.NEXTVAL, 'khuser02', DEFAULT, DEFAULT);
SELECT SEQ_USERNO.CURRVAL FROM DUAL;
-- �������� INSERT�� �� ������ ���� ���������� ������!

-- NEXTVAL, CURRVAL ����� �� �ִ� ���
-- 1. ���������� �ƴ� SELECT��
-- 2. INSERT���� SELECT��
-- 3. INSERT���� VALUES��
-- 4. UPDATE���� SET��

-- CURRVAL�� ����� �� ������ ��
-- NEXTVAL�� ������ 1�� ������ �Ŀ� CURRVAL�� �� �� ����

-- ������ ����(���۰��� �ٲ� �� ����. �ٲٷ��� DROP�ϰ� �ٽ� ��������)
CREATE SEQUENCE SEQ_SAMPLE1;
SELECT * FROM USER_SEQUENCES;
ALTER SEQUENCE SEQ_SAMPLE1
INCREMENT BY 10;

-- ������ J1, J2, J3�� �ƴ� ����߿��� �ڽ��� �μ��� ��ձ޿����� ���� �޿��� �޴� 
-- ������. �μ��ڵ�, �����, �޿�, �μ��� �޿����
SELECT E.DEPT_CODE AS �μ��ڵ�, E.EMP_NAME AS �����, E.SALARY AS �޿�, AVG_SAL AS "�μ��� ��ձ޿�"
FROM EMPLOYEE E
JOIN(SELECT DEPT_CODE, CEIL(AVG(SALARY)) "AVG_SAL"
    FROM EMPLOYEE
    GROUP BY DEPT_CODE) A ON E.DEPT_CODE = A.DEPT_CODE
WHERE JOB_CODE NOT IN('J1','J2','J3') AND AVG_SAL < E.SALARY;

SELECT DEPT_CODE, CEIL(AVG(SALARY)) "AVG_SAL"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

