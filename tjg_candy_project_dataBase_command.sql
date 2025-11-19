SHOW DATABASES;
use candy;
show tables;

CREATE DATABASE candy CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
show variables like 'secure_file_priv';

delimiter $$
create trigger  before_insert_product
before insert on product
for each row
begin
declare max_code int;

select ifnull(max(cast(right(pid,4) as unsigned)),0) into max_code from product;

set new.pid = concat('P',lpad((max_code+1),4,'0'));
end$$
delimiter ;
DROP TRIGGER IF EXISTS before_insert_product;
desc products;
SHOW TABLES;
drop table product;


INSERT INTO PRODUCT(brand_name, dc, description, image_url, image_url_name, is_hot_deal, is_member_special, origin, price, product_date, product_description_image,
product_information_image, product_name, count, delType, allergyInfo, seller, unit, weight, notes, upk)
SELECT 
    jt.brandName,
    jt.dc,
    jt.description,
    jt.imageUrl,
    jt.imageUrl_name,
    jt.isHotDeal,
    jt.isMemberSpecial,
    jt.origin,
    jt.price,
    jt.productDate,
    jt.productDescriptionImage,
    jt.productInformationImage,
    jt.productName,
    jt.count,
    jt.delType,
    jt.allergyInfo,
    jt.seller,
    jt.unit,
    jt.weight,
    jt.notes,
    jt.upk
FROM JSON_TABLE(
    CAST(
        LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/foodData.json')
        AS CHAR CHARACTER SET utf8mb4
    ),
    '$[*]' COLUMNS (
        brandName VARCHAR(100) PATH '$.brandName',
        dc INT PATH '$.dc',
        description VARCHAR(255) PATH '$.description',
        imageUrl VARCHAR(255) PATH '$.imageUrl',
        imageUrl_name VARCHAR(100) PATH '$.imageUrl_name',
        isHotDeal BOOLEAN PATH '$.isHotDeal',
        isMemberSpecial BOOLEAN PATH '$.isMemberSpecial',
        origin VARCHAR(50) PATH '$.origin',
        price INT PATH '$.price',
        productDate VARCHAR(20) PATH '$.productDate',
        productDescriptionImage VARCHAR(255) PATH '$.productDescriptionImage',
        productInformationImage VARCHAR(255) PATH '$.productInformationImage',
        productName VARCHAR(200) PATH '$.productName',
        count int PATH '$.count',
        delType int PATH '$.delType',
        allergyInfo VARCHAR(255) PATH '$.allergyInfo',
        seller VARCHAR(255) PATH '$.seller',
        unit VARCHAR(255) PATH '$.unit',
        weight VARCHAR(255) PATH '$.weight',
        notes VARCHAR(255) PATH '$.notes',
        upk bigint PATH '$.upk'
    )
) AS jt;

desc product;


select * from users;
select * from product;
show tables;


desc orders;
INSERT INTO orders ( ppk, order_date, qty, upk)
SELECT 
  jt.ppk,
  jt.order_date,
  jt.qty,
  jt.upk
FROM JSON_TABLE(
  CAST(
    LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/purchase.json')
    AS CHAR CHARACTER SET utf8mb4
  ),
  '$[*]'
  COLUMNS (
    ppk VARCHAR(10) PATH '$.ppk',
    qty INT PATH '$.qty',
    order_date DATETIME PATH '$.order_date',
    upk INT PATH '$.upk'
  )
) AS jt;




delete from product;
select * from product;
select * from users;
select * from orders;
select * from orders o, product p where o.pid = p.pid;

ALTER TABLE orders DROP FOREIGN KEY fk_orders_product;

INSERT INTO users (
  address,
  birthday,
  email,
  gender,
  name,
  password,
  phone,
  provider,
  recommendation,
  user_id
)
SELECT
  jt.address,
  jt.birthday,
  jt.email,
  jt.gender,
  jt.name,
  jt.password,
  jt.phone,
  jt.provider,
  jt.recommendation,
  jt.user_id
FROM JSON_TABLE(
  CAST(
    LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.json')
    AS CHAR CHARACTER SET utf8mb4
  ),
  '$[*]'
  COLUMNS (
    id INT PATH '$.id',
    address VARCHAR(255) PATH '$.address',
    birthday DATE PATH '$.birthday',
    email VARCHAR(100) PATH '$.email',
    gender CHAR(1) PATH '$.gender',
    name VARCHAR(100) PATH '$.name',
    password VARCHAR(255) PATH '$.password',
    phone VARCHAR(30) PATH '$.phone',
    provider VARCHAR(50) PATH '$.provider',
    recommendation VARCHAR(100) PATH '$.recommendation',
    user_id VARCHAR(50) PATH '$.user_id'
  )
) AS jt;


