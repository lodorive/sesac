*&---------------------------------------------------------------------*
*& Report ZNESTED_STRUCTURE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZNESTED_STRUCTURE_SS36.

*DATA gs_student TYPE Zstudent_SS36_2. "Nested
*
** 1/ȫ�浿/24/99.00/�ѱ�/����/��õ�� ���굿
*gs_student-stdid = 1.
*gs_student-stdname = 'ȫ�浿'.
*gs_student-stdage = 24.
*gs_student-stdscore = '99.00'.
*
*gs_student-address-country = '�ѱ�'.
*gs_student-address-city = '����'.
*gs_student-address-street = '��õ�� ���굿'.


DATA gs_student TYPE Zstudent_SS36_3. "Include

* 1/ȫ�浿/24/99.00/�ѱ�/����/��õ�� ���굿
gs_student-stdid = 1.
gs_student-stdname = 'ȫ�浿'.
gs_student-stdage = 24.
gs_student-stdscore = '99.00'.

gs_student-country = '�ѱ�'.
gs_student-city = '����'.
gs_student-street = '��õ�� ���굿'.

WRITE:/ gs_student-stdid,
        gs_student-stdname,
        gs_student-stdage,
        gs_student-stdscore,
        gs_student-country,
        gs_student-city,
        gs_student-street.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
