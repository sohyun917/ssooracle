--����� ���� ����, ���Ѻο� �� ����
CREATE USER STUDENT IDENTIFIED BY STUDENT;

GRANT CONNECT TO STUDENT;

GRANT RESOURCE TO STUDENT;

CREATE TABLE STUDENT_TBL(
    STUDENT_NAME VARCHAR(20),
    STUDENT_AGE NUMBER,
    STUDENT_GRADE NUMBER,
    STUDENT_ADDRESS VARCHAR(100)
);
--KH������ ����� �� ��й�ȣ�� KH�� ���ּ���.
CREATE USER KH IDENTIFIED BY KH;
--������ �����ϰ� ���̺��� ������ �ǵ��� ���ּ���.
GRANT CONNECT, RESOURCE TO KH;
--�����̸��� ����� �����غ�����!