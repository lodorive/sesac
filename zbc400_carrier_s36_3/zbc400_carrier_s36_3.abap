*&---------------------------------------------------------------------*
*& Report ZBC400_CARRIER_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_carrier_s36_3.

* SCARR ���̺��� �װ��� �ڵ� AA�� ���� �˻��ؼ�
* ��� �÷��� ����ϰ��� �Ѵ�
PARAMETERS pa_car TYPE scarr-carrid.

* �÷� 5���� ������ ��Ʈ���� ����
DATA gs_carrier TYPE scarr.

INITIALIZATION.
  "Nothing to do

AT SELECTION-SCREEN.

  PERFORM check_auth. "���� üũ ����

START-OF-SELECTION.
  PERFORM get_carrier. "�װ��� �����

END-OF-SELECTION.
  PERFORM write_carrier. "�װ��� ������ ���

* �װ��� ��� �����ƾ
FORM get_carrier .

  SELECT SINGLE * "mandt carrid carrname currcod url
    FROM scarr
    INTO gs_carrier
   WHERE carrid = pa_car.

ENDFORM.

* �װ��� ���� ��� �����ƾ
FORM write_carrier .


    IF gs_carrier IS INITIAL. "���� ���ٸ�

      MESSAGE i001(zmessage_ss36) WITH pa_car.

    ELSE.

      WRITE:/'ID:', gs_carrier-carrid.
      WRITE:/'Name:', gs_carrier-carrname.
      WRITE:/'Currency:', gs_carrier-currcode.

      WRITE:/'URL:', gs_carrier-url+0(32). "0��° ��ġ���� 32�ڸ��� ���

  ENDIF.

ENDFORM.

* ���� üũ �����ƾ
FORM check_auth .

  AUTHORITY-CHECK OBJECT 'S_CARRID'
         ID 'CARRID' FIELD pa_car
         ID 'ACTVT' FIELD '03'.
  IF sy-subrc <> 0.
    MESSAGE E005(ZMESSAGE_SS36) WITH pa_car.
  ENDIF.

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
