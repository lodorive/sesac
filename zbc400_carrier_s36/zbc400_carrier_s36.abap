*&---------------------------------------------------------------------*
*& Report ZBC400_CARRIER_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_carrier_s36.

* SCARR ���̺��� �װ��� �ڵ� AA�� ���� �˻��ؼ�
* ��� �÷��� ����ϰ��� �Ѵ�
PARAMETERS pa_car TYPE scarr-carrid.

* �÷� 5���� ������ ��Ʈ���� ����
DATA gs_carrier TYPE scarr.

* ���� üũ�� ���� ���� ����
DATA gv_auth TYPE c LENGTH 1.

PERFORM get_carrier. "�װ��� �����
PERFORM write_carrier. "�װ��� ������ ���

FORM get_carrier .

  SELECT SINGLE * "mandt carrid carrname currcod url
    FROM scarr
    INTO gs_carrier
   WHERE carrid = pa_car.

  " ���� �ִ������� Ȯ��
  IF sy-subrc <> 0. " ���� ���ٸ�
    CLEAR gs_carrier.
  ELSE. "���� �ִٸ�

    "���� üũ
    AUTHORITY-CHECK OBJECT 'S_CARRID'
             ID 'CARRID' FIELD pa_car
             ID 'ACTVT' FIELD '03'.

    IF sy-subrc <> 0. "������ ���ٸ�
      gv_auth = 'f'. "false ���� �־���
    ENDIF.

  ENDIF.

ENDFORM.

FORM write_carrier .

  IF gv_auth = 'f'. "������ ���ٸ�
    MESSAGE i005(zmessage_s36) WITH pa_car.

  ELSE.

    IF gs_carrier IS INITIAL.
      MESSAGE i007(zmssage_s36) WITH pa_car.
    ELSE.
      WRITE:/'ID:', gs_carrier-carrid.
      WRITE:/'Name:', gs_carrier-carrname.
      WRITE:/'Currency:', gs_carrier-currcode.

      WRITE:/'URL:', gs_carrier-url+0(32). "0��° ��ġ���� 32�ڸ��� ���
    ENDIF.
  ENDIF.
ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
