*&---------------------------------------------------------------------*
*& Report ZSUBROUTINE_SS36_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSUBROUTINE_SS36_3.

* 화면에서 횟수를 입력 받아서 해당 횟수 만큼
* Hello ABAP! 을 출력하는 프로그램을 구현하시오

TYPES TY_NAME TYPE c LENGTH 10. "로컬 타입 정의 for 이름.

* 전역 변수(Global Variable)
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

    f_name = '홍길동'. "파라미터로 전송된 원본 변수의 값에 영향을 미치치 않음
                     "이유 : Call by Value 방식

ENDFORM.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
