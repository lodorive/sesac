****************************************************************																																
*   This file was generated by Direct Download Enterprise.     *																																
*   Please do not change it manually.                          *																																
****************************************************************																																
%_DYNPRO																																
SAPMZBC410_SOLUTION_SS36																																
0110																																
750																																
                40																																
%_HEADER																																
SAPMZBC410_SOLUTION_SS36                0110I0110      8 39192 37  0  0 27121  0G E                              20240902160108																																
%_DESCRIPTION																																
                40																																
%_FIELDS																																
SDYN_CONN-COUNTRYFR	2	CHAR	 12	30	00	00	30	00	  1	  3		  0	  0	  0		  0			LND		  0	  0								국가	                                                                                                                                                                                                                                                        X	
SDYN_CONN-COUNTRYFR	C	CHAR	  3	A0	00	80	30	00	  1	 21		  0	  0	  0		  0			LND		  6	  0								___	                                       00	
SDYN_CONN-CITYFROM	2	CHAR	 11	30	00	00	30	00	  2	  3		  0	  0	  0		  0					  0	  0								출발 도시	                                                                                                                                                                                                                                                        X	
SDYN_CONN-CITYFROM	C	CHAR	 20	A0	00	80	30	00	  2	 21		  0	  0	  0		  0					 40	  0								____________________	                                       00	
SDYN_CONN-AIRPFROM	2	CHAR	 15	30	00	00	30	00	  3	  3		  0	  0	  0		  0					  0	  0								출발 공항	                                                                                                                                                                                                                                                        X	
SDYN_CONN-AIRPFROM	C	CHAR	  3	A0	00	80	30	00	  3	 21		  0	  0	  0		  0					  6	  0								___	                                       00	
SDYN_CONN-COUNTRYTO	2	CHAR	 12	30	00	00	30	00	  4	  3		  0	  0	  0		  0			LND		  0	  0								국가	                                                                                                                                                                                                                                                        X	
SDYN_CONN-COUNTRYTO	C	CHAR	  3	A0	00	80	30	00	  4	 21		  0	  0	  0		  0			LND		  6	  0								___	                                       00	
SDYN_CONN-CITYTO	2	CHAR	 17	30	00	00	30	00	  5	  3		  0	  0	  0		  0					  0	  0								도착 도시	                                                                                                                                                                                                                                                        X	
SDYN_CONN-CITYTO	C	CHAR	 20	A0	00	80	30	00	  5	 21		  0	  0	  0		  0					 40	  0								____________________	                                       00	
SDYN_CONN-AIRPTO	2	CHAR	 15	30	00	00	30	00	  6	  3		  0	  0	  0		  0					  0	  0								도착 공항	                                                                                                                                                                                                                                                        X	
SDYN_CONN-AIRPTO	C	CHAR	  3	A0	00	80	30	00	  6	 21		  0	  0	  0		  0					  6	  0								___	                                       00	
SDYN_CONN-DEPTIME	2	CHAR	 15	30	00	00	30	00	  7	  3		  0	  0	  0		  0					  0	  0								출발	                                                                                                                                                                                                                                                        X	
SDYN_CONN-DEPTIME	T	TIME	  8	A0	00	80	30	08	  7	 21		  0	  0	  0		  0					 12	  0								________	X                                      00	
SDYN_CONN-ARRTIME	2	CHAR	 15	30	00	00	30	00	  8	  3		  0	  0	  0		  0					  0	  0								도착 시간	                                                                                                                                                                                                                                                        X	
SDYN_CONN-ARRTIME	T	TIME	  8	A0	00	80	30	08	  8	 21		  0	  0	  0		  0					 12	  0								________	X                                      00	
		CHAR	 20	80	10	00	00	00	255	  1	O	  0	  0	  0		  0					  0	  0								____________________		
%_FLOWLOGIC																																
PROCESS BEFORE OUTPUT.																																
* MODULE STATUS_0110.																																
  MODULE get_spfli.																																
*																																
PROCESS AFTER INPUT.																																
* MODULE USER_COMMAND_0110.																																
