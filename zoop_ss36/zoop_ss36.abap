*&---------------------------------------------------------------------*
*& Report ZOOP_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zoop_ss36.

INCLUDE zoop_ss36top. " 부모 클래스 / 버스 클래스 / 트럭 클래스

  DATA gt_parking TYPE TABLE OF REF TO lcl_vehicle. " 버스 / 트럭 담을 수 있음

  DATA go_bus TYPE REF TO lcl_bus.
  DATA go_truck TYPE REF TO lcl_truck.

START-OF-SELECTION.

  " 버스 생성
  " 부모의 생성자를 그대로 물려받음
  CREATE OBJECT go_bus
    EXPORTING
      i_maker = '현대'
      i_model = 'Happy City'
      i_color = '1' .

  APPEND go_bus TO gt_parking. " 타입이 다르지만 객체 지향 프로그램이기 때문에 가능
                               " CASTING 이 발생(부모의 타입으로 바뀜)
                               " Generalization  = Up.Cast

  " 트럭 생성
  CREATE OBJECT go_truck
    EXPORTING
      i_maker = '볼보'
      i_model = 'T12'
      i_color = '5'.

  APPEND go_truck TO gt_parking. " 타입이 다르지만 객체 지향 프로그램이기 때문에 가능

*" 자동차를 생성 (REF 변수)
*DATA go_car01 TYPE REF TO lcl_vehicle.
*DATA go_car02 LIKE go_car01.
*
*" 인터널 테이블 선언(자동차를 보관할 수 있는 인터널 테이블)
*DATA gt_parking TYPE TABLE OF REF TO lcl_vehicle.
*
*START-OF-SELECTION.
*
** 자동차 2대 생성
*  CREATE OBJECT go_car01
*    EXPORTING i_maker = '현대'
*              i_model = '제네시스'
*              i_color = '3'.
*
*  APPEND go_car01 TO gt_parking.
*
*  CREATE OBJECT go_car02
*    EXPORTING i_maker = '벤츠'
*              i_model = 'S클래스'
*              i_color = '1'.
*
*  APPEND go_car02 TO gt_parking.
*
*  CREATE OBJECT go_car02
*    EXPORTING i_maker = '아우디'
*              i_model = 'A6'
*              i_color = '4'.
*
*  APPEND go_car02 TO gt_parking.
*
*** 주차장에 들어 있는 2번째 자동차의 제원을 확인 하고 싶어
*  DATA gw_car TYPE REF TO lcl_vehicle.
**  READ TABLE gt_parking INTO gw_car INDEx 2. " 2번째 포인터를 읽음
**
**  gw_car->display_attrs( ).
*
** 우리 회사 주차장에 있는 모든 자동차의 제원을 확인
*  LOOP AT gt_parking INTO gw_car.
*    gw_car->display_attrs( ). " 1번 문법
**    CALL METHOD gw_car->display_attrs( ). " 2번 문법
*    NEW-LINE.
*  ENDLOOP.
*
** 총 생산된 자동차 개수를 출력하고자 함(Print_total_cars 호출)
*  lcl_vehicle=>print_total_cars( ).

* 자동차를 하나 생성하고 go_car01를 가리키게 되면
* 기존에 go_car01이 가리키고 있던 포인터가 끊어진다
* 그러므로 그 오브젝트는 가비지 콜렉터가 동작하게 됨
*  CREATE OBJECT go_car01.
*
*  CLEAR: go_car01, go_car02. "포인터를 끊어라 -> 가비지 콜렉터가 동작할 개연성이 생김

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
