*&---------------------------------------------------------------------*
*& Report ZTABLE_TYPE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztable_type_ss36.

* 학생들을 보관할 인터널 테이블 정의
DATA it_student TYPE zstudent_ss36t.
DATA wa_student LIKE LINE OF it_student.

* 3/홍길동/24/99.0 삽입
CLEAR wa_student.
wa_student-stdid = 3.
wa_student-stdname = '홍길동'.
wa_student-stdage = 24.
wa_student-stdscore = '99.0'.
INSERT wa_student INTO TABLE it_student.

* 1/김미리/21/88.0 삽입
CLEAR wa_student.
wa_student-stdid = 1.
wa_student-stdname = '김미리'.
wa_student-stdage = 21.
wa_student-stdscore = '88.0'.
INSERT wa_student INTO TABLE it_student.

* 인터널 테이블 내용 확인
cl_demo_output=>display_data( it_student ).

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
