*&---------------------------------------------------------------------*
*& Report ZLOOP_FINAL_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLOOP_FINAL_S36.

* 화면에서 시작값과 종료값을 입력받아 해당 범위의
* 홀수 합과 짝수 합 및 두 합의 차이를 구하는 프로그램을 구현하시오

PARAMETERS: pa_from TYPE i, " 시작값을 입렵 받음
            pa_to TYPE i. " 종료값을 입렵 받음

DATA: gv_even TYPE i, " 짝수 담을 변수
      gv_odd TYPE i, " 홀수 담을 변수
      gv_result TYPE i, " LOOP에서 사용할 변수
      gv_result2 TYPE i. " 두 수의 차이 값을 담을 변수

      gv_result = pa_from. "시작값을 넣음

      " pa_to가 100보다 큰 값을 입력할 경우 100까지만 처리함
      IF pa_to > 100.
        pa_to = 100.
      ENDIF.

      " gv_result의 값이 pa_to의 값이 될 때까지 LOOP
      WHILE gv_result <= pa_to.

        IF gv_result mod 2 = 0. " 값이 짝수라면
          gv_even = gv_even + gv_result. " 짝수값 + 현재값
        ELSE. gv_odd = gv_odd + gv_result. " 아니라면 홀수값 + 현재값

        ENDIF.

        gv_result = gv_result + 1. " 시작~끝 사이의 값을 모두 검사하므로 +1씩 증가

        ENDWHILE.

        " 두 합의 차이를 계산
        IF gv_odd >= gv_even. " 홀수의 값이 짝수보다 크거나 같다면
            gv_result2 = gv_odd - gv_even. " 홀수 - 짝수로 계산
        ELSE. " 아니라면
            gv_result2 = gv_even - gv_odd. " 짝수 - 홀수로 계산
        ENDIF.

WRITE:/ 'Even Sum:', gv_even.
WRITE:/ 'Odd Sum:', gv_odd.
WRITE:/ 'Diff of Two Sums:', gv_result2.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
