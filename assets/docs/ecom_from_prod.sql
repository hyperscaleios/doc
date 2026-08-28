- SEQUENCE: public.attr_id_seq

-- DROP SEQUENCE IF EXISTS public.attr_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.attr_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.attr_id_seq
    OWNER TO hsio;

-- Table: public.attribute

-- DROP TABLE IF EXISTS public.attribute;

CREATE TABLE IF NOT EXISTS public.attribute
(
    attr_id integer NOT NULL DEFAULT nextval('attr_id_seq'::regclass),
    attr_name character varying(25) COLLATE pg_catalog."default",
    attr_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT attribute_pkey PRIMARY KEY (attr_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.attribute
    OWNER to hsio;
-- SEQUENCE: public.cust_id_seq

-- DROP SEQUENCE IF EXISTS public.cust_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.cust_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.cust_id_seq
    OWNER TO hsio;
-- Table: public.customer
-- cust_type
-- 1  =  retail
-- 2  =  wholesale
-- 3  =  customer
-- 4  =  internal
-- 5  =  prospect
-- 6  =  vendor
-- 7  =  vendor/customer

-- DROP TABLE IF EXISTS public.customer;

CREATE TABLE IF NOT EXISTS public.customer
(
    cust_id integer NOT NULL DEFAULT nextval('cust_id_seq'::regclass),
    cust_type integer DEFAULT 1,
    cust_name character varying(40) COLLATE pg_catalog."default",
    cust_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_deleted boolean,
    CONSTRAINT customer_pkey PRIMARY KEY (cust_id)
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customer
    OWNER to hsio;

-- SEQUENCE: public.cust_attr_id_seq

-- DROP SEQUENCE IF EXISTS public.cust_attr_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.cust_attr_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.cust_attr_id_seq
    OWNER TO hsio;

-- Table: public.cust_attr

-- DROP TABLE IF EXISTS public.cust_attr;

CREATE TABLE IF NOT EXISTS public.cust_attr
(
    cust_attr_id integer NOT NULL DEFAULT nextval('cust_attr_id_seq'::regclass),
    attr_id integer,
    cust_id integer,
    cust_attr_value character varying(100) COLLATE pg_catalog."default",
    cust_attr_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT cust_attr_pkey PRIMARY KEY (cust_attr_id)
)
TABLESPACE pg_default;

-- SEQUENCE: public.contact_id_seq

-- DROP SEQUENCE IF EXISTS public.contact_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.contact_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.contact_id_seq
    OWNER TO hsio;

-- Table: public.contact

-- DROP TABLE IF EXISTS public.contact;

CREATE TABLE IF NOT EXISTS public.contact
(
    contact_id integer NOT NULL DEFAULT nextval('contact_id_seq'::regclass),
    fname character varying(20) COLLATE pg_catalog."default",
    lname character varying(20) COLLATE pg_catalog."default",
    phone character varying(20) COLLATE pg_catalog."default",
    email character varying(20) COLLATE pg_catalog."default",
    contact_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT contact_pkey PRIMARY KEY (contact_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.contact
    OWNER to hsio;

-- SEQUENCE: public.address_id_seq

-- DROP SEQUENCE IF EXISTS public.address_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.address_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.address_id_seq
    OWNER TO hsio;

-- Table: public.address

-- DROP TABLE IF EXISTS public.address;

CREATE TABLE IF NOT EXISTS public.address
(
    address_id integer NOT NULL DEFAULT nextval('address_id_seq'::regclass),
    cust_id integer,
    attr_id integer,
    phone character varying(20) COLLATE pg_catalog."default",
    email character varying(20) COLLATE pg_catalog."default",
    address_attr_value character varying(30) COLLATE pg_catalog."default",
    street_address character varying(50) COLLATE pg_catalog."default",
    city character varying(20) COLLATE pg_catalog."default",
    province character varying(20) COLLATE pg_catalog."default",
    country character varying(20) COLLATE pg_catalog."default",
    zipcode character varying(20) COLLATE pg_catalog."default",
    crdate timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT address_pkey PRIMARY KEY (address_id),
    CONSTRAINT address_attr_id_fkey FOREIGN KEY (attr_id)
        REFERENCES public.attribute (attr_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT address_cust_id_fkey FOREIGN KEY (cust_id)
        REFERENCES public.customer (cust_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.address
    OWNER to hsio;

-- SEQUENCE: public.product_id_seq

-- DROP SEQUENCE IF EXISTS public.product_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.product_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.product_id_seq
    OWNER TO hsio;

-- Table: public.product

-- DROP TABLE IF EXISTS public.product;

CREATE TABLE IF NOT EXISTS public.product
(
    product_id integer NOT NULL DEFAULT nextval('product_id_seq'::regclass),
    product_name character varying(50) COLLATE pg_catalog."default",
    product_status smallint DEFAULT 1,
    product_desc character varying(200) COLLATE pg_catalog."default",
    product_price numeric(6,2),
    product_msg character varying(30) COLLATE pg_catalog."default",
    CONSTRAINT product_pkey PRIMARY KEY (product_id)
)
TABLESPACE pg_default;
-- product_status   
-- 1  = available
-- 15 = available and discounted 15%.
-- 2  = back ordered
-- 4  = discontinued

ALTER TABLE IF EXISTS public.product
    OWNER to hsio;


-- SEQUENCE: public.product_attr_seq

-- DROP SEQUENCE IF EXISTS public.product_attr_seq;

CREATE SEQUENCE IF NOT EXISTS public.product_attr_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.product_attr_seq
    OWNER TO hsio;

-- Table: public.product_attr

-- DROP TABLE IF EXISTS public.product_attr;

CREATE TABLE IF NOT EXISTS public.product_attr
(
    product_attr_id integer NOT NULL DEFAULT nextval('product_attr_seq'::regclass),
    product_id integer,
    product_attr_value character varying(50) COLLATE pg_catalog."default",
    product_attr_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT product_attr_pkey PRIMARY KEY (product_attr_id),
    CONSTRAINT product_attr_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.product (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.product_attr
    OWNER to hsio;

-- SEQUENCE: public.product_inv_id_seq

-- DROP SEQUENCE IF EXISTS public.product_inv_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.product_inv_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.product_inv_id_seq
    OWNER TO hsio;

-- Table: public.product_inv

-- DROP TABLE IF EXISTS public.product_inv;

CREATE TABLE IF NOT EXISTS public.product_inv
(
    product_inv_id integer NOT NULL DEFAULT nextval('product_inv_id_seq'::regclass),
    product_id integer,
    cust_id integer,
    qnty integer DEFAULT 1,
    location character varying(10) COLLATE pg_catalog."default" DEFAULT 'warehouse'::character varying,
    serial_number character varying(30) COLLATE pg_catalog."default" DEFAULT 99999,
    CONSTRAINT product_inv_pkey PRIMARY KEY (product_inv_id),
    CONSTRAINT product_inv_cust_id_fkey FOREIGN KEY (cust_id)
        REFERENCES public.customer (cust_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_inv_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.product (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_inv
    OWNER to hsio;
-- SEQUENCE: public.order_id_seq

-- DROP SEQUENCE IF EXISTS public.order_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.order_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.order_id_seq
    OWNER TO hsio;

-- Table: public.s_order

-- DROP TABLE IF EXISTS public.s_order;

CREATE TABLE IF NOT EXISTS public.s_order
(
    order_id integer NOT NULL DEFAULT nextval('order_id_seq'::regclass),
    cust_id integer,
    order_date date DEFAULT CURRENT_DATE,
    total real,
    payment_method character varying(10) COLLATE pg_catalog."default",
    payment_term integer,
    due_date date,
    delivery_method character varying(10) COLLATE pg_catalog."default",
    CONSTRAINT s_order_pkey PRIMARY KEY (order_id),
    CONSTRAINT s_order_cust_id_fkey FOREIGN KEY (cust_id)
        REFERENCES public.customer (cust_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.s_order
    OWNER to hsio;

-- SEQUENCE: public.sorder_detail_id_seq

-- DROP SEQUENCE IF EXISTS public.sorder_detail_id_seq;

CREATE SEQUENCE IF NOT EXISTS public.sorder_detail_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.sorder_detail_id_seq
    OWNER TO hsio;

-- Table: public.s_order_detail

-- DROP TABLE IF EXISTS public.s_order_detail;

CREATE TABLE IF NOT EXISTS public.s_order_detail
(
    sorder_detail_id integer NOT NULL DEFAULT nextval('sorder_detail_id_seq'::regclass),
    order_id integer,
    product_id integer,
    qnty integer DEFAULT 1,
    location character varying(10) COLLATE pg_catalog."default" DEFAULT 'warehouse'::character varying,
    serial_number character varying(30) COLLATE pg_catalog."default" DEFAULT 99999,
    CONSTRAINT s_order_detail_pkey PRIMARY KEY (sorder_detail_id),
    CONSTRAINT s_order_detail_order_id_fkey FOREIGN KEY (order_id)
        REFERENCES public.s_order (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT s_order_detail_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.product (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.s_order_detail
    OWNER to hsio;

-- SEQUENCE: public.ticket_number_seq

-- DROP SEQUENCE IF EXISTS public.ticket_number_seq;

CREATE SEQUENCE IF NOT EXISTS public.ticket_number_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.ticket_number_seq
    OWNER TO hsio;

-- Table: public.ticket

-- DROP TABLE IF EXISTS public.ticket;

CREATE TABLE IF NOT EXISTS public.ticket
(
    ticket_number integer NOT NULL DEFAULT nextval('ticket_number_seq'::regclass),
    cust_id integer,
    product_id integer,
    crdate timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ticket_desc text COLLATE pg_catalog."default",
    ticket_owner character varying(20) COLLATE pg_catalog."default",
    contact_id integer,
    priority smallint,
    status character varying(10) COLLATE pg_catalog."default",
    CONSTRAINT ticket_pkey PRIMARY KEY (ticket_number),
    CONSTRAINT ticket_cust_id_fkey FOREIGN KEY (cust_id)
        REFERENCES public.customer (cust_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT ticket_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.product (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;
alter table ticket add constraint ticket_priority check (priority in (1,2,3,4));
ALTER TABLE IF EXISTS public.ticket
    OWNER to hsio;

-- SEQUENCE: public.ticket_number_seq

-- DROP SEQUENCE IF EXISTS public.ticket_number_seq;

CREATE SEQUENCE IF NOT EXISTS public.ticket_detail_id_seq
    INCREMENT 1
    START 101
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
ALTER SEQUENCE public.ticket_detail_id_seq
    OWNER TO hsio;


-- Table: public.ticket_detail

-- DROP TABLE IF EXISTS public.ticket_detail;

CREATE TABLE IF NOT EXISTS public.ticket_detail(
    ticket_detail_id integer NOT NULL DEFAULT nextval('ticket_detail_id_seq'::regclass),
    ticket_number integer,
    contact_media character varying(6) COLLATE pg_catalog."default",
    contact_date date,
    contact_id integer,
    conversation text COLLATE pg_catalog."default",
    CONSTRAINT ticket_detail_pkey PRIMARY KEY (ticket_detail_id),
    CONSTRAINT ticket_detail_ticket_number_fkey FOREIGN KEY (ticket_number)
        REFERENCES public.ticket (ticket_number) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.ticket_detail
    OWNER to hsio;


