*&---------------------------------------------------------------------*
*& Report ZCLIENT_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zclient_ss36.

*DATA it TYPE TABLE OF scarr.

* CLIENT SPECIFIED : 다른 클라이언트 데이터를 가져올 때

*SELECT *
*  FROM scarr
*  CLIENT SPECIFIED
*  INTO TABLE it
*  WHERE mandt = '000'.
*
*cl_demo_output=>display_data( it ).

* 복사한 테이블에 대한항공 삽입
* KR / Korean Air / KRW / http://www.koreanair.com

DATA wa TYPE zscarr_ss36.
DATA it LIKE TABLE OF wa. "여러 건 삽입을 위한 인터널 테이블

*wa-carrid = 'KR'.
*wa-carrname = 'Korean Air'.
*wa-currcode = 'KRW'.
*wa-url = 'http://www.koreanair.com'.
*APPEND wa TO it.
*
**INSERT zscarr_ss36 FROM wa. "데이터베이스에 삽입
**WRITE :/ sy-subrc, sy-dbcnt.
*
** America Airline 삽입, (화폐단위를 'XYZ'로)
*wa-carrid = 'UA'.
*wa-carrname = 'United Airline'.
*wa-currcode = 'USD'.
*wa-url = 'http://www.ua.com'.
*APPEND wa TO it.
*
** ACCEPTING DUPLICATE KEYS : DB Key 값 중복값 체크
*INSERT zscarr_ss36
*FROM TABLE it
*ACCEPTING DUPLICATE KEYS. "데이터베이스에 삽입
*
*WRITE :/ sy-subrc, sy-dbcnt.

* UPDATE <테이블> FROM <스트럭쳐> <- 이 문법 쓸 땐 SELECT를 먼저해야 함
*SELECT SINGLE *
*  FROM zscarr_ss36
*  INTO wa
*  WHERE carrid = 'AA'.
*
*IF sy-subrc = 0.
*  "XYZ -> USD
*  wa-currcode = 'USD'.
*  UPDATE zscarr_ss36 FROM wa.
*ENDIF.
*
*WRITE :/ sy-subrc, sy-dbcnt.

*UPDATE zscarr_ss36
*SET currcode = 'XYZ'
*WHERE carrid = 'AA'.
*
*WRITE :/ sy-subrc, sy-dbcnt.

* 데이터가 존재할 때
*wa-carrid = 'UA'.
*wa-currcode = 'USD'.
*MODIFY zscarr_ss36 FROM wa.

* 데이터가 존재하지 않을 때
*wa-carrid = 'TT'.
*wa-currcode = 'USD'.
*MODIFY zscarr_ss36 FROM wa.

* 항공사 이름이 비워진 데이터를 찾아서 항공사 이름을 Unknown으로 변경
*UPDATE zscarr_ss36
*SET carrname = 'Unknown'
*WHERE carrname = space.

* 홈페이지가 비워있는 항공사를 모두 삭제
*DELETE
*FROM zscarr_ss36
*WHERE url = space.

* KR 삭제
DELETE
FROM zscarr_ss36
WHERE carrid = 'KR'.
WRITE: sy-subrc, sy-dbcnt.

COMMIT WORK. "최종 반영. 확정 짓겠다.
ROLLBACK WORK. "DB 변경 취소

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
