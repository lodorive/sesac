*&---------------------------------------------------------------------*
*& Report ZBC400_SECOND_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC400_SECOND_SS36.

*DATA xyz1 TYPE c LENGTH 3. "ABAP Standard Data Type
* xyz2 와 xyz3는 같다
*DATA xyz2 TYPE s_carr_id. "Data Element
*DATA xyz3 TYPE scarr_carrid. "테이블의 컬럼을 참조

* S_CARR_ID : C:3 -> Data Element -> Global Data Type
*PARAMETERS p_id1 TYPE s_carr_id. "기술적인 정보 + 의미적인 정보
*PARAMETERS p_id2 TYPE c LENGTH 3. "오직 기술적인 정보

** 이름을 위한 타입 정의 (C:32) -> Local Data Type
*TYPES ty_name TYPE c LENGTH 128.
*
*PARAMETERS p_today TYPE d. "날짜를 입력
*
** 사용자에게 나이를 입력받고자 한다. i, p(x), n(o)
*PARAMETERS p_age TYPE n LENGTH 3. "3자리 숫자만 입력 가능(음수도 X)
*
*PARAMETERS p_name TYPE ty_name.
*
** 타입 N의 변수 출력
*WRITE: p_age.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
