USE shop;

SELECT * FROM buy;

--대단위 데이터 csv 파일을 해당 테이블에 import 하기
LOAD DATA LOCAL INFILE 'buy.csv' INTO TABLE but FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

-- 테이블 목록 보기
SHOW TABLES;

-- sql 파일 실행하여 sql 명령을 실행하기(터미널에서 실행하기)
SOURCE test2.sql;


customer cus NEW customer();
cus.setCustomerid(request.getParameter("customerid"));
cus.setCustomername(request.getParameter("customername"));
cus.setCustomertype(request.getParameter("customertype"));
cus.setCountry(request.getParameter("contry"));
cus.setCity(request.getParameter("city"));
cus.setState(request.getParameter("state"));
cus.setPostcode(Integer.request.getParameter("postcode"));
cus.setRegiontype(request.getParameter("Regiontype"));


-- 고객등록
INSERT INTO customer VALUES('AK-10880', 'Alien Kim', 'Consumer', 'South Korea', 'Seoul', 'Seoul', 18517, 'West');



-- 테이블 확인 가능
DESC customer;

-- 웹에서 고객 등록
public void cusInsert(customer cus){
	INSERT INTO customer VALUES(?, ?, ?, ?, ?, ?, ?, ?);
	pstmt.setString(1, cus.getCustomerid());
	pstmt.setString(2, cus.getCustomername());
	pstmt.setString(3, cus.getCustomertype());
	pstmt.setString(4, cus.getCountry());
	pstmt.setString(5, cus.getCity());
	pstmt.setString(6, cus.getState());
	pstmt.setInt(7, cus.getPostcode());
	pstmt.setInt(8, cus.getRegiontype());
}
	
-- 이걸 가지고 클래스를 만듦.


웹에서 고객정보(데이터) 변경
UPDATE customer SET sountry=?, city=?, state-?, WHERE customerid=?;
pstmt.setString(1, cus.getCountry());
pstmt.setString(2, cus.getCity());
pstmt.setString(3, cus.getState());
pstmt.setStrinh(4, cus.getCoustomerid());

-- 웹에서 고객 삭제
DELETE FROM customer 

-- 고객정보 변경
UPDATE customer SET country='America', city='Los Angels', State='Los Angels' 
WHERE customerid='AK-10880';

COMMIT;

SELECT * FROM customer WHERE customername LIKE '%Kim%' AND city='Seoul';




-- 해당 데이터를 csv로 export 하기
-- 해당 테이블 먼저 검색(select)
SELECT * FROM product;
-- 검색 결과에서 전체 선택한 후 마우스 오른쪽 [격자 행 내보내기]
-- 출력형식 Excel CSV 선택하고, 해당 파일의 이름과 경로를 지정
-- 내보내기

-- 테이블 삭제
DROP TABLE customer;

USE shop;
SHOW TABLES;

SELECT * FROM buy;

-- customerid 별로 그룹화하여 customerid, 제품거래건수, 총수량, 평균, 할인율을 출력하라
SELECT costomerid, COUNT(productid) AS '제품거래건수', SUM(quantity) AS '총수량', 
AVG(discount) AS'평균할인율' FROM buy GROUP BY customerid;


-- buy 테이블에서 할인율이 가장 작은 거래 정보를 수량(quantity)의 내림차순으로 출력하시오.
-- 단 수량이 같은 경우 주문일(orderdate)의 오름차순으로 하시오.
SELECT * FROM buy WHERE discount = (SELECT min(discount) FROM buy) 
ORDER BY quantity DESC, orderdate ASC;
-- desc 내림차순 asc 오름차순


-- 배송일(shipdate)의 년도별로 총수량의 합계와 총수량의 평균,
-- 총수량의 최대값을 집계하시오.(년도를 추출하는 함수는 YEAR.)
SELECT YEAR(shipdate) AS '년도', SUM(quantity) AS '총합계', AVG(quantity) AS '총평균'
MAX(quantity) AS '최대배송량' FROM buy GROUP BY YEAR(shipdate);


