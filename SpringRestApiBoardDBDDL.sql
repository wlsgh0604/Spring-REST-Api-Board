-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        12.0.2-MariaDB - mariadb.org binary distribution
-- 서버 OS:                        Win64
-- HeidiSQL 버전:                  12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- board_table 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `board_table` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `board_table`;

-- 테이블 board_table.board 구조 내보내기
CREATE TABLE IF NOT EXISTS `board` (
  `no` int(11) NOT NULL AUTO_INCREMENT COMMENT '글번호',
  `subject` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL COMMENT '회원인경우에는 비어있음',
  `contents` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hit` int(11) DEFAULT 0,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `member_no` int(11) DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  `regist_time` datetime DEFAULT current_timestamp(),
  `regist_id` int(11) DEFAULT NULL,
  `update_time` datetime DEFAULT current_timestamp(),
  `update_id` int(11) DEFAULT NULL,
  `hidden` int(11) DEFAULT 0 COMMENT '삭제시 숨김처리, 관리자 삭제, 사용자 삭제 등 구분용',
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=1045 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 프로시저 board_table.insert_loop 구조 내보내기
DELIMITER //
CREATE PROCEDURE `insert_loop`()
BEGIN
  DECLARE i INT DEFAULT 1;

  WHILE i <= 1000 DO
    INSERT INTO board (subject, password, contents, nickname)
    VALUES (
      CONCAT(i, '번째 게시물입니다'),
      i,
      CONCAT(i, '번째 게시물 내용입니다'),
      i
    );
    SET i = i + 1;
  END WHILE;
END//
DELIMITER ;

-- 테이블 board_table.member 구조 내보내기
CREATE TABLE IF NOT EXISTS `member` (
  `member_no` int(11) NOT NULL DEFAULT 0,
  `nickname` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`member_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 board_table.member_info 구조 내보내기
CREATE TABLE IF NOT EXISTS `member_info` (
  `mno` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `login_faild` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `ban_time` datetime DEFAULT NULL,
  `regist_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`mno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 board_table.reply 구조 내보내기
CREATE TABLE IF NOT EXISTS `reply` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `board_no` int(11) DEFAULT NULL,
  `contents` text DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  `groupId` int(11) DEFAULT NULL,
  `order_no` int(11) DEFAULT NULL,
  `nickname` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `reg_date` datetime DEFAULT current_timestamp(),
  `hidden` int(11) DEFAULT 0,
  `del_date` datetime DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
