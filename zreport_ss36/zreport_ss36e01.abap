*&---------------------------------------------------------------------*
*&  Include           ZREPORT_SS36E01
*&---------------------------------------------------------------------*
LOAD-OF-PROGRAM.

INITIALIZATION.
  tab1 = 'Carrier'.  "첫번째 탭 레이블.
  tab2 = 'Booking'.  "두번째 탭 레이블.

  "프로그램이 구동되자마자 2번째 탭을 활성화 시키고 띄우고 싶다.
  blk1-activetab = 'COMM2'.
  blk1-dynnr     = 120.

  "버튼 레이블 결정
  gv_btn1 = 'Display'.
  gv_btn2 = 'Change'.

AT SELECTION-SCREEN OUTPUT. " 1000번 화면의 PBO
  LOOP AT SCREEN.
    " 사용자가 금액 체크박스를 클릭한 경우
    " 라디오버튼 그룹 숨기기
    IF pa_curr = 'X'.
      IF screen-group1 = 'XYZ'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.

* 얘는 전체 PAI(User_Command 같은 느낌)
AT SELECTION-SCREEN. " 1000번 화면의 PAI
  CASE sy-dynnr.
    WHEN '1000'.
      CASE sscrfields-ucomm. "사용자가 어떤 필드를 눌렀니?
        WHEN 'ON1'.
          "아밥 딕셔너리 호출
          CALL TRANSACTION 'SE11'.
        WHEN 'ON2'.
          "아밥 에디터 호출
          CALL TRANSACTION 'SE38'.
      ENDCASE.
    WHEN '110'.
      "Nothing To do.
    WHEN '120'.
      "Nothing To do.
  ENDCASE.

  AT SELECTION-SCREEN ON pa_name.
    "1100번 화면 띄우기
    IF pa_name = 'X'.
      CALL SELECTION-SCREEN 1100
      STARTING AT 5 5.

        IF sy-subrc <> 0. "팝업창에서 취소 버튼 클릭 시
          LEAVE TO SCREEN 1000.
        ENDIF.

    ENDIF.

*   사용자가 pa_name에서 f1을 눌렀을 때 help를 띄우고 싶음
  AT SELECTION-SCREEN ON HELP-REQUEST FOR pa_name.
    MESSAGE 'F1 Help...' TYPE 'I'.

  START-OF-SELECTION.
    WRITE: 'Processing...'.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
