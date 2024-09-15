*&---------------------------------------------------------------------*
*& Report ZSTUDENT_SCORE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zstudent_score_ss36_4.

TYPES: BEGIN OF ts_common,
         id      TYPE zstd_ss36-id,
         name    TYPE zstd_ss36-name,
         gender  TYPE zstd_ss36-gender,
         gendert TYPE val_text,
         score   TYPE zscore_ss36-score,
       END OF ts_common.

TYPES: BEGIN OF ts_output,
         subject TYPE zscore_ss36-subject,
         subjectt TYPE zsubject_ss36T-text,
         min     TYPE ts_common,
         max     TYPE ts_common,
         sum     TYPE p LENGTH 7 DECIMALS 2,
         avg     TYPE zscore_ss36-score,
         total   TYPE i,
       END OF ts_output.

DATA: gs_output TYPE ts_output,
      gt_output TYPE TABLE OF ts_output.

* 학생 Internal Table과 Work Area
DATA: gt_std TYPE TABLE OF zstd_ss36,
      gs_std LIKE LINE OF gt_std.

* 점수 Internal Table과 Work Area
DATA: gt_score TYPE TABLE OF zscore_ss36,
      gw_score LIKE LINE OF gt_score.

* 과목 Internal Table과 Work Area
DATA: gt_subject TYPE TABLE OF zsubject_ss36,
      gw_subject LIKE LINE OF gt_subject.

SELECT-OPTIONS so_id FOR gs_std-id.
SELECT-OPTIONS so_ent FOR gs_std-entry.

INITIALIZATION.
"Nothing to do.

AT SELECTION-SCREEN.
"Nothing to do.

START-OF-SELECTION.

PERFORM get_std. "입력 값 데이터 취득
PERFORM get_subject. "과목 데이터 취득

* 과목별 점수를 구하기 위한 서브루틴
LOOP AT gt_subject INTO gw_subject.
  "과목을 파라미터로 던진다
  PERFORM get_data USING gw_subject-subject CHANGING gt_output.
ENDLOOP.

END-OF-SELECTION.
  PERFORM write_output.

FORM get_data  USING VALUE(f_subject) TYPE ZSTDSUBJECT_SS36
               CHANGING f_output LIKE gt_output.

    CLEAR gs_output.
   "과목별 점수 데이터 취득
    SELECT *
    FROM zscore_ss36
    INTO TABLE gt_score
    WHERE subject = f_subject.

    "과목 TEXT 취득
    SELECT SINGLE text
    FROM zsubject_ss36T
    INTO gs_output-subjectt
    WHERE subject = f_subject.

    gs_output-subject = f_subject.
    gs_output-total = lInes( gt_score ).

    "최대 점수 학생 ID 및 점수
    SORT gt_score BY score DESCENDING.
    READ TABLE gt_score INTO gw_score INDEX 1.
    MOVE-CORRESPONDING gw_score TO gs_output-max.

    "최소 점수 학생 ID 및 점수
    SORT gt_score BY score ASCENDING.
    READ TABLE gt_score INTO gw_score INDEX 1.
    MOVE-CORRESPONDING gw_score TO gs_output-min.

    "합계 점수와 평균
    LOOP AT gt_score INTO gw_score.
      gs_output-sum = gs_output-sum + gw_score-score.
    ENDLOOP.

    gs_output-avg = gs_output-sum / gs_output-total.

    "최소 점수 / 최대 점수 학생 상세 정보 취득
    PERFORM get_std_info USING gs_output-min-id
                         CHANGING gs_output-min.

    PERFORM get_std_info USING gs_output-max-id
                         CHANGING gs_output-max.

    APPEND gs_output TO f_output.

ENDFORM.


FORM get_std_info  USING VALUE(f_id) TYPE zstd_ss36-id
                   CHANGING f_info TYPE ts_common.

  SELECT SINGLE *
    FROM zstd_ss36
    INTO CORRESPONDING FIELDS OF f_info
    WHERE id = f_id.

   "성별 취득
    PERFORM get_gender_text USING f_info-gender
                       CHANGING f_info-gendert.


ENDFORM.


FORM get_gender_text  USING    VALUE(f_gender)  TYPE zstd_ss36-gender
                      CHANGING f_gendert        TYPE val_text.

  DATA lt_domvalues TYPE bbpt_domvalue_keys.
  DATA lw_domvalue  TYPE bbp_domvalue_keys.

  CALL FUNCTION 'BBP_GET_DOMVALUES_F4'
    EXPORTING
      iv_language           = sy-langu
      iv_domain_name        = 'ZGENDER_SS36'
    TABLES
      et_domvalues          = lt_domvalues
    EXCEPTIONS
      unknown_domain_passed = 1
      OTHERS                = 2.

  READ TABLE lt_domvalues INTO lw_domvalue WITH KEY domain_value = f_gender.
  f_gendert = lw_domvalue-domain_text.

ENDFORM.


FORM write_output .
    LOOP AT gt_output INTO gs_output.

    WRITE:/ gs_output-subjectt+0(10),
    gs_output-max-score,
    gs_output-min-score,
    gs_output-avg,
    gs_output-total,
    gs_output-max-gendert.

  ENDLOOP.
ENDFORM.


FORM get_std .
* 입력 값에 해당하는 데이터를 조회
  SELECT id name gender
    FROM zstd_ss36
    INTO CORRESPONDING FIELDS OF TABLE gt_std
    WHERE id IN so_id AND entry IN so_ent.
ENDFORM.


FORM get_subject .
* 과목 데이터 취득
 SELECT DISTINCT subject
   FROM zscore_ss36
   INTO CORRESPONDING FIELDS OF TABLE gt_subject
   FOR ALL ENTRIES IN gt_std
   WHERE id = gt_std-id.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
