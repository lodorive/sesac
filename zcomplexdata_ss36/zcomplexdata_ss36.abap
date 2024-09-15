*&---------------------------------------------------------------------*
*& Report ZCOMPLEXDATA_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcomplexdata_ss36.

*DATA xyz TYPE s_carrname. "Simple Data Object
*DATA xyz2 TYPE bc400_s_flight. "Structure Data Object
*DATA xyz3 TYPE sflight. "Structure Data Object
*DATA xyz4 LIKE xyz3. "Structure Data Object
*DATA xyz5 TYPE bc400_s_flight-fldate. "Simple Data Object

* 항공사 코드, 항공사 이름, 화폐 단위로 구성된 스트럭쳐 타입 정의
TYPES: BEGIN OF ts_flight,

         carrid   TYPE scarr-carrid,
         carrname TYPE scarr-carrname,
         currcode TYPE scarr-currcode,

       END OF ts_flight.


DATA gs_flight TYPE ts_flight.

* 스트럭쳐 변수에 값 채우기 (KA, Korean Air, KRW)
gs_flight-carrid = 'KA'.
gs_flight-carrname = 'Korean Air'.
gs_flight-currcode = 'KRW'.

* 모든 컴포넌트 출력
WRITE:  gs_flight-carrid,
        gs_flight-carrname,
        gs_flight-currcode.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
