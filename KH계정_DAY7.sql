--## ��������(SubQuery)
--> �ϳ��� SQL�� �ȿ� ���ԵǾ� �ִ� �� �ٸ� SQL��(SELECT)
--> ���������� ���������� �����ϴ� �������� ����
--## Ư¡
--> ���������� �������� �����ʿ� ��ġ�ؾ� ��
--> ���������� �ݵ�� �Ұ�ȣ�� ����� �� (SELECT......)

-- ex1) ������ ������ ������ �̸��� ����ض�
SELECT EMP_ID, EMP_NAME, MANAGER_ID 
FROM EMPLOYEE;
-- STEP1. ������ ������ ������ ID�� �����ΰ�?
SELECT MANAGER_ID FROM EMPLOYEE
WHERE EMP_NAME = '������'; -- 214
-- STEP2. ������ ID�� ������ �̸��� ���Ѵ�.
SELECT EMP_NAME FROM EMPLOYEE
WHERE EMP_ID = 214;
-- ���������� �ѹ濡 �ذ��غ���
SELECT EMP_NAME FROM EMPLOYEE 
WHERE EMP_ID = (SELECT MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME = '������');

-- ex2) �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������ 
-- ���, �̸�, �����ڵ�, �޿��� ��ȸ�Ͻÿ�
-- STEP1.�� ������ ��ձ޿��� ���ΰ�?
SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE; -- 3047662
-- STEP2.��ձ޿����� �޿��� ���� �����ǻ��, �̸�, �����ڵ�, �޿���ȸ
SELECT EMP_ID AS ���, EMP_NAME AS �̸�, JOB_CODE AS �����ڵ�, SALARY AS �޿�
FROM EMPLOYEE
WHERE SALARY > 3047662;
-- �ѹ濡 �ذ��ϱ�
SELECT EMP_ID AS ���, EMP_NAME AS �̸�, JOB_CODE AS �����ڵ�, SALARY AS �޿�
FROM EMPLOYEE
WHERE SALARY > (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE);

--## ��������(Sub Query)�� ����
-- 1. ������ ��������(���������� ������ ����� �� �ϳ��� ����. ������� ����)
-- 2. ������ ��������
-- 3. ���߿� ��������
-- 4. ������ ���߿� ��������
-- 5. ��(ȣ��)�� ��������
-- 6. ��Į�� ��������
--### 1. ������ ��������
-- ���������� ��ȸ �����(��, Ʃ��, ���ڵ�)�� ������ 1�� �϶�
--### 2. ������ ��������
-- ���������� ��ȸ �����(��, Ʃ��, ���ڵ�)�� ������ ������ �϶�
-- ������ �������� �տ��� �Ϲ� �񱳿����� ���Ұ�(IN/NOT IN, ANY, ALL, EXIST)
-- 2.1 IN
-- ������ �������� ��� �߿��� �ϳ��� ��ġ�ϴ� ��, OR
-- ex) �����⳪ �ڳ��� ���� �μ��� ���� ����� ���� ���
-- STEP1. ������ �μ��ڵ� ���ϰ� �ڳ��� �μ��ڵ� ���ؾ���
SELECT DEPT_CODE FROM EMPLOYEE
WHERE EMP_NAME IN ('������','�ڳ���'); -- D9, D5
-- STEP2. ���� �μ��ڵ�� ���� ���
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D9');
-- �ѹ濡
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IN 
(SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME IN ('������','�ڳ���'));


-- @�ǽ�����
-- ���¿�, ������ ����� �޿����(emplyee���̺��� sal_level�÷�)�� ���� ����� 
-- ���޸�, ������� ���.
-- STEP1. ������ ������ ����� �޿���� ���
SELECT SAL_LEVEL FROM EMPLOYEE WHERE EMP_NAME IN ('���¿�','������'); -- S4,S5
-- STEP2. �޿���� ������� ���޸�, ����� ���
SELECT JOB_NAME AS ���޸�, EMP_NAME AS �����
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE SAL_LEVEL IN ('S4','S5');
-- �ѹ濡
SELECT JOB_NAME AS ���޸�, EMP_NAME AS ����� FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE SAL_LEVEL IN (SELECT SAL_LEVEL FROM EMPLOYEE WHERE EMP_NAME IN ('���¿�','������'));

