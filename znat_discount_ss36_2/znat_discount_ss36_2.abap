*&---------------------------------------------------------------------*
*& Report ZNAT_DISCOUNT_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT znat_discount_ss36_2.

* 화면에서 국가 코드(단일 값)과 할인율(범위 값)을 입력 받아
* 해당 조건의 고객을 출력하는 프로그램을 구현하시오
* (출력시 할인율이 높은 고객부터 출력하시오)

* + 기존에 개발한 프로그램을 개선
* 각 Event Block에 로직을 직접 구현하지 말고 서브루틴으로 설계
* 일본(JP) 국가의 고객을 조회 시 조회할 수 없다고 메시지 처리
* 화면이 뜨자마자 국가는 DE, 할인율은 20 ~ 25로 설정

* 복습용

* 타입 정의
TYPES: BEGIN OF ts_cust,
         id           TYPE scustom-id,
         name         TYPE scustom-name,
         country      TYPE scustom-country,
         custtype     TYPE scustom-custtype,
         discount     TYPE scustom-discount,
         adj_discount TYPE scustom-discount,
       END OF ts_cust.

* 변수 정의
DATA: gt_cust TYPE TABLE OF ts_cust,
      gw_cust LIKE LINE OF gt_cust.

* 입력 값
PARAMETERS: pa_cou TYPE scustom-country.
SELECT-OPTIONS so_dis FOR gw_cust-discount.

INITIALIZATION.
  PERFORM init.

AT SELECTION-SCREEN.
  PERFORM check-cou.

START-OF-SELECTION.

  PERFORM get_data. "데이터 취득

  " 데이터 가공
  LOOP AT gt_cust INTO gw_cust.

  CASE gw_cust-custtype.
  WHEN 'B'.
      gw_cust-adj_discount = gw_cust-discount + 2.
  WHEN 'P'.
      gw_cust-adj_discount = gw_cust-discount.
  ENDCASE.
  MODIFY gt_cust FROM gw_cust.

  ENDLOOP.

END-OF-SELECTION.
SORT gt_cust BY adj_discount DESCENDING ID ASCENDING.

LOOP AT gt_cust INTO gw_cust.
  " 데이터 출력
  PERFORM write_cust.

ENDLOOP.

* 기본 값 서브루틴
FORM init .
  pa_cou = 'DE'.

  so_dis-sign = 'I'.
  so_dis-option = 'BT'.
  so_dis-low = 20.
  so_dis-high = 25.
  APPEND so_dis TO so_dis.

ENDFORM.

* JP 국가의 고객 조회 체크(에러 메시지 출력)
FORM check-cou .

  IF pa_cou = 'JP'.
    MESSAGE E007(ZMESSAGE_SS36) WITH pa_cou.
  ENDIF.

ENDFORM.

FORM get_data .
  " 데이터 취득
  SELECT *
  FROM scustom
  INTO CORRESPONDING FIELDS OF TABLE gt_cust
  WHERE COUNTRY = pa_cou
  AND DISCOUNT IN so_dis.

ENDFORM.

FORM write_cust .
 WRITE:/ gw_cust-id,
  gw_cust-name,
  gw_cust-country,
  gw_cust-custtype,
  gw_cust-discount,
  gw_cust-adj_discount,'%'.
ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
