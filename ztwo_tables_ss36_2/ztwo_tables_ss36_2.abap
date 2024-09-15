REPORT ztwo_tables_ss36_2.

* ���� ���̺� SCARR, SPFLI
* ȭ�鿡�� ȭ�� ������ �Է� �޾� �ش� ȭ�� ������ ����ϴ�
* �װ���� �װ����� ����Ͻÿ� (��, ��� �� �װ��� �̸��� �Բ� ����Ͻÿ�)

PARAMETERS p_cur TYPE scarr-currcode. "ȭ�����

* scarr�� spfli�� ���̺� ������ ���� ���̺� ����
DATA gs_scarr TYPE scarr. " �װ��� ���̺� ����
DATA gt_scarr LIKE TABLE OF gs_scarr.
DATA gs_spfli TYPE spfli. " �װ��� ���̺� ����
DATA gt_spfli LIKE TABLE OF gs_spfli.

* ����ڰ� �Է��� ȭ�� ������ �´�
* �װ��� �����͸� �����Ͽ� gt_scarr ���� ���̺� ����
SELECT carrid carrname
  FROM scarr
  INTO CORRESPONDING FIELDS OF TABLE gt_scarr
  WHERE currcode = p_cur.

* gt_scarr ���� ���̺��� �װ��� ������ �ϳ��� �о��
LOOP AT gt_scarr INTO gs_scarr.

  " ���� ���� �װ����� carrid�� ��ġ�ϴ� �װ��� ������
  " gt_spfli ���� ���̺� ����
  SELECT connid countryfr countryto
  FROM spfli
  INTO CORRESPONDING FIELDS OF TABLE gt_spfli
  WHERE carrid = gs_scarr-carrid.

  " gt_spfli ���� ���̺��� �װ��� ������ �ϳ��� �о��
  LOOP AT gt_spfli INTO gs_spfli.

    WRITE:/ gs_scarr-carrid,         " �װ��� ID
            gs_spfli-connid,         " �װ��� ID
            gs_spfli-countryfr,     " ��� ����
            gs_spfli-countryto,     " ���� ����
            gs_scarr-carrname.      " �װ��� �̸�

  ENDLOOP.

ENDLOOP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
