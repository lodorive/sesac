*&---------------------------------------------------------------------*
*& Report ZTWO_TABLES_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztwo_tables_ss36.

* ���� ���̺� SCARR, SPFLI
* ȭ�鿡�� ȭ�� ������ �Է� �޾� �ش� ȭ�� ������ ����ϴ�
* �װ���� �װ����� ����Ͻÿ� (��, ��� �� �װ��� �̸��� �Բ� ����Ͻÿ�)

TYPES: BEGIN OF ts_conn,
         carrid    TYPE scarr-carrid,
         connid    TYPE spfli-connid,
         countryfr TYPE spfli-countryfr,
         countryto TYPE spfli-countryto,
         carrname  TYPE scarr-carrname,
       END OF ts_conn.

DATA gs_conn TYPE ts_conn.

PARAMETERS p_cur TYPE scarr-currcode. "ȭ�����

* ����ڰ� �Է��� ȭ�� ������ �´�
* �װ��� �����͸� �����Ͽ� gs_scarr ������ ����
SELECT carrid carrname
  FROM scarr
  INTO CORRESPONDING FIELDS OF gs_conn
  WHERE currcode = p_cur.

  " ���õ� �װ����� carrid�� ��ġ�ϴ� �װ��� ������
  " gs_spfli ������ ����
  SELECT connid countryfr countryto
    FROM spfli
    INTO CORRESPONDING FIELDS OF gs_conn
    WHERE carrid = gs_conn-carrid.

    " ���õ� �װ��� �� �װ��� ������ ���
    WRITE:/ gs_conn-carrid,         " �װ��� ID
            gs_conn-connid,         " �װ��� ID
            gs_conn-countryfr,     " ��� ����
            gs_conn-countryto,     " ���� ����
            gs_conn-carrname.      " �װ��� �̸�

  ENDSELECT.

ENDSELECT.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
