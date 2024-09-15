*&---------------------------------------------------------------------*
*&  Include           ZFSCHEDULE_SS36_3F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GET_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM get_data .


  IF pa_int = 'X' AND pa_dom = 'X'. " �������� �������� üũ �Ǿ� �ִٸ�

    " ��� ������ ��ȸ
    SELECT *
    FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli
    WHERE carrid = pa_car.

  ELSEIF pa_int = 'X'. " �������� üũ �Ǿ� �ִٸ�

    SELECT *
    FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli
    WHERE carrid = pa_car " carrid�� �Է� ���� �����鼭
      AND countryfr <> spfli~countryto. " ��� ������ ���� ������ �ٸ���(������)

  ELSE. " �ƴ϶��

    SELECT *
    FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli
    WHERE carrid = pa_car " carrid�� �Է� ���� �����鼭
      AND countryfr = spfli~countryto. " ��� ������ ���� ������ ���ٸ�(������)

  ENDIF.



  cl_demo_output=>display_data( gt_spfli ).



ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
