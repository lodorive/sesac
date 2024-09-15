*&---------------------------------------------------------------------*
*& Report ZTEXT_TABLE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztext_table_ss36.

* 화면에서 전공을 입력 받음
PARAMETERS p_major TYPE zstd_ss36-major. "F4 help 제공 -> Check Table O
PARAMETERS p_maj TYPE zmajor_ss36-major. "F4 help 제공X -> Check Table X

* 화면에서 학번을 입력 받아 해당 학생의 성적을 출력
PARAMETERS p_id TYPE zscore_ss36-id. "학생 테이블-not bad, 성적 테이블-good O

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
