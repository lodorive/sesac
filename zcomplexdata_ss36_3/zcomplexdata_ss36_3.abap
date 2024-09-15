*&---------------------------------------------------------------------*
*& Report ZCOMPLEXDATA_SS36_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcomplexdata_ss36_3.

* Local Structured Type 정의
TYPES: BEGIN OF ts_student,
         id      TYPE n LENGTH 8,
         name    TYPE c LENGTH 32,
         address TYPE c LENGTH 128,
         age     TYPE n LENGTH 3,
       END OF ts_student.

* Local Table Type 정의
TYPES: tt_student TYPE STANDARD TABLE OF ts_student
                  WITH NON-UNIQUE KEY id.

* Internal Table 정의 with Table Type
DATA gt_student TYPE tt_student. "여러 학생을 담을 수 있는 변수

* Work Area (Structure Variable)
*DATA gw_student TYPE ts_student. "1안

* Table Type으로 만들면 무조건 Internal Table
*DATA gw_student TYPE LINE OF tt_student. "2안

* Work Area
DATA gw_student LIKE LINE OF gt_student. "3안

* Internal Table에 1/홍길동/서울/24 를 삽입
CLEAR gw_student. "쓰레기값 방지
gw_student-id = 1.
gw_student-name = '홍길동'.
gw_student-address = '서울'.
gw_student-age = 24.
APPEND gw_student TO gt_student.

* Internal Table에 3/김미리/?/21 삽입
CLEAR gw_student. "쓰레기값 방지
gw_student-id = 3.
gw_student-name = '김미리'.
*gw_student-address = '서울'.
gw_student-age = 21.
APPEND gw_student TO gt_student.

CLEAR gw_student. "쓰레기값 방지
gw_student-id = 5.
gw_student-name = '장그레'.
gw_student-address = '부산'.
gw_student-age = 28.
APPEND gw_student TO gt_student.

* Intetnal Table에서 데이터 읽기
* 1) Index 접근 (행으로 접근)
READ TABLE gt_student INTO gw_student INDEX 2.
IF sy-subrc = 0. "잘 읽었으면(INDEX 2번이 있다면)
*  WRITE:/ gw_student-name.
ENDIF.

* 2) Key 접근
READ TABLE gt_student INTO gw_student
                      WITH KEY address = '부산'.
IF sy-subrc = 0. "잘 읽었으면(address = '부산'이 있다면)
*  WRITE:/ gw_student-name.
ENDIF.

CLEAR gw_student. "쓰레기값 방지
gw_student-id = 7.
gw_student-name = '장그레'.
gw_student-address = '인천'.
gw_student-age = 27.
APPEND gw_student TO gt_student.

* 3) 이름이 '장그레'이면서 나이가 27세인 친구 찾기
READ TABLE gt_student INTO gw_student
                      WITH KEY name = '장그레'
                               age = 27.
IF sy-subrc = 0.
*  WRITE:/ gw_student-address.
ENDIF.

* 4) sy-subrc 체크를 안 한 경우 -> 쓰레기 값 생길 수 있음
* 방지 하기 위해서 CLEAR와 sy-subrc 사용을 필수로 해주면 좋다
CLEAR gw_student.
READ TABLE gt_student INTO gw_student
                      WITH KEY address = '서울'
                               age = 50.
IF sy-subrc = 0.
*WRITE:/ gw_student-address.
ENDIF.

* 주소가 비워져 있는 김미리의 주소를 대전으로 설정
* 1) 김미리를 읽어야 함
READ TABLE gt_student INTO gw_student INDEX 2.
IF sy-subrc = 0. "값이 있다면
  gw_student-age = 22.
  gw_student-address = '대전'.
  " gw_student에 id를 가지고 있는 값을 찾아서
  " 해당 라인의 주소를 대전으로 설정
  " 이유 : id가 Internal Table의 Key이기 때문에
  MODIFY TABLE gt_student FROM gw_student.
ENDIF.

* Internal Table에 현재 4명의 학생 존재
* 1) Index 삭제(0 ~ 1개)
*DELETE gt_student INDEX 3.

* 2) Key 삭제(0 ~ n개) --- AND OR 사용 가능
*DELETE gt_student WHERE address = '서울'.

* 모든 학생의 주소를 서울로 변경하고자 함 (= Internal table Loop 필요)
LOOP AT gt_student INTO gw_student.

  gw_student-address = '서울'.
  MODIFY gt_student FROM gw_student.

ENDLOOP.

* 나이가 25살 이상인 학생의 주소를 서울로 모두 변경하고자 함 (Loop + WHERE)
LOOP AT gt_student INTO gw_student WHERE age > 25.

  gw_student-address = '서울'.
  MODIFY gt_student FROM gw_student.

ENDLOOP.

* 나이가 많은 순서대로 정렬(SORT)
SORT gt_student BY age DESCENDING.

* 주소로 먼저 정렬 후 나이로 정렬
*SORT gt_student BY address age.

* Internal Table의 전체 내용을 출력
LOOP AT gt_student INTO gw_student. "WHERE age > 25
  WRITE:/ sy-tabix,
          gw_student-id, gw_student-name+0(10),
          gw_student-address+0(15), gw_student-age.
ENDLOOP.

* Intetnal Table 내용을 확인하고 싶을 때 사용 툴
*CALL METHOD cl_demo_output=>display_data
*  EXPORTING
*    value = gt_student.

----------------------------------------------------------------------------------
Extracted by Mass Download version 1.5.5 - E.G.Mellodew. 1998-2024. Sap Release 750
