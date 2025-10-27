
SHOW DATABASES;
use candy;
show tables;
desc product;
    
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
        productName VARCHAR(200) PATH '$.productName'
    )
) AS jt;

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



SET SQL_SAFE_UPDATES = 0;
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







INSERT INTO notice (
  content,
  is_pinned,
  title,
  writer
)
SELECT
  jt.content,
  jt.is_pinned,
  jt.title,
  jt.writer
FROM JSON_TABLE(
  CAST(
    LOAD_FILE('C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/notice.json')
    AS CHAR CHARACTER SET utf8mb4
  ),
  '$.qnaList[*]'
  COLUMNS (
    content VARCHAR(300) PATH '$.content',
    is_pinned INT PATH '$.is',
    title  PATH '$.title',
    date VARCHAR(20) PATH '$.date',
    status VARCHAR(50) PATH '$.status',
    is_private BOOLEAN PATH '$.isPrivate',
    upk INT PATH '$.upk'
  )
) AS jt;