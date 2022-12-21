--����Ŭ�Լ�
--1. ����ó���Լ�
--LENGTH, LENGTHB(���̱���), SUBSTR(�����ڸ�), INSTR(��ġ����)
--LPAD, RPAD(ä��°�), LTRIM, RTRIM

--@�ǽ����� 
-- �������ڿ����� �յ� ��� ���ڸ� �����ϼ���.
-- '982341678934509hello89798739273402'
SELECT RTRIM(LTRIM('982341678934509hello89798739273402', '0123456789'),'0123456789')
FROM DUAL;

--@�ǽ�����
--������� ���� �ߺ����� ���������� ����ϼ���.
SELECT SUBSTR(EMP_NAME,1,1) "EMP_NAME"
FROM EMPLOYEE
ORDER BY EMP_NAME ASC;
--�ߺ����� ����ϱ�
SELECT DISTINCT SUBSTR(EMP_NAME,1,1) "EMP_NAME"
FROM EMPLOYEE
ORDER BY EMP_NAME ASC;

-- @�ǽ�����
-- employee ���̺��� ���ڸ� �����ȣ, �����, �ֹι�ȣ, ������ ��Ÿ������.
-- �ֹι�ȣ�� ��6�ڸ��� *ó���ϼ���.
SELECT EMP_ID, EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*'), SALARY*12
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '1';

--SELECT EMP_ID, EMP_NAME, SUBSTR(EMP_NO,1,8)||'******', SALARY*12
SELECT EMP_ID, EMP_NAME, CONCAT(SUBSTR(EMP_NO,1,8),'******'), SALARY*12
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = '1';

--2. ����ó���Լ�
--@�ǽ�����
--EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ��� ����غ��ÿ� 
--(SYSDATE�� ����ϸ� ���� �ð� ���)
SELECT EMP_NAME, SYSDATE-HIRE_DATE, FLOOR(SYSDATE-HIRE_DATE), ROUND(SYSDATE-HIRE_DATE)
FROM EMPLOYEE;

--3. ��¥ó���Լ�
--@�ǽ�����
--EMPLOYEE���̺��� ����� �̸�, �Ի���, �Ի� �� 3������ �� ��¥�� ��ȸ�Ͻÿ�
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3)
FROM EMPLOYEE;
--@�ǽ�����
--EMPLOYEE ���̺��� ����� �̸�, �Ի���, �ٹ� �������� ��ȸ�Ͻÿ�
SELECT EMP_NAME, HIRE_DATE, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))"PERIOD"
FROM EMPLOYEE;
--@�ǽ�����
--ex) EMPLOYEE ���̺��� ����� �̸�, �Ի���, �Ի���� ���������� ��ȸ�ϼ���
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;
--@�ǽ�����
--ex) EMPLOYEE ���̺��� ��� �̸�, �Ի� �⵵, �Ի� ��, �Ի� ���� ��ȸ�Ͻÿ�
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE)||'��'"�Ի� �⵵", EXTRACT(MONTH FROM HIRE_DATE)||'��'"�Ի� ��", EXTRACT(DAY FROM HIRE_DATE)||'��'"�Ի� ��"
FROM EMPLOYEE;

--@�ǽ�����
/*
     ���úη� �Ͽ��ھ��� ���뿡 �������ϴ�.
     ������ �Ⱓ�� 1�� 6������ �Ѵٶ�� �����ϸ�
     ù��°,�������ڸ� ���Ͻð�,
     �ι�°,�������ڱ��� �Ծ���� «���� �׸����� ���մϴ�.
     (��, 1�� 3���� �Դ´ٰ� �Ѵ�.)
*/
SELECT ADD_MONTHS(SYSDATE, 18)"��������", (ADD_MONTHS(SYSDATE, 18)-SYSDATE)*3 "«���"
FROM DUAL;
--4. ����ȯ�Լ�



-- @�Լ� �����ǽ�����
--1. ������� �̸���, �̸��� ���̸� ����Ͻÿ�
--	ex)  ȫ�浿 , hong@kh.or.kr   	  13
SELECT EMP_NAME "������", EMAIL "�̸���", LENGTH(EMAIL) "�̸��� ����"
FROM EMPLOYEE;
--�̸����� ���̰� 15���� ���� �����͸� �˻��غ��ÿ�
SELECT *
FROM EMPLOYEE
WHERE LENGTH(EMAIL) < 15;

