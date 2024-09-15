*&---------------------------------------------------------------------*
*& Report ZCOMPLEXDATA_SS36_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcomplexdata_ss36_2.

DATA gt_flights TYPE bc400_t_flights."Table Type
* 1) Line Type : 컬럼 6개짜리 Internal Teble
* 2) Primary Key : 3개 (CARRID, CONNID, FLDATE) Non-Unique
* 3) Table Kind : Standard Type

* Local Structured Type 정의
TYPES: BEGIN OF ts_student,
         id      TYPE n LENGTH 8,
         name    TYPE c LENGTH 32,
         address TYPE c LENGTH 128,
         age     TYPE n LENGTH 3,
       END OF ts_student.

* Local Table Type 정의
TYPES: tt_student TYPE STANDARD TABLE OF ts_student
                  WITH NON-UNIQUE KEY id.

* Internal Table 정의 with Table Type
DATA gt_student TYPE tt_student. "여러 학생을 담을 수 있는 변수

* Internal Table 정의 With Structure Type
DATA gt_student2 TYPE STANDARD TABLE OF ts_student
                 WITH NON-UNIQUE KEY id.

* Quiz1
DATA gt_flight TYPE STANDARD TABLE OF
               bc400_s_flight "Structure 타입
               WITH NON-UNIQUE KEY carrid connid.

* Internal Table 정의 Short Form
* Default : Standard, 모든 Char Field가 자동으로 Key
DATA gt_flight2 TYPE TABLE OF bc400_s_flight.

* 다른 Internal Table을 가지고 Internal Teble 정의
DATA gt_flight3 LIKE gt_flight2.

* Structure 변수 정의
DATA gs_flight TYPE bc400_s_flight.

* Internal Table 정의 with Structure 변수를 가지고
DATA gt_flight4 LIKE TABLE OF gs_flight.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
