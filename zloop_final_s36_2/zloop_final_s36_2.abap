*&---------------------------------------------------------------------*
*& Report ZLOOP_FINAL_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLOOP_FINAL_S36_2.

* ȭ�鿡�� ���۰��� ���ᰪ�� �Է¹޾� �ش� ������
* Ȧ�� �հ� ¦�� �� �� �� ���� ���̸� ���ϴ� ���α׷��� �����Ͻÿ�
* to�� 100���� ū ���̸� 100������ ó��

PARAMETERS: pa_start TYPE i, "���۰��� �Է� ����
            pa_end TYPE i. "���ᰪ�� �Է� ����

DATA: gv_even_sum TYPE i, "¦�� ���� ����
      gv_odd_sum TYPE i, "Ȧ�� ���� ����
      gv_diff TYPE i. "���̸� ���� ����

"pa_end�� 100���� ū ���� �Է��� ��� 100������ ����
IF pa_end > 100.
*  WRITE: 'End value maximum is 100!'
  "�˾����� ����ڿ��� ������ �ϰ��� �Ѵ�
  MESSAGE i001(BC100_MESSAGE) WITH pa_end.
ELSE.
  " �������� ���
  WHILE pa_start <= pa_end.

*    "�ִ� 100������ ���
*    IF pa_start > 100.
*      EXIT.
*    ENDIF.

*    WRITE:/ pa_start.
    IF pa_start mod 2 = 0. "���� ¦�����
        gv_even_sum = gv_even_sum + pa_start. "¦���� + ���簪
        ELSE.
          gv_odd_sum = gv_odd_sum + pa_start. "�ƴ϶�� Ȧ���� + ���簪
    ENDIF.
    pa_start = pa_start + 1. "����~�� ������ ���� ��� �˻��ϹǷ� +1�� ����

  ENDWHILE.

    "�� ���� ���̸� ���
    IF gv_odd_sum >= gv_even_sum. "Ȧ���� ���� ¦������ ũ�ų� ���ٸ�
        gv_diff = gv_odd_sum - gv_even_sum. "Ȧ�� - ¦���� ���
    ELSE. "�ƴ϶��
        gv_diff = gv_even_sum - gv_odd_sum. "¦�� - Ȧ���� ���
    ENDIF.

  WRITE:/ 'Even Sum:', gv_even_sum.
  WRITE:/ 'Odd Sum:', gv_odd_sum.
  WRITE:/ 'Diff of Two Sums:', gv_diff.

ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
