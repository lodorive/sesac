*&---------------------------------------------------------------------*
*& Report ZCONDITION_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCONDITION_S36.

* ����) ȭ�鿡�� ���̸� �Է� �޾Ƽ� 5�� �̸��̸� Baby
* 5�� �̻��̰� 10�̸��̸� Young
* 10�� �̻��̰� 20 �̸��̸� Teenager
* �������� Old ���

PARAMETERS pa_age TYPE i. " ���� �Է� ����

IF pa_age < 5. " 5�� �̸��̸� Baby
  WRITE 'Baby'.
ELSEIF pa_age => 5 AND pa_age < 10. " 5�� �̻��̰� 10�̸��̸� Young
  WRITE 'Young'.
ELSEIF pa_age => 10 AND pa_age < 20. " 10�� �̻��̰� 20 �̸��̸� Teenager
  WRITE 'Teenager'.
ELSE.
  WRITE 'Old'. " �������� Old ���
ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
