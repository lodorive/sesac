*&---------------------------------------------------------------------*
*& Report ZSUBROUTINE_SS36_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSUBROUTINE_SS36_3.

* ȭ�鿡�� Ƚ���� �Է� �޾Ƽ� �ش� Ƚ�� ��ŭ
* Hello ABAP! �� ����ϴ� ���α׷��� �����Ͻÿ�

TYPES TY_NAME TYPE c LENGTH 10. "���� Ÿ�� ���� for �̸�.

* ���� ����(Global Variable)
PARAMETERS pa_cnt TYPE i.
PARAMETERS pa_name TYPE ty_name.
PARAMETERS pa_new TYPE ty_name.

DO pa_cnt TIMES.

 PERFORM WRITE_HELLO USING pa_name. "<-- pa_name or pa_new(Call by Value)
 PERFORM WRITE_HELLO USING pa_new.

ENDDO.
*&---------------------------------------------------------------------*
*&      Form  WRITE_HELLO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM write_hello USING VALUE(f_name) TYPE ty_name.

    WRITE:/ '********************'.
    WRITE:/ 'Hello', f_name, '!'.
    WRITE:/ '********************'.
    SKIP.

    f_name = 'ȫ�浿'. "�Ķ���ͷ� ���۵� ���� ������ ���� ������ ��ġġ ����
                     "���� : Call by Value ���

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
