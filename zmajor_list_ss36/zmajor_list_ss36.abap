*&---------------------------------------------------------------------*
*& Report ZMAJOR_LIST_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMAJOR_LIST_SS36.

DATA gs_major TYPE ZMAJOR_STUDENT_SS36.
DATA gw_student LIKE LINE OF gs_major-students.

gs_major-major = 1.

CLEAR gw_student.
gw_student-stdid = 1.
gw_student-stdname = 'ȫ�浿'.
gw_student-stdage = 23.
INSERT gw_student INTO TABLE gs_major-students.

CLEAR gw_student.
gw_student-stdid = 2.
gw_student-stdname = '��ö��'.
gw_student-stdage = 33.
INSERT gw_student INTO TABLE gs_major-students.

CLEAR gw_student.
gw_student-stdid = 3.
gw_student-stdname = '�ڹ̸�'.
gw_student-stdage = 12.
INSERT gw_student INTO TABLE gs_major-students.

* �ش� Deep ��Ʈ���Ŀ��� �й��� 2���� ģ���� �о, ���̸� ���
READ TABLE gs_major-students
INTO gw_student
WITH KEY stdid = 2.

IF sy-subrc = 0.
WRITE:/ gw_student-stdage.
ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
