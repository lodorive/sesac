*&---------------------------------------------------------------------*
*&  Include           ZREPORT_SS36E01
*&---------------------------------------------------------------------*
LOAD-OF-PROGRAM.

INITIALIZATION.

AT SELECTION-SCREEN OUTPUT.

AT SELECTION-SCREEN.

" 화면의 필드(p_vari)에 대해 sarch help 제공
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_vari.
  " 사용자가 저장한 베리언트 팝업 로직 구성
  PERFORM f4_variant.

START-OF-SELECTION.
  PERFORM get_data. " 조건의 예약 정보 취득

  IF gt_book IS NOT INITIAL. "데이터가 존재하면
    CALL SCREEN '0100'. "ALV 띄우기
  ELSE.
    "해당 조건에 대한 데이터가 없습니다. (S).
    MESSAGE s015(zmessage_ss36).
  ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