--2. ������ �̸��� �̸��� �ּ� �� ���̵� �κи� ����Ͻÿ�
--	ex) ���ö	no_hc
--	ex) ������	jung_jh
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL, 1, INSTR(EMAIL,'@',-1,1)) 
FROM EMPLOYEE;
SELECT EMAIL, INSTR(EMAIL,'@',1,1)
FROM EMPLOYEE;

--3. 60��뿡 �¾ ������� ���, ���ʽ� ���� ����Ͻÿ�. 
--�׶� ���ʽ� ���� null�� ��쿡�� 0 �̶�� ��� �ǰ� ����ÿ�
--	    ������    ���      ���ʽ�
--	ex) ������	    1962	    0.3
--	ex) ������	    1963  	    0
SELECT TO_DATE(SUBSTR(EMP_NO,1,2),'RR') FROM EMPLOYEE;
SELECT EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) FROM EMPLOYEE;

SELECT EMP_NAME"������", '19'||SUBSTR(EMP_NO,1,2)"���" , NVL(BONUS,0)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 1, 1)=6;

--�ٽú���
--4. '010' �ڵ��� ��ȣ�� ���� �ʴ� ����� ���� ����Ͻÿ� (�ڿ� ������ ���� ���̽ÿ�)
--	   �ο�
--	ex) 3��
SELECT EMP_NAME
FROM EMPLOYEE;
WHERE PHONE;
--���ذ�

--5. ������� �Ի����� ����Ͻÿ� 
--	��, �Ʒ��� ���� ��µǵ��� ����� ���ÿ�
--	    ������		�Ի���
--	ex) ������		2012�� 12��
--	ex) ������		1997�� 3��
SELECT EMP_NAME"������", EXTRACT(YEAR FROM HIRE_DATE)||'�� '||EXTRACT(MONTH FROM HIRE_DATE)||'��' "�Ի���"
FROM EMPLOYEE;

--6. ������� �ֹι�ȣ�� ��ȸ�Ͻÿ�
--	��, �ֹι�ȣ 9��° �ڸ����� �������� '*' ���ڷ� ä������� �Ͻÿ�
--	ex) ȫ�浿 771120-1******
SELECT EMP_NAME"������", SUBSTR(EMP_NO,1,8)||'******'"�ֹι�ȣ"
FROM EMPLOYEE;

--�ٽú���
--7. ������, �����ڵ�, ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--     ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���
SELECT EMP_NAME"������", JOB_CODE"�����ڵ�", TO_CHAR((SALARY*12+(SALARY*NVL(BONUS,0))),'L999,999,999')"����", NVL(BONUS,0)
FROM EMPLOYEE;


--8. �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� �����߿� ��ȸ��.
--   ��� ����� �μ��ڵ� 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5','D9') AND EXTRACT(YEAR FROM HIRE_DATE)=2004;

--9. ������, �Ի���, ���ñ����� �ٹ��ϼ� ��ȸ 
--	* �ָ��� ���� , �Ҽ��� �Ʒ��� ����
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE-HIRE_DATE)
FROM EMPLOYEE;

--�ٽú���
--10. ������, �μ��ڵ�, �������, ����(��) ��ȸ
--   ��, ��������� �ֹι�ȣ���� �����ؼ�, 
--   ���������� ������ �����Ϸ� ��µǰ� ��.
--   ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, �����
--	* �ֹι�ȣ�� �̻��� ������� ���ܽ�Ű�� ���� �ϵ���(200,201,214 �� ����)
--	* HINT : NOT IN ���
SELECT TO_CHAR(TO_DATE('19'||EMP_NO),'YYYY"��" MM"��" DD"��"') FROM EMPLOYEE;
SELECT EMP_NAME, DEPT_CODE, '19'||SUBSTR(EMP_NO,1,2)||'�� ' ||SUBSTR(EMP_NO,3,2)||'�� '||SUBSTR(EMP_NO,5,2)||'��' "�������",
--����ó���Լ�
EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR'))||'�� '||
EXTRACT(MONTH FROM TO_DATE(SUBSTR(EMP_NO,3,2),'MM'))||'�� '||
EXTRACT(DAY FROM TO_DATE(SUBSTR(EMP_NO,5,2),'DD'))||'��'"�������2",
--��¥ó���Լ�
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2),'RR')) AS "����(��)",
--��¥ó���Լ�
EXTRACT(YEAR FROM SYSDATE) - (1900 + TO_NUMBER(SUBSTR(EMP_NO,1,2))) AS ����,
--����ó���Լ�
EXTRACT(YEAR FROM SYSDATE) - (DECODE(SUBSTR(EMP_NO,8,1),'1',1900,'2',1900,'3',2000,'4',2000) + TO_NUMBER(SUBSTR(EMP_NO,1,2))) AS ����2
FROM EMPLOYEE
WHERE EMP_ID NOT IN(200, 201, 214);
--������ȸ���� �ٽ��ϱ�

