FUNCTION zget_connect_ss36.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_CARRID) TYPE  SPFLI-CARRID
*"     REFERENCE(I_CONNID) TYPE  SPFLI-CONNID
*"  EXPORTING
*"     REFERENCE(E_SPFLI) TYPE  SPFLI
*"     VALUE(E_FLIGHTTYPE) TYPE  TEXT
*"  EXCEPTIONS
*"      INVALID_FLIGHT
*"----------------------------------------------------------------------

  SELECT SINGLE *"CITYFROM AIRPFROM CITYTO AIRPTO
    FROM spfli
    INTO E_SPFLI "( E_CITYFROM, E_AIRPFROM, E_CITYTO, E_AIRPTO )
    WHERE carrid = i_carrid.

  IF sy-subrc <> 0.
    "�Է��� �װ��� �������� �ʴ� ��� INVALID_FLIGHT �߻�
    RAISE invalid_flight.

  ELSEIF
    E_SPFLI-cityfrom = E_SPFLI-cityto. "��� ������ ���� ������ ���ٸ�
    e_flighttype = '������'.

  ELSE.
    e_flighttype = '������'.

  ENDIF.

ENDFUNCTION.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
