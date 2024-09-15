*&---------------------------------------------------------------------*
*& Report ZSUBROUTINE_SS36_5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSUBROUTINE_SS36_5.

* 고객 ID를 입력받아 해당 고객의 이름, 전화번호, 이메일 주소를
* 출력하는 프로그램을 구현하시오

PARAMETERS: pa_id TYPE SCUSTOM-id. "아이디를 입력 받음
DATA: gv_result TYPE SCUSTOM. "데이터를 저장

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


    IF gv_result is INITIAL. "데이터가 존재하지 않는다면

      MESSAGE i001(ZMESSAGE_SS36) WITH pa_id. "에러메시지 출력

      ELSE. "아니라면 정보 출력

      WRITE:/'ID:', f_result-id.
      WRITE:/'Name:', f_result-name.
      WRITE:/'Telephone:', f_result-telephone.
      WRITE:/'Email:', f_result-email.

      ENDIF.

  ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
