*&---------------------------------------------------------------------*
*& Report ZSTUDENT_SCORE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zstudent_score_ss36_3.

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

DATA: gs_output TYPE ts_output.

DATA gt_score TYPE TABLE OF zscore_ss36.
DATA gw_score TYPE zscore_ss36.

SELECT-OPTIONS p_stdid FOR gs_output-min-id. "MATCHCODE OBJECT ZH_STDID_SS36.
* ���� ȭ�� �׸���.
PARAMETERS p_subj TYPE zscore_ss36-subject OBLIGATORY. "�ʼ� �Է°����� ������.
PARAMETERS p_id TYPE ZSTDID_SS36.

INITIALIZATION.
  "Nothing to do.

AT SELECTION-SCREEN.
  "Nothing to do.

START-OF-SELECTION.
  "1) ȭ�鿡�� �Է��� ������ ��� ���� ����ϱ�.
  SELECT *
    FROM zscore_ss36
    INTO TABLE
    gt_score
    WHERE subject = p_subj.

  SELECT SINGLE text
    FROM zsubject_ss36T
    INTO gs_output-subjectt
    WHERE subject = p_subj.

  gs_output-subject = p_subj.            "���� �̸�.
  gs_output-total   = lines( gt_score ). "��ü �Ǽ�.

  "2) �ִ� ���� �л� ID �� ���� ���ϱ�.
  SORT gt_score BY score DESCENDING.
  READ TABLE gt_score INTO gw_score INDEX 1.
  MOVE-CORRESPONDING gw_score TO gs_output-max.

  "3) �ּ� ���� �л� ID �� ���� ���ϱ� .
  SORT gt_score BY score ASCENDING.
  READ TABLE gt_score INTO gw_score INDEX 1.
  MOVE-CORRESPONDING gw_score TO gs_output-min.

  "4) �հ� ������ ������� ���ϱ�.
  LOOP AT gt_score INTO gw_score.
    gs_output-sum = gs_output-sum + gw_score-score.
  ENDLOOP.

  gs_output-avg = gs_output-sum / gs_output-total.

  "5)�ּ� ����/ �ִ� ���� �л� �� ���� ����ϱ�.
  PERFORM get_student_info USING gs_output-min-id
                        CHANGING gs_output-min.

  PERFORM get_student_info USING gs_output-max-id
                        CHANGING gs_output-max.

*********************************************************************

WRITE:/ gs_output-subjectt+0(10),
gs_output-min-score,
gs_output-max-score,
gs_output-avg,
gs_output-total,
gs_output-max-gendert.

* �����ƾ ���� (�л� ID�� �Է� �޾Ƽ�, �ΰ����� ���� ä���(name, gender, gendert)
FORM get_student_info USING VALUE(f_id) TYPE zstd_ss36-id
                      CHANGING f_info   TYPE ts_common.

        SELECT SINGLE *
           FROM zstd_ss36
           INTO CORRESPONDING FIELDS OF f_info
          WHERE id = f_id.

  "���� �ؽ�Ʈ ����ϱ�.
  PERFORM get_gender_text USING    f_info-gender
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

  READ TABLE lt_domvalues INTO lw_domvalue
  WITH KEY domain_value = f_gender.
  f_gendert = lw_domvalue-domain_text.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
