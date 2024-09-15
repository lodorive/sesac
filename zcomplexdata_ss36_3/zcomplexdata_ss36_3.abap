*&---------------------------------------------------------------------*
*& Report ZCOMPLEXDATA_SS36_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcomplexdata_ss36_3.

* Local Structured Type ����
TYPES: BEGIN OF ts_student,
         id      TYPE n LENGTH 8,
         name    TYPE c LENGTH 32,
         address TYPE c LENGTH 128,
         age     TYPE n LENGTH 3,
       END OF ts_student.

* Local Table Type ����
TYPES: tt_student TYPE STANDARD TABLE OF ts_student
                  WITH NON-UNIQUE KEY id.

* Internal Table ���� with Table Type
DATA gt_student TYPE tt_student. "���� �л��� ���� �� �ִ� ����

* Work Area (Structure Variable)
*DATA gw_student TYPE ts_student. "1��

* Table Type���� ����� ������ Internal Table
*DATA gw_student TYPE LINE OF tt_student. "2��

* Work Area
DATA gw_student LIKE LINE OF gt_student. "3��

* Internal Table�� 1/ȫ�浿/����/24 �� ����
CLEAR gw_student. "�����Ⱚ ����
gw_student-id = 1.
gw_student-name = 'ȫ�浿'.
gw_student-address = '����'.
gw_student-age = 24.
APPEND gw_student TO gt_student.

* Internal Table�� 3/��̸�/?/21 ����
CLEAR gw_student. "�����Ⱚ ����
gw_student-id = 3.
gw_student-name = '��̸�'.
*gw_student-address = '����'.
gw_student-age = 21.
APPEND gw_student TO gt_student.

CLEAR gw_student. "�����Ⱚ ����
gw_student-id = 5.
gw_student-name = '��׷�'.
gw_student-address = '�λ�'.
gw_student-age = 28.
APPEND gw_student TO gt_student.

* Intetnal Table���� ������ �б�
* 1) Index ���� (������ ����)
READ TABLE gt_student INTO gw_student INDEX 2.
IF sy-subrc = 0. "�� �о�����(INDEX 2���� �ִٸ�)
*  WRITE:/ gw_student-name.
ENDIF.

* 2) Key ����
READ TABLE gt_student INTO gw_student
                      WITH KEY address = '�λ�'.
IF sy-subrc = 0. "�� �о�����(address = '�λ�'�� �ִٸ�)
*  WRITE:/ gw_student-name.
ENDIF.

CLEAR gw_student. "�����Ⱚ ����
gw_student-id = 7.
gw_student-name = '��׷�'.
gw_student-address = '��õ'.
gw_student-age = 27.
APPEND gw_student TO gt_student.

* 3) �̸��� '��׷�'�̸鼭 ���̰� 27���� ģ�� ã��
READ TABLE gt_student INTO gw_student
                      WITH KEY name = '��׷�'
                               age = 27.
IF sy-subrc = 0.
*  WRITE:/ gw_student-address.
ENDIF.

* 4) sy-subrc üũ�� �� �� ��� -> ������ �� ���� �� ����
* ���� �ϱ� ���ؼ� CLEAR�� sy-subrc ����� �ʼ��� ���ָ� ����
CLEAR gw_student.
READ TABLE gt_student INTO gw_student
                      WITH KEY address = '����'
                               age = 50.
IF sy-subrc = 0.
*WRITE:/ gw_student-address.
ENDIF.

* �ּҰ� ����� �ִ� ��̸��� �ּҸ� �������� ����
* 1) ��̸��� �о�� ��
READ TABLE gt_student INTO gw_student INDEX 2.
IF sy-subrc = 0. "���� �ִٸ�
  gw_student-age = 22.
  gw_student-address = '����'.
  " gw_student�� id�� ������ �ִ� ���� ã�Ƽ�
  " �ش� ������ �ּҸ� �������� ����
  " ���� : id�� Internal Table�� Key�̱� ������
  MODIFY TABLE gt_student FROM gw_student.
ENDIF.

* Internal Table�� ���� 4���� �л� ����
* 1) Index ����(0 ~ 1��)
*DELETE gt_student INDEX 3.

* 2) Key ����(0 ~ n��) --- AND OR ��� ����
*DELETE gt_student WHERE address = '����'.

* ��� �л��� �ּҸ� ����� �����ϰ��� �� (= Internal table Loop �ʿ�)
LOOP AT gt_student INTO gw_student.

  gw_student-address = '����'.
  MODIFY gt_student FROM gw_student.

ENDLOOP.

* ���̰� 25�� �̻��� �л��� �ּҸ� ����� ��� �����ϰ��� �� (Loop + WHERE)
LOOP AT gt_student INTO gw_student WHERE age > 25.

  gw_student-address = '����'.
  MODIFY gt_student FROM gw_student.

ENDLOOP.

* ���̰� ���� ������� ����(SORT)
SORT gt_student BY age DESCENDING.

* �ּҷ� ���� ���� �� ���̷� ����
*SORT gt_student BY address age.

* Internal Table�� ��ü ������ ���
LOOP AT gt_student INTO gw_student. "WHERE age > 25
  WRITE:/ sy-tabix,
          gw_student-id, gw_student-name+0(10),
          gw_student-address+0(15), gw_student-age.
ENDLOOP.

* Intetnal Table ������ Ȯ���ϰ� ���� �� ��� ��
*CALL METHOD cl_demo_output=>display_data
*  EXPORTING
*    value = gt_student.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
