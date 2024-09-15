FUNCTION zupdate_conn_ss36.
*"----------------------------------------------------------------------
*"*"Update Function Module:
*"
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(I_SDYN_CONN) TYPE  SDYN_CONN
*"----------------------------------------------------------------------

* 입력 받은 파라미터를 이용하여 SPFLI 업데이트 수행
  UPDATE spfli
    SET countryfr = i_sdyn_conn-countryfr
        countryto = i_sdyn_conn-countryto
        cityfrom = i_sdyn_conn-cityfrom
        cityto = i_sdyn_conn-cityto
  WHERE carrid = i_sdyn_conn-carrid
  AND   connid = i_sdyn_conn-connid.

  IF sy-subrc <> 0.
    MESSAGE a013(zmessage_ss36).
  ENDIF.

ENDFUNCTION.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
