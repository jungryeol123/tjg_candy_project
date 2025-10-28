-- sql실행전 candy 서버를 기동 시키고 할것!!!!!!
SHOW DATABASES; -- 데이터 베이스 확인
use candy; -- candy 데이터 베이스 사용
show tables; -- 테이블 확인
desc product; -- product 테이블 구조 확인

select * from product;
select * from users;
select * from orders;
select * from reviews;

-- sql 변경시 설정
SET SQL_SAFE_UPDATES = 0;

-- candy라는 이름의 데이터 베이스가 없을 경우 실행
CREATE DATABASE candy CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
show variables like 'secure_file_priv';

-- product 테이블에 Pid 설정 트리거(P0001)
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

-- 트리거 삭제 명령어(존재할경우 삭제)
DROP TRIGGER IF EXISTS before_insert_product;

-- product 테이블에 데이터 insert ( json파일을 꼭 경로에 넣고 실행할것!)
desc product; -- 테이블 확인용
INSERT INTO product(brand_name, dc, description, image_url, image_url_name, is_hot_deal, is_member_special, origin, price, product_date, product_description_image,
product_information_image, product_name)
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
    jt.productName
FROM JSON_TABLE(
    CAST(
        LOAD_FILE('C://ProgramData//MySQL//MySQL Server 8.0//Uploads//foodData.json')
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
        productName VARCHAR(200) PATH '$.productName'
    )
) AS jt;

-- orders 테이블에 데이터 insert ( json파일을 꼭 경로에 넣고 실행할것!)
desc orders; -- 테이블 확인용
INSERT INTO orders ( ppk, order_date, qty, upk)
SELECT 
  jt.ppk,
  jt.order_date,
  jt.qty,
  jt.upk
FROM JSON_TABLE(
  CAST(
    LOAD_FILE('C://ProgramData//MySQL//MySQL Server 8.0//Uploads//purchase.json')
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

-- users 테이블에 데이터 insert ( json파일을 꼭 경로에 넣고 실행할것!)
desc users; -- 테이블 확인용
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
    LOAD_FILE('C://ProgramData//MySQL//MySQL Server 8.0//Uploads//users.json')
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

-- reviews 테이블에 데이터 insert ( json파일을 꼭 경로에 넣고 실행할것! )
desc reviews; -- 테이블 확인용
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
    LOAD_FILE('C://ProgramData//MySQL//MySQL Server 8.0//Uploads//reviews.json')
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

-- product_qna 테이블에 데이터 insert ( json파일을 꼭 경로에 넣고 실행할것! )
desc product_qna; -- 테이블 확인용
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
                
desc notice;

-- notice 테이블에 데이터 insert ( json파일을 꼭 경로에 넣고 실행할것! )
desc notice; -- 테이블 확인용
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
    LOAD_FILE('C://ProgramData//MySQL//MySQL Server 8.0//Uploads//notices.json')
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

-- foreign key 설정 가장 마지막에 할것.
-- 테이블 확인
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS where table_schema = 'candy';
-- FOREIGN KEY 해제 ( 삭제전에 해둬야 다른 테이블 지울때 에러가 안남)
-- FOREIGN KEY를 설정 안했다면 패스
ALTER TABLE orders DROP FOREIGN KEY fk_orders_product;
ALTER TABLE orders DROP FOREIGN KEY fk_orders_user;
ALTER TABLE product_qna DROP FOREIGN KEY fk_product_qna_product;
ALTER TABLE product_qna DROP FOREIGN KEY fk_product_qna_users;
ALTER TABLE reviews DROP FOREIGN KEY fk_reviews_product;
ALTER TABLE reviews DROP FOREIGN KEY fk_reviews_users;

-- orders테이블 foreign key 설정 ( users테이블의 id )
ALTER TABLE orders
ADD CONSTRAINT fk_orders_user
FOREIGN KEY (upk) 
REFERENCES users(id) 
ON UPDATE CASCADE
ON DELETE CASCADE;

-- orders테이블 foreign key 설정( product테이블의 id )
ALTER TABLE orders
ADD CONSTRAINT fk_orders_product
FOREIGN KEY (ppk)
REFERENCES product(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- reviews foreign key 설정 ( users테이블의 id )
ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_users
FOREIGN KEY (upk)
REFERENCES users(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- reviews테이블 foreign key 설정( product테이블의 id )
ALTER TABLE reviews
ADD CONSTRAINT fk_reviews_product
FOREIGN KEY (ppk)
REFERENCES product(id)
ON UPDATE CASCADE
ON DELETE CASCADE;


-- product_qna테이블 foreign key 설정( product테이블의 id )
ALTER TABLE product_qna
ADD CONSTRAINT fk_product_qna_product
FOREIGN KEY (ppk)
REFERENCES product(id)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- product_qna테이블 foreign key 설정( users테이블의 id )
ALTER TABLE product_qna
ADD CONSTRAINT fk_product_qna_users
FOREIGN KEY (upk)
REFERENCES users(id)
ON UPDATE CASCADE
ON DELETE CASCADE;












