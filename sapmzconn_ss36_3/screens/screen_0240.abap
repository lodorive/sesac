****************************************************************																																
*   This file was generated by Direct Download Enterprise.     *																																
*   Please do not change it manually.                          *																																
****************************************************************																																
%_DYNPRO																																
SAPMZCONN_SS36_3																																
0240																																
750																																
                40																																
%_HEADER																																
SAPMZCONN_SS36_3                        0240I0240      3  8192 37  0  0 27121  0G E                              20240903111431																																
%_DESCRIPTION																																
                40																																
%_FIELDS																																
GS_DISTANCE-SHORT	C	CHAR	  1	80	00	80	30	00	  1	  2		  0	  0	  0		  0	A				  0	  0	101									
GS_DISTANCE-SHORT	0	CHAR	  5	00	00	00	30	00	  1	  4		  0	  0	  0		  0	A				  0	  0	101							Short		
GS_DISTANCE-MEDIUM	C	CHAR	  1	80	00	80	30	00	  2	  2		  0	  0	  0		  0	A				  0	  0	101									
GS_DISTANCE-MEDIUM	0	CHAR	  6	00	00	00	30	00	  2	  4		  0	  0	  0		  0	A				  0	  0	101							Medium		
GS_DISTANCE-LONG	C	CHAR	  1	80	00	80	30	00	  3	  2		  0	  0	  0		  0	A				  0	  0	101									
GS_DISTANCE-LONG	0	CHAR	  4	00	00	00	30	00	  3	  4		  0	  0	  0		  0	A				  0	  0	101							Long		
		CHAR	 20	80	10	00	00	00	255	  1	O	  0	  0	  0		  0					  0	  0								____________________		
%_FLOWLOGIC																																
PROCESS BEFORE OUTPUT.																																
* MODULE STATUS_0240.																																
  MODULE set_distance.																																
*																																
PROCESS AFTER INPUT.																																
* MODULE USER_COMMAND_0240.																																
