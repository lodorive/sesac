*&---------------------------------------------------------------------*
*& Report ZBC100_FIRST_PROGRAM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC100_FIRST_PROGRAM_2.

PARAMETERS p_name TYPE string. "ȭ�鿡 ������� �̸��� �Է� ����.
PARAMETERS p_age TYPE i. "ȭ�鿡 ������� ���̸� �Է� ����.

WRITE 'Hello'.
NEW-LINE.
WRITE p_name. "����ڰ� �Է��� ���� ���.
WRITE: p_name, 'is', p_age, 'years old'. "ȭ�鿡 �̸��� ���� + ���� ���ڿ� ���.

*WRITE: 'Hello', NEW_LINE, p_name. "�����߻�.
*WRITE: 'Hello', /, p_name. "WRITE ������ NEW-LINE�� ����.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
