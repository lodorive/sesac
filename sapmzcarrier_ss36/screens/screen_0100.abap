****************************************************************																																
*   This file was generated by Direct Download Enterprise.     *																																
*   Please do not change it manually.                          *																																
****************************************************************																																
%_DYNPRO																																
SAPMZCARRIER_SS36																																
0100																																
750																																
                40																																
%_HEADER																																
SAPMZCARRIER_SS36                       0100 0100      9121192 37  0  0 27122  0G E                              20240829093513																																
%_DESCRIPTION																																
                40																																
%_FIELDS																																
SCARR-CARRID	2	CHAR	 16	30	00	00	30	00	  5	  6		  0	  0	  0		  0			CAR		  0	  0								�װ���	                                                                                                                                                                                                                                                        X	
SCARR-CARRID	C	CHAR	  3	A0	00	A0	00	00	  5	 23		  0	  0	  0		  0			CAR		  6	  0								___	X                                      00	
SCARR-CARRNAME	2	CHAR	 16	30	02	00	30	00	  7	  6		  0	  0	  0		  0					  0	  0								�װ���	                                                                                                                                                                                                                                                        X	
SCARR-CARRNAME	C	CHAR	 20	A0	02	80	30	00	  7	 23		  0	  0	  0		  0					 40	  0								____________________	                                       00	
SCARR-CURRCODE	2	CHAR	 16	30	00	04	30	00	  8	  6		  0	  0	  0		  0					  0	  0								�װ��� ��ȭ	                                                                                                                                                                                                                                                        X	
SCARR-CURRCODE	C	CUKY	  5	A0	00	84	30	08	  8	 23		  0	  0	  0		  0					 10	  0								_____	X                                      00	
TCURT-LTEXT	C	CHAR	 40	80	00	80	30	00	  8	 29		  0	  0	  0		  0					  0	  0								________________________________________		
SCARR-URL	2	CHAR	  3	30	02	00	30	00	  9	  6		  0	  0	  0		  0					  0	  0								URL	                                                                                                                                                                                                                                                        X	
SCARR-URL	C	CHAR	255	B1	02	80	30	00	  9	 23		  0	  0	  0		100					255	  0								____________________________________________________________________________________________________________________________________	                                       00	
		CHAR	 20	80	10	00	00	00	255	  1	O	  0	  0	  0		  0					  0	  0								____________________		
%_FLOWLOGIC																																
PROCESS BEFORE OUTPUT.																																
* MODULE STATUS_0100.																																
*																																
PROCESS AFTER INPUT.																																
* MODULE USER_COMMAND_0100.																																
																																
MODULE get_carrier. "�װ��� �� ������ ��ȸ�ϴ� ���																																