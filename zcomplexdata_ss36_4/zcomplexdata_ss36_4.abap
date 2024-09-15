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

* With Header Line을 가진 인터널 테이블
* gt_student Internal Table 생성 + gt_student Work Area도 만들어짐
DATA gt_student TYPE TABLE OF
                ts_student WITH HEADER LINE.

* APPEND
gt_student-id = 1. "Work Area
gt_student-name = '홍길동'. "Work Area

* Work Area와 Internal Table 이름이 같으면 TO를 생략해도 됨
*APPEND gt_student TO gt_student.
APPEND gt_student.

CLEAR gt_student. "Work Area를 지움
CLEAR gt_student[]. "Internal Table을 지움

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
