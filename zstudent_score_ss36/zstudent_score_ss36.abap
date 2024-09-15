*&---------------------------------------------------------------------*
*& Report ZSTUDENT_SCORE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zstudent_score_ss36.

TYPES: BEGIN OF ts_agg,
         id        TYPE zstdid_ss36, "�л� ID
         subject   TYPE zstdsubject_ss36, "���� �̸�
         score     TYPE zstdscore_ss36, "����
         max       TYPE zstdscore_ss36, "�ִ� ����
         min       TYPE zstdscore_ss36, "�ּ� ����
         avg       TYPE zstdscore_ss36, "��� ����
         candidate TYPE i, "������ ��
         gender    TYPE zgender_ss36, "����
         gendert   TYPE domvalue_l, "���� �ؽ�Ʈ
       END OF ts_agg.

DATA gt_agg TYPE TABLE OF ts_agg.
DATA gw_agg LIKE LINE OF gt_agg.

PARAMETERS pa_sub TYPE zscore_ss36-subject OBLIGATORY. "���� �̸�
SELECT-OPTIONS so_id FOR gw_agg-id. "�л� ID

DATA lv_agg_max TYPE zstdscore_ss36. "�ִ� ����
DATA lv_agg_min TYPE zstdscore_ss36 VALUE 100. "�ּ� ����
DATA lv_agg_sum TYPE zstdscore_ss36. "�հ� ����
DATA lv_agg_avg TYPE zstdscore_ss36. "��� ����
DATA lv_agg_cnt TYPE i. "������ ��

INITIALIZATION.
  "Nothing to do.

AT SELECTION-SCREEN.
  "Nothing to do.

START-OF-SELECTION.
  PERFORM get_score. "������ ��� �����ƾ ȣ��
  PERFORM get_agg. "���� ��� �����ƾ ȣ��

END-OF-SELECTION.
  PERFORM write_sub_agg. "������ ��� �����ƾ ȣ��

* ������ ��� �����ƾ
FORM get_score .
* zscore_SS36 ���̺��� �Է� ��(����, ����)��
* ��ġ�ϴ� �����͸� ��ȸ �� gt_agg ���̺� ����
  SELECT subject score
   FROM zscore_ss36
   INTO CORRESPONDING FIELDS OF TABLE gt_agg
   WHERE subject = pa_sub
   AND id IN so_id.
ENDFORM.

* ���� ��� �����ƾ
FORM get_agg .

  " ���̺� ����Ǿ� �ִ� ������ ���Ͽ�
  " �ִ� ������ �ִ� ����, �հ�, ī��Ʈ ��(������ ��)�� ����
  LOOP AT gt_agg INTO gw_agg.

    "�ִ� ���� ��
    IF gw_agg-score > lv_agg_max.
      lv_agg_max = gw_agg-score.

      "�ּ� ���� ��
    ELSEIF gw_agg-score < lv_agg_min.
      lv_agg_min = gw_agg-score.

    ENDIF.

    "�հ� ���
    lv_agg_sum = lv_agg_sum + gw_agg-score.

    "������ �� ī��Ʈ
    lv_agg_cnt = lv_agg_cnt + 1.

  ENDLOOP.

  "�ִ� ���� ����
  gw_agg-max = lv_agg_max.

  "�ּ� ���� ����
  gw_agg-min = lv_agg_min.

  "������ �� ����
  gw_agg-candidate = lv_agg_cnt.

  "��� ���� ��� �� ����
  lv_agg_avg = lv_agg_sum / lv_agg_cnt.
  gw_agg-avg = lv_agg_avg.

* ������ ����ڰ� �Է��� �����̸鼭
* �ִ� ���� ���� ������ �ִ� ID�� ��ȸ
  SELECT SINGLE id
    FROM zscore_ss36
    INTO CORRESPONDING FIELDS OF gw_agg
    WHERE subject = gw_agg-subject
    AND score = gw_agg-max.

* �л� ID�� gender ��ȸ
  SELECT SINGLE gender
    FROM zstd_ss36
    INTO CORRESPONDING FIELDS OF gw_agg
    WHERE id = gw_agg-id.

* �Լ��� ����ϱ� ���� ���ͳ� ���̺�� Work Area.
  DATA lt_domvalues TYPE bbpt_domvalue_keys.
  DATA ls_domvalues LIKE LINE OF lt_domvalues.

* Gender �ؽ�Ʈ ����� ���� �Լ� ȣ��
  CALL FUNCTION 'BBP_GET_DOMVALUES_F4'
    EXPORTING
      iv_language    = sy-langu
      iv_domain_name = 'ZGENDER_SS36'
    TABLES
      et_domvalues   = lt_domvalues.

  READ TABLE lt_domvalues INTO ls_domvalues
  WITH KEY domain_value = gw_agg-gender.

  IF sy-subrc = 0. "�� �о�����
    "����� �ؽ�Ʈ ���� �־���
    gw_agg-gendert = ls_domvalues-domain_text.
  ENDIF.
ENDFORM.

* ������ ��� �����ƾ
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
