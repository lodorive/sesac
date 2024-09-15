*&---------------------------------------------------------------------*
*& Report ZCOMPLEXDATA_SS36_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcomplexdata_ss36_2.

DATA gt_flights TYPE bc400_t_flights."Table Type
* 1) Line Type : �÷� 6��¥�� Internal Teble
* 2) Primary Key : 3�� (CARRID, CONNID, FLDATE) Non-Unique
* 3) Table Kind : Standard Type

* Local Structured Type ����
TYPES: BEGIN OF ts_student,
         id      TYPE n LENGTH 8,
         name    TYPE c LENGTH 32,
         address TYPE c LENGTH 128,
         age     TYPE n LENGTH 3,
       END OF ts_student.

* Local Table Type ����
TYPES: tt_student TYPE STANDARD TABLE OF ts_student
                  WITH NON-UNIQUE KEY id.

* Internal Table ���� with Table Type
DATA gt_student TYPE tt_student. "���� �л��� ���� �� �ִ� ����

* Internal Table ���� With Structure Type
DATA gt_student2 TYPE STANDARD TABLE OF ts_student
                 WITH NON-UNIQUE KEY id.

* Quiz1
DATA gt_flight TYPE STANDARD TABLE OF
               bc400_s_flight "Structure Ÿ��
               WITH NON-UNIQUE KEY carrid connid.

* Internal Table ���� Short Form
* Default : Standard, ��� Char Field�� �ڵ����� Key
DATA gt_flight2 TYPE TABLE OF bc400_s_flight.

* �ٸ� Internal Table�� ������ Internal Teble ����
DATA gt_flight3 LIKE gt_flight2.

* Structure ���� ����
DATA gs_flight TYPE bc400_s_flight.

* Internal Table ���� with Structure ������ ������
DATA gt_flight4 LIKE TABLE OF gs_flight.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
