FUNCTION zget_customer_ss36.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_ID) TYPE  SCUSTOM-ID
*"  EXPORTING
*"     REFERENCE(E_NAME) TYPE  SCUSTOM-NAME
*"     REFERENCE(E_TELEPHONE) TYPE  SCUSTOM-TELEPHONE
*"     REFERENCE(E_EMAIL) TYPE  SCUSTOM-EMAIL
*"     REFERENCE(E_LANGU) TYPE  SCUSTOM-LANGU
*"     REFERENCE(E_LANGUT) TYPE  T002T-SPTXT
*"----------------------------------------------------------------------

  SELECT SINGLE name telephone email langu
    FROM scustom
    INTO ( e_name, e_telephone, e_email, e_langu )
    WHERE id = i_id.

  CALL FUNCTION 'HRWPC_RFC_SPRSL_TEXT_GET'
    EXPORTING
      sprsl      = e_langu
      langu      = sy-langu
    IMPORTING
      sprsl_text = e_langut.

ENDFUNCTION.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
