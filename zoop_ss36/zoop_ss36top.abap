*&---------------------------------------------------------------------*
*&  Include           ZOOP_SS36TOP
*&---------------------------------------------------------------------*

* ���� ���� �ý��� ����
* LocalClass
CLASS  lcl_vehicle DEFINITION.
  PUBLIC SECTION.
    " ���⿡ �����ϴ� �� �ܺο��� ���� ����
    " Instance Attribute(=Object Attribute)
    DATA plate_num TYPE char8 READ-ONLY. " �ڵ��� ��ȣ��
    DATA color     TYPE char1 READ-ONLY. " �ڵ��� ����(�� ���� �־ ������ �Ұ�)

    " �ܺο� �ڵ��� �귣��� ���� �˷��ִ� �޼ҵ� ����
    METHODS get_maker_and_model
      EXPORTING e_maker TYPE char32
                e_model TYPE char32.

    METHODS set_attrs
      IMPORTING i_maker TYPE char32
                i_model TYPE char32
                i_color TYPE char1.

    " ���� �ڵ����� ������ ����ϴ� �޼ҵ� ����
    METHODS display_attrs.

    " constructor ������
    " �ڵ����� ����鼭 �Ӽ��� �����ϰ� �;�
    " CREATE OBJECT�� ���� �� �ڵ� ȣ��
    METHODS constructor " ������ �� �̸����� �ؾ���
      IMPORTING i_maker TYPE char32
                i_model TYPE char32
                i_color TYPE char1.


    " �ش� Ŭ������ ���� ������� �ڵ��� ������ �����ϴ� �޼ҵ� ����
    " Static Methode -> Static Attribute�� ���� ����
    CLASS-METHODS print_total_cars.

*--------------------------------------------------

  PRIVATE SECTION.
    " ���⿡ �����ϴ� �� �ܺο��� ���� �Ұ���.
    DATA maker TYPE char32. " �귣��
    DATA model TYPE char32. " ��
    DATA fuel  TYPE i. " �ܿ� �����

    " Static Attribute(=Class Attribute)
    CLASS-DATA n_of_created TYPE i. " �� ������ �ڵ��� ��
ENDCLASS.

*--------------------------------------------------

CLASS lcl_vehicle IMPLEMENTATION.

  METHOD get_maker_and_model.
    "�ܺο� ���� �ڵ����� �귣��� �� ������ ����
    e_maker = maker. " �޼ҵ��� �Ķ���� = �Ӽ�
    e_model = model. " �޼ҵ��� �Ķ���� = �Ӽ�
  ENDMETHOD.

  METHOD print_total_cars.
    "maker = 'A'. "���� �߻�(Static �Ӽ��� �ƴϹǷ�)
    WRITE:/ 'Total created cars:', n_of_created.
  ENDMETHOD.

  METHOD set_attrs.
    "�Ķ���ͷ� ���� 3���� �̿��Ͽ�, ������ �ڵ����� �Ӽ��� ����
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
    "CREATE OBJECT�� ���޵� ���� �̿��Ͽ� �Ӽ��� ����
    me->maker = i_maker.
    me->model = i_model.
    me->color = i_color.

    " ������ �ڵ��� ���� +1 ����
    n_of_created = n_of_created + 1.

  ENDMETHOD.

ENDCLASS.

* ���� Ŭ���� ���� (��� : LCL_VEHICLE)
* INHERITING FROM : ������ ����� ��� ������?
CLASS lcl_bus DEFINITION INHERITING FROM lcl_vehicle.
  PUBLIC SECTION.

  PRIVATE SECTION.
    DATA n_of_passenger TYPE i. " �°� ��
ENDCLASS.

CLASS lcl_bus IMPLEMENTATION.

ENDCLASS.

* Ʈ�� Ŭ���� ����
CLASS lcl_truck DEFINITION INHERITING FROM lcl_vehicle.
  PUBLIC SECTION.

  PRIVATE SECTION.
    DATA cargo_size TYPE i. " ���緮
ENDCLASS.

CLASS lcl_truck IMPLEMENTATION.

ENDCLASS.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
