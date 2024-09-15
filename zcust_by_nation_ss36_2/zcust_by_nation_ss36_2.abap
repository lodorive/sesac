*&---------------------------------------------------------------------*
*& Report ZCUST_BY_NATION_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcust_by_nation_ss36_2.

* 프로그램 이름 : ZCUST_BY_NATION_SS36
* 화면에서 국가 코드를 입력 받아서 해당 국적의 고객을 모두 출력하는 프로그램을 구현

* 입력 파라미터
PARAMETERS p_cou TYPE scustom-country.

DATA gs_scustom TYPE scustom. " 스트럭쳐 타입의 결과 값 담을 공간
DATA gt_scustom LIKE TABLE OF gs_scustom. " 인터널 테이블

* SELECT LOOP
SELECT id name country telephone email

  FROM scustom
  INTO CORRESPONDING FIELDS OF TABLE gt_scustom "608건의 데이터가 한 번에 담김(US 일 때)
  WHERE country = p_cou.

WRITE: sy-dbcnt.

* 인터널 테이블 루프 돌면서 출력
LOOP AT gt_scustom INTO gs_scustom.

  " 이메일이 비어 있으면
  IF gs_scustom-email IS INITIAL.
    gs_scustom-email = 'N/A'.
  ENDIF.
  " 전화번호가 비어 있으면
  IF gs_scustom-telephone IS INITIAL.
    gs_scustom-telephone = 'N/A'.
  ENDIF.

WRITE: sy-tabix,
       gs_scustom-id,
       gs_scustom-name,
       gs_scustom-country,
       gs_scustom-telephone,
       gs_scustom-email.

ENDLOOP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
