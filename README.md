# CODE WIKI

###### 2019 LINC+ DEU 컴퓨터공학과 캡스톤디자인-008 Team8 프로젝트 결과물


코드위키는 물품의 Bar/QR코드를 스캔하면 해당 물품에 대한 정보를

위키백과 형식으로 공유하는 웹 서비스 입니다



스마트폰의 카메라를 이용하여 Bar/QR 코드의 스캔 정보를 얻기 위한 어플리케이션과

JSP를 이용하여 웹 사이트를 제작하였습니다.



#### 기술

Application

- Java
- Android Studio(IDE)

Web

- JSP
- MySQL
- JavaScript
- Bootstrap
- IntelliJ IDEA(IDE)



#### 사용한 라이브러리

Application

- zxing(bar/QR code 리더기)

Web

- jQuery
- CKEditor4(문서 작성을 위한 에디터)



#### 서버 제원

- WAS: Raspberry Pi 3 Model B+ / Ubuntu Mate
- DB: Raspberry Pi 3 Model B+ / Raspbian



#### 기능

Application

- Bar/QR 코드 스캔
- 스캔 결과 출력(Modal)
- 어두운 곳에서도 원활한 스캔을 위한 플래시
- 스캔 결과가 URL이면 해당 사이트로 바로 이동할 수 있는 기능

Web

- Bar/QR 코드 값을 ID로 하는 문서 작성 / 조회 / 수정(위키 형식)
- 문서 정렬 조회 기능 (최근 변경 / 내용 길이)
- 사용자 인증(로그인 / 회원가입 / 마이페이지)
- 게시판 (CRUD 기능 구현)



#### 프로젝트 기간

2019.03. ~ 2019.06.
