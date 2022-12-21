--ORACLE DAY05
--�׷��Լ�
--�������� ���� ���� �� ���� ����� ������ �Լ�
--SUM, AVG, COUNT, MAX, MIN

--@�ǽ�����
--1. [EMPLOYEE] ���̺��� ���� ����� �޿� �� ���� ���
SELECT TO_CHAR(SUM(SALARY),'L999,999,999,999')"�޿� �� ��"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

--2. [EMPLOYEE]���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ������ ���
SELECT TO_CHAR(SUM(SALARY*12 + SALARY*NVL(BONUS,0)),'L999,999,999,999')"���ʽ� ���� ����"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--3. [EMOLOYEE]���̺��� �� ����� ���ʽ� ����� �Ҽ� ��°�ڸ����� �ݿø��Ͽ� ���Ͽ���
SELECT ROUND(AVG(NVL(BONUS,0)),2)
FROM EMPLOYEE;

--4. [EMPLOYEE] ���̺��� D5 �μ��� ���� �ִ� ����� ���� ��ȸ
SELECT COUNT(EMP_NAME)"����� ��"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--EX) EMPLOYEE ���̺� ����� �������� ���� ���Ͻÿ�
SELECT COUNT(*) --�ӵ��� ���� ����
FROM EMPLOYEE;

--5. [EMPLOYEE] ���̺��� ������� �����ִ� �μ��� ���� ��ȸ (NULL�� ���ܵ�)
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

--6. [EMPLOYEE] ���̺��� ��� �� ���� ���� �޿��� ���� ���� �޿��� ��ȸ
SELECT TO_CHAR(MAX(SALARY),'L999,999,999,999')"�ִ�", TO_CHAR(MIN(SALARY),'L999,999,999,999')"�ּ�"
FROM EMPLOYEE;

--7. [EMPLOYEE] ���̺��� ���� ������ �Ի��ϰ� ���� �ֱ� �Ի����� ��ȸ�Ͻÿ�
SELECT MAX(HIRE_DATE)"�ֱ� �Ի���", MIN(HIRE_DATE)"������ �Ի���"
FROM EMPLOYEE;

--#GROUP BY ��
--������ �׷� �������� ����� �׷��Լ��� �� �Ѱ��� ������� �����ϱ� ������
--�׷��Լ��� �̿��Ͽ� �������� ������� �����ϱ� ���ؼ���
--�׷��Լ��� ����� �׷��� ������ GROUP BY���� ����Ͽ� ����ؾ���.
--EX) �μ����� �޿����� ���ϰ�ʹ�
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE;

--EX) ���޺��� �޿��� ���ϱ�
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

--[EMPLOYEE] ���̺��� �μ��ڵ� �׷캰 �޿��� �հ�, �׷캰 �޿��� ���(����ó��),
--�ο����� ��ȸ�ϰ�, �μ��ڵ� ������ ����
SELECT DEPT_CODE"�μ��ڵ�", TO_CHAR(SUM(SALARY),'L999,999,999')"�հ�", TO_CHAR(ROUND(AVG(SALARY)),'L999,999,999')"���", COUNT(*)"�ο���"
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--[EMPLOYEE] ���̺��� �μ��ڵ� �׷캰, ���ʽ��� ���޹޴� ��� ���� ��ȸ�ϰ� 
--�μ��ڵ� ������ ����. BONUS�÷��� ���� �����Ѵٸ�, �� ���� 1�� ī����.
--���ʽ��� ���޹޴� ����� ���� �μ��� ����.
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

--@�ǽ�����
--1. EMPLOYEE ���̺��� ������ J1�� �����ϰ�, ���޺� ����� �� ��ձ޿��� ����ϼ���.
SELECT JOB_CODE"�����ڵ�",COUNT(EMP_NAME)"���޺� �����", TO_CHAR(ROUND(AVG(SALARY)),'L999,999,999,999')"��ձ޿�"
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

--2. EMPLOYEE���̺��� ������ J1�� �����ϰ�,  
--�Ի�⵵�� �ο����� ��ȸ�ؼ�, �Ի�� �������� �������� �����ϼ���.
SELECT EXTRACT(YEAR FROM HIRE_DATE)"�Ի�⵵", COUNT(EMP_NAME)"�ο���"
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY EXTRACT(YEAR FROM HIRE_DATE)
ORDER BY EXTRACT(YEAR FROM HIRE_DATE) ASC;

--3. [EMPLOYEE] ���̺��� EMP_NO�� 8��° �ڸ��� 1, 3 �̸� '��', 
--2, 4 �̸� '��'�� ����� ��ȸ�ϰ�,
-- ������ �޿��� ���(����ó��), �޿��� �հ�, �ο����� ��ȸ�� �� 
--�ο����� ���������� ���� �Ͻÿ�
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','��','3','��','2','��','4','��')"����",
ROUND(AVG(SALARY))"���", SUM(SALARY)"�޿��հ�", COUNT(EMP_NAME)"�ο���"
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','��','3','��','2','��','4','��')
ORDER BY COUNT(EMP_NAME) DESC;

--4. �μ��� ���� �ο����� ���ϼ���.
SELECT DEPT_CODE"�μ��ڵ�", COUNT(EMP_NAME)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
--���ذ�

--5. �μ��� �޿� ����� 3,000,000��(��������) �̻���  �μ��鿡 ���ؼ� 
--�μ���, �޿������ ����ϼ���.
SELECT DEPT_CODE, AVG(SALARY)"���"
FROM EMPLOYEE
GROUP BY DEPT_CODE
WHERE (��� >= 3000000);
--���ذ�
