/* ─────────────────────────────────────────────
   SchoolStock 1차 — 초기 데이터
   실행 순서: schema.sql → sequences.sql → data.sql → data-news.sql
   ───────────────────────────────────────────── */

/* 학생 8명 — 데모용 평문 비밀번호 */
INSERT INTO students (student_id, password, name, grade, class, class_number, register_year, total_coupon, total_point)
VALUES ('kjw050101', '1234', '김진우', 5, '1', 1, 2026, 0, 30000);
INSERT INTO students (student_id, password, name, grade, class, class_number, register_year, total_coupon, total_point)
VALUES ('lsy050102', '1234', '이서연', 5, '1', 2, 2026, 0, 30000);
INSERT INTO students (student_id, password, name, grade, class, class_number, register_year, total_coupon, total_point)
VALUES ('pdy050103', '1234', '박도윤', 5, '1', 3, 2026, 0, 30000);
INSERT INTO students (student_id, password, name, grade, class, class_number, register_year, total_coupon, total_point)
VALUES ('cjw050104', '1234', '최지우', 5, '1', 4, 2026, 0, 30000);
INSERT INTO students (student_id, password, name, grade, class, class_number, register_year, total_coupon, total_point)
VALUES ('jhj050105', '1234', '정하준', 5, '1', 5, 2026, 0, 30000);
INSERT INTO students (student_id, password, name, grade, class, class_number, register_year, total_coupon, total_point)
VALUES ('ksy050106', '1234', '강서윤', 5, '1', 6, 2026, 0, 30000);
INSERT INTO students (student_id, password, name, grade, class, class_number, register_year, total_coupon, total_point)
VALUES ('jyj050107', '1234', '조예준', 5, '1', 7, 2026, 0, 30000);
INSERT INTO students (student_id, password, name, grade, class, class_number, register_year, total_coupon, total_point)
VALUES ('yjh050108', '1234', '윤지호', 5, '1', 8, 2026, 0, 30000);

/* 종목 10개 — 발행잔량 각 10주. 학생이 직접 매수해야 보유가 생긴다 */
INSERT INTO stocks (stock_no, name, content, publication_balance, publication_price, prev_price)
VALUES (1, '한빛제과', '초콜릿·과자·사탕 등 어린이 간식을 만들어 마트와 편의점에 공급하는 종합 제과 회사', 10, 800, 800);
INSERT INTO stocks (stock_no, name, content, publication_balance, publication_price, prev_price)
VALUES (2, '미소제과', '비스킷과 껌, 캐러멜을 주로 생산해 판매하는 제과 회사', 10, 1000, 1000);
INSERT INTO stocks (stock_no, name, content, publication_balance, publication_price, prev_price)
VALUES (3, '미래전자', '스마트폰과 냉장고·세탁기 같은 가전제품을 만들어 파는 전자 회사', 10, 3000, 3000);
INSERT INTO stocks (stock_no, name, content, publication_balance, publication_price, prev_price)
VALUES (4, '샛별전자', '텔레비전과 노트북·모니터를 만들어 국내외에 판매하는 전자 회사', 10, 2500, 2500);
INSERT INTO stocks (stock_no, name, content, publication_balance, publication_price, prev_price)
VALUES (5, '한별게임즈', '스마트폰으로 즐기는 모바일 게임을 개발하고 운영하는 게임 회사', 10, 1500, 1500);
INSERT INTO stocks (stock_no, name, content, publication_balance, publication_price, prev_price)
VALUES (6, '누리게임즈', 'PC와 콘솔용 게임을 개발해 판매하는 게임 회사', 10, 1200, 1200);
INSERT INTO stocks (stock_no, name, content, publication_balance, publication_price, prev_price)
VALUES (7, '튼튼자동차', '승용차와 전기차를 만들어 국내외에 수출하는 자동차 회사', 10, 2800, 2800);
INSERT INTO stocks (stock_no, name, content, publication_balance, publication_price, prev_price)
VALUES (8, '햇살에너지', '태양광 발전소를 짓고 전기를 생산해 공급하는 친환경 에너지 회사', 10, 400, 400);
INSERT INTO stocks (stock_no, name, content, publication_balance, publication_price, prev_price)
VALUES (9, '행복마트', '전국에 매장을 두고 식품과 생활용품을 파는 대형마트 회사', 10, 1000, 1000);
INSERT INTO stocks (stock_no, name, content, publication_balance, publication_price, prev_price)
VALUES (10, '하늘항공', '국내선·국제선 비행기로 승객과 화물을 실어 나르는 항공 회사', 10, 2000, 2000);

/* 쿠폰 3개 */
INSERT INTO coupons (coupon_no, name, price) VALUES (1, '매점 간식 교환권', 3000);
INSERT INTO coupons (coupon_no, name, price) VALUES (2, '숙제 면제권', 5000);
INSERT INTO coupons (coupon_no, name, price) VALUES (3, '자리 바꾸기 우선권', 4000);

COMMIT;