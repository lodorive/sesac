*&---------------------------------------------------------------------*
*& Report ZSTUDENT_SCORE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zstudent_score_ss36_2.

TYPES: BEGIN OF ts_agg,
         id        TYPE zstd_ss36-id, "�л� ID
         subject   TYPE zstdsubject_ss36, "���� �̸�
         score     TYPE zstdscore_ss36, "����
         max       TYPE zstdscore_ss36, "�ִ� ����
         min       TYPE zstdscore_ss36, "�ּ� ����
         avg       TYPE zstdscore_ss36, "��� ����
         candidate TYPE i, "������ ��
         gender    TYPE zgender_ss36, "����
         gendert   TYPE domvalue_l, "���� �ؽ�Ʈ
       END OF ts_agg.

* ���� ����� ���� ���� ���̺�� ��Ʈ���� ����
DATA gt_agg TYPE TABLE OF ts_agg.
DATA gw_agg LIKE LINE OF gt_agg.

* �л� ������
DATA gt_std TYPE TABLE OF zstd_ss36.
DATA gw_std LIKE LINE OF gt_std.

* ���� ������
DATA gt_scr TYPE TABLE OF zscore_ss36.
DATA gw_scr LIKE LINE OF gt_scr.

* ���� ��°��� ���� ���̺� Ÿ�� ����
DATA gt_agg_all TYPE TABLE OF ts_agg.

* ����ڿ��� �Է� ����
SELECT-OPTIONS so_id FOR gw_std-id. "�л� ID
SELECT-OPTIONS so_ent FOR gw_std-entry. "���г��

INITIALIZATION.
  "Nothing to do.

AT SELECTION-SCREEN.
  "Nothing to do.

START-OF-SELECTION.
  PERFORM get_stdid. "�Է� ���� ������ ID ã�� �����ƾ ȣ��
  PERFORM get_subject. "���� ��ȸ �����ƾ ȣ��

  "������ �Ķ���ͷ� ������ ������ ����ϴ� �����ƾ ȣ��
  LOOP AT gt_scr INTO gw_scr.
    PERFORM get_agg USING gw_scr-subject.
  ENDLOOP.

END-OF-SELECTION.
  PERFORM write_sub_agg.

* ���� ��� �����ƾ
CLEAR gt_agg.
FORM get_agg  USING VALUE(p_gw_scr_subject)
                    TYPE zstdsubject_ss36.

  DATA lv_agg_max TYPE zstdscore_ss36. "�ִ� ����
  DATA lv_agg_min TYPE zstdscore_ss36 VALUE 100. "�ּ� ����
  DATA lv_agg_sum TYPE zstdscore_ss36. "�հ� ����
  DATA lv_agg_avg TYPE zstdscore_ss36. "��� ����
  DATA lv_agg_cnt TYPE i. "������ ��

  " �Լ��� ����ϱ� ���� ���ͳ� ���̺�� Work Area.
  DATA lt_domvalues TYPE bbpt_domvalue_keys.
  DATA ls_domvalues LIKE LINE OF lt_domvalues.

  CLEAR: lv_agg_max, lv_agg_sum, lv_agg_cnt.

  SELECT score subject
    FROM zscore_ss36
    INTO CORRESPONDING FIELDS OF TABLE gt_agg
    WHERE subject = p_gw_scr_subject.

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

  gw_agg-subject = p_gw_scr_subject.

  " ������ ����ڰ� �Է��� �����̸鼭
  " �ִ� ���� ���� ������ �ִ� ID�� ��ȸ
  SELECT SINGLE id
  FROM zscore_ss36
  INTO CORRESPONDING FIELDS OF gw_agg
  WHERE subject = gw_agg-subject
  AND score = gw_agg-max.

  " �л� ID�� gender �о��.
  READ TABLE gt_std INTO gw_std WITH KEY id = gw_agg-id.
  IF sy-subrc = 0.
    gw_agg-gender = gw_std-gender.
  ENDIF.

  " Gender �ؽ�Ʈ ����� ���� �Լ� ȣ��
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

  APPEND gw_agg TO gt_agg.
  CLEAR gt_agg.

  APPEND gw_agg TO gt_agg_all.

ENDFORM.

* ����ڰ� �Է��� ���ǿ� �ش��ϴ� ID�� ã�� �����ƾ
FORM get_stdid .
  SELECT id gender
  FROM zstd_ss36
  INTO CORRESPONDING FIELDS OF TABLE gt_std
  WHERE id IN so_id AND entry IN so_ent.
ENDFORM.

* ��� ������ ��ȸ�ϴ� �����ƾ
FORM get_subject .

  SELECT DISTINCT subject
    FROM zscore_ss36
    INTO CORRESPONDING FIELDS OF TABLE gt_scr
    FOR ALL ENTRIES IN gt_std
    WHERE id = gt_std-id.

ENDFORM.

* ��� �� ��� �����ƾ
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
