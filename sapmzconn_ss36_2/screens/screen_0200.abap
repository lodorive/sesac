****************************************************************																																
*   This file was generated by Direct Download Enterprise.     *																																
*   Please do not change it manually.                          *																																
****************************************************************																																
%_DYNPRO																																
SAPMZCONN_SS36_2																																
0200																																
750																																
                40																																
%_HEADER																																
SAPMZCONN_SS36_2                        0200 0200      7 39192 37  0  0 27122  0G E                              20240903200010																																
%_DESCRIPTION																																
                40																																
%_FIELDS																																
SDYN_CONN-CARRID	2	CHAR	 16	30	00	04	30	00	  2	  3		  0	  0	  0		  0			CAR		  0	  0								항공사	                                                                                                                                                                                                                                                        X	
SDYN_CONN-CARRID	C	CHAR	  3	A0	00	84	30	08	  2	 21		  0	  0	  0		  0			CAR		  6	  0								___	X                                      00	
SDYN_CONN-CONNID	2	CHAR	 15	30	00	04	30	00	  3	  3		  0	  0	  0		  0			CON		  0	  0								항공편 번호	                                                                                                                                                                                                                                                        X	
SDYN_CONN-CONNID	N	NUMC	  4	A0	00	84	30	08	  3	 21		  0	  0	  0		  0			CON		  8	  0								____	X                                      00	
SDYN_CONN-COUNTRYFR	2	CHAR	 12	30	00	00	30	00	  4	  3		  0	  0	  0		  0			LND		  0	  0								국가	                                                                                                                                                                                                                                                        X	
SDYN_CONN-COUNTRYFR	C	CHAR	  3	A0	00	80	00	00	  4	 21		  0	  0	  0		  0			LND		  6	  0				XYZ				___	                                       00	
SDYN_CONN-CITYFROM	2	CHAR	 11	30	00	00	30	00	  5	  3		  0	  0	  0		  0					  0	  0								출발 도시	                                                                                                                                                                                                                                                        X	
SDYN_CONN-CITYFROM	C	CHAR	 20	A0	00	80	00	00	  5	 21		  0	  0	  0		  0					 40	  0				XYZ				____________________	                                       00	
SDYN_CONN-COUNTRYTO	2	CHAR	 12	30	00	00	30	00	  6	  3		  0	  0	  0		  0			LND		  0	  0								국가	                                                                                                                                                                                                                                                        X	
SDYN_CONN-COUNTRYTO	C	CHAR	  3	A0	00	80	00	00	  6	 21		  0	  0	  0		  0			LND		  6	  0				XYZ				___	                                       00	
SDYN_CONN-CITYTO	2	CHAR	 17	30	00	00	30	00	  7	  3		  0	  0	  0		  0					  0	  0								도착 도시	                                                                                                                                                                                                                                                        X	
SDYN_CONN-CITYTO	C	CHAR	 20	A0	00	80	00	00	  7	 21		  0	  0	  0		  0					 40	  0				XYZ				____________________	                                       00	
OK_CODE		CHAR	 20	80	10	00	00	00	255	  1	O	  0	  0	  0		  0					  0	  0								____________________		
%_FLOWLOGIC																																
PROCESS BEFORE OUTPUT.																																
 MODULE clear_ok_code.																																
 MODULE STATUS_0200.																																
 MODULE modify_screen.																																
*																																
PROCESS AFTER INPUT.																																
 MODULE USER_COMMAND_0200.																																
