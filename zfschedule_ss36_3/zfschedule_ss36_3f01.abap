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


  IF pa_int = 'X' AND pa_dom = 'X'. " 국제선과 국내선이 체크 되어 있다면

    " 모든 데이터 조회
    SELECT *
    FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli
    WHERE carrid = pa_car.

  ELSEIF pa_int = 'X'. " 국제선이 체크 되어 있다면

    SELECT *
    FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli
    WHERE carrid = pa_car " carrid가 입렵 값과 같으면서
      AND countryfr <> spfli~countryto. " 출발 국가와 도착 국가가 다르면(국제선)

  ELSE. " 아니라면

    SELECT *
    FROM spfli
    INTO CORRESPONDING FIELDS OF TABLE gt_spfli
    WHERE carrid = pa_car " carrid가 입력 값과 같으면서
      AND countryfr = spfli~countryto. " 출발 국가와 도착 국가가 같다면(국내선)

  ENDIF.



  cl_demo_output=>display_data( gt_spfli ).



ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
