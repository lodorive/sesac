*&---------------------------------------------------------------------*
*& Report ZCOMPLEXDATA_SS36_4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCOMPLEXDATA_SS36_4.

TYPES: BEGIN OF ts_student,
         id      TYPE n LENGTH 8,
         name    TYPE c LENGTH 32,
         address TYPE c LENGTH 128,
         age     TYPE n LENGTH 3,
       END OF ts_student.

* With Header Line�� ���� ���ͳ� ���̺�
* gt_student Internal Table ���� + gt_student Work Area�� �������
DATA gt_student TYPE TABLE OF
                ts_student WITH HEADER LINE.

* APPEND
gt_student-id = 1. "Work Area
gt_student-name = 'ȫ�浿'. "Work Area

* Work Area�� Internal Table �̸��� ������ TO�� �����ص� ��
*APPEND gt_student TO gt_student.
APPEND gt_student.

CLEAR gt_student. "Work Area�� ����
CLEAR gt_student[]. "Internal Table�� ����

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
