*&---------------------------------------------------------------------*
*&  Include           ZOOP_SS36TOP
*&---------------------------------------------------------------------*

* 주차 관리 시스템 설계
* LocalClass
CLASS  lcl_vehicle DEFINITION.
  PUBLIC SECTION.
    " 여기에 정의하는 건 외부에서 접근 가능
    " Instance Attribute(=Object Attribute)
    DATA plate_num TYPE char8 READ-ONLY. " 자동차 번호판
    DATA color     TYPE char1 READ-ONLY. " 자동차 색상(볼 수는 있어도 변경은 불가)

    " 외부에 자동차 브랜드와 모델을 알려주는 메소드 정의
    METHODS get_maker_and_model
      EXPORTING e_maker TYPE char32
                e_model TYPE char32.

    METHODS set_attrs
      IMPORTING i_maker TYPE char32
                i_model TYPE char32
                i_color TYPE char1.

    " 본인 자동차의 제원을 출력하는 메소드 정의
    METHODS display_attrs.

    " constructor 생성자
    " 자동차를 만들면서 속성을 설정하고 싶어
    " CREATE OBJECT를 만날 때 자동 호출
    METHODS constructor " 무조건 요 이름으로 해야함
      IMPORTING i_maker TYPE char32
                i_model TYPE char32
                i_color TYPE char1.


    " 해당 클래스를 통해 만들어진 자동차 개수를 리턴하는 메소드 정의
    " Static Methode -> Static Attribute만 접근 가능
    CLASS-METHODS print_total_cars.

*--------------------------------------------------

  PRIVATE SECTION.
    " 여기에 정의하는 건 외부에서 접근 불가능.
    DATA maker TYPE char32. " 브랜드
    DATA model TYPE char32. " 모델
    DATA fuel  TYPE i. " 잔여 연료령

    " Static Attribute(=Class Attribute)
    CLASS-DATA n_of_created TYPE i. " 총 생성된 자동차 수
ENDCLASS.

*--------------------------------------------------

CLASS lcl_vehicle IMPLEMENTATION.

  METHOD get_maker_and_model.
    "외부에 본인 자동차의 브랜드와 모델 정보를 리턴
    e_maker = maker. " 메소드의 파라미터 = 속성
    e_model = model. " 메소드의 파라미터 = 속성
  ENDMETHOD.

  METHOD print_total_cars.
    "maker = 'A'. "에러 발생(Static 속성이 아니므로)
    WRITE:/ 'Total created cars:', n_of_created.
  ENDMETHOD.

  METHOD set_attrs.
    "파라미터로 받은 3개를 이용하여, 생성된 자동차의 속성을 설정
    maker = i_maker.
    model = i_model.
    color = i_color.
  ENDMETHOD.

  METHOD display_attrs.
    WRITE:/ 'Maker:', maker.
    WRITE:/ 'Model:', model.
    WRITE:/ 'Color:', color.
    WRITE:/ 'Number:', plate_num.
  ENDMETHOD.

  METHOD constructor.
    "CREATE OBJECT로 전달된 값을 이용하여 속성을 설정
    me->maker = i_maker.
    me->model = i_model.
    me->color = i_color.

    " 생성된 자동차 수를 +1 증가
    n_of_created = n_of_created + 1.

  ENDMETHOD.

ENDCLASS.

* 버스 클래스 설계 (상속 : LCL_VEHICLE)
* INHERITING FROM : 누구의 기능을 상속 받을래?
CLASS lcl_bus DEFINITION INHERITING FROM lcl_vehicle.
  PUBLIC SECTION.

  PRIVATE SECTION.
    DATA n_of_passenger TYPE i. " 승객 수
ENDCLASS.

CLASS lcl_bus IMPLEMENTATION.

ENDCLASS.

* 트럭 클래스 설계
CLASS lcl_truck DEFINITION INHERITING FROM lcl_vehicle.
  PUBLIC SECTION.

  PRIVATE SECTION.
    DATA cargo_size TYPE i. " 적재량
ENDCLASS.

CLASS lcl_truck IMPLEMENTATION.

ENDCLASS.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
