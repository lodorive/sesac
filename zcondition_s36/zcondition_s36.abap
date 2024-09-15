*&---------------------------------------------------------------------*
*& Report ZCONDITION_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCONDITION_S36.

* 문제) 화면에서 나이를 입력 받아서 5살 미만이면 Baby
* 5살 이상이고 10미만이면 Young
* 10살 이상이고 20 미만이면 Teenager
* 나머지는 Old 출력

PARAMETERS pa_age TYPE i. " 나이 입력 받음

IF pa_age < 5. " 5살 미만이면 Baby
  WRITE 'Baby'.
ELSEIF pa_age => 5 AND pa_age < 10. " 5살 이상이고 10미만이면 Young
  WRITE 'Young'.
ELSEIF pa_age => 10 AND pa_age < 20. " 10살 이상이고 20 미만이면 Teenager
  WRITE 'Teenager'.
ELSE.
  WRITE 'Old'. " 나머지는 Old 출력
ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
