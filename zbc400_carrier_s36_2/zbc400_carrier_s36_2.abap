*&---------------------------------------------------------------------*
*& Report ZBC400_CARRIER_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_carrier_s36_2.

* SCARR ���̺��� �װ��� �ڵ� AA�� ���� �˻��ؼ�
* ��� �÷��� ����ϰ��� �Ѵ�
PARAMETERS pa_car TYPE scarr-carrid.

* �÷� 5���� ������ ��Ʈ���� ����
DATA gs_carrier TYPE scarr.

* �Լ��� ����� ���� ����
DATA gs_tcurt TYPE tcurt.

PERFORM get_carrier USING pa_car "Sobroutine ����(�װ��� ���)
                    CHANGING gs_carrier.

PERFORM write_carrier USING gs_carrier "�װ��� ���� �� ȭ�� ����
                      CHANGING gs_tcurt.

*&---------------------------------------------------------------------*
*&      Form  GET_CARRIER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_carrier USING VALUE(f_car) TYPE scarr-carrid
                 CHANGING fs_carrier TYPE scarr.

  SELECT SINGLE carrid currcode "mandt carrid carrname currcod url
    FROM scarr
    INTO CORRESPONDING FIELDS OF fs_carrier
   WHERE carrid = f_car.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  WRITE_CARRIER
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM write_carrier USING VALUE(fs_carrier) TYPE scarr
                         CHANGING fs_tcurt TYPE tcurt.
*IF sy-subrc <> 0.
  IF gs_carrier IS INITIAL.
    "WRITE: 'Sorry, no data found!'.
    "���� �޽����� �����ϱ� (ZMESSAGE_SS36, 001)
    MESSAGE i001(zmessage_ss36) WITH pa_car.

  ELSE.

  " ȭ�鿡�� ȭ������� �Է¹޾� �ش� ȭ������� �ؽ�Ʈ�� ����ϴ� �Լ�
    CALL FUNCTION 'TCURT_SINGLE_READ'
      EXPORTING
        i_spras         = sy-langu "����ڵ�(EN)
        i_waers         = fs_carrier-currcode "ȭ��(USD)
*       I_RESET_BUFFER  =
*       I_BYPASSING_BUFFER       =
      IMPORTING
        o_tcurt         = fs_tcurt
      EXCEPTIONS
        not_found       = 1
        parameter_error = 2
        OTHERS          = 3.

  CASE sy-subrc.
    WHEN 1.
      WRITE:/'NOT_FOUND'.
    WHEN 2.
      WRITE:/'PARAMETER_ERROR'.
    WHEN OTHERS.
  ENDCASE.

    WRITE:/'ID:', fs_carrier-carrid.
    WRITE:/'Name:', fs_carrier-carrname.
    WRITE:/'Currency:', fs_carrier-currcode, fs_tcurt-ltext.

    WRITE:/'URL:', fs_carrier-url+0(32). "0��° ��ġ���� 32�ڸ��� ���

  ENDIF.
ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
