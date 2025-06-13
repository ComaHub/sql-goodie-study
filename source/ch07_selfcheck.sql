-- 셀프체크
-- 별그램 DB를 보고 다음 1~3을 수행하는 쿼리를 작성하세요.
-- (ch06_07_selfcheck.png 참고)

-- 1 사용자가 자신의 계정을 공개하는지 여부를 다음과 같이 조회하세요.
-- ------------------------
-- 닉네임      | 계정 공개 여부
-- ------------------------
SELECT U.nickname "닉네임", S.private "계정 공개 여부" FROM users U
INNER JOIN settings S ON U.id = S.user_id;

-- 2 누가 올렸는지 확인할 수 있는 사진에 대해서만 사진 파일명과 올린 사람을 다음과 같이 조회하세요.
-- ------------------------
-- 파일명      | 게시자
-- ------------------------
SELECT P.file_name "파일명", U.nickname "게시자" FROM photos P
INNER JOIN users U ON P.user_id = U.id;

-- 3 모든 사진에 대해 사진 파일명과 올린 사람을 다음과 같이 조회하세요.(올린 사람이 누구인지 모르는 사진도 조회합니다.)
-- ------------------------
-- 파일명      | 게시자
-- ------------------------
SELECT P.file_name "파일명", U.nickname "게시자" FROM photos P
LEFT OUTER JOIN users U ON P.user_id = U.id;

