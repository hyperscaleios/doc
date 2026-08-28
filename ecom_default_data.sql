    insert into attribute(attr_name) values('home');

insert  into attribute(attr_name) values('office');

insert into attribute(attr_name) values('warehouse');

insert into attribute(attr_name) values('FedEx');

insert into attribute(attr_name) values('UPS');

-- Table: public.customer
-- cust_type
-- 1  =  retail
-- 2  =  wholesale
-- 3  =  customer
-- 4  =  internal
-- 5  =  prospect
-- 6  =  vendor
-- 7  =  vendor/customer
insert into customer(cust_type,cust_name)values(1,'retail');
insert into customer(cust_type,cust_name)values(2,'wholesale');
insert into customer(cust_type,cust_name)values(4,'internal');

CREATE OR REPLACE PROCEDURE insert_customer(
	custType INTEGER, 
	custName TEXT


)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO customer(cust_type, cust_name)
	VALUES (custType, custName);
        COMMIT;
END;
$$
