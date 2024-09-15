*&---------------------------------------------------------------------*
*& Report ZRUNTIME_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRUNTIME_S36.

* 화면에서 값을 2개 입력 받아서 나누기 연산을 수행
PARAMETERS p_num1 TYPE i.
PARAMETERS p_num2 TYPE i.

DATA gv_result TYPE i. "나눈 결과를 보관할 변수

IF p_num2 <> 0. "나누는 값이 0이 아니라면 값을 나누고 출력
  gv_result = p_num1 / p_num2.
  WRITE: gv_result.
ELSE."0이라면 에러 메시지 출력
  WRITE: 'Divide by zero not allowed!'.
ENDIF.

** 이 코드가 조금 더 깔끔함(에러 상황을 먼저 검사)
*IF p_num2 = 0.
*  WRITE: 'Divide by zero not allowed!'.
*  ELSE.
*    gv_result = p_num1 / p_num2.
*  WRITE: gv_result.
*ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