-- 2. ASIA1������ �ٹ��ϴ� ��� �������, �μ��ڵ�, �����
SELECT DEPT_CODE AS �μ��ڵ�, EMP_NAME AS ����� FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE LOCATION_ID = (SELECT LOCAL_CODE FROM LOCATION WHERE LOCAL_NAME = 'ASIA1');
--��
SELECT DEPT_CODE AS �μ��ڵ�, EMP_NAME AS ����� FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_ID FROM DEPARTMENT
JOIN LOCATION  ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME = 'ASIA1');

-- 2.2 NOT IN
-- ������ �������� ��� �߿��� �ϳ��� ��ġ���� �ʴ� ��
-- @�ǽ�����
-- ������ ��ǥ, �λ����� �ƴ� ��� ����� �μ����� ���
-- STEP1. ��ǥ, �λ��� JOB_CODE ���ϱ�
SELECT JOB_CODE FROM JOB WHERE JOB_NAME IN ('��ǥ','�λ���'); -- J1,J2
-- STEP2. ���� JOB_CODE �������� �ֱ�
SELECT EMP_NAME AS ������, JOB_CODE AS �����ڵ� FROM EMPLOYEE 
WHERE JOB_CODE NOT IN ('J1','J2');
-- �ѹ濡
SELECT EMP_NAME AS ������, DEPT_CODE AS �μ��ڵ� FROM EMPLOYEE
WHERE JOB_CODE NOT IN (SELECT JOB_CODE FROM JOB WHERE JOB_NAME IN ('��ǥ','�λ���'))
GROUP BY DEPT_CODE, EMP_NAME
ORDER BY 2;

--### 3. ���߿� ��������
--### 4. ������ ���߿� ��������
--### 5. ��(ȣ��)�� ��������
-- ���������� ���� ���������� �ְ� ���������� ������ ���� �� �����
-- �ٽ� ���������� ��ȯ�ؼ� �����ϴ� ����
-- ���������� WHERE�� ������ ���ؼ��� ���������� ���� ����Ǵ� ����
-- �������� ���̺��� ���ڵ�(��)�� ���� ���������� ��� ���� �ٲ�
-- �����ϱ�! : ���������� �ִ� ���� ���������� ������ ���� ��� ��������
-- �׷��� �ʰ� ���������� �ܵ����� ���Ǹ� �Ϲ� ��������
-- �Ϲ� ��������
SELECT EMP_NAME, SALARY
FROM EMPLOYEE WHERE JOB_CODE = (SELECT JOB_CODE FROM JOB WHERE JOB_NAME = '��ǥ');
-- ��� ��������
SELECT EMP_NAME, SALARY
FROM EMPLOYEE WHERE EXISTS (SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE = 'D5');

-- ���������� �Ѹ��̶� �ִ� ������ ����Ͻÿ�.
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E WHERE EXISTS (SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);

-- DEPT_CODE�� ���� ����� ����Ͻÿ�.
SELECT EMP_NAME FROM EMPLOYEE WHERE DEPT_CODE IS NULL;
-- ������������Ἥ �غ���
SELECT EMP_NAME FROM EMPLOYEE E WHERE NOT EXISTS (SELECT 1 FROM DEPARTMENT WHERE DEPT_ID = E.DEPT_CODE);
-- ������������ ������ ��ߵǴ� �÷��� �����ΰ�? DEPT_CODE
-- �� ���� ��� ���̺��� ��ߵǴ°�? DEPARTMENT

-- ���� ���� �޿��� �޴� ����� exists ��� ���������� �̿��ؼ� ���϶�.(�����)
SELECT EMP_NAME FROM EMPLOYEE E WHERE NOT EXISTS (SELECT 1 FROM EMPLOYEE WHERE SALARY > E.SALARY);
-- ���� ���� �޿��� �޴� ����� exists ��� ���������� �̿��ؼ� ���϶�.
SELECT EMP_NAME FROM EMPLOYEE E WHERE NOT EXISTS (SELECT 1 FROM EMPLOYEE WHERE SALARY < E.SALARY);
-- ������ J1, J2, J3�� �ƴ� ����߿��� �ڽ��� �μ��� ��ձ޿����� ���� �޿��� �޴� ������.
-- �μ��ڵ�, �����, �޿�, �μ��� �޿����

