*&---------------------------------------------------------------------*
*& Report ZBC100_FIRST_PROGRAM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZBC100_FIRST_PROGRAM_2.

PARAMETERS p_name TYPE string. "화면에 사용자의 이름을 입력 받음.
PARAMETERS p_age TYPE i. "화면에 사용자의 나이를 입력 받음.

WRITE 'Hello'.
NEW-LINE.
WRITE p_name. "사용자가 입력한 값을 출력.
WRITE: p_name, 'is', p_age, 'years old'. "화면에 이름과 나이 + 고정 문자열 출력.

*WRITE: 'Hello', NEW_LINE, p_name. "에러발생.
*WRITE: 'Hello', /, p_name. "WRITE 문에서 NEW-LINE과 같음.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
