*&---------------------------------------------------------------------*
*& Report ZDEEP_AIRLINE_SS36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDEEP_AIRLINE_SS36_2.

DATA gs_airline TYPE ZDEEP_AIRLINE_SS36. "����ü Ÿ�� ���� ����
*DATA gw_connections LIKE LINE OF gs_airline-connections.
DATA gw_connections TYPE ZAIRLINE_SS36. "gs_airline�� ���Ե� connections Ÿ���� ���� ����

PARAMETERS pa_car TYPE scarr-carrid. "�װ��� �ڵ�

* �Է� ���� �װ��� �ڵ带 �̿��Ͽ� ���ڵ� ��ȸ �� gs_airline�� ����
SELECT SINGLE *
  FROM scarr
  INTO CORRESPONDING FIELDS OF gs_airline
  WHERE carrid = pa_car.

  " �װ��� �ڵ�, �װ��� �̸� ���
  WRITE:/ gs_airline-carrid, gs_airline-carrname.

  " gs_airline�� ����Ǿ� �ִ� �װ��� �ڵ�� spfli ���ڵ� ��ȸ ��
  " gs_airline�� ���ԵǾ� �ִ� connections ���̺� ����
  SELECT *
    FROM SPFLI
    INTO CORRESPONDING FIELDS OF TABLE gs_airline-connections
    WHERE carrid = gs_airline-carrid.

    " gs_airline�� ���Ե� ���̺� gs_airline-connections�� �����Ͽ�
    " �� ���� ������ ���
    LOOP AT gs_airline-connections INTO gw_connections.

      WRITE:/
      gw_connections-connid,
      gw_connections-countryfr,
      gw_connections-countryto,
      gw_connections-cityfrom,
      gw_connections-cityto.

      ENDLOOP.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
