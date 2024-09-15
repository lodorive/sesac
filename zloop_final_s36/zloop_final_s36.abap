*&---------------------------------------------------------------------*
*& Report ZLOOP_FINAL_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZLOOP_FINAL_S36.

* ȭ�鿡�� ���۰��� ���ᰪ�� �Է¹޾� �ش� ������
* Ȧ�� �հ� ¦�� �� �� �� ���� ���̸� ���ϴ� ���α׷��� �����Ͻÿ�

PARAMETERS: pa_from TYPE i, " ���۰��� �Է� ����
            pa_to TYPE i. " ���ᰪ�� �Է� ����

DATA: gv_even TYPE i, " ¦�� ���� ����
      gv_odd TYPE i, " Ȧ�� ���� ����
      gv_result TYPE i, " LOOP���� ����� ����
      gv_result2 TYPE i. " �� ���� ���� ���� ���� ����

      gv_result = pa_from. "���۰��� ����

      " pa_to�� 100���� ū ���� �Է��� ��� 100������ ó����
      IF pa_to > 100.
        pa_to = 100.
      ENDIF.

      " gv_result�� ���� pa_to�� ���� �� ������ LOOP
      WHILE gv_result <= pa_to.

        IF gv_result mod 2 = 0. " ���� ¦�����
          gv_even = gv_even + gv_result. " ¦���� + ���簪
        ELSE. gv_odd = gv_odd + gv_result. " �ƴ϶�� Ȧ���� + ���簪

        ENDIF.

        gv_result = gv_result + 1. " ����~�� ������ ���� ��� �˻��ϹǷ� +1�� ����

        ENDWHILE.

        " �� ���� ���̸� ���
        IF gv_odd >= gv_even. " Ȧ���� ���� ¦������ ũ�ų� ���ٸ�
            gv_result2 = gv_odd - gv_even. " Ȧ�� - ¦���� ���
        ELSE. " �ƴ϶��
            gv_result2 = gv_even - gv_odd. " ¦�� - Ȧ���� ���
        ENDIF.

WRITE:/ 'Even Sum:', gv_even.
WRITE:/ 'Odd Sum:', gv_odd.
WRITE:/ 'Diff of Two Sums:', gv_result2.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
