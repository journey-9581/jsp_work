-- 사용자(회원) 정보를 저장할 테이블
CREATE TABLE users(
	id VARCHAR2(100) PRIMARY KEY,
	pwd VARCHAR2(100) NOT NULL,
	email VARCHAR2(100),
	proflie VARCHAR2(100), -- 프로필 이미지 경로를 저장할 칼럼
	regdate DATE -- 가입일
);

-- 게시글을 저장할 테이블 
CREATE TABLE board_cafe(
	num NUMBER PRIMARY KEY, -- 글 번호
	writer VARCHAR2(100) NOT NULL, -- 작성자(로그인 된 아이디)
	title VARCHAR2(100) NOT NULL, -- 제목
	content CLOB, -- 글 내용
	viewCount NUMBER, -- 조회수
	regdate DATE -- 글 작성일
);

-- 게시글의 번호를 얻어낼 시퀀스
CREATE SEQUENCE board_cafe_seq;

-- 업로드 된 파일의 정보를 저장할 테이블
CREATE TABLE board_file(
	num NUMBER PRIMARY KEY,
	writer VARCHAR2(100) NOT NULL,
	title VARCHAR2(100) NOT NULL,
	orgFile VARCHAR2(100) NOT NULL, -- 원본 파일명
	saveFile VARCHAR2(100) NOT NULL, -- 서버에 실제로 저장된 파일명
	fileSize NUMBER NOT NULL, -- 파일의 크기
	regdate DATE
)

-- 파일 번호를 얻어낼 시퀀스
CREATE SEQUENCE board_file_seq;

--
CREATE TABLE board_gallery(
	num NUMBER PRIMARY KEY,
	writer VARCHAR2(100),
	caption VARCHAR2(100),
	imagePath VARCHAR2(100), -- /upload/xxx1.jpg
	regdate DATE
);

--
CREATE SEQUENCE board_gallery_seq;