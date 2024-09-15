*&---------------------------------------------------------------------*
*& Report ZBC400_SS36_STRUCTURE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc400_ss36_structure.

* Exercise13

PARAMETERS: pa_car  TYPE bc400_s_flight-carrid, "�װ��� �ڵ�
            pa_con  TYPE bc400_s_flight-connid, "�װ��� ���� ��ȣ
            pa_date TYPE bc400_s_flight-fldate. "�װ��� ��¥

DATA: gs_carrier TYPE bc400_s_carrier, "�װ��� ������ ������ Structure Object
      gs_flight  TYPE bc400_s_flight. "�װ��� ������ ������ Structure Object

* ����ü ����
TYPES: BEGIN OF ts_carrierflight,
         carrid     TYPE s_carr_id, "�װ��� �ڵ�
         carrname   TYPE s_carrname, "�װ��� �̸�
         currcode   TYPE s_currcode, "�װ��� ��ȭ �ڵ�
         url        TYPE s_carrurl, "�� ����Ʈ URL
         connid     TYPE s_conn_id, "�װ��� ���� ��ȣ
         fldate     TYPE s_date, "�װ��� ��¥
         seatsmax   TYPE s_seatsmax, "�ִ� �¼� ��
         seatsocc   TYPE s_seatsocc, "������ �¼� ��
         percentage TYPE s_flghtocc, "�װ��� ������

       END OF ts_carrierflight.

DATA gs_carrierflight TYPE ts_carrierflight.

* �װ��� ������ �������� Method
TRY.
    CALL METHOD cl_bc400_flightmodel=>get_flight
      EXPORTING
        iv_carrid = pa_car "�Է� ���� �װ��� �ڵ�
        iv_connid = pa_con "�Է� ���� �װ��� ���� ��ȣ
        iv_fldate = pa_date " �Է� ���� �װ��� ��¥
      IMPORTING
        es_flight = gs_flight. "������ �װ��� ������ gs_flight�� ����
  CATCH cx_bc400_no_data .
  CATCH cx_bc400_no_auth .
ENDTRY.

* �װ��� ������ �������� Method
TRY.
    CALL METHOD cl_bc400_flightmodel=>get_carrier
      EXPORTING
        iv_carrid  = pa_car "�Է� ���� �װ��� �ڵ�
      IMPORTING
        es_carrier = gs_carrier. "������ �װ��� ������ gs_carrier�� ����
  CATCH cx_bc400_no_data .
  CATCH cx_bc400_no_auth .
ENDTRY.

* gs_flight �����͸� gs_carrierflight�� ����
MOVE-CORRESPONDING gs_flight TO gs_carrierflight.
* gs_carrier �����͸� gs_carrierflight�� ����
MOVE-CORRESPONDING gs_carrier TO gs_carrierflight.

IF gs_carrierflight IS NOT INITIAL. "���� ������� �ʴٸ� ���

WRITE:/ 'Airline Code:',gs_carrierflight-carrid.
WRITE:/ 'Airline Name:',gs_carrierflight-carrname.
WRITE:/ 'Flight Connection Number:',gs_carrierflight-connid.
WRITE:/ 'Local currency of airline:',gs_carrierflight-currcode.
WRITE:/ 'Flight date:',gs_carrierflight-fldate.
WRITE:/ 'Flight occupancy:',gs_carrierflight-percentage.
WRITE:/ 'Maximum capacity in economy class:',gs_carrierflight-seatsmax.
WRITE:/ 'Occupied seats in economy class:',gs_carrierflight-seatsocc.
WRITE:/ 'Airline URL:',gs_carrierflight-url+0(32).

ENDIF.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