-- 주문일(orderdate)의 년도와 월별로 주문수량(quantity)의 합계와
-- 평균 할인율을 집계하시오.(DATE_FORMAT 함수를 사용.)
-- dateformat(컬럼, 형식)
-- 단, 주문량 합계가 0인 것은 제외할 것.
SELECT DATE_FORMAT(orderdate, '%Y-%m') AS '년월', SUM(quantity) AS '주문량합계',
AVG(discount) AS '평균할인율' FROM buy GROUP BY DATE_FORMAT(orderdate, '%Y-%m')
  HAVING SUM(quantity) !=0;
-- 조건식에 ==0 :0인것, !=0 :0이 아닌 것



-- 제품번호(productid)가 FUR로 시작하는 가구 종류를 구매한 고객정보 중에서
-- 고객명(customername), 국가(country), 도시(city)를 출력하되, 고객id(customerid)의
-- 내림차순으로 하고, 고객id가 같은 경우 주문수량(quantity)의 오름차순으로 할 것.
-- 이중쿼리, 연관쿼리, 내부조인 등 원하는 방식으로 해결할 것.
-- 방법1
SELECT a.customername, a.country, a.city FROM customer a, buy b WHERE
a.customerid = b.customerid ORDER BY a.customerid AND b.productid LIKE 'FUR%'
DESC, b.quantity ASC;
-- 방법2
SELECT a.customername, a.country, a.city FROM customer a INNER join buy b ON
a.customerid = b.customerid WHERE b.productid LIKE 'FUR%' 
order BY a.customerid DESC, b.quantity ASC;



-- 제품(product) 테이블로부터 가격(price)이 40이상인 제품을 검색하여
-- 제품2(product2) 테이블을 생성하시오.(고가 상품 테이블 = product2)
CREATE table product2 AS (SELECT * from product WHERE price >= 40);
-- 제품(product) 테이블로부터 가격(price)이 40미만인 제품을 검색하여
-- 제품3(product3) 테이블을 생성하시오.(저가 상품 테이블 = product3)
CREATE table product3 AS (SELECT * from product WHERE price < 40);

-- 제품3(product3) 테이블로부터 price가 0인 레코드를 삭제하시오.
DELETE FROM product3 WHERE price <= 0;

SELECT TABLE product2;
SELECT TABLE product3;


-- 제품명(productname)에 "(큰따옴표)가 있는 데이터의 "(큰따옴포)를 제거하시오.
UPDATE product2 SET productname=SUBSTRING(productname, 2, LENGTH(productname)-1)
WHERE productname LIKE '\"%';

UPDATE product3 SET productname=SUBSTRING(productname, 2, LENGTH(productname)-1)
WHERE productname LIKE '\"%';


-- UNION : 중복을 제거하여 합집합 
-- UNION ALL : 중복 포함하여 합집합

CREATE VIEW uni_tab1 AS (SELECT productid, price FROM product2 
UNION SELECT productid, price FROM product3);

--교집합
CREATE VIEW int_tab1 AS (SELECT productid, price FROM product2 
INTERSECT SELECT productid, price FROM product3);

-- 차집합
CREATE VIEW exc_tab1 AS (SELECT productid, price FROM product 
EXCEPT SELECT productid, price FROM product2);


SELECT * FROM uni_tab1;
SELECT * FROM int_tab1;
SELECT * FROM exc_tab1;



-- 제품2와 제품3의 테이블 데이터를 합집합하여 전체상품의 테이ㅡㄹ을 생ㅇ성하시오

-- 제품과 제품3의 테이블 데이터를 차집합하여 제거상품의 테이블을 생성하시오

-- 제품과 제품2의 테이블 데이터를 교집합하여 인기상품의 테이블을 생성하시오


CREATE TABLE 

CREATE TABLE totpro AS (SELECT * FROM product2 UNION SELECT * FROM product3);
CREATE TABLE totpro AS (SELECT * FROM product UNION ALL SELECT * FROM product3);
CREATE TABLE totpro AS (SELECT * FROM product2 EXCEPT SELECT * FROM product2);

CREATE VIEW int_tab1 AS (SELECT productid, price FROM product2 
INTERSECT SELECT productid, price FROM product3);