SHOW CREATE TABLE orders;
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where table_schema = 'candy';
ALTER TABLE orders DROP FOREIGN KEY fk_orders_products;
ALTER TABLE product_qna DROP FOREIGN KEY fk_product_qna_products;
ALTER TABLE reviews DROP FOREIGN KEY fk_reviews_products;
ALTER TABLE products DROP FOREIGN KEY fk_orders_products;
DROP TABLE product;
DROP TABLE orders;
DROP TABLE product_qna;
DROP TABLE reviews;
show tables;
select * from users;
select * from orders;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_user
FOREIGN KEY (upk) 
REFERENCES users(id) 
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_product
FOREIGN KEY (ppk)
REFERENCES product(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

show tables;
ALTER TABLE orders DROP COLUMN user_id;
select * from product;
select * from reviews;
ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_users
FOREIGN KEY (upk)
REFERENCES users(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_product
FOREIGN KEY (ppk)
REFERENCES product(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE product_qna
ADD CONSTRAINT fk_product_qna_product
FOREIGN KEY (ppk)
REFERENCES product(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE product_qna
ADD CONSTRAINT fk_product_qna_users
FOREIGN KEY (upk)
REFERENCES users(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

show tables;
desc reviews;
INSERT INTO reviews (
  ppk,
  product_name,
  title,
  content,
  date,
  is_best,
  likes,
  images,
  tags,
  upk
)
SELECT
  jt.ppk,
  jt.product_name,
  jt.title,
  jt.content,
  jt.date,
  jt.is_best,
  jt.likes,
  jt.images,
  jt.tags,
  jt.upk
FROM JSON_TABLE(
  CAST(
    LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/reviews.json')
    AS CHAR CHARACTER SET utf8mb4
  ),
  '$.reviews[*]'
  COLUMNS (
    id INT PATH '$.id',
    ppk INT PATH '$.ppk',
    product_name VARCHAR(255) PATH '$.productName',
    title VARCHAR(255) PATH '$.title',
    content TEXT PATH '$.content',
    date VARCHAR(20) PATH '$.date',
    is_best BOOLEAN PATH '$.isBest',
    likes INT PATH '$.likes',
    images JSON PATH '$.images',
    tags JSON PATH '$.tags',
    upk Int PATH '$.upk'
  )
) AS jt;
delete from review;
select * from reviews;
select * from orders;
select * from product_qna;

desc product_qna;
INSERT INTO product_qna (
  ppk,
  title,
  date,
  status,
  is_private,
  upk
)
SELECT
  jt.ppk,
  jt.title,
  jt.date,
  jt.status,
  jt.is_private,
  jt.upk
FROM JSON_TABLE(
  CAST(
    LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/productQnA.json')
    AS CHAR CHARACTER SET utf8mb4
  ),
  '$.qnaList[*]'
  COLUMNS (
    id INT PATH '$.id',
    ppk INT PATH '$.ppk',
    title VARCHAR(255) PATH '$.title',
    date VARCHAR(20) PATH '$.date',
    status VARCHAR(50) PATH '$.status',
    is_private BOOLEAN PATH '$.isPrivate',
    upk INT PATH '$.upk'
  )
) AS jt;
show tables;
desc reviews;
desc product;
select * from product;
select * from orders;
select * from reviews;
desc users;
desc product_qna;
select r.id, r.content, r.date, r.images, r.is_best, r.likes, r.ppk, r.product_name, r.tags, r.title, r.upk, u.name from reviews r, users u where r.upk = u.id;
select pq.id,  pq.date, pq.is_private, pq.ppk, pq.status, pq.title, pq.upk, u.name as writer from  product_qna pq, users u where pq.upk = u.id;
select p.id,o.qty, p.brand_name, p.dc, p.description, p.image_url, p.image_url_name, p.is_hot_deal, p.is_member_special, p.origin, p.pid, p.price, p.product_date, p.product_description_image, p.product_information_image, p.product_name  from orders o, product p where o.ppk = p.id;
 SELECT 
        p.id AS id,
        p.brand_name AS brandName,
        p.dc AS dc,
        p.description AS description,
        p.image_url AS imageUrl,
        p.image_url_name AS imageUrlName,
        p.is_hot_deal AS isHotDeal,
        p.is_member_special AS isMemberSpecial,
        p.origin AS origin,
        p.pid AS pid,
        p.price AS price,
        p.product_date AS productDate,
        p.product_description_image AS productDescriptionImage,
        p.product_information_image AS productInformationImage,
        p.product_name AS productName
    FROM orders o
    JOIN product p ON o.ppk = p.id
    GROUP BY p.id
    ORDER BY SUM(o.qty) DESC
    LIMIT 10;

SELECT
                        p.id AS id,
                        p.brand_name AS brandName,
                        p.dc AS dc,
                        p.description AS description,
                        p.image_url AS imageUrl,
                        p.image_url_name AS imageUrlName,
                        p.is_hot_deal AS isHotDeal,
                        p.is_member_special AS isMemberSpecial,
                        p.origin AS origin,
                        p.pid AS pid,
                        p.price AS price,
                        p.product_date AS productDate,
                        p.product_description_image AS productDescriptionImage,
                        p.product_information_image AS productInformationImage,
                        p.product_name AS productName
                    FROM orders o
                    JOIN product p ON o.ppk = p.id
                    GROUP BY p.id
                    ORDER BY SUM(o.qty) DESC
                    LIMIT 10;
                    
                    
show tables;
desc notice;




select * from notice; 
INSERT INTO notice (
  title,
  content,
  writer,
  is_pinned,
  created_at
)
SELECT
  jt.title,
  jt.content,
  jt.writer,
  jt.isPinned,
  jt.createdAt
FROM JSON_TABLE(
  CAST(
    LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/notices.json')
    AS CHAR CHARACTER SET utf8mb4
  ),
  '$.noticeList[*]'
  COLUMNS (
    id INT PATH '$.id',
    title VARCHAR(255) PATH '$.title',
    content TEXT PATH '$.content',
    writer VARCHAR(100) PATH '$.writer',
    isPinned BOOLEAN PATH '$.isPinned',
    createdAt DATETIME PATH '$.createdAt'
  )
) AS jt;

INSERT INTO notice (title, content, writer, is_pinned, created_at) VALUES
('회원 등급제 변경 안내', '2025년 11월 1일부터 신규 회원 등급제가 시행됩니다. 등급별 혜택은 마이페이지에서 확인 가능합니다.', '운영팀', 1, '2025-10-25 09:00:00'),
('리뷰 작성 이벤트 당첨자 발표', '리뷰 이벤트에 참여해주신 고객님께 감사드립니다. 당첨자는 공지사항을 통해 확인해주세요.', '마케팅팀', 0, '2025-10-23 13:45:00'),
('정기점검 안내 (11월 2일)', '시스템 안정화를 위한 정기 점검이 11월 2일 02:00~05:00 진행됩니다. 서비스 이용에 참고 바랍니다.', '개발팀', 1, '2025-10-22 11:00:00'),
('배송비 정책 개편 안내', '무료배송 기준 금액이 40,000원으로 변경됩니다. 자세한 내용은 고객센터에서 확인해주세요.', '운영팀', 0, '2025-10-21 08:30:00'),
('카카오 간편결제 오류 복구 완료', '일시적으로 발생한 카카오페이 결제 오류가 복구되었습니다. 불편을 드려 죄송합니다.', '개발팀', 0, '2025-10-19 17:20:00'),
('고객센터 상담 지연 안내', '현재 상담 문의가 많아 답변이 지연되고 있습니다. 빠른 시일 내에 처리하겠습니다.', '고객센터', 0, '2025-10-17 15:10:00'),
('신규 브랜드 입점 안내', '인기 브랜드 "FreshDay"가 새로 입점했습니다! 다양한 상품을 만나보세요.', 'MD팀', 0, '2025-10-14 09:00:00'),
('추석 명절 선물세트 예약 오픈', '추석 선물세트 사전 예약이 시작되었습니다. 조기 품절 주의!', '마케팅팀', 0, '2025-09-28 10:00:00'),
('상품 리뷰 작성 시 포인트 적립', '상품 리뷰를 작성하면 500포인트를 드립니다. (텍스트 기준)', '운영팀', 0, '2025-09-22 14:30:00'),
('모바일 앱 업데이트 안내', '새로운 버전(v2.3.1) 앱이 출시되었습니다. 최신 기능을 이용해보세요.', '개발팀', 0, '2025-09-20 12:15:00'),
('환경 보호 캠페인 참여 안내', '플라스틱 줄이기 캠페인에 함께해주세요. 자세한 내용은 이벤트 페이지를 확인하세요.', '마케팅팀', 0, '2025-09-18 11:45:00'),
('주문 폭주로 인한 배송 지연 안내', '주문량 증가로 인해 일부 상품 배송이 지연될 수 있습니다. 양해 부탁드립니다.', '물류팀', 0, '2025-09-15 18:00:00'),
('서버 점검 완료 안내', '예정된 서버 점검이 정상적으로 완료되었습니다. 서비스 이용에 감사드립니다.', '개발팀', 0, '2025-09-14 05:30:00'),
('개인정보 처리방침 개정 안내', '2025년 10월 1일부터 새로운 개인정보 처리방침이 적용됩니다.', '법무팀', 1, '2025-09-10 09:00:00'),
('리워드 적립률 변경 안내', '2025년 11월부터 일부 카테고리의 리워드 적립률이 변경됩니다.', '운영팀', 0, '2025-09-08 13:00:00'),
('회원가입 오류 수정 완료', '일부 환경에서 회원가입이 불가능하던 오류가 수정되었습니다.', '개발팀', 0, '2025-09-06 10:20:00'),
('고객 후기 이벤트 개최', '상품 후기를 작성하시면 추첨을 통해 사은품을 드립니다. 많은 참여 바랍니다.', '마케팅팀', 0, '2025-09-01 16:00:00'),
('CS 운영시간 단축 안내 (주말)', '주말 고객센터 운영시간이 10:00~16:00으로 변경됩니다.', '고객센터', 0, '2025-08-28 08:00:00'),
('시스템 장애 복구 완료', '일부 결제 오류 문제가 조치 완료되었습니다. 이용에 감사드립니다.', '개발팀', 0, '2025-08-25 15:30:00'),
('상품 교환/반품 절차 변경 안내', '상품 교환 및 반품 절차가 간소화되었습니다. 마이페이지에서 간편하게 신청하세요.', '운영팀', 0, '2025-08-20 11:00:00');

DROP TABLE IF EXISTS order_detail;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS cart;

show tables;
select * from orders;
select * from order_detail;
select * from product;
select * from users;
select * from cart;
desc cart;
INSERT INTO cart ( added_at, qty, ppk, upk) VALUES("2025-10-10", 2, 2,1);
select * from delivery;

-- delivery 테이블 생성ppkadded_at
CREATE TABLE delivery (
    del_type int PRIMARY KEY,       -- 배송 타입 코드
    del_name VARCHAR(50) NOT NULL,          -- 배송명
    del_description TEXT NOT NULL           -- 배송 설명
);
-- deliverey 데이터
INSERT INTO delivery(del_type, del_name, del_description) VALUES
(1, '샛별배송', '23시 전 주문 시 수도권/충청 내일 아침 7시 전 도착\n그 외 지역 아침 8시 전 도착'),
(2, '일반배송', '주문일로부터 2~3일 내 도착');

-- product테이블 foreign key 설정 ( delivery테이블의 del_type )
ALTER TABLE product
ADD CONSTRAINT fk_product_del_type
FOREIGN KEY (del_type)
REFERENCES delivery(del_type);
select * from product;

update product set del_type = 1 ;
-- product detail용 view
-- 20251113 이승수 view_product_detail 업데이트
create view view_product_detail
as 
SELECT p.*, d.del_name, d.del_description, cm.id as category_main_id
FROM product p, delivery d, category_main cm, category_sub cs
WHERE p.del_type = d.del_type
AND cm.id = cs.main_id
AND cs.id = p.category_sub_id;

select * from product;
select * from category_sub;

select * from view_product_detail;

select * from product;
desc product;

create table product_recipe(
	id 		int		auto_increment primary key,
    description	text,
    added_at	timestamp
);
desc cart;

select * from reviews;

update reviews set images = "[""/images/reviewImages/review1.png"", ""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png"",""/images/reviewImages/review2.png""]"
where id = 1;

-- 20251106 이승수 추가 : product의 upk 항목 추가로 인한 설정.(users id를 외래키로 사용)
update product set upk = 1;

-- 20251113 이승수 추가 : category_main, category_sub 테이블 생성 및 데이터
-- 20251113 이승수 view_product_detail 업데이트
set sql_safe_updates = 0;
drop view view_product_detail;
create view view_product_detail
as 
SELECT p.*, d.del_name, d.del_description, cm.id as category_main_id
FROM product p, delivery d, category_main cm, category_sub cs
WHERE p.del_type = d.del_type
AND cm.id = cs.main_id
AND cs.id = p.category_sub_id;

select * from product;
update product set category_sub_id = 20 ;
-- 대분류
INSERT INTO category_main (name, display_order, is_used) VALUES
('신선식품', 1, true),('가공식품', 2, true),('간편식/즉석식품', 3, true),('음료/유제품', 4, true),('과자/베이커리', 5, true),('건강식품', 6, true),('주류/전통주', 7, true);

update category_main set name = "간편식/즉석식품" where id =3;
select * from category_main;

-- 중분류
INSERT INTO category_sub (main_id, name, display_order, is_used) VALUES
-- 신선식품 1~5
(1, '정육', 1, true),(1, '수산물', 2, true),(1, '과일', 3, true),(1, '채소', 4, true),(1, '계란', 5, true),
-- 가공식품 6~9
(2, '라면/면류', 1, true),(2, '통조림/즉석조리', 2, true),(2, '조미료/양념', 3, true),(2, '소스/드레싱', 4, true),
-- 간편식/즉석식품 10~13
(3, '냉동식품', 1, true),(3, '도시락/볶음밥', 2, true),(3, '국/탕/찌개', 3, true),(3, '죽/스프', 4, true),
-- 음료/유제품 14~18
(4, '생수/탄산수', 1, true),(4, '커피/차', 2, true),(4, '주스/에이드', 3, true),(4, '우유/요거트', 4, true),(4, '치즈/버터', 5, true),
-- 과자/베이커리 19~22
(5, '스낵/쿠키', 1, true),(5, '초콜릿/젤리', 2, true),(5, '빵/케이크', 3, true),(5, '베이킹재료', 4, true),
-- 건강식품 23~25
(6, '견과류', 1, true),(6, '건과일', 2, true),(6, '홍삼/인삼', 3, true),(6, '비타민/영양제', 4, true),
-- 주류/전통주 27~30
(7, '맥주', 1, true),(7, '와인', 2, true),(7, '소주/증류주', 3, true),(7, '전통주', 4, true);

UPDATE product SET category_sub_id = 10 WHERE id = 1;
UPDATE product SET category_sub_id = 1 WHERE id = 2;
UPDATE product SET category_sub_id = 9 WHERE id = 3;
UPDATE product SET category_sub_id = 19 WHERE id = 4;
UPDATE product SET category_sub_id = 13 WHERE id = 5;
UPDATE product SET category_sub_id = 10 WHERE id = 6;
UPDATE product SET category_sub_id = 17 WHERE id = 7;
UPDATE product SET category_sub_id = 3 WHERE id = 8;
UPDATE product SET category_sub_id = 17 WHERE id = 9;
UPDATE product SET category_sub_id = 6 WHERE id = 10;
UPDATE product SET category_sub_id = 1 WHERE id = 11;
UPDATE product SET category_sub_id = 17 WHERE id = 12;
UPDATE product SET category_sub_id = 8 WHERE id = 13;
UPDATE product SET category_sub_id = 21 WHERE id = 14;
UPDATE product SET category_sub_id = 4 WHERE id = 15;
UPDATE product SET category_sub_id = 5 WHERE id = 16;
UPDATE product SET category_sub_id = 15 WHERE id = 17;
UPDATE product SET category_sub_id = 4 WHERE id = 18;
UPDATE product SET category_sub_id = 14 WHERE id = 19;
UPDATE product SET category_sub_id = 17 WHERE id = 20;

-- 20251119 이승수 추가 cart테이블 foregin key 설정
-- product테이블에서 상품이 지워졌을경우 cart테이블에서 삭제
ALTER TABLE cart
DROP FOREIGN KEY FKi5rep9miokyv1vywdoq4lepid; -- jpa에서 자동으로 만들어준 foreign key

ALTER TABLE cart
ADD CONSTRAINT fk_cart_ppk
FOREIGN KEY (ppk) REFERENCES product(id)
ON DELETE CASCADE
ON UPDATE CASCADE;
