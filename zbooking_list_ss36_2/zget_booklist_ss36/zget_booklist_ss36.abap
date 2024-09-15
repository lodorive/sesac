FUNCTION ZGET_BOOKLIST_SS36.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_CARRID) TYPE  SBOOK-CARRID
*"     REFERENCE(I_CONNID) TYPE  SBOOK-CONNID
*"     REFERENCE(I_FLDATE) TYPE  ZRFLDATE_SS36
*"  EXPORTING
*"     REFERENCE(E_BOOKLIST) TYPE  ZBOOKLIST_SS36T
*"----------------------------------------------------------------------

  " 4) 데이터 취득
  " 입력 받은 항공사 코드, 항공편, 비행 일자 기준으로 예약 정보 조회
  SELECT carrid fldate customid class
     FROM sbook
     INTO CORRESPONDING FIELDS OF TABLE e_booklist
     WHERE carrid = i_carrid
     AND connid = i_connid
     AND fldate IN i_fldate[]
     AND cancelled <> 'X'.

   "항공사 이름 취득하기
  "(어차피 carrid('aa')가 같은 데이터만 뽑히기 때문에 이름은 한 번만 조회해도 됨)
  DATA lv_carrname TYPE scarr-carrname.
  SELECT SINGLE carrname
    FROM scarr
    INTO lv_carrname
    WHERE carrid = i_carrid.

  DATA gw_book LIKE LINE OF e_booklist.
  LOOP AT e_booklist INTO gw_book.
    "0) 항공사 이름 취득
    gw_book-carrname = lv_carrname.

    "1) 년도, 월 추출
    gw_book-fyear = gw_book-fldate+0(4).
    gw_book-fmonth = gw_book-fldate+4(2).

    "2) 고객 상세 정보 채우기
    CALL FUNCTION 'ZGET_CUSTOMER_SS36'
      EXPORTING
        i_id        = gw_book-customid
      IMPORTING
        e_name      = gw_book-name
        e_telephone = gw_book-telephone
        e_email     = gw_book-email.

    "3) class 클래스 텍스트 처리
    CASE gw_book-class.
      WHEN 'F'.
        gw_book-classt = TEXT-fir.
      WHEN 'Y'.
        gw_book-classt = TEXT-eco.
      WHEN 'C'.
        gw_book-classt = TEXT-bus.
    ENDCASE.

    MODIFY e_booklist FROM gw_book. "인터널 테이블에 반영

  ENDLOOP.


ENDFUNCTION.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
