FUNCTION ZGET_CUSTOMER_SS36_2.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_ID) TYPE  SCUSTOM-ID
*"  EXPORTING
*"     REFERENCE(E_CUSTOMER) TYPE  ZCUSTDETAIL_SS36
*"  EXCEPTIONS
*"      INVALID_ID
*"----------------------------------------------------------------------

  SELECT SINGLE * "name telephone email langu
    FROM scustom
    INTO CORRESPONDING FIELDS OF E_CUSTOMER "e_name, e_telephone, e_email, e_langu
    WHERE id = i_id.

  IF sy-subrc <> 0.
    "존재하지 않는 고객 ID일 경우 예외 발생
    RAISE INVALID_ID.
  ENDIF.

  CALL FUNCTION 'HRWPC_RFC_SPRSL_TEXT_GET'
    EXPORTING
      sprsl      = E_CUSTOMER-langu
      langu      = sy-langu
    IMPORTING
      sprsl_text = E_CUSTOMER-langut.

ENDFUNCTION.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
