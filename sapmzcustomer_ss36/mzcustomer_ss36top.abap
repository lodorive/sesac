*&---------------------------------------------------------------------*
*& Include MBC414_CUST_TTOP
*&---------------------------------------------------------------------*

* MESSAGE-ID�� ����ϸ� MESSAGE(zmessage_ss36)�� ���� �ʾƵ� ��
* MESSAGE e001.
PROGRAM sapmbc414_cust_t MESSAGE-ID bc414.

TYPES gty_flag TYPE c LENGTH 1.

DATA gv_result       TYPE gty_flag.
DATA gv_data_changed TYPE gty_flag.
DATA ok_code         TYPE syucomm.

TABLES: scustom.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