--11. ������, �μ����� ����ϼ���.
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.(case ���)
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ�ϰ�, �μ��ڵ� �������� �������� ������.
SELECT EMP_NAME"�����",
DECODE(DEPT_CODE,'D5','�ѹ���','D6','��ȹ��','D9','������') "�μ���"
--CASE WHEN DEPT_CODE = 'D5' THEN '�ѹ���'
  --  WHEN DEPT_CODE = 'D6' THEN '��ȹ��'
    --WHEN DEPT_CODE = 'D9' THEN '������' END "�μ���"
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D9')
ORDER BY DEPT_CODE ASC;

------------------------------------------------------------------------------------
-- ���� �ǽ� ����
-- ����1. 
-- �Ի����� 5�� �̻�, 10�� ������ ������ �̸�,�ֹι�ȣ,�޿�,�Ի����� �˻��Ͽ���
SELECT EMP_NAME AS �̸�, EMP_NO AS �ֹι�ȣ, SALARY AS �޿�, HIRE_DATE AS �Ի���
FROM EMPLOYEE
WHERE CEIL((SYSDATE-HIRE_DATE)/365) BETWEEN 5 AND 10;

-- ����2.
-- �������� �ƴ� ������ �̸�,�μ��ڵ�, �����, �ٹ��Ⱓ, �������� �˻��Ͽ��� 
--(��� ���� : ENT_YN)
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE, (ENT_DATE-HIRE_DATE), ENT_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'Y';

-- ����3.
-- �ټӳ���� 10�� �̻��� �������� �˻��Ͽ�
-- ��� ����� �̸�,�޿�,�ټӳ��(�Ҽ���X)�� �ټӳ���� ������������ �����Ͽ� ����Ͽ���
-- ��, �޿��� 50% �λ�� �޿��� ��µǵ��� �Ͽ���.
SELECT EMP_NAME, SALARY*1.5, CEIL((SYSDATE-HIRE_DATE)/365)"�ټӳ��"
FROM EMPLOYEE
--WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) >= 10
WHERE CEIL((SYSDATE-HIRE_DATE)/365) >=10
ORDER BY 3 ASC;

-- ����4.
-- �Ի����� 99/01/01 ~ 10/01/01 �� ��� �߿��� �޿��� 2000000 �� ������ �����
-- �̸�,�ֹι�ȣ,�̸���,����ȣ,�޿��� �˻� �Ͻÿ�
SELECT EMP_NAME, EMAIL, PHONE, SALARY
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '99/01/01' AND '10/01/01' AND SALARY <= 2000000;

-- ����5.
-- �޿��� 2000000�� ~ 3000000�� �� ������ �߿��� 4�� �����ڸ� �˻��Ͽ� 
-- �̸�,�ֹι�ȣ,�޿�,�μ��ڵ带 �ֹι�ȣ ������(��������) ����Ͽ���
-- ��, �μ��ڵ尡 null�� ����� �μ��ڵ尡 '����' ���� ��� �Ͽ���.
SELECT EMP_NAME, EMP_NO, SALARY, NVL(DEPT_CODE,'����')
FROM EMPLOYEE
WHERE (SALARY BETWEEN 2000000 AND 3000000)  
--AND (SUBSTR(EMP_NO,8,1) = 2)AND (SUBSTR(EMP_NO,4,1) = 4)
AND EMP_NO LIKE '__04__-2%'
ORDER BY EMP_NO DESC;

-- ����6.
-- ���� ��� �� ���ʽ��� ���� ����� ���ñ��� �ٹ����� �����Ͽ� 
-- 1000�� ����(�Ҽ��� ����) 
-- �޿��� 10% ���ʽ��� ����Ͽ� �̸�,Ư�� ���ʽ� (��� �ݾ�) ����� ����Ͽ���.
-- ��, �̸� ������ ���� ���� �����Ͽ� ����Ͽ���.
SELECT EMP_NAME, FLOOR(SYSDATE-HIRE_DATE), SUBSTR(FLOOR(SYSDATE-HIRE_DATE),-4,1)*SALARY*0.1 "Ư�� ���ʽ�"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1)=1 AND BONUS IS NULL
ORDER BY EMP_NAME ASC;