*&---------------------------------------------------------------------*
*& Report ZTABLE_TYPE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztable_type_ss36.

* �л����� ������ ���ͳ� ���̺� ����
DATA it_student TYPE zstudent_ss36t.
DATA wa_student LIKE LINE OF it_student.

* 3/ȫ�浿/24/99.0 ����
CLEAR wa_student.
wa_student-stdid = 3.
wa_student-stdname = 'ȫ�浿'.
wa_student-stdage = 24.
wa_student-stdscore = '99.0'.
INSERT wa_student INTO TABLE it_student.

* 1/��̸�/21/88.0 ����
CLEAR wa_student.
wa_student-stdid = 1.
wa_student-stdname = '��̸�'.
wa_student-stdage = 21.
wa_student-stdscore = '88.0'.
INSERT wa_student INTO TABLE it_student.

* ���ͳ� ���̺� ���� Ȯ��
cl_demo_output=>display_data( it_student ).

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
