*&---------------------------------------------------------------------*
*&  Include           ZREPORT_SS36E01
*&---------------------------------------------------------------------*
LOAD-OF-PROGRAM.

INITIALIZATION.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN.

" ȭ���� �ʵ�(p_vari)�� ���� sarch help ����
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_vari.
  " ����ڰ� ������ ������Ʈ �˾� ���� ����
  PERFORM f4_variant.

START-OF-SELECTION.
  PERFORM get_data. " ������ ���� ���� ���

  IF gt_book IS NOT INITIAL. "�����Ͱ� �����ϸ�
    CALL SCREEN '0100'. "ALV ����
  ELSE.
    "�ش� ���ǿ� ���� �����Ͱ� �����ϴ�. (S).
    MESSAGE s015(zmessage_ss36).
  ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
