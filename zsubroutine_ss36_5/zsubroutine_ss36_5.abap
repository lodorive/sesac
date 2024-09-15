*&---------------------------------------------------------------------*
*& Report ZSUBROUTINE_SS36_5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSUBROUTINE_SS36_5.

* �� ID�� �Է¹޾� �ش� ���� �̸�, ��ȭ��ȣ, �̸��� �ּҸ�
* ����ϴ� ���α׷��� �����Ͻÿ�

PARAMETERS: pa_id TYPE SCUSTOM-id. "���̵� �Է� ����
DATA: gv_result TYPE SCUSTOM. "�����͸� ����

PERFORM get_scustom USING pa_id
                    CHANGING gv_result.


FORM get_scustom USING VALUE(f_id) TYPE SCUSTOM-id
                  CHANGING f_result TYPE SCUSTOM.


  SELECT SINGLE ID NAME TELEPHONE EMAIL
    FROM SCUSTOM
    INTO (f_result-id,
          f_result-name,
          f_result-telephone,
          f_result-email)
    WHERE id = f_id.


    IF gv_result is INITIAL. "�����Ͱ� �������� �ʴ´ٸ�

      MESSAGE i001(ZMESSAGE_SS36) WITH pa_id. "�����޽��� ���

      ELSE. "�ƴ϶�� ���� ���

      WRITE:/'ID:', f_result-id.
      WRITE:/'Name:', f_result-name.
      WRITE:/'Telephone:', f_result-telephone.
      WRITE:/'Email:', f_result-email.

      ENDIF.

  ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
