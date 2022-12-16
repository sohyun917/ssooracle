CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

DESC USER_GRADE;

INSERT INTO USER_GRADE
VALUES(10, '�Ϲ�ȸ��');
INSERT INTO USER_GRADE
VALUES(20, '���ȸ��');
INSERT INTO USER_GRADE
VALUES(30, 'Ư��ȸ��');

--���⼭���� �ڽ��۾�
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
VALUES(1, 'user01', 'pass01','�Ͽ���', '��', 'user01@iei.com', 10);
INSERT INTO USER_FOREIGNKEY
VALUES(2, 'user02', 'pass02','�̿���', '��', 'user02@iei.com', 20);
INSERT INTO USER_FOREIGNKEY
VALUES(3, 'user03', 'pass03','�����', '��', 'user03@iei.com', 30);
INSERT INTO USER_FOREIGNKEY
VALUES(4, 'user04', 'pass04','�����', '��', 'user04@iei.com', 40);
SELECT GRADE_CODE, GRADE_NAME FROM USER_GRADE;

SELECT EMP_NAME, SALARY, SALARY*12 "����(���ʽ� ������)", BONUS, (SALARY*BONUS + SALARY*12) AS "����(���ʽ� ����)"
FROM EMPLOYEE
WHERE SALARY > 3000000 AND EMP_NAME = '������';

--SALARY�� �������� ������������(ASC)
--SALARY�� �������� ������������(DESC)
--NULL�� �����ϴ� �÷�����?
--ASC�϶� NULL�� �� �Ʒ���, DESC�϶� NULL�� �� ����
SELECT EMP_NAME, SALARY, SALARY*12 "����(���ʽ� ������)", BONUS, (SALARY*BONUS + SALARY*12) AS "����(���ʽ� ����)"
FROM EMPLOYEE
WHERE SALARY > 3000000 OR EMP_NAME = '������'
ORDER BY BONUS ASC;
--FROM -> WHERE -> SELECT -> ORDER BY
--ORDER BY�� �� �������� ����ȴ�.

--BETWEEN A AND B, �񱳿�����
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
--WHERE SALARY > 2000000 AND SALARY < 6000000;
WHERE SALARY BETWEEN 2000000 AND 6000000;

--OR�� ����ϴ� ������
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8';
WHERE DEPT_CODE IN('D6', 'D8');

--IS NULL / IS NOT NULL������(NULL���� �ֵ鸸 OR NULL���� �ƴ� �ֵ鸸)
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

--LIKE������
--���� ���� ���� ������ �̸��� �޿��� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

--EMPLOYEE���̺��� �̸��� ���� ������ ������ ����� �̸��� ����Ͻÿ�.
--���ϵ�ī��
--1. % : 0�� �̻��� ��� ���ڸ� ��Ī
--2. _(�����) : �ϳ��� �ڸ��� �ش��ϴ� ��� ���ڸ� ��Ī
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '__��';


-- �ǽ�����
--1. EMPLOYEE ���̺��� �̸� ���� ������ ������ ����� �̸��� ����Ͻÿ�
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

--2. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ��
--����Ͻÿ�
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--3. EMPLOYEE ���̺��� �����ּ��� 's'�� ���鼭, DEPT_CODE�� D9 �Ǵ� D6�̰�
--������� 90/01/01 ~ 01/12/01�̸鼭, ������ 270�����̻��� ����� ��ü ������ ����Ͻÿ�
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '%s%' 
AND DEPT_CODE IN ('D9', 'D6') 
AND HIRE_DATE BETWEEN '90/01/01' AND '01/12/01'
AND SALARY >= 2700000;

--4. EMPLOYEE ���̺��� EMAIL ID �� @ ���ڸ��� 5�ڸ��� ������ ��ȸ�Ѵٸ�?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';

--5. EMPLOYEE ���̺��� EMAIL ID �� '_' ���ڸ��� 3�ڸ��� ������ ��ȸ�Ѵٸ�?
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
--���ذ�

--6. ������(MANAGER_ID)�� ���� �μ� ��ġ(DEPT_CODE)�� ���� ����  ������ �̸� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--7. �μ���ġ�� ���� �ʾ����� ���ʽ��� �����ϴ� ���� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;
