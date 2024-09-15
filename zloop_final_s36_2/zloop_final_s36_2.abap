*&---------------------------------------------------------------------*
*& Report ZLOOP_FINAL_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLOOP_FINAL_S36_2.

* 화면에서 시작값과 종료값을 입력받아 해당 범위의
* 홀수 합과 짝수 합 및 두 합의 차이를 구하는 프로그램을 구현하시오
* to가 100보다 큰 값이면 100까지만 처리

PARAMETERS: pa_start TYPE i, "시작값을 입렵 받음
            pa_end TYPE i. "종료값을 입렵 받음

DATA: gv_even_sum TYPE i, "짝수 담을 변수
      gv_odd_sum TYPE i, "홀수 담을 변수
      gv_diff TYPE i. "차이를 담을 변수

"pa_end가 100보다 큰 값을 입력할 경우 100까지만 설정
IF pa_end > 100.
*  WRITE: 'End value maximum is 100!'
  "팝업으로 사용자에게 인폼을 하고자 한다
  MESSAGE i001(BC100_MESSAGE) WITH pa_end.
ELSE.
  " 정상적인 경우
  WHILE pa_start <= pa_end.

*    "최대 100까지만 계산
*    IF pa_start > 100.
*      EXIT.
*    ENDIF.

*    WRITE:/ pa_start.
    IF pa_start mod 2 = 0. "값이 짝수라면
        gv_even_sum = gv_even_sum + pa_start. "짝수값 + 현재값
        ELSE.
          gv_odd_sum = gv_odd_sum + pa_start. "아니라면 홀수값 + 현재값
    ENDIF.
    pa_start = pa_start + 1. "시작~끝 사이의 값을 모두 검사하므로 +1씩 증가

  ENDWHILE.

    "두 합의 차이를 계산
    IF gv_odd_sum >= gv_even_sum. "홀수의 값이 짝수보다 크거나 같다면
        gv_diff = gv_odd_sum - gv_even_sum. "홀수 - 짝수로 계산
    ELSE. "아니라면
        gv_diff = gv_even_sum - gv_odd_sum. "짝수 - 홀수로 계산
    ENDIF.

  WRITE:/ 'Even Sum:', gv_even_sum.
  WRITE:/ 'Odd Sum:', gv_odd_sum.
  WRITE:/ 'Diff of Two Sums:', gv_diff.

ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
