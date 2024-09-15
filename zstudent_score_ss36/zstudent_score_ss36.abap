*&---------------------------------------------------------------------*
*& Report ZSTUDENT_SCORE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zstudent_score_ss36.

TYPES: BEGIN OF ts_agg,
         id        TYPE zstdid_ss36, "학생 ID
         subject   TYPE zstdsubject_ss36, "과목 이름
         score     TYPE zstdscore_ss36, "점수
         max       TYPE zstdscore_ss36, "최대 점수
         min       TYPE zstdscore_ss36, "최소 점수
         avg       TYPE zstdscore_ss36, "평균 점수
         candidate TYPE i, "응시자 수
         gender    TYPE zgender_ss36, "성별
         gendert   TYPE domvalue_l, "성별 텍스트
       END OF ts_agg.

DATA gt_agg TYPE TABLE OF ts_agg.
DATA gw_agg LIKE LINE OF gt_agg.

PARAMETERS pa_sub TYPE zscore_ss36-subject OBLIGATORY. "과목 이름
SELECT-OPTIONS so_id FOR gw_agg-id. "학생 ID

DATA lv_agg_max TYPE zstdscore_ss36. "최대 점수
DATA lv_agg_min TYPE zstdscore_ss36 VALUE 100. "최소 점수
DATA lv_agg_sum TYPE zstdscore_ss36. "합계 점수
DATA lv_agg_avg TYPE zstdscore_ss36. "평균 점수
DATA lv_agg_cnt TYPE i. "응시자 수

INITIALIZATION.
  "Nothing to do.

AT SELECTION-SCREEN.
  "Nothing to do.

START-OF-SELECTION.
  PERFORM get_score. "데이터 취득 서브루틴 호출
  PERFORM get_agg. "점수 계산 서브루틴 호출

END-OF-SELECTION.
  PERFORM write_sub_agg. "데이터 출력 서브루틴 호출

* 데이터 취득 서브루틴
FORM get_score .
* zscore_SS36 테이블에서 입력 값(과목, 점수)과
* 일치하는 데이터를 조회 후 gt_agg 테이블에 저장
  SELECT subject score
   FROM zscore_ss36
   INTO CORRESPONDING FIELDS OF TABLE gt_agg
   WHERE subject = pa_sub
   AND id IN so_id.
ENDFORM.

* 점수 계산 서브루틴
FORM get_agg .

  " 테이블에 저장되어 있는 값들을 비교하여
  " 최대 점수와 최대 점수, 합계, 카운트 수(응시자 수)를 구함
  LOOP AT gt_agg INTO gw_agg.

    "최대 점수 비교
    IF gw_agg-score > lv_agg_max.
      lv_agg_max = gw_agg-score.

      "최소 점수 비교
    ELSEIF gw_agg-score < lv_agg_min.
      lv_agg_min = gw_agg-score.

    ENDIF.

    "합계 계산
    lv_agg_sum = lv_agg_sum + gw_agg-score.

    "응시자 수 카운트
    lv_agg_cnt = lv_agg_cnt + 1.

  ENDLOOP.

  "최대 점수 저장
  gw_agg-max = lv_agg_max.

  "최소 점수 저장
  gw_agg-min = lv_agg_min.

  "응시자 수 저장
  gw_agg-candidate = lv_agg_cnt.

  "평균 점수 계산 및 저장
  lv_agg_avg = lv_agg_sum / lv_agg_cnt.
  gw_agg-avg = lv_agg_avg.

* 과목이 사용자가 입력한 과목이면서
* 최대 점수 값을 가지고 있는 ID를 조회
  SELECT SINGLE id
    FROM zscore_ss36
    INTO CORRESPONDING FIELDS OF gw_agg
    WHERE subject = gw_agg-subject
    AND score = gw_agg-max.

* 학생 ID로 gender 조회
  SELECT SINGLE gender
    FROM zstd_ss36
    INTO CORRESPONDING FIELDS OF gw_agg
    WHERE id = gw_agg-id.

* 함수를 사용하기 위한 인터널 테이블과 Work Area.
  DATA lt_domvalues TYPE bbpt_domvalue_keys.
  DATA ls_domvalues LIKE LINE OF lt_domvalues.

* Gender 텍스트 취득을 위한 함수 호출
  CALL FUNCTION 'BBP_GET_DOMVALUES_F4'
    EXPORTING
      iv_language    = sy-langu
      iv_domain_name = 'ZGENDER_SS36'
    TABLES
      et_domvalues   = lt_domvalues.

  READ TABLE lt_domvalues INTO ls_domvalues
  WITH KEY domain_value = gw_agg-gender.

  IF sy-subrc = 0. "잘 읽었으면
    "취득한 텍스트 값을 넣어줌
    gw_agg-gendert = ls_domvalues-domain_text.
  ENDIF.
ENDFORM.

* 데이터 출력 서브루틴
FORM write_sub_agg .

  WRITE:/ gw_agg-subject,
        gw_agg-max,
        gw_agg-min,
        gw_agg-avg,
        gw_agg-candidate,
        gw_agg-gendert.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
