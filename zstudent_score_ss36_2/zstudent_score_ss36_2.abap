*&---------------------------------------------------------------------*
*& Report ZSTUDENT_SCORE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zstudent_score_ss36_2.

TYPES: BEGIN OF ts_agg,
         id        TYPE zstd_ss36-id, "학생 ID
         subject   TYPE zstdsubject_ss36, "과목 이름
         score     TYPE zstdscore_ss36, "점수
         max       TYPE zstdscore_ss36, "최대 점수
         min       TYPE zstdscore_ss36, "최소 점수
         avg       TYPE zstdscore_ss36, "평균 점수
         candidate TYPE i, "응시자 수
         gender    TYPE zgender_ss36, "성별
         gendert   TYPE domvalue_l, "성별 텍스트
       END OF ts_agg.

* 점수 계산을 위한 내부 테이블과 스트럭쳐 정의
DATA gt_agg TYPE TABLE OF ts_agg.
DATA gw_agg LIKE LINE OF gt_agg.

* 학생 데이터
DATA gt_std TYPE TABLE OF zstd_ss36.
DATA gw_std LIKE LINE OF gt_std.

* 점수 데이터
DATA gt_scr TYPE TABLE OF zscore_ss36.
DATA gw_scr LIKE LINE OF gt_scr.

* 최종 출력값을 담을 테이블 타입 정의
DATA gt_agg_all TYPE TABLE OF ts_agg.

* 사용자에게 입력 받음
SELECT-OPTIONS so_id FOR gw_std-id. "학생 ID
SELECT-OPTIONS so_ent FOR gw_std-entry. "입학년월

INITIALIZATION.
  "Nothing to do.

AT SELECTION-SCREEN.
  "Nothing to do.

START-OF-SELECTION.
  PERFORM get_stdid. "입력 받은 조건의 ID 찾는 서브루틴 호출
  PERFORM get_subject. "과목 조회 서브루틴 호출

  "과목을 파라미터로 던져서 점수를 계산하는 서브루틴 호출
  LOOP AT gt_scr INTO gw_scr.
    PERFORM get_agg USING gw_scr-subject.
  ENDLOOP.

END-OF-SELECTION.
  PERFORM write_sub_agg.

* 점수 계산 서브루틴
CLEAR gt_agg.
FORM get_agg  USING VALUE(p_gw_scr_subject)
                    TYPE zstdsubject_ss36.

  DATA lv_agg_max TYPE zstdscore_ss36. "최대 점수
  DATA lv_agg_min TYPE zstdscore_ss36 VALUE 100. "최소 점수
  DATA lv_agg_sum TYPE zstdscore_ss36. "합계 점수
  DATA lv_agg_avg TYPE zstdscore_ss36. "평균 점수
  DATA lv_agg_cnt TYPE i. "응시자 수

  " 함수를 사용하기 위한 인터널 테이블과 Work Area.
  DATA lt_domvalues TYPE bbpt_domvalue_keys.
  DATA ls_domvalues LIKE LINE OF lt_domvalues.

  CLEAR: lv_agg_max, lv_agg_sum, lv_agg_cnt.

  SELECT score subject
    FROM zscore_ss36
    INTO CORRESPONDING FIELDS OF TABLE gt_agg
    WHERE subject = p_gw_scr_subject.

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

  gw_agg-subject = p_gw_scr_subject.

  " 과목이 사용자가 입력한 과목이면서
  " 최대 점수 값을 가지고 있는 ID를 조회
  SELECT SINGLE id
  FROM zscore_ss36
  INTO CORRESPONDING FIELDS OF gw_agg
  WHERE subject = gw_agg-subject
  AND score = gw_agg-max.

  " 학생 ID로 gender 읽어옴.
  READ TABLE gt_std INTO gw_std WITH KEY id = gw_agg-id.
  IF sy-subrc = 0.
    gw_agg-gender = gw_std-gender.
  ENDIF.

  " Gender 텍스트 취득을 위한 함수 호출
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

  APPEND gw_agg TO gt_agg.
  CLEAR gt_agg.

  APPEND gw_agg TO gt_agg_all.

ENDFORM.

* 사용자가 입력한 조건에 해당하는 ID를 찾는 서브루틴
FORM get_stdid .
  SELECT id gender
  FROM zstd_ss36
  INTO CORRESPONDING FIELDS OF TABLE gt_std
  WHERE id IN so_id AND entry IN so_ent.
ENDFORM.

* 모든 과목을 조회하는 서브루틴
FORM get_subject .

  SELECT DISTINCT subject
    FROM zscore_ss36
    INTO CORRESPONDING FIELDS OF TABLE gt_scr
    FOR ALL ENTRIES IN gt_std
    WHERE id = gt_std-id.

ENDFORM.

* 결과 값 출력 서브루틴
FORM write_sub_agg .

  LOOP AT gt_agg_all INTO gw_agg.

    WRITE:/ gw_agg-subject,
    gw_agg-max,
    gw_agg-min,
    gw_agg-avg,
    gw_agg-candidate,
    gw_agg-gendert.
*    gw_agg-id.
  ENDLOOP.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
