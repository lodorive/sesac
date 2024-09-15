*&---------------------------------------------------------------------*
*& Report ZBC400_CARRIER_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_carrier_s36_2.

* SCARR 테이블에서 항공사 코드 AA인 행을 검색해서
* 모든 컬럼을 취득하고자 한다
PARAMETERS pa_car TYPE scarr-carrid.

* 컬럼 5개로 구성된 스트럭쳐 변수
DATA gs_carrier TYPE scarr.

* 함수의 결과를 담을 변수
DATA gs_tcurt TYPE tcurt.

PERFORM get_carrier USING pa_car "Sobroutine 정의(항공사 취득)
                    CHANGING gs_carrier.

PERFORM write_carrier USING gs_carrier "항공사 정보 및 화폐 단위
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
    "성공 메시지로 변경하기 (ZMESSAGE_SS36, 001)
    MESSAGE i001(zmessage_ss36) WITH pa_car.

  ELSE.

  " 화면에서 화폐단위를 입력받아 해당 화폐단위의 텍스트를 출력하는 함수
    CALL FUNCTION 'TCURT_SINGLE_READ'
      EXPORTING
        i_spras         = sy-langu "언어코드(EN)
        i_waers         = fs_carrier-currcode "화폐(USD)
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

    WRITE:/'URL:', fs_carrier-url+0(32). "0번째 위치에서 32자리를 출력

  ENDIF.
ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
