****************************************************************																																
*   This file was generated by Direct Download Enterprise.     *																																
*   Please do not change it manually.                          *																																
****************************************************************																																
%_DYNPRO																																
ZALV_SS36																																
0100																																
750																																
                40																																
%_HEADER																																
ZALV_SS36                               0100 0100     26119192 37  0  0 27121  0G E                              20240910110258																																
%_DESCRIPTION																																
                40																																
%_FIELDS																																
CONTROL_AREA			119	00	30	00	30	00	  2	  2		  0	  0	  0		 25	U				 12	 59	101									
OK_CODE		CHAR	 20	80	10	00	00	00	255	  1	O	  0	  0	  0		  0					  0	  0								____________________	                                       00	
%_FLOWLOGIC																																
PROCESS BEFORE OUTPUT.																																
 MODULE clear_ok_code.																																
 MODULE STATUS_0100.																																
 MODULE init_control_processing.																																
*																																
PROCESS AFTER INPUT.																																
 MODULE USER_COMMAND_0100.																																