--### 6. ��Į�� ��������
-- ������� 1���� ���������, SELECT������ ����
--### 6.1 ��Į�� �������� - SELECT��
-- ex) ��� ����� ���, �̸�, �����ڻ��, �����ڸ��� ��ȸ�ϼ���
SELECT EMP_ID, EMP_NAME, MANAGER_ID, (SELECT EMP_NAME FROM EMPLOYEE M WHERE M.EMP_ID = E.MANAGER_ID)
FROM EMPLOYEE E;
-- @�ǽ�����
-- 1. �����, �μ���, �μ��� ����ӱ��� ��Į�󼭺������� �̿��ؼ� ����ϼ���.
SELECT EMP_NAME AS �����, DEPT_TITLE AS �μ���, (SELECT ROUND(AVG(SALARY)) FROM EMPLOYEE WHERE DEPT_CODE = D.DEPT_ID) "�μ��� ����ӱ�"
FROM EMPLOYEE
JOIN DEPARTMENT D ON DEPT_CODE = DEPT_ID;

--### 6.2 ��Į�� �������� - WHERE��
-- ex) �ڽ��� ���� ������ ��� �޿����� ���� �޴� ������ �̸�, ����, �޿��� ��ȸ�ϼ���.

--### 6.3 ��Į�� �������� - ORDER BY��
-- ex) ��� ������ ���, �̸�, �ҼӺμ��� ��ȸ �� �μ����� ������������ �����ϼ���.



--### 7. �ζ��� �� (FROM�������� ��������)
-- FROM���� ���������� ����� ���� �ζ��κ�(INLINE-VIEW)��� ��.
SELECT DEPT_ID, DEPT_TITLE
FROM
(SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT);

SELECT EMP_ID, SALARY
FROM
(SELECT EMP_NAME, EMP_ID, SALARY, EMP_NO FROM EMPLOYEE);

-- VIEW��??
-- �������̺� �ٰ��� ������ ������ ���̺�(����ڿ��� �ϳ��� ���̺�ó�� ��밡���ϰ� ��)
-- VIEW�� ����
-- 1. Stored View : ���������� ��밡�� -> ����Ŭ ��ü
-- 2. Inlined View : FROM ���� ����ϴ� ��������, 1ȸ��

--@�ǽ�����
--1. employee���̺��� 2010�⵵�� �Ի��� ����� 
--���, �����, �Ի�⵵�� �ζ��κ並 ����ؼ� ���.
SELECT *
FROM 
(SELECT EMP_ID AS ���, EMP_NAME AS �����, EXTRACT(YEAR FROM HIRE_DATE) AS �Ի�⵵
 FROM EMPLOYEE)
WHERE �Ի�⵵ BETWEEN 2010 AND 2019;

--2. employee���̺��� ����� 30��, 40���� ���ڻ���� 
--���, �μ���, ����, ���̸� �ζ��κ並 ����ؼ� ����϶�.(LEFT JOIN�� ��� NULL���� ��µȴ�)
SELECT *
FROM 
(SELECT EMP_ID AS ���, DEPT_TITLE AS �μ���,
DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��') AS ����,
EXTRACT(YEAR FROM SYSDATE) - ('19'||(SUBSTR(EMP_NO,1,2))) AS ����
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID)
WHERE ���� = '��' AND ���� BETWEEN 30 AND 49;
--��
SELECT *
FROM
(SELECT EMP_ID AS ���
, (SELECT DEPT_TITLE FROM DEPARTMENT WHERE DEPT_ID = E.DEPT_CODE) AS �μ���
, DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��') AS ����
, EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(EMP_NO,1,2))) AS ����
FROM EMPLOYEE E)
WHERE ���� = '��' AND FLOOR(����/10) IN (3,4);


--## �������
--### 1. TOP-N�м�
--### 2. WITH
--### 3. ������ ����(Hierarchical Query)
--### 4. ������ �Լ�
--#### 4.1 ���� �Լ�

