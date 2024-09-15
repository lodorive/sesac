*&---------------------------------------------------------------------*
*& Include MZDEMO_SS36TOP                                    Module Pool      SAPMZDEMO_SS36
*&
*&---------------------------------------------------------------------*
PROGRAM SAPMZDEMO_SS36.

* 화면에 그린 스트럭쳐와 통신할 변수 선언하기
TABLES zcalculator_ss36. "ABAP 딕셔너리와 통신할 수 있는 변수 선언


* 계산기를 위한 변수 선언
DATA: gv_arg1 TYPE i,
      gv_arg2 TYPE i,
      gv_operator TYPE c LENGTH 1, " +, - , / , *
      gv_result TYPE i.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
