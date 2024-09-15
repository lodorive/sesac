*&---------------------------------------------------------------------*
*& Report ZQUIZ_S36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZQUIZ_S36.

* ȭ�鿡�� �Ի��ϰ� ����⵵, ����� �̸��� �Է� �޾�
* �ش� ����� ������ ����ϴ� ���α׷��� �����Ͻÿ�

PARAMETERS: p_year TYPE GRRM_YEAR, "�Ի�⵵
            p_crty TYPE GRRM_YEAR, "����⵵
            p_name TYPE c LENGTH 10. "�̸�

* ��: �Ի�⵵ 2020 / �̸� Jane
*DATA: gv_year TYPE c LENGTH 4.
*gv_year = sy-datum+0(4). "����⵵

DATA gv_cnt TYPE c LENGTH 2. "�⺻ ����
gv_cnt = 15. "�⺻ ���� 15��

DATA gv_al TYPE c LENGTH 2. "�ټӿ��� ���� ����
gv_al = p_crty - p_year - 1. "����⵵ - �Ի�⵵ - 1

IF p_year > p_crty. "�Ի�⵵�� ����⵵ ���Ķ��
  MESSAGE i001(ZBC100_msg). "�����޽��� ���
ELSE.

DO gv_al TIMES.

  IF sy-index MOD 2 = 1. " �ټӿ����� Ȧ�����
      gv_cnt = gv_cnt + 1. "������ �߰�

    IF gv_cnt > 30. "���� �ϼ��� 30�� �Ѿ�ٸ�
      gv_cnt = 30. "���� �ϼ��� �ִ밪�� 30�� ����
    ENDIF.

  ENDIF.

ENDDO.

WRITE:/ p_name,
'total vacation allowance on',
p_crty, 'is',
gv_cnt, 'days'.

ENDIF.


*Messages
*----------------------------------------------------------
*
* Message class: ZBC100_MSG
*001   0�� �����ų� 0���� ���� �� �����ϴ�.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
