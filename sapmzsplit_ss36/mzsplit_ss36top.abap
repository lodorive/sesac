*&---------------------------------------------------------------------*
*& Include MZSPLIT_SS36TOP                                   Module Pool      SAPMZSPLIT_SS36
*&
*&---------------------------------------------------------------------*
PROGRAM SAPMZSPLIT_SS36.

TABLES: SCARR.
DATA ok_code TYPE sy-ucomm.

*���ø� �����̳ʸ� ���� ����
"go_split <--> ȭ���� Splitter�� ���� ������� ��
DATA go_split TYPE REF TO cl_dynpro_splitter.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
