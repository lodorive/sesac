****************************************************************																																
*   This file was generated by Direct Download Enterprise.     *																																
*   Please do not change it manually.                          *																																
****************************************************************																																
%_DYNPRO																																
SAPMZ_STUDENTSS36																																
0200																																
750																																
                40																																
%_HEADER																																
SAPMZ_STUDENTSS36                       0200 0200     11 47192 37  0  0 27122  0G E                              20240904173358																																
%_DESCRIPTION																																
                40																																
%_FIELDS																																
BOX_STD		CHAR	 47	00	00	00	30	00	  1	  2		  0	  0	  0		  3	R				  0	  0	101							Student		
ZSTD_SS36-ID	0	CHAR	 20	30	00	00	30	00	  2	  4		  0	  0	  0		  0					  0	  0								Student ID	                                                                                                                                                                                                                                                        X	
ZSTD_SS36-ID	N	NUMC	  8	A0	00	80	30	08	  2	 25		  0	  0	  0		  0					 16	  0				STU				________	X                                      00	
BOX_DETAIL		CHAR	 47	00	00	00	30	00	  4	  2		  0	  0	  0		  8	R				  0	  0	102							Student Detail		
ZSTD_SS36-NAME	1	CHAR	 10	30	02	00	30	00	  5	  4		  0	  0	  0		  0					  0	  0								Name	                                                                                                                                                                                                                                                        X	
ZSTD_SS36-NAME	C	CHAR	 12	A0	02	A0	00	00	  5	 25		  0	  0	  0		  0					 24	  0				STU				____________	                                       00	
ZSTD_SS36-AGE	1	CHAR	 10	30	00	01	30	00	  6	  4		  0	  0	  0		  0					  0	  0								Age	                                                                                                                                                                                                                                                        X	
ZSTD_SS36-AGE	N	NUMC	  3	A0	00	A1	00	08	  6	 25		  0	  0	  0		  0					  6	  0				STU				___	X                                      00	
ZSTD_SS36-ENTRY	1	CHAR	 10	30	00	00	30	00	  7	  4		  0	  0	  0		  0					  0	  0								Entry	                                                                                                                                                                                                                                                        X	
ZSTD_SS36-ENTRY	D	DATE	 10	A0	00	A0	00	08	  7	 25		  0	  0	  0		  0					 16	  0				STU				__________	X                                      00	
ZSTD_SS36-SALARY	1	CHAR	 10	30	00	00	30	00	  8	  4		  0	  0	  0		  0					  0	  0								Salary	                                                                                                                                                                                                                                                        X	
ZSTD_SS36-SALARY	P	CURR	 13	A0	00	80	00	00	  8	 25		  0	  0	  0		  0					 10	  2		ZSTD_SS36-CURRENCY		STU				_____________	                                       00	
ZSTD_SS36-CURRENCY	C	CUKY	  5	A0	00	84	00	08	  8	 39		  0	  0	  0		  0					 10	  0				STU				_____	X                                      00	
LBL_GENDERT	0	CHAR	  6	00	00	00	30	00	  9	  4		  0	  0	  0		  0					  0	  0								Gender		
GV_GENDERT	C	CHAR	  6	80	00	80	30	00	  9	 25		  0	  0	  0		  0					  0	  0								______		
LBL_TOTAL	0	CHAR	 14	00	00	00	30	00	 10	  4		  0	  0	  0		  0					  0	  0								Total Subjects		
GV_TOTAL	I	INT4	 11	80	00	80	30	00	 10	 25		  0	  0	  0		  0					  0	  0								___________		
OK_CODE		CHAR	 20	80	10	00	00	00	255	  1	O	  0	  0	  0		  0					  0	  0								____________________		
%_FLOWLOGIC																																
PROCESS BEFORE OUTPUT.																																
 MODULE clear_ok_code.																																
 MODULE STATUS_0200.																																
 MODULE modify_screen.																																
*																																
PROCESS AFTER INPUT.																																
  MODULE exit2 AT EXIT-COMMAND.																																
																																
  FIELD zstd_ss36-salary.																																
																																
*  MODULE USER_COMMAND_0200.																																
