--#ROLL UP�� CUBE
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY 1;

--�μ� �� ���޺� �޿� �հ�
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY 1;
--�μ����հ�� ��ü�հ����

SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1;
--�μ����հ�, ���޺��հ�, ��ü�հ� ��µ�

--���տ�����
--������ -> INTERSECT
--������ -> UNION(�����պκ��� �ѹ��� ����.), UNION ALL(�����պκ��� ������ ���ش�)
--������ -> MINUS
--ResultSet�� ������?
--�ؿ� ��µǴ°�(ResultSet������ ������, �������� ����ϴ°�)
--�����տ���
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;
--�����տ���
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;
--�����տ���
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_NAME, EMP_ID FROM EMPLOYEE WHERE SALARY >= 2400000;

--UNION�� ����!!
--1. SELECT���� �÷� ������ �ݵ�� ���ƾ� ��
--2. �÷��� ������Ÿ���� �ݵ�� ���ų� ��ȯ�����ؾ���(ex. CHAR - VARCHAR2)

--#���ι�(JOIN)
--���� ���̺��� ���ڵ带 �����Ͽ� �ϳ��� ���� ǥ���� ��
--�� �� �̻��� ���̺��� �������� ������ �ִ� �����͵��� �÷� �������� �з��Ͽ� 
--���ο� ������ ���̺��� �̿��Ͽ� �����
--�ٽø���, ���� �ٸ� ���̺��� ������ ���밪�� �̿������μ� �ʵ带 ��ȸ��.

--11. ������, �μ����� ����ϼ���.
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.(case ���)
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ�ϰ�, �μ��ڵ� �������� �������� ������.
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5', 'D6', 'D9');
SELECT * FROM DEPARTMENT;

SELECT EMP_NAME, DEPT_CODE FROM EMPLOYEE;
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;
--SELECT �÷��� FROM ���̺� JOIN ���̺� ON �÷���1 = �÷���2
SELECT EMP_NAME, DEPT_TITLE FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
--ANSIǥ�ر���
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID;
--����Ŭ ���뱸��

--JOIN�� ����1
--1. Equi-JOIN : �Ϲ������� ���, =�� ���� ����
--2. NON-Equi-JOIN : ���������� �ƴ� BETWEEN AND, IS NULL, IS NOT NULL, IN, NOT IN������ ���

-- @�ǽ�����
--1. �μ���� �������� ����ϼ���. DEPARTMENT, LOCATION ���̺� �̿�
SELECT DEPT_TITLE, LOCAL_NAME FROM DEPARTMENT JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--2. ������ ���޸��� ����ϼ���. EMPLOYEE, JOB ���̺� �̿�
--�÷����� ������ ��� ���� ������ ����� ����� �� �ִ�.
SELECT EMP_NAME, JOB_NAME FROM EMPLOYEE JOIN JOB ON EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
SELECT EMP_NAME, JOB_NAME FROM EMPLOYEE EMP JOIN JOB JB ON EMP.JOB_CODE = JB.JOB_CODE;
SELECT EMP_NAME, JOB_NAME FROM EMPLOYEE JOIN JOB USING(JOB_CODE);

--3. ������� �������� ����ϼ���. LOCATION, NATIONAL���̺� �̿�
SELECT * FROM LOCATION;
SELECT * FROM NATIONAL;
SELECT NATIONAL_NAME, LOCAL_NAME FROM NATIONAL JOIN LOCATION USING(NATIONAL_CODE);

--#INNER JOIN
--##INNER EQUI JOIN

--#JOIN�� ����2
--INNER JOIN(��������) : �Ϲ������� ����ϴ� ����(������), ���� �����ʹ� ��������Ѵ�.
--OUTER JOIN(�ܺ�����) : ������, ��� ���, ���� �����͵� ������ش�.
--->1. LEFT (OUTER) JOIN
--->2. RIGHT (OUTER) JOIN
--->3. FULL (OUTER) JOIN
SELECT EMP_NAME, DEPT_TITLE 
FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

SELECT EMP_NAME, DEPT_TITLE 
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
--���� ���̺�(EMPLOYEE)�� ��� �����͸� �����. ��Ī�Ǵ� �����Ͱ� ���
SELECT EMP_NAME, DEPT_TITLE 
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE = DEPT_ID(+);
--����Ŭ ���뱸��(�÷����� �������� ���̺��� ���� ����Ѵ�.)

