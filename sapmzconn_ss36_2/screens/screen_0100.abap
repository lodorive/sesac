****************************************************************																																
*   This file was generated by Direct Download Enterprise.     *																																
*   Please do not change it manually.                          *																																
****************************************************************																																
%_DYNPRO																																
SAPMZCONN_SS36_2																																
0100																																
750																																
                40																																
%_HEADER																																
SAPMZCONN_SS36_2                        0100 0100      8 41192 37  0  0 27124  0G E                              20240901222401																																
%_DESCRIPTION																																
                40																																
%_FIELDS																																
SPFLI-CARRID	2	CHAR	 16	30	00	04	30	00	  2	  5		  0	  0	  0		  0			CAR		  0	  0								�װ���	                                                                                                                                                                                                                                                        X	
SPFLI-CARRID	C	CHAR	 15	B0	0C	A4	00	18	  2	 22		  0	  0	  0		 20			CAR		  6	  0								_______________	XDL K                                  00	
SPFLI-CONNID	2	CHAR	 15	30	00	00	30	00	  3	  5		  0	  0	  0		  0			CON		  0	  0								�װ��� ��ȣ	                                                                                                                                                                                                                                                        X	
SPFLI-CONNID	N	NUMC	  4	A0	0C	A0	00	00	  3	 22		  0	  0	  0		  0			CON		  8	  0								____	                                       00	
BOX_MODE		CHAR	 39	00	00	00	30	00	  5	  4		  0	  0	  0		  4	R				  0	  0	101							Mode		
GS_MODE-DISPLAY	C	CHAR	  1	80	00	80	00	00	  6	  6		  0	  0	  0		  0	A				  0	  0	102								                                                                                                                                                                        TOGG	
GS_MODE-DISPLAY	0	CHAR	  7	00	00	00	30	00	  6	  8		  0	  0	  0		  0	A				  0	  0	102							Display		
GS_MODE-CHANGE	C	CHAR	  1	80	00	80	00	00	  7	  6		  0	  0	  0		  0	A				  0	  0	102								                                                                                                                                                                        TOGG	
GS_MODE-CHANGE	0	CHAR	  6	00	00	00	30	00	  7	  8		  0	  0	  0		  0	A				  0	  0	102							Change		
OK_CODE		CHAR	 20	80	10	00	00	00	255	  1	O	  0	  0	  0		  0					  0	  0								____________________		
%_FLOWLOGIC																																
PROCESS BEFORE OUTPUT.																																
 MODULE clear_ok_code.																																
 MODULE STATUS_0100.																																
*																																
PROCESS AFTER INPUT.																																
  MODULE get_data.																																
  MODULE USER_COMMAND_0100.																																