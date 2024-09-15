*&---------------------------------------------------------------------*
*& Report ZBC100_S36_CALC_HOLS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC100_S36_COND.

PARAMETERS: pa_name TYPE string, " 사용자 이름
            pa_total TYPE i, " 일년 총 휴가 일수
            pa_used TYPE i, " 사용한 휴가 일수
            pa_roll TYPE i. " 이월할 휴가 일수

DATA: gv_first_name TYPE string," 성과 이름을 담을 변수 생성
      gv_last_name TYPE string.

SPLIT pa_name AT space " space를 기준으로 성과 이름을 각각의 변수에 담아라
      INTO gv_first_name
      gv_last_name.

* 올해 남은 휴가 일수 계산
DATA gv_remaining TYPE i.

*BREAK-POINT. " 디버깅 방법 중 하나

gv_remaining = pa_total - pa_used. " 총 휴가 일수 - 사용한 휴가 일수

WRITE: icon_flight AS ICON, " 아이콘 추가
gv_remaining COLOR COL_POSITIVE, " 색상 추가
'vacation days remaining for'(REM), gv_first_name. " first name 출력


IF pa_roll => gv_remaining. " 이월할 휴가 일수가 올해 남은 휴가 일수보다 크거나 같다면
  WRITE 'You cannot roll over more days than you have remaining'.
ELSE. " 아니라면 내년 휴가 일수를 계산
  DATA gv_next_year TYPE i.
  gv_next_year = pa_total + pa_roll. " 총 휴가 일수 + 이월 휴가 일수 = 내년 휴가 일수

  NEW-LINE.

  WRITE: icon_holiday AS ICON, " 아이콘 추가
  gv_next_year COLOR COL_TOTAL, " 색상 추가
  'days vacation will be available next year'(NXT).
ENDIF.

*Text elements
*----------------------------------------------------------
* NXT 이월 휴가 일수
* REM 남은 휴가 일수


*Selection texts
*----------------------------------------------------------
* PA_NAME         이름
* PA_ROLL         이월된 휴가 일수
* PA_TOTAL         전체 휴가 일수
* PA_USED         사용한 휴가 일수

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