SELECT EMP_NAME, DEPT_TITLE 
FROM EMPLOYEE RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
--������ ���̺��� ���� �� �������.
SELECT EMP_NAME, DEPT_TITLE 
FROM EMPLOYEE, DEPARTMENT WHERE DEPT_CODE(+) = DEPT_ID;
--����Ŭ ���뱸��(�÷����� �������� ���̺��� ���� ����Ѵ�.)

SELECT EMP_NAME, DEPT_TITLE 
FROM EMPLOYEE FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
--�� ���̺��� ���� �� ������ش�.

--ex) OUTER JOIN(�ܺ�����)�� ���캸��
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

SELECT EMP_NAME, DEPT_TITLE
FROM DEPARTMENT LEFT JOIN EMPLOYEE ON DEPT_ID = DEPT_CODE;

--#JOIN�� ����3
--1. ��ȣ����(CROSS JOIN)
--2. ��������(SELF JOIN)
--3. ��������
---> �������� ���ι��� �ѹ��� ����� �� ����(�����߿�)
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;

--@�ǽ�����
-- 1. ������ �븮�̸鼭, ASIA ������ �ٹ��ϴ� ���� ��ȸ
-- ���, �̸� ,���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
SELECT 
    EMP_ID"���"
    , EMP_NAME"�̸�"
    , JOB_NAME"���޸�"
    , DEPT_TITLE"�μ���"
    ,LOCAL_NAME"�ٹ�������"
    , SALARY"�޿�"
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE JOB_NAME = '�븮' AND LOCAL_NAME IN ('ASIA1', 'ASIA2', 'ASIA3');
--WHERE JOB_NAME = '�븮' AND LOCAL_NAME LIKE 'ASIA%';


--@���νǽ�����_kh
--1. 2022�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT SYSDATE
FROM DUAL;
--���ذ�

--2. �ֹι�ȣ�� 1970��� ���̸鼭 ������ �����̰�, ���� ������ �������� 
--�����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.
SELECT EMP_NAME"�����", EMP_NO"�ֹι�ȣ", DEPT_TITLE"�μ���", JOB_NAME"���޸�"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
JOIN JOB USING (JOB_CODE)
WHERE SUBSTR(EMP_NO,1,1) = 7 AND SUBSTR(EMP_NO,8,1) = 2 AND SUBSTR(EMP_NAME,1,1) = '��';

--3. �̸��� '��'�ڰ� ���� �������� ���, �����, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_ID"���", EMP_NAME"�����", DEPT_TITLE"�μ���"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME LIKE '%��%';


--5. �ؿܿ����ο� �ٹ��ϴ� �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_NAME"�����", JOB_NAME"���޸�", DEPT_CODE"�μ��ڵ�", DEPT_TITLE"�μ���"
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE DEPT_CODE IN ('D5','D6','D7');

--6. ���ʽ�����Ʈ�� �޴� �������� �����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME"�����", BONUS"���ʽ�����Ʈ", DEPT_TITLE"�μ���", LOCAL_NAME"�ٹ�������"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE BONUS IS NOT NULL;

--7. �μ��ڵ尡 D2�� �������� �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME"�����", JOB_NAME"���޸�", DEPT_TITLE"�μ���", LOCAL_NAME"�ٹ�������"
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE DEPT_CODE = 'D2';

--8. �޿�������̺��� �ִ�޿�(MAX_SAL)���� ���� �޴� �������� 
--�����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
-- (������̺�� �޿�������̺��� SAL_LEVEL�÷��������� ������ ��)
--> ������ �������� ����!!!
SELECT EMP_NAME"�����", JOB_NAME"���޸�", SALARY"�޿�", SALARY*12"����"
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);
--WHERE �޿�������̺��� �ִ�޿����� ���� �޴� ����
--���ذ�

--9. �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� �����, �μ���, ������, �������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME"�����", DEPT_TITLE"�μ���", LOCAL_NAME"������", NATIONAL_NAME"������"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME IN ('�ѱ�', '�Ϻ�');

--10. ���ʽ�����Ʈ�� ���� ������ �߿��� ������ ����� ����� �������� 
--�����, ���޸�, �޿��� ��ȸ�Ͻÿ�. ��, join�� IN ����� ��
SELECT EMP_NAME"�����", DEPT_TITLE"���޸�", SALARY"�޿�"
FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE BONUS IS NULL AND DEPT_CODE='D4';
--���ذ�

--11. �������� ������ ����� ������ ���� ��ȸ�Ͻÿ�.
SELECT ENT_YN"��翩��", COUNT(*)"������ ��"
FROM EMPLOYEE
GROUP BY ENT_YN;