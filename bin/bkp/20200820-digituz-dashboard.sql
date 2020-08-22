--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: app_user; Type: TABLE; Schema: public; Owner: digituz-dashboard
--

CREATE TABLE public.app_user (
    id integer NOT NULL,
    name character varying(75) NOT NULL,
    email character varying(150) NOT NULL,
    password character varying(150) NOT NULL,
    version integer
);


ALTER TABLE public.app_user OWNER TO "digituz-dashboard";

--
-- Name: app_user_id_seq; Type: SEQUENCE; Schema: public; Owner: digituz-dashboard
--

CREATE SEQUENCE public.app_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_user_id_seq OWNER TO "digituz-dashboard";

--
-- Name: app_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digituz-dashboard
--

ALTER SEQUENCE public.app_user_id_seq OWNED BY public.app_user.id;


--
-- Name: customer; Type: TABLE; Schema: public; Owner: digituz-dashboard
--

CREATE TABLE public.customer (
    id integer NOT NULL,
    cpf character varying(11) NOT NULL,
    name character varying(60) NOT NULL,
    phone_number character varying(24),
    email character varying(60),
    birthday date,
    zip_address character varying(8),
    state character varying(2),
    city character varying(30),
    neighborhood character varying(30),
    street_address character varying(50),
    street_number character varying(10),
    street_number2 character varying(20),
    version integer
);


ALTER TABLE public.customer OWNER TO "digituz-dashboard";

--
-- Name: customer_id_seq; Type: SEQUENCE; Schema: public; Owner: digituz-dashboard
--

CREATE SEQUENCE public.customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_id_seq OWNER TO "digituz-dashboard";

--
-- Name: customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digituz-dashboard
--

ALTER SEQUENCE public.customer_id_seq OWNED BY public.customer.id;


--
-- Name: database_migrations; Type: TABLE; Schema: public; Owner: digituz-dashboard
--

CREATE TABLE public.database_migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.database_migrations OWNER TO "digituz-dashboard";

--
-- Name: database_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: digituz-dashboard
--

CREATE SEQUENCE public.database_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.database_migrations_id_seq OWNER TO "digituz-dashboard";

--
-- Name: database_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digituz-dashboard
--

ALTER SEQUENCE public.database_migrations_id_seq OWNED BY public.database_migrations.id;


--
-- Name: image; Type: TABLE; Schema: public; Owner: digituz-dashboard
--

CREATE TABLE public.image (
    id integer NOT NULL,
    main_filename character varying(140) NOT NULL,
    original_filename character varying(140) NOT NULL,
    mimetype character varying(30) NOT NULL,
    original_file_url character varying(400) NOT NULL,
    extra_large_file_url character varying(400) NOT NULL,
    large_file_url character varying(400) NOT NULL,
    medium_file_url character varying(400) NOT NULL,
    small_file_url character varying(400) NOT NULL,
    thumbnail_file_url character varying(400) NOT NULL,
    version integer,
    number_of_tags integer DEFAULT 0 NOT NULL,
    archived boolean DEFAULT false NOT NULL,
    file_size integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    aspect_ratio numeric(13,2) NOT NULL
);


ALTER TABLE public.image OWNER TO "digituz-dashboard";

--
-- Name: image_id_seq; Type: SEQUENCE; Schema: public; Owner: digituz-dashboard
--

CREATE SEQUENCE public.image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.image_id_seq OWNER TO "digituz-dashboard";

--
-- Name: image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digituz-dashboard
--

ALTER SEQUENCE public.image_id_seq OWNED BY public.image.id;


--
-- Name: image_tag; Type: TABLE; Schema: public; Owner: digituz-dashboard
--

CREATE TABLE public.image_tag (
    image_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.image_tag OWNER TO "digituz-dashboard";

--
-- Name: inventory; Type: TABLE; Schema: public; Owner: digituz-dashboard
--

CREATE TABLE public.inventory (
    id integer NOT NULL,
    current_position integer DEFAULT 0 NOT NULL,
    version integer,
    product_variation_id integer
);


ALTER TABLE public.inventory OWNER TO "digituz-dashboard";

--
-- Name: inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: digituz-dashboard
--

CREATE SEQUENCE public.inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_id_seq OWNER TO "digituz-dashboard";

--
-- Name: inventory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digituz-dashboard
--

ALTER SEQUENCE public.inventory_id_seq OWNED BY public.inventory.id;


--
-- Name: inventory_movement; Type: TABLE; Schema: public; Owner: digituz-dashboard
--

CREATE TABLE public.inventory_movement (
    id integer NOT NULL,
    inventory_id integer NOT NULL,
    amount integer NOT NULL,
    description character varying(60) NOT NULL,
    version integer,
    sale_order_id integer
);


ALTER TABLE public.inventory_movement OWNER TO "digituz-dashboard";

--
-- Name: inventory_movement_id_seq; Type: SEQUENCE; Schema: public; Owner: digituz-dashboard
--

CREATE SEQUENCE public.inventory_movement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_movement_id_seq OWNER TO "digituz-dashboard";

--
-- Name: inventory_movement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digituz-dashboard
--

ALTER SEQUENCE public.inventory_movement_id_seq OWNED BY public.inventory_movement.id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: digituz-dashboard
--

CREATE TABLE public.product (
    id integer NOT NULL,
    sku character varying(24) NOT NULL,
    title character varying(60) NOT NULL,
    description text,
    product_details text,
    selling_price numeric(15,2),
    height numeric(15,3),
    width numeric(15,3),
    length numeric(15,3),
    weight numeric(15,3),
    is_active boolean DEFAULT true,
    ncm character varying(10) NOT NULL,
    version integer,
    variations_size integer DEFAULT 0 NOT NULL,
    images_size integer DEFAULT 0 NOT NULL,
    without_variation boolean DEFAULT true NOT NULL,
    category character varying(60)
);


ALTER TABLE public.product OWNER TO "digituz-dashboard";

--
-- Name: product_composition; Type: TABLE; Schema: public; Owner: digituz-dashboard
--

CREATE TABLE public.product_composition (
    id integer NOT NULL,
    product_id integer NOT NULL,
    product_variation_id integer NOT NULL,
    version integer
);


ALTER TABLE public.product_composition OWNER TO "digituz-dashboard";

--
-- Name: product_composition_id_seq; Type: SEQUENCE; Schema: public; Owner: digituz-dashboard
--

CREATE SEQUENCE public.product_composition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_composition_id_seq OWNER TO "digituz-dashboard";

--
-- Name: product_composition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digituz-dashboard
--

ALTER SEQUENCE public.product_composition_id_seq OWNED BY public.product_composition.id;


--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: digituz-dashboard
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_id_seq OWNER TO "digituz-dashboard";

--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digituz-dashboard
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- Name: product_image; Type: TABLE; Schema: public; Owner: digituz-dashboard
--

CREATE TABLE public.product_image (
    image_id integer NOT NULL,
    product_id integer NOT NULL,
    image_order integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.product_image OWNER TO "digituz-dashboard";

--
-- Name: product_image_id_seq; Type: SEQUENCE; Schema: public; Owner: digituz-dashboard
--

CREATE SEQUENCE public.product_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_image_id_seq OWNER TO "digituz-dashboard";

--
-- Name: product_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digituz-dashboard
--

ALTER SEQUENCE public.product_image_id_seq OWNED BY public.product_image.id;


--
-- Name: product_variation; Type: TABLE; Schema: public; Owner: digituz-dashboard
--

CREATE TABLE public.product_variation (
    id integer NOT NULL,
    sku character varying(24) NOT NULL,
    product_id integer NOT NULL,
    description text,
    selling_price numeric(15,2),
    version integer,
    no_variation boolean DEFAULT false NOT NULL,
    current_position integer
);


ALTER TABLE public.product_variation OWNER TO "digituz-dashboard";

--
-- Name: product_variation_id_seq; Type: SEQUENCE; Schema: public; Owner: digituz-dashboard
--

CREATE SEQUENCE public.product_variation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_variation_id_seq OWNER TO "digituz-dashboard";

--
-- Name: product_variation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digituz-dashboard
--

ALTER SEQUENCE public.product_variation_id_seq OWNED BY public.product_variation.id;


--
-- Name: sale_order; Type: TABLE; Schema: public; Owner: digituz-dashboard
--

CREATE TABLE public.sale_order (
    id integer NOT NULL,
    version integer,
    reference_code character varying(36) NOT NULL,
    customer_id integer NOT NULL,
    discount numeric(15,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    payment_type character varying(60) NOT NULL,
    payment_status character varying(60) NOT NULL,
    installments integer NOT NULL,
    shipping_type character varying(60) NOT NULL,
    customer_name character varying(60) NOT NULL,
    shipping_street_address character varying(50) NOT NULL,
    shipping_street_number character varying(10) NOT NULL,
    shipping_street_number_2 character varying(20),
    shipping_neighborhood character varying(30) NOT NULL,
    shipping_city character varying(30) NOT NULL,
    shipping_state character varying(2) NOT NULL,
    shipping_zip_address character varying(8) NOT NULL,
    shipping_price numeric(15,2) NOT NULL,
    creation_date timestamp without time zone,
    approval_date timestamp without time zone,
    cancellation_date timestamp without time zone,
    bling_status character varying(30)
);


ALTER TABLE public.sale_order OWNER TO "digituz-dashboard";

--
-- Name: sale_order_id_seq; Type: SEQUENCE; Schema: public; Owner: digituz-dashboard
--

CREATE SEQUENCE public.sale_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sale_order_id_seq OWNER TO "digituz-dashboard";

--
-- Name: sale_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digituz-dashboard
--

ALTER SEQUENCE public.sale_order_id_seq OWNED BY public.sale_order.id;


--
-- Name: sale_order_item; Type: TABLE; Schema: public; Owner: digituz-dashboard
--

CREATE TABLE public.sale_order_item (
    id integer NOT NULL,
    version integer,
    sale_order_id integer NOT NULL,
    price numeric(15,2),
    discount numeric(15,2),
    amount numeric(15,2),
    product_variation_id integer
);


ALTER TABLE public.sale_order_item OWNER TO "digituz-dashboard";

--
-- Name: sale_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: digituz-dashboard
--

CREATE SEQUENCE public.sale_order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sale_order_item_id_seq OWNER TO "digituz-dashboard";

--
-- Name: sale_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digituz-dashboard
--

ALTER SEQUENCE public.sale_order_item_id_seq OWNED BY public.sale_order_item.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: digituz-dashboard
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    label character varying(24) NOT NULL,
    description character varying(60) NOT NULL,
    version integer
);


ALTER TABLE public.tag OWNER TO "digituz-dashboard";

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: digituz-dashboard
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO "digituz-dashboard";

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: digituz-dashboard
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: app_user id; Type: DEFAULT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.app_user ALTER COLUMN id SET DEFAULT nextval('public.app_user_id_seq'::regclass);


--
-- Name: customer id; Type: DEFAULT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.customer ALTER COLUMN id SET DEFAULT nextval('public.customer_id_seq'::regclass);


--
-- Name: database_migrations id; Type: DEFAULT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.database_migrations ALTER COLUMN id SET DEFAULT nextval('public.database_migrations_id_seq'::regclass);


--
-- Name: image id; Type: DEFAULT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.image ALTER COLUMN id SET DEFAULT nextval('public.image_id_seq'::regclass);


--
-- Name: inventory id; Type: DEFAULT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.inventory ALTER COLUMN id SET DEFAULT nextval('public.inventory_id_seq'::regclass);


--
-- Name: inventory_movement id; Type: DEFAULT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.inventory_movement ALTER COLUMN id SET DEFAULT nextval('public.inventory_movement_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- Name: product_composition id; Type: DEFAULT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product_composition ALTER COLUMN id SET DEFAULT nextval('public.product_composition_id_seq'::regclass);


--
-- Name: product_image id; Type: DEFAULT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product_image ALTER COLUMN id SET DEFAULT nextval('public.product_image_id_seq'::regclass);


--
-- Name: product_variation id; Type: DEFAULT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product_variation ALTER COLUMN id SET DEFAULT nextval('public.product_variation_id_seq'::regclass);


--
-- Name: sale_order id; Type: DEFAULT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.sale_order ALTER COLUMN id SET DEFAULT nextval('public.sale_order_id_seq'::regclass);


--
-- Name: sale_order_item id; Type: DEFAULT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.sale_order_item ALTER COLUMN id SET DEFAULT nextval('public.sale_order_item_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: digituz-dashboard
--

COPY public.app_user (id, name, email, password, version) FROM stdin;
1	Bruno Krebs	bruno.krebs@fridakahlo.com.br	lbX01as$	\N
2	Lena Vettoretti	lena@fridakahlo.com.br	lbX01as$	\N
3	Fabíola Pires	admin@fridakahlo.com.br	lbX01as$	\N
4	Agnes Romeu	agnessromeu@gmail.com	lbX01as$	\N
5	Integração Site Frida Kahlo	api-user@fridakahlo.com.br	jas41Hm_1lPO	\N
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: digituz-dashboard
--

COPY public.customer (id, cpf, name, phone_number, email, birthday, zip_address, state, city, neighborhood, street_address, street_number, street_number2, version) FROM stdin;
2	02472440073	Joana da Silva	21987654321	joana@spam4.me	1976-03-06	22440000	RJ	Rio de Janeiro	Leblon	Rua Almirante Guilhem	44	\N	1
1	64846453022	Pingo Vettoretti Krebs	51999999999	pingo@spam4.me	2019-01-20	01305000	SP	São Paulo	Consolação	Rua Augusta	123		2
\.


--
-- Data for Name: database_migrations; Type: TABLE DATA; Schema: public; Owner: digituz-dashboard
--

COPY public.database_migrations (id, "timestamp", name) FROM stdin;
1	1590442910556	products1590442910556
2	1590450018996	productsVariations1590450018996
3	1591067635452	images1591067635452
4	1591226382556	users1591226382556
5	1592126793246	variationsSize1592126793246
6	1593080022054	tags1593080022054
7	1593177822667	imageTags1593177822667
8	1593254766379	numberOfTags1593254766379
9	1593268025563	archivedImages1593268025563
10	1593300501313	imageDetails1593300501313
12	1593507529662	productImages1593507529662
13	1593743578245	productAdjustments1593743578245
14	1593816386883	inventoryControl1593816386883
16	1594294027020	customers1594294027020
20	1594583375504	salesOrder1594583375504
26	1594763802705	salesOrderInventory1594763802705
28	1594890063844	noVariation1594890063844
32	1594906117705	inventoryProductVariation1594906117705
34	1594992375542	removeAutoTimestamps1594992375542
35	1595685058409	databaseAmendments1595685058409
36	1595885583223	productCategories1595885583223
37	1596234755381	apiUser1596234755381
41	1596497372893	saleOrderDate1596497372893
43	1597234604055	uniqueRefCode1597234604055
45	1597342730008	salesOrderBlingStatus1597342730008
46	1597671859780	compositeProduct1597671859780
48	1597671860980	productVariationCurrentPosition1597671860980
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: digituz-dashboard
--

COPY public.image (id, main_filename, original_filename, mimetype, original_file_url, extra_large_file_url, large_file_url, medium_file_url, small_file_url, thumbnail_file_url, version, number_of_tags, archived, file_size, width, height, aspect_ratio) FROM stdin;
255	H0012_zujedTq2PK-1593471653551-original-.png	H0012_zujedTq2PK.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/H0012_zujedTq2PK-1593471653551-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/H0012_zujedTq2PK-1593471653551-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/H0012_zujedTq2PK-1593471653551-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/H0012_zujedTq2PK-1593471653551-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/H0012_zujedTq2PK-1593471653551-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/H0012_zujedTq2PK-1593471653551-thumbnail.png	2	1	f	6565	383	383	1.00
256	A05938-3_aTyR16tOn-1593471652355-original-.png	A05938-3_aTyR16tOn.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05938-3_aTyR16tOn-1593471652355-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05938-3_aTyR16tOn-1593471652355-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05938-3_aTyR16tOn-1593471652355-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05938-3_aTyR16tOn-1593471652355-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05938-3_aTyR16tOn-1593471652355-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05938-3_aTyR16tOn-1593471652355-thumbnail.png	2	1	f	22301	551	551	1.00
257	B05938-3_uC6m2SxiMP-1593471653155-original-.png	B05938-3_uC6m2SxiMP.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05938-3_uC6m2SxiMP-1593471653155-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05938-3_uC6m2SxiMP-1593471653155-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05938-3_uC6m2SxiMP-1593471653155-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05938-3_uC6m2SxiMP-1593471653155-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05938-3_uC6m2SxiMP-1593471653155-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05938-3_uC6m2SxiMP-1593471653155-thumbnail.png	2	1	f	28822	551	551	1.00
258	A05912-3_bOQfSag0rS-1593471651952-original-.png	A05912-3_bOQfSag0rS.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05912-3_bOQfSag0rS-1593471651952-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05912-3_bOQfSag0rS-1593471651952-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05912-3_bOQfSag0rS-1593471651952-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05912-3_bOQfSag0rS-1593471651952-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05912-3_bOQfSag0rS-1593471651952-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05912-3_bOQfSag0rS-1593471651952-thumbnail.png	2	1	f	75247	945	945	1.00
259	A05910-3_5LeETziAJv-1593471651168-original-.png	A05910-3_5LeETziAJv.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05910-3_5LeETziAJv-1593471651168-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05910-3_5LeETziAJv-1593471651168-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05910-3_5LeETziAJv-1593471651168-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05910-3_5LeETziAJv-1593471651168-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05910-3_5LeETziAJv-1593471651168-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05910-3_5LeETziAJv-1593471651168-thumbnail.png	2	1	f	84075	945	945	1.00
260	A05911-3_pp1-09lZu-1593471651558-original-.png	A05911-3_pp1-09lZu.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05911-3_pp1-09lZu-1593471651558-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05911-3_pp1-09lZu-1593471651558-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05911-3_pp1-09lZu-1593471651558-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05911-3_pp1-09lZu-1593471651558-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05911-3_pp1-09lZu-1593471651558-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05911-3_pp1-09lZu-1593471651558-thumbnail.png	2	1	f	114182	945	945	1.00
261	G05910-3_2Q1GdY6D65-1593471652753-original-.png	G05910-3_2Q1GdY6D65.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05910-3_2Q1GdY6D65-1593471652753-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05910-3_2Q1GdY6D65-1593471652753-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05910-3_2Q1GdY6D65-1593471652753-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05910-3_2Q1GdY6D65-1593471652753-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05910-3_2Q1GdY6D65-1593471652753-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05910-3_2Q1GdY6D65-1593471652753-thumbnail.png	2	1	f	81513	1080	1080	1.00
398	4057_-_Porta_Niq_FK009_AM_-_frente_Vhx_SKEmT-1593471705176-original-.jpg	4057_-_Porta_Niq_FK009_AM_-_frente_Vhx_SKEmT.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4057_-_Porta_Niq_FK009_AM_-_frente_Vhx_SKEmT-1593471705176-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4057_-_Porta_Niq_FK009_AM_-_frente_Vhx_SKEmT-1593471705176-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4057_-_Porta_Niq_FK009_AM_-_frente_Vhx_SKEmT-1593471705176-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4057_-_Porta_Niq_FK009_AM_-_frente_Vhx_SKEmT-1593471705176-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4057_-_Porta_Niq_FK009_AM_-_frente_Vhx_SKEmT-1593471705176-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4057_-_Porta_Niq_FK009_AM_-_frente_Vhx_SKEmT-1593471705176-thumbnail.jpg	2	1	f	103968	1080	731	1.48
262	P05901-3_YQjB9P6uo-1593471654353-original-.png	P05901-3_YQjB9P6uo.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05901-3_YQjB9P6uo-1593471654353-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05901-3_YQjB9P6uo-1593471654353-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05901-3_YQjB9P6uo-1593471654353-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05901-3_YQjB9P6uo-1593471654353-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05901-3_YQjB9P6uo-1593471654353-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05901-3_YQjB9P6uo-1593471654353-thumbnail.png	2	1	f	33935	945	945	1.00
269	P05903-3_x5U0EWfCQ-1593471654753-original-.png	P05903-3_x5U0EWfCQ.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05903-3_x5U0EWfCQ-1593471654753-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05903-3_x5U0EWfCQ-1593471654753-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05903-3_x5U0EWfCQ-1593471654753-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05903-3_x5U0EWfCQ-1593471654753-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05903-3_x5U0EWfCQ-1593471654753-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05903-3_x5U0EWfCQ-1593471654753-thumbnail.png	2	1	f	49368	945	945	1.00
399	4061_-_Bolsa_Trans_FK009_C_-_frente_uK0xvdVZo-1593471708762-original-.jpg	4061_-_Bolsa_Trans_FK009_C_-_frente_uK0xvdVZo.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4061_-_Bolsa_Trans_FK009_C_-_frente_uK0xvdVZo-1593471708762-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4061_-_Bolsa_Trans_FK009_C_-_frente_uK0xvdVZo-1593471708762-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4061_-_Bolsa_Trans_FK009_C_-_frente_uK0xvdVZo-1593471708762-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4061_-_Bolsa_Trans_FK009_C_-_frente_uK0xvdVZo-1593471708762-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4061_-_Bolsa_Trans_FK009_C_-_frente_uK0xvdVZo-1593471708762-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4061_-_Bolsa_Trans_FK009_C_-_frente_uK0xvdVZo-1593471708762-thumbnail.jpg	2	1	f	116313	792	1080	0.73
425	IMG_7488_6dSxpBTVb-1593471719554-original-.jpg	IMG_7488_6dSxpBTVb.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7488_6dSxpBTVb-1593471719554-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7488_6dSxpBTVb-1593471719554-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7488_6dSxpBTVb-1593471719554-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7488_6dSxpBTVb-1593471719554-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7488_6dSxpBTVb-1593471719554-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7488_6dSxpBTVb-1593471719554-thumbnail.jpg	3	1	t	37184	1080	720	1.50
265	P05910-3_yPlmkAgXk-1593471655952-original-.png	P05910-3_yPlmkAgXk.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05910-3_yPlmkAgXk-1593471655952-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05910-3_yPlmkAgXk-1593471655952-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05910-3_yPlmkAgXk-1593471655952-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05910-3_yPlmkAgXk-1593471655952-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05910-3_yPlmkAgXk-1593471655952-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05910-3_yPlmkAgXk-1593471655952-thumbnail.png	3	2	f	99628	945	945	1.00
266	P05904-3_K1wSfO5Kl-1593471657165-original-.png	P05904-3_K1wSfO5Kl.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05904-3_K1wSfO5Kl-1593471657165-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05904-3_K1wSfO5Kl-1593471657165-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05904-3_K1wSfO5Kl-1593471657165-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05904-3_K1wSfO5Kl-1593471657165-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05904-3_K1wSfO5Kl-1593471657165-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05904-3_K1wSfO5Kl-1593471657165-thumbnail.png	2	1	f	38912	945	945	1.00
267	P05902-3_i2Mbn50SJB-1593471657554-original-.png	P05902-3_i2Mbn50SJB.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05902-3_i2Mbn50SJB-1593471657554-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05902-3_i2Mbn50SJB-1593471657554-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05902-3_i2Mbn50SJB-1593471657554-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05902-3_i2Mbn50SJB-1593471657554-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05902-3_i2Mbn50SJB-1593471657554-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05902-3_i2Mbn50SJB-1593471657554-thumbnail.png	2	1	f	27188	945	945	1.00
268	P05914-3_c7vFv2oln-1593471656366-original-.png	P05914-3_c7vFv2oln.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05914-3_c7vFv2oln-1593471656366-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05914-3_c7vFv2oln-1593471656366-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05914-3_c7vFv2oln-1593471656366-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05914-3_c7vFv2oln-1593471656366-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05914-3_c7vFv2oln-1593471656366-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05914-3_c7vFv2oln-1593471656366-thumbnail.png	2	1	f	90379	1080	1080	1.00
270	P05913-3_Q-TBPm1y2-1593471656753-original-.png	P05913-3_Q-TBPm1y2.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05913-3_Q-TBPm1y2-1593471656753-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05913-3_Q-TBPm1y2-1593471656753-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05913-3_Q-TBPm1y2-1593471656753-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05913-3_Q-TBPm1y2-1593471656753-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05913-3_Q-TBPm1y2-1593471656753-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05913-3_Q-TBPm1y2-1593471656753-thumbnail.png	2	1	f	75095	1080	1080	1.00
272	P05906-3_6695yhpu0-1593471655154-original-.png	P05906-3_6695yhpu0.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05906-3_6695yhpu0-1593471655154-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05906-3_6695yhpu0-1593471655154-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05906-3_6695yhpu0-1593471655154-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05906-3_6695yhpu0-1593471655154-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05906-3_6695yhpu0-1593471655154-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05906-3_6695yhpu0-1593471655154-thumbnail.png	2	1	f	77354	945	945	1.00
263	P05900-3_xPxgVk2-B-1593471653961-original-.png	P05900-3_xPxgVk2-B.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05900-3_xPxgVk2-B-1593471653961-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05900-3_xPxgVk2-B-1593471653961-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05900-3_xPxgVk2-B-1593471653961-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05900-3_xPxgVk2-B-1593471653961-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05900-3_xPxgVk2-B-1593471653961-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05900-3_xPxgVk2-B-1593471653961-thumbnail.png	3	2	f	55769	945	945	1.00
271	P05908-3_7vz0hSK-e-1593471657954-original-.png	P05908-3_7vz0hSK-e.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05908-3_7vz0hSK-e-1593471657954-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05908-3_7vz0hSK-e-1593471657954-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05908-3_7vz0hSK-e-1593471657954-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05908-3_7vz0hSK-e-1593471657954-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05908-3_7vz0hSK-e-1593471657954-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05908-3_7vz0hSK-e-1593471657954-thumbnail.png	2	1	f	35377	945	945	1.00
285	P05916-3_oae-24cbZ-1593471658358-original-.png	P05916-3_oae-24cbZ.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05916-3_oae-24cbZ-1593471658358-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05916-3_oae-24cbZ-1593471658358-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05916-3_oae-24cbZ-1593471658358-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05916-3_oae-24cbZ-1593471658358-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05916-3_oae-24cbZ-1593471658358-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05916-3_oae-24cbZ-1593471658358-thumbnail.png	2	1	f	82988	1080	1080	1.00
286	P05929-3_21C1PiAKG-1593471663553-original-.png	P05929-3_21C1PiAKG.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05929-3_21C1PiAKG-1593471663553-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05929-3_21C1PiAKG-1593471663553-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05929-3_21C1PiAKG-1593471663553-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05929-3_21C1PiAKG-1593471663553-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05929-3_21C1PiAKG-1593471663553-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05929-3_21C1PiAKG-1593471663553-thumbnail.png	2	1	f	62589	945	945	1.00
287	P05930-3_byPnJR2c9-1593471663957-original-.png	P05930-3_byPnJR2c9.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05930-3_byPnJR2c9-1593471663957-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05930-3_byPnJR2c9-1593471663957-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05930-3_byPnJR2c9-1593471663957-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05930-3_byPnJR2c9-1593471663957-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05930-3_byPnJR2c9-1593471663957-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05930-3_byPnJR2c9-1593471663957-thumbnail.png	2	1	f	74163	945	945	1.00
288	P05932-3_dS_RxKeAbf-1593471664355-original-.png	P05932-3_dS_RxKeAbf.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05932-3_dS_RxKeAbf-1593471664355-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05932-3_dS_RxKeAbf-1593471664355-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05932-3_dS_RxKeAbf-1593471664355-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05932-3_dS_RxKeAbf-1593471664355-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05932-3_dS_RxKeAbf-1593471664355-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05932-3_dS_RxKeAbf-1593471664355-thumbnail.png	2	1	f	46539	945	945	1.00
289	P05931-3_UuBm8JHzQ-1593471665153-original-.png	P05931-3_UuBm8JHzQ.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05931-3_UuBm8JHzQ-1593471665153-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05931-3_UuBm8JHzQ-1593471665153-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05931-3_UuBm8JHzQ-1593471665153-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05931-3_UuBm8JHzQ-1593471665153-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05931-3_UuBm8JHzQ-1593471665153-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05931-3_UuBm8JHzQ-1593471665153-thumbnail.png	2	1	f	40510	945	945	1.00
290	P05935-3_D5FQq45nV-1593471665558-original-.png	P05935-3_D5FQq45nV.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05935-3_D5FQq45nV-1593471665558-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05935-3_D5FQq45nV-1593471665558-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05935-3_D5FQq45nV-1593471665558-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05935-3_D5FQq45nV-1593471665558-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05935-3_D5FQq45nV-1593471665558-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05935-3_D5FQq45nV-1593471665558-thumbnail.png	2	1	f	90635	945	945	1.00
291	P05936-3_sis-Ys2rZ-1593471665956-original-.png	P05936-3_sis-Ys2rZ.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05936-3_sis-Ys2rZ-1593471665956-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05936-3_sis-Ys2rZ-1593471665956-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05936-3_sis-Ys2rZ-1593471665956-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05936-3_sis-Ys2rZ-1593471665956-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05936-3_sis-Ys2rZ-1593471665956-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05936-3_sis-Ys2rZ-1593471665956-thumbnail.png	2	1	f	46875	945	945	1.00
400	4061_-_Bolsa_Trans_FK009_C_-_verso_L9hdg80nO-1593471709155-original-.jpg	4061_-_Bolsa_Trans_FK009_C_-_verso_L9hdg80nO.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4061_-_Bolsa_Trans_FK009_C_-_verso_L9hdg80nO-1593471709155-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4061_-_Bolsa_Trans_FK009_C_-_verso_L9hdg80nO-1593471709155-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4061_-_Bolsa_Trans_FK009_C_-_verso_L9hdg80nO-1593471709155-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4061_-_Bolsa_Trans_FK009_C_-_verso_L9hdg80nO-1593471709155-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4061_-_Bolsa_Trans_FK009_C_-_verso_L9hdg80nO-1593471709155-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4061_-_Bolsa_Trans_FK009_C_-_verso_L9hdg80nO-1593471709155-thumbnail.jpg	2	1	f	103193	744	1080	0.69
273	P05915-3_AvBV20p4wH-1593471658754-original-.png	P05915-3_AvBV20p4wH.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05915-3_AvBV20p4wH-1593471658754-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05915-3_AvBV20p4wH-1593471658754-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05915-3_AvBV20p4wH-1593471658754-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05915-3_AvBV20p4wH-1593471658754-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05915-3_AvBV20p4wH-1593471658754-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05915-3_AvBV20p4wH-1593471658754-thumbnail.png	2	1	f	90714	1080	1080	1.00
274	P05917-3_kBxRmi1QqT-1593471659158-original-.png	P05917-3_kBxRmi1QqT.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05917-3_kBxRmi1QqT-1593471659158-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05917-3_kBxRmi1QqT-1593471659158-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05917-3_kBxRmi1QqT-1593471659158-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05917-3_kBxRmi1QqT-1593471659158-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05917-3_kBxRmi1QqT-1593471659158-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05917-3_kBxRmi1QqT-1593471659158-thumbnail.png	2	1	f	79627	1080	1080	1.00
275	P05918-3_Vhob8vvMR-1593471659952-original-.png	P05918-3_Vhob8vvMR.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05918-3_Vhob8vvMR-1593471659952-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05918-3_Vhob8vvMR-1593471659952-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05918-3_Vhob8vvMR-1593471659952-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05918-3_Vhob8vvMR-1593471659952-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05918-3_Vhob8vvMR-1593471659952-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05918-3_Vhob8vvMR-1593471659952-thumbnail.png	2	1	f	64214	945	945	1.00
276	P05920-3_YjP7Ylvg0I-1593471660356-original-.png	P05920-3_YjP7Ylvg0I.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05920-3_YjP7Ylvg0I-1593471660356-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05920-3_YjP7Ylvg0I-1593471660356-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05920-3_YjP7Ylvg0I-1593471660356-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05920-3_YjP7Ylvg0I-1593471660356-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05920-3_YjP7Ylvg0I-1593471660356-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05920-3_YjP7Ylvg0I-1593471660356-thumbnail.png	1	0	f	48311	945	945	1.00
277	P05919-3_E-NFtbZly-1593471659557-original-.png	P05919-3_E-NFtbZly.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05919-3_E-NFtbZly-1593471659557-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05919-3_E-NFtbZly-1593471659557-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05919-3_E-NFtbZly-1593471659557-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05919-3_E-NFtbZly-1593471659557-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05919-3_E-NFtbZly-1593471659557-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05919-3_E-NFtbZly-1593471659557-thumbnail.png	2	1	f	102447	1080	1080	1.00
401	B05927-3_fMgg1YYZs-1593471709553-original-.png	B05927-3_fMgg1YYZs.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05927-3_fMgg1YYZs-1593471709553-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05927-3_fMgg1YYZs-1593471709553-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05927-3_fMgg1YYZs-1593471709553-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05927-3_fMgg1YYZs-1593471709553-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05927-3_fMgg1YYZs-1593471709553-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05927-3_fMgg1YYZs-1593471709553-thumbnail.png	2	1	f	97125	945	945	1.00
402	217505_7ZRIwxw5a-1593471710354-original-.png	217505_7ZRIwxw5a.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/217505_7ZRIwxw5a-1593471710354-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/217505_7ZRIwxw5a-1593471710354-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/217505_7ZRIwxw5a-1593471710354-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/217505_7ZRIwxw5a-1593471710354-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/217505_7ZRIwxw5a-1593471710354-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/217505_7ZRIwxw5a-1593471710354-thumbnail.png	1	0	f	53255	1080	1080	1.00
403	B05905-3_kfHfcjyjA-1593471709953-original-.png	B05905-3_kfHfcjyjA.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05905-3_kfHfcjyjA-1593471709953-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05905-3_kfHfcjyjA-1593471709953-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05905-3_kfHfcjyjA-1593471709953-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05905-3_kfHfcjyjA-1593471709953-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05905-3_kfHfcjyjA-1593471709953-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05905-3_kfHfcjyjA-1593471709953-thumbnail.png	2	1	f	83814	945	945	1.00
278	P05920-31_Mnk5dqctD-1593471661152-original-.png	P05920-31_Mnk5dqctD.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05920-31_Mnk5dqctD-1593471661152-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05920-31_Mnk5dqctD-1593471661152-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05920-31_Mnk5dqctD-1593471661152-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05920-31_Mnk5dqctD-1593471661152-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05920-31_Mnk5dqctD-1593471661152-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05920-31_Mnk5dqctD-1593471661152-thumbnail.png	1	0	f	53368	945	945	1.00
279	P05922-3_hi1PZjW9CY-1593471660778-original-.png	P05922-3_hi1PZjW9CY.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05922-3_hi1PZjW9CY-1593471660778-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05922-3_hi1PZjW9CY-1593471660778-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05922-3_hi1PZjW9CY-1593471660778-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05922-3_hi1PZjW9CY-1593471660778-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05922-3_hi1PZjW9CY-1593471660778-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05922-3_hi1PZjW9CY-1593471660778-thumbnail.png	2	1	f	99100	1080	1080	1.00
280	P05921-3_9saiMvFRT-1593471661549-original-.png	P05921-3_9saiMvFRT.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05921-3_9saiMvFRT-1593471661549-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05921-3_9saiMvFRT-1593471661549-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05921-3_9saiMvFRT-1593471661549-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05921-3_9saiMvFRT-1593471661549-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05921-3_9saiMvFRT-1593471661549-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05921-3_9saiMvFRT-1593471661549-thumbnail.png	2	1	f	74175	945	945	1.00
281	P05923-3_05dVaRrBA-1593471661951-original-.png	P05923-3_05dVaRrBA.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05923-3_05dVaRrBA-1593471661951-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05923-3_05dVaRrBA-1593471661951-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05923-3_05dVaRrBA-1593471661951-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05923-3_05dVaRrBA-1593471661951-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05923-3_05dVaRrBA-1593471661951-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05923-3_05dVaRrBA-1593471661951-thumbnail.png	2	1	f	103752	945	945	1.00
282	P05926-3_dXJA2T7J84-1593471663149-original-.png	P05926-3_dXJA2T7J84.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05926-3_dXJA2T7J84-1593471663149-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05926-3_dXJA2T7J84-1593471663149-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05926-3_dXJA2T7J84-1593471663149-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05926-3_dXJA2T7J84-1593471663149-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05926-3_dXJA2T7J84-1593471663149-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05926-3_dXJA2T7J84-1593471663149-thumbnail.png	2	1	f	42002	945	945	1.00
404	3299945_jnHwaSYNt-1593471711156-original-.png	3299945_jnHwaSYNt.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/3299945_jnHwaSYNt-1593471711156-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/3299945_jnHwaSYNt-1593471711156-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/3299945_jnHwaSYNt-1593471711156-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/3299945_jnHwaSYNt-1593471711156-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/3299945_jnHwaSYNt-1593471711156-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/3299945_jnHwaSYNt-1593471711156-thumbnail.png	1	0	f	38332	1080	1080	1.00
417	brinco_cactus_anzol_szfTGOePa-1593471715553-original-.jpg	brinco_cactus_anzol_szfTGOePa.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/brinco_cactus_anzol_szfTGOePa-1593471715553-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/brinco_cactus_anzol_szfTGOePa-1593471715553-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/brinco_cactus_anzol_szfTGOePa-1593471715553-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/brinco_cactus_anzol_szfTGOePa-1593471715553-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/brinco_cactus_anzol_szfTGOePa-1593471715553-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/brinco_cactus_anzol_szfTGOePa-1593471715553-thumbnail.jpg	2	1	f	20886	1080	1080	1.00
423	IMG_7618_E_IXKR880-1593471717959-original-.jpg	IMG_7618_E_IXKR880.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7618_E_IXKR880-1593471717959-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7618_E_IXKR880-1593471717959-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7618_E_IXKR880-1593471717959-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7618_E_IXKR880-1593471717959-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7618_E_IXKR880-1593471717959-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7618_E_IXKR880-1593471717959-thumbnail.jpg	2	1	f	128424	720	1080	0.67
283	P05928-3_FqohYOCbA-1593471662756-original-.png	P05928-3_FqohYOCbA.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05928-3_FqohYOCbA-1593471662756-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05928-3_FqohYOCbA-1593471662756-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05928-3_FqohYOCbA-1593471662756-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05928-3_FqohYOCbA-1593471662756-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05928-3_FqohYOCbA-1593471662756-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05928-3_FqohYOCbA-1593471662756-thumbnail.png	2	1	f	60194	945	945	1.00
284	P05925-3_1GyaCV8yP-1593471662355-original-.png	P05925-3_1GyaCV8yP.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05925-3_1GyaCV8yP-1593471662355-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05925-3_1GyaCV8yP-1593471662355-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05925-3_1GyaCV8yP-1593471662355-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05925-3_1GyaCV8yP-1593471662355-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05925-3_1GyaCV8yP-1593471662355-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05925-3_1GyaCV8yP-1593471662355-thumbnail.png	2	1	f	89493	1080	1080	1.00
292	P05937-3__65vAqaMh-1593471666353-original-.png	P05937-3__65vAqaMh.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05937-3__65vAqaMh-1593471666353-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05937-3__65vAqaMh-1593471666353-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05937-3__65vAqaMh-1593471666353-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05937-3__65vAqaMh-1593471666353-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05937-3__65vAqaMh-1593471666353-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05937-3__65vAqaMh-1593471666353-thumbnail.png	2	1	f	39845	945	945	1.00
294	P05938-3_ccuFOpSgAJ-1593471667159-original-.png	P05938-3_ccuFOpSgAJ.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05938-3_ccuFOpSgAJ-1593471667159-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05938-3_ccuFOpSgAJ-1593471667159-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05938-3_ccuFOpSgAJ-1593471667159-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05938-3_ccuFOpSgAJ-1593471667159-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05938-3_ccuFOpSgAJ-1593471667159-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05938-3_ccuFOpSgAJ-1593471667159-thumbnail.png	2	1	f	34932	945	945	1.00
295	P05942-3_UGmvHRcAD-1593471667555-original-.png	P05942-3_UGmvHRcAD.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05942-3_UGmvHRcAD-1593471667555-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05942-3_UGmvHRcAD-1593471667555-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05942-3_UGmvHRcAD-1593471667555-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05942-3_UGmvHRcAD-1593471667555-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05942-3_UGmvHRcAD-1593471667555-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05942-3_UGmvHRcAD-1593471667555-thumbnail.png	2	1	f	29905	945	945	1.00
296	P05933-3_mEl--JjX3T-1593471664750-original-.png	P05933-3_mEl--JjX3T.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05933-3_mEl--JjX3T-1593471664750-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05933-3_mEl--JjX3T-1593471664750-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05933-3_mEl--JjX3T-1593471664750-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05933-3_mEl--JjX3T-1593471664750-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05933-3_mEl--JjX3T-1593471664750-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05933-3_mEl--JjX3T-1593471664750-thumbnail.png	2	1	f	63982	945	945	1.00
297	PU5943-3_X8iaimTspQ-1593471667959-original-.png	PU5943-3_X8iaimTspQ.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PU5943-3_X8iaimTspQ-1593471667959-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PU5943-3_X8iaimTspQ-1593471667959-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PU5943-3_X8iaimTspQ-1593471667959-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PU5943-3_X8iaimTspQ-1593471667959-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PU5943-3_X8iaimTspQ-1593471667959-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PU5943-3_X8iaimTspQ-1593471667959-thumbnail.png	2	1	f	92517	1080	1080	1.00
298	PU5909-3_ymTkYyHrv-1593471668352-original-.png	PU5909-3_ymTkYyHrv.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PU5909-3_ymTkYyHrv-1593471668352-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PU5909-3_ymTkYyHrv-1593471668352-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PU5909-3_ymTkYyHrv-1593471668352-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PU5909-3_ymTkYyHrv-1593471668352-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PU5909-3_ymTkYyHrv-1593471668352-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PU5909-3_ymTkYyHrv-1593471668352-thumbnail.png	2	1	f	85866	1080	1080	1.00
406	PP1591_hjcBtF9Ue-1593471711558-original-.png	PP1591_hjcBtF9Ue.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP1591_hjcBtF9Ue-1593471711558-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP1591_hjcBtF9Ue-1593471711558-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP1591_hjcBtF9Ue-1593471711558-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP1591_hjcBtF9Ue-1593471711558-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP1591_hjcBtF9Ue-1593471711558-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP1591_hjcBtF9Ue-1593471711558-thumbnail.png	1	0	f	34023	1080	1079	1.00
293	P05939-3_gKYWIpEhF-1593471666753-original-.png	P05939-3_gKYWIpEhF.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05939-3_gKYWIpEhF-1593471666753-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05939-3_gKYWIpEhF-1593471666753-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05939-3_gKYWIpEhF-1593471666753-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05939-3_gKYWIpEhF-1593471666753-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05939-3_gKYWIpEhF-1593471666753-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05939-3_gKYWIpEhF-1593471666753-thumbnail.png	2	1	f	44418	945	945	1.00
407	PP15904_f4SaP8vgD-1593471711959-original-.png	PP15904_f4SaP8vgD.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP15904_f4SaP8vgD-1593471711959-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP15904_f4SaP8vgD-1593471711959-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP15904_f4SaP8vgD-1593471711959-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP15904_f4SaP8vgD-1593471711959-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP15904_f4SaP8vgD-1593471711959-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP15904_f4SaP8vgD-1593471711959-thumbnail.png	1	0	f	23525	1080	1080	1.00
408	PP1597_BHyamAyTa-1593471712355-original-.png	PP1597_BHyamAyTa.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP1597_BHyamAyTa-1593471712355-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP1597_BHyamAyTa-1593471712355-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP1597_BHyamAyTa-1593471712355-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP1597_BHyamAyTa-1593471712355-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP1597_BHyamAyTa-1593471712355-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/PP1597_BHyamAyTa-1593471712355-thumbnail.png	1	0	f	21757	1080	1080	1.00
409	IMG_7662_XaC90Nv0vS-1593471712756-original-.jpg	IMG_7662_XaC90Nv0vS.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7662_XaC90Nv0vS-1593471712756-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7662_XaC90Nv0vS-1593471712756-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7662_XaC90Nv0vS-1593471712756-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7662_XaC90Nv0vS-1593471712756-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7662_XaC90Nv0vS-1593471712756-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7662_XaC90Nv0vS-1593471712756-thumbnail.jpg	1	0	f	27926	1080	720	1.50
410	IMG_7661_2YogtdFGd-1593471713156-original-.jpg	IMG_7661_2YogtdFGd.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7661_2YogtdFGd-1593471713156-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7661_2YogtdFGd-1593471713156-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7661_2YogtdFGd-1593471713156-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7661_2YogtdFGd-1593471713156-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7661_2YogtdFGd-1593471713156-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7661_2YogtdFGd-1593471713156-thumbnail.jpg	1	0	f	28452	1080	720	1.50
411	IMG_7659_BC_aIRLiP-1593471713554-original-.jpg	IMG_7659_BC_aIRLiP.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7659_BC_aIRLiP-1593471713554-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7659_BC_aIRLiP-1593471713554-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7659_BC_aIRLiP-1593471713554-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7659_BC_aIRLiP-1593471713554-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7659_BC_aIRLiP-1593471713554-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7659_BC_aIRLiP-1593471713554-thumbnail.jpg	1	0	f	28835	1080	720	1.50
412	IMG_7657_qdHqZq5Rr-1593471713953-original-.jpg	IMG_7657_qdHqZq5Rr.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7657_qdHqZq5Rr-1593471713953-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7657_qdHqZq5Rr-1593471713953-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7657_qdHqZq5Rr-1593471713953-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7657_qdHqZq5Rr-1593471713953-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7657_qdHqZq5Rr-1593471713953-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7657_qdHqZq5Rr-1593471713953-thumbnail.jpg	1	0	f	27925	1080	720	1.50
413	IMG_7658_LeZvSg3ura-1593471714380-original-.jpg	IMG_7658_LeZvSg3ura.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7658_LeZvSg3ura-1593471714380-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7658_LeZvSg3ura-1593471714380-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7658_LeZvSg3ura-1593471714380-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7658_LeZvSg3ura-1593471714380-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7658_LeZvSg3ura-1593471714380-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7658_LeZvSg3ura-1593471714380-thumbnail.jpg	1	0	f	31500	1080	720	1.50
299	P05940-3_Tl5uc_Z79-1593471668752-original-.png	P05940-3_Tl5uc_Z79.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05940-3_Tl5uc_Z79-1593471668752-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05940-3_Tl5uc_Z79-1593471668752-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05940-3_Tl5uc_Z79-1593471668752-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05940-3_Tl5uc_Z79-1593471668752-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05940-3_Tl5uc_Z79-1593471668752-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05940-3_Tl5uc_Z79-1593471668752-thumbnail.png	2	1	f	88067	945	945	1.00
300	P05941-3_3_hKKNzu7-1593471669153-original-.png	P05941-3_3_hKKNzu7.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05941-3_3_hKKNzu7-1593471669153-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05941-3_3_hKKNzu7-1593471669153-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05941-3_3_hKKNzu7-1593471669153-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05941-3_3_hKKNzu7-1593471669153-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05941-3_3_hKKNzu7-1593471669153-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05941-3_3_hKKNzu7-1593471669153-thumbnail.png	2	1	f	64020	945	945	1.00
301	P05934-3_aWXGrjstv-1593471669591-original-.png	P05934-3_aWXGrjstv.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05934-3_aWXGrjstv-1593471669591-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05934-3_aWXGrjstv-1593471669591-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05934-3_aWXGrjstv-1593471669591-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05934-3_aWXGrjstv-1593471669591-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05934-3_aWXGrjstv-1593471669591-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05934-3_aWXGrjstv-1593471669591-thumbnail.png	2	1	f	43895	945	945	1.00
302	4104_-_Chav_ECOBag_FK011_R_-_verso_a6NUjtVKuO-1593471669951-original-.jpg	4104_-_Chav_ECOBag_FK011_R_-_verso_a6NUjtVKuO.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_verso_a6NUjtVKuO-1593471669951-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_verso_a6NUjtVKuO-1593471669951-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_verso_a6NUjtVKuO-1593471669951-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_verso_a6NUjtVKuO-1593471669951-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_verso_a6NUjtVKuO-1593471669951-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_verso_a6NUjtVKuO-1593471669951-thumbnail.jpg	2	1	f	97381	864	1080	0.80
323	4094_-_Necessaire_BEG_FK011_R_ZZTzrr2ZZ-1593471679159-original-.jpg	4094_-_Necessaire_BEG_FK011_R_ZZTzrr2ZZ.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4094_-_Necessaire_BEG_FK011_R_ZZTzrr2ZZ-1593471679159-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4094_-_Necessaire_BEG_FK011_R_ZZTzrr2ZZ-1593471679159-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4094_-_Necessaire_BEG_FK011_R_ZZTzrr2ZZ-1593471679159-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4094_-_Necessaire_BEG_FK011_R_ZZTzrr2ZZ-1593471679159-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4094_-_Necessaire_BEG_FK011_R_ZZTzrr2ZZ-1593471679159-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4094_-_Necessaire_BEG_FK011_R_ZZTzrr2ZZ-1593471679159-thumbnail.jpg	2	1	f	95660	1080	701	1.54
324	4092_-_Necessaire_E100_FK011_-_verso_E-K4Q-LmC-1593471679555-original-.jpg	4092_-_Necessaire_E100_FK011_-_verso_E-K4Q-LmC.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_verso_E-K4Q-LmC-1593471679555-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_verso_E-K4Q-LmC-1593471679555-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_verso_E-K4Q-LmC-1593471679555-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_verso_E-K4Q-LmC-1593471679555-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_verso_E-K4Q-LmC-1593471679555-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_verso_E-K4Q-LmC-1593471679555-thumbnail.jpg	2	1	f	100219	778	1080	0.72
414	IMG_7642_l6FuJVqLB-1593471715959-original-.jpg	IMG_7642_l6FuJVqLB.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7642_l6FuJVqLB-1593471715959-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7642_l6FuJVqLB-1593471715959-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7642_l6FuJVqLB-1593471715959-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7642_l6FuJVqLB-1593471715959-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7642_l6FuJVqLB-1593471715959-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7642_l6FuJVqLB-1593471715959-thumbnail.jpg	2	1	f	52217	1080	720	1.50
303	4104_-_Chav_ECOBag_FK011_R_-_dentro_Q00vnucj0-1593471670360-original-.jpg	4104_-_Chav_ECOBag_FK011_R_-_dentro_Q00vnucj0.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_dentro_Q00vnucj0-1593471670360-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_dentro_Q00vnucj0-1593471670360-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_dentro_Q00vnucj0-1593471670360-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_dentro_Q00vnucj0-1593471670360-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_dentro_Q00vnucj0-1593471670360-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_dentro_Q00vnucj0-1593471670360-thumbnail.jpg	2	1	f	85105	949	1080	0.88
304	4104_-_Chav_ECOBag_FK011_R_-_frente__ZTTDxSBf-1593471670755-original-.jpg	4104_-_Chav_ECOBag_FK011_R_-_frente__ZTTDxSBf.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_frente__ZTTDxSBf-1593471670755-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_frente__ZTTDxSBf-1593471670755-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_frente__ZTTDxSBf-1593471670755-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_frente__ZTTDxSBf-1593471670755-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_frente__ZTTDxSBf-1593471670755-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4104_-_Chav_ECOBag_FK011_R_-_frente__ZTTDxSBf-1593471670755-thumbnail.jpg	2	1	f	73899	810	1080	0.75
305	4103_-_Chav_F_FK011_-_verso_2E3cMa1din-1593471671550-original-.jpg	4103_-_Chav_F_FK011_-_verso_2E3cMa1din.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4103_-_Chav_F_FK011_-_verso_2E3cMa1din-1593471671550-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4103_-_Chav_F_FK011_-_verso_2E3cMa1din-1593471671550-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4103_-_Chav_F_FK011_-_verso_2E3cMa1din-1593471671550-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4103_-_Chav_F_FK011_-_verso_2E3cMa1din-1593471671550-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4103_-_Chav_F_FK011_-_verso_2E3cMa1din-1593471671550-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4103_-_Chav_F_FK011_-_verso_2E3cMa1din-1593471671550-thumbnail.jpg	2	1	f	43508	642	1080	0.59
306	4099_-_Bolsa_Saco_FK1011_R_-_verso_fmHi0ODw7-1593471671158-original-.jpg	4099_-_Bolsa_Saco_FK1011_R_-_verso_fmHi0ODw7.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_verso_fmHi0ODw7-1593471671158-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_verso_fmHi0ODw7-1593471671158-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_verso_fmHi0ODw7-1593471671158-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_verso_fmHi0ODw7-1593471671158-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_verso_fmHi0ODw7-1593471671158-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_verso_fmHi0ODw7-1593471671158-thumbnail.jpg	2	1	f	95718	1080	1001	1.08
307	4103_-_Chav_F_FK011_-_frente_ULUTtB3VW-1593471672379-original-.jpg	4103_-_Chav_F_FK011_-_frente_ULUTtB3VW.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4103_-_Chav_F_FK011_-_frente_ULUTtB3VW-1593471672379-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4103_-_Chav_F_FK011_-_frente_ULUTtB3VW-1593471672379-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4103_-_Chav_F_FK011_-_frente_ULUTtB3VW-1593471672379-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4103_-_Chav_F_FK011_-_frente_ULUTtB3VW-1593471672379-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4103_-_Chav_F_FK011_-_frente_ULUTtB3VW-1593471672379-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4103_-_Chav_F_FK011_-_frente_ULUTtB3VW-1593471672379-thumbnail.jpg	2	1	f	49521	619	1080	0.57
415	IMG_7637_bJXccZYEx-1593471716352-original-.jpg	IMG_7637_bJXccZYEx.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7637_bJXccZYEx-1593471716352-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7637_bJXccZYEx-1593471716352-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7637_bJXccZYEx-1593471716352-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7637_bJXccZYEx-1593471716352-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7637_bJXccZYEx-1593471716352-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7637_bJXccZYEx-1593471716352-thumbnail.jpg	2	3	f	59268	1080	720	1.50
418	IMG_7638_jodAFw9D-c-1593471716760-original-.jpg	IMG_7638_jodAFw9D-c.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7638_jodAFw9D-c-1593471716760-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7638_jodAFw9D-c-1593471716760-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7638_jodAFw9D-c-1593471716760-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7638_jodAFw9D-c-1593471716760-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7638_jodAFw9D-c-1593471716760-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7638_jodAFw9D-c-1593471716760-thumbnail.jpg	2	2	f	66394	1080	720	1.50
308	4099_-_Bolsa_Saco_FK1011_R_-_frente_u6SEyeffy-1593471671958-original-.jpg	4099_-_Bolsa_Saco_FK1011_R_-_frente_u6SEyeffy.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_frente_u6SEyeffy-1593471671958-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_frente_u6SEyeffy-1593471671958-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_frente_u6SEyeffy-1593471671958-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_frente_u6SEyeffy-1593471671958-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_frente_u6SEyeffy-1593471671958-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_frente_u6SEyeffy-1593471671958-thumbnail.jpg	2	1	f	94011	1079	1080	1.00
309	4099_-_Bolsa_Saco_FK1011_R_-_lateral_QDDfGH_Qx-1593471672758-original-.jpg	4099_-_Bolsa_Saco_FK1011_R_-_lateral_QDDfGH_Qx.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_lateral_QDDfGH_Qx-1593471672758-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_lateral_QDDfGH_Qx-1593471672758-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_lateral_QDDfGH_Qx-1593471672758-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_lateral_QDDfGH_Qx-1593471672758-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_lateral_QDDfGH_Qx-1593471672758-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4099_-_Bolsa_Saco_FK1011_R_-_lateral_QDDfGH_Qx-1593471672758-thumbnail.jpg	2	1	f	69872	644	1080	0.60
310	4098_-_Bolsa_T_rmica_G_FK011_-_verso_f8bONspL_-1593471673153-original-.jpg	4098_-_Bolsa_T_rmica_G_FK011_-_verso_f8bONspL_.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_verso_f8bONspL_-1593471673153-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_verso_f8bONspL_-1593471673153-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_verso_f8bONspL_-1593471673153-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_verso_f8bONspL_-1593471673153-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_verso_f8bONspL_-1593471673153-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_verso_f8bONspL_-1593471673153-thumbnail.jpg	2	1	f	116138	1017	1080	0.94
311	4098_-_Bolsa_T_rmica_G_FK011_-_lateral_4XMxde0zP-1593471673555-original-.jpg	4098_-_Bolsa_T_rmica_G_FK011_-_lateral_4XMxde0zP.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_lateral_4XMxde0zP-1593471673555-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_lateral_4XMxde0zP-1593471673555-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_lateral_4XMxde0zP-1593471673555-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_lateral_4XMxde0zP-1593471673555-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_lateral_4XMxde0zP-1593471673555-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_lateral_4XMxde0zP-1593471673555-thumbnail.jpg	2	1	f	113793	1080	981	1.10
312	4098_-_Bolsa_T_rmica_G_FK011_-_frente_rdMwuacu4-1593471673957-original-.jpg	4098_-_Bolsa_T_rmica_G_FK011_-_frente_rdMwuacu4.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_frente_rdMwuacu4-1593471673957-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_frente_rdMwuacu4-1593471673957-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_frente_rdMwuacu4-1593471673957-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_frente_rdMwuacu4-1593471673957-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_frente_rdMwuacu4-1593471673957-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_frente_rdMwuacu4-1593471673957-thumbnail.jpg	2	1	f	103072	1080	1078	1.00
419	IMG_7653_4l3lGrVwgm-1593471714789-original-.jpg	IMG_7653_4l3lGrVwgm.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7653_4l3lGrVwgm-1593471714789-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7653_4l3lGrVwgm-1593471714789-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7653_4l3lGrVwgm-1593471714789-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7653_4l3lGrVwgm-1593471714789-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7653_4l3lGrVwgm-1593471714789-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7653_4l3lGrVwgm-1593471714789-thumbnail.jpg	1	0	f	29303	1080	720	1.50
420	IMG_7626_KYye4xmVu-1593471717158-original-.jpg	IMG_7626_KYye4xmVu.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7626_KYye4xmVu-1593471717158-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7626_KYye4xmVu-1593471717158-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7626_KYye4xmVu-1593471717158-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7626_KYye4xmVu-1593471717158-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7626_KYye4xmVu-1593471717158-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7626_KYye4xmVu-1593471717158-thumbnail.jpg	1	0	f	56977	1080	721	1.50
313	4097_-_Bolsa_T_rmica_PFK011_-_lateral_7Xfm2_3Fv-1593471674360-original-.jpg	4097_-_Bolsa_T_rmica_PFK011_-_lateral_7Xfm2_3Fv.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_lateral_7Xfm2_3Fv-1593471674360-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_lateral_7Xfm2_3Fv-1593471674360-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_lateral_7Xfm2_3Fv-1593471674360-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_lateral_7Xfm2_3Fv-1593471674360-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_lateral_7Xfm2_3Fv-1593471674360-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_lateral_7Xfm2_3Fv-1593471674360-thumbnail.jpg	2	1	f	131763	1080	983	1.10
314	4097_-_Bolsa_T_rmica_PFK011_-_frente_9fY-YCBUb-1593471675159-original-.jpg	4097_-_Bolsa_T_rmica_PFK011_-_frente_9fY-YCBUb.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_frente_9fY-YCBUb-1593471675159-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_frente_9fY-YCBUb-1593471675159-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_frente_9fY-YCBUb-1593471675159-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_frente_9fY-YCBUb-1593471675159-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_frente_9fY-YCBUb-1593471675159-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_frente_9fY-YCBUb-1593471675159-thumbnail.jpg	2	1	f	96550	906	1080	0.84
315	4098_-_Bolsa_T_rmica_G_FK011_-_cima_g4IeV8u6C-1593471674754-original-.jpg	4098_-_Bolsa_T_rmica_G_FK011_-_cima_g4IeV8u6C.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_cima_g4IeV8u6C-1593471674754-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_cima_g4IeV8u6C-1593471674754-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_cima_g4IeV8u6C-1593471674754-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_cima_g4IeV8u6C-1593471674754-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_cima_g4IeV8u6C-1593471674754-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4098_-_Bolsa_T_rmica_G_FK011_-_cima_g4IeV8u6C-1593471674754-thumbnail.jpg	2	1	f	119308	1080	811	1.33
316	4096_-_Bolsa_Sacola_FK011_-_verso_ZTrsBJZDv-1593471675950-original-.jpg	4096_-_Bolsa_Sacola_FK011_-_verso_ZTrsBJZDv.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_verso_ZTrsBJZDv-1593471675950-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_verso_ZTrsBJZDv-1593471675950-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_verso_ZTrsBJZDv-1593471675950-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_verso_ZTrsBJZDv-1593471675950-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_verso_ZTrsBJZDv-1593471675950-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_verso_ZTrsBJZDv-1593471675950-thumbnail.jpg	2	1	f	92759	694	1080	0.64
317	4097_-_Bolsa_T_rmica_PFK011_-_cima_GcXbQRzby-1593471675561-original-.jpg	4097_-_Bolsa_T_rmica_PFK011_-_cima_GcXbQRzby.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_cima_GcXbQRzby-1593471675561-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_cima_GcXbQRzby-1593471675561-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_cima_GcXbQRzby-1593471675561-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_cima_GcXbQRzby-1593471675561-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_cima_GcXbQRzby-1593471675561-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4097_-_Bolsa_T_rmica_PFK011_-_cima_GcXbQRzby-1593471675561-thumbnail.jpg	2	1	f	136332	1080	998	1.08
421	IMG_7636_0KsxGMIBs-1593471717559-original-.jpg	IMG_7636_0KsxGMIBs.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7636_0KsxGMIBs-1593471717559-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7636_0KsxGMIBs-1593471717559-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7636_0KsxGMIBs-1593471717559-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7636_0KsxGMIBs-1593471717559-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7636_0KsxGMIBs-1593471717559-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7636_0KsxGMIBs-1593471717559-thumbnail.jpg	2	3	f	57917	1080	719	1.50
422	IMG_7616_MOuzsaulv5-1593471718357-original-.jpg	IMG_7616_MOuzsaulv5.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7616_MOuzsaulv5-1593471718357-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7616_MOuzsaulv5-1593471718357-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7616_MOuzsaulv5-1593471718357-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7616_MOuzsaulv5-1593471718357-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7616_MOuzsaulv5-1593471718357-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7616_MOuzsaulv5-1593471718357-thumbnail.jpg	2	1	f	106419	720	1080	0.67
318	4096_-_Bolsa_Sacola_FK011_-_lateral2_QdcJDqf3G-1593471676353-original-.jpg	4096_-_Bolsa_Sacola_FK011_-_lateral2_QdcJDqf3G.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_lateral2_QdcJDqf3G-1593471676353-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_lateral2_QdcJDqf3G-1593471676353-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_lateral2_QdcJDqf3G-1593471676353-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_lateral2_QdcJDqf3G-1593471676353-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_lateral2_QdcJDqf3G-1593471676353-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_lateral2_QdcJDqf3G-1593471676353-thumbnail.jpg	2	1	f	75101	611	1080	0.57
319	4096_-_Bolsa_Sacola_FK011_-_lateral1_cI9c3cj64-1593471676756-original-.jpg	4096_-_Bolsa_Sacola_FK011_-_lateral1_cI9c3cj64.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_lateral1_cI9c3cj64-1593471676756-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_lateral1_cI9c3cj64-1593471676756-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_lateral1_cI9c3cj64-1593471676756-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_lateral1_cI9c3cj64-1593471676756-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_lateral1_cI9c3cj64-1593471676756-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_lateral1_cI9c3cj64-1593471676756-thumbnail.jpg	2	1	f	65467	603	1080	0.56
320	4096_-_Bolsa_Sacola_FK011_-_frente_zxtKhrTL0-1593471677154-original-.jpg	4096_-_Bolsa_Sacola_FK011_-_frente_zxtKhrTL0.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_frente_zxtKhrTL0-1593471677154-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_frente_zxtKhrTL0-1593471677154-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_frente_zxtKhrTL0-1593471677154-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_frente_zxtKhrTL0-1593471677154-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_frente_zxtKhrTL0-1593471677154-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_frente_zxtKhrTL0-1593471677154-thumbnail.jpg	2	1	f	90505	662	1080	0.61
321	4093_-_Necessaire_BEG_FK011_PT_uEcnZpKog-1593471677958-original-.jpg	4093_-_Necessaire_BEG_FK011_PT_uEcnZpKog.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4093_-_Necessaire_BEG_FK011_PT_uEcnZpKog-1593471677958-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4093_-_Necessaire_BEG_FK011_PT_uEcnZpKog-1593471677958-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4093_-_Necessaire_BEG_FK011_PT_uEcnZpKog-1593471677958-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4093_-_Necessaire_BEG_FK011_PT_uEcnZpKog-1593471677958-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4093_-_Necessaire_BEG_FK011_PT_uEcnZpKog-1593471677958-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4093_-_Necessaire_BEG_FK011_PT_uEcnZpKog-1593471677958-thumbnail.jpg	2	1	f	111336	1080	738	1.46
322	4095_-_Bolsa_Trans_FK011_PT_-_verso_DrWm78iLzR-1593471678785-original-.jpg	4095_-_Bolsa_Trans_FK011_PT_-_verso_DrWm78iLzR.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4095_-_Bolsa_Trans_FK011_PT_-_verso_DrWm78iLzR-1593471678785-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4095_-_Bolsa_Trans_FK011_PT_-_verso_DrWm78iLzR-1593471678785-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4095_-_Bolsa_Trans_FK011_PT_-_verso_DrWm78iLzR-1593471678785-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4095_-_Bolsa_Trans_FK011_PT_-_verso_DrWm78iLzR-1593471678785-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4095_-_Bolsa_Trans_FK011_PT_-_verso_DrWm78iLzR-1593471678785-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4095_-_Bolsa_Trans_FK011_PT_-_verso_DrWm78iLzR-1593471678785-thumbnail.jpg	2	1	f	71487	724	1080	0.67
426	IMG_7599_-9BqcRVni-1593471719155-original-.jpg	IMG_7599_-9BqcRVni.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7599_-9BqcRVni-1593471719155-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7599_-9BqcRVni-1593471719155-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7599_-9BqcRVni-1593471719155-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7599_-9BqcRVni-1593471719155-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7599_-9BqcRVni-1593471719155-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7599_-9BqcRVni-1593471719155-thumbnail.jpg	2	1	f	57775	1080	720	1.50
427	p06474_flI8AwFdP-1593471721958-original-.jpg	p06474_flI8AwFdP.jpeg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06474_flI8AwFdP-1593471721958-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06474_flI8AwFdP-1593471721958-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06474_flI8AwFdP-1593471721958-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06474_flI8AwFdP-1593471721958-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06474_flI8AwFdP-1593471721958-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06474_flI8AwFdP-1593471721958-thumbnail.jpg	1	0	f	40588	1080	1080	1.00
325	4092_-_Necessaire_E100_FK011_-_frente_QCTYyNBH1-1593471679952-original-.jpg	4092_-_Necessaire_E100_FK011_-_frente_QCTYyNBH1.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_frente_QCTYyNBH1-1593471679952-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_frente_QCTYyNBH1-1593471679952-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_frente_QCTYyNBH1-1593471679952-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_frente_QCTYyNBH1-1593471679952-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_frente_QCTYyNBH1-1593471679952-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_frente_QCTYyNBH1-1593471679952-thumbnail.jpg	2	1	f	112682	796	1080	0.74
326	4092_-_Necessaire_E100_FK011_-_dentro2_2hlvVeM_1-1593471680758-original-.jpg	4092_-_Necessaire_E100_FK011_-_dentro2_2hlvVeM_1.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_dentro2_2hlvVeM_1-1593471680758-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_dentro2_2hlvVeM_1-1593471680758-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_dentro2_2hlvVeM_1-1593471680758-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_dentro2_2hlvVeM_1-1593471680758-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_dentro2_2hlvVeM_1-1593471680758-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_dentro2_2hlvVeM_1-1593471680758-thumbnail.jpg	2	1	f	95854	1060	1080	0.98
327	4096_-_Bolsa_Sacola_FK011_-_cima_tnLlZvRS9-1593471677554-original-.jpg	4096_-_Bolsa_Sacola_FK011_-_cima_tnLlZvRS9.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_cima_tnLlZvRS9-1593471677554-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_cima_tnLlZvRS9-1593471677554-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_cima_tnLlZvRS9-1593471677554-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_cima_tnLlZvRS9-1593471677554-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_cima_tnLlZvRS9-1593471677554-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4096_-_Bolsa_Sacola_FK011_-_cima_tnLlZvRS9-1593471677554-thumbnail.jpg	2	1	f	81571	1080	641	1.68
328	4095_-_Bolsa_Trans_FK011_PT_-_frente_xWaRDGUtA-1593471678353-original-.jpg	4095_-_Bolsa_Trans_FK011_PT_-_frente_xWaRDGUtA.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4095_-_Bolsa_Trans_FK011_PT_-_frente_xWaRDGUtA-1593471678353-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4095_-_Bolsa_Trans_FK011_PT_-_frente_xWaRDGUtA-1593471678353-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4095_-_Bolsa_Trans_FK011_PT_-_frente_xWaRDGUtA-1593471678353-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4095_-_Bolsa_Trans_FK011_PT_-_frente_xWaRDGUtA-1593471678353-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4095_-_Bolsa_Trans_FK011_PT_-_frente_xWaRDGUtA-1593471678353-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4095_-_Bolsa_Trans_FK011_PT_-_frente_xWaRDGUtA-1593471678353-thumbnail.jpg	2	1	f	88040	821	1080	0.76
329	4092_-_Necessaire_E100_FK011_-_fechado_frente_M1R-2I5Dg-1593471681156-original-.jpg	4092_-_Necessaire_E100_FK011_-_fechado_frente_M1R-2I5Dg.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_fechado_frente_M1R-2I5Dg-1593471681156-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_fechado_frente_M1R-2I5Dg-1593471681156-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_fechado_frente_M1R-2I5Dg-1593471681156-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_fechado_frente_M1R-2I5Dg-1593471681156-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_fechado_frente_M1R-2I5Dg-1593471681156-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_fechado_frente_M1R-2I5Dg-1593471681156-thumbnail.jpg	2	1	f	105803	1080	586	1.84
330	4091_-_Necessaire_Vivo_FK011_-_frente_MUjHiOIxa-1593471682354-original-.jpg	4091_-_Necessaire_Vivo_FK011_-_frente_MUjHiOIxa.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4091_-_Necessaire_Vivo_FK011_-_frente_MUjHiOIxa-1593471682354-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4091_-_Necessaire_Vivo_FK011_-_frente_MUjHiOIxa-1593471682354-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4091_-_Necessaire_Vivo_FK011_-_frente_MUjHiOIxa-1593471682354-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4091_-_Necessaire_Vivo_FK011_-_frente_MUjHiOIxa-1593471682354-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4091_-_Necessaire_Vivo_FK011_-_frente_MUjHiOIxa-1593471682354-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4091_-_Necessaire_Vivo_FK011_-_frente_MUjHiOIxa-1593471682354-thumbnail.jpg	2	1	f	79708	1080	583	1.85
428	p06501_IZIhe1DZk-1593471721555-original-.jpg	p06501_IZIhe1DZk.jpeg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06501_IZIhe1DZk-1593471721555-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06501_IZIhe1DZk-1593471721555-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06501_IZIhe1DZk-1593471721555-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06501_IZIhe1DZk-1593471721555-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06501_IZIhe1DZk-1593471721555-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06501_IZIhe1DZk-1593471721555-thumbnail.jpg	2	1	f	39209	1080	1080	1.00
331	4091_-_Necessaire_Vivo_FK011_-_lateral_ivwZOytV5-1593471681963-original-.jpg	4091_-_Necessaire_Vivo_FK011_-_lateral_ivwZOytV5.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4091_-_Necessaire_Vivo_FK011_-_lateral_ivwZOytV5-1593471681963-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4091_-_Necessaire_Vivo_FK011_-_lateral_ivwZOytV5-1593471681963-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4091_-_Necessaire_Vivo_FK011_-_lateral_ivwZOytV5-1593471681963-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4091_-_Necessaire_Vivo_FK011_-_lateral_ivwZOytV5-1593471681963-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4091_-_Necessaire_Vivo_FK011_-_lateral_ivwZOytV5-1593471681963-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4091_-_Necessaire_Vivo_FK011_-_lateral_ivwZOytV5-1593471681963-thumbnail.jpg	2	1	f	106315	1080	848	1.27
332	4089_-_Necessaire_GR_FK011_PT_-_frente_AlwuqkYYd-1593471682759-original-.jpg	4089_-_Necessaire_GR_FK011_PT_-_frente_AlwuqkYYd.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4089_-_Necessaire_GR_FK011_PT_-_frente_AlwuqkYYd-1593471682759-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4089_-_Necessaire_GR_FK011_PT_-_frente_AlwuqkYYd-1593471682759-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4089_-_Necessaire_GR_FK011_PT_-_frente_AlwuqkYYd-1593471682759-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4089_-_Necessaire_GR_FK011_PT_-_frente_AlwuqkYYd-1593471682759-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4089_-_Necessaire_GR_FK011_PT_-_frente_AlwuqkYYd-1593471682759-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4089_-_Necessaire_GR_FK011_PT_-_frente_AlwuqkYYd-1593471682759-thumbnail.jpg	2	1	f	70207	1080	537	2.01
333	4085_-_Carteira_GR_FK011_PT_7mfUTu8qo-1593471683552-original-.jpg	4085_-_Carteira_GR_FK011_PT_7mfUTu8qo.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4085_-_Carteira_GR_FK011_PT_7mfUTu8qo-1593471683552-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4085_-_Carteira_GR_FK011_PT_7mfUTu8qo-1593471683552-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4085_-_Carteira_GR_FK011_PT_7mfUTu8qo-1593471683552-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4085_-_Carteira_GR_FK011_PT_7mfUTu8qo-1593471683552-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4085_-_Carteira_GR_FK011_PT_7mfUTu8qo-1593471683552-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4085_-_Carteira_GR_FK011_PT_7mfUTu8qo-1593471683552-thumbnail.jpg	2	1	f	73628	1080	591	1.83
334	4092_-_Necessaire_E100_FK011_-_dentro1_0qvfi9Y6o-1593471681558-original-.jpg	4092_-_Necessaire_E100_FK011_-_dentro1_0qvfi9Y6o.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_dentro1_0qvfi9Y6o-1593471681558-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_dentro1_0qvfi9Y6o-1593471681558-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_dentro1_0qvfi9Y6o-1593471681558-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_dentro1_0qvfi9Y6o-1593471681558-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_dentro1_0qvfi9Y6o-1593471681558-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_dentro1_0qvfi9Y6o-1593471681558-thumbnail.jpg	2	1	f	100932	1032	1080	0.96
335	4086_-_Carteira_Meg_FK011_R_yioe0i5cb-1593471683192-original-.jpg	4086_-_Carteira_Meg_FK011_R_yioe0i5cb.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4086_-_Carteira_Meg_FK011_R_yioe0i5cb-1593471683192-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4086_-_Carteira_Meg_FK011_R_yioe0i5cb-1593471683192-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4086_-_Carteira_Meg_FK011_R_yioe0i5cb-1593471683192-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4086_-_Carteira_Meg_FK011_R_yioe0i5cb-1593471683192-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4086_-_Carteira_Meg_FK011_R_yioe0i5cb-1593471683192-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4086_-_Carteira_Meg_FK011_R_yioe0i5cb-1593471683192-thumbnail.jpg	2	1	f	66474	1080	508	2.13
429	IMG_7451_37BVIuiqs-1593471719972-original-.jpg	IMG_7451_37BVIuiqs.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7451_37BVIuiqs-1593471719972-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7451_37BVIuiqs-1593471719972-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7451_37BVIuiqs-1593471719972-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7451_37BVIuiqs-1593471719972-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7451_37BVIuiqs-1593471719972-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7451_37BVIuiqs-1593471719972-thumbnail.jpg	2	5	f	76010	1080	720	1.50
433	p06491_GoyF1P4fB-1593471723553-original-.jpg	p06491_GoyF1P4fB.jpeg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06491_GoyF1P4fB-1593471723553-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06491_GoyF1P4fB-1593471723553-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06491_GoyF1P4fB-1593471723553-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06491_GoyF1P4fB-1593471723553-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06491_GoyF1P4fB-1593471723553-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06491_GoyF1P4fB-1593471723553-thumbnail.jpg	2	1	f	35201	1080	1080	1.00
336	4090_-_Necessaire_Peq_FK011_R_-_Lateral_Qak0_dEUb-1593471683959-original-.jpg	4090_-_Necessaire_Peq_FK011_R_-_Lateral_Qak0_dEUb.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4090_-_Necessaire_Peq_FK011_R_-_Lateral_Qak0_dEUb-1593471683959-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4090_-_Necessaire_Peq_FK011_R_-_Lateral_Qak0_dEUb-1593471683959-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4090_-_Necessaire_Peq_FK011_R_-_Lateral_Qak0_dEUb-1593471683959-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4090_-_Necessaire_Peq_FK011_R_-_Lateral_Qak0_dEUb-1593471683959-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4090_-_Necessaire_Peq_FK011_R_-_Lateral_Qak0_dEUb-1593471683959-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4090_-_Necessaire_Peq_FK011_R_-_Lateral_Qak0_dEUb-1593471683959-thumbnail.jpg	2	1	f	82075	1080	759	1.42
337	4088_-_Porta_Niq_FK011_R_Ow4J1bzBV-1593471684358-original-.jpg	4088_-_Porta_Niq_FK011_R_Ow4J1bzBV.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4088_-_Porta_Niq_FK011_R_Ow4J1bzBV-1593471684358-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4088_-_Porta_Niq_FK011_R_Ow4J1bzBV-1593471684358-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4088_-_Porta_Niq_FK011_R_Ow4J1bzBV-1593471684358-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4088_-_Porta_Niq_FK011_R_Ow4J1bzBV-1593471684358-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4088_-_Porta_Niq_FK011_R_Ow4J1bzBV-1593471684358-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4088_-_Porta_Niq_FK011_R_Ow4J1bzBV-1593471684358-thumbnail.jpg	2	1	f	67589	1080	659	1.64
338	4084_-_Chav_ECOBag_FK010_AZ_-_frente_riJSEFJvg-1593471686762-original-.jpg	4084_-_Chav_ECOBag_FK010_AZ_-_frente_riJSEFJvg.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_frente_riJSEFJvg-1593471686762-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_frente_riJSEFJvg-1593471686762-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_frente_riJSEFJvg-1593471686762-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_frente_riJSEFJvg-1593471686762-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_frente_riJSEFJvg-1593471686762-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_frente_riJSEFJvg-1593471686762-thumbnail.jpg	2	1	f	140099	766	1080	0.71
339	4084_-_Chav_ECOBag_FK010_AZ_-_dentro_u90SeneO3-1593471687561-original-.jpg	4084_-_Chav_ECOBag_FK010_AZ_-_dentro_u90SeneO3.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_dentro_u90SeneO3-1593471687561-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_dentro_u90SeneO3-1593471687561-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_dentro_u90SeneO3-1593471687561-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_dentro_u90SeneO3-1593471687561-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_dentro_u90SeneO3-1593471687561-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_dentro_u90SeneO3-1593471687561-thumbnail.jpg	2	1	f	121696	987	1080	0.91
431	p06472_fqxwLGSjR-1593471723159-original-.jpg	p06472_fqxwLGSjR.jpeg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06472_fqxwLGSjR-1593471723159-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06472_fqxwLGSjR-1593471723159-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06472_fqxwLGSjR-1593471723159-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06472_fqxwLGSjR-1593471723159-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06472_fqxwLGSjR-1593471723159-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06472_fqxwLGSjR-1593471723159-thumbnail.jpg	2	1	f	33238	1080	1080	1.00
432	p03651_qYkuHUusk-1593471720788-original-.jpg	p03651_qYkuHUusk.jpeg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p03651_qYkuHUusk-1593471720788-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p03651_qYkuHUusk-1593471720788-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p03651_qYkuHUusk-1593471720788-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p03651_qYkuHUusk-1593471720788-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p03651_qYkuHUusk-1593471720788-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p03651_qYkuHUusk-1593471720788-thumbnail.jpg	2	1	f	14920	1080	1080	1.00
340	4080_-_Bolsa_T_rmica_FK010_AZ_-_verso_--JZOZMS4-1593471686357-original-.jpg	4080_-_Bolsa_T_rmica_FK010_AZ_-_verso_--JZOZMS4.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_verso_--JZOZMS4-1593471686357-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_verso_--JZOZMS4-1593471686357-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_verso_--JZOZMS4-1593471686357-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_verso_--JZOZMS4-1593471686357-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_verso_--JZOZMS4-1593471686357-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_verso_--JZOZMS4-1593471686357-thumbnail.jpg	2	1	f	227693	1080	1043	1.04
341	4092_-_Necessaire_E100_FK011_-_fechado_verso_wjZYh5sqPM-1593471680386-original-.jpg	4092_-_Necessaire_E100_FK011_-_fechado_verso_wjZYh5sqPM.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_fechado_verso_wjZYh5sqPM-1593471680386-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_fechado_verso_wjZYh5sqPM-1593471680386-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_fechado_verso_wjZYh5sqPM-1593471680386-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_fechado_verso_wjZYh5sqPM-1593471680386-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_fechado_verso_wjZYh5sqPM-1593471680386-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4092_-_Necessaire_E100_FK011_-_fechado_verso_wjZYh5sqPM-1593471680386-thumbnail.jpg	2	1	f	109134	1080	560	1.93
342	4080_-_Bolsa_T_rmica_FK010_AZ_-_lateral_qSJQhsBBGG-1593471687161-original-.jpg	4080_-_Bolsa_T_rmica_FK010_AZ_-_lateral_qSJQhsBBGG.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_lateral_qSJQhsBBGG-1593471687161-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_lateral_qSJQhsBBGG-1593471687161-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_lateral_qSJQhsBBGG-1593471687161-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_lateral_qSJQhsBBGG-1593471687161-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_lateral_qSJQhsBBGG-1593471687161-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_lateral_qSJQhsBBGG-1593471687161-thumbnail.jpg	2	1	f	162431	1080	952	1.13
343	4090_-_Necessaire_Peq_FK011_R_-_Frente_lWT-GkB0--1593471685557-original-.jpg	4090_-_Necessaire_Peq_FK011_R_-_Frente_lWT-GkB0-.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4090_-_Necessaire_Peq_FK011_R_-_Frente_lWT-GkB0--1593471685557-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4090_-_Necessaire_Peq_FK011_R_-_Frente_lWT-GkB0--1593471685557-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4090_-_Necessaire_Peq_FK011_R_-_Frente_lWT-GkB0--1593471685557-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4090_-_Necessaire_Peq_FK011_R_-_Frente_lWT-GkB0--1593471685557-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4090_-_Necessaire_Peq_FK011_R_-_Frente_lWT-GkB0--1593471685557-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4090_-_Necessaire_Peq_FK011_R_-_Frente_lWT-GkB0--1593471685557-thumbnail.jpg	2	1	f	55138	1080	489	2.21
349	4080_-_Bolsa_T_rmica_FK010_AZ_-_cima_koXFEfvKd-1593471688362-original-.jpg	4080_-_Bolsa_T_rmica_FK010_AZ_-_cima_koXFEfvKd.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_cima_koXFEfvKd-1593471688362-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_cima_koXFEfvKd-1593471688362-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_cima_koXFEfvKd-1593471688362-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_cima_koXFEfvKd-1593471688362-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_cima_koXFEfvKd-1593471688362-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_cima_koXFEfvKd-1593471688362-thumbnail.jpg	2	1	f	163587	1080	860	1.26
434	IMG_7426_wq70_846yJ-1593471722759-original-.jpg	IMG_7426_wq70_846yJ.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7426_wq70_846yJ-1593471722759-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7426_wq70_846yJ-1593471722759-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7426_wq70_846yJ-1593471722759-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7426_wq70_846yJ-1593471722759-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7426_wq70_846yJ-1593471722759-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7426_wq70_846yJ-1593471722759-thumbnail.jpg	2	8	f	92843	1080	720	1.50
435	IMG_7463_zNUHeaxbl-1593471722396-original-.jpg	IMG_7463_zNUHeaxbl.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7463_zNUHeaxbl-1593471722396-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7463_zNUHeaxbl-1593471722396-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7463_zNUHeaxbl-1593471722396-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7463_zNUHeaxbl-1593471722396-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7463_zNUHeaxbl-1593471722396-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7463_zNUHeaxbl-1593471722396-thumbnail.jpg	1	0	f	142594	1080	720	1.50
344	4089_-_Necessaire_GR_FK011_PT_-_lateral_scSedM2Mqt-1593471684750-original-.jpg	4089_-_Necessaire_GR_FK011_PT_-_lateral_scSedM2Mqt.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4089_-_Necessaire_GR_FK011_PT_-_lateral_scSedM2Mqt-1593471684750-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4089_-_Necessaire_GR_FK011_PT_-_lateral_scSedM2Mqt-1593471684750-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4089_-_Necessaire_GR_FK011_PT_-_lateral_scSedM2Mqt-1593471684750-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4089_-_Necessaire_GR_FK011_PT_-_lateral_scSedM2Mqt-1593471684750-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4089_-_Necessaire_GR_FK011_PT_-_lateral_scSedM2Mqt-1593471684750-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4089_-_Necessaire_GR_FK011_PT_-_lateral_scSedM2Mqt-1593471684750-thumbnail.jpg	2	1	f	89198	1080	837	1.29
345	4084_-_Chav_ECOBag_FK010_AZ_-_verso_-K-YeVTvw-1593471685960-original-.jpg	4084_-_Chav_ECOBag_FK010_AZ_-_verso_-K-YeVTvw.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_verso_-K-YeVTvw-1593471685960-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_verso_-K-YeVTvw-1593471685960-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_verso_-K-YeVTvw-1593471685960-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_verso_-K-YeVTvw-1593471685960-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_verso_-K-YeVTvw-1593471685960-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4084_-_Chav_ECOBag_FK010_AZ_-_verso_-K-YeVTvw-1593471685960-thumbnail.jpg	2	1	f	131254	772	1080	0.71
346	4080_-_Bolsa_T_rmica_FK010_AZ_-_frente_kAjocjtrz-1593471687972-original-.jpg	4080_-_Bolsa_T_rmica_FK010_AZ_-_frente_kAjocjtrz.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_frente_kAjocjtrz-1593471687972-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_frente_kAjocjtrz-1593471687972-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_frente_kAjocjtrz-1593471687972-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_frente_kAjocjtrz-1593471687972-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_frente_kAjocjtrz-1593471687972-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4080_-_Bolsa_T_rmica_FK010_AZ_-_frente_kAjocjtrz-1593471687972-thumbnail.jpg	2	1	f	211173	1065	1080	0.99
347	4079_-_Bolsa_Sacola_FK010_-_verso__0d-57-4m-1593471688758-original-.jpg	4079_-_Bolsa_Sacola_FK010_-_verso__0d-57-4m.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_verso__0d-57-4m-1593471688758-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_verso__0d-57-4m-1593471688758-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_verso__0d-57-4m-1593471688758-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_verso__0d-57-4m-1593471688758-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_verso__0d-57-4m-1593471688758-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_verso__0d-57-4m-1593471688758-thumbnail.jpg	2	1	f	133264	740	1080	0.69
348	4087_-_Porta_Niq_FK011_PT_TaPky3uwe-1593471685187-original-.jpg	4087_-_Porta_Niq_FK011_PT_TaPky3uwe.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4087_-_Porta_Niq_FK011_PT_TaPky3uwe-1593471685187-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4087_-_Porta_Niq_FK011_PT_TaPky3uwe-1593471685187-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4087_-_Porta_Niq_FK011_PT_TaPky3uwe-1593471685187-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4087_-_Porta_Niq_FK011_PT_TaPky3uwe-1593471685187-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4087_-_Porta_Niq_FK011_PT_TaPky3uwe-1593471685187-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4087_-_Porta_Niq_FK011_PT_TaPky3uwe-1593471685187-thumbnail.jpg	2	1	f	78211	1080	682	1.58
436	RX919_2_aZEZiVJOs-1593471724357-original-.jpg	RX919_2_aZEZiVJOs.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_2_aZEZiVJOs-1593471724357-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_2_aZEZiVJOs-1593471724357-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_2_aZEZiVJOs-1593471724357-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_2_aZEZiVJOs-1593471724357-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_2_aZEZiVJOs-1593471724357-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_2_aZEZiVJOs-1593471724357-thumbnail.jpg	2	1	f	25399	408	612	0.67
437	11006PL006_1_pFI6afpSl_-1593471723956-original-.jpg	11006PL006_1_pFI6afpSl_.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/11006PL006_1_pFI6afpSl_-1593471723956-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/11006PL006_1_pFI6afpSl_-1593471723956-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/11006PL006_1_pFI6afpSl_-1593471723956-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/11006PL006_1_pFI6afpSl_-1593471723956-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/11006PL006_1_pFI6afpSl_-1593471723956-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/11006PL006_1_pFI6afpSl_-1593471723956-thumbnail.jpg	2	1	f	69950	475	800	0.59
350	4079_-_Bolsa_Sacola_FK010_-_frente_MgNUvtD2V-1593471689159-original-.jpg	4079_-_Bolsa_Sacola_FK010_-_frente_MgNUvtD2V.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_frente_MgNUvtD2V-1593471689159-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_frente_MgNUvtD2V-1593471689159-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_frente_MgNUvtD2V-1593471689159-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_frente_MgNUvtD2V-1593471689159-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_frente_MgNUvtD2V-1593471689159-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_frente_MgNUvtD2V-1593471689159-thumbnail.jpg	2	1	f	142306	706	1080	0.65
438	RX919_3_DZX2mvVaZL-1593471724755-original-.jpg	RX919_3_DZX2mvVaZL.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_3_DZX2mvVaZL-1593471724755-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_3_DZX2mvVaZL-1593471724755-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_3_DZX2mvVaZL-1593471724755-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_3_DZX2mvVaZL-1593471724755-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_3_DZX2mvVaZL-1593471724755-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_3_DZX2mvVaZL-1593471724755-thumbnail.jpg	2	1	f	41965	408	612	0.67
439	BR6001_1_g5K4I90Jp-1593471725163-original-.jpg	BR6001_1_g5K4I90Jp.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_1_g5K4I90Jp-1593471725163-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_1_g5K4I90Jp-1593471725163-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_1_g5K4I90Jp-1593471725163-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_1_g5K4I90Jp-1593471725163-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_1_g5K4I90Jp-1593471725163-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_1_g5K4I90Jp-1593471725163-thumbnail.jpg	2	1	f	27247	408	612	0.67
440	11006PL006_2_5ByUJWZ16-1593471721172-original-.jpg	11006PL006_2_5ByUJWZ16.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/11006PL006_2_5ByUJWZ16-1593471721172-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/11006PL006_2_5ByUJWZ16-1593471721172-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/11006PL006_2_5ByUJWZ16-1593471721172-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/11006PL006_2_5ByUJWZ16-1593471721172-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/11006PL006_2_5ByUJWZ16-1593471721172-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/11006PL006_2_5ByUJWZ16-1593471721172-thumbnail.jpg	2	1	f	796109	1960	4032	0.49
441	BR6001_2_mDvS6_9AC-1593471725958-original-.jpg	BR6001_2_mDvS6_9AC.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_2_mDvS6_9AC-1593471725958-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_2_mDvS6_9AC-1593471725958-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_2_mDvS6_9AC-1593471725958-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_2_mDvS6_9AC-1593471725958-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_2_mDvS6_9AC-1593471725958-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_2_mDvS6_9AC-1593471725958-thumbnail.jpg	2	1	f	55189	408	612	0.67
351	4079_-_Bolsa_Sacola_FK010_-_lateral_TBQKS75Jk-1593471689554-original-.jpg	4079_-_Bolsa_Sacola_FK010_-_lateral_TBQKS75Jk.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_lateral_TBQKS75Jk-1593471689554-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_lateral_TBQKS75Jk-1593471689554-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_lateral_TBQKS75Jk-1593471689554-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_lateral_TBQKS75Jk-1593471689554-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_lateral_TBQKS75Jk-1593471689554-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_lateral_TBQKS75Jk-1593471689554-thumbnail.jpg	2	1	f	116694	670	1080	0.62
352	4078_-_Bolsa_Trans_FK010_AZ_-_frente_0ijZPt1F1-1593471690361-original-.jpg	4078_-_Bolsa_Trans_FK010_AZ_-_frente_0ijZPt1F1.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4078_-_Bolsa_Trans_FK010_AZ_-_frente_0ijZPt1F1-1593471690361-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4078_-_Bolsa_Trans_FK010_AZ_-_frente_0ijZPt1F1-1593471690361-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4078_-_Bolsa_Trans_FK010_AZ_-_frente_0ijZPt1F1-1593471690361-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4078_-_Bolsa_Trans_FK010_AZ_-_frente_0ijZPt1F1-1593471690361-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4078_-_Bolsa_Trans_FK010_AZ_-_frente_0ijZPt1F1-1593471690361-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4078_-_Bolsa_Trans_FK010_AZ_-_frente_0ijZPt1F1-1593471690361-thumbnail.jpg	2	1	f	127217	882	1080	0.82
353	4077_-_Bolsa_Trans_FK010_PT_-_frente_1E8OTrlmR-1593471690759-original-.jpg	4077_-_Bolsa_Trans_FK010_PT_-_frente_1E8OTrlmR.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4077_-_Bolsa_Trans_FK010_PT_-_frente_1E8OTrlmR-1593471690759-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4077_-_Bolsa_Trans_FK010_PT_-_frente_1E8OTrlmR-1593471690759-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4077_-_Bolsa_Trans_FK010_PT_-_frente_1E8OTrlmR-1593471690759-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4077_-_Bolsa_Trans_FK010_PT_-_frente_1E8OTrlmR-1593471690759-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4077_-_Bolsa_Trans_FK010_PT_-_frente_1E8OTrlmR-1593471690759-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4077_-_Bolsa_Trans_FK010_PT_-_frente_1E8OTrlmR-1593471690759-thumbnail.jpg	2	1	f	108197	744	1080	0.69
354	4078_-_Bolsa_Trans_FK010_AZ_-_verso_zcuHQ_0tDo-1593471691157-original-.jpg	4078_-_Bolsa_Trans_FK010_AZ_-_verso_zcuHQ_0tDo.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4078_-_Bolsa_Trans_FK010_AZ_-_verso_zcuHQ_0tDo-1593471691157-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4078_-_Bolsa_Trans_FK010_AZ_-_verso_zcuHQ_0tDo-1593471691157-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4078_-_Bolsa_Trans_FK010_AZ_-_verso_zcuHQ_0tDo-1593471691157-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4078_-_Bolsa_Trans_FK010_AZ_-_verso_zcuHQ_0tDo-1593471691157-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4078_-_Bolsa_Trans_FK010_AZ_-_verso_zcuHQ_0tDo-1593471691157-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4078_-_Bolsa_Trans_FK010_AZ_-_verso_zcuHQ_0tDo-1593471691157-thumbnail.jpg	2	1	f	116888	882	1080	0.82
355	4075_-_Necessaire_Vivo_FK010_-_verso_jvD2mTxDs-1593471691561-original-.jpg	4075_-_Necessaire_Vivo_FK010_-_verso_jvD2mTxDs.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_verso_jvD2mTxDs-1593471691561-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_verso_jvD2mTxDs-1593471691561-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_verso_jvD2mTxDs-1593471691561-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_verso_jvD2mTxDs-1593471691561-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_verso_jvD2mTxDs-1593471691561-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_verso_jvD2mTxDs-1593471691561-thumbnail.jpg	2	1	f	126643	1080	621	1.74
356	4079_-_Bolsa_Sacola_FK010_-_cima_7-eufOIW7-1593471689955-original-.jpg	4079_-_Bolsa_Sacola_FK010_-_cima_7-eufOIW7.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_cima_7-eufOIW7-1593471689955-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_cima_7-eufOIW7-1593471689955-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_cima_7-eufOIW7-1593471689955-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_cima_7-eufOIW7-1593471689955-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_cima_7-eufOIW7-1593471689955-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4079_-_Bolsa_Sacola_FK010_-_cima_7-eufOIW7-1593471689955-thumbnail.jpg	2	1	f	80043	1080	691	1.56
442	IMG_7449_yEoNiKrpC-1593471726354-original-.jpg	IMG_7449_yEoNiKrpC.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7449_yEoNiKrpC-1593471726354-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7449_yEoNiKrpC-1593471726354-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7449_yEoNiKrpC-1593471726354-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7449_yEoNiKrpC-1593471726354-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7449_yEoNiKrpC-1593471726354-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7449_yEoNiKrpC-1593471726354-thumbnail.jpg	1	0	f	78903	1080	720	1.50
357	4077_-_Bolsa_Trans_FK010_PT_-_verso_uOLxLTKut-1593471691961-original-.jpg	4077_-_Bolsa_Trans_FK010_PT_-_verso_uOLxLTKut.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4077_-_Bolsa_Trans_FK010_PT_-_verso_uOLxLTKut-1593471691961-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4077_-_Bolsa_Trans_FK010_PT_-_verso_uOLxLTKut-1593471691961-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4077_-_Bolsa_Trans_FK010_PT_-_verso_uOLxLTKut-1593471691961-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4077_-_Bolsa_Trans_FK010_PT_-_verso_uOLxLTKut-1593471691961-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4077_-_Bolsa_Trans_FK010_PT_-_verso_uOLxLTKut-1593471691961-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4077_-_Bolsa_Trans_FK010_PT_-_verso_uOLxLTKut-1593471691961-thumbnail.jpg	2	1	f	104639	728	1080	0.67
358	4072_-_Carteira_GR_FK010_AZ_-_frente_vjFqUkXfU-1593471692354-original-.jpg	4072_-_Carteira_GR_FK010_AZ_-_frente_vjFqUkXfU.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4072_-_Carteira_GR_FK010_AZ_-_frente_vjFqUkXfU-1593471692354-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4072_-_Carteira_GR_FK010_AZ_-_frente_vjFqUkXfU-1593471692354-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4072_-_Carteira_GR_FK010_AZ_-_frente_vjFqUkXfU-1593471692354-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4072_-_Carteira_GR_FK010_AZ_-_frente_vjFqUkXfU-1593471692354-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4072_-_Carteira_GR_FK010_AZ_-_frente_vjFqUkXfU-1593471692354-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4072_-_Carteira_GR_FK010_AZ_-_frente_vjFqUkXfU-1593471692354-thumbnail.jpg	2	1	f	151441	1080	621	1.74
359	4072_-_Carteira_GR_FK010_AZ_-_verso_v5FW5R4MI-1593471692755-original-.jpg	4072_-_Carteira_GR_FK010_AZ_-_verso_v5FW5R4MI.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4072_-_Carteira_GR_FK010_AZ_-_verso_v5FW5R4MI-1593471692755-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4072_-_Carteira_GR_FK010_AZ_-_verso_v5FW5R4MI-1593471692755-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4072_-_Carteira_GR_FK010_AZ_-_verso_v5FW5R4MI-1593471692755-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4072_-_Carteira_GR_FK010_AZ_-_verso_v5FW5R4MI-1593471692755-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4072_-_Carteira_GR_FK010_AZ_-_verso_v5FW5R4MI-1593471692755-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4072_-_Carteira_GR_FK010_AZ_-_verso_v5FW5R4MI-1593471692755-thumbnail.jpg	2	1	f	116923	1080	594	1.82
360	4074_-_Porta_Niq_FK010_AZ_-_frente_8mnTkkyVQ-1593471693191-original-.jpg	4074_-_Porta_Niq_FK010_AZ_-_frente_8mnTkkyVQ.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4074_-_Porta_Niq_FK010_AZ_-_frente_8mnTkkyVQ-1593471693191-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4074_-_Porta_Niq_FK010_AZ_-_frente_8mnTkkyVQ-1593471693191-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4074_-_Porta_Niq_FK010_AZ_-_frente_8mnTkkyVQ-1593471693191-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4074_-_Porta_Niq_FK010_AZ_-_frente_8mnTkkyVQ-1593471693191-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4074_-_Porta_Niq_FK010_AZ_-_frente_8mnTkkyVQ-1593471693191-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4074_-_Porta_Niq_FK010_AZ_-_frente_8mnTkkyVQ-1593471693191-thumbnail.jpg	2	1	f	125269	1080	694	1.56
361	4075_-_Necessaire_Vivo_FK010_-_lateral_QCCBhIP_wq-1593471693556-original-.jpg	4075_-_Necessaire_Vivo_FK010_-_lateral_QCCBhIP_wq.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_lateral_QCCBhIP_wq-1593471693556-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_lateral_QCCBhIP_wq-1593471693556-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_lateral_QCCBhIP_wq-1593471693556-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_lateral_QCCBhIP_wq-1593471693556-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_lateral_QCCBhIP_wq-1593471693556-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_lateral_QCCBhIP_wq-1593471693556-thumbnail.jpg	2	1	f	118148	1080	886	1.22
443	IMG_7416_YdRmoNELt-1593471725554-original-.jpg	IMG_7416_YdRmoNELt.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7416_YdRmoNELt-1593471725554-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7416_YdRmoNELt-1593471725554-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7416_YdRmoNELt-1593471725554-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7416_YdRmoNELt-1593471725554-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7416_YdRmoNELt-1593471725554-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7416_YdRmoNELt-1593471725554-thumbnail.jpg	2	8	f	134461	1080	720	1.50
444	AB716_1_mg1NSrtjoy-1593471726756-original-.jpg	AB716_1_mg1NSrtjoy.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_1_mg1NSrtjoy-1593471726756-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_1_mg1NSrtjoy-1593471726756-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_1_mg1NSrtjoy-1593471726756-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_1_mg1NSrtjoy-1593471726756-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_1_mg1NSrtjoy-1593471726756-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_1_mg1NSrtjoy-1593471726756-thumbnail.jpg	2	1	f	55546	408	612	0.67
362	4071_-_Carteira_GR_FK010_PT_-_frente_V7j0xM0f3-1593471693960-original-.jpg	4071_-_Carteira_GR_FK010_PT_-_frente_V7j0xM0f3.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4071_-_Carteira_GR_FK010_PT_-_frente_V7j0xM0f3-1593471693960-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4071_-_Carteira_GR_FK010_PT_-_frente_V7j0xM0f3-1593471693960-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4071_-_Carteira_GR_FK010_PT_-_frente_V7j0xM0f3-1593471693960-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4071_-_Carteira_GR_FK010_PT_-_frente_V7j0xM0f3-1593471693960-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4071_-_Carteira_GR_FK010_PT_-_frente_V7j0xM0f3-1593471693960-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4071_-_Carteira_GR_FK010_PT_-_frente_V7j0xM0f3-1593471693960-thumbnail.jpg	2	1	f	138560	1080	601	1.80
363	4074_-_Porta_Niq_FK010_AZ_-_verso_IpBUztVDr3-1593471694356-original-.jpg	4074_-_Porta_Niq_FK010_AZ_-_verso_IpBUztVDr3.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4074_-_Porta_Niq_FK010_AZ_-_verso_IpBUztVDr3-1593471694356-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4074_-_Porta_Niq_FK010_AZ_-_verso_IpBUztVDr3-1593471694356-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4074_-_Porta_Niq_FK010_AZ_-_verso_IpBUztVDr3-1593471694356-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4074_-_Porta_Niq_FK010_AZ_-_verso_IpBUztVDr3-1593471694356-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4074_-_Porta_Niq_FK010_AZ_-_verso_IpBUztVDr3-1593471694356-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4074_-_Porta_Niq_FK010_AZ_-_verso_IpBUztVDr3-1593471694356-thumbnail.jpg	2	1	f	121266	1080	692	1.56
364	4073_-_Porta_Niq_FK010_PT_-_frente__W30Nlbadq-1593471694756-original-.jpg	4073_-_Porta_Niq_FK010_PT_-_frente__W30Nlbadq.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4073_-_Porta_Niq_FK010_PT_-_frente__W30Nlbadq-1593471694756-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4073_-_Porta_Niq_FK010_PT_-_frente__W30Nlbadq-1593471694756-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4073_-_Porta_Niq_FK010_PT_-_frente__W30Nlbadq-1593471694756-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4073_-_Porta_Niq_FK010_PT_-_frente__W30Nlbadq-1593471694756-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4073_-_Porta_Niq_FK010_PT_-_frente__W30Nlbadq-1593471694756-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4073_-_Porta_Niq_FK010_PT_-_frente__W30Nlbadq-1593471694756-thumbnail.jpg	2	1	f	119170	1080	672	1.61
365	4071_-_Carteira_GR_FK010_PT_-_verso_-EQuW1ci--1593471695155-original-.jpg	4071_-_Carteira_GR_FK010_PT_-_verso_-EQuW1ci-.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4071_-_Carteira_GR_FK010_PT_-_verso_-EQuW1ci--1593471695155-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4071_-_Carteira_GR_FK010_PT_-_verso_-EQuW1ci--1593471695155-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4071_-_Carteira_GR_FK010_PT_-_verso_-EQuW1ci--1593471695155-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4071_-_Carteira_GR_FK010_PT_-_verso_-EQuW1ci--1593471695155-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4071_-_Carteira_GR_FK010_PT_-_verso_-EQuW1ci--1593471695155-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4071_-_Carteira_GR_FK010_PT_-_verso_-EQuW1ci--1593471695155-thumbnail.jpg	2	1	f	130209	1080	670	1.61
366	4073_-_Porta_Niq_FK010_PT_-_verso_jYXLAuEQn7-1593471695551-original-.jpg	4073_-_Porta_Niq_FK010_PT_-_verso_jYXLAuEQn7.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4073_-_Porta_Niq_FK010_PT_-_verso_jYXLAuEQn7-1593471695551-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4073_-_Porta_Niq_FK010_PT_-_verso_jYXLAuEQn7-1593471695551-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4073_-_Porta_Niq_FK010_PT_-_verso_jYXLAuEQn7-1593471695551-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4073_-_Porta_Niq_FK010_PT_-_verso_jYXLAuEQn7-1593471695551-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4073_-_Porta_Niq_FK010_PT_-_verso_jYXLAuEQn7-1593471695551-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4073_-_Porta_Niq_FK010_PT_-_verso_jYXLAuEQn7-1593471695551-thumbnail.jpg	2	1	f	113215	1080	725	1.49
445	AB716_2_Zl3YObmYq-1593471727551-original-.jpg	AB716_2_Zl3YObmYq.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_2_Zl3YObmYq-1593471727551-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_2_Zl3YObmYq-1593471727551-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_2_Zl3YObmYq-1593471727551-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_2_Zl3YObmYq-1593471727551-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_2_Zl3YObmYq-1593471727551-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_2_Zl3YObmYq-1593471727551-thumbnail.jpg	2	1	f	26204	408	612	0.67
457	BEGE716_3_LkE1UU0Qv-1593471728359-original-.jpg	BEGE716_3_LkE1UU0Qv.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_3_LkE1UU0Qv-1593471728359-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_3_LkE1UU0Qv-1593471728359-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_3_LkE1UU0Qv-1593471728359-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_3_LkE1UU0Qv-1593471728359-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_3_LkE1UU0Qv-1593471728359-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_3_LkE1UU0Qv-1593471728359-thumbnail.jpg	2	1	f	49801	408	612	0.67
367	4075_-_Necessaire_Vivo_FK010_-_frente_5zY1peL7--1593471696032-original-.jpg	4075_-_Necessaire_Vivo_FK010_-_frente_5zY1peL7-.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_frente_5zY1peL7--1593471696032-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_frente_5zY1peL7--1593471696032-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_frente_5zY1peL7--1593471696032-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_frente_5zY1peL7--1593471696032-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_frente_5zY1peL7--1593471696032-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4075_-_Necessaire_Vivo_FK010_-_frente_5zY1peL7--1593471696032-thumbnail.jpg	2	1	f	129738	1080	585	1.85
379	4062_-_Bolsa_Sacola_FK009_-_lateral1_l4V-GfTY0-1593471701962-original-.jpg	4062_-_Bolsa_Sacola_FK009_-_lateral1_l4V-GfTY0.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_lateral1_l4V-GfTY0-1593471701962-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_lateral1_l4V-GfTY0-1593471701962-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_lateral1_l4V-GfTY0-1593471701962-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_lateral1_l4V-GfTY0-1593471701962-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_lateral1_l4V-GfTY0-1593471701962-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_lateral1_l4V-GfTY0-1593471701962-thumbnail.jpg	2	1	f	88653	566	1080	0.52
397	4053_-_Carteira_GR_FK009_PTC_-_frente_JU2RFFRtad-1593471707961-original-.jpg	4053_-_Carteira_GR_FK009_PTC_-_frente_JU2RFFRtad.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4053_-_Carteira_GR_FK009_PTC_-_frente_JU2RFFRtad-1593471707961-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4053_-_Carteira_GR_FK009_PTC_-_frente_JU2RFFRtad-1593471707961-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4053_-_Carteira_GR_FK009_PTC_-_frente_JU2RFFRtad-1593471707961-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4053_-_Carteira_GR_FK009_PTC_-_frente_JU2RFFRtad-1593471707961-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4053_-_Carteira_GR_FK009_PTC_-_frente_JU2RFFRtad-1593471707961-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4053_-_Carteira_GR_FK009_PTC_-_frente_JU2RFFRtad-1593471707961-thumbnail.jpg	2	1	f	107567	1080	530	2.04
446	AB716_3_ZbxOs7x05-1593471727165-original-.jpg	AB716_3_ZbxOs7x05.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_3_ZbxOs7x05-1593471727165-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_3_ZbxOs7x05-1593471727165-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_3_ZbxOs7x05-1593471727165-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_3_ZbxOs7x05-1593471727165-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_3_ZbxOs7x05-1593471727165-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AB716_3_ZbxOs7x05-1593471727165-thumbnail.jpg	2	1	f	50456	408	612	0.67
448	BEGE716_2_-1cmCuCYV-1593471728754-original-.jpg	BEGE716_2_-1cmCuCYV.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_2_-1cmCuCYV-1593471728754-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_2_-1cmCuCYV-1593471728754-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_2_-1cmCuCYV-1593471728754-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_2_-1cmCuCYV-1593471728754-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_2_-1cmCuCYV-1593471728754-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_2_-1cmCuCYV-1593471728754-thumbnail.jpg	2	1	f	25455	408	612	0.67
449	LA837_3_AZBCiVYTb--1593471729155-original-.jpg	LA837_3_AZBCiVYTb-.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_3_AZBCiVYTb--1593471729155-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_3_AZBCiVYTb--1593471729155-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_3_AZBCiVYTb--1593471729155-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_3_AZBCiVYTb--1593471729155-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_3_AZBCiVYTb--1593471729155-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_3_AZBCiVYTb--1593471729155-thumbnail.jpg	2	1	f	58519	408	612	0.67
450	LA837_2_rBGmtI2_a--1593471729954-original-.jpg	LA837_2_rBGmtI2_a-.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_2_rBGmtI2_a--1593471729954-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_2_rBGmtI2_a--1593471729954-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_2_rBGmtI2_a--1593471729954-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_2_rBGmtI2_a--1593471729954-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_2_rBGmtI2_a--1593471729954-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_2_rBGmtI2_a--1593471729954-thumbnail.jpg	2	1	f	64978	408	612	0.67
368	4069_-_Chav_ECOBag_FK009_C_-_verso_RQU3xFhYpB-1593471696356-original-.jpg	4069_-_Chav_ECOBag_FK009_C_-_verso_RQU3xFhYpB.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_verso_RQU3xFhYpB-1593471696356-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_verso_RQU3xFhYpB-1593471696356-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_verso_RQU3xFhYpB-1593471696356-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_verso_RQU3xFhYpB-1593471696356-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_verso_RQU3xFhYpB-1593471696356-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_verso_RQU3xFhYpB-1593471696356-thumbnail.jpg	2	1	f	131396	726	1080	0.67
369	4069_-_Chav_ECOBag_FK009_C_-_frente_evKaLs-Sh-1593471697154-original-.jpg	4069_-_Chav_ECOBag_FK009_C_-_frente_evKaLs-Sh.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_frente_evKaLs-Sh-1593471697154-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_frente_evKaLs-Sh-1593471697154-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_frente_evKaLs-Sh-1593471697154-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_frente_evKaLs-Sh-1593471697154-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_frente_evKaLs-Sh-1593471697154-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_frente_evKaLs-Sh-1593471697154-thumbnail.jpg	2	1	f	134088	739	1080	0.68
370	4064_-_Bolsa_T_rmica_G_FK009_C_-_verso_0JW3QcSvZ-1593471696759-original-.jpg	4064_-_Bolsa_T_rmica_G_FK009_C_-_verso_0JW3QcSvZ.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_verso_0JW3QcSvZ-1593471696759-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_verso_0JW3QcSvZ-1593471696759-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_verso_0JW3QcSvZ-1593471696759-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_verso_0JW3QcSvZ-1593471696759-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_verso_0JW3QcSvZ-1593471696759-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_verso_0JW3QcSvZ-1593471696759-thumbnail.jpg	2	1	f	203997	1019	1080	0.94
371	4069_-_Chav_ECOBag_FK009_C_-_dentro_e1mmLbBlH-1593471697955-original-.jpg	4069_-_Chav_ECOBag_FK009_C_-_dentro_e1mmLbBlH.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_dentro_e1mmLbBlH-1593471697955-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_dentro_e1mmLbBlH-1593471697955-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_dentro_e1mmLbBlH-1593471697955-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_dentro_e1mmLbBlH-1593471697955-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_dentro_e1mmLbBlH-1593471697955-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4069_-_Chav_ECOBag_FK009_C_-_dentro_e1mmLbBlH-1593471697955-thumbnail.jpg	2	1	f	88656	1013	1080	0.94
372	4064_-_Bolsa_T_rmica_G_FK009_C_-_lateral_xrF5Zopa0-1593471697554-original-.jpg	4064_-_Bolsa_T_rmica_G_FK009_C_-_lateral_xrF5Zopa0.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_lateral_xrF5Zopa0-1593471697554-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_lateral_xrF5Zopa0-1593471697554-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_lateral_xrF5Zopa0-1593471697554-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_lateral_xrF5Zopa0-1593471697554-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_lateral_xrF5Zopa0-1593471697554-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_lateral_xrF5Zopa0-1593471697554-thumbnail.jpg	2	1	f	186623	1080	1060	1.02
447	BEGE716_1_dOveH7QS0-1593471727953-original-.jpg	BEGE716_1_dOveH7QS0.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_1_dOveH7QS0-1593471727953-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_1_dOveH7QS0-1593471727953-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_1_dOveH7QS0-1593471727953-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_1_dOveH7QS0-1593471727953-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_1_dOveH7QS0-1593471727953-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BEGE716_1_dOveH7QS0-1593471727953-thumbnail.jpg	2	1	f	21114	408	612	0.67
458	AZ9316_1_Q-SYi2npI-1593471731956-original-.jpg	AZ9316_1_Q-SYi2npI.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_1_Q-SYi2npI-1593471731956-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_1_Q-SYi2npI-1593471731956-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_1_Q-SYi2npI-1593471731956-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_1_Q-SYi2npI-1593471731956-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_1_Q-SYi2npI-1593471731956-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_1_Q-SYi2npI-1593471731956-thumbnail.jpg	2	1	f	27248	408	612	0.67
373	4064_-_Bolsa_T_rmica_G_FK009_C_-_frente_Aml6E47_6-1593471698369-original-.jpg	4064_-_Bolsa_T_rmica_G_FK009_C_-_frente_Aml6E47_6.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_frente_Aml6E47_6-1593471698369-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_frente_Aml6E47_6-1593471698369-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_frente_Aml6E47_6-1593471698369-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_frente_Aml6E47_6-1593471698369-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_frente_Aml6E47_6-1593471698369-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_frente_Aml6E47_6-1593471698369-thumbnail.jpg	2	1	f	162660	958	1080	0.89
374	4063_-_Bolsa_T_rmica_G_FK009_PT_-_verso_eZDezrePMQ-1593471699593-original-.jpg	4063_-_Bolsa_T_rmica_G_FK009_PT_-_verso_eZDezrePMQ.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_verso_eZDezrePMQ-1593471699593-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_verso_eZDezrePMQ-1593471699593-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_verso_eZDezrePMQ-1593471699593-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_verso_eZDezrePMQ-1593471699593-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_verso_eZDezrePMQ-1593471699593-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_verso_eZDezrePMQ-1593471699593-thumbnail.jpg	2	1	f	151226	863	1080	0.80
375	4063_-_Bolsa_T_rmica_G_FK009_PT_-_cima_cU5Qsb3g3-1593471700366-original-.jpg	4063_-_Bolsa_T_rmica_G_FK009_PT_-_cima_cU5Qsb3g3.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_cima_cU5Qsb3g3-1593471700366-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_cima_cU5Qsb3g3-1593471700366-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_cima_cU5Qsb3g3-1593471700366-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_cima_cU5Qsb3g3-1593471700366-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_cima_cU5Qsb3g3-1593471700366-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_cima_cU5Qsb3g3-1593471700366-thumbnail.jpg	2	1	f	151444	1080	813	1.33
376	4063_-_Bolsa_T_rmica_G_FK009_PT_-_frente_LZvqiltKa-1593471699962-original-.jpg	4063_-_Bolsa_T_rmica_G_FK009_PT_-_frente_LZvqiltKa.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_frente_LZvqiltKa-1593471699962-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_frente_LZvqiltKa-1593471699962-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_frente_LZvqiltKa-1593471699962-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_frente_LZvqiltKa-1593471699962-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_frente_LZvqiltKa-1593471699962-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_frente_LZvqiltKa-1593471699962-thumbnail.jpg	2	1	f	180662	1080	1065	1.01
377	4062_-_Bolsa_Sacola_FK009_-_verso_RrQlQUCFP-1593471700761-original-.jpg	4062_-_Bolsa_Sacola_FK009_-_verso_RrQlQUCFP.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_verso_RrQlQUCFP-1593471700761-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_verso_RrQlQUCFP-1593471700761-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_verso_RrQlQUCFP-1593471700761-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_verso_RrQlQUCFP-1593471700761-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_verso_RrQlQUCFP-1593471700761-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_verso_RrQlQUCFP-1593471700761-thumbnail.jpg	2	1	f	141906	713	1080	0.66
451	BD8255_1_q3f_7BURz-1593471731155-original-.jpg	BD8255_1_q3f_7BURz.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_1_q3f_7BURz-1593471731155-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_1_q3f_7BURz-1593471731155-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_1_q3f_7BURz-1593471731155-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_1_q3f_7BURz-1593471731155-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_1_q3f_7BURz-1593471731155-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_1_q3f_7BURz-1593471731155-thumbnail.jpg	2	1	f	64490	408	612	0.67
452	IMG_7423_CXK_QDXQi-1593471730762-original-.jpg	IMG_7423_CXK_QDXQi.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7423_CXK_QDXQi-1593471730762-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7423_CXK_QDXQi-1593471730762-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7423_CXK_QDXQi-1593471730762-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7423_CXK_QDXQi-1593471730762-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7423_CXK_QDXQi-1593471730762-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7423_CXK_QDXQi-1593471730762-thumbnail.jpg	2	8	f	123537	1080	720	1.50
378	4062_-_Bolsa_Sacola_FK009_-_lateral2_0Ne12_t9IV-1593471701155-original-.jpg	4062_-_Bolsa_Sacola_FK009_-_lateral2_0Ne12_t9IV.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_lateral2_0Ne12_t9IV-1593471701155-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_lateral2_0Ne12_t9IV-1593471701155-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_lateral2_0Ne12_t9IV-1593471701155-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_lateral2_0Ne12_t9IV-1593471701155-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_lateral2_0Ne12_t9IV-1593471701155-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_lateral2_0Ne12_t9IV-1593471701155-thumbnail.jpg	2	1	f	123639	655	1080	0.61
380	4062_-_Bolsa_Sacola_FK009_-_frente_kSt9ObMtx-1593471701553-original-.jpg	4062_-_Bolsa_Sacola_FK009_-_frente_kSt9ObMtx.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_frente_kSt9ObMtx-1593471701553-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_frente_kSt9ObMtx-1593471701553-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_frente_kSt9ObMtx-1593471701553-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_frente_kSt9ObMtx-1593471701553-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_frente_kSt9ObMtx-1593471701553-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_frente_kSt9ObMtx-1593471701553-thumbnail.jpg	2	1	f	124087	725	1080	0.67
381	4062_-_Bolsa_Sacola_FK009_-_cima_haH08tFQb-1593471702367-original-.jpg	4062_-_Bolsa_Sacola_FK009_-_cima_haH08tFQb.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_cima_haH08tFQb-1593471702367-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_cima_haH08tFQb-1593471702367-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_cima_haH08tFQb-1593471702367-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_cima_haH08tFQb-1593471702367-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_cima_haH08tFQb-1593471702367-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4062_-_Bolsa_Sacola_FK009_-_cima_haH08tFQb-1593471702367-thumbnail.jpg	2	1	f	77962	1080	587	1.84
382	4063_-_Bolsa_T_rmica_G_FK009_PT_-_lateral_x47IugG8Y-1593471699168-original-.jpg	4063_-_Bolsa_T_rmica_G_FK009_PT_-_lateral_x47IugG8Y.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_lateral_x47IugG8Y-1593471699168-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_lateral_x47IugG8Y-1593471699168-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_lateral_x47IugG8Y-1593471699168-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_lateral_x47IugG8Y-1593471699168-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_lateral_x47IugG8Y-1593471699168-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4063_-_Bolsa_T_rmica_G_FK009_PT_-_lateral_x47IugG8Y-1593471699168-thumbnail.jpg	2	1	f	159720	1080	1051	1.03
383	4060_-_Bolsa_Trans_FK009_PT_-_verso_0J7n8_sgu-1593471702755-original-.jpg	4060_-_Bolsa_Trans_FK009_PT_-_verso_0J7n8_sgu.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4060_-_Bolsa_Trans_FK009_PT_-_verso_0J7n8_sgu-1593471702755-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4060_-_Bolsa_Trans_FK009_PT_-_verso_0J7n8_sgu-1593471702755-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4060_-_Bolsa_Trans_FK009_PT_-_verso_0J7n8_sgu-1593471702755-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4060_-_Bolsa_Trans_FK009_PT_-_verso_0J7n8_sgu-1593471702755-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4060_-_Bolsa_Trans_FK009_PT_-_verso_0J7n8_sgu-1593471702755-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4060_-_Bolsa_Trans_FK009_PT_-_verso_0J7n8_sgu-1593471702755-thumbnail.jpg	2	1	f	110826	772	1080	0.71
453	AZ9316_3_4uKFnG7k8-1593471732759-original-.jpg	AZ9316_3_4uKFnG7k8.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_3_4uKFnG7k8-1593471732759-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_3_4uKFnG7k8-1593471732759-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_3_4uKFnG7k8-1593471732759-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_3_4uKFnG7k8-1593471732759-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_3_4uKFnG7k8-1593471732759-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_3_4uKFnG7k8-1593471732759-thumbnail.jpg	2	1	f	29353	298	447	0.67
454	BD8255_2_iNEO7GYIz-1593471731554-original-.jpg	BD8255_2_iNEO7GYIz.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_2_iNEO7GYIz-1593471731554-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_2_iNEO7GYIz-1593471731554-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_2_iNEO7GYIz-1593471731554-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_2_iNEO7GYIz-1593471731554-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_2_iNEO7GYIz-1593471731554-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_2_iNEO7GYIz-1593471731554-thumbnail.jpg	2	1	f	27050	408	612	0.67
384	4058_-_Nec_Vivo_FK009_-_verso_cXkOUH_FlV-1593471703162-original-.jpg	4058_-_Nec_Vivo_FK009_-_verso_cXkOUH_FlV.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_verso_cXkOUH_FlV-1593471703162-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_verso_cXkOUH_FlV-1593471703162-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_verso_cXkOUH_FlV-1593471703162-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_verso_cXkOUH_FlV-1593471703162-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_verso_cXkOUH_FlV-1593471703162-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_verso_cXkOUH_FlV-1593471703162-thumbnail.jpg	2	1	f	133119	1080	610	1.77
385	4058_-_Nec_Vivo_FK009_-_frente_Zl-HHEDiE-1593471703558-original-.jpg	4058_-_Nec_Vivo_FK009_-_frente_Zl-HHEDiE.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_frente_Zl-HHEDiE-1593471703558-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_frente_Zl-HHEDiE-1593471703558-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_frente_Zl-HHEDiE-1593471703558-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_frente_Zl-HHEDiE-1593471703558-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_frente_Zl-HHEDiE-1593471703558-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_frente_Zl-HHEDiE-1593471703558-thumbnail.jpg	2	1	f	125472	1080	585	1.85
386	4064_-_Bolsa_T_rmica_G_FK009_C_-_cima_Ia3kwTjmS-1593471698753-original-.jpg	4064_-_Bolsa_T_rmica_G_FK009_C_-_cima_Ia3kwTjmS.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_cima_Ia3kwTjmS-1593471698753-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_cima_Ia3kwTjmS-1593471698753-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_cima_Ia3kwTjmS-1593471698753-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_cima_Ia3kwTjmS-1593471698753-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_cima_Ia3kwTjmS-1593471698753-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4064_-_Bolsa_T_rmica_G_FK009_C_-_cima_Ia3kwTjmS-1593471698753-thumbnail.jpg	2	1	f	165661	1080	818	1.32
387	4060_-_Bolsa_Trans_FK009_PT_-_frente_VRl0F_cdz-1593471703954-original-.jpg	4060_-_Bolsa_Trans_FK009_PT_-_frente_VRl0F_cdz.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4060_-_Bolsa_Trans_FK009_PT_-_frente_VRl0F_cdz-1593471703954-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4060_-_Bolsa_Trans_FK009_PT_-_frente_VRl0F_cdz-1593471703954-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4060_-_Bolsa_Trans_FK009_PT_-_frente_VRl0F_cdz-1593471703954-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4060_-_Bolsa_Trans_FK009_PT_-_frente_VRl0F_cdz-1593471703954-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4060_-_Bolsa_Trans_FK009_PT_-_frente_VRl0F_cdz-1593471703954-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4060_-_Bolsa_Trans_FK009_PT_-_frente_VRl0F_cdz-1593471703954-thumbnail.jpg	2	1	f	113541	816	1080	0.76
388	4058_-_Nec_Vivo_FK009_-_lateral_C8MWsFUqS-1593471704360-original-.jpg	4058_-_Nec_Vivo_FK009_-_lateral_C8MWsFUqS.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_lateral_C8MWsFUqS-1593471704360-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_lateral_C8MWsFUqS-1593471704360-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_lateral_C8MWsFUqS-1593471704360-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_lateral_C8MWsFUqS-1593471704360-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_lateral_C8MWsFUqS-1593471704360-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4058_-_Nec_Vivo_FK009_-_lateral_C8MWsFUqS-1593471704360-thumbnail.jpg	2	1	f	124514	1071	1080	0.99
455	AZ9316_2_Xrj-P9bEx-1593471732358-original-.jpg	AZ9316_2_Xrj-P9bEx.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_2_Xrj-P9bEx-1593471732358-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_2_Xrj-P9bEx-1593471732358-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_2_Xrj-P9bEx-1593471732358-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_2_Xrj-P9bEx-1593471732358-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_2_Xrj-P9bEx-1593471732358-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/AZ9316_2_Xrj-P9bEx-1593471732358-thumbnail.jpg	2	1	f	17614	408	612	0.67
456	BD8255_3_Z6Ecl55BX-1593471730356-original-.jpg	BD8255_3_Z6Ecl55BX.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_3_Z6Ecl55BX-1593471730356-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_3_Z6Ecl55BX-1593471730356-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_3_Z6Ecl55BX-1593471730356-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_3_Z6Ecl55BX-1593471730356-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_3_Z6Ecl55BX-1593471730356-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BD8255_3_Z6Ecl55BX-1593471730356-thumbnail.jpg	2	1	f	70509	408	612	0.67
389	4057_-_Porta_Niq_FK009_AM_-_verso_yO0myVlil-1593471704753-original-.jpg	4057_-_Porta_Niq_FK009_AM_-_verso_yO0myVlil.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4057_-_Porta_Niq_FK009_AM_-_verso_yO0myVlil-1593471704753-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4057_-_Porta_Niq_FK009_AM_-_verso_yO0myVlil-1593471704753-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4057_-_Porta_Niq_FK009_AM_-_verso_yO0myVlil-1593471704753-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4057_-_Porta_Niq_FK009_AM_-_verso_yO0myVlil-1593471704753-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4057_-_Porta_Niq_FK009_AM_-_verso_yO0myVlil-1593471704753-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4057_-_Porta_Niq_FK009_AM_-_verso_yO0myVlil-1593471704753-thumbnail.jpg	2	1	f	116257	1080	712	1.52
390	4056_-_Porta_Niq_FK009_C_-_verso_kUwtj79UUY-1593471705570-original-.jpg	4056_-_Porta_Niq_FK009_C_-_verso_kUwtj79UUY.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4056_-_Porta_Niq_FK009_C_-_verso_kUwtj79UUY-1593471705570-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4056_-_Porta_Niq_FK009_C_-_verso_kUwtj79UUY-1593471705570-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4056_-_Porta_Niq_FK009_C_-_verso_kUwtj79UUY-1593471705570-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4056_-_Porta_Niq_FK009_C_-_verso_kUwtj79UUY-1593471705570-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4056_-_Porta_Niq_FK009_C_-_verso_kUwtj79UUY-1593471705570-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4056_-_Porta_Niq_FK009_C_-_verso_kUwtj79UUY-1593471705570-thumbnail.jpg	2	1	f	118677	1080	697	1.55
391	4055_-_Porta_Niq_FK009_PT_-_verso__6J0Ji-oR-1593471705965-original-.jpg	4055_-_Porta_Niq_FK009_PT_-_verso__6J0Ji-oR.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4055_-_Porta_Niq_FK009_PT_-_verso__6J0Ji-oR-1593471705965-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4055_-_Porta_Niq_FK009_PT_-_verso__6J0Ji-oR-1593471705965-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4055_-_Porta_Niq_FK009_PT_-_verso__6J0Ji-oR-1593471705965-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4055_-_Porta_Niq_FK009_PT_-_verso__6J0Ji-oR-1593471705965-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4055_-_Porta_Niq_FK009_PT_-_verso__6J0Ji-oR-1593471705965-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4055_-_Porta_Niq_FK009_PT_-_verso__6J0Ji-oR-1593471705965-thumbnail.jpg	2	1	f	127294	1080	720	1.50
392	4054_-_Carteira_GR_FK009_AM_-_verso_8UKLpODH6v-1593471706361-original-.jpg	4054_-_Carteira_GR_FK009_AM_-_verso_8UKLpODH6v.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4054_-_Carteira_GR_FK009_AM_-_verso_8UKLpODH6v-1593471706361-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4054_-_Carteira_GR_FK009_AM_-_verso_8UKLpODH6v-1593471706361-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4054_-_Carteira_GR_FK009_AM_-_verso_8UKLpODH6v-1593471706361-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4054_-_Carteira_GR_FK009_AM_-_verso_8UKLpODH6v-1593471706361-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4054_-_Carteira_GR_FK009_AM_-_verso_8UKLpODH6v-1593471706361-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4054_-_Carteira_GR_FK009_AM_-_verso_8UKLpODH6v-1593471706361-thumbnail.jpg	2	1	f	124375	1080	608	1.78
393	4056_-_Porta_Niq_FK009_C_-_frente_wstKlg4vb-1593471706759-original-.jpg	4056_-_Porta_Niq_FK009_C_-_frente_wstKlg4vb.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4056_-_Porta_Niq_FK009_C_-_frente_wstKlg4vb-1593471706759-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4056_-_Porta_Niq_FK009_C_-_frente_wstKlg4vb-1593471706759-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4056_-_Porta_Niq_FK009_C_-_frente_wstKlg4vb-1593471706759-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4056_-_Porta_Niq_FK009_C_-_frente_wstKlg4vb-1593471706759-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4056_-_Porta_Niq_FK009_C_-_frente_wstKlg4vb-1593471706759-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4056_-_Porta_Niq_FK009_C_-_frente_wstKlg4vb-1593471706759-thumbnail.jpg	2	1	f	100736	1080	685	1.58
459	LA837_1_BHy40q6Kfm-1593471729552-original-.jpg	LA837_1_BHy40q6Kfm.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_1_BHy40q6Kfm-1593471729552-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_1_BHy40q6Kfm-1593471729552-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_1_BHy40q6Kfm-1593471729552-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_1_BHy40q6Kfm-1593471729552-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_1_BHy40q6Kfm-1593471729552-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/LA837_1_BHy40q6Kfm-1593471729552-thumbnail.jpg	2	1	f	26544	408	612	0.67
460	RX919_1_u_LW1GaI9g-1593471733554-original-.jpg	RX919_1_u_LW1GaI9g.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_1_u_LW1GaI9g-1593471733554-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_1_u_LW1GaI9g-1593471733554-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_1_u_LW1GaI9g-1593471733554-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_1_u_LW1GaI9g-1593471733554-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_1_u_LW1GaI9g-1593471733554-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/RX919_1_u_LW1GaI9g-1593471733554-thumbnail.jpg	2	1	f	52836	408	612	0.67
394	4054_-_Carteira_GR_FK009_AM_-_frente_aXVwbnUNI-1593471707157-original-.jpg	4054_-_Carteira_GR_FK009_AM_-_frente_aXVwbnUNI.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4054_-_Carteira_GR_FK009_AM_-_frente_aXVwbnUNI-1593471707157-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4054_-_Carteira_GR_FK009_AM_-_frente_aXVwbnUNI-1593471707157-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4054_-_Carteira_GR_FK009_AM_-_frente_aXVwbnUNI-1593471707157-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4054_-_Carteira_GR_FK009_AM_-_frente_aXVwbnUNI-1593471707157-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4054_-_Carteira_GR_FK009_AM_-_frente_aXVwbnUNI-1593471707157-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4054_-_Carteira_GR_FK009_AM_-_frente_aXVwbnUNI-1593471707157-thumbnail.jpg	2	1	f	114863	1080	571	1.89
395	4053_-_Carteira_GR_FK009_PTC_-_verso_R5eEWXOHX-1593471707552-original-.jpg	4053_-_Carteira_GR_FK009_PTC_-_verso_R5eEWXOHX.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4053_-_Carteira_GR_FK009_PTC_-_verso_R5eEWXOHX-1593471707552-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4053_-_Carteira_GR_FK009_PTC_-_verso_R5eEWXOHX-1593471707552-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4053_-_Carteira_GR_FK009_PTC_-_verso_R5eEWXOHX-1593471707552-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4053_-_Carteira_GR_FK009_PTC_-_verso_R5eEWXOHX-1593471707552-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4053_-_Carteira_GR_FK009_PTC_-_verso_R5eEWXOHX-1593471707552-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4053_-_Carteira_GR_FK009_PTC_-_verso_R5eEWXOHX-1593471707552-thumbnail.jpg	2	1	f	122442	1080	574	1.88
396	4055_-_Porta_Niq_FK009_PT_-_frente_h7HY_iT_e-1593471708355-original-.jpg	4055_-_Porta_Niq_FK009_PT_-_frente_h7HY_iT_e.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4055_-_Porta_Niq_FK009_PT_-_frente_h7HY_iT_e-1593471708355-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4055_-_Porta_Niq_FK009_PT_-_frente_h7HY_iT_e-1593471708355-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4055_-_Porta_Niq_FK009_PT_-_frente_h7HY_iT_e-1593471708355-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4055_-_Porta_Niq_FK009_PT_-_frente_h7HY_iT_e-1593471708355-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4055_-_Porta_Niq_FK009_PT_-_frente_h7HY_iT_e-1593471708355-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4055_-_Porta_Niq_FK009_PT_-_frente_h7HY_iT_e-1593471708355-thumbnail.jpg	2	1	f	84995	1080	674	1.60
461	IMG_7402_PLgEeuZ2rp-1593471733160-original-.jpg	IMG_7402_PLgEeuZ2rp.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7402_PLgEeuZ2rp-1593471733160-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7402_PLgEeuZ2rp-1593471733160-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7402_PLgEeuZ2rp-1593471733160-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7402_PLgEeuZ2rp-1593471733160-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7402_PLgEeuZ2rp-1593471733160-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7402_PLgEeuZ2rp-1593471733160-thumbnail.jpg	2	8	f	96002	1080	720	1.50
462	BR6001_3_-yG927qLoT-1593471733958-original-.jpg	BR6001_3_-yG927qLoT.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_3_-yG927qLoT-1593471733958-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_3_-yG927qLoT-1593471733958-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_3_-yG927qLoT-1593471733958-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_3_-yG927qLoT-1593471733958-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_3_-yG927qLoT-1593471733958-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/BR6001_3_-yG927qLoT-1593471733958-thumbnail.jpg	2	1	f	53987	408	612	0.67
463	IMG_7405_XAZxWvg8A-1593471734758-original-.jpg	IMG_7405_XAZxWvg8A.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7405_XAZxWvg8A-1593471734758-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7405_XAZxWvg8A-1593471734758-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7405_XAZxWvg8A-1593471734758-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7405_XAZxWvg8A-1593471734758-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7405_XAZxWvg8A-1593471734758-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7405_XAZxWvg8A-1593471734758-thumbnail.jpg	2	10	f	101510	1080	720	1.50
464	IMG_7651_dA81GNosg-1593471734364-original-.jpg	IMG_7651_dA81GNosg.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7651_dA81GNosg-1593471734364-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7651_dA81GNosg-1593471734364-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7651_dA81GNosg-1593471734364-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7651_dA81GNosg-1593471734364-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7651_dA81GNosg-1593471734364-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7651_dA81GNosg-1593471734364-thumbnail.jpg	1	0	f	31322	1080	720	1.50
465	IMG_7393_kvShigkmO-1593471735159-original-.jpg	IMG_7393_kvShigkmO.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7393_kvShigkmO-1593471735159-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7393_kvShigkmO-1593471735159-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7393_kvShigkmO-1593471735159-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7393_kvShigkmO-1593471735159-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7393_kvShigkmO-1593471735159-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7393_kvShigkmO-1593471735159-thumbnail.jpg	2	4	f	86562	1080	720	1.50
466	IMG_7397__Y4yzpv3xW-1593471735559-original-.jpg	IMG_7397__Y4yzpv3xW.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7397__Y4yzpv3xW-1593471735559-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7397__Y4yzpv3xW-1593471735559-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7397__Y4yzpv3xW-1593471735559-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7397__Y4yzpv3xW-1593471735559-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7397__Y4yzpv3xW-1593471735559-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7397__Y4yzpv3xW-1593471735559-thumbnail.jpg	2	4	f	99280	1080	720	1.50
467	IMG_1167_zN5hjFcSbB-1593471735963-original-.jpg	IMG_1167_zN5hjFcSbB.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1167_zN5hjFcSbB-1593471735963-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1167_zN5hjFcSbB-1593471735963-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1167_zN5hjFcSbB-1593471735963-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1167_zN5hjFcSbB-1593471735963-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1167_zN5hjFcSbB-1593471735963-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1167_zN5hjFcSbB-1593471735963-thumbnail.jpg	2	1	f	151291	720	1080	0.67
468	IMG_1000_i5j_IfvgA-1593471736432-original-.jpg	IMG_1000_i5j_IfvgA.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1000_i5j_IfvgA-1593471736432-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1000_i5j_IfvgA-1593471736432-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1000_i5j_IfvgA-1593471736432-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1000_i5j_IfvgA-1593471736432-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1000_i5j_IfvgA-1593471736432-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1000_i5j_IfvgA-1593471736432-thumbnail.jpg	2	7	f	140593	720	1080	0.67
469	IMG_7355_ZcCxb2k6p-1593471736755-original-.jpg	IMG_7355_ZcCxb2k6p.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7355_ZcCxb2k6p-1593471736755-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7355_ZcCxb2k6p-1593471736755-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7355_ZcCxb2k6p-1593471736755-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7355_ZcCxb2k6p-1593471736755-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7355_ZcCxb2k6p-1593471736755-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7355_ZcCxb2k6p-1593471736755-thumbnail.jpg	2	7	f	116528	1080	720	1.50
470	IMG_1085_jF2zBuLTK-1593471737163-original-.jpg	IMG_1085_jF2zBuLTK.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1085_jF2zBuLTK-1593471737163-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1085_jF2zBuLTK-1593471737163-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1085_jF2zBuLTK-1593471737163-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1085_jF2zBuLTK-1593471737163-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1085_jF2zBuLTK-1593471737163-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1085_jF2zBuLTK-1593471737163-thumbnail.jpg	2	4	f	128306	720	1080	0.67
471	IMG_1303_QE3Pqh4vx-1593471737555-original-.jpg	IMG_1303_QE3Pqh4vx.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1303_QE3Pqh4vx-1593471737555-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1303_QE3Pqh4vx-1593471737555-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1303_QE3Pqh4vx-1593471737555-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1303_QE3Pqh4vx-1593471737555-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1303_QE3Pqh4vx-1593471737555-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1303_QE3Pqh4vx-1593471737555-thumbnail.jpg	2	5	f	74317	720	1080	0.67
472	IMG_7347_Gah3hD-IHS-1593471738359-original-.jpg	IMG_7347_Gah3hD-IHS.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7347_Gah3hD-IHS-1593471738359-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7347_Gah3hD-IHS-1593471738359-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7347_Gah3hD-IHS-1593471738359-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7347_Gah3hD-IHS-1593471738359-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7347_Gah3hD-IHS-1593471738359-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7347_Gah3hD-IHS-1593471738359-thumbnail.jpg	2	5	f	89931	1080	720	1.50
473	IMG_7332_gb_5TZ2Wx-1593471737961-original-.jpg	IMG_7332_gb_5TZ2Wx.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7332_gb_5TZ2Wx-1593471737961-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7332_gb_5TZ2Wx-1593471737961-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7332_gb_5TZ2Wx-1593471737961-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7332_gb_5TZ2Wx-1593471737961-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7332_gb_5TZ2Wx-1593471737961-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7332_gb_5TZ2Wx-1593471737961-thumbnail.jpg	2	3	f	169013	1080	1080	1.00
474	IMG_7344__7chRPluS-1593471739156-original-.jpg	IMG_7344__7chRPluS.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7344__7chRPluS-1593471739156-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7344__7chRPluS-1593471739156-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7344__7chRPluS-1593471739156-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7344__7chRPluS-1593471739156-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7344__7chRPluS-1593471739156-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7344__7chRPluS-1593471739156-thumbnail.jpg	1	0	f	71534	1080	720	1.50
475	IMG_7342_G8OKwoUOG-1593471739552-original-.jpg	IMG_7342_G8OKwoUOG.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7342_G8OKwoUOG-1593471739552-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7342_G8OKwoUOG-1593471739552-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7342_G8OKwoUOG-1593471739552-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7342_G8OKwoUOG-1593471739552-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7342_G8OKwoUOG-1593471739552-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7342_G8OKwoUOG-1593471739552-thumbnail.jpg	2	3	f	69411	1080	720	1.50
476	IMG_7325_LSVWZqZh_-1593471739961-original-.jpg	IMG_7325_LSVWZqZh_.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7325_LSVWZqZh_-1593471739961-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7325_LSVWZqZh_-1593471739961-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7325_LSVWZqZh_-1593471739961-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7325_LSVWZqZh_-1593471739961-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7325_LSVWZqZh_-1593471739961-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7325_LSVWZqZh_-1593471739961-thumbnail.jpg	2	4	f	88173	1080	720	1.50
477	IMG_7322_tPEvac0kN-1593471740752-original-.jpg	IMG_7322_tPEvac0kN.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7322_tPEvac0kN-1593471740752-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7322_tPEvac0kN-1593471740752-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7322_tPEvac0kN-1593471740752-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7322_tPEvac0kN-1593471740752-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7322_tPEvac0kN-1593471740752-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7322_tPEvac0kN-1593471740752-thumbnail.jpg	2	4	f	88140	1080	720	1.50
485	IMG_7560_GzlwZQvMk-1593471743556-original-.jpg	IMG_7560_GzlwZQvMk.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7560_GzlwZQvMk-1593471743556-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7560_GzlwZQvMk-1593471743556-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7560_GzlwZQvMk-1593471743556-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7560_GzlwZQvMk-1593471743556-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7560_GzlwZQvMk-1593471743556-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7560_GzlwZQvMk-1593471743556-thumbnail.jpg	2	2	f	79978	720	1080	0.67
486	IMG_7571_g5-p4WquM-1593471743960-original-.jpg	IMG_7571_g5-p4WquM.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7571_g5-p4WquM-1593471743960-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7571_g5-p4WquM-1593471743960-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7571_g5-p4WquM-1593471743960-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7571_g5-p4WquM-1593471743960-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7571_g5-p4WquM-1593471743960-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7571_g5-p4WquM-1593471743960-thumbnail.jpg	2	4	f	90815	1080	720	1.50
487	IMG_7499_eouvMpMmXR-1593471744356-original-.jpg	IMG_7499_eouvMpMmXR.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7499_eouvMpMmXR-1593471744356-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7499_eouvMpMmXR-1593471744356-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7499_eouvMpMmXR-1593471744356-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7499_eouvMpMmXR-1593471744356-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7499_eouvMpMmXR-1593471744356-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7499_eouvMpMmXR-1593471744356-thumbnail.jpg	2	3	f	85316	720	1080	0.67
488	IMG_7493_k_AaI_WZH-1593471744759-original-.jpg	IMG_7493_k_AaI_WZH.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7493_k_AaI_WZH-1593471744759-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7493_k_AaI_WZH-1593471744759-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7493_k_AaI_WZH-1593471744759-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7493_k_AaI_WZH-1593471744759-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7493_k_AaI_WZH-1593471744759-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7493_k_AaI_WZH-1593471744759-thumbnail.jpg	2	4	f	77203	1080	720	1.50
489	IMG_7564_hZ4NJ_I3re-1593471743151-original-.jpg	IMG_7564_hZ4NJ_I3re.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7564_hZ4NJ_I3re-1593471743151-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7564_hZ4NJ_I3re-1593471743151-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7564_hZ4NJ_I3re-1593471743151-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7564_hZ4NJ_I3re-1593471743151-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7564_hZ4NJ_I3re-1593471743151-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7564_hZ4NJ_I3re-1593471743151-thumbnail.jpg	2	6	f	70645	1080	720	1.50
490	IMG_7391_RSXtN3N8O-1593471745557-original-.jpg	IMG_7391_RSXtN3N8O.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7391_RSXtN3N8O-1593471745557-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7391_RSXtN3N8O-1593471745557-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7391_RSXtN3N8O-1593471745557-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7391_RSXtN3N8O-1593471745557-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7391_RSXtN3N8O-1593471745557-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7391_RSXtN3N8O-1593471745557-thumbnail.jpg	2	11	f	116488	720	1080	0.67
491	IMG_7390_xWYdqywI9h-1593471745956-original-.jpg	IMG_7390_xWYdqywI9h.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7390_xWYdqywI9h-1593471745956-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7390_xWYdqywI9h-1593471745956-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7390_xWYdqywI9h-1593471745956-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7390_xWYdqywI9h-1593471745956-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7390_xWYdqywI9h-1593471745956-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7390_xWYdqywI9h-1593471745956-thumbnail.jpg	2	2	f	79662	720	1080	0.67
478	IMG_7324_MjcGIAAemI-1593471740358-original-.jpg	IMG_7324_MjcGIAAemI.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7324_MjcGIAAemI-1593471740358-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7324_MjcGIAAemI-1593471740358-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7324_MjcGIAAemI-1593471740358-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7324_MjcGIAAemI-1593471740358-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7324_MjcGIAAemI-1593471740358-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7324_MjcGIAAemI-1593471740358-thumbnail.jpg	1	0	f	101742	1080	720	1.50
479	IMG_7314_vlEf1o0xO-1593471741175-original-.jpg	IMG_7314_vlEf1o0xO.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7314_vlEf1o0xO-1593471741175-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7314_vlEf1o0xO-1593471741175-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7314_vlEf1o0xO-1593471741175-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7314_vlEf1o0xO-1593471741175-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7314_vlEf1o0xO-1593471741175-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7314_vlEf1o0xO-1593471741175-thumbnail.jpg	2	2	f	63796	1080	720	1.50
480	IMG_7310_TDA0XMqpt-1593471741959-original-.jpg	IMG_7310_TDA0XMqpt.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7310_TDA0XMqpt-1593471741959-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7310_TDA0XMqpt-1593471741959-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7310_TDA0XMqpt-1593471741959-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7310_TDA0XMqpt-1593471741959-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7310_TDA0XMqpt-1593471741959-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7310_TDA0XMqpt-1593471741959-thumbnail.jpg	2	4	f	68037	1080	720	1.50
481	IMG_7312_bSNKcU0hX-1593471742357-original-.jpg	IMG_7312_bSNKcU0hX.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7312_bSNKcU0hX-1593471742357-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7312_bSNKcU0hX-1593471742357-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7312_bSNKcU0hX-1593471742357-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7312_bSNKcU0hX-1593471742357-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7312_bSNKcU0hX-1593471742357-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7312_bSNKcU0hX-1593471742357-thumbnail.jpg	2	3	f	53521	1080	720	1.50
482	IMG_7581_09-M-n6qh-1593471742759-original-.jpg	IMG_7581_09-M-n6qh.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7581_09-M-n6qh-1593471742759-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7581_09-M-n6qh-1593471742759-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7581_09-M-n6qh-1593471742759-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7581_09-M-n6qh-1593471742759-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7581_09-M-n6qh-1593471742759-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7581_09-M-n6qh-1593471742759-thumbnail.jpg	2	4	f	61037	1080	720	1.50
483	IMG_2333_3i-mL4f5n-1593471738801-original-.jpg	IMG_2333_3i-mL4f5n.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2333_3i-mL4f5n-1593471738801-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2333_3i-mL4f5n-1593471738801-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2333_3i-mL4f5n-1593471738801-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2333_3i-mL4f5n-1593471738801-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2333_3i-mL4f5n-1593471738801-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2333_3i-mL4f5n-1593471738801-thumbnail.jpg	2	1	f	1376816	4032	3024	1.33
484	IMG_7315__IG-q9APk-1593471741554-original-.jpg	IMG_7315__IG-q9APk.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7315__IG-q9APk-1593471741554-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7315__IG-q9APk-1593471741554-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7315__IG-q9APk-1593471741554-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7315__IG-q9APk-1593471741554-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7315__IG-q9APk-1593471741554-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7315__IG-q9APk-1593471741554-thumbnail.jpg	2	2	f	52438	1080	720	1.50
492	IMG_7389_vEi0rnwXqx-1593471746755-original-.jpg	IMG_7389_vEi0rnwXqx.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7389_vEi0rnwXqx-1593471746755-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7389_vEi0rnwXqx-1593471746755-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7389_vEi0rnwXqx-1593471746755-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7389_vEi0rnwXqx-1593471746755-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7389_vEi0rnwXqx-1593471746755-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7389_vEi0rnwXqx-1593471746755-thumbnail.jpg	2	2	f	67159	720	1080	0.67
493	IMG_7387_RCZoblFPw-1593471746360-original-.jpg	IMG_7387_RCZoblFPw.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7387_RCZoblFPw-1593471746360-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7387_RCZoblFPw-1593471746360-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7387_RCZoblFPw-1593471746360-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7387_RCZoblFPw-1593471746360-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7387_RCZoblFPw-1593471746360-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7387_RCZoblFPw-1593471746360-thumbnail.jpg	2	7	f	121831	1080	720	1.50
494	IMG_7378_wFTnl-nCr-1593471747172-original-.jpg	IMG_7378_wFTnl-nCr.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7378_wFTnl-nCr-1593471747172-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7378_wFTnl-nCr-1593471747172-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7378_wFTnl-nCr-1593471747172-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7378_wFTnl-nCr-1593471747172-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7378_wFTnl-nCr-1593471747172-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7378_wFTnl-nCr-1593471747172-thumbnail.jpg	2	7	f	81929	1080	720	1.50
495	IMG_7375_bFoas7ZtI-1593471747556-original-.jpg	IMG_7375_bFoas7ZtI.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7375_bFoas7ZtI-1593471747556-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7375_bFoas7ZtI-1593471747556-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7375_bFoas7ZtI-1593471747556-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7375_bFoas7ZtI-1593471747556-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7375_bFoas7ZtI-1593471747556-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7375_bFoas7ZtI-1593471747556-thumbnail.jpg	2	8	f	71078	1080	720	1.50
496	IMG_7382_RZoR9Fo8i-1593471747959-original-.jpg	IMG_7382_RZoR9Fo8i.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7382_RZoR9Fo8i-1593471747959-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7382_RZoR9Fo8i-1593471747959-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7382_RZoR9Fo8i-1593471747959-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7382_RZoR9Fo8i-1593471747959-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7382_RZoR9Fo8i-1593471747959-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7382_RZoR9Fo8i-1593471747959-thumbnail.jpg	2	6	f	76444	1080	720	1.50
497	IMG_7292_GSD755t8f-1593471748355-original-.jpg	IMG_7292_GSD755t8f.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7292_GSD755t8f-1593471748355-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7292_GSD755t8f-1593471748355-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7292_GSD755t8f-1593471748355-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7292_GSD755t8f-1593471748355-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7292_GSD755t8f-1593471748355-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7292_GSD755t8f-1593471748355-thumbnail.jpg	2	7	f	73342	1080	720	1.50
498	IMG_7290_opguHwecC-1593471748752-original-.jpg	IMG_7290_opguHwecC.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7290_opguHwecC-1593471748752-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7290_opguHwecC-1593471748752-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7290_opguHwecC-1593471748752-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7290_opguHwecC-1593471748752-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7290_opguHwecC-1593471748752-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7290_opguHwecC-1593471748752-thumbnail.jpg	2	5	f	75916	720	1080	0.67
499	IMG_7392_qbgsvNc9w-1593471745159-original-.jpg	IMG_7392_qbgsvNc9w.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7392_qbgsvNc9w-1593471745159-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7392_qbgsvNc9w-1593471745159-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7392_qbgsvNc9w-1593471745159-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7392_qbgsvNc9w-1593471745159-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7392_qbgsvNc9w-1593471745159-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7392_qbgsvNc9w-1593471745159-thumbnail.jpg	2	9	f	98605	720	1080	0.67
500	IMG_7275_NyczxRTVh-1593471749155-original-.jpg	IMG_7275_NyczxRTVh.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7275_NyczxRTVh-1593471749155-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7275_NyczxRTVh-1593471749155-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7275_NyczxRTVh-1593471749155-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7275_NyczxRTVh-1593471749155-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7275_NyczxRTVh-1593471749155-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7275_NyczxRTVh-1593471749155-thumbnail.jpg	2	1	f	125759	1080	1062	1.02
501	IMG_7248_xAc0K6qOxy-1593471749558-original-.jpg	IMG_7248_xAc0K6qOxy.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7248_xAc0K6qOxy-1593471749558-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7248_xAc0K6qOxy-1593471749558-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7248_xAc0K6qOxy-1593471749558-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7248_xAc0K6qOxy-1593471749558-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7248_xAc0K6qOxy-1593471749558-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7248_xAc0K6qOxy-1593471749558-thumbnail.jpg	2	2	f	106978	720	1080	0.67
502	IMG_7234_kR1AGmeJ3-1593471749955-original-.jpg	IMG_7234_kR1AGmeJ3.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7234_kR1AGmeJ3-1593471749955-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7234_kR1AGmeJ3-1593471749955-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7234_kR1AGmeJ3-1593471749955-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7234_kR1AGmeJ3-1593471749955-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7234_kR1AGmeJ3-1593471749955-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7234_kR1AGmeJ3-1593471749955-thumbnail.jpg	2	5	f	98517	1080	720	1.50
503	IMG_7236_p9R0_JLJZ-1593471750359-original-.jpg	IMG_7236_p9R0_JLJZ.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7236_p9R0_JLJZ-1593471750359-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7236_p9R0_JLJZ-1593471750359-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7236_p9R0_JLJZ-1593471750359-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7236_p9R0_JLJZ-1593471750359-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7236_p9R0_JLJZ-1593471750359-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7236_p9R0_JLJZ-1593471750359-thumbnail.jpg	2	5	f	96234	1080	720	1.50
504	IMG_7214_n8Sc1fMXt-1593471750780-original-.jpg	IMG_7214_n8Sc1fMXt.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7214_n8Sc1fMXt-1593471750780-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7214_n8Sc1fMXt-1593471750780-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7214_n8Sc1fMXt-1593471750780-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7214_n8Sc1fMXt-1593471750780-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7214_n8Sc1fMXt-1593471750780-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7214_n8Sc1fMXt-1593471750780-thumbnail.jpg	2	4	f	69188	1080	720	1.50
505	IMG_7205_hNwDTjYrg-1593471751158-original-.jpg	IMG_7205_hNwDTjYrg.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7205_hNwDTjYrg-1593471751158-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7205_hNwDTjYrg-1593471751158-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7205_hNwDTjYrg-1593471751158-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7205_hNwDTjYrg-1593471751158-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7205_hNwDTjYrg-1593471751158-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7205_hNwDTjYrg-1593471751158-thumbnail.jpg	2	4	f	83506	1080	720	1.50
506	IMG_7167_EFbYr9Po6-1593471751559-original-.jpg	IMG_7167_EFbYr9Po6.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7167_EFbYr9Po6-1593471751559-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7167_EFbYr9Po6-1593471751559-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7167_EFbYr9Po6-1593471751559-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7167_EFbYr9Po6-1593471751559-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7167_EFbYr9Po6-1593471751559-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7167_EFbYr9Po6-1593471751559-thumbnail.jpg	2	6	f	70654	1080	720	1.50
507	IMG_7161_waHnGrnGyy-1593471751957-original-.jpg	IMG_7161_waHnGrnGyy.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7161_waHnGrnGyy-1593471751957-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7161_waHnGrnGyy-1593471751957-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7161_waHnGrnGyy-1593471751957-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7161_waHnGrnGyy-1593471751957-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7161_waHnGrnGyy-1593471751957-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7161_waHnGrnGyy-1593471751957-thumbnail.jpg	2	3	f	104285	720	1080	0.67
508	IMG_7562_bQzxbvYsIJ-1593471755156-original-.jpg	IMG_7562_bQzxbvYsIJ.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7562_bQzxbvYsIJ-1593471755156-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7562_bQzxbvYsIJ-1593471755156-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7562_bQzxbvYsIJ-1593471755156-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7562_bQzxbvYsIJ-1593471755156-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7562_bQzxbvYsIJ-1593471755156-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7562_bQzxbvYsIJ-1593471755156-thumbnail.jpg	1	0	f	88655	1080	720	1.50
509	IMG_7537_iCdTM4O8m-1593471755557-original-.jpg	IMG_7537_iCdTM4O8m.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7537_iCdTM4O8m-1593471755557-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7537_iCdTM4O8m-1593471755557-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7537_iCdTM4O8m-1593471755557-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7537_iCdTM4O8m-1593471755557-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7537_iCdTM4O8m-1593471755557-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7537_iCdTM4O8m-1593471755557-thumbnail.jpg	2	1	f	98436	1080	720	1.50
510	IMG_7552_Eg9ThZ0Mq-1593471755956-original-.jpg	IMG_7552_Eg9ThZ0Mq.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7552_Eg9ThZ0Mq-1593471755956-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7552_Eg9ThZ0Mq-1593471755956-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7552_Eg9ThZ0Mq-1593471755956-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7552_Eg9ThZ0Mq-1593471755956-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7552_Eg9ThZ0Mq-1593471755956-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7552_Eg9ThZ0Mq-1593471755956-thumbnail.jpg	1	0	f	97561	1080	720	1.50
511	IMG_7374_jK4qJj5uf-1593471756762-original-.jpg	IMG_7374_jK4qJj5uf.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7374_jK4qJj5uf-1593471756762-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7374_jK4qJj5uf-1593471756762-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7374_jK4qJj5uf-1593471756762-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7374_jK4qJj5uf-1593471756762-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7374_jK4qJj5uf-1593471756762-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7374_jK4qJj5uf-1593471756762-thumbnail.jpg	1	0	f	69852	1080	720	1.50
512	IMG_7481_fhjStzfxFa-1593471756359-original-.jpg	IMG_7481_fhjStzfxFa.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7481_fhjStzfxFa-1593471756359-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7481_fhjStzfxFa-1593471756359-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7481_fhjStzfxFa-1593471756359-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7481_fhjStzfxFa-1593471756359-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7481_fhjStzfxFa-1593471756359-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7481_fhjStzfxFa-1593471756359-thumbnail.jpg	2	1	f	136363	1080	720	1.50
513	IMG_2098_EOGiaZROy-1593471754368-original-.jpg	IMG_2098_EOGiaZROy.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2098_EOGiaZROy-1593471754368-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2098_EOGiaZROy-1593471754368-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2098_EOGiaZROy-1593471754368-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2098_EOGiaZROy-1593471754368-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2098_EOGiaZROy-1593471754368-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2098_EOGiaZROy-1593471754368-thumbnail.jpg	2	6	f	567286	1921	2660	0.72
514	IMG_7372_O3yx-RhHro-1593471757157-original-.jpg	IMG_7372_O3yx-RhHro.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7372_O3yx-RhHro-1593471757157-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7372_O3yx-RhHro-1593471757157-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7372_O3yx-RhHro-1593471757157-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7372_O3yx-RhHro-1593471757157-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7372_O3yx-RhHro-1593471757157-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7372_O3yx-RhHro-1593471757157-thumbnail.jpg	1	0	f	77592	1080	720	1.50
516	IMG_7373_od2zPE4Np5-1593471757960-original-.jpg	IMG_7373_od2zPE4Np5.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7373_od2zPE4Np5-1593471757960-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7373_od2zPE4Np5-1593471757960-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7373_od2zPE4Np5-1593471757960-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7373_od2zPE4Np5-1593471757960-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7373_od2zPE4Np5-1593471757960-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7373_od2zPE4Np5-1593471757960-thumbnail.jpg	1	0	f	74696	1080	720	1.50
517	IMG_7366_6-I5mNOlc-1593471758357-original-.jpg	IMG_7366_6-I5mNOlc.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7366_6-I5mNOlc-1593471758357-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7366_6-I5mNOlc-1593471758357-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7366_6-I5mNOlc-1593471758357-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7366_6-I5mNOlc-1593471758357-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7366_6-I5mNOlc-1593471758357-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7366_6-I5mNOlc-1593471758357-thumbnail.jpg	1	0	f	76126	1080	720	1.50
518	IMG_2300_lqfD5fQvO-1593471753581-original-.jpg	IMG_2300_lqfD5fQvO.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2300_lqfD5fQvO-1593471753581-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2300_lqfD5fQvO-1593471753581-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2300_lqfD5fQvO-1593471753581-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2300_lqfD5fQvO-1593471753581-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2300_lqfD5fQvO-1593471753581-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2300_lqfD5fQvO-1593471753581-thumbnail.jpg	1	0	f	1494976	3024	4032	0.75
519	IMG_7296_ITUqoDToLN-1593471758755-original-.jpg	IMG_7296_ITUqoDToLN.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7296_ITUqoDToLN-1593471758755-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7296_ITUqoDToLN-1593471758755-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7296_ITUqoDToLN-1593471758755-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7296_ITUqoDToLN-1593471758755-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7296_ITUqoDToLN-1593471758755-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7296_ITUqoDToLN-1593471758755-thumbnail.jpg	2	1	f	67309	1080	720	1.50
520	IMG_7294_gSq1evNrd-1593471759157-original-.jpg	IMG_7294_gSq1evNrd.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7294_gSq1evNrd-1593471759157-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7294_gSq1evNrd-1593471759157-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7294_gSq1evNrd-1593471759157-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7294_gSq1evNrd-1593471759157-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7294_gSq1evNrd-1593471759157-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7294_gSq1evNrd-1593471759157-thumbnail.jpg	2	4	f	68599	1080	720	1.50
521	IMG_2304_iW33bvn12-1593471752427-original-.jpg	IMG_2304_iW33bvn12.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2304_iW33bvn12-1593471752427-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2304_iW33bvn12-1593471752427-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2304_iW33bvn12-1593471752427-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2304_iW33bvn12-1593471752427-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2304_iW33bvn12-1593471752427-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2304_iW33bvn12-1593471752427-thumbnail.jpg	2	5	f	1726462	3024	4032	0.75
515	IMG_7362_PHqNWHG6T-1593471757558-original-.jpg	IMG_7362_PHqNWHG6T.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7362_PHqNWHG6T-1593471757558-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7362_PHqNWHG6T-1593471757558-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7362_PHqNWHG6T-1593471757558-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7362_PHqNWHG6T-1593471757558-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7362_PHqNWHG6T-1593471757558-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7362_PHqNWHG6T-1593471757558-thumbnail.jpg	1	0	f	68013	1080	720	1.50
527	IMG_7157_hBUhEf7nn-1593471760760-original-.jpg	IMG_7157_hBUhEf7nn.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7157_hBUhEf7nn-1593471760760-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7157_hBUhEf7nn-1593471760760-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7157_hBUhEf7nn-1593471760760-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7157_hBUhEf7nn-1593471760760-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7157_hBUhEf7nn-1593471760760-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7157_hBUhEf7nn-1593471760760-thumbnail.jpg	2	4	f	77547	1080	720	1.50
528	4043_2_ma3FauzLB-1593471761555-original-.jpg	4043_2_ma3FauzLB.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_2_ma3FauzLB-1593471761555-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_2_ma3FauzLB-1593471761555-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_2_ma3FauzLB-1593471761555-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_2_ma3FauzLB-1593471761555-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_2_ma3FauzLB-1593471761555-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_2_ma3FauzLB-1593471761555-thumbnail.jpg	1	0	f	62013	800	648	1.23
529	IMG_2183_tbNEV2wrQ-1593471754062-original-.jpg	IMG_2183_tbNEV2wrQ.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2183_tbNEV2wrQ-1593471754062-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2183_tbNEV2wrQ-1593471754062-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2183_tbNEV2wrQ-1593471754062-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2183_tbNEV2wrQ-1593471754062-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2183_tbNEV2wrQ-1593471754062-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2183_tbNEV2wrQ-1593471754062-thumbnail.jpg	2	4	f	2137081	3024	4032	0.75
530	4043_1_9wJOJfPX1-1593471761959-original-.jpg	4043_1_9wJOJfPX1.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_1_9wJOJfPX1-1593471761959-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_1_9wJOJfPX1-1593471761959-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_1_9wJOJfPX1-1593471761959-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_1_9wJOJfPX1-1593471761959-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_1_9wJOJfPX1-1593471761959-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_1_9wJOJfPX1-1593471761959-thumbnail.jpg	1	0	f	60776	800	467	1.71
531	IMG_2093_eLfrkkn4S-1593471754816-original-.jpg	IMG_2093_eLfrkkn4S.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2093_eLfrkkn4S-1593471754816-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2093_eLfrkkn4S-1593471754816-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2093_eLfrkkn4S-1593471754816-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2093_eLfrkkn4S-1593471754816-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2093_eLfrkkn4S-1593471754816-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2093_eLfrkkn4S-1593471754816-thumbnail.jpg	2	6	f	1013343	3024	4032	0.75
522	IMG_7280_W-yMBYoYv-1593471759556-original-.jpg	IMG_7280_W-yMBYoYv.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7280_W-yMBYoYv-1593471759556-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7280_W-yMBYoYv-1593471759556-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7280_W-yMBYoYv-1593471759556-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7280_W-yMBYoYv-1593471759556-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7280_W-yMBYoYv-1593471759556-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7280_W-yMBYoYv-1593471759556-thumbnail.jpg	2	2	f	66934	1080	720	1.50
523	IMG_7278_oFyzxFcIU-1593471759965-original-.jpg	IMG_7278_oFyzxFcIU.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7278_oFyzxFcIU-1593471759965-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7278_oFyzxFcIU-1593471759965-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7278_oFyzxFcIU-1593471759965-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7278_oFyzxFcIU-1593471759965-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7278_oFyzxFcIU-1593471759965-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7278_oFyzxFcIU-1593471759965-thumbnail.jpg	2	1	f	72255	720	1080	0.67
524	IMG_7159_Udc3wYX-d5-1593471760358-original-.jpg	IMG_7159_Udc3wYX-d5.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7159_Udc3wYX-d5-1593471760358-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7159_Udc3wYX-d5-1593471760358-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7159_Udc3wYX-d5-1593471760358-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7159_Udc3wYX-d5-1593471760358-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7159_Udc3wYX-d5-1593471760358-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7159_Udc3wYX-d5-1593471760358-thumbnail.jpg	2	3	f	78725	720	1080	0.67
525	IMG_2302_92FcSkYXqU-1593471752799-original-.jpg	IMG_2302_92FcSkYXqU.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2302_92FcSkYXqU-1593471752799-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2302_92FcSkYXqU-1593471752799-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2302_92FcSkYXqU-1593471752799-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2302_92FcSkYXqU-1593471752799-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2302_92FcSkYXqU-1593471752799-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2302_92FcSkYXqU-1593471752799-thumbnail.jpg	2	5	f	1707413	3024	4032	0.75
526	IMG_2296_US6Hq0PnX-1593471753193-original-.jpg	IMG_2296_US6Hq0PnX.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2296_US6Hq0PnX-1593471753193-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2296_US6Hq0PnX-1593471753193-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2296_US6Hq0PnX-1593471753193-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2296_US6Hq0PnX-1593471753193-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2296_US6Hq0PnX-1593471753193-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2296_US6Hq0PnX-1593471753193-thumbnail.jpg	2	4	f	1761727	3024	4032	0.75
536	4031_1_xjuqtdjwc-1593471762775-original-.jpg	4031_1_xjuqtdjwc.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4031_1_xjuqtdjwc-1593471762775-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4031_1_xjuqtdjwc-1593471762775-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4031_1_xjuqtdjwc-1593471762775-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4031_1_xjuqtdjwc-1593471762775-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4031_1_xjuqtdjwc-1593471762775-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4031_1_xjuqtdjwc-1593471762775-thumbnail.jpg	2	1	f	255942	871	1616	0.54
537	4006_2_nFtW8YekQ-1593471764390-original-.jpg	4006_2_nFtW8YekQ.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4006_2_nFtW8YekQ-1593471764390-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4006_2_nFtW8YekQ-1593471764390-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4006_2_nFtW8YekQ-1593471764390-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4006_2_nFtW8YekQ-1593471764390-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4006_2_nFtW8YekQ-1593471764390-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4006_2_nFtW8YekQ-1593471764390-thumbnail.jpg	2	1	f	73757	800	347	2.31
541	4049_2_PShTwHQJI-1593471765556-original-.jpg	4049_2_PShTwHQJI.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4049_2_PShTwHQJI-1593471765556-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4049_2_PShTwHQJI-1593471765556-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4049_2_PShTwHQJI-1593471765556-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4049_2_PShTwHQJI-1593471765556-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4049_2_PShTwHQJI-1593471765556-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4049_2_PShTwHQJI-1593471765556-thumbnail.jpg	1	0	f	73169	750	800	0.94
542	4042_2_bb_KRGpMx-1593471765954-original-.jpg	4042_2_bb_KRGpMx.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4042_2_bb_KRGpMx-1593471765954-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4042_2_bb_KRGpMx-1593471765954-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4042_2_bb_KRGpMx-1593471765954-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4042_2_bb_KRGpMx-1593471765954-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4042_2_bb_KRGpMx-1593471765954-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4042_2_bb_KRGpMx-1593471765954-thumbnail.jpg	1	0	f	48146	800	490	1.63
532	4043_3_uV-VQmw8z-1593471763160-original-.jpg	4043_3_uV-VQmw8z.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_3_uV-VQmw8z-1593471763160-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_3_uV-VQmw8z-1593471763160-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_3_uV-VQmw8z-1593471763160-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_3_uV-VQmw8z-1593471763160-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_3_uV-VQmw8z-1593471763160-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4043_3_uV-VQmw8z-1593471763160-thumbnail.jpg	1	0	f	45583	800	478	1.67
533	4038_2_IYbXQ1C-Z-1593471763555-original-.jpg	4038_2_IYbXQ1C-Z.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4038_2_IYbXQ1C-Z-1593471763555-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4038_2_IYbXQ1C-Z-1593471763555-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4038_2_IYbXQ1C-Z-1593471763555-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4038_2_IYbXQ1C-Z-1593471763555-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4038_2_IYbXQ1C-Z-1593471763555-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4038_2_IYbXQ1C-Z-1593471763555-thumbnail.jpg	1	0	f	38320	800	374	2.14
534	4004_1_4gqYihJYh-1593471761169-original-.jpg	4004_1_4gqYihJYh.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4004_1_4gqYihJYh-1593471761169-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4004_1_4gqYihJYh-1593471761169-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4004_1_4gqYihJYh-1593471761169-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4004_1_4gqYihJYh-1593471761169-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4004_1_4gqYihJYh-1593471761169-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4004_1_4gqYihJYh-1593471761169-thumbnail.jpg	1	0	f	668649	2749	1443	1.91
535	4038_1_O4d5DiCy6-1593471763957-original-.jpg	4038_1_O4d5DiCy6.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4038_1_O4d5DiCy6-1593471763957-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4038_1_O4d5DiCy6-1593471763957-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4038_1_O4d5DiCy6-1593471763957-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4038_1_O4d5DiCy6-1593471763957-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4038_1_O4d5DiCy6-1593471763957-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4038_1_O4d5DiCy6-1593471763957-thumbnail.jpg	1	0	f	65650	800	463	1.73
538	4049_1_EYE4zAo6px-1593471765159-original-.jpg	4049_1_EYE4zAo6px.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4049_1_EYE4zAo6px-1593471765159-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4049_1_EYE4zAo6px-1593471765159-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4049_1_EYE4zAo6px-1593471765159-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4049_1_EYE4zAo6px-1593471765159-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4049_1_EYE4zAo6px-1593471765159-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4049_1_EYE4zAo6px-1593471765159-thumbnail.jpg	1	0	f	34705	469	532	0.88
539	4031_2_z9mG83ASe-1593471764756-original-.jpg	4031_2_z9mG83ASe.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4031_2_z9mG83ASe-1593471764756-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4031_2_z9mG83ASe-1593471764756-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4031_2_z9mG83ASe-1593471764756-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4031_2_z9mG83ASe-1593471764756-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4031_2_z9mG83ASe-1593471764756-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4031_2_z9mG83ASe-1593471764756-thumbnail.jpg	1	0	f	91155	431	800	0.54
540	4050_1_yaQXBl2fC-1593471762371-original-.jpg	4050_1_yaQXBl2fC.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4050_1_yaQXBl2fC-1593471762371-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4050_1_yaQXBl2fC-1593471762371-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4050_1_yaQXBl2fC-1593471762371-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4050_1_yaQXBl2fC-1593471762371-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4050_1_yaQXBl2fC-1593471762371-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4050_1_yaQXBl2fC-1593471762371-thumbnail.jpg	2	1	f	569076	2080	1789	1.16
545	4045_1_Ie97-f4vt-1593471767961-original-.jpg	4045_1_Ie97-f4vt.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4045_1_Ie97-f4vt-1593471767961-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4045_1_Ie97-f4vt-1593471767961-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4045_1_Ie97-f4vt-1593471767961-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4045_1_Ie97-f4vt-1593471767961-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4045_1_Ie97-f4vt-1593471767961-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4045_1_Ie97-f4vt-1593471767961-thumbnail.jpg	1	0	f	28988	475	526	0.90
543	4044_1_-V1tbGNem-1593471766359-original-.jpg	4044_1_-V1tbGNem.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4044_1_-V1tbGNem-1593471766359-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4044_1_-V1tbGNem-1593471766359-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4044_1_-V1tbGNem-1593471766359-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4044_1_-V1tbGNem-1593471766359-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4044_1_-V1tbGNem-1593471766359-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4044_1_-V1tbGNem-1593471766359-thumbnail.jpg	1	0	f	71460	800	782	1.02
544	4040_2_fDMMu4cdo-1593471767158-original-.jpg	4040_2_fDMMu4cdo.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4040_2_fDMMu4cdo-1593471767158-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4040_2_fDMMu4cdo-1593471767158-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4040_2_fDMMu4cdo-1593471767158-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4040_2_fDMMu4cdo-1593471767158-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4040_2_fDMMu4cdo-1593471767158-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4040_2_fDMMu4cdo-1593471767158-thumbnail.jpg	1	0	f	51896	800	473	1.69
546	4044_2_7BfLmH7sd-1593471766751-original-.jpg	4044_2_7BfLmH7sd.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4044_2_7BfLmH7sd-1593471766751-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4044_2_7BfLmH7sd-1593471766751-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4044_2_7BfLmH7sd-1593471766751-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4044_2_7BfLmH7sd-1593471766751-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4044_2_7BfLmH7sd-1593471766751-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4044_2_7BfLmH7sd-1593471766751-thumbnail.jpg	1	0	f	100051	709	800	0.89
547	4040_1_caR9TfglqH-1593471767556-original-.jpg	4040_1_caR9TfglqH.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4040_1_caR9TfglqH-1593471767556-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4040_1_caR9TfglqH-1593471767556-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4040_1_caR9TfglqH-1593471767556-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4040_1_caR9TfglqH-1593471767556-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4040_1_caR9TfglqH-1593471767556-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4040_1_caR9TfglqH-1593471767556-thumbnail.jpg	1	0	f	57376	800	501	1.60
548	4045_2_LlHWrhfxKH-1593471768358-original-.jpg	4045_2_LlHWrhfxKH.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4045_2_LlHWrhfxKH-1593471768358-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4045_2_LlHWrhfxKH-1593471768358-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4045_2_LlHWrhfxKH-1593471768358-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4045_2_LlHWrhfxKH-1593471768358-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4045_2_LlHWrhfxKH-1593471768358-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4045_2_LlHWrhfxKH-1593471768358-thumbnail.jpg	1	0	f	23265	506	493	1.03
549	4007_V_PhsWuoM-1593471769160-original-.jpg	4007_V_PhsWuoM.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4007_V_PhsWuoM-1593471769160-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4007_V_PhsWuoM-1593471769160-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4007_V_PhsWuoM-1593471769160-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4007_V_PhsWuoM-1593471769160-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4007_V_PhsWuoM-1593471769160-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4007_V_PhsWuoM-1593471769160-thumbnail.jpg	2	1	f	61611	800	314	2.55
550	4050_2_hOi236SYxh-1593471768761-original-.jpg	4050_2_hOi236SYxh.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4050_2_hOi236SYxh-1593471768761-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4050_2_hOi236SYxh-1593471768761-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4050_2_hOi236SYxh-1593471768761-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4050_2_hOi236SYxh-1593471768761-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4050_2_hOi236SYxh-1593471768761-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4050_2_hOi236SYxh-1593471768761-thumbnail.jpg	2	1	f	129388	800	714	1.12
551	4042_1_d1I7v6Kl--1593471769961-original-.jpg	4042_1_d1I7v6Kl-.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4042_1_d1I7v6Kl--1593471769961-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4042_1_d1I7v6Kl--1593471769961-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4042_1_d1I7v6Kl--1593471769961-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4042_1_d1I7v6Kl--1593471769961-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4042_1_d1I7v6Kl--1593471769961-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4042_1_d1I7v6Kl--1593471769961-thumbnail.jpg	1	0	f	54899	800	455	1.76
552	4046_1_yuOynK0wM-1593471770360-original-.jpg	4046_1_yuOynK0wM.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4046_1_yuOynK0wM-1593471770360-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4046_1_yuOynK0wM-1593471770360-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4046_1_yuOynK0wM-1593471770360-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4046_1_yuOynK0wM-1593471770360-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4046_1_yuOynK0wM-1593471770360-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4046_1_yuOynK0wM-1593471770360-thumbnail.jpg	1	0	f	46176	800	679	1.18
553	4047_2_JA3fJ-0Ta-1593471770803-original-.jpg	4047_2_JA3fJ-0Ta.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4047_2_JA3fJ-0Ta-1593471770803-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4047_2_JA3fJ-0Ta-1593471770803-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4047_2_JA3fJ-0Ta-1593471770803-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4047_2_JA3fJ-0Ta-1593471770803-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4047_2_JA3fJ-0Ta-1593471770803-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4047_2_JA3fJ-0Ta-1593471770803-thumbnail.jpg	2	1	f	36844	519	800	0.65
554	4041_2_gLImKMLXE-1593471771158-original-.jpg	4041_2_gLImKMLXE.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4041_2_gLImKMLXE-1593471771158-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4041_2_gLImKMLXE-1593471771158-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4041_2_gLImKMLXE-1593471771158-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4041_2_gLImKMLXE-1593471771158-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4041_2_gLImKMLXE-1593471771158-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4041_2_gLImKMLXE-1593471771158-thumbnail.jpg	1	0	f	55537	800	514	1.56
555	4046_2_460lKPTqdP-1593471771959-original-.jpg	4046_2_460lKPTqdP.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4046_2_460lKPTqdP-1593471771959-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4046_2_460lKPTqdP-1593471771959-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4046_2_460lKPTqdP-1593471771959-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4046_2_460lKPTqdP-1593471771959-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4046_2_460lKPTqdP-1593471771959-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4046_2_460lKPTqdP-1593471771959-thumbnail.jpg	1	0	f	28406	800	314	2.55
556	4041_1_ASGcFwJtx-1593471771557-original-.jpg	4041_1_ASGcFwJtx.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4041_1_ASGcFwJtx-1593471771557-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4041_1_ASGcFwJtx-1593471771557-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4041_1_ASGcFwJtx-1593471771557-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4041_1_ASGcFwJtx-1593471771557-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4041_1_ASGcFwJtx-1593471771557-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4041_1_ASGcFwJtx-1593471771557-thumbnail.jpg	1	0	f	70943	800	527	1.52
557	4039_1_SAshl4bLD-1593471772362-original-.jpg	4039_1_SAshl4bLD.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4039_1_SAshl4bLD-1593471772362-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4039_1_SAshl4bLD-1593471772362-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4039_1_SAshl4bLD-1593471772362-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4039_1_SAshl4bLD-1593471772362-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4039_1_SAshl4bLD-1593471772362-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4039_1_SAshl4bLD-1593471772362-thumbnail.jpg	1	0	f	84627	800	427	1.87
558	IMG_1943_OdhadMlV--1593471772759-original-.jpg	IMG_1943_OdhadMlV-.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1943_OdhadMlV--1593471772759-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1943_OdhadMlV--1593471772759-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1943_OdhadMlV--1593471772759-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1943_OdhadMlV--1593471772759-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1943_OdhadMlV--1593471772759-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1943_OdhadMlV--1593471772759-thumbnail.jpg	1	0	f	83750	720	1080	0.67
559	4006_1_ySG5kwcq5-1593471769572-original-.jpg	4006_1_ySG5kwcq5.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4006_1_ySG5kwcq5-1593471769572-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4006_1_ySG5kwcq5-1593471769572-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4006_1_ySG5kwcq5-1593471769572-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4006_1_ySG5kwcq5-1593471769572-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4006_1_ySG5kwcq5-1593471769572-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4006_1_ySG5kwcq5-1593471769572-thumbnail.jpg	1	0	f	818880	3673	1591	2.31
560	IMG_1998_NMHR5XxYDv-1593471773592-original-.jpg	IMG_1998_NMHR5XxYDv.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1998_NMHR5XxYDv-1593471773592-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1998_NMHR5XxYDv-1593471773592-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1998_NMHR5XxYDv-1593471773592-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1998_NMHR5XxYDv-1593471773592-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1998_NMHR5XxYDv-1593471773592-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1998_NMHR5XxYDv-1593471773592-thumbnail.jpg	2	1	f	72925	720	1080	0.67
561	IMG_7095_ljnbj8xgq-1593471773599-original-.jpg	IMG_7095_ljnbj8xgq.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7095_ljnbj8xgq-1593471773599-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7095_ljnbj8xgq-1593471773599-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7095_ljnbj8xgq-1593471773599-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7095_ljnbj8xgq-1593471773599-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7095_ljnbj8xgq-1593471773599-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7095_ljnbj8xgq-1593471773599-thumbnail.jpg	2	5	f	86150	720	1080	0.67
562	IMG_1675_kgGP2N_oKy-1593471774783-original-.jpg	IMG_1675_kgGP2N_oKy.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1675_kgGP2N_oKy-1593471774783-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1675_kgGP2N_oKy-1593471774783-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1675_kgGP2N_oKy-1593471774783-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1675_kgGP2N_oKy-1593471774783-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1675_kgGP2N_oKy-1593471774783-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1675_kgGP2N_oKy-1593471774783-thumbnail.jpg	2	4	f	73137	720	1080	0.67
578	IMG_7132_3BKOLEHk8-1593471781560-original-.jpg	IMG_7132_3BKOLEHk8.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7132_3BKOLEHk8-1593471781560-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7132_3BKOLEHk8-1593471781560-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7132_3BKOLEHk8-1593471781560-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7132_3BKOLEHk8-1593471781560-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7132_3BKOLEHk8-1593471781560-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7132_3BKOLEHk8-1593471781560-thumbnail.jpg	2	5	f	87550	1080	720	1.50
579	G05926-3_qQDpFny6x-1593471779558-original-.png	G05926-3_qQDpFny6x.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05926-3_qQDpFny6x-1593471779558-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05926-3_qQDpFny6x-1593471779558-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05926-3_qQDpFny6x-1593471779558-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05926-3_qQDpFny6x-1593471779558-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05926-3_qQDpFny6x-1593471779558-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05926-3_qQDpFny6x-1593471779558-thumbnail.png	2	2	f	55440	1080	1080	1.00
580	IMG_2220_5qp5yFazw-1593471778449-original-.jpg	IMG_2220_5qp5yFazw.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2220_5qp5yFazw-1593471778449-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2220_5qp5yFazw-1593471778449-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2220_5qp5yFazw-1593471778449-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2220_5qp5yFazw-1593471778449-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2220_5qp5yFazw-1593471778449-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2220_5qp5yFazw-1593471778449-thumbnail.jpg	2	1	f	1654080	3024	4032	0.75
581	4070_-_CGA_FK010_PT_-_verso_fAeUcQk7C-1593471781979-original-.jpg	4070_-_CGA_FK010_PT_-_verso_fAeUcQk7C.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4070_-_CGA_FK010_PT_-_verso_fAeUcQk7C-1593471781979-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4070_-_CGA_FK010_PT_-_verso_fAeUcQk7C-1593471781979-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4070_-_CGA_FK010_PT_-_verso_fAeUcQk7C-1593471781979-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4070_-_CGA_FK010_PT_-_verso_fAeUcQk7C-1593471781979-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4070_-_CGA_FK010_PT_-_verso_fAeUcQk7C-1593471781979-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4070_-_CGA_FK010_PT_-_verso_fAeUcQk7C-1593471781979-thumbnail.jpg	2	1	f	945909	4416	2486	1.78
582	cj-ondenaopuderesamar_IqezeHDPN-1593471787954-original-.jpg	cj-ondenaopuderesamar_IqezeHDPN.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar_IqezeHDPN-1593471787954-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar_IqezeHDPN-1593471787954-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar_IqezeHDPN-1593471787954-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar_IqezeHDPN-1593471787954-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar_IqezeHDPN-1593471787954-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar_IqezeHDPN-1593471787954-thumbnail.jpg	1	0	f	48698	960	1280	0.75
599	cj-ondenaopuderesamar_p78zh6iQ6-1593471791560-original-.jpg	cj-ondenaopuderesamar_p78zh6iQ6.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar_p78zh6iQ6-1593471791560-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar_p78zh6iQ6-1593471791560-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar_p78zh6iQ6-1593471791560-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar_p78zh6iQ6-1593471791560-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar_p78zh6iQ6-1593471791560-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar_p78zh6iQ6-1593471791560-thumbnail.jpg	1	0	f	57642	1100	1100	1.00
563	IMG_3962_EF2vs9AtI-1593471773966-original-.jpg	IMG_3962_EF2vs9AtI.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_3962_EF2vs9AtI-1593471773966-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_3962_EF2vs9AtI-1593471773966-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_3962_EF2vs9AtI-1593471773966-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_3962_EF2vs9AtI-1593471773966-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_3962_EF2vs9AtI-1593471773966-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_3962_EF2vs9AtI-1593471773966-thumbnail.jpg	2	7	f	141568	810	1080	0.75
564	IMG_1875_Klj1Jtbmo-1593471774357-original-.jpg	IMG_1875_Klj1Jtbmo.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1875_Klj1Jtbmo-1593471774357-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1875_Klj1Jtbmo-1593471774357-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1875_Klj1Jtbmo-1593471774357-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1875_Klj1Jtbmo-1593471774357-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1875_Klj1Jtbmo-1593471774357-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1875_Klj1Jtbmo-1593471774357-thumbnail.jpg	2	1	f	122433	720	1080	0.67
565	IMG_1599_SoTxWQ8RO-1593471775197-original-.jpg	IMG_1599_SoTxWQ8RO.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1599_SoTxWQ8RO-1593471775197-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1599_SoTxWQ8RO-1593471775197-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1599_SoTxWQ8RO-1593471775197-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1599_SoTxWQ8RO-1593471775197-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1599_SoTxWQ8RO-1593471775197-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1599_SoTxWQ8RO-1593471775197-thumbnail.jpg	2	2	f	83893	720	1080	0.67
566	IMG_1802_Rx-6uafHC-1593471775562-original-.jpg	IMG_1802_Rx-6uafHC.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1802_Rx-6uafHC-1593471775562-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1802_Rx-6uafHC-1593471775562-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1802_Rx-6uafHC-1593471775562-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1802_Rx-6uafHC-1593471775562-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1802_Rx-6uafHC-1593471775562-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1802_Rx-6uafHC-1593471775562-thumbnail.jpg	2	2	f	92998	720	1080	0.67
567	IMG_1639_ukwzYGsVQE-1593471775959-original-.jpg	IMG_1639_ukwzYGsVQE.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1639_ukwzYGsVQE-1593471775959-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1639_ukwzYGsVQE-1593471775959-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1639_ukwzYGsVQE-1593471775959-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1639_ukwzYGsVQE-1593471775959-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1639_ukwzYGsVQE-1593471775959-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1639_ukwzYGsVQE-1593471775959-thumbnail.jpg	2	2	f	76577	720	1080	0.67
568	IMG_1474_5r_mePpC9-1593471776361-original-.jpg	IMG_1474_5r_mePpC9.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1474_5r_mePpC9-1593471776361-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1474_5r_mePpC9-1593471776361-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1474_5r_mePpC9-1593471776361-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1474_5r_mePpC9-1593471776361-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1474_5r_mePpC9-1593471776361-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1474_5r_mePpC9-1593471776361-thumbnail.jpg	2	3	f	77324	720	1080	0.67
569	IMG_1439_le93daYY_-1593471776768-original-.jpg	IMG_1439_le93daYY_.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1439_le93daYY_-1593471776768-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1439_le93daYY_-1593471776768-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1439_le93daYY_-1593471776768-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1439_le93daYY_-1593471776768-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1439_le93daYY_-1593471776768-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1439_le93daYY_-1593471776768-thumbnail.jpg	2	6	f	87774	720	1080	0.67
570	C00234-3_n_O9L7xQw-1593471778757-original-.png	C00234-3_n_O9L7xQw.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/C00234-3_n_O9L7xQw-1593471778757-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/C00234-3_n_O9L7xQw-1593471778757-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/C00234-3_n_O9L7xQw-1593471778757-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/C00234-3_n_O9L7xQw-1593471778757-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/C00234-3_n_O9L7xQw-1593471778757-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/C00234-3_n_O9L7xQw-1593471778757-thumbnail.png	2	1	f	35742	1080	1080	1.00
571	C00239-3_mYBw5iTYrO-1593471779161-original-.png	C00239-3_mYBw5iTYrO.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/C00239-3_mYBw5iTYrO-1593471779161-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/C00239-3_mYBw5iTYrO-1593471779161-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/C00239-3_mYBw5iTYrO-1593471779161-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/C00239-3_mYBw5iTYrO-1593471779161-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/C00239-3_mYBw5iTYrO-1593471779161-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/C00239-3_mYBw5iTYrO-1593471779161-thumbnail.png	2	1	f	40773	1080	1080	1.00
572	IMG_2257_ONwxU2RY1-1593471777563-original-.jpg	IMG_2257_ONwxU2RY1.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2257_ONwxU2RY1-1593471777563-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2257_ONwxU2RY1-1593471777563-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2257_ONwxU2RY1-1593471777563-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2257_ONwxU2RY1-1593471777563-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2257_ONwxU2RY1-1593471777563-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2257_ONwxU2RY1-1593471777563-thumbnail.jpg	2	2	f	524183	2502	1987	1.26
573	G05938-3_eVEl1rued-1593471779995-original-.png	G05938-3_eVEl1rued.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05938-3_eVEl1rued-1593471779995-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05938-3_eVEl1rued-1593471779995-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05938-3_eVEl1rued-1593471779995-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05938-3_eVEl1rued-1593471779995-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05938-3_eVEl1rued-1593471779995-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05938-3_eVEl1rued-1593471779995-thumbnail.png	2	2	f	59167	1080	1080	1.00
574	G05925-3__Y1GQqZMZ-1593471780358-original-.png	G05925-3__Y1GQqZMZ.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05925-3__Y1GQqZMZ-1593471780358-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05925-3__Y1GQqZMZ-1593471780358-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05925-3__Y1GQqZMZ-1593471780358-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05925-3__Y1GQqZMZ-1593471780358-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05925-3__Y1GQqZMZ-1593471780358-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05925-3__Y1GQqZMZ-1593471780358-thumbnail.png	2	2	f	67256	1080	1080	1.00
575	4039_2_cxFb1HP_2i-1593471781160-original-.jpg	4039_2_cxFb1HP_2i.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4039_2_cxFb1HP_2i-1593471781160-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4039_2_cxFb1HP_2i-1593471781160-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4039_2_cxFb1HP_2i-1593471781160-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4039_2_cxFb1HP_2i-1593471781160-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4039_2_cxFb1HP_2i-1593471781160-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4039_2_cxFb1HP_2i-1593471781160-thumbnail.jpg	1	0	f	41716	800	346	2.31
576	IMG_2250_huyWZCQFE-1593471777223-original-.jpg	IMG_2250_huyWZCQFE.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2250_huyWZCQFE-1593471777223-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2250_huyWZCQFE-1593471777223-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2250_huyWZCQFE-1593471777223-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2250_huyWZCQFE-1593471777223-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2250_huyWZCQFE-1593471777223-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2250_huyWZCQFE-1593471777223-thumbnail.jpg	2	1	f	840640	3024	4032	0.75
577	G05923-3_YNN38gF9Z-1593471780761-original-.png	G05923-3_YNN38gF9Z.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05923-3_YNN38gF9Z-1593471780761-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05923-3_YNN38gF9Z-1593471780761-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05923-3_YNN38gF9Z-1593471780761-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05923-3_YNN38gF9Z-1593471780761-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05923-3_YNN38gF9Z-1593471780761-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05923-3_YNN38gF9Z-1593471780761-thumbnail.png	2	2	f	91353	1080	1080	1.00
583	4076_-_BEG_FK010_AZ_-_verso_LkmhQDkiF-1593471782789-original-.jpg	4076_-_BEG_FK010_AZ_-_verso_LkmhQDkiF.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4076_-_BEG_FK010_AZ_-_verso_LkmhQDkiF-1593471782789-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4076_-_BEG_FK010_AZ_-_verso_LkmhQDkiF-1593471782789-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4076_-_BEG_FK010_AZ_-_verso_LkmhQDkiF-1593471782789-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4076_-_BEG_FK010_AZ_-_verso_LkmhQDkiF-1593471782789-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4076_-_BEG_FK010_AZ_-_verso_LkmhQDkiF-1593471782789-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4076_-_BEG_FK010_AZ_-_verso_LkmhQDkiF-1593471782789-thumbnail.jpg	2	1	f	1156281	4176	2723	1.53
584	cj-ondenaopuderemamar3_jxpOTLTLl-1593471788359-original-.jpg	cj-ondenaopuderemamar3_jxpOTLTLl.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderemamar3_jxpOTLTLl-1593471788359-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderemamar3_jxpOTLTLl-1593471788359-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderemamar3_jxpOTLTLl-1593471788359-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderemamar3_jxpOTLTLl-1593471788359-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderemamar3_jxpOTLTLl-1593471788359-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderemamar3_jxpOTLTLl-1593471788359-thumbnail.jpg	2	1	f	76037	960	1280	0.75
586	6114_-_Almof_FK009_C_-_verso_mxwDgKF90-1593471784484-original-.jpg	6114_-_Almof_FK009_C_-_verso_mxwDgKF90.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_verso_mxwDgKF90-1593471784484-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_verso_mxwDgKF90-1593471784484-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_verso_mxwDgKF90-1593471784484-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_verso_mxwDgKF90-1593471784484-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_verso_mxwDgKF90-1593471784484-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_verso_mxwDgKF90-1593471784484-thumbnail.jpg	1	0	f	612920	2993	2975	1.01
587	g05926_-nyClLSdA-1593471789959-original-.jpg	g05926_-nyClLSdA.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/g05926_-nyClLSdA-1593471789959-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/g05926_-nyClLSdA-1593471789959-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/g05926_-nyClLSdA-1593471789959-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/g05926_-nyClLSdA-1593471789959-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/g05926_-nyClLSdA-1593471789959-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/g05926_-nyClLSdA-1593471789959-thumbnail.jpg	1	0	f	15819	800	800	1.00
588	conjunto-coracao2_qQO8LWFuaZ-1593471788763-original-.jpg	conjunto-coracao2_qQO8LWFuaZ.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao2_qQO8LWFuaZ-1593471788763-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao2_qQO8LWFuaZ-1593471788763-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao2_qQO8LWFuaZ-1593471788763-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao2_qQO8LWFuaZ-1593471788763-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao2_qQO8LWFuaZ-1593471788763-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao2_qQO8LWFuaZ-1593471788763-thumbnail.jpg	2	1	f	75651	960	1280	0.75
589	6117_-_Almof_FK010_AZ_-_verso_GT13WZ3Bp-1593471785214-original-.jpg	6117_-_Almof_FK010_AZ_-_verso_GT13WZ3Bp.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6117_-_Almof_FK010_AZ_-_verso_GT13WZ3Bp-1593471785214-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6117_-_Almof_FK010_AZ_-_verso_GT13WZ3Bp-1593471785214-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6117_-_Almof_FK010_AZ_-_verso_GT13WZ3Bp-1593471785214-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6117_-_Almof_FK010_AZ_-_verso_GT13WZ3Bp-1593471785214-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6117_-_Almof_FK010_AZ_-_verso_GT13WZ3Bp-1593471785214-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6117_-_Almof_FK010_AZ_-_verso_GT13WZ3Bp-1593471785214-thumbnail.jpg	1	0	f	677802	3040	2956	1.03
591	6114_-_Almof_FK009_C_-_frente_FHhM_BVRJ-1593471783611-original-.jpg	6114_-_Almof_FK009_C_-_frente_FHhM_BVRJ.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_frente_FHhM_BVRJ-1593471783611-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_frente_FHhM_BVRJ-1593471783611-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_frente_FHhM_BVRJ-1593471783611-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_frente_FHhM_BVRJ-1593471783611-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_frente_FHhM_BVRJ-1593471783611-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_frente_FHhM_BVRJ-1593471783611-thumbnail.jpg	1	0	f	1195559	3440	3088	1.11
602	6116_-_Almof_FK010_PT_-_frente_wmnDeNDSE-1593471786382-original-.jpg	6116_-_Almof_FK010_PT_-_frente_wmnDeNDSE.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6116_-_Almof_FK010_PT_-_frente_wmnDeNDSE-1593471786382-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6116_-_Almof_FK010_PT_-_frente_wmnDeNDSE-1593471786382-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6116_-_Almof_FK010_PT_-_frente_wmnDeNDSE-1593471786382-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6116_-_Almof_FK010_PT_-_frente_wmnDeNDSE-1593471786382-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6116_-_Almof_FK010_PT_-_frente_wmnDeNDSE-1593471786382-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6116_-_Almof_FK010_PT_-_frente_wmnDeNDSE-1593471786382-thumbnail.jpg	1	0	f	1128757	3273	3103	1.05
585	4070_-_CGA_FK010_PT_-_frente_qq0xBNOe4-1593471782382-original-.jpg	4070_-_CGA_FK010_PT_-_frente_qq0xBNOe4.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4070_-_CGA_FK010_PT_-_frente_qq0xBNOe4-1593471782382-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4070_-_CGA_FK010_PT_-_frente_qq0xBNOe4-1593471782382-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4070_-_CGA_FK010_PT_-_frente_qq0xBNOe4-1593471782382-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4070_-_CGA_FK010_PT_-_frente_qq0xBNOe4-1593471782382-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4070_-_CGA_FK010_PT_-_frente_qq0xBNOe4-1593471782382-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4070_-_CGA_FK010_PT_-_frente_qq0xBNOe4-1593471782382-thumbnail.jpg	2	1	f	1234921	4623	2749	1.68
592	6114_-_Almof_FK009_C_-_frente_yMqLtQkZS-1593471784000-original-.jpg	6114_-_Almof_FK009_C_-_frente_yMqLtQkZS.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_frente_yMqLtQkZS-1593471784000-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_frente_yMqLtQkZS-1593471784000-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_frente_yMqLtQkZS-1593471784000-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_frente_yMqLtQkZS-1593471784000-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_frente_yMqLtQkZS-1593471784000-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6114_-_Almof_FK009_C_-_frente_yMqLtQkZS-1593471784000-thumbnail.jpg	1	0	f	1195559	3440	3088	1.11
590	conjunto-coracao1_o61Cs-8wku-1593471789155-original-.jpg	conjunto-coracao1_o61Cs-8wku.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao1_o61Cs-8wku-1593471789155-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao1_o61Cs-8wku-1593471789155-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao1_o61Cs-8wku-1593471789155-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao1_o61Cs-8wku-1593471789155-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao1_o61Cs-8wku-1593471789155-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao1_o61Cs-8wku-1593471789155-thumbnail.jpg	2	1	f	63566	960	1280	0.75
593	6115_-_Almof_FK009_AM_-_verso_yOLQSI2L4-1593471785974-original-.jpg	6115_-_Almof_FK009_AM_-_verso_yOLQSI2L4.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6115_-_Almof_FK009_AM_-_verso_yOLQSI2L4-1593471785974-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6115_-_Almof_FK009_AM_-_verso_yOLQSI2L4-1593471785974-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6115_-_Almof_FK009_AM_-_verso_yOLQSI2L4-1593471785974-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6115_-_Almof_FK009_AM_-_verso_yOLQSI2L4-1593471785974-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6115_-_Almof_FK009_AM_-_verso_yOLQSI2L4-1593471785974-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6115_-_Almof_FK009_AM_-_verso_yOLQSI2L4-1593471785974-thumbnail.jpg	1	0	f	388455	3487	3216	1.08
594	conjunto-coracao03_zcvCPFNi1n-1593471789560-original-.jpg	conjunto-coracao03_zcvCPFNi1n.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao03_zcvCPFNi1n-1593471789560-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao03_zcvCPFNi1n-1593471789560-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao03_zcvCPFNi1n-1593471789560-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao03_zcvCPFNi1n-1593471789560-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao03_zcvCPFNi1n-1593471789560-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao03_zcvCPFNi1n-1593471789560-thumbnail.jpg	2	1	f	48904	960	1280	0.75
595	6116_-_Almof_FK010_PT_-_verso_z2FqFBf97-1593471786769-original-.jpg	6116_-_Almof_FK010_PT_-_verso_z2FqFBf97.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6116_-_Almof_FK010_PT_-_verso_z2FqFBf97-1593471786769-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6116_-_Almof_FK010_PT_-_verso_z2FqFBf97-1593471786769-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6116_-_Almof_FK010_PT_-_verso_z2FqFBf97-1593471786769-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6116_-_Almof_FK010_PT_-_verso_z2FqFBf97-1593471786769-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6116_-_Almof_FK010_PT_-_verso_z2FqFBf97-1593471786769-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6116_-_Almof_FK010_PT_-_verso_z2FqFBf97-1593471786769-thumbnail.jpg	1	0	f	334262	3014	3051	0.99
596	6115_-_Almof_FK009_AM_-_frente_AcNDm-1bQ-1593471785603-original-.jpg	6115_-_Almof_FK009_AM_-_frente_AcNDm-1bQ.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6115_-_Almof_FK009_AM_-_frente_AcNDm-1bQ-1593471785603-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6115_-_Almof_FK009_AM_-_frente_AcNDm-1bQ-1593471785603-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6115_-_Almof_FK009_AM_-_frente_AcNDm-1bQ-1593471785603-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6115_-_Almof_FK009_AM_-_frente_AcNDm-1bQ-1593471785603-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6115_-_Almof_FK009_AM_-_frente_AcNDm-1bQ-1593471785603-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6115_-_Almof_FK009_AM_-_frente_AcNDm-1bQ-1593471785603-thumbnail.jpg	1	0	f	1128167	3201	3116	1.03
597	6113_-_Almof_FK009_PT_-_frente_8LCmVvYbT-1593471787171-original-.jpg	6113_-_Almof_FK009_PT_-_frente_8LCmVvYbT.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6113_-_Almof_FK009_PT_-_frente_8LCmVvYbT-1593471787171-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6113_-_Almof_FK009_PT_-_frente_8LCmVvYbT-1593471787171-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6113_-_Almof_FK009_PT_-_frente_8LCmVvYbT-1593471787171-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6113_-_Almof_FK009_PT_-_frente_8LCmVvYbT-1593471787171-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6113_-_Almof_FK009_PT_-_frente_8LCmVvYbT-1593471787171-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6113_-_Almof_FK009_PT_-_frente_8LCmVvYbT-1593471787171-thumbnail.jpg	1	0	f	909742	3121	3108	1.00
598	4076_-_BEG_FK010_AZ_-_frente_HZXGF9Nav-1593471783186-original-.jpg	4076_-_BEG_FK010_AZ_-_frente_HZXGF9Nav.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4076_-_BEG_FK010_AZ_-_frente_HZXGF9Nav-1593471783186-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4076_-_BEG_FK010_AZ_-_frente_HZXGF9Nav-1593471783186-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4076_-_BEG_FK010_AZ_-_frente_HZXGF9Nav-1593471783186-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4076_-_BEG_FK010_AZ_-_frente_HZXGF9Nav-1593471783186-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4076_-_BEG_FK010_AZ_-_frente_HZXGF9Nav-1593471783186-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4076_-_BEG_FK010_AZ_-_frente_HZXGF9Nav-1593471783186-thumbnail.jpg	2	1	f	1070403	4042	2524	1.60
601	CADERNETA_G_FRIDA_KAHLO_2018-01_PleJ5IsUL-1593471790362-original-.jpg	CADERNETA_G_FRIDA_KAHLO_2018-01_PleJ5IsUL.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/CADERNETA_G_FRIDA_KAHLO_2018-01_PleJ5IsUL-1593471790362-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/CADERNETA_G_FRIDA_KAHLO_2018-01_PleJ5IsUL-1593471790362-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/CADERNETA_G_FRIDA_KAHLO_2018-01_PleJ5IsUL-1593471790362-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/CADERNETA_G_FRIDA_KAHLO_2018-01_PleJ5IsUL-1593471790362-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/CADERNETA_G_FRIDA_KAHLO_2018-01_PleJ5IsUL-1593471790362-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/CADERNETA_G_FRIDA_KAHLO_2018-01_PleJ5IsUL-1593471790362-thumbnail.jpg	2	2	f	317366	909	1191	0.76
607	conjunto-coracao_ChhnlSe6r-1593471793558-original-.jpg	conjunto-coracao_ChhnlSe6r.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao_ChhnlSe6r-1593471793558-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao_ChhnlSe6r-1593471793558-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao_ChhnlSe6r-1593471793558-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao_ChhnlSe6r-1593471793558-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao_ChhnlSe6r-1593471793558-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao_ChhnlSe6r-1593471793558-thumbnail.jpg	2	1	f	54637	1100	1100	1.00
609	1894_-_P_Porta_Cactus_05_lQmLvXsD9-1593471793957-original-.jpg	1894_-_P_Porta_Cactus_05_lQmLvXsD9.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1894_-_P_Porta_Cactus_05_lQmLvXsD9-1593471793957-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1894_-_P_Porta_Cactus_05_lQmLvXsD9-1593471793957-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1894_-_P_Porta_Cactus_05_lQmLvXsD9-1593471793957-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1894_-_P_Porta_Cactus_05_lQmLvXsD9-1593471793957-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1894_-_P_Porta_Cactus_05_lQmLvXsD9-1593471793957-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1894_-_P_Porta_Cactus_05_lQmLvXsD9-1593471793957-thumbnail.jpg	2	1	f	53441	649	1000	0.65
600	cj-ondenaopuderemamar3_0MYZL1piN-1593471791956-original-.jpg	cj-ondenaopuderemamar3_0MYZL1piN.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderemamar3_0MYZL1piN-1593471791956-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderemamar3_0MYZL1piN-1593471791956-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderemamar3_0MYZL1piN-1593471791956-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderemamar3_0MYZL1piN-1593471791956-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderemamar3_0MYZL1piN-1593471791956-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderemamar3_0MYZL1piN-1593471791956-thumbnail.jpg	2	1	f	65799	1280	1280	1.00
606	cj-ondenaopuderesamar2_zZ6JTn8tf-1593471793170-original-.jpg	cj-ondenaopuderesamar2_zZ6JTn8tf.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar2_zZ6JTn8tf-1593471793170-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar2_zZ6JTn8tf-1593471793170-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar2_zZ6JTn8tf-1593471793170-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar2_zZ6JTn8tf-1593471793170-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar2_zZ6JTn8tf-1593471793170-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar2_zZ6JTn8tf-1593471793170-thumbnail.jpg	2	1	f	67120	1100	1100	1.00
622	argola-ondulada_fjViRo-vh-1593471797158-original-.jpg	argola-ondulada_fjViRo-vh.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-ondulada_fjViRo-vh-1593471797158-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-ondulada_fjViRo-vh-1593471797158-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-ondulada_fjViRo-vh-1593471797158-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-ondulada_fjViRo-vh-1593471797158-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-ondulada_fjViRo-vh-1593471797158-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-ondulada_fjViRo-vh-1593471797158-thumbnail.jpg	2	1	f	111753	3024	2397	1.26
603	CADERNETA_G_FRIDA_KAHLO_2018-02_SJzcES-Cb-1593471790760-original-.jpg	CADERNETA_G_FRIDA_KAHLO_2018-02_SJzcES-Cb.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/CADERNETA_G_FRIDA_KAHLO_2018-02_SJzcES-Cb-1593471790760-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/CADERNETA_G_FRIDA_KAHLO_2018-02_SJzcES-Cb-1593471790760-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/CADERNETA_G_FRIDA_KAHLO_2018-02_SJzcES-Cb-1593471790760-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/CADERNETA_G_FRIDA_KAHLO_2018-02_SJzcES-Cb-1593471790760-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/CADERNETA_G_FRIDA_KAHLO_2018-02_SJzcES-Cb-1593471790760-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/CADERNETA_G_FRIDA_KAHLO_2018-02_SJzcES-Cb-1593471790760-thumbnail.jpg	2	2	f	332731	910	1190	0.76
604	conjunto-coracao1_t6mDT_2FQ-1593471792359-original-.jpg	conjunto-coracao1_t6mDT_2FQ.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao1_t6mDT_2FQ-1593471792359-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao1_t6mDT_2FQ-1593471792359-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao1_t6mDT_2FQ-1593471792359-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao1_t6mDT_2FQ-1593471792359-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao1_t6mDT_2FQ-1593471792359-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao1_t6mDT_2FQ-1593471792359-thumbnail.jpg	2	1	f	75480	1100	1100	1.00
605	cj-ondenaopuderesamar2_pNKfhjkEq-1593471791157-original-.jpg	cj-ondenaopuderesamar2_pNKfhjkEq.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar2_pNKfhjkEq-1593471791157-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar2_pNKfhjkEq-1593471791157-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar2_pNKfhjkEq-1593471791157-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar2_pNKfhjkEq-1593471791157-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar2_pNKfhjkEq-1593471791157-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-ondenaopuderesamar2_pNKfhjkEq-1593471791157-thumbnail.jpg	2	1	f	63105	960	1280	0.75
608	IMG_2270_8flKvRRW1-1593471777994-original-.jpg	IMG_2270_8flKvRRW1.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2270_8flKvRRW1-1593471777994-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2270_8flKvRRW1-1593471777994-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2270_8flKvRRW1-1593471777994-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2270_8flKvRRW1-1593471777994-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2270_8flKvRRW1-1593471777994-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2270_8flKvRRW1-1593471777994-thumbnail.jpg	1	0	f	1409140	3024	4032	0.75
619	argola-coracao_OJDlXKXipe-1593471796363-original-.jpg	argola-coracao_OJDlXKXipe.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-coracao_OJDlXKXipe-1593471796363-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-coracao_OJDlXKXipe-1593471796363-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-coracao_OJDlXKXipe-1593471796363-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-coracao_OJDlXKXipe-1593471796363-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-coracao_OJDlXKXipe-1593471796363-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-coracao_OJDlXKXipe-1593471796363-thumbnail.jpg	2	1	f	104934	2500	2486	1.01
621	43128__1__11FF9la5v-1593471799156-original-.jpg	43128__1__11FF9la5v.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43128__1__11FF9la5v-1593471799156-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43128__1__11FF9la5v-1593471799156-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43128__1__11FF9la5v-1593471799156-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43128__1__11FF9la5v-1593471799156-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43128__1__11FF9la5v-1593471799156-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43128__1__11FF9la5v-1593471799156-thumbnail.jpg	1	0	f	26446	300	300	1.00
620	bracelete_56Lg9S5Wp-1593471795963-original-.jpg	bracelete_56Lg9S5Wp.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bracelete_56Lg9S5Wp-1593471795963-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bracelete_56Lg9S5Wp-1593471795963-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bracelete_56Lg9S5Wp-1593471795963-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bracelete_56Lg9S5Wp-1593471795963-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bracelete_56Lg9S5Wp-1593471795963-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bracelete_56Lg9S5Wp-1593471795963-thumbnail.jpg	2	1	f	133268	3024	3036	1.00
610	1899_-_Almof_P_Porta_F_Cactus_G1_HxPZO8T8j-1593471794357-original-.jpg	1899_-_Almof_P_Porta_F_Cactus_G1_HxPZO8T8j.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1899_-_Almof_P_Porta_F_Cactus_G1_HxPZO8T8j-1593471794357-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1899_-_Almof_P_Porta_F_Cactus_G1_HxPZO8T8j-1593471794357-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1899_-_Almof_P_Porta_F_Cactus_G1_HxPZO8T8j-1593471794357-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1899_-_Almof_P_Porta_F_Cactus_G1_HxPZO8T8j-1593471794357-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1899_-_Almof_P_Porta_F_Cactus_G1_HxPZO8T8j-1593471794357-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1899_-_Almof_P_Porta_F_Cactus_G1_HxPZO8T8j-1593471794357-thumbnail.jpg	2	1	f	44606	770	1000	0.77
611	a07023_9WrZr5MHu-1593471795155-original-.jpg	a07023_9WrZr5MHu.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07023_9WrZr5MHu-1593471795155-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07023_9WrZr5MHu-1593471795155-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07023_9WrZr5MHu-1593471795155-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07023_9WrZr5MHu-1593471795155-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07023_9WrZr5MHu-1593471795155-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07023_9WrZr5MHu-1593471795155-thumbnail.jpg	2	2	f	38070	800	800	1.00
612	1892_-_P_Porta_Cactus_03_0jBMIIyWb-1593471794756-original-.jpg	1892_-_P_Porta_Cactus_03_0jBMIIyWb.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1892_-_P_Porta_Cactus_03_0jBMIIyWb-1593471794756-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1892_-_P_Porta_Cactus_03_0jBMIIyWb-1593471794756-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1892_-_P_Porta_Cactus_03_0jBMIIyWb-1593471794756-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1892_-_P_Porta_Cactus_03_0jBMIIyWb-1593471794756-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1892_-_P_Porta_Cactus_03_0jBMIIyWb-1593471794756-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/1892_-_P_Porta_Cactus_03_0jBMIIyWb-1593471794756-thumbnail.jpg	2	1	f	48470	600	1000	0.60
613	conjunto-coracao2_PKveTUy8W-1593471792760-original-.jpg	conjunto-coracao2_PKveTUy8W.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao2_PKveTUy8W-1593471792760-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao2_PKveTUy8W-1593471792760-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao2_PKveTUy8W-1593471792760-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao2_PKveTUy8W-1593471792760-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao2_PKveTUy8W-1593471792760-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto-coracao2_PKveTUy8W-1593471792760-thumbnail.jpg	2	1	f	89170	1200	1200	1.00
614	6117_-_Almof_FK010_AZ_-_frente_2DR5zSy8e-1593471784773-original-.jpg	6117_-_Almof_FK010_AZ_-_frente_2DR5zSy8e.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6117_-_Almof_FK010_AZ_-_frente_2DR5zSy8e-1593471784773-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6117_-_Almof_FK010_AZ_-_frente_2DR5zSy8e-1593471784773-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6117_-_Almof_FK010_AZ_-_frente_2DR5zSy8e-1593471784773-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6117_-_Almof_FK010_AZ_-_frente_2DR5zSy8e-1593471784773-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6117_-_Almof_FK010_AZ_-_frente_2DR5zSy8e-1593471784773-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6117_-_Almof_FK010_AZ_-_frente_2DR5zSy8e-1593471784773-thumbnail.jpg	1	0	f	1175594	3055	2998	1.02
615	c00240_QNCBxjdRg-1593471795643-original-.jpg	c00240_QNCBxjdRg.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/c00240_QNCBxjdRg-1593471795643-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/c00240_QNCBxjdRg-1593471795643-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/c00240_QNCBxjdRg-1593471795643-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/c00240_QNCBxjdRg-1593471795643-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/c00240_QNCBxjdRg-1593471795643-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/c00240_QNCBxjdRg-1593471795643-thumbnail.jpg	2	1	f	26571	800	800	1.00
616	6113_-_Almof_FK009_PT_-_verso_mCdUoVZmw-1593471787572-original-.jpg	6113_-_Almof_FK009_PT_-_verso_mCdUoVZmw.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6113_-_Almof_FK009_PT_-_verso_mCdUoVZmw-1593471787572-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6113_-_Almof_FK009_PT_-_verso_mCdUoVZmw-1593471787572-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6113_-_Almof_FK009_PT_-_verso_mCdUoVZmw-1593471787572-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6113_-_Almof_FK009_PT_-_verso_mCdUoVZmw-1593471787572-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6113_-_Almof_FK009_PT_-_verso_mCdUoVZmw-1593471787572-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/6113_-_Almof_FK009_PT_-_verso_mCdUoVZmw-1593471787572-thumbnail.jpg	1	0	f	391969	3203	3122	1.03
617	argola-coracao2_6Mr5opq6D-1593471796757-original-.jpg	argola-coracao2_6Mr5opq6D.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-coracao2_6Mr5opq6D-1593471796757-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-coracao2_6Mr5opq6D-1593471796757-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-coracao2_6Mr5opq6D-1593471796757-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-coracao2_6Mr5opq6D-1593471796757-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-coracao2_6Mr5opq6D-1593471796757-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-coracao2_6Mr5opq6D-1593471796757-thumbnail.jpg	2	1	f	77497	2500	2486	1.01
618	43127_5M6g1cMYT-1593471798755-original-.jpg	43127_5M6g1cMYT.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43127_5M6g1cMYT-1593471798755-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43127_5M6g1cMYT-1593471798755-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43127_5M6g1cMYT-1593471798755-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43127_5M6g1cMYT-1593471798755-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43127_5M6g1cMYT-1593471798755-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43127_5M6g1cMYT-1593471798755-thumbnail.jpg	2	1	f	23658	300	300	1.00
623	41775_88EbhzP28-1593471799954-original-.jpg	41775_88EbhzP28.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/41775_88EbhzP28-1593471799954-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/41775_88EbhzP28-1593471799954-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/41775_88EbhzP28-1593471799954-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/41775_88EbhzP28-1593471799954-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/41775_88EbhzP28-1593471799954-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/41775_88EbhzP28-1593471799954-thumbnail.jpg	2	1	f	15724	300	300	1.00
624	argola-grande_X2NaclG2Q-1593471797962-original-.jpg	argola-grande_X2NaclG2Q.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-grande_X2NaclG2Q-1593471797962-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-grande_X2NaclG2Q-1593471797962-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-grande_X2NaclG2Q-1593471797962-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-grande_X2NaclG2Q-1593471797962-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-grande_X2NaclG2Q-1593471797962-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-grande_X2NaclG2Q-1593471797962-thumbnail.jpg	2	1	f	96392	3024	3504	0.86
625	43106_mBTNMdYyA-1593471800355-original-.jpg	43106_mBTNMdYyA.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43106_mBTNMdYyA-1593471800355-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43106_mBTNMdYyA-1593471800355-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43106_mBTNMdYyA-1593471800355-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43106_mBTNMdYyA-1593471800355-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43106_mBTNMdYyA-1593471800355-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43106_mBTNMdYyA-1593471800355-thumbnail.jpg	2	1	f	14852	300	300	1.00
626	43095_q4T8W_swX-1593471800753-original-.jpg	43095_q4T8W_swX.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43095_q4T8W_swX-1593471800753-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43095_q4T8W_swX-1593471800753-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43095_q4T8W_swX-1593471800753-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43095_q4T8W_swX-1593471800753-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43095_q4T8W_swX-1593471800753-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43095_q4T8W_swX-1593471800753-thumbnail.jpg	2	1	f	21750	300	300	1.00
627	argola-ondulada2_fPEly1G2D-1593471797621-original-.jpg	argola-ondulada2_fPEly1G2D.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-ondulada2_fPEly1G2D-1593471797621-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-ondulada2_fPEly1G2D-1593471797621-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-ondulada2_fPEly1G2D-1593471797621-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-ondulada2_fPEly1G2D-1593471797621-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-ondulada2_fPEly1G2D-1593471797621-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-ondulada2_fPEly1G2D-1593471797621-thumbnail.jpg	2	1	f	171549	3024	4032	0.75
628	43097_3fTBIPQlp-1593471801157-original-.jpg	43097_3fTBIPQlp.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43097_3fTBIPQlp-1593471801157-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43097_3fTBIPQlp-1593471801157-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43097_3fTBIPQlp-1593471801157-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43097_3fTBIPQlp-1593471801157-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43097_3fTBIPQlp-1593471801157-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43097_3fTBIPQlp-1593471801157-thumbnail.jpg	2	1	f	26307	300	300	1.00
629	43096_MwxSSMUp_-1593471801557-original-.jpg	43096_MwxSSMUp_.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43096_MwxSSMUp_-1593471801557-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43096_MwxSSMUp_-1593471801557-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43096_MwxSSMUp_-1593471801557-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43096_MwxSSMUp_-1593471801557-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43096_MwxSSMUp_-1593471801557-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43096_MwxSSMUp_-1593471801557-thumbnail.jpg	2	1	f	19329	300	300	1.00
639	43235__1__0nTe3hgVH-1593471804754-original-.jpg	43235__1__0nTe3hgVH.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43235__1__0nTe3hgVH-1593471804754-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43235__1__0nTe3hgVH-1593471804754-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43235__1__0nTe3hgVH-1593471804754-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43235__1__0nTe3hgVH-1593471804754-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43235__1__0nTe3hgVH-1593471804754-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43235__1__0nTe3hgVH-1593471804754-thumbnail.jpg	2	1	f	20212	300	300	1.00
640	43164__1__mY_dKAcwQ-1593471805153-original-.jpg	43164__1__mY_dKAcwQ.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43164__1__mY_dKAcwQ-1593471805153-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43164__1__mY_dKAcwQ-1593471805153-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43164__1__mY_dKAcwQ-1593471805153-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43164__1__mY_dKAcwQ-1593471805153-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43164__1__mY_dKAcwQ-1593471805153-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43164__1__mY_dKAcwQ-1593471805153-thumbnail.jpg	2	1	f	20938	300	300	1.00
641	43000_wAHzjY5fj-1593471807559-original-.jpg	43000_wAHzjY5fj.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43000_wAHzjY5fj-1593471807559-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43000_wAHzjY5fj-1593471807559-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43000_wAHzjY5fj-1593471807559-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43000_wAHzjY5fj-1593471807559-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43000_wAHzjY5fj-1593471807559-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43000_wAHzjY5fj-1593471807559-thumbnail.jpg	2	1	f	20068	300	300	1.00
630	argola-grande2_bjHK2lhcp-1593471798368-original-.jpg	argola-grande2_bjHK2lhcp.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-grande2_bjHK2lhcp-1593471798368-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-grande2_bjHK2lhcp-1593471798368-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-grande2_bjHK2lhcp-1593471798368-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-grande2_bjHK2lhcp-1593471798368-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-grande2_bjHK2lhcp-1593471798368-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/argola-grande2_bjHK2lhcp-1593471798368-thumbnail.jpg	2	1	f	213897	4208	4032	1.04
631	43550__RqIraaDu-1593471801972-original-.jpg	43550__RqIraaDu.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43550__RqIraaDu-1593471801972-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43550__RqIraaDu-1593471801972-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43550__RqIraaDu-1593471801972-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43550__RqIraaDu-1593471801972-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43550__RqIraaDu-1593471801972-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43550__RqIraaDu-1593471801972-thumbnail.jpg	2	1	f	12288	300	300	1.00
632	43282_X0cwGFTNT-1593471802357-original-.jpg	43282_X0cwGFTNT.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43282_X0cwGFTNT-1593471802357-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43282_X0cwGFTNT-1593471802357-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43282_X0cwGFTNT-1593471802357-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43282_X0cwGFTNT-1593471802357-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43282_X0cwGFTNT-1593471802357-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43282_X0cwGFTNT-1593471802357-thumbnail.jpg	2	1	f	15649	300	300	1.00
633	40642_5J9CNxywB-1593471799566-original-.jpg	40642_5J9CNxywB.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40642_5J9CNxywB-1593471799566-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40642_5J9CNxywB-1593471799566-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40642_5J9CNxywB-1593471799566-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40642_5J9CNxywB-1593471799566-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40642_5J9CNxywB-1593471799566-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40642_5J9CNxywB-1593471799566-thumbnail.jpg	2	1	f	378922	1200	1200	1.00
634	43281_DBXgybOSO-1593471802755-original-.jpg	43281_DBXgybOSO.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43281_DBXgybOSO-1593471802755-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43281_DBXgybOSO-1593471802755-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43281_DBXgybOSO-1593471802755-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43281_DBXgybOSO-1593471802755-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43281_DBXgybOSO-1593471802755-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43281_DBXgybOSO-1593471802755-thumbnail.jpg	2	1	f	21804	300	300	1.00
635	43269_Wz8HKn0Cx-1593471803154-original-.jpg	43269_Wz8HKn0Cx.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43269_Wz8HKn0Cx-1593471803154-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43269_Wz8HKn0Cx-1593471803154-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43269_Wz8HKn0Cx-1593471803154-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43269_Wz8HKn0Cx-1593471803154-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43269_Wz8HKn0Cx-1593471803154-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43269_Wz8HKn0Cx-1593471803154-thumbnail.jpg	2	1	f	16386	300	300	1.00
636	43336_Vtj_j4njU-1593471803559-original-.jpg	43336_Vtj_j4njU.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43336_Vtj_j4njU-1593471803559-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43336_Vtj_j4njU-1593471803559-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43336_Vtj_j4njU-1593471803559-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43336_Vtj_j4njU-1593471803559-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43336_Vtj_j4njU-1593471803559-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43336_Vtj_j4njU-1593471803559-thumbnail.jpg	2	1	f	23138	300	300	1.00
637	43338_bGTX0FVDo-1593471803956-original-.jpg	43338_bGTX0FVDo.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43338_bGTX0FVDo-1593471803956-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43338_bGTX0FVDo-1593471803956-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43338_bGTX0FVDo-1593471803956-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43338_bGTX0FVDo-1593471803956-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43338_bGTX0FVDo-1593471803956-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43338_bGTX0FVDo-1593471803956-thumbnail.jpg	2	1	f	23191	300	300	1.00
638	43337_2IUGDKghm-1593471804360-original-.jpg	43337_2IUGDKghm.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43337_2IUGDKghm-1593471804360-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43337_2IUGDKghm-1593471804360-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43337_2IUGDKghm-1593471804360-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43337_2IUGDKghm-1593471804360-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43337_2IUGDKghm-1593471804360-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43337_2IUGDKghm-1593471804360-thumbnail.jpg	2	1	f	29304	300	300	1.00
646	43163__1__AjDTh0kQ0-1593471808361-original-.jpg	43163__1__AjDTh0kQ0.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43163__1__AjDTh0kQ0-1593471808361-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43163__1__AjDTh0kQ0-1593471808361-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43163__1__AjDTh0kQ0-1593471808361-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43163__1__AjDTh0kQ0-1593471808361-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43163__1__AjDTh0kQ0-1593471808361-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43163__1__AjDTh0kQ0-1593471808361-thumbnail.jpg	2	1	f	25550	300	300	1.00
647	40623_rRCd7Mbat-1593471805960-original-.jpg	40623_rRCd7Mbat.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40623_rRCd7Mbat-1593471805960-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40623_rRCd7Mbat-1593471805960-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40623_rRCd7Mbat-1593471805960-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40623_rRCd7Mbat-1593471805960-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40623_rRCd7Mbat-1593471805960-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40623_rRCd7Mbat-1593471805960-thumbnail.jpg	2	1	f	385277	1200	1200	1.00
648	a07021_6BKTUwGOH-1593471808754-original-.jpg	a07021_6BKTUwGOH.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07021_6BKTUwGOH-1593471808754-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07021_6BKTUwGOH-1593471808754-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07021_6BKTUwGOH-1593471808754-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07021_6BKTUwGOH-1593471808754-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07021_6BKTUwGOH-1593471808754-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07021_6BKTUwGOH-1593471808754-thumbnail.jpg	2	1	f	30846	800	800	1.00
649	a07022_Wuof_9YoQ-1593471809160-original-.jpg	a07022_Wuof_9YoQ.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07022_Wuof_9YoQ-1593471809160-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07022_Wuof_9YoQ-1593471809160-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07022_Wuof_9YoQ-1593471809160-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07022_Wuof_9YoQ-1593471809160-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07022_Wuof_9YoQ-1593471809160-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/a07022_Wuof_9YoQ-1593471809160-thumbnail.jpg	2	1	f	33426	800	800	1.00
650	40641_OneD_9zZY-1593471806766-original-.jpg	40641_OneD_9zZY.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40641_OneD_9zZY-1593471806766-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40641_OneD_9zZY-1593471806766-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40641_OneD_9zZY-1593471806766-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40641_OneD_9zZY-1593471806766-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40641_OneD_9zZY-1593471806766-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40641_OneD_9zZY-1593471806766-thumbnail.jpg	2	1	f	422577	1200	1200	1.00
651	b04454_8P7VL-Jsr-1593471809560-original-.jpg	b04454_8P7VL-Jsr.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b04454_8P7VL-Jsr-1593471809560-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b04454_8P7VL-Jsr-1593471809560-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b04454_8P7VL-Jsr-1593471809560-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b04454_8P7VL-Jsr-1593471809560-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b04454_8P7VL-Jsr-1593471809560-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b04454_8P7VL-Jsr-1593471809560-thumbnail.jpg	2	1	f	45200	800	800	1.00
652	b05077_yBb-TxU6C-1593471810385-original-.jpg	b05077_yBb-TxU6C.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05077_yBb-TxU6C-1593471810385-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05077_yBb-TxU6C-1593471810385-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05077_yBb-TxU6C-1593471810385-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05077_yBb-TxU6C-1593471810385-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05077_yBb-TxU6C-1593471810385-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05077_yBb-TxU6C-1593471810385-thumbnail.jpg	2	1	f	35843	800	800	1.00
642	42999_Kuf2_KdO3-1593471807158-original-.jpg	42999_Kuf2_KdO3.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/42999_Kuf2_KdO3-1593471807158-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/42999_Kuf2_KdO3-1593471807158-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/42999_Kuf2_KdO3-1593471807158-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/42999_Kuf2_KdO3-1593471807158-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/42999_Kuf2_KdO3-1593471807158-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/42999_Kuf2_KdO3-1593471807158-thumbnail.jpg	2	1	f	18333	300	300	1.00
643	43001_4uMOLY9u8-1593471807954-original-.jpg	43001_4uMOLY9u8.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43001_4uMOLY9u8-1593471807954-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43001_4uMOLY9u8-1593471807954-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43001_4uMOLY9u8-1593471807954-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43001_4uMOLY9u8-1593471807954-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43001_4uMOLY9u8-1593471807954-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43001_4uMOLY9u8-1593471807954-thumbnail.jpg	2	1	f	15552	300	300	1.00
644	40621_z5nKqeMZe-1593471805600-original-.jpg	40621_z5nKqeMZe.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40621_z5nKqeMZe-1593471805600-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40621_z5nKqeMZe-1593471805600-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40621_z5nKqeMZe-1593471805600-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40621_z5nKqeMZe-1593471805600-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40621_z5nKqeMZe-1593471805600-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40621_z5nKqeMZe-1593471805600-thumbnail.jpg	2	1	f	327970	1200	1200	1.00
645	40622_NzYmVk7Xi-1593471806361-original-.jpg	40622_NzYmVk7Xi.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40622_NzYmVk7Xi-1593471806361-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40622_NzYmVk7Xi-1593471806361-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40622_NzYmVk7Xi-1593471806361-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40622_NzYmVk7Xi-1593471806361-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40622_NzYmVk7Xi-1593471806361-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/40622_NzYmVk7Xi-1593471806361-thumbnail.jpg	2	1	f	242907	1200	1200	1.00
656	b06657_g1CXSJtEe-1593471811554-original-.jpg	b06657_g1CXSJtEe.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b06657_g1CXSJtEe-1593471811554-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b06657_g1CXSJtEe-1593471811554-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b06657_g1CXSJtEe-1593471811554-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b06657_g1CXSJtEe-1593471811554-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b06657_g1CXSJtEe-1593471811554-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b06657_g1CXSJtEe-1593471811554-thumbnail.jpg	1	0	f	20050	800	800	1.00
657	gotas_X0oatfKDs-1593471811958-original-.jpg	gotas_X0oatfKDs.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/gotas_X0oatfKDs-1593471811958-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/gotas_X0oatfKDs-1593471811958-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/gotas_X0oatfKDs-1593471811958-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/gotas_X0oatfKDs-1593471811958-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/gotas_X0oatfKDs-1593471811958-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/gotas_X0oatfKDs-1593471811958-thumbnail.jpg	2	1	f	45116	960	1044	0.92
658	g07516_ZAmViQi5p-1593471814355-original-.jpg	g07516_ZAmViQi5p.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/g07516_ZAmViQi5p-1593471814355-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/g07516_ZAmViQi5p-1593471814355-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/g07516_ZAmViQi5p-1593471814355-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/g07516_ZAmViQi5p-1593471814355-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/g07516_ZAmViQi5p-1593471814355-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/g07516_ZAmViQi5p-1593471814355-thumbnail.jpg	2	1	f	25289	800	800	1.00
659	B05032-24_EhPm2j_5s-1593471812762-original-.jpg	B05032-24_EhPm2j_5s.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-24_EhPm2j_5s-1593471812762-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-24_EhPm2j_5s-1593471812762-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-24_EhPm2j_5s-1593471812762-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-24_EhPm2j_5s-1593471812762-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-24_EhPm2j_5s-1593471812762-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-24_EhPm2j_5s-1593471812762-thumbnail.jpg	2	1	f	164017	2448	3264	0.75
653	b05076_oERezJlPI-1593471809963-original-.jpg	b05076_oERezJlPI.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05076_oERezJlPI-1593471809963-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05076_oERezJlPI-1593471809963-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05076_oERezJlPI-1593471809963-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05076_oERezJlPI-1593471809963-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05076_oERezJlPI-1593471809963-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05076_oERezJlPI-1593471809963-thumbnail.jpg	2	1	f	47116	800	800	1.00
654	b05097_1l6_u92Xz-1593471810756-original-.jpg	b05097_1l6_u92Xz.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05097_1l6_u92Xz-1593471810756-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05097_1l6_u92Xz-1593471810756-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05097_1l6_u92Xz-1593471810756-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05097_1l6_u92Xz-1593471810756-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05097_1l6_u92Xz-1593471810756-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/b05097_1l6_u92Xz-1593471810756-thumbnail.jpg	2	1	f	37587	800	800	1.00
655	p06505__1__Ge9A_D1n--1593471811157-original-.jpg	p06505__1__Ge9A_D1n-.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06505__1__Ge9A_D1n--1593471811157-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06505__1__Ge9A_D1n--1593471811157-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06505__1__Ge9A_D1n--1593471811157-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06505__1__Ge9A_D1n--1593471811157-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06505__1__Ge9A_D1n--1593471811157-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/p06505__1__Ge9A_D1n--1593471811157-thumbnail.jpg	2	1	f	30066	800	800	1.00
664	B05032-28_dfEWaC5-Y-1593471813557-original-.jpg	B05032-28_dfEWaC5-Y.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-28_dfEWaC5-Y-1593471813557-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-28_dfEWaC5-Y-1593471813557-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-28_dfEWaC5-Y-1593471813557-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-28_dfEWaC5-Y-1593471813557-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-28_dfEWaC5-Y-1593471813557-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-28_dfEWaC5-Y-1593471813557-thumbnail.jpg	2	1	f	182933	3024	4032	0.75
666	B05032-20_1f-QQlmbW-1593471813990-original-.jpg	B05032-20_1f-QQlmbW.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-20_1f-QQlmbW-1593471813990-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-20_1f-QQlmbW-1593471813990-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-20_1f-QQlmbW-1593471813990-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-20_1f-QQlmbW-1593471813990-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-20_1f-QQlmbW-1593471813990-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-20_1f-QQlmbW-1593471813990-thumbnail.jpg	2	1	f	208997	3024	4032	0.75
667	WhatsApp_Image_2020-01-17_at_17.06.40_auXCBkgqb-1593471815962-original-.jpg	WhatsApp_Image_2020-01-17_at_17.06.40_auXCBkgqb.jpeg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.40_auXCBkgqb-1593471815962-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.40_auXCBkgqb-1593471815962-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.40_auXCBkgqb-1593471815962-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.40_auXCBkgqb-1593471815962-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.40_auXCBkgqb-1593471815962-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.40_auXCBkgqb-1593471815962-thumbnail.jpg	2	1	f	186913	959	1280	0.75
672	43336_WJaERq2Pm-1593471819160-original-.jpg	43336_WJaERq2Pm.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43336_WJaERq2Pm-1593471819160-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43336_WJaERq2Pm-1593471819160-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43336_WJaERq2Pm-1593471819160-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43336_WJaERq2Pm-1593471819160-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43336_WJaERq2Pm-1593471819160-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43336_WJaERq2Pm-1593471819160-thumbnail.jpg	2	1	f	23138	300	300	1.00
673	43338_PinxyfCEG-1593471819551-original-.jpg	43338_PinxyfCEG.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43338_PinxyfCEG-1593471819551-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43338_PinxyfCEG-1593471819551-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43338_PinxyfCEG-1593471819551-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43338_PinxyfCEG-1593471819551-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43338_PinxyfCEG-1593471819551-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43338_PinxyfCEG-1593471819551-thumbnail.jpg	2	1	f	23191	300	300	1.00
660	IMG_1895_uVUj0CN_Y-1593471812369-original-.jpg	IMG_1895_uVUj0CN_Y.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1895_uVUj0CN_Y-1593471812369-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1895_uVUj0CN_Y-1593471812369-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1895_uVUj0CN_Y-1593471812369-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1895_uVUj0CN_Y-1593471812369-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1895_uVUj0CN_Y-1593471812369-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1895_uVUj0CN_Y-1593471812369-thumbnail.jpg	1	0	f	208997	3024	4032	0.75
661	WhatsApp_Image_2020-01-17_at_17.06.41_p4_WYUcIr-1593471814761-original-.jpg	WhatsApp_Image_2020-01-17_at_17.06.41_p4_WYUcIr.jpeg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41_p4_WYUcIr-1593471814761-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41_p4_WYUcIr-1593471814761-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41_p4_WYUcIr-1593471814761-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41_p4_WYUcIr-1593471814761-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41_p4_WYUcIr-1593471814761-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41_p4_WYUcIr-1593471814761-thumbnail.jpg	1	0	f	167906	959	1280	0.75
662	B05032-34_RVQcVps2--1593471813166-original-.jpg	B05032-34_RVQcVps2-.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-34_RVQcVps2--1593471813166-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-34_RVQcVps2--1593471813166-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-34_RVQcVps2--1593471813166-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-34_RVQcVps2--1593471813166-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-34_RVQcVps2--1593471813166-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/B05032-34_RVQcVps2--1593471813166-thumbnail.jpg	1	0	f	209818	3024	4032	0.75
663	WhatsApp_Image_2020-01-17_at_17.06.41__1__t8E2Ft2Wl-1593471815164-original-.jpg	WhatsApp_Image_2020-01-17_at_17.06.41__1__t8E2Ft2Wl.jpeg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41__1__t8E2Ft2Wl-1593471815164-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41__1__t8E2Ft2Wl-1593471815164-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41__1__t8E2Ft2Wl-1593471815164-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41__1__t8E2Ft2Wl-1593471815164-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41__1__t8E2Ft2Wl-1593471815164-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41__1__t8E2Ft2Wl-1593471815164-thumbnail.jpg	2	1	f	154177	959	1280	0.75
665	WhatsApp_Image_2020-01-17_at_17.06.41__2__R7Ugajvg0-1593471815565-original-.jpg	WhatsApp_Image_2020-01-17_at_17.06.41__2__R7Ugajvg0.jpeg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41__2__R7Ugajvg0-1593471815565-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41__2__R7Ugajvg0-1593471815565-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41__2__R7Ugajvg0-1593471815565-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41__2__R7Ugajvg0-1593471815565-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41__2__R7Ugajvg0-1593471815565-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.41__2__R7Ugajvg0-1593471815565-thumbnail.jpg	2	1	f	200364	959	1280	0.75
676	IMG_1897__1__5nSC3d8uk-1593471817565-original-.jpg	IMG_1897__1__5nSC3d8uk.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1897__1__5nSC3d8uk-1593471817565-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1897__1__5nSC3d8uk-1593471817565-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1897__1__5nSC3d8uk-1593471817565-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1897__1__5nSC3d8uk-1593471817565-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1897__1__5nSC3d8uk-1593471817565-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1897__1__5nSC3d8uk-1593471817565-thumbnail.jpg	2	1	f	228919	3024	3024	1.00
668	WhatsApp_Image_2020-01-17_at_17.29.51_VhuQQXtb--1593471816362-original-.jpg	WhatsApp_Image_2020-01-17_at_17.29.51_VhuQQXtb-.jpeg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.29.51_VhuQQXtb--1593471816362-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.29.51_VhuQQXtb--1593471816362-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.29.51_VhuQQXtb--1593471816362-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.29.51_VhuQQXtb--1593471816362-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.29.51_VhuQQXtb--1593471816362-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.29.51_VhuQQXtb--1593471816362-thumbnail.jpg	2	1	f	102594	1280	1280	1.00
669	43235_ytAqWBDpr-1593471818354-original-.jpg	43235_ytAqWBDpr.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43235_ytAqWBDpr-1593471818354-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43235_ytAqWBDpr-1593471818354-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43235_ytAqWBDpr-1593471818354-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43235_ytAqWBDpr-1593471818354-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43235_ytAqWBDpr-1593471818354-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43235_ytAqWBDpr-1593471818354-thumbnail.jpg	2	1	f	20212	300	300	1.00
670	WhatsApp_Image_2020-01-17_at_17.06.42_mGm98yiKu-1593471817159-original-.jpg	WhatsApp_Image_2020-01-17_at_17.06.42_mGm98yiKu.jpeg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.42_mGm98yiKu-1593471817159-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.42_mGm98yiKu-1593471817159-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.42_mGm98yiKu-1593471817159-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.42_mGm98yiKu-1593471817159-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.42_mGm98yiKu-1593471817159-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-01-17_at_17.06.42_mGm98yiKu-1593471817159-thumbnail.jpg	2	1	f	115458	959	1280	0.75
671	43337_d0RK8a72w-1593471818767-original-.jpg	43337_d0RK8a72w.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43337_d0RK8a72w-1593471818767-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43337_d0RK8a72w-1593471818767-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43337_d0RK8a72w-1593471818767-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43337_d0RK8a72w-1593471818767-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43337_d0RK8a72w-1593471818767-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43337_d0RK8a72w-1593471818767-thumbnail.jpg	2	1	f	29304	300	300	1.00
674	95a01b70-bf8e-11e9-8614-e9c9125bf87b_WN007HuTd-1593471819958-original-.jpg	95a01b70-bf8e-11e9-8614-e9c9125bf87b_WN007HuTd.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/95a01b70-bf8e-11e9-8614-e9c9125bf87b_WN007HuTd-1593471819958-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/95a01b70-bf8e-11e9-8614-e9c9125bf87b_WN007HuTd-1593471819958-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/95a01b70-bf8e-11e9-8614-e9c9125bf87b_WN007HuTd-1593471819958-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/95a01b70-bf8e-11e9-8614-e9c9125bf87b_WN007HuTd-1593471819958-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/95a01b70-bf8e-11e9-8614-e9c9125bf87b_WN007HuTd-1593471819958-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/95a01b70-bf8e-11e9-8614-e9c9125bf87b_WN007HuTd-1593471819958-thumbnail.jpg	2	1	f	33552	425	600	0.71
675	IMG_1896_kA4lFhtaC-1593471816808-original-.jpg	IMG_1896_kA4lFhtaC.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1896_kA4lFhtaC-1593471816808-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1896_kA4lFhtaC-1593471816808-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1896_kA4lFhtaC-1593471816808-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1896_kA4lFhtaC-1593471816808-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1896_kA4lFhtaC-1593471816808-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1896_kA4lFhtaC-1593471816808-thumbnail.jpg	2	1	f	284632	3024	4032	0.75
677	IMG_1903__1__PNgWZMGZK-1593471817964-original-.jpg	IMG_1903__1__PNgWZMGZK.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1903__1__PNgWZMGZK-1593471817964-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1903__1__PNgWZMGZK-1593471817964-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1903__1__PNgWZMGZK-1593471817964-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1903__1__PNgWZMGZK-1593471817964-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1903__1__PNgWZMGZK-1593471817964-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1903__1__PNgWZMGZK-1593471817964-thumbnail.jpg	2	1	f	221399	3024	3024	1.00
678	4081_-_E100_FK010_AZPT_-_frente_KPkGnp6v7-1593471820777-original-.jpg	4081_-_E100_FK010_AZPT_-_frente_KPkGnp6v7.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_frente_KPkGnp6v7-1593471820777-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_frente_KPkGnp6v7-1593471820777-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_frente_KPkGnp6v7-1593471820777-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_frente_KPkGnp6v7-1593471820777-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_frente_KPkGnp6v7-1593471820777-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_frente_KPkGnp6v7-1593471820777-thumbnail.jpg	2	1	f	845787	4026	1993	2.02
679	4081_-_E100_FK010_AZPT_-_dentro2_-OCVSReK_-1593471821170-original-.jpg	4081_-_E100_FK010_AZPT_-_dentro2_-OCVSReK_.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_dentro2_-OCVSReK_-1593471821170-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_dentro2_-OCVSReK_-1593471821170-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_dentro2_-OCVSReK_-1593471821170-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_dentro2_-OCVSReK_-1593471821170-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_dentro2_-OCVSReK_-1593471821170-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_dentro2_-OCVSReK_-1593471821170-thumbnail.jpg	2	1	f	638786	3114	3221	0.97
680	4081_-_E100_FK010_AZPT_-_verso_hI9heeQ-J-1593471820383-original-.jpg	4081_-_E100_FK010_AZPT_-_verso_hI9heeQ-J.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_verso_hI9heeQ-J-1593471820383-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_verso_hI9heeQ-J-1593471820383-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_verso_hI9heeQ-J-1593471820383-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_verso_hI9heeQ-J-1593471820383-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_verso_hI9heeQ-J-1593471820383-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_verso_hI9heeQ-J-1593471820383-thumbnail.jpg	2	1	f	973601	4489	2302	1.95
681	4081_-_E100_FK010_AZPT_-_dentro1_Ti2_zS0aZ-1593471821575-original-.jpg	4081_-_E100_FK010_AZPT_-_dentro1_Ti2_zS0aZ.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_dentro1_Ti2_zS0aZ-1593471821575-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_dentro1_Ti2_zS0aZ-1593471821575-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_dentro1_Ti2_zS0aZ-1593471821575-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_dentro1_Ti2_zS0aZ-1593471821575-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_dentro1_Ti2_zS0aZ-1593471821575-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_dentro1_Ti2_zS0aZ-1593471821575-thumbnail.jpg	2	1	f	719373	3247	3204	1.01
699	IMG_1873_bKNZ_euRa-1593471830409-original-.jpg	IMG_1873_bKNZ_euRa.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1873_bKNZ_euRa-1593471830409-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1873_bKNZ_euRa-1593471830409-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1873_bKNZ_euRa-1593471830409-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1873_bKNZ_euRa-1593471830409-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1873_bKNZ_euRa-1593471830409-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1873_bKNZ_euRa-1593471830409-thumbnail.jpg	1	0	f	644064	2000	2667	0.75
701	IMG_1866_CLAD4MuVhx-1593471831171-original-.jpg	IMG_1866_CLAD4MuVhx.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1866_CLAD4MuVhx-1593471831171-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1866_CLAD4MuVhx-1593471831171-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1866_CLAD4MuVhx-1593471831171-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1866_CLAD4MuVhx-1593471831171-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1866_CLAD4MuVhx-1593471831171-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1866_CLAD4MuVhx-1593471831171-thumbnail.jpg	2	1	f	493175	2000	2667	0.75
702	bolsaazul1_OCIHQiaVr-1593471832784-original-.jpg	bolsaazul1_OCIHQiaVr.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul1_OCIHQiaVr-1593471832784-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul1_OCIHQiaVr-1593471832784-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul1_OCIHQiaVr-1593471832784-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul1_OCIHQiaVr-1593471832784-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul1_OCIHQiaVr-1593471832784-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul1_OCIHQiaVr-1593471832784-thumbnail.jpg	1	0	f	608672	2000	2667	0.75
704	IMG_1871_Ef2POvayu-1593471830769-original-.jpg	IMG_1871_Ef2POvayu.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1871_Ef2POvayu-1593471830769-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1871_Ef2POvayu-1593471830769-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1871_Ef2POvayu-1593471830769-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1871_Ef2POvayu-1593471830769-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1871_Ef2POvayu-1593471830769-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1871_Ef2POvayu-1593471830769-thumbnail.jpg	2	1	f	583751	2000	2667	0.75
682	4081_-_E100_FK010_AZPT_-_baixo_-LOHGQbEZ-1593471822373-original-.jpg	4081_-_E100_FK010_AZPT_-_baixo_-LOHGQbEZ.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_baixo_-LOHGQbEZ-1593471822373-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_baixo_-LOHGQbEZ-1593471822373-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_baixo_-LOHGQbEZ-1593471822373-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_baixo_-LOHGQbEZ-1593471822373-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_baixo_-LOHGQbEZ-1593471822373-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_baixo_-LOHGQbEZ-1593471822373-thumbnail.jpg	2	1	f	707820	2211	3327	0.66
683	4066_-_E100_FK009_CVD_-_verso_jo9hQ231k-1593471823571-original-.jpg	4066_-_E100_FK009_CVD_-_verso_jo9hQ231k.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_verso_jo9hQ231k-1593471823571-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_verso_jo9hQ231k-1593471823571-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_verso_jo9hQ231k-1593471823571-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_verso_jo9hQ231k-1593471823571-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_verso_jo9hQ231k-1593471823571-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_verso_jo9hQ231k-1593471823571-thumbnail.jpg	2	1	f	615209	3862	1935	2.00
684	4081_-_E100_FK010_AZPT_-_cima_u2BF2iro2-1593471822029-original-.jpg	4081_-_E100_FK010_AZPT_-_cima_u2BF2iro2.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_cima_u2BF2iro2-1593471822029-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_cima_u2BF2iro2-1593471822029-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_cima_u2BF2iro2-1593471822029-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_cima_u2BF2iro2-1593471822029-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_cima_u2BF2iro2-1593471822029-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4081_-_E100_FK010_AZPT_-_cima_u2BF2iro2-1593471822029-thumbnail.jpg	2	1	f	931860	2395	3369	0.71
685	4059_-_BEG_FK009_VD_-_verso_hwVfwHheS-1593471822798-original-.jpg	4059_-_BEG_FK009_VD_-_verso_hwVfwHheS.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4059_-_BEG_FK009_VD_-_verso_hwVfwHheS-1593471822798-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4059_-_BEG_FK009_VD_-_verso_hwVfwHheS-1593471822798-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4059_-_BEG_FK009_VD_-_verso_hwVfwHheS-1593471822798-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4059_-_BEG_FK009_VD_-_verso_hwVfwHheS-1593471822798-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4059_-_BEG_FK009_VD_-_verso_hwVfwHheS-1593471822798-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4059_-_BEG_FK009_VD_-_verso_hwVfwHheS-1593471822798-thumbnail.jpg	2	1	f	1030574	3935	2558	1.54
700	IMG_1870_oD24r4toP-1593471831587-original-.jpg	IMG_1870_oD24r4toP.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1870_oD24r4toP-1593471831587-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1870_oD24r4toP-1593471831587-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1870_oD24r4toP-1593471831587-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1870_oD24r4toP-1593471831587-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1870_oD24r4toP-1593471831587-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1870_oD24r4toP-1593471831587-thumbnail.jpg	2	1	f	770128	2000	2667	0.75
703	4065_-_E100_FK009_PT_-_cima_W4vd9NFZS-1593471828386-original-.jpg	4065_-_E100_FK009_PT_-_cima_W4vd9NFZS.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_cima_W4vd9NFZS-1593471828386-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_cima_W4vd9NFZS-1593471828386-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_cima_W4vd9NFZS-1593471828386-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_cima_W4vd9NFZS-1593471828386-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_cima_W4vd9NFZS-1593471828386-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_cima_W4vd9NFZS-1593471828386-thumbnail.jpg	2	1	f	827009	2402	3250	0.74
686	4066_-_E100_FK009_CVD_-_dentro2__1__KKMhUYEwI-1593471824378-original-.jpg	4066_-_E100_FK009_CVD_-_dentro2__1__KKMhUYEwI.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro2__1__KKMhUYEwI-1593471824378-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro2__1__KKMhUYEwI-1593471824378-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro2__1__KKMhUYEwI-1593471824378-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro2__1__KKMhUYEwI-1593471824378-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro2__1__KKMhUYEwI-1593471824378-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro2__1__KKMhUYEwI-1593471824378-thumbnail.jpg	2	1	f	599662	3013	3262	0.92
687	4066_-_E100_FK009_CVD_-_dentro1__1__q8BolJ0UX-1593471824769-original-.jpg	4066_-_E100_FK009_CVD_-_dentro1__1__q8BolJ0UX.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro1__1__q8BolJ0UX-1593471824769-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro1__1__q8BolJ0UX-1593471824769-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro1__1__q8BolJ0UX-1593471824769-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro1__1__q8BolJ0UX-1593471824769-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro1__1__q8BolJ0UX-1593471824769-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro1__1__q8BolJ0UX-1593471824769-thumbnail.jpg	2	1	f	509144	2991	3330	0.90
688	4066_-_E100_FK009_CVD_-_frente_BGz6zvB8G-1593471823981-original-.jpg	4066_-_E100_FK009_CVD_-_frente_BGz6zvB8G.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_frente_BGz6zvB8G-1593471823981-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_frente_BGz6zvB8G-1593471823981-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_frente_BGz6zvB8G-1593471823981-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_frente_BGz6zvB8G-1593471823981-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_frente_BGz6zvB8G-1593471823981-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_frente_BGz6zvB8G-1593471823981-thumbnail.jpg	2	1	f	723064	4107	2038	2.02
689	4066_-_E100_FK009_CVD_-_dentro1_Xxw4bUXke-1593471825569-original-.jpg	4066_-_E100_FK009_CVD_-_dentro1_Xxw4bUXke.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro1_Xxw4bUXke-1593471825569-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro1_Xxw4bUXke-1593471825569-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro1_Xxw4bUXke-1593471825569-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro1_Xxw4bUXke-1593471825569-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro1_Xxw4bUXke-1593471825569-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro1_Xxw4bUXke-1593471825569-thumbnail.jpg	2	1	f	509144	2991	3330	0.90
690	4066_-_E100_FK009_CVD_-_dentro2_IYf_x9UnP-1593471825173-original-.jpg	4066_-_E100_FK009_CVD_-_dentro2_IYf_x9UnP.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro2_IYf_x9UnP-1593471825173-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro2_IYf_x9UnP-1593471825173-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro2_IYf_x9UnP-1593471825173-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro2_IYf_x9UnP-1593471825173-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro2_IYf_x9UnP-1593471825173-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_dentro2_IYf_x9UnP-1593471825173-thumbnail.jpg	2	1	f	599662	3013	3262	0.92
691	4066_-_E100_FK009_CVD_-_cima_ooFZnj3Vy-1593471825983-original-.jpg	4066_-_E100_FK009_CVD_-_cima_ooFZnj3Vy.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_cima_ooFZnj3Vy-1593471825983-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_cima_ooFZnj3Vy-1593471825983-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_cima_ooFZnj3Vy-1593471825983-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_cima_ooFZnj3Vy-1593471825983-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_cima_ooFZnj3Vy-1593471825983-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4066_-_E100_FK009_CVD_-_cima_ooFZnj3Vy-1593471825983-thumbnail.jpg	2	1	f	829951	2505	3331	0.75
692	4065_-_E100_FK009_PT_-_verso_OBwi6o4sz-1593471826378-original-.jpg	4065_-_E100_FK009_PT_-_verso_OBwi6o4sz.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_verso_OBwi6o4sz-1593471826378-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_verso_OBwi6o4sz-1593471826378-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_verso_OBwi6o4sz-1593471826378-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_verso_OBwi6o4sz-1593471826378-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_verso_OBwi6o4sz-1593471826378-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_verso_OBwi6o4sz-1593471826378-thumbnail.jpg	2	1	f	738040	4049	1947	2.08
693	4065_-_E100_FK009_PT_-_frente_ytLSEXZ_a-1593471826777-original-.jpg	4065_-_E100_FK009_PT_-_frente_ytLSEXZ_a.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_frente_ytLSEXZ_a-1593471826777-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_frente_ytLSEXZ_a-1593471826777-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_frente_ytLSEXZ_a-1593471826777-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_frente_ytLSEXZ_a-1593471826777-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_frente_ytLSEXZ_a-1593471826777-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_frente_ytLSEXZ_a-1593471826777-thumbnail.jpg	2	1	f	645805	4191	2092	2.00
694	4059_-_BEG_FK009_VD_-_frente_cbNtMAMHd-1593471823181-original-.jpg	4059_-_BEG_FK009_VD_-_frente_cbNtMAMHd.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4059_-_BEG_FK009_VD_-_frente_cbNtMAMHd-1593471823181-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4059_-_BEG_FK009_VD_-_frente_cbNtMAMHd-1593471823181-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4059_-_BEG_FK009_VD_-_frente_cbNtMAMHd-1593471823181-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4059_-_BEG_FK009_VD_-_frente_cbNtMAMHd-1593471823181-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4059_-_BEG_FK009_VD_-_frente_cbNtMAMHd-1593471823181-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4059_-_BEG_FK009_VD_-_frente_cbNtMAMHd-1593471823181-thumbnail.jpg	2	1	f	1021690	3835	2528	1.52
695	4065_-_E100_FK009_PT_-_dentro1_qkF6XMQcr-1593471827573-original-.jpg	4065_-_E100_FK009_PT_-_dentro1_qkF6XMQcr.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_dentro1_qkF6XMQcr-1593471827573-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_dentro1_qkF6XMQcr-1593471827573-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_dentro1_qkF6XMQcr-1593471827573-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_dentro1_qkF6XMQcr-1593471827573-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_dentro1_qkF6XMQcr-1593471827573-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_dentro1_qkF6XMQcr-1593471827573-thumbnail.jpg	2	1	f	566147	2960	3292	0.90
696	4065_-_E100_FK009_PT_-_baixo_glFB8kJKG-1593471827980-original-.jpg	4065_-_E100_FK009_PT_-_baixo_glFB8kJKG.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_baixo_glFB8kJKG-1593471827980-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_baixo_glFB8kJKG-1593471827980-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_baixo_glFB8kJKG-1593471827980-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_baixo_glFB8kJKG-1593471827980-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_baixo_glFB8kJKG-1593471827980-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_baixo_glFB8kJKG-1593471827980-thumbnail.jpg	2	1	f	800290	2329	3258	0.71
697	4065_-_E100_FK009_PT_-_dentro2_Q29eMmwP0-1593471827180-original-.jpg	4065_-_E100_FK009_PT_-_dentro2_Q29eMmwP0.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_dentro2_Q29eMmwP0-1593471827180-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_dentro2_Q29eMmwP0-1593471827180-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_dentro2_Q29eMmwP0-1593471827180-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_dentro2_Q29eMmwP0-1593471827180-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_dentro2_Q29eMmwP0-1593471827180-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4065_-_E100_FK009_PT_-_dentro2_Q29eMmwP0-1593471827180-thumbnail.jpg	2	1	f	662156	3266	3292	0.99
698	IMG_1225_1yj9cROXA-1593471832040-original-.jpg	IMG_1225_1yj9cROXA.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1225_1yj9cROXA-1593471832040-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1225_1yj9cROXA-1593471832040-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1225_1yj9cROXA-1593471832040-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1225_1yj9cROXA-1593471832040-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1225_1yj9cROXA-1593471832040-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1225_1yj9cROXA-1593471832040-thumbnail.jpg	2	1	f	418439	1500	2000	0.75
705	IMG_4801_g1RxfIkhU-1593471832380-original-.jpg	IMG_4801_g1RxfIkhU.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_4801_g1RxfIkhU-1593471832380-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_4801_g1RxfIkhU-1593471832380-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_4801_g1RxfIkhU-1593471832380-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_4801_g1RxfIkhU-1593471832380-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_4801_g1RxfIkhU-1593471832380-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_4801_g1RxfIkhU-1593471832380-thumbnail.jpg	2	1	f	1069023	3024	4032	0.75
706	4051_-_CGA_FK009_PT_-_frente__1__LbGAOcqSe-1593471829970-original-.jpg	4051_-_CGA_FK009_PT_-_frente__1__LbGAOcqSe.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4051_-_CGA_FK009_PT_-_frente__1__LbGAOcqSe-1593471829970-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4051_-_CGA_FK009_PT_-_frente__1__LbGAOcqSe-1593471829970-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4051_-_CGA_FK009_PT_-_frente__1__LbGAOcqSe-1593471829970-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4051_-_CGA_FK009_PT_-_frente__1__LbGAOcqSe-1593471829970-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4051_-_CGA_FK009_PT_-_frente__1__LbGAOcqSe-1593471829970-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4051_-_CGA_FK009_PT_-_frente__1__LbGAOcqSe-1593471829970-thumbnail.jpg	2	1	f	1049602	4558	2555	1.78
709	4051_-_CGA_FK009_PT_-_verso__1__7mN8-ewG9-1593471829584-original-.jpg	4051_-_CGA_FK009_PT_-_verso__1__7mN8-ewG9.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4051_-_CGA_FK009_PT_-_verso__1__7mN8-ewG9-1593471829584-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4051_-_CGA_FK009_PT_-_verso__1__7mN8-ewG9-1593471829584-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4051_-_CGA_FK009_PT_-_verso__1__7mN8-ewG9-1593471829584-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4051_-_CGA_FK009_PT_-_verso__1__7mN8-ewG9-1593471829584-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4051_-_CGA_FK009_PT_-_verso__1__7mN8-ewG9-1593471829584-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4051_-_CGA_FK009_PT_-_verso__1__7mN8-ewG9-1593471829584-thumbnail.jpg	2	1	f	1125396	4420	2711	1.63
713	bolsaazul2_1_X3ef1pRcl-1593471835974-original-.jpg	bolsaazul2_1_X3ef1pRcl.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul2_1_X3ef1pRcl-1593471835974-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul2_1_X3ef1pRcl-1593471835974-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul2_1_X3ef1pRcl-1593471835974-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul2_1_X3ef1pRcl-1593471835974-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul2_1_X3ef1pRcl-1593471835974-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul2_1_X3ef1pRcl-1593471835974-thumbnail.jpg	2	1	f	742774	2000	2667	0.75
716	bolsa-melancia1_fKeC0YRj9-1593471837176-original-.jpg	bolsa-melancia1_fKeC0YRj9.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-melancia1_fKeC0YRj9-1593471837176-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-melancia1_fKeC0YRj9-1593471837176-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-melancia1_fKeC0YRj9-1593471837176-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-melancia1_fKeC0YRj9-1593471837176-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-melancia1_fKeC0YRj9-1593471837176-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-melancia1_fKeC0YRj9-1593471837176-thumbnail.jpg	2	1	f	746298	2000	2667	0.75
725	IMG_2328_OS1M0Go1t-1593471839710-original-.jpg	IMG_2328_OS1M0Go1t.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2328_OS1M0Go1t-1593471839710-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2328_OS1M0Go1t-1593471839710-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2328_OS1M0Go1t-1593471839710-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2328_OS1M0Go1t-1593471839710-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2328_OS1M0Go1t-1593471839710-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2328_OS1M0Go1t-1593471839710-thumbnail.jpg	2	1	f	1309620	3024	4032	0.75
742	IMG_1856_C4Qqfh0t_-1593471842789-original-.jpg	IMG_1856_C4Qqfh0t_.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1856_C4Qqfh0t_-1593471842789-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1856_C4Qqfh0t_-1593471842789-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1856_C4Qqfh0t_-1593471842789-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1856_C4Qqfh0t_-1593471842789-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1856_C4Qqfh0t_-1593471842789-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1856_C4Qqfh0t_-1593471842789-thumbnail.jpg	2	1	f	1146202	3024	4032	0.75
743	IMG_1855_6hkqs8Tp--1593471843184-original-.jpg	IMG_1855_6hkqs8Tp-.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1855_6hkqs8Tp--1593471843184-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1855_6hkqs8Tp--1593471843184-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1855_6hkqs8Tp--1593471843184-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1855_6hkqs8Tp--1593471843184-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1855_6hkqs8Tp--1593471843184-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1855_6hkqs8Tp--1593471843184-thumbnail.jpg	2	1	f	1131851	3024	4032	0.75
707	4052_-_CGA_FK009_C_-_frente_bultHkZyB-1593471829207-original-.jpg	4052_-_CGA_FK009_C_-_frente_bultHkZyB.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4052_-_CGA_FK009_C_-_frente_bultHkZyB-1593471829207-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4052_-_CGA_FK009_C_-_frente_bultHkZyB-1593471829207-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4052_-_CGA_FK009_C_-_frente_bultHkZyB-1593471829207-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4052_-_CGA_FK009_C_-_frente_bultHkZyB-1593471829207-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4052_-_CGA_FK009_C_-_frente_bultHkZyB-1593471829207-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4052_-_CGA_FK009_C_-_frente_bultHkZyB-1593471829207-thumbnail.jpg	2	1	f	1151164	4432	2758	1.61
708	4052_-_CGA_FK009_C_-_verso_vd9BVnsox-1593471828784-original-.jpg	4052_-_CGA_FK009_C_-_verso_vd9BVnsox.JPG	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4052_-_CGA_FK009_C_-_verso_vd9BVnsox-1593471828784-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4052_-_CGA_FK009_C_-_verso_vd9BVnsox-1593471828784-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4052_-_CGA_FK009_C_-_verso_vd9BVnsox-1593471828784-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4052_-_CGA_FK009_C_-_verso_vd9BVnsox-1593471828784-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4052_-_CGA_FK009_C_-_verso_vd9BVnsox-1593471828784-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/4052_-_CGA_FK009_C_-_verso_vd9BVnsox-1593471828784-thumbnail.jpg	2	1	f	1257930	4417	2799	1.58
710	bolsamelancia_YRDGfbtT7-1593471835174-original-.jpg	bolsamelancia_YRDGfbtT7.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsamelancia_YRDGfbtT7-1593471835174-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsamelancia_YRDGfbtT7-1593471835174-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsamelancia_YRDGfbtT7-1593471835174-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsamelancia_YRDGfbtT7-1593471835174-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsamelancia_YRDGfbtT7-1593471835174-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsamelancia_YRDGfbtT7-1593471835174-thumbnail.jpg	2	1	f	831232	3024	3024	1.00
711	bolsaazul2_BRrNh8oBj-1593471834784-original-.jpg	bolsaazul2_BRrNh8oBj.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul2_BRrNh8oBj-1593471834784-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul2_BRrNh8oBj-1593471834784-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul2_BRrNh8oBj-1593471834784-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul2_BRrNh8oBj-1593471834784-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul2_BRrNh8oBj-1593471834784-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul2_BRrNh8oBj-1593471834784-thumbnail.jpg	2	1	f	1236714	3024	3024	1.00
712	bolsa-melancia_1_4QPru6m6F-1593471836771-original-.jpg	bolsa-melancia_1_4QPru6m6F.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-melancia_1_4QPru6m6F-1593471836771-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-melancia_1_4QPru6m6F-1593471836771-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-melancia_1_4QPru6m6F-1593471836771-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-melancia_1_4QPru6m6F-1593471836771-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-melancia_1_4QPru6m6F-1593471836771-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-melancia_1_4QPru6m6F-1593471836771-thumbnail.jpg	2	1	f	588044	2000	2667	0.75
714	bolsaazul1_jZ8aVT7vH-1593471836699-original-.jpg	bolsaazul1_jZ8aVT7vH.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul1_jZ8aVT7vH-1593471836699-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul1_jZ8aVT7vH-1593471836699-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul1_jZ8aVT7vH-1593471836699-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul1_jZ8aVT7vH-1593471836699-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul1_jZ8aVT7vH-1593471836699-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsaazul1_jZ8aVT7vH-1593471836699-thumbnail.jpg	2	1	f	608672	2000	2667	0.75
715	IMG_1792_X64j60q3K-1593471833184-original-.jpg	IMG_1792_X64j60q3K.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1792_X64j60q3K-1593471833184-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1792_X64j60q3K-1593471833184-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1792_X64j60q3K-1593471833184-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1792_X64j60q3K-1593471833184-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1792_X64j60q3K-1593471833184-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1792_X64j60q3K-1593471833184-thumbnail.jpg	2	1	f	1096236	3024	4032	0.75
724	IMG_2334_UiHDmIK1H-1593471838807-original-.jpg	IMG_2334_UiHDmIK1H.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2334_UiHDmIK1H-1593471838807-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2334_UiHDmIK1H-1593471838807-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2334_UiHDmIK1H-1593471838807-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2334_UiHDmIK1H-1593471838807-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2334_UiHDmIK1H-1593471838807-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2334_UiHDmIK1H-1593471838807-thumbnail.jpg	2	1	f	1438017	3024	4032	0.75
729	WhatsApp_Image_2020-03-10_at_15.14.30_ZzuldF0Gi-1593471844760-original-.jpg	WhatsApp_Image_2020-03-10_at_15.14.30_ZzuldF0Gi.jpeg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.30_ZzuldF0Gi-1593471844760-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.30_ZzuldF0Gi-1593471844760-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.30_ZzuldF0Gi-1593471844760-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.30_ZzuldF0Gi-1593471844760-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.30_ZzuldF0Gi-1593471844760-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.30_ZzuldF0Gi-1593471844760-thumbnail.jpg	2	1	f	56749	960	1280	0.75
734	IMG_1862_8QWyF7oKv-1593471841570-original-.jpg	IMG_1862_8QWyF7oKv.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1862_8QWyF7oKv-1593471841570-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1862_8QWyF7oKv-1593471841570-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1862_8QWyF7oKv-1593471841570-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1862_8QWyF7oKv-1593471841570-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1862_8QWyF7oKv-1593471841570-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1862_8QWyF7oKv-1593471841570-thumbnail.jpg	2	1	f	789484	3024	4032	0.75
735	IMG_1860_1zsdkh5mB-1593471842380-original-.jpg	IMG_1860_1zsdkh5mB.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1860_1zsdkh5mB-1593471842380-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1860_1zsdkh5mB-1593471842380-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1860_1zsdkh5mB-1593471842380-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1860_1zsdkh5mB-1593471842380-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1860_1zsdkh5mB-1593471842380-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1860_1zsdkh5mB-1593471842380-thumbnail.jpg	2	1	f	688516	3024	4032	0.75
738	A05938_7bnUNXW-d-1593471847159-original-.jpg	A05938_7bnUNXW-d.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05938_7bnUNXW-d-1593471847159-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05938_7bnUNXW-d-1593471847159-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05938_7bnUNXW-d-1593471847159-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05938_7bnUNXW-d-1593471847159-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05938_7bnUNXW-d-1593471847159-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/A05938_7bnUNXW-d-1593471847159-thumbnail.jpg	2	1	f	13991	800	800	1.00
717	fridinha-preta2_PNX5a-qKv-1593471833977-original-.jpg	fridinha-preta2_PNX5a-qKv.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/fridinha-preta2_PNX5a-qKv-1593471833977-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/fridinha-preta2_PNX5a-qKv-1593471833977-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/fridinha-preta2_PNX5a-qKv-1593471833977-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/fridinha-preta2_PNX5a-qKv-1593471833977-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/fridinha-preta2_PNX5a-qKv-1593471833977-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/fridinha-preta2_PNX5a-qKv-1593471833977-thumbnail.jpg	2	1	f	920080	3024	3024	1.00
718	bolsatransversal-azul_jOAMg3lwR-1593471837581-original-.jpg	bolsatransversal-azul_jOAMg3lwR.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsatransversal-azul_jOAMg3lwR-1593471837581-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsatransversal-azul_jOAMg3lwR-1593471837581-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsatransversal-azul_jOAMg3lwR-1593471837581-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsatransversal-azul_jOAMg3lwR-1593471837581-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsatransversal-azul_jOAMg3lwR-1593471837581-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsatransversal-azul_jOAMg3lwR-1593471837581-thumbnail.jpg	2	1	f	724349	2000	2667	0.75
719	fridinha-preta_XDqG_LDl_-1593471835581-original-.jpg	fridinha-preta_XDqG_LDl_.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/fridinha-preta_XDqG_LDl_-1593471835581-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/fridinha-preta_XDqG_LDl_-1593471835581-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/fridinha-preta_XDqG_LDl_-1593471835581-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/fridinha-preta_XDqG_LDl_-1593471835581-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/fridinha-preta_XDqG_LDl_-1593471835581-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/fridinha-preta_XDqG_LDl_-1593471835581-thumbnail.jpg	2	1	f	1018388	3024	3024	1.00
720	43426_mgkiHEGsp-1593471843961-original-.png	43426_mgkiHEGsp.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43426_mgkiHEGsp-1593471843961-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43426_mgkiHEGsp-1593471843961-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43426_mgkiHEGsp-1593471843961-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43426_mgkiHEGsp-1593471843961-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43426_mgkiHEGsp-1593471843961-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43426_mgkiHEGsp-1593471843961-thumbnail.png	2	1	f	5031	300	300	1.00
721	IMG_2338_3SBLpcpor-1593471837991-original-.jpg	IMG_2338_3SBLpcpor.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2338_3SBLpcpor-1593471837991-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2338_3SBLpcpor-1593471837991-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2338_3SBLpcpor-1593471837991-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2338_3SBLpcpor-1593471837991-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2338_3SBLpcpor-1593471837991-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2338_3SBLpcpor-1593471837991-thumbnail.jpg	2	1	f	1388375	3024	4032	0.75
722	43413_FIpFWPlQR-1593471844358-original-.png	43413_FIpFWPlQR.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43413_FIpFWPlQR-1593471844358-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43413_FIpFWPlQR-1593471844358-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43413_FIpFWPlQR-1593471844358-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43413_FIpFWPlQR-1593471844358-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43413_FIpFWPlQR-1593471844358-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/43413_FIpFWPlQR-1593471844358-thumbnail.png	2	1	f	5730	300	300	1.00
723	IMG_2337_OFWWHyjlJ-1593471838444-original-.jpg	IMG_2337_OFWWHyjlJ.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2337_OFWWHyjlJ-1593471838444-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2337_OFWWHyjlJ-1593471838444-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2337_OFWWHyjlJ-1593471838444-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2337_OFWWHyjlJ-1593471838444-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2337_OFWWHyjlJ-1593471838444-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2337_OFWWHyjlJ-1593471838444-thumbnail.jpg	2	1	f	1575146	3024	4032	0.75
726	IMG_1791_a_m_UoOOp-1593471833585-original-.jpg	IMG_1791_a_m_UoOOp.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1791_a_m_UoOOp-1593471833585-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1791_a_m_UoOOp-1593471833585-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1791_a_m_UoOOp-1593471833585-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1791_a_m_UoOOp-1593471833585-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1791_a_m_UoOOp-1593471833585-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1791_a_m_UoOOp-1593471833585-thumbnail.jpg	2	1	f	962556	3024	4032	0.75
727	IMG_2302_LKyTSWBbO-1593471840440-original-.jpg	IMG_2302_LKyTSWBbO.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2302_LKyTSWBbO-1593471840440-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2302_LKyTSWBbO-1593471840440-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2302_LKyTSWBbO-1593471840440-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2302_LKyTSWBbO-1593471840440-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2302_LKyTSWBbO-1593471840440-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2302_LKyTSWBbO-1593471840440-thumbnail.jpg	2	1	f	1084015	3024	4032	0.75
728	IMG_2327_RVjLSXS13-1593471839987-original-.jpg	IMG_2327_RVjLSXS13.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2327_RVjLSXS13-1593471839987-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2327_RVjLSXS13-1593471839987-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2327_RVjLSXS13-1593471839987-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2327_RVjLSXS13-1593471839987-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2327_RVjLSXS13-1593471839987-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2327_RVjLSXS13-1593471839987-thumbnail.jpg	2	1	f	1371442	3024	4032	0.75
733	WhatsApp_Image_2020-03-10_at_15.14.40_1RwkYcinv-1593471845557-original-.jpg	WhatsApp_Image_2020-03-10_at_15.14.40_1RwkYcinv.jpeg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.40_1RwkYcinv-1593471845557-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.40_1RwkYcinv-1593471845557-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.40_1RwkYcinv-1593471845557-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.40_1RwkYcinv-1593471845557-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.40_1RwkYcinv-1593471845557-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.40_1RwkYcinv-1593471845557-thumbnail.jpg	2	1	f	60257	960	1280	0.75
736	IMG_2298_WM0xlgxu4-1593471841193-original-.jpg	IMG_2298_WM0xlgxu4.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2298_WM0xlgxu4-1593471841193-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2298_WM0xlgxu4-1593471841193-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2298_WM0xlgxu4-1593471841193-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2298_WM0xlgxu4-1593471841193-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2298_WM0xlgxu4-1593471841193-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2298_WM0xlgxu4-1593471841193-thumbnail.jpg	2	1	f	1020645	3024	4032	0.75
737	20200311_165447_tJSaXtZT0-1593471846361-original-.jpg	20200311_165447_tJSaXtZT0.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/20200311_165447_tJSaXtZT0-1593471846361-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/20200311_165447_tJSaXtZT0-1593471846361-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/20200311_165447_tJSaXtZT0-1593471846361-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/20200311_165447_tJSaXtZT0-1593471846361-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/20200311_165447_tJSaXtZT0-1593471846361-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/20200311_165447_tJSaXtZT0-1593471846361-thumbnail.jpg	2	1	f	49334	1000	1000	1.00
739	IMG_1861_d6Y0tfy6W-1593471841978-original-.jpg	IMG_1861_d6Y0tfy6W.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1861_d6Y0tfy6W-1593471841978-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1861_d6Y0tfy6W-1593471841978-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1861_d6Y0tfy6W-1593471841978-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1861_d6Y0tfy6W-1593471841978-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1861_d6Y0tfy6W-1593471841978-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_1861_d6Y0tfy6W-1593471841978-thumbnail.jpg	2	1	f	970086	3024	4032	0.75
740	20200311_173120_nsWs-vTw1-1593471846771-original-.jpg	20200311_173120_nsWs-vTw1.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/20200311_173120_nsWs-vTw1-1593471846771-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/20200311_173120_nsWs-vTw1-1593471846771-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/20200311_173120_nsWs-vTw1-1593471846771-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/20200311_173120_nsWs-vTw1-1593471846771-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/20200311_173120_nsWs-vTw1-1593471846771-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/20200311_173120_nsWs-vTw1-1593471846771-thumbnail.jpg	2	1	f	70269	1000	1000	1.00
741	IMG_2300_e17GRt7K1-1593471840778-original-.jpg	IMG_2300_e17GRt7K1.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2300_e17GRt7K1-1593471840778-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2300_e17GRt7K1-1593471840778-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2300_e17GRt7K1-1593471840778-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2300_e17GRt7K1-1593471840778-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2300_e17GRt7K1-1593471840778-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2300_e17GRt7K1-1593471840778-thumbnail.jpg	2	1	f	883845	3024	4032	0.75
730	WhatsApp_Image_2020-03-10_at_15.14.21_gFd80lbor-1593471845157-original-.jpg	WhatsApp_Image_2020-03-10_at_15.14.21_gFd80lbor.jpeg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.21_gFd80lbor-1593471845157-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.21_gFd80lbor-1593471845157-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.21_gFd80lbor-1593471845157-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.21_gFd80lbor-1593471845157-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.21_gFd80lbor-1593471845157-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/WhatsApp_Image_2020-03-10_at_15.14.21_gFd80lbor-1593471845157-thumbnail.jpg	2	1	f	60784	960	1280	0.75
731	MiniCanecaPorcelanaFridaKahloFaceAmarelo_rj3DbPM5I-1593471843590-original-.jpg	MiniCanecaPorcelanaFridaKahloFaceAmarelo_rj3DbPM5I.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/MiniCanecaPorcelanaFridaKahloFaceAmarelo_rj3DbPM5I-1593471843590-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/MiniCanecaPorcelanaFridaKahloFaceAmarelo_rj3DbPM5I-1593471843590-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/MiniCanecaPorcelanaFridaKahloFaceAmarelo_rj3DbPM5I-1593471843590-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/MiniCanecaPorcelanaFridaKahloFaceAmarelo_rj3DbPM5I-1593471843590-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/MiniCanecaPorcelanaFridaKahloFaceAmarelo_rj3DbPM5I-1593471843590-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/MiniCanecaPorcelanaFridaKahloFaceAmarelo_rj3DbPM5I-1593471843590-thumbnail.jpg	2	1	f	21458	400	400	1.00
732	bolsa-saco_x4NfWD4g--1593471834381-original-.jpg	bolsa-saco_x4NfWD4g-.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-saco_x4NfWD4g--1593471834381-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-saco_x4NfWD4g--1593471834381-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-saco_x4NfWD4g--1593471834381-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-saco_x4NfWD4g--1593471834381-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-saco_x4NfWD4g--1593471834381-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/bolsa-saco_x4NfWD4g--1593471834381-thumbnail.jpg	2	1	f	674560	3024	3024	1.00
744	02__1__15OnmM4N5-1593471847577-original-.jpg	02__1__15OnmM4N5.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02__1__15OnmM4N5-1593471847577-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02__1__15OnmM4N5-1593471847577-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02__1__15OnmM4N5-1593471847577-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02__1__15OnmM4N5-1593471847577-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02__1__15OnmM4N5-1593471847577-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02__1__15OnmM4N5-1593471847577-thumbnail.jpg	1	0	f	260610	1180	1180	1.00
745	03__2__N7rIc5Oih-1593471847964-original-.jpg	03__2__N7rIc5Oih.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03__2__N7rIc5Oih-1593471847964-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03__2__N7rIc5Oih-1593471847964-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03__2__N7rIc5Oih-1593471847964-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03__2__N7rIc5Oih-1593471847964-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03__2__N7rIc5Oih-1593471847964-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03__2__N7rIc5Oih-1593471847964-thumbnail.jpg	2	1	f	177489	1180	1180	1.00
746	01_p1n8KtaGR-1593471848363-original-.jpg	01_p1n8KtaGR.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/01_p1n8KtaGR-1593471848363-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/01_p1n8KtaGR-1593471848363-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/01_p1n8KtaGR-1593471848363-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/01_p1n8KtaGR-1593471848363-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/01_p1n8KtaGR-1593471848363-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/01_p1n8KtaGR-1593471848363-thumbnail.jpg	2	1	f	228726	1180	1180	1.00
747	foto06_ury3A4vJr-1593471848793-original-.jpg	foto06_ury3A4vJr.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto06_ury3A4vJr-1593471848793-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto06_ury3A4vJr-1593471848793-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto06_ury3A4vJr-1593471848793-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto06_ury3A4vJr-1593471848793-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto06_ury3A4vJr-1593471848793-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto06_ury3A4vJr-1593471848793-thumbnail.jpg	2	2	f	159664	1180	1180	1.00
748	foto05_i65iXquPh-1593471849220-original-.jpg	foto05_i65iXquPh.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto05_i65iXquPh-1593471849220-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto05_i65iXquPh-1593471849220-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto05_i65iXquPh-1593471849220-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto05_i65iXquPh-1593471849220-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto05_i65iXquPh-1593471849220-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto05_i65iXquPh-1593471849220-thumbnail.jpg	2	1	f	144160	1180	1180	1.00
749	melancia2_YatzVsicK-1593471846027-original-.jpg	melancia2_YatzVsicK.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/melancia2_YatzVsicK-1593471846027-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/melancia2_YatzVsicK-1593471846027-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/melancia2_YatzVsicK-1593471846027-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/melancia2_YatzVsicK-1593471846027-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/melancia2_YatzVsicK-1593471846027-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/melancia2_YatzVsicK-1593471846027-thumbnail.jpg	2	1	f	1377781	3024	3024	1.00
750	foto01_OG582aHQa-1593471849963-original-.jpg	foto01_OG582aHQa.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto01_OG582aHQa-1593471849963-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto01_OG582aHQa-1593471849963-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto01_OG582aHQa-1593471849963-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto01_OG582aHQa-1593471849963-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto01_OG582aHQa-1593471849963-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto01_OG582aHQa-1593471849963-thumbnail.jpg	2	1	f	144516	1180	1180	1.00
751	02__1__9q0MqVhAt-1593471850367-original-.jpg	02__1__9q0MqVhAt.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02__1__9q0MqVhAt-1593471850367-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02__1__9q0MqVhAt-1593471850367-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02__1__9q0MqVhAt-1593471850367-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02__1__9q0MqVhAt-1593471850367-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02__1__9q0MqVhAt-1593471850367-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02__1__9q0MqVhAt-1593471850367-thumbnail.jpg	2	1	f	260610	1180	1180	1.00
752	02_AnGGz1_4J-1593471851163-original-.jpg	02_AnGGz1_4J.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02_AnGGz1_4J-1593471851163-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02_AnGGz1_4J-1593471851163-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02_AnGGz1_4J-1593471851163-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02_AnGGz1_4J-1593471851163-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02_AnGGz1_4J-1593471851163-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/02_AnGGz1_4J-1593471851163-thumbnail.jpg	2	1	f	126174	1180	1180	1.00
753	03_h4kIapoSf-1593471851555-original-.jpg	03_h4kIapoSf.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03_h4kIapoSf-1593471851555-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03_h4kIapoSf-1593471851555-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03_h4kIapoSf-1593471851555-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03_h4kIapoSf-1593471851555-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03_h4kIapoSf-1593471851555-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03_h4kIapoSf-1593471851555-thumbnail.jpg	2	1	f	150761	1180	1180	1.00
754	foto03_k3ufCxaSh-1593471849621-original-.jpg	foto03_k3ufCxaSh.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto03_k3ufCxaSh-1593471849621-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto03_k3ufCxaSh-1593471849621-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto03_k3ufCxaSh-1593471849621-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto03_k3ufCxaSh-1593471849621-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto03_k3ufCxaSh-1593471849621-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto03_k3ufCxaSh-1593471849621-thumbnail.jpg	2	1	f	148806	1180	1180	1.00
755	foto10_GfrVED64O-1593471852768-original-.jpg	foto10_GfrVED64O.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto10_GfrVED64O-1593471852768-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto10_GfrVED64O-1593471852768-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto10_GfrVED64O-1593471852768-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto10_GfrVED64O-1593471852768-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto10_GfrVED64O-1593471852768-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto10_GfrVED64O-1593471852768-thumbnail.jpg	2	1	f	193364	1180	1180	1.00
756	foto11_nEMSmLJZz-1593471852424-original-.jpg	foto11_nEMSmLJZz.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto11_nEMSmLJZz-1593471852424-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto11_nEMSmLJZz-1593471852424-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto11_nEMSmLJZz-1593471852424-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto11_nEMSmLJZz-1593471852424-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto11_nEMSmLJZz-1593471852424-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto11_nEMSmLJZz-1593471852424-thumbnail.jpg	2	1	f	503409	1180	1180	1.00
757	03__1__tk0wY08KE-1593471850763-original-.jpg	03__1__tk0wY08KE.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03__1__tk0wY08KE-1593471850763-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03__1__tk0wY08KE-1593471850763-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03__1__tk0wY08KE-1593471850763-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03__1__tk0wY08KE-1593471850763-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03__1__tk0wY08KE-1593471850763-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/03__1__tk0wY08KE-1593471850763-thumbnail.jpg	2	1	f	120318	1180	1180	1.00
758	foto02_05arEj9IM-1593471855167-original-.jpg	foto02_05arEj9IM.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto02_05arEj9IM-1593471855167-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto02_05arEj9IM-1593471855167-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto02_05arEj9IM-1593471855167-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto02_05arEj9IM-1593471855167-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto02_05arEj9IM-1593471855167-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto02_05arEj9IM-1593471855167-thumbnail.jpg	2	1	f	270514	1180	1180	1.00
759	foto9_nzk5n93zV-1593471851965-original-.jpg	foto9_nzk5n93zV.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto9_nzk5n93zV-1593471851965-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto9_nzk5n93zV-1593471851965-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto9_nzk5n93zV-1593471851965-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto9_nzk5n93zV-1593471851965-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto9_nzk5n93zV-1593471851965-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto9_nzk5n93zV-1593471851965-thumbnail.jpg	2	1	f	257740	1180	1180	1.00
760	foto01__1__vI1rAkxtp-1593471855567-original-.jpg	foto01__1__vI1rAkxtp.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto01__1__vI1rAkxtp-1593471855567-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto01__1__vI1rAkxtp-1593471855567-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto01__1__vI1rAkxtp-1593471855567-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto01__1__vI1rAkxtp-1593471855567-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto01__1__vI1rAkxtp-1593471855567-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto01__1__vI1rAkxtp-1593471855567-thumbnail.jpg	2	1	f	302498	1180	1180	1.00
761	mask2_0pTMS00UK-1593471857554-original-.jpg	mask2_0pTMS00UK.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mask2_0pTMS00UK-1593471857554-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mask2_0pTMS00UK-1593471857554-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mask2_0pTMS00UK-1593471857554-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mask2_0pTMS00UK-1593471857554-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mask2_0pTMS00UK-1593471857554-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mask2_0pTMS00UK-1593471857554-thumbnail.jpg	2	1	f	59741	1180	1180	1.00
762	mask__dwY0y6YK-1593471857959-original-.jpg	mask__dwY0y6YK.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mask__dwY0y6YK-1593471857959-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mask__dwY0y6YK-1593471857959-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mask__dwY0y6YK-1593471857959-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mask__dwY0y6YK-1593471857959-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mask__dwY0y6YK-1593471857959-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mask__dwY0y6YK-1593471857959-thumbnail.jpg	2	1	f	77565	1180	1180	1.00
763	conunto4_wP8v927t3-1593471853203-original-.jpg	conunto4_wP8v927t3.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conunto4_wP8v927t3-1593471853203-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conunto4_wP8v927t3-1593471853203-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conunto4_wP8v927t3-1593471853203-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conunto4_wP8v927t3-1593471853203-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conunto4_wP8v927t3-1593471853203-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conunto4_wP8v927t3-1593471853203-thumbnail.jpg	2	3	f	1218062	3024	4032	0.75
764	agnes-sanches_EKJX8RT0S-1593471858759-original-.png	agnes-sanches_EKJX8RT0S.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/agnes-sanches_EKJX8RT0S-1593471858759-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/agnes-sanches_EKJX8RT0S-1593471858759-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/agnes-sanches_EKJX8RT0S-1593471858759-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/agnes-sanches_EKJX8RT0S-1593471858759-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/agnes-sanches_EKJX8RT0S-1593471858759-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/agnes-sanches_EKJX8RT0S-1593471858759-thumbnail.png	1	0	f	56342	512	512	1.00
765	IMG_2329_x0V5rq3gh-1593471839180-original-.jpg	IMG_2329_x0V5rq3gh.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2329_x0V5rq3gh-1593471839180-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2329_x0V5rq3gh-1593471839180-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2329_x0V5rq3gh-1593471839180-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2329_x0V5rq3gh-1593471839180-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2329_x0V5rq3gh-1593471839180-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2329_x0V5rq3gh-1593471839180-thumbnail.jpg	2	1	f	1135350	3024	4032	0.75
766	conjunto03_NjWEL0dHG-1593471853584-original-.jpg	conjunto03_NjWEL0dHG.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto03_NjWEL0dHG-1593471853584-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto03_NjWEL0dHG-1593471853584-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto03_NjWEL0dHG-1593471853584-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto03_NjWEL0dHG-1593471853584-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto03_NjWEL0dHG-1593471853584-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto03_NjWEL0dHG-1593471853584-thumbnail.jpg	2	2	f	1272252	3024	4032	0.75
767	conjunto02_9PpX--71s-1593471854001-original-.jpg	conjunto02_9PpX--71s.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto02_9PpX--71s-1593471854001-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto02_9PpX--71s-1593471854001-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto02_9PpX--71s-1593471854001-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto02_9PpX--71s-1593471854001-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto02_9PpX--71s-1593471854001-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto02_9PpX--71s-1593471854001-thumbnail.jpg	2	2	f	1438647	3024	4032	0.75
768	cartas_vIoXOdzbw-1593471859170-original-.jpg	cartas_vIoXOdzbw.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cartas_vIoXOdzbw-1593471859170-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cartas_vIoXOdzbw-1593471859170-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cartas_vIoXOdzbw-1593471859170-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cartas_vIoXOdzbw-1593471859170-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cartas_vIoXOdzbw-1593471859170-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cartas_vIoXOdzbw-1593471859170-thumbnail.jpg	1	0	f	135681	1280	628	2.04
769	IMG_2338_E-Y84s4fu-1593471854796-original-.jpg	IMG_2338_E-Y84s4fu.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2338_E-Y84s4fu-1593471854796-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2338_E-Y84s4fu-1593471854796-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2338_E-Y84s4fu-1593471854796-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2338_E-Y84s4fu-1593471854796-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2338_E-Y84s4fu-1593471854796-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_2338_E-Y84s4fu-1593471854796-thumbnail.jpg	2	1	f	1388375	3024	4032	0.75
770	frida-kahlo-e-familia-2_pa-8lSRv0-1593471859559-original-.jpg	frida-kahlo-e-familia-2_pa-8lSRv0.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/frida-kahlo-e-familia-2_pa-8lSRv0-1593471859559-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/frida-kahlo-e-familia-2_pa-8lSRv0-1593471859559-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/frida-kahlo-e-familia-2_pa-8lSRv0-1593471859559-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/frida-kahlo-e-familia-2_pa-8lSRv0-1593471859559-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/frida-kahlo-e-familia-2_pa-8lSRv0-1593471859559-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/frida-kahlo-e-familia-2_pa-8lSRv0-1593471859559-thumbnail.jpg	1	0	f	141639	1200	832	1.44
771	foto04_zrnSnSrT6-1593471859965-original-.jpg	foto04_zrnSnSrT6.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto04_zrnSnSrT6-1593471859965-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto04_zrnSnSrT6-1593471859965-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto04_zrnSnSrT6-1593471859965-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto04_zrnSnSrT6-1593471859965-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto04_zrnSnSrT6-1593471859965-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/foto04_zrnSnSrT6-1593471859965-thumbnail.jpg	2	1	f	190170	1180	1180	1.00
772	mascara3_-75jj4SQz-1593471858362-original-.jpg	mascara3_-75jj4SQz.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mascara3_-75jj4SQz-1593471858362-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mascara3_-75jj4SQz-1593471858362-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mascara3_-75jj4SQz-1593471858362-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mascara3_-75jj4SQz-1593471858362-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mascara3_-75jj4SQz-1593471858362-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/mascara3_-75jj4SQz-1593471858362-thumbnail.jpg	2	1	f	227948	1180	1180	1.00
773	conjunto3-2_9V9Im7I-g-1593471860762-original-.jpg	conjunto3-2_9V9Im7I-g.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3-2_9V9Im7I-g-1593471860762-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3-2_9V9Im7I-g-1593471860762-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3-2_9V9Im7I-g-1593471860762-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3-2_9V9Im7I-g-1593471860762-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3-2_9V9Im7I-g-1593471860762-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3-2_9V9Im7I-g-1593471860762-thumbnail.jpg	2	2	f	156981	1180	1180	1.00
774	cj-pulseiraberloque_fQBNAdlg--1593471861557-original-.jpg	cj-pulseiraberloque_fQBNAdlg-.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-pulseiraberloque_fQBNAdlg--1593471861557-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-pulseiraberloque_fQBNAdlg--1593471861557-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-pulseiraberloque_fQBNAdlg--1593471861557-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-pulseiraberloque_fQBNAdlg--1593471861557-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-pulseiraberloque_fQBNAdlg--1593471861557-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-pulseiraberloque_fQBNAdlg--1593471861557-thumbnail.jpg	2	2	f	62693	1180	1180	1.00
777	cj-correntebrinco_ji-gaZe6O-1593471862357-original-.jpg	cj-correntebrinco_ji-gaZe6O.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-correntebrinco_ji-gaZe6O-1593471862357-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-correntebrinco_ji-gaZe6O-1593471862357-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-correntebrinco_ji-gaZe6O-1593471862357-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-correntebrinco_ji-gaZe6O-1593471862357-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-correntebrinco_ji-gaZe6O-1593471862357-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-correntebrinco_ji-gaZe6O-1593471862357-thumbnail.jpg	2	3	f	49829	1180	1180	1.00
778	cj-correntebrinco_Wpj0qbetD-1593471862759-original-.jpg	cj-correntebrinco_Wpj0qbetD.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-correntebrinco_Wpj0qbetD-1593471862759-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-correntebrinco_Wpj0qbetD-1593471862759-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-correntebrinco_Wpj0qbetD-1593471862759-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-correntebrinco_Wpj0qbetD-1593471862759-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-correntebrinco_Wpj0qbetD-1593471862759-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/cj-correntebrinco_Wpj0qbetD-1593471862759-thumbnail.jpg	2	3	f	49829	1180	1180	1.00
775	conjunto1-2_SataJWu-Z-1593471860362-original-.jpg	conjunto1-2_SataJWu-Z.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1-2_SataJWu-Z-1593471860362-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1-2_SataJWu-Z-1593471860362-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1-2_SataJWu-Z-1593471860362-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1-2_SataJWu-Z-1593471860362-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1-2_SataJWu-Z-1593471860362-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1-2_SataJWu-Z-1593471860362-thumbnail.jpg	2	2	f	266607	1180	1180	1.00
776	conjunto1_nZShXg0wId-1593471861174-original-.jpg	conjunto1_nZShXg0wId.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1_nZShXg0wId-1593471861174-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1_nZShXg0wId-1593471861174-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1_nZShXg0wId-1593471861174-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1_nZShXg0wId-1593471861174-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1_nZShXg0wId-1593471861174-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1_nZShXg0wId-1593471861174-thumbnail.jpg	2	2	f	177329	1180	1180	1.00
779	conjunto3_VUsZnCXQHT-1593471861957-original-.jpg	conjunto3_VUsZnCXQHT.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3_VUsZnCXQHT-1593471861957-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3_VUsZnCXQHT-1593471861957-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3_VUsZnCXQHT-1593471861957-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3_VUsZnCXQHT-1593471861957-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3_VUsZnCXQHT-1593471861957-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3_VUsZnCXQHT-1593471861957-thumbnail.jpg	2	2	f	165134	1180	1180	1.00
780	conjunto2_aJl1XDEU-n-1593471863157-original-.jpg	conjunto2_aJl1XDEU-n.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto2_aJl1XDEU-n-1593471863157-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto2_aJl1XDEU-n-1593471863157-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto2_aJl1XDEU-n-1593471863157-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto2_aJl1XDEU-n-1593471863157-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto2_aJl1XDEU-n-1593471863157-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto2_aJl1XDEU-n-1593471863157-thumbnail.jpg	2	3	f	143489	1180	1180	1.00
781	conjunto3-3_fAEdov6pvS-1593471863573-original-.jpg	conjunto3-3_fAEdov6pvS.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3-3_fAEdov6pvS-1593471863573-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3-3_fAEdov6pvS-1593471863573-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3-3_fAEdov6pvS-1593471863573-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3-3_fAEdov6pvS-1593471863573-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3-3_fAEdov6pvS-1593471863573-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto3-3_fAEdov6pvS-1593471863573-thumbnail.jpg	2	2	f	246323	1180	1180	1.00
782	conjunto2-2_8QgbGHi34-1593471863960-original-.jpg	conjunto2-2_8QgbGHi34.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto2-2_8QgbGHi34-1593471863960-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto2-2_8QgbGHi34-1593471863960-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto2-2_8QgbGHi34-1593471863960-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto2-2_8QgbGHi34-1593471863960-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto2-2_8QgbGHi34-1593471863960-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto2-2_8QgbGHi34-1593471863960-thumbnail.jpg	2	3	f	301426	1180	1180	1.00
783	Screen_Shot_2020-05-07_at_11.02.46_9CdX8mi_V-1593471856374-original-.png	Screen_Shot_2020-05-07_at_11.02.46_9CdX8mi_V.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_11.02.46_9CdX8mi_V-1593471856374-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_11.02.46_9CdX8mi_V-1593471856374-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_11.02.46_9CdX8mi_V-1593471856374-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_11.02.46_9CdX8mi_V-1593471856374-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_11.02.46_9CdX8mi_V-1593471856374-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_11.02.46_9CdX8mi_V-1593471856374-thumbnail.png	1	0	f	313989	3434	1786	1.92
784	museu-virtual-casa-azul-frida-kahlo-3_2AL-jBKI--1593471864766-original-.png	museu-virtual-casa-azul-frida-kahlo-3_2AL-jBKI-.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo-3_2AL-jBKI--1593471864766-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo-3_2AL-jBKI--1593471864766-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo-3_2AL-jBKI--1593471864766-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo-3_2AL-jBKI--1593471864766-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo-3_2AL-jBKI--1593471864766-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo-3_2AL-jBKI--1593471864766-thumbnail.png	1	0	f	188773	1430	816	1.75
785	conjunto1-2_nFWRu0TKd-1593471864363-original-.jpg	conjunto1-2_nFWRu0TKd.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1-2_nFWRu0TKd-1593471864363-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1-2_nFWRu0TKd-1593471864363-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1-2_nFWRu0TKd-1593471864363-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1-2_nFWRu0TKd-1593471864363-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1-2_nFWRu0TKd-1593471864363-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto1-2_nFWRu0TKd-1593471864363-thumbnail.jpg	2	2	f	266607	1180	1180	1.00
786	conjunto01_rDfavC3-h-1593471854415-original-.jpg	conjunto01_rDfavC3-h.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto01_rDfavC3-h-1593471854415-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto01_rDfavC3-h-1593471854415-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto01_rDfavC3-h-1593471854415-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto01_rDfavC3-h-1593471854415-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto01_rDfavC3-h-1593471854415-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/conjunto01_rDfavC3-h-1593471854415-thumbnail.jpg	2	3	f	1609377	3024	4032	0.75
787	museu-virtual-casa-azul-frida-kahlo_Na-c2oSoG-1593471865166-original-.png	museu-virtual-casa-azul-frida-kahlo_Na-c2oSoG.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo_Na-c2oSoG-1593471865166-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo_Na-c2oSoG-1593471865166-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo_Na-c2oSoG-1593471865166-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo_Na-c2oSoG-1593471865166-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo_Na-c2oSoG-1593471865166-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo_Na-c2oSoG-1593471865166-thumbnail.png	1	0	f	285177	1430	804	1.78
788	P05924-3_4G2pq1Jw--1593471865990-original-.png	P05924-3_4G2pq1Jw-.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05924-3_4G2pq1Jw--1593471865990-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05924-3_4G2pq1Jw--1593471865990-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05924-3_4G2pq1Jw--1593471865990-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05924-3_4G2pq1Jw--1593471865990-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05924-3_4G2pq1Jw--1593471865990-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05924-3_4G2pq1Jw--1593471865990-thumbnail.png	2	1	f	93879	945	945	1.00
789	museu-virtual-casa-azul-frida-kahlo-banner_oyuRPqhLw-1593471865563-original-.png	museu-virtual-casa-azul-frida-kahlo-banner_oyuRPqhLw.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo-banner_oyuRPqhLw-1593471865563-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo-banner_oyuRPqhLw-1593471865563-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo-banner_oyuRPqhLw-1593471865563-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo-banner_oyuRPqhLw-1593471865563-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo-banner_oyuRPqhLw-1593471865563-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/museu-virtual-casa-azul-frida-kahlo-banner_oyuRPqhLw-1593471865563-thumbnail.png	1	0	f	230459	1280	628	2.04
790	Screen_Shot_2020-05-07_at_11.02.49_LkIJgItCl-1593471856777-original-.png	Screen_Shot_2020-05-07_at_11.02.49_LkIJgItCl.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_11.02.49_LkIJgItCl-1593471856777-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_11.02.49_LkIJgItCl-1593471856777-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_11.02.49_LkIJgItCl-1593471856777-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_11.02.49_LkIJgItCl-1593471856777-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_11.02.49_LkIJgItCl-1593471856777-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_11.02.49_LkIJgItCl-1593471856777-thumbnail.png	1	0	f	314953	3434	1786	1.92
791	G05924-3_8SOAiGmtB-1593471866376-original-.png	G05924-3_8SOAiGmtB.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05924-3_8SOAiGmtB-1593471866376-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05924-3_8SOAiGmtB-1593471866376-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05924-3_8SOAiGmtB-1593471866376-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05924-3_8SOAiGmtB-1593471866376-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05924-3_8SOAiGmtB-1593471866376-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/G05924-3_8SOAiGmtB-1593471866376-thumbnail.png	2	1	f	81539	1080	1080	1.00
792	Screen_Shot_2020-05-07_at_15.30.32_4RMeloigF-1593471856034-original-.png	Screen_Shot_2020-05-07_at_15.30.32_4RMeloigF.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_15.30.32_4RMeloigF-1593471856034-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_15.30.32_4RMeloigF-1593471856034-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_15.30.32_4RMeloigF-1593471856034-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_15.30.32_4RMeloigF-1593471856034-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_15.30.32_4RMeloigF-1593471856034-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_15.30.32_4RMeloigF-1593471856034-thumbnail.png	1	0	f	944747	3104	1978	1.57
793	Screen_Shot_2020-05-07_at_15.30.32_K4moRpX8W-1593471857281-original-.png	Screen_Shot_2020-05-07_at_15.30.32_K4moRpX8W.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_15.30.32_K4moRpX8W-1593471857281-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_15.30.32_K4moRpX8W-1593471857281-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_15.30.32_K4moRpX8W-1593471857281-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_15.30.32_K4moRpX8W-1593471857281-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_15.30.32_K4moRpX8W-1593471857281-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/Screen_Shot_2020-05-07_at_15.30.32_K4moRpX8W-1593471857281-thumbnail.png	1	0	f	944747	3104	1978	1.57
405	3084701_XWsuz9Ya8-1593471710770-original-.png	3084701_XWsuz9Ya8.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/3084701_XWsuz9Ya8-1593471710770-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/3084701_XWsuz9Ya8-1593471710770-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/3084701_XWsuz9Ya8-1593471710770-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/3084701_XWsuz9Ya8-1593471710770-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/3084701_XWsuz9Ya8-1593471710770-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/3084701_XWsuz9Ya8-1593471710770-thumbnail.png	2	0	t	67112	1080	1080	1.00
424	IMG_7605_DKUxwV80G-1593471718757-original-.jpg	IMG_7605_DKUxwV80G.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7605_DKUxwV80G-1593471718757-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7605_DKUxwV80G-1593471718757-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7605_DKUxwV80G-1593471718757-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7605_DKUxwV80G-1593471718757-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7605_DKUxwV80G-1593471718757-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7605_DKUxwV80G-1593471718757-thumbnail.jpg	3	1	t	75798	720	1080	0.67
416	IMG_7655_tOB8x9Jd2-1593471715153-original-.jpg	IMG_7655_tOB8x9Jd2.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7655_tOB8x9Jd2-1593471715153-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7655_tOB8x9Jd2-1593471715153-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7655_tOB8x9Jd2-1593471715153-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7655_tOB8x9Jd2-1593471715153-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7655_tOB8x9Jd2-1593471715153-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7655_tOB8x9Jd2-1593471715153-thumbnail.jpg	2	0	t	31290	1080	720	1.50
430	IMG_7429_yLWop8hD--1593471720361-original-.jpg	IMG_7429_yLWop8hD-.jpg	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7429_yLWop8hD--1593471720361-original.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7429_yLWop8hD--1593471720361-extra-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7429_yLWop8hD--1593471720361-large.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7429_yLWop8hD--1593471720361-medium.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7429_yLWop8hD--1593471720361-small.jpg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/IMG_7429_yLWop8hD--1593471720361-thumbnail.jpg	3	3	t	84310	1080	720	1.50
264	P05907-3_S1Ox-hGyyP-1593471655555-original-.png	P05907-3_S1Ox-hGyyP.png	image/jpeg	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05907-3_S1Ox-hGyyP-1593471655555-original.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05907-3_S1Ox-hGyyP-1593471655555-extra-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05907-3_S1Ox-hGyyP-1593471655555-large.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05907-3_S1Ox-hGyyP-1593471655555-medium.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05907-3_S1Ox-hGyyP-1593471655555-small.png	https://s3.sa-east-1.amazonaws.com/arquivos-dev.fridakahlo.com.br/P05907-3_S1Ox-hGyyP-1593471655555-thumbnail.png	3	2	f	102116	945	945	1.00
\.


--
-- Data for Name: image_tag; Type: TABLE DATA; Schema: public; Owner: digituz-dashboard
--

COPY public.image_tag (image_id, tag_id) FROM stdin;
255	169
256	184
257	170
258	183
259	155
260	188
261	197
262	227
266	223
267	226
268	215
269	225
270	217
271	224
272	220
273	218
274	164
275	214
277	211
279	210
280	195
281	162
282	209
283	207
284	213
285	216
286	157
287	206
288	212
289	168
290	153
291	208
292	203
293	199
294	201
295	154
296	204
297	193
298	182
299	202
300	198
301	163
302	147
303	147
304	147
305	108
306	113
307	108
308	113
309	113
310	114
311	114
312	114
313	122
314	122
315	114
316	116
317	122
318	116
319	116
320	116
321	124
322	117
323	118
324	119
325	119
326	119
327	116
328	117
329	119
330	121
331	121
332	120
333	129
334	119
335	134
336	126
337	125
338	152
339	152
340	139
341	119
342	139
343	126
344	120
345	152
346	139
347	141
348	123
349	139
350	141
351	141
352	138
353	142
354	138
355	140
356	141
357	142
358	145
359	145
360	143
361	140
362	146
363	143
364	144
365	146
366	144
367	140
368	151
369	151
370	148
371	151
372	148
373	148
374	150
375	150
376	150
377	130
378	130
379	130
380	130
381	130
382	150
383	127
384	132
385	132
386	148
387	127
388	132
389	137
390	135
391	133
392	136
393	135
394	136
395	131
396	133
397	131
398	137
399	128
400	128
401	222
403	221
414	221
415	183
415	188
415	170
417	149
418	183
418	188
421	183
421	188
421	170
422	158
423	158
424	188
425	226
426	188
428	194
429	208
429	207
429	154
429	223
429	162
430	209
430	197
430	178
431	196
432	187
433	205
434	209
434	192
434	204
434	224
434	216
434	226
434	191
434	193
436	167
437	160
438	167
439	171
440	160
441	171
443	209
443	192
443	204
443	224
443	216
443	226
443	191
443	193
444	177
445	177
446	177
447	173
448	173
449	174
450	174
451	176
452	209
452	192
452	204
452	224
452	216
452	226
452	191
452	193
453	181
454	176
455	181
457	173
456	176
458	181
459	174
460	167
461	209
461	192
461	204
461	224
461	216
461	226
461	191
461	193
462	171
463	209
463	192
463	204
463	224
463	216
463	226
463	199
463	191
463	212
463	193
465	218
465	206
465	197
465	186
466	218
466	206
466	197
466	186
467	160
468	184
468	188
468	201
468	192
468	157
468	149
468	160
469	155
469	188
469	207
469	168
469	194
469	169
469	193
477	184
477	155
477	183
477	188
479	194
479	169
480	184
480	188
480	194
480	193
481	188
481	194
481	193
482	184
482	155
482	183
482	188
483	221
484	194
484	169
470	201
470	192
470	149
470	160
471	201
471	192
471	157
471	149
471	160
472	210
472	216
472	191
472	194
472	169
473	155
473	183
473	188
475	216
475	194
475	193
476	184
476	155
476	183
476	188
485	155
485	188
486	184
486	155
486	183
486	188
487	155
487	188
487	224
488	209
488	204
488	224
488	194
489	184
489	155
489	183
489	207
489	194
489	193
490	210
490	209
490	192
490	204
490	224
490	216
490	226
490	199
490	191
490	212
490	193
491	215
491	206
492	215
492	206
493	225
493	208
493	207
493	199
493	154
493	212
493	223
494	208
494	224
494	199
494	194
494	154
494	223
494	193
495	209
495	218
495	204
495	216
495	199
495	191
495	212
495	193
496	225
496	168
496	216
496	154
496	223
496	193
497	210
497	209
497	207
497	216
497	191
497	194
497	193
498	207
498	216
498	191
498	194
498	193
499	210
499	209
499	192
499	204
499	224
499	216
499	199
499	191
499	212
500	222
501	188
501	222
502	184
502	155
502	183
502	188
502	192
503	155
503	183
503	188
503	207
503	180
504	192
504	207
504	180
504	186
505	192
505	207
505	197
505	186
506	210
506	207
506	216
506	191
506	194
506	193
507	184
507	188
507	149
509	161
512	166
513	183
513	188
513	207
513	216
513	194
513	193
519	194
520	210
520	209
520	207
520	216
521	184
521	155
521	183
521	188
521	193
522	207
522	197
523	222
524	184
524	188
524	149
525	184
525	155
525	183
525	188
525	193
526	184
526	155
526	183
526	188
527	184
527	155
527	183
527	188
529	155
529	188
529	168
529	194
531	183
531	188
531	207
531	216
531	194
531	193
536	166
537	159
540	158
549	161
550	158
553	175
560	161
561	201
561	157
561	149
561	180
561	186
562	155
562	188
562	194
562	193
563	184
563	155
563	183
563	188
563	192
563	207
563	222
564	166
565	207
565	222
566	155
566	188
567	207
567	222
568	192
568	207
568	222
569	184
569	155
569	183
569	188
569	192
569	207
570	178
571	186
572	191
572	180
573	201
573	180
574	213
574	180
576	226
577	162
577	180
584	106
578	201
578	192
578	157
578	197
578	178
579	209
579	180
580	186
581	110
583	109
585	110
588	107
590	103
594	101
598	109
600	106
601	100
601	102
603	99
603	105
604	103
605	104
606	104
607	101
609	95
610	94
611	96
611	93
612	98
613	107
615	97
617	89
618	72
619	89
620	92
622	90
623	81
624	91
625	73
626	76
627	90
628	75
629	77
630	91
631	67
632	62
633	87
634	65
635	74
636	66
637	64
638	68
639	69
640	70
641	79
642	80
643	78
644	85
645	83
646	71
647	84
648	63
649	61
650	82
651	60
652	57
653	58
654	56
655	53
657	59
658	54
659	49
663	51
664	52
665	52
666	51
667	89
668	44
669	69
670	47
671	68
672	66
673	64
674	172
675	47
676	46
677	45
678	38
679	38
680	38
681	38
682	38
683	42
684	38
685	39
686	42
687	42
688	42
689	42
690	42
691	40
692	40
693	40
694	39
695	40
696	42
697	40
698	59
700	52
701	47
703	42
704	51
705	56
706	43
707	41
708	41
709	43
710	130
711	141
712	150
713	141
714	141
715	62
716	150
717	116
718	138
719	116
720	36
721	72
722	35
723	72
724	85
725	70
726	65
727	74
728	84
729	36
730	37
731	37
732	113
733	35
734	75
735	77
736	69
737	36
738	184
739	76
740	35
741	69
742	75
743	76
745	209
746	209
747	157
747	193
748	157
749	130
750	157
751	226
752	225
753	225
754	157
755	188
756	188
757	226
758	183
759	188
760	183
761	34
762	34
763	214
763	163
763	206
765	71
766	164
766	223
767	213
767	195
769	72
771	194
772	34
773	210
773	92
774	216
774	193
775	191
775	193
776	216
776	193
777	191
777	221
777	197
778	191
778	221
778	197
779	210
779	92
780	191
780	221
780	197
781	210
781	92
782	191
782	221
782	197
785	216
785	193
786	204
786	212
786	211
788	9
791	9
263	15
263	7
265	15
265	7
264	15
264	7
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: digituz-dashboard
--

COPY public.inventory (id, current_position, version, product_variation_id) FROM stdin;
2149	6	5	503
2026	23	24	389
2037	2	18	397
2072	14	6	432
2115	8	6	104
1926	3	8	72
1946	6	6	92
1954	3	5	317
1931	3	5	77
2151	8	5	505
2148	8	5	502
1956	1	5	319
1961	0	4	324
1966	0	4	329
2114	0	4	103
2152	12	5	506
2045	2	5	405
2083	1	5	443
2097	10	5	457
2154	2	5	508
1960	4	5	323
1964	2	5	327
1980	3	5	343
2065	2	5	425
2066	13	5	426
2079	8	5	439
2121	1	5	475
2094	31	5	454
2095	13	5	455
2096	14	5	456
2135	8	5	489
2141	5	5	495
2129	12	5	483
2111	5	5	471
2030	15	5	393
2142	8	5	496
2080	9	5	440
2009	8	5	372
2112	18	5	472
2081	20	5	441
1995	15	5	358
2082	15	5	442
2143	10	5	497
2119	4	5	473
2084	1	5	444
2131	2	5	485
1996	2	5	359
1924	1	5	70
1943	5	5	89
2086	1	5	446
1934	4	5	80
2071	14	5	431
2070	10	5	430
2087	12	5	447
2098	13	5	458
2036	6	5	396
1998	5	5	361
2132	9	5	486
2145	2	5	499
2099	14	5	459
2124	4	5	478
1999	2	5	362
2055	3	5	415
2038	9	5	398
2088	7	5	448
2100	14	5	460
2000	2	5	363
2133	10	5	487
2146	9	5	500
2089	10	5	449
2125	1	5	479
2147	3	5	501
2056	4	5	416
2126	10	5	480
2040	6	5	400
2134	4	5	488
2101	1	5	461
2090	6	5	450
2074	10	5	434
2021	3	5	384
2041	10	5	401
2012	8	5	375
2057	6	5	417
2127	10	5	481
2136	11	5	490
2091	7	5	451
1925	1	5	71
1945	9	5	91
1944	7	5	90
2075	3	5	435
1948	3	5	94
1928	5	5	74
2092	5	5	452
2013	1	5	376
2058	6	5	418
2137	20	5	491
1935	5	5	81
1947	10	5	93
2043	2	5	403
2014	27	5	377
2023	3	5	386
1919	5	5	65
1950	19	5	96
1930	5	5	76
1937	5	5	83
2104	1	5	464
2025	1	5	388
2044	7	5	404
2105	2	5	465
2046	2	5	406
2157	2	5	511
2093	4	5	453
2016	5	5	379
2106	5	5	466
2015	41	5	378
2128	1	5	482
2005	31	5	368
2047	24	5	407
2019	29	5	382
2017	1	5	380
2061	13	5	421
2160	1	5	514
2020	3	5	383
2139	3	5	493
1992	37	5	355
2140	4	5	494
2156	2	5	510
2155	4	5	509
2158	34	5	512
2085	2	5	445
2120	2	5	474
1997	1	5	360
1927	4	9	73
1923	3	9	69
2067	0	6	427
1952	10	12	98
1929	6	12	75
1958	3	5	321
1955	2	5	318
1957	3	5	320
1959	2	5	322
1967	7	14	330
1976	37	6	339
1968	9	5	331
1969	10	5	332
1971	8	5	334
1972	8	5	335
1973	3	5	336
1977	26	5	340
1978	5	5	341
1981	3	5	344
1984	9	5	347
1983	10	5	346
1987	1	5	350
1985	8	5	348
1988	3	5	351
1993	2	5	356
2027	1	5	390
1994	13	5	357
2008	3	5	371
2109	16	5	469
2122	10	5	476
2110	1	2	470
2031	2	2	394
1891	0	1	37
1892	0	1	38
1893	0	1	39
1894	0	1	40
1895	0	1	41
1896	0	1	42
1897	0	1	43
1898	0	1	44
1899	0	1	45
1900	0	1	46
1901	0	1	47
1902	0	1	48
1903	0	1	49
1904	0	1	50
1906	0	1	52
1907	0	1	53
1908	0	1	54
1909	0	1	55
1910	0	1	56
1911	0	1	57
1912	0	1	58
2010	0	1	373
2011	0	1	374
2018	0	1	381
2022	0	1	385
2024	0	1	387
2028	0	1	391
2029	0	1	392
2033	0	1	100
2034	0	1	101
2035	0	1	395
2039	0	1	399
2076	0	1	436
2077	0	1	437
2078	0	1	438
2103	0	1	463
2107	0	1	467
2108	0	1	468
2113	0	1	102
2116	0	1	105
2117	0	1	106
2118	0	1	107
2123	0	1	477
2130	0	1	484
2138	0	1	492
2144	0	1	498
2159	0	1	513
2102	0	1	462
2153	5	5	507
2150	10	5	504
1913	0	1	59
1914	0	1	60
1915	0	1	61
1916	0	1	62
1917	0	1	63
1918	0	1	64
1920	0	1	66
2032	8	5	99
1965	8	5	328
1982	3	5	345
1963	0	4	326
1882	0	2	28
1861	0	1	7
1867	0	1	13
1868	0	1	14
1870	0	1	16
1876	0	1	22
1881	0	1	27
1884	0	1	30
1885	0	1	31
1886	0	1	32
1887	0	1	33
1888	0	1	34
1889	0	1	35
1890	0	1	36
1857	14	5	3
1858	13	5	4
1856	2	5	2
1860	3	5	6
1859	2	5	5
1862	35	5	8
1874	2	5	20
1864	1	5	10
1866	1	5	12
1869	1	5	15
1872	1	5	18
1871	1	5	17
1873	19	5	19
1875	2	5	21
1877	4	5	23
1879	3	5	25
1880	2	5	26
1878	1	5	24
1905	2	5	51
1939	3	5	85
1865	1	2	11
1855	0	1	1
1883	10	18	29
1863	0	1	9
1921	0	1	67
1922	0	1	68
2006	0	1	369
1932	0	1	78
1936	0	1	82
1941	0	1	87
1942	0	1	88
1949	0	1	95
1953	0	1	316
1970	0	1	333
1974	0	1	337
1975	0	1	338
1979	0	1	342
1986	0	1	349
1989	0	1	352
1990	0	1	353
1991	0	1	354
2001	0	1	364
2002	0	1	365
2003	0	1	366
2007	0	1	370
1933	1	2	79
2004	1	2	367
2042	-2	2	402
2048	0	1	408
2049	0	1	409
2050	0	1	410
2051	0	1	411
2052	0	1	412
2053	0	1	413
2054	0	1	414
2059	0	1	419
2060	0	1	420
2062	0	1	422
2063	0	1	423
2064	0	1	424
2069	0	1	429
2073	0	1	433
2068	1	2	428
2162	0	1	112
2163	0	1	113
2164	0	1	516
1962	0	4	325
1938	2	5	84
2161	8	5	515
\.


--
-- Data for Name: inventory_movement; Type: TABLE DATA; Schema: public; Owner: digituz-dashboard
--

COPY public.inventory_movement (id, inventory_id, amount, description, version, sale_order_id) FROM stdin;
853	2149	6	Informação originária do Bling.	1	\N
856	1857	14	Informação originária do Bling.	1	\N
867	1859	2	Informação originária do Bling.	1	\N
877	1957	3	Informação originária do Bling.	1	\N
885	1965	8	Informação originária do Bling.	1	\N
895	1978	5	Informação originária do Bling.	1	\N
905	1991	0	Informação originária do Bling.	1	\N
916	1868	0	Informação originária do Bling.	1	\N
925	2079	8	Informação originária do Bling.	1	\N
936	2096	14	Informação originária do Bling.	1	\N
950	2053	0	Informação originária do Bling.	1	\N
959	2143	10	Informação originária do Bling.	1	\N
967	1875	2	Informação originária do Bling.	1	\N
977	2132	9	Informação originária do Bling.	1	\N
987	2100	14	Informação originária do Bling.	1	\N
995	2147	3	Informação originária do Bling.	1	\N
1004	2090	6	Informação originária do Bling.	1	\N
1013	2136	11	Informação originária do Bling.	1	\N
1023	1877	4	Informação originária do Bling.	1	\N
1033	1928	5	Informação originária do Bling.	1	\N
1042	1888	0	Informação originária do Bling.	1	\N
1051	2014	27	Informação originária do Bling.	1	\N
1061	1897	0	Informação originária do Bling.	1	\N
1072	1914	0	Informação originária do Bling.	1	\N
1082	2033	0	Informação originária do Bling.	1	\N
1090	1929	7	Informação originária do Bling.	1	\N
1101	2025	1	Informação originária do Bling.	1	\N
1110	2159	0	Informação originária do Bling.	1	\N
1120	2017	1	Informação originária do Bling.	1	\N
1128	2156	2	Informação originária do Bling.	1	\N
1137	2022	0	Informação originária do Bling.	1	\N
1149	2063	0	Informação originária do Bling.	1	\N
1174	2037	-1	17	1	17
1185	2037	-1	21	1	21
1195	2037	-3	24	1	24
1198	1967	-3	41	1	41
1207	1976	-3	46	1	46
1218	2067	-1	49	1	49
854	1861	0	Informação originária do Bling.	1	\N
863	2032	8	Informação originária do Bling.	1	\N
873	2148	8	Informação originária do Bling.	1	\N
884	1964	2	Informação originária do Bling.	1	\N
893	1973	3	Informação originária do Bling.	1	\N
903	1983	10	Informação originária do Bling.	1	\N
913	2027	1	Informação originária do Bling.	1	\N
923	1866	1	Informação originária do Bling.	1	\N
933	2135	8	Informação originária do Bling.	1	\N
943	2010	0	Informação originária do Bling.	1	\N
954	1872	1	Informação originária do Bling.	1	\N
966	1943	5	Informação originária do Bling.	1	\N
978	1998	5	Informação originária do Bling.	1	\N
990	2000	2	Informação originária do Bling.	1	\N
1000	2134	4	Informação originária do Bling.	1	\N
1010	2057	6	Informação originária do Bling.	1	\N
1018	1945	9	Informação originária do Bling.	1	\N
1029	2059	0	Informação originária do Bling.	1	\N
1041	1910	0	Informação originária do Bling.	1	\N
1050	1899	0	Informação originária do Bling.	1	\N
1059	2023	3	Informação originária do Bling.	1	\N
1069	1885	0	Informação originária do Bling.	1	\N
1080	2034	0	Informação originária do Bling.	1	\N
1092	2118	0	Informação originária do Bling.	1	\N
1102	2104	1	Informação originária do Bling.	1	\N
1112	2016	5	Informação originária do Bling.	1	\N
1121	2160	1	Informação originária do Bling.	1	\N
1132	2155	4	Informação originária do Bling.	1	\N
1143	2076	0	Informação originária do Bling.	1	\N
1175	1883	-1	18	1	18
1186	2026	-1	21	1	21
1196	2072	-1	25	1	25
1208	1946	-2	47	1	47
1219	1929	-1	49	1	49
855	1932	0	Informação originária do Bling.	1	\N
865	2151	8	Informação originária do Bling.	1	\N
875	1963	0	Informação originária do Bling.	1	\N
887	1968	9	Informação originária do Bling.	1	\N
898	1976	40	Informação originária do Bling.	1	\N
908	1988	3	Informação originária do Bling.	1	\N
920	1864	1	Informação originária do Bling.	1	\N
927	2008	3	Informação originária do Bling.	1	\N
937	2141	5	Informação originária do Bling.	1	\N
946	2009	8	Informação originária do Bling.	1	\N
960	2131	2	Informação originária do Bling.	1	\N
970	1934	4	Informação originária do Bling.	1	\N
980	2124	4	Informação originária do Bling.	1	\N
988	2072	15	Informação originária do Bling.	1	\N
997	2040	6	Informação originária do Bling.	1	\N
1009	1876	0	Informação originária do Bling.	1	\N
1021	1881	0	Informação originária do Bling.	1	\N
1031	1883	19	Informação originária do Bling.	1	\N
1038	2058	6	Informação originária do Bling.	1	\N
1048	1912	0	Informação originária do Bling.	1	\N
1055	1894	0	Informação originária do Bling.	1	\N
1065	1906	0	Informação originária do Bling.	1	\N
1074	1936	0	Informação originária do Bling.	1	\N
1084	1941	0	Informação originária do Bling.	1	\N
1096	1938	2	Informação originária do Bling.	1	\N
1105	2105	2	Informação originária do Bling.	1	\N
1114	2015	41	Informação originária do Bling.	1	\N
1127	2161	8	Informação originária do Bling.	1	\N
1138	2085	2	Informação originária do Bling.	1	\N
1147	2138	0	Informação originária do Bling.	1	\N
1176	2037	-1	18	1	18
1187	1883	-1	22	1	22
1197	2115	-1	25	1	25
858	1858	13	Informação originária do Bling.	1	\N
864	1860	3	Informação originária do Bling.	1	\N
874	1962	0	Informação originária do Bling.	1	\N
883	1959	2	Informação originária do Bling.	1	\N
894	1977	26	Informação originária do Bling.	1	\N
904	1987	1	Informação originária do Bling.	1	\N
914	2108	0	Informação originária do Bling.	1	\N
926	2066	13	Informação originária do Bling.	1	\N
935	2122	10	Informação originária do Bling.	1	\N
945	2142	8	Informação originária do Bling.	1	\N
953	1923	3	Informação originária do Bling.	1	\N
963	2113	0	Informação originária do Bling.	1	\N
973	2087	12	Informação originária do Bling.	1	\N
983	2039	0	Informação originária do Bling.	1	\N
993	2089	10	Informação originária do Bling.	1	\N
1003	2074	10	Informação originária do Bling.	1	\N
1014	2115	9	Informação originária do Bling.	1	\N
1025	1879	3	Informação originária do Bling.	1	\N
1035	2013	1	Informação originária do Bling.	1	\N
1046	1947	10	Informação originária do Bling.	1	\N
1057	1902	0	Informação originária do Bling.	1	\N
1068	1915	0	Informação originária do Bling.	1	\N
1078	1917	0	Informação originária do Bling.	1	\N
1087	2002	0	Informação originária do Bling.	1	\N
1097	1937	5	Informação originária do Bling.	1	\N
1108	2018	0	Informação originária do Bling.	1	\N
1118	2047	24	Informação originária do Bling.	1	\N
1129	2054	0	Informação originária do Bling.	1	\N
1139	2103	0	Informação originária do Bling.	1	\N
1151	2050	0	Informação originária do Bling.	1	\N
1177	2026	-1	18	1	18
1188	2037	-1	22	1	22
857	1954	3	Informação originária do Bling.	1	\N
868	1953	0	Informação originária do Bling.	1	\N
878	1966	0	Informação originária do Bling.	1	\N
890	1967	14	Informação originária do Bling.	1	\N
899	1984	9	Informação originária do Bling.	1	\N
911	2052	0	Informação originária do Bling.	1	\N
921	2029	0	Informação originária do Bling.	1	\N
928	2095	13	Informação originária do Bling.	1	\N
938	2110	1	Informação originária do Bling.	1	\N
949	2112	18	Informação originária do Bling.	1	\N
955	2011	0	Informação originária do Bling.	1	\N
964	1873	19	Informação originária do Bling.	1	\N
975	2036	6	Informação originária do Bling.	1	\N
985	2073	0	Informação originária do Bling.	1	\N
999	2164	0	Informação originária do Bling.	1	\N
1008	2012	8	Informação originária do Bling.	1	\N
1019	1926	4	Informação originária do Bling.	1	\N
1027	1880	2	Informação originária do Bling.	1	\N
1037	1909	0	Informação originária do Bling.	1	\N
1047	2043	2	Informação originária do Bling.	1	\N
1058	1892	0	Informação originária do Bling.	1	\N
1066	1886	0	Informação originária do Bling.	1	\N
1077	1922	0	Informação originária do Bling.	1	\N
1085	1918	0	Informação originária do Bling.	1	\N
1094	1952	11	Informação originária do Bling.	1	\N
1103	2044	7	Informação originária do Bling.	1	\N
1113	1990	0	Informação originária do Bling.	1	\N
1123	2020	3	Informação originária do Bling.	1	\N
1133	2068	1	Informação originária do Bling.	1	\N
1141	2001	0	Informação originária do Bling.	1	\N
1148	1997	1	Informação originária do Bling.	1	\N
1178	1883	-1	19	1	19
1189	2026	-1	22	1	22
859	1856	2	Informação originária do Bling.	1	\N
866	1958	3	Informação originária do Bling.	1	\N
879	1862	35	Informação originária do Bling.	1	\N
886	1974	0	Informação originária do Bling.	1	\N
896	1874	2	Informação originária do Bling.	1	\N
907	2051	0	Informação originária do Bling.	1	\N
915	1867	0	Informação originária do Bling.	1	\N
924	2083	1	Informação originária do Bling.	1	\N
934	2130	0	Informação originária do Bling.	1	\N
944	2030	15	Informação originária do Bling.	1	\N
956	2119	4	Informação originária do Bling.	1	\N
965	2097	10	Informação originária do Bling.	1	\N
974	2098	13	Informação originária do Bling.	1	\N
984	2037	15	Informação originária do Bling.	1	\N
996	2146	9	Informação originária do Bling.	1	\N
1006	2021	3	Informação originária do Bling.	1	\N
1017	1944	7	Informação originária do Bling.	1	\N
1030	2075	3	Informação originária do Bling.	1	\N
1040	2137	20	Informação originária do Bling.	1	\N
1052	1889	0	Informação originária do Bling.	1	\N
1062	1893	0	Informação originária do Bling.	1	\N
1070	1887	0	Informação originária do Bling.	1	\N
1081	1905	2	Informação originária do Bling.	1	\N
1091	1950	19	Informação originária do Bling.	1	\N
1100	2060	0	Informação originária do Bling.	1	\N
1111	2106	5	Informação originária do Bling.	1	\N
1122	2061	13	Informação originária do Bling.	1	\N
1130	2069	0	Informação originária do Bling.	1	\N
1142	2144	0	Informação originária do Bling.	1	\N
1152	2004	1	Informação originária do Bling.	1	\N
1179	2037	-1	19	1	19
1180	2026	-1	19	1	19
1190	1883	-1	23	1	23
1203	1967	-2	42	1	42
860	1931	3	Informação originária do Bling.	1	\N
870	1955	2	Informação originária do Bling.	1	\N
876	1961	0	Informação originária do Bling.	1	\N
888	1971	8	Informação originária do Bling.	1	\N
901	1982	3	Informação originária do Bling.	1	\N
909	1989	0	Informação originária do Bling.	1	\N
918	2045	2	Informação originária do Bling.	1	\N
929	2121	1	Informação originária do Bling.	1	\N
940	2067	1	Informação originária do Bling.	1	\N
948	2081	20	Informação originária do Bling.	1	\N
958	1871	1	Informação originária do Bling.	1	\N
969	2086	1	Informação originária do Bling.	1	\N
979	2099	14	Informação originária do Bling.	1	\N
989	2088	7	Informação originária do Bling.	1	\N
998	2126	10	Informação originária do Bling.	1	\N
1007	2041	10	Informação originária do Bling.	1	\N
1016	1925	1	Informação originária do Bling.	1	\N
1026	1882	0	Informação originária do Bling.	1	\N
1036	2092	5	Informação originária do Bling.	1	\N
1045	1890	0	Informação originária do Bling.	1	\N
1056	1901	0	Informação originária do Bling.	1	\N
1067	1903	0	Informação originária do Bling.	1	\N
1076	1913	0	Informação originária do Bling.	1	\N
1089	1919	5	Informação originária do Bling.	1	\N
1098	1930	5	Informação originária do Bling.	1	\N
1107	2157	2	Informação originária do Bling.	1	\N
1119	2107	0	Informação originária do Bling.	1	\N
1131	2158	34	Informação originária do Bling.	1	\N
1140	2031	2	Informação originária do Bling.	1	\N
1150	2062	0	Informação originária do Bling.	1	\N
1170	2026	-1	16	1	16
1169	1883	-1	16	1	16
1181	1883	-1	20	1	20
1191	2026	-2	23	1	23
1204	1926	-1	42	1	42
861	2153	5	Informação originária do Bling.	1	\N
869	2152	12	Informação originária do Bling.	1	\N
880	1960	4	Informação originária do Bling.	1	\N
889	1972	8	Informação originária do Bling.	1	\N
897	1986	0	Informação originária do Bling.	1	\N
906	1985	8	Informação originária do Bling.	1	\N
917	2028	0	Informação originária do Bling.	1	\N
930	1994	13	Informação originária do Bling.	1	\N
939	2129	12	Informação originária do Bling.	1	\N
951	1995	15	Informação originária do Bling.	1	\N
961	1933	1	Informação originária do Bling.	1	\N
971	2071	14	Informação originária do Bling.	1	\N
981	1999	2	Informação originária do Bling.	1	\N
991	2133	10	Informação originária do Bling.	1	\N
1001	2101	1	Informação originária do Bling.	1	\N
1011	2127	10	Informação originária do Bling.	1	\N
1020	2064	0	Informação originária do Bling.	1	\N
1028	1878	1	Informação originária do Bling.	1	\N
1039	1907	0	Informação originária do Bling.	1	\N
1049	1891	0	Informação originária do Bling.	1	\N
1060	1895	0	Informação originária do Bling.	1	\N
1071	1916	0	Informação originária do Bling.	1	\N
1079	2116	0	Informação originária do Bling.	1	\N
1088	1942	0	Informação originária do Bling.	1	\N
1099	1939	3	Informação originária do Bling.	1	\N
1109	2093	4	Informação originária do Bling.	1	\N
1117	2019	29	Informação originária do Bling.	1	\N
1126	2140	4	Informação originária do Bling.	1	\N
1136	2035	0	Informação originária do Bling.	1	\N
1146	2024	0	Informação originária do Bling.	1	\N
1171	2037	-1	16	1	16
1182	2037	-1	20	1	20
1192	2037	-3	23	1	23
1205	1967	-2	44	1	44
862	2150	10	Informação originária do Bling.	1	\N
872	1956	1	Informação originária do Bling.	1	\N
882	1970	0	Informação originária do Bling.	1	\N
892	1979	0	Informação originária do Bling.	1	\N
902	1980	3	Informação originária do Bling.	1	\N
912	2007	0	Informação originária do Bling.	1	\N
922	1869	1	Informação originária do Bling.	1	\N
932	2109	16	Informação originária do Bling.	1	\N
942	2080	9	Informação originária do Bling.	1	\N
952	2082	15	Informação originária do Bling.	1	\N
962	1996	2	Informação originária do Bling.	1	\N
972	2070	10	Informação originária do Bling.	1	\N
982	2055	3	Informação originária do Bling.	1	\N
992	2125	1	Informação originária do Bling.	1	\N
1002	2114	0	Informação originária do Bling.	1	\N
1012	2091	7	Informação originária do Bling.	1	\N
1022	1946	8	Informação originária do Bling.	1	\N
1032	1948	3	Informação originária do Bling.	1	\N
1043	1911	0	Informação originária do Bling.	1	\N
1053	1898	0	Informação originária do Bling.	1	\N
1063	1896	0	Informação originária do Bling.	1	\N
1073	1921	0	Informação originária do Bling.	1	\N
1083	1949	0	Informação originária do Bling.	1	\N
1093	2003	0	Informação originária do Bling.	1	\N
1104	2026	34	Informação originária do Bling.	1	\N
1115	2128	1	Informação originária do Bling.	1	\N
1124	2139	3	Informação originária do Bling.	1	\N
1134	2123	0	Informação originária do Bling.	1	\N
1145	2120	2	Informação originária do Bling.	1	\N
1172	1883	-1	17	1	17
1183	2026	-1	20	1	20
1193	1883	-1	24	1	24
1206	2042	-2	45	1	45
871	2154	2	Informação originária do Bling.	1	\N
881	1975	0	Informação originária do Bling.	1	\N
891	1969	10	Informação originária do Bling.	1	\N
900	1981	3	Informação originária do Bling.	1	\N
910	1993	2	Informação originária do Bling.	1	\N
919	2065	2	Informação originária do Bling.	1	\N
931	2094	31	Informação originária do Bling.	1	\N
941	2111	5	Informação originária do Bling.	1	\N
947	1870	0	Informação originária do Bling.	1	\N
957	2084	1	Informação originária do Bling.	1	\N
968	1924	1	Informação originária do Bling.	1	\N
976	2145	2	Informação originária do Bling.	1	\N
986	2038	9	Informação originária do Bling.	1	\N
994	2056	4	Informação originária do Bling.	1	\N
1005	2042	0	Informação originária do Bling.	1	\N
1015	1927	4	Informação originária do Bling.	1	\N
1024	1884	0	Informação originária do Bling.	1	\N
1034	1908	0	Informação originária do Bling.	1	\N
1044	1935	5	Informação originária do Bling.	1	\N
1054	1900	0	Informação originária do Bling.	1	\N
1064	1904	0	Informação originária do Bling.	1	\N
1075	1920	0	Informação originária do Bling.	1	\N
1086	2117	0	Informação originária do Bling.	1	\N
1095	2078	0	Informação originária do Bling.	1	\N
1106	2046	2	Informação originária do Bling.	1	\N
1116	2005	31	Informação originária do Bling.	1	\N
1125	1992	37	Informação originária do Bling.	1	\N
1135	1865	1	Informação originária do Bling.	1	\N
1144	2077	0	Informação originária do Bling.	1	\N
1173	2026	-1	17	1	17
1184	1883	-1	21	1	21
1194	2026	-2	24	1	24
1217	1952	-1	49	1	49
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: digituz-dashboard
--

COPY public.product (id, sku, title, description, product_details, selling_price, height, width, length, weight, is_active, ncm, version, variations_size, images_size, without_variation, category) FROM stdin;
93	A07023-36	Anel Frida Kahlo Flor Verde Com Ródio		<p>Anel em Prata 925 com banho de ródio branco.</p>\n<p>Garantia perene quanto a composição.</p>\n<p>Outros tamanhos, no momento, sob encomenda. Através do email contato@fridakahlo.com.br.</p>	289.90	\N	\N	\N	\N	t	7113.11.00	6	1	1	f	ANEIS
94	A07023-3	Anel Frida Kahlo Flor Verde	\N	<p>Anel em Prata 925.</p>\n<p>Garantia perene quanto a composição.</p>	259.90	\N	\N	\N	0.000	t	7113.11.00	5	2	1	f	ANEIS
95	C00240	Corrente Grume Pequena	\N	<p>Corrente em Prata 925</p>	59.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	COLARES
11	P04062	Pingente Frida Kahlo Estrela	\N		99.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BERLOQUES
10	B05032-AR	Brinco FK Anzol Azul e Rosa	\N	<p>Brinco em prata 925 com Cristal colorido</p>	59.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BRINCOS
178	C00239	Gargantilha Veneziana	\N		44.90	\N	\N	\N	0.000	t	7113.11.00	2	3	0	f	COLARES
181	C00246	Gargantilha Elo Português Médio	\N	<p>Gargantilha em Prata 925 estilo elo português.</p>	59.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	COLARES
15	PU3793	Pulseira FK Trançada Couro Preta	\N	<p>Pulseira em couro trançado, com fecho em prata 925.</p>	149.90	\N	\N	\N	0.000	t		2	2	0	f	PULSEIRAS
19	C00267	Corrente Bolinhas	\N	<p>Corrente em Prata 925.</p>	59.90	\N	\N	\N	0.000	t	7113.11.00	2	2	0	f	COLARES
157	11006PL006	Camiseta Oficial Frida Kahlo	\N	<p>Camiseta mescla cinza.&nbsp;</p>\n<p>Comprimento P : 62cm</p>\n<p>Ombro a ombro P: 31cm</p>\n<p>Comprimento M: 64cm</p>\n<p>Ombro a ombro M: 33cm</p>\n<p>Comprimento G: 66cm</p>\n<p>Ombro a ombro G: 35cm</p>	79.90	0.020	0.100	0.160	0.000	t	6106.20.00	5	3	3	f	CAMISETAS
62	A07021	Anel Frida Kahlo Flor Preta	\N		329.90	\N	\N	\N	0.000	t	7113.11.00	5	2	1	f	ANEIS
54	G07516	Escapulário Dois Cristais - Coleção Cores	\N		189.90	\N	\N	\N	0.000	t	7113.11.00	5	3	1	f	COLARES
171	MR837	Camiseta Mágoas	\N	<p>SOBRE O PRODUTO</p>\n<p>As camisetas Chico Rei são produzidas artesanalmente com 100% de fibra natural de algodão, refinada e penteada.</p>\n<p>A estampa é pintada com tinta a base de água e com padrão de cores exclusiva. Tudo feito à mão.</p>\n<p>Atenção: o tom da malha pode apresentar pequenas variações entre os lotes.</p>	69.90	\N	\N	\N	0.000	t		5	2	1	f	CAMISETAS
9	P05924	Berloque Frida Kahlo Medalha Arara Preta	\N	<p>Berloque em prata 925 e banho de ródio branco. Pintado a mão.</p>\n<p>Pode ser usado como berloque ou como pingente.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
174	LA837	Camiseta La Artista		<p>SOBRE O PRODUTO</p>\n<p>As camisetas Chico Rei são produzidas artesanalmente com 100% de fibra natural de algodão, refinada e penteada.</p>\n<p>A estampa é pintada com tinta a base de água e com padrão de cores exclusiva. Tudo feito à mão.</p>\n<p>Atenção: o tom da malha pode apresentar pequenas variações entre os lotes.</p>	69.90	\N	\N	\N	0.000	f		6	5	3	f	CAMISETAS
169	RX919	Camiseta Miragem	\N	<p>SOBRE O PRODUTO</p>\n<p>As camisetas Chico Rei são produzidas artesanalmente com 100% de fibra natural de algodão, refinada e penteada.</p>\n<p>A estampa é pintada com tinta a base de água e com padrão de cores exclusiva. Tudo feito à mão.</p>\n<p>Atenção: o tom da malha pode apresentar pequenas variações entre os lotes.</p>	69.90	\N	\N	\N	0.000	t		5	3	3	f	CAMISETAS
34	MFK-5707	Máscara Frida Kahlo	\N	<p>A máscara Frida Kahlo faz parte de uma edição especial e exclusiva da Loja Oficial Frida Kahlo.</p>\n<p>Essa máscara é feita de tecido duplo e o seu material é de algodão.</p>	39.90	\N	\N	\N	0.000	t	6307.90.10	5	1	3	f	ACESSORIOS
37	40546	Mini Caneca Ceramica FK Face Amarelo	\N	<p>Mini Caneca em Cerâmica 140 ml</p>\n<p>Altura: 6,2x6,2x7,3 cm</p>	34.90	0.073	0.062	\N	0.500	t	6911.10.90	5	1	2	f	DECORACAO
38	4081	Estojo FK Floral Azul	\N	<p>Estojo com divisórias interna. Organizador de lápis.</p>\n<p>Tamanho: 12cmX21cmX7cm</p>	84.90	0.210	0.120	0.070	0.000	t	4202.39.00	5	1	6	f	ACESSORIOS
35	43413	Mini Caneca Porcelana FK Geometric Flowers	\N	<p>Mini Caneca em Porcelana - 220ml</p>\n<p>7,9x6,4x7,7 cm</p>	34.90	0.077	0.079	\N	0.500	t	6911.10.90	5	1	1	f	DECORACAO
25	43367	Copo Termico Plástico Red Birds and Flowers	\N	<p>Dimensões 8,5 x 15,5 cm</p>	49.90	0.155	0.085	\N	0.000	t	3924.10.00	2	1	0	f	DECORACAO
26	43331	Caneca com Alça Vidro Mágica	\N	<p>Surpeenda-se com essa Caneca Mágica.</p>\n<p>A imagem surge no momento em que a caneca é aquecida.</p>\n<p>Dimensões: 8 x 9,5 cm</p>	39.90	\N	8.950	\N	0.000	t	7013.37.00	2	1	0	f	DECORACAO
31	40624	Lixeira para Carro em Neoprene - Pixel	\N	<p>Material: Neoprene</p>\n<p>Dimensões:20 x 29 cm</p>	34.90	\N	\N	\N	0.000	t	6307.90.90	2	1	0	f	ACESSORIOS
27	43254	Necessaire Flowers Fundo Preto	\N	<p>Dimensões 23,5 x 6,5 x 17 cm</p>	54.90	0.235	0.170	0.065	0.000	t	4202.92.00	2	1	0	f	ACESSORIOS
20	B07683-C	Brinco Cristal Oval C	\N	<p>Brinco em prata 925 com Cristal colorido</p>	59.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BRINCOS
18	P04056	Pingente Frida Kahlo Olho de Tigre	\N		99.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BERLOQUES
33	40127	Lata Metal Skulls and Flowers	\N	<p>Lata decorativa em metal.</p>\n<p>Dimensões: 12,8 x 9,9 x 19,9 cm</p>	37.40	0.199	0.128	0.009	0.000	t	7323.99.00	2	1	0	f	DECORACAO
21	B07683-B	Brinco Cristal Oval B	\N	<p>Brinco em prata 925 com Cristal colorido</p>	59.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BRINCOS
17	P04057	Pingente Frida Kahlo Turquesa Howlita	\N		99.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BERLOQUES
13	P04061	Pingente Frida Kahlo Jade Rubi Facetada	\N		99.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BERLOQUES
24	43368	Copo Termico Plástico Red Flowers	\N	<p>Dimensões: 8,5 x 17,5 cm</p>	49.90	0.175	0.085	\N	0.000	t	3924.10.00	2	1	0	f	DECORACAO
32	40279	Tela Heavened Heart	\N	<p>Dimensões: 30 x 40 cm</p>	44.90	0.400	0.300	0.015	0.000	t	4911.91.00	2	1	0	f	DECORACAO
28	43253	Necessaire Red Birds and Flowers	\N	<p>Dimensões 23,5 x 6,5 x 17 cm</p>	54.90	0.065	0.235	0.170	0.000	t	4202.92.00	2	1	0	f	ACESSORIOS
30	43098	Suporte de Panela em Vidro	\N	<p>Para usar como suporte ou como quadrinho de cozinha.</p>\n<p>Dimensões: 18,3 x 16,5 cm</p>	34.90	0.165	0.183	\N	0.000	t	7013.49.00	2	1	0	f	DECORACAO
16	P06511	Pingente Frida Kahlo Coração Murano Amarelo Pequeno	\N		89.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BERLOQUES
29	43239	Cj 4 Copos de Shot	\N	<p>Conjunto com 4 copos de shot.</p>	44.90	0.059	0.050	0.035	0.000	t	7013.37.00	2	1	0	f	DECORACAO
22	B07683-A	Brinco Cristal Oval A	\N	<p>Brinco em prata 925 com Cristal colorido</p>	59.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BRINCOS
23	B06657-VV	Brinco FK Anzol Duas Pedras Vermelha e Verde	\N	<p>Brinco em prata 925.</p>	99.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BRINCOS
14	P04060	Pingente Frida Kahlo Malaquita Russa	\N		99.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BERLOQUES
36	43426	Mini Caneca Porcelana FK Head and Flowers	\N	<p>Mini Caneca em Porcelana 140ml</p>\n<p>6,7x6,7x7,3 cm</p>	34.90	0.073	0.067	\N	0.500	t	6911.10.90	5	1	2	f	DECORACAO
39	4059	Bolsa Necessaire FK Frutas Verde Alça Corda	\N	<p>Bolsinha prática. Pode ser usada como bolsa de mão, necessaire, estojo…</p>\n<p>Tamanho:37cmX19cmX5cm</p>	69.90	0.190	0.270	0.050	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
213	P05919	Berloque Frida Kahlo e Caveira	\N	<p>Berloque Rosto em Prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
47	B06657-ML	Brinco  FK Anzol Duas Pedras Azul e Rosa	\N	<p>Brinco em prata 925.</p>	99.90	\N	\N	\N	0.000	t	7113.11.00	6	1	1	f	BRINCOS
46	G07516-BE	Escapulário dois Cristais - Black e Esmeralda	\N	<p>Colar modelo Escapulário.</p>\n<p>60 com</p>\n<p>Duas pedras em Cristal</p>	189.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	COLARES
40	4066	Estojo FK Melancia Coral	\N	<p>Estojo com divisórias interna. Organizador de lápis.</p>\n<p>Tamanho: 12cmX21cmX7cm</p>	89.90	0.210	0.120	0.070	0.000	t	4202.39.00	5	1	4	f	ACESSORIOS
45	G07516-SA	Escapulário dois Cristais - Safira e Aqua Marine	\N	<p>Colar modelo Escapulário.</p>\n<p>60 com</p>\n<p>Duas pedras em Cristal</p>	189.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	COLARES
43	4051	Carteira FK Melancia Preta Alça Corda	\N	<p>Carteira com alça de cora regulável.</p>\n<p>25cm x 17cm</p>	69.90	0.170	0.250	\N	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
41	4065	Estojo FK  Melancia Preto	\N	<p>Estojo com divisórias interna. Organizador de lápis.</p>\n<p>Tamanho: 12cmX21cmX7cm</p>	89.90	0.210	0.120	0.070	0.000	t	4202.39.00	5	1	6	f	ACESSORIOS
49	B05032-AM	Brinco FK Anzol  Aqua Marine	\N	<p>Brinco em prata 925 com Cristal colorido</p>	59.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BRINCOS
42	4052	Carteira FK Melancia Coral Alça Corda	\N	<p>Carteira com alça de cora regulável.</p>\n<p>25cm x 17cm</p>	79.90	0.170	0.250	\N	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
44	43205	Moleskine Frida Kahlo Flowers	\N	<p>Caderneta de anotação capa dura.</p>\n<p>Tamanho: 9,5x14cms</p>\n<p>96 folhas</p>	39.90	\N	\N	\N	0.000	t	4820.10.00	5	1	1	f	ACESSORIOS
53	P06505	Pingente Frida Kahlo Coração Murano Vermelho Grande	\N		99.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
101	62450-77V	Moleskine Frida Kahlo Caveira Vermelha Pequena	\N	<p>Caderneta de anotações pequena.</p>\n<p>Papel especial 70g.</p>\n<p>Capa com recurso especial.</p>\n<p>Elástico.</p>\n<p>Miolo sem pauta.</p>\n<p>Formato 95mm x 140mm</p>	34.90	\N	\N	\N	0.000	t	4820.20.00	5	1	1	f	ACESSORIOS
106	KT0004	Conjunto Corações Completo	\N	<p>Conjunto composto por</p>\n<p>1 Bracelete Oval N00360</p>\n<p>2 Berloques Frida Kahlo Coração com Pincel P05907</p>\n<p>2 Berloque Passador Murano Coração P06501</p>\n<p>1 Gargantilha Elo Portuguê Média Tam 45 C0246-45</p>	589.90	\N	\N	\N	0.000	t		4	1	1	f	\N
119	4094	Bolsinha Necessaire FK Fridinha Rosa Bebê	\N	<p>Bolsinha prática. Pode ser usada como bolsa de mão, necessaire, estojo…</p>\n<p>Tamanho:37cmX19cmX5cm</p>	69.90	0.190	0.270	0.050	0.000	t	4202.39.00	5	1	1	f	ACESSORIOS
135	4057	Niqueleira FK Pitaya Preta	\N	<p>Niqueleira com aro para chaveiro.</p>\n<p>Tamanho: 12cmX7cm</p>	34.90	0.070	0.120	\N	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
113	B06365	Brinco Frida Kahlo Coração Partido	\N	<p>Brinco em prata 925 com banho de ródio branco.</p>	159.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BRINCOS
48	B06657-ES	Brinco FK Anzol Duas Pedras Esmeralda	\N	<p>Brinco em prata 925.</p>	99.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BRINCOS
192	3776791	Gargantilha Prata 70 cm	\N		69.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	COLARES
183	4048	Shopper Frida Kahlo Geometrica	\N	<p>Especificações:<br />\n- Bolsa Sacola Média Frida Kahlo;<br />\n- Material externo: policloreto de vinila e poliéster;<br />\n- Revestimento interno: 100% poliéster;<br />\n- Alças fixas;<br />\n- Bolso principal com fechamento em zíper;<br />\n- Bolso frontal pequeno com fechamento em zíper.</p>\n<p>- 28 x 33 x 4 cm</p>	119.90	0.330	0.280	0.040	0.000	t	6304.99.00	2	1	0	f	ACESSORIOS
188	CP15041	Corrente Casal de Passarinhos	\N	<p>Corrente em Prata 925 com formato de casal de passarinhos.</p>	54.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	COLARES
64	43281	Carteira Almoço  FK Red Birds and Flowers	\N	<p>Carteirinha de mão para passeio.</p>\n<p>Formato: 18 x 12 cms</p>	34.90	\N	\N	\N	0.000	t	4202.32.00	5	1	1	f	ACESSORIOS
198	P06472	Berloque Frida Kahlo Passador Murano Preto	\N	<p>Berloque separador Prata 925 feito de Vidro Murano Italiano lapidado à mão.</p>\n<p>Acabamento e polimento manual.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	99.90	\N	\N	\N	0.000	t		5	1	1	f	BERLOQUES
83	40623	Capa Almofada Poliester FK Face and Flowers	\N	<p>Capa para almofada.</p>\n<p>Sem enchimento.</p>\n<p>Tamanho 45 x 45 cm.</p>\n<p>Material: Poliester</p>	54.90	0.450	0.450	\N	0.000	t	6304.91.00	5	1	2	f	DECORACAO
205	P05933	Berloque Frida Kahlo Face Color	\N	<p>Berloque&nbsp; em Prata 925 com banho de ródio branco. Detalhes do retrato pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	0.010	0.010	0.010	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
224	P05908	Berloque Frida Kahlo Murano Flor	\N	<p>Berloque Passador em Prata 925 com banho de ródio branco. Detalhes da flor&nbsp;pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
228	LFK-00001	Máscara XYZ	\N	\N	\N	\N	\N	\N	\N	t	1234.56.78	1	0	0	t	\N
173	B05938	Brinco Frida Kahlo Cactus	\N	<p>Brinco em prata 925 com banho de Rodio Branco</p>	89.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BRINCOS
70	43269	Placa Madeira - Face and Red Roses	\N	<p>Placa decorativa em madeira.</p>\n<p>Formato: 26 x 30 cms</p>	59.90	0.300	0.260	\N	0.000	t	4420.10.00	5	1	1	f	DECORACAO
58	B05076	Brinco FK Gota Turmalina	\N	<p>Brinco em prata 925.</p>	167.90	0.320	0.140	\N	0.000	t	7113.11.00	5	1	1	f	BRINCOS
168	P05931	Berloque Frida Kahlo Melancia	\N	<p>Berloque passador em prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	89.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
159	4002	Carteira FK Pequena Viva la Vida	\N	<p>Carteira de mão ótima para aquela saidinha rápida.&nbsp;</p>\n<p>17 x 10 cm</p>	49.90	0.100	0.170	\N	0.000	t	4202.39.00	5	1	1	f	ACESSORIOS
214	P05916	Berloque Frida Kahlo Onde Não Puderes Amar	\N	<p>Berloque Medalha com gravação no verso "Onde não puderes amar"&nbsp; em Prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	129.90	\N	\N	\N	0.000	t	7113.11.00	5	1	3	f	BERLOQUES
146	4071	Carteira FK Grande Floral Preta	\N	<p>Carteira com alça em poliester.</p>\n<p>Tamanho: 20cmX12cm</p>	59.90	0.120	0.200	\N	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
84	40642	Set C/6 Pcs Porta Copos Cortiça FK Pixels	\N	<p>Conjunto com 6 porta copos.</p>\n<p>Material: cortiça</p>\n<p>Formato 10 x 10 cm</p>	34.90	0.100	0.100	\N	0.000	t	4503.90.00	5	1	1	f	DECORACAO
199	P05941	Berloque Frida Kahlo Face Flor Rosa	\N	<p>Berloque em Prata 925 com banho de ródio branco. Detalhes do rosto pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
161	4006	Carteira FK Grande Viva la Vida	\N	<p>Essa é estilo cloutch. Para qualquer ocasião.</p>\n<p>23 x 13 cm</p>	59.90	0.130	0.230	\N	0.000	t	4202.39.00	5	1	3	f	ACESSORIOS
112	PB6366	Bracelete Fino Frida Kahlo Rosas Vermelhas	\N	<p>Bracele em prata 925 com banho de ródio. Pulseira ajustável.</p>	329.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	PULSEIRAS
215	P05918	Berloque Frida Kahlo Baby Balloon	\N	<p>Berloque Medalha Baby em Prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
91	3320243	Brinco FK Argola Ondulada Grande	\N	<p>Argola ondulada em prata 925.</p>\n<p>Diâmetro 5cm</p>	79.90	0.050	0.050	\N	0.000	t	7113.11.00	5	1	2	f	BRINCOS
201	P05938	Berloque Frida Kahlo Cactus	\N	<p>Berloque em Prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	84.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
206	P05930	Berloque Frida Kahlo Medalha Flores Vermelhas	\N	<p>Berloque em Prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
207	P05928	Berloque Frida Kahlo Coração em Chamas	\N	<p>Berloque em Prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
148	4084	Chaveiro Ecobag Estampado - com bolsa pink	\N	<p>Chaveiro em poliseter, com ziper.</p>\n<p>Dentro do chaveiro vem uma ecobag amarela.</p>\n<p>Tamanho do Chaveiro: 8cmx10cm</p>	39.90	0.100	0.080	\N	0.000	t	6304.99.00	6	1	2	f	ACESSORIOS
124	4088	Niqueleira FK Fridinha Rosa Bebê	\N	<p>Niqueleira com aro para chaveiro.</p>\n<p>Tamanho: 12cmX7cm</p>	34.90	0.070	0.120	\N	0.000	t	4202.39.00	5	1	1	f	ACESSORIOS
138	4054	Carteira FK Grande Pitaya	\N	<p>Carteira com alça em poliester.</p>\n<p>Tamanho: 20cmX12cm</p>	59.90	0.120	0.200	\N	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
59	B04454-36	Brinco FK Contorno Gota Azul	\N	<p>Brinco em prata 925.</p>	99.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BRINCOS
196	P06501	Berloque Frida Kahlo Passador Murano Coração	\N	<p>Berloque separador Prata 925 feito de Vidro Murano Italiano lapidado à mão em&nbsp;formato de Coração&nbsp;Esmaltado.</p>\n<p>Acabamento e polimento manual.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	99.90	\N	\N	\N	0.000	t	7113.11.00	5	1	2	f	BERLOQUES
66	43336	Tela Blue Birds and Flowers Colorido	\N	<p>Tela em lona.</p>\n<p>30x1,5x40cm</p>	44.90	\N	\N	\N	0.000	t	4911.91.00	5	1	1	f	DECORACAO
145	4072	Carteira FK Grande Floral Azul	\N	<p>Carteira com alça em poliester.</p>\n<p>Tamanho: 20cmX12cm</p>	59.90	0.120	0.200	\N	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
85	40622	Capa Almofada Poliester FK Esperanza	\N	<p>Capa para almofada.</p>\n<p>Sem enchimento.</p>\n<p>Tamanho 45 x 45 cm.</p>\n<p>Material: Poliester</p>	54.90	0.450	0.450	\N	0.000	t	6304.91.00	5	1	1	f	DECORACAO
133	4058	Necessaire FK Frutas Verde Água	\N	<p>Necessaire em Poliester com zipper.</p>\n<p>Tamanho: 21cmX12cmX7cm</p>	59.90	0.120	0.210	0.070	0.000	t		5	1	3	f	ACESSORIOS
152	B06913	Brinco Frida Kahlo Cactus Anzol	\N	<p>Brinco em prata 925 com banho de Rodio Branco</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BRINCOS
193	P05900	Berloque Frida Kahlo Passador Flor Vermelha	\N	<p>Berloque passador em prata 925 com banho de ródio branco. Flor vermelha pintada a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BERLOQUES
50	B05032-VV	Brinco FK Anzol Vermelha e Verde	\N	<p>Brinco em prata 925 com Cristal colorido</p>	59.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BRINCOS
190	PP15904	Flor Madreperola	\N	<p>Pingente em madreperola.</p>\n<p>Tamanho: 1 x 1 cm</p>	22.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BERLOQUES
111	PB6367	Bracelete Largo Frida Kahlo Rosas Vermelhas	\N	<p>Bracele em prata 925 com banho de ródio. Pulseira ajustável.</p>	449.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	PULSEIRAS
52	B05032-BK	Brinco FK Anzol Black	\N	<p>Brinco em prata 925 com Cristal colorido</p>	59.90	\N	\N	\N	0.000	t	7113.11.00	5	1	2	f	BRINCOS
97	1894	Peso de Porta Cactus	\N	<p>Peso de Porta.</p>\n<p>Material poliester.</p>\n<p>Enchimento em areia.</p>\n<p>Formato 14 x 21 cms</p>	54.90	0.210	0.140	\N	0.000	t	6304.99.00	5	1	1	f	DECORACAO
127	4085	Carteira FK Grande Fridinha Preta	\N	<p>Carteira em poliester, com zipper.</p>\n<p>Tamanho: 23cmX13cm</p>	59.90	0.130	0.230	\N	0.000	t	4202.39.00	5	1	1	f	ACESSORIOS
117	4095	Bolsa Transversal FK Fridinha Preta	\N	<p>Bolsa em poliester com alça longa e ajustável.</p>\n<p>tamanho: 15cmX20cmX5cm</p>	79.90	0.200	0.150	0.050	0.000	t	4202.22.20	5	1	2	f	ACESSORIOS
179	4047	Bolsa Transversal FK Geometrica	\N	<p>Especificações:<br />\n- Bolsa Transversal Estampada Frida Kahlo;<br />\n- Material: poliéster;<br />\n- Forro plástico;<br />\n- Fechamento em zíper;<br />\n- Alça regulável.</p>\n<p>- Medidas: 17cmx12cm x14cm</p>	79.90	0.120	0.170	0.140	0.000	t	6304.99.00	5	1	1	f	ACESSORIOS
166	P05917	Berloque Frida Kahlo Risada	\N	<p>Berloque passador em prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
218	P05915	Berloque Frida Kahlo Coração Baby Rosa	\N	<p>Berloque em Prata 925 com banho de ródio branco. Detalhesno coração&nbsp; pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	3	f	BERLOQUES
140	4075	Necessaire FK Floral Azul	\N	<p>Necessaire em Poliester com zipper.</p>\n<p>Tamanho: 21cmX12cmX7cm</p>	59.90	0.120	0.210	0.070	0.000	t	4202.39.00	5	1	3	f	ACESSORIOS
125	4087	Niqueleira FK Fridinha Preta	\N	<p>Niqueleira com aro para chaveiro.</p>\n<p>Tamanho: 12cmX7cm</p>	34.90	0.070	0.120	\N	0.000	t	4202.39.00	5	1	1	f	ACESSORIOS
212	P05922	Berloque Frida Kahlo Apaixonada	\N	<p>Berloque em Prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	2	f	BERLOQUES
51	B05032-SF	Brinco FK Safira Anzol	\N	<p>Brinco em prata 925 com Cristal colorido</p>	59.90	\N	\N	\N	0.000	t	7113.11.00	5	1	2	f	BRINCOS
147	4104	Chaveiro Ecobag Fridinha - com bolsa preta	\N	<p>Chaveiro em poliseter, com ziper.</p>\n<p>Dentro do chaveiro vem uma ecobag amarela.</p>\n<p>Tamanho do Chaveiro: 8cmx10cm</p>	39.90	0.100	0.080	\N	0.000	t	6304.99.00	6	1	2	f	ACESSORIOS
154	P05935	Berloque Frida Kahlo Caveira Colorida			119.90	\N	\N	\N	0.000	f	7113.11.00	6	1	1	f	BERLOQUES
210	P05926	Berloque Frida Kahlo Boneca	\N	<p>Berloque Boneca em Prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	129.90	\N	\N	\N	0.000	t	7113.11.00	5	1	3	f	BERLOQUES
230	LFK-00003	Máscara XYZ	\N	\N	\N	\N	\N	\N	\N	t	1234.56.78	1	0	3	t	\N
231	LFK-00004	Máscara Cinza	\N	\N	\N	\N	\N	\N	\N	t	1234.56.79	2	0	0	t	\N
55	G06187	Gargantilha Olho Grego e pontos de Luz	\N		59.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BRINCOS
96	1899	Peso de Porta Cactus em Feltro	\N	<p>Peso de porta.</p>\n<p>Material Feltro.</p>\n<p>Enchimento areia.</p>\n<p>Formato 17 x 23 cms</p>	54.90	0.230	0.170	\N	0.000	t	6304.99.00	5	1	1	f	DECORACAO
158	P05929	Berloque Frida Kahlo Passador Flores Vazado	\N	<p>Passador em prata 925 com banho de ródio branco.&nbsp;</p>\n<p>Pintado a mão.</p>	129.90	0.020	0.020	0.020	0.000	t	7113.11.00	5	1	3	f	BERLOQUES
216	P05914	Berloque Frida Kahlo Baby Coração			119.90	\N	\N	\N	0.000	f		6	1	2	f	BERLOQUES
162	P05923	BerloqueFrida Kahlo Arara Vermelha	\N	<p>Berloque em prata 925 e banho de ródio branco. Pintado a mão.</p>\n<p>Pode ser usado como berloque ou como pingente.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
203	P05940	Berloque Frida Kahlo Flor Vermelha	\N	<p>Berloque em&nbsp; Prata 925 com banho de ródio branco.</p>\n<p>Flor vermelha pintada a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
197	P05921	Berloque Frida Kahlo 3 Flores	\N	<p>Berloque passador em prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
90	3127435	Brinco FK Argola Ondulada Pequena	\N	<p>Argola ondulada em prata 925.</p>\n<p>Diâmetro 3cm</p>	59.90	0.030	0.030	\N	0.000	t	7113.11.00	5	1	2	f	BRINCOS
223	P05904	Berloque Frida Kahlo Shadow	\N	<p>Berloque Passador&nbsp; Shadow em Prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	79.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
98	1892	Peso de Porta  Cactus com Flor	\N	<p>Peso de porta.</p>\n<p>Material poliester.</p>\n<p>Enchimento Areia.</p>\n<p>Formato: 14 x 25 cms</p>	54.90	0.250	0.140	\N	0.000	t	6304.99.00	5	1	1	f	DECORACAO
57	B05077	Brinco FK Gota Esmeralda	\N	<p>Brinco em prata 925.</p>	179.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BRINCOS
63	43282	Carteira Almoço FK Face and Red Roses	\N	<p>Carteirinha de mão para passeio.</p>\n<p>Formato: 18 x 12 cms</p>	34.90	\N	\N	\N	0.000	t	4202.32.00	5	1	1	f	ACESSORIOS
155	P05942	Berloque Frida Kahlo Passador Mão	\N	<p>Berloque em prata 925, com banho de ródio branco.</p>\n<p>Pintado a mão.</p>\n<p>Garantia permanente.</p>	99.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
195	3282228	Gargantilha Prata 40cm	\N		39.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	COLARES
131	4061	Bolsa Transversal FK Melancia Coral	\N	<p>Bolsa em poliester com alça longa e ajustável.</p>\n<p>tamanho: 15cmX20cmX5cm</p>	79.90	0.200	0.150	0.050	0.000	t	4202.22.20	5	1	2	f	ACESSORIOS
160	4050	Bolsa Transversal FK Viva la Vida	\N	<p>Super pratica essa bolsa transversal.</p>\n<p>12 x 17 cm</p>	79.90	0.170	0.120	0.040	0.000	t	4202.22.20	5	1	2	f	ACESSORIOS
89	129783	Brinco FK Argola Coração	\N	<p>Argola em prata 925. Formato de coração.</p>\n<p>Altura 4 cms.</p>	59.90	\N	\N	\N	0.000	t	7113.11.00	5	1	2	f	BRINCOS
109	4076	Bolsa Necessaire FK Floral Azul Alça Corda	\N	<p>Bolsinha prática. Pode ser usada como bolsa de mão, necessaire, estojo…</p>\n<p>Tamanho:37cmX19cmX5cm</p>	69.90	0.190	0.270	0.050	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
100	62449-77V	Moleskine Frida Kahlo Caveira Vermelha Grande	\N	<p>Caderneta de anotações grande.</p>\n<p>Papel especial 70g.</p>\n<p>Capa com recurso especial.</p>\n<p>Elástico.</p>\n<p>Miolo com pauta.</p>\n<p>Formato 190mm x 245mm</p>	54.90	\N	\N	\N	0.000	t	4820.10.00	5	1	1	f	ACESSORIOS
56	B05097	Brinco FK Gota Melancia Azul e Roxa	\N	<p>Brinco em prata 925.</p>	79.90	0.120	0.080	\N	0.000	t	7113.11.00	5	1	2	f	BRINCOS
65	43338	Tela Birds and Flowers FD Vermelho	\N	<p>Tela em lona.</p>\n<p>30x1,5x40cm</p>	44.90	\N	\N	\N	0.000	t	4911.91.00	5	1	1	f	DECORACAO
164	4031	Shopper  Frida Kahlo Viva la Vida	\N	<p>Shopper Bag Preta linda e versátil.&nbsp;</p>\n<p>Cabe um note de até 17"</p>\n<p>30 x 40 cm</p>	154.90	0.400	0.300	0.040	0.000	t	4202.22.20	5	1	3	f	ACESSORIOS
80	42999	Placa Metal Pies	\N	<p>Placa decorativa em metal.</p>\n<p>Tamanho: 26 x 20 cms</p>	34.90	0.260	0.200	\N	0.000	t	8306.29.00	5	1	1	f	DECORACAO
114	4099	Mochila SacoFrida Kahlo Fridinha	\N	<p>- Mochila Sacola Frida Kahlo;<br />\n- Material externo: policloreto de vinila e poliéster;<br />\n- Revestimento interno: 100% poliéster;<br />\n- Alças em cadarço;<br />\nTamanho: 30cmX40cmX3cm</p>	69.90	0.300	0.400	0.030	0.000	t	6304.99.00	5	1	4	f	ACESSORIOS
87	SP2019	Sacola Papel	\N		2.00	0.110	0.185	0.145	0.000	t		1	0	0	t	\N
76	43096	Cachepot Cerâmica Yellow Flowers - Fundo Vermelho	\N	<p>Lindo cachepot em cerâmica.</p>\n<p>Peça indispensavel na decoração da sua casa.</p>\n<p>Tamanho: 14 x 14 x 12 cms</p>	59.90	\N	\N	\N	0.000	t	6913.90.00	5	1	1	f	DECORACAO
126	4090	Estojo FK Fridinha Rosa Bebê	\N	<p>Estojo em poliester.</p>\n<p>Tamanho: 18cmX6cmX6cm</p>	44.90	0.060	0.180	0.060	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
141	4077	Bolsa Transversal FK Floral Preta	\N	<p>Bolsa em poliester com alça longa e ajustável.</p>\n<p>tamanho: 15cmX20cmX5cm</p>	79.90	0.200	0.150	0.050	0.000	t	4202.22.20	5	1	2	f	ACESSORIOS
67	43550	Sacola Market Frida Kahlo Red	\N	<p>Sacola em polipropileno excelente para feira e mercado.</p>\n<p>Tamanho: 40 x 15 x 40 cm</p>	49.90	\N	\N	\N	0.000	t	4202.22.10	5	1	0	f	ACESSORIOS
120	4091	Necessaire FK Fridinha Rosa Bebê	\N	<p>Necessaire em Poliester com zipper.</p>\n<p>Tamanho: 21cmX12cmX7cm</p>	59.90	0.120	0.210	0.070	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
150	4063	Bolsa Térmica FK Melancia Grande	\N	<p>Especificações:<br />\n- Bolsa Térmica Média Frida Kahlo;<br />\n- Material: poliéster;<br />\n- Forro plástico;<br />\n- Espuma térmica;<br />\n- Bolso Externo com zíper (ideal para levar temperos, guardanapos etc);<br />\n- Alça de mão fixa e alça lateral removível.</p>\n<p>24cmx20cmx13cm</p>	119.90	0.200	0.240	0.130	0.000	t	4202.22.20	5	1	2	f	ACESSORIOS
75	43097	Cachepot Cerâmica Red Birds and Flowers	\N		59.90	0.140	0.140	\N	0.000	t	6913.90.00	5	1	2	f	DECORACAO
163	P05934	Berloque Frida Kahlo Face White	\N	<p>Berloque em Prata 925.</p>\n<p>Compatível com todas as pulseiras de coleção.</p>\n<p>Pode ser usado como berloque ou pingente.</p>	119.90	\N	\N	\N	0.000	t		5	1	1	f	BERLOQUES
143	4074	Niqueleira FK Floral Azul	\N	<p>Niqueleira com aro para chaveiro.</p>\n<p>Tamanho: 12cmX7cm</p>	34.90	0.070	0.120	\N	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
123	4089	Necessaire Fridinha  Grande Preta	\N	<p>Necessaire em poliester, fundo preto com alça marrom.</p>\n<p>Tamanho: 21cmX12cmX6cm</p>	64.90	0.120	0.210	0.060	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
132	4062	Bolsa Sacola  FK Melancia	\N	<p>Bolsa em poliester reforçada. Excelente para compras.</p>\n<p>Tamanho: 35cmX39cmX10cm</p>	139.90	0.390	0.350	0.100	0.000	t	4202.22.20	5	1	4	f	ACESSORIOS
116	4096	Bolsa Sacola FK Fridinha	\N	<p>Bolsa em poliester reforçada. Excelente para compras.</p>\n<p>Tamanho: 35cmX39cmX10cm</p>	139.90	0.390	0.350	0.100	0.000	t	4202.22.20	5	1	4	f	ACESSORIOS
104	KT0005	Conjunto Corações Pulseira	\N	<p>Conjunto composto por</p>\n<p>1 Bracelete Oval N00360</p>\n<p>1 Berloques Frida Kahlo Coração com Pincel P05907</p>\n<p>2 Berloque Passador Murano Coração P06501</p>	399.90	\N	\N	\N	0.000	t		4	1	1	f	\N
71	43164	Capa Almofada Poliester FK Face and Red Roses	\N	<p>Capa para almofada.</p>\n<p>Sem enchimento.</p>\n<p>Tamanho 45 x 45 cm.</p>\n<p>Material: Poliester</p>	59.90	0.450	0.450	\N	0.000	t	6304.91.00	5	1	2	f	DECORACAO
108	4103	Chaveiro Fridinha Pom Pom	\N	<p>Chaveiro em poliseter, com echimento e pom pom.</p>	29.90	0.070	0.070	\N	0.000	t	6304.99.00	5	1	2	f	ACESSORIOS
128	4086	Carteira FK Fridinha Rosa Bebê	\N	<p>Carteira em poliester, com zipper.</p>\n<p>Tamanho: 17cmX10cm</p>	49.90	0.100	0.170	\N	0.000	t	4202.39.00	5	1	1	f	ACESSORIOS
99	62499-77B	Moleskine Frida Kahlo Pavão Grande	\N	<p>Caderneta de anotações grande.</p>\n<p>Papel especial 70g.</p>\n<p>Capa com recurso especial.</p>\n<p>Elástico.</p>\n<p>Miolo com pauta.</p>\n<p>Formato 190mm x 245mm</p>	54.90	\N	\N	\N	0.000	t	4820.20.00	5	1	1	f	ACESSORIOS
110	4070	Carteira FK Grande Floral Preta Alça Corda	\N	<p>Bolsinha prática. Pode ser usada como bolsa de mão, necessaire, estojo…</p>\n<p>Tamanho:37cmX19cmX5cm</p>	69.90	0.170	0.250	0.000	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
204	P05937	Berloque Frida Kahlo Medalha Pequena	\N	<p>Berloque formato medalha em Prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
115	4098	Bolsa Térmica FK Fridinha Grande	\N	<p>Especificações:<br />\n- Bolsa Térmica Média Frida Kahlo;<br />\n- Material: poliéster;<br />\n- Forro plástico;<br />\n- Espuma térmica;<br />\n- Bolso Externo com zíper (ideal para levar temperos, guardanapos etc);<br />\n- Alça de mão fixa e alça lateral removível.</p>\n<p>24cmx20cmx13cm</p>	119.90	0.200	0.240	0.130	0.000	t	4202.22.20	5	1	3	f	ACESSORIOS
156	C00241-3	Gargantilha Elo Português Pequeno Tamanho:45	\N		18.39	\N	\N	\N	0.000	t	7113.11.00	1	0	0	t	\N
103	KT0006	Gargantilha com Pingente Coração com Pincel	\N	<p>1 Berloques Frida Kahlo Coração com Pincel P05907</p>\n<p>1 Gargantilha Elo Portuguê Média Tam 45 C0246-45</p>	189.90	\N	\N	\N	0.000	t		4	1	1	f	\N
194	P05907	Berloque Frida Kahlo Coração com Pincel	\N	<p>Berloque passador em prata 925 com banho de ródio branco. Coração pintado a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	129.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BERLOQUES
137	4080	Bolsa Termica FK Floral Azul Grande	\N	<p>Especificações:<br />\n- Bolsa Térmica Média Frida Kahlo;<br />\n- Material: poliéster;<br />\n- Forro plástico;<br />\n- Espuma térmica;<br />\n- Bolso Externo com zíper (ideal para levar temperos, guardanapos etc);<br />\n- Alça de mão fixa e alça lateral removível.</p>\n<p>24cmx20cmx13cm</p>	119.90	0.200	0.240	0.130	0.000	t	4202.22.20	5	1	3	f	ACESSORIOS
189	P03651	Trava de Segurança (par)	\N		34.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
72	43163	Capa Almofada Poliester FK Red Flowers FD Preto	\N	<p>Capa para almofada.</p>\n<p>Sem enchimento.</p>\n<p>Tamanho 45 x 45 cm.</p>\n<p>Material: Poliester</p>	59.90	0.450	0.450	\N	0.000	t	6304.91.00	5	1	2	f	DECORACAO
165	H0012	Bracelete com Fecho Coração	\N	<p>Bracele em prata 925 com detalhes em zirconia.</p>\n<p>Uma ótima opção para montar a coleção de berloques.</p>\n<p>Dimensão: 5,5 de raio.</p>	134.90	\N	\N	\N	0.000	t		5	1	1	f	PULSEIRAS
68	43337	Tela Face Flowers Frame Colorido	\N	<p>Tela em lona.</p>\n<p>30x1,5x40cm</p>	44.90	\N	\N	\N	0.000	t	4911.91.00	5	1	1	f	DECORACAO
92	3250350	Bracelete FK Oval Largo	\N	<p>Bracelete "chatinho" em prata 925.</p>\n<p>Dimensões 6,5 x 5,2 cm</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	PULSEIRAS
69	43235	Lugar Americano - Red Flowers Conjunto com 2 Lugares	\N	<p>Conjunto com 2 lugares.</p>\n<p>Material: plástico</p>\n<p>Formato: 43,5 x 28,5 cms</p>	19.90	0.285	0.435	\N	0.000	t	3924.10.00	5	1	3	f	DECORACAO
74	43106	Lixeira para Carro FK em Neoprene Flowers	\N	<p>Essa lixeirinha em neoprene para carro é linda e prática.</p>\n<p>Quando suja você pode lava-la facilmente.</p>\n<p>Tamanho: 20 x 29 cms</p>	34.90	0.290	0.200	\N	0.000	t	6307.90.90	5	1	1	f	ACESSORIOS
60	B04454-3	Brinco FK Contorno Gota Verde	\N	<p>Brinco em prata 925.</p>	99.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BRINCOS
79	43000	Placa Metal Esperanza	\N	<p>Placa decorativa em metal.</p>\n<p>Tamanho: 26 x 20 cms</p>	34.90	0.260	0.200	\N	0.000	t	8306.29.00	5	1	1	f	DECORACAO
220	P05906	Stopper Frida Kahlo Rosas	\N		119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
200	P05939	Berloque Frida Kahlo Passador Coração  com Pincel	\N	<p>Berloque em Prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
86	40621	Capa Almofada Poliester FK Pixel	\N	<p>Capa para almofada.</p>\n<p>Sem enchimento.</p>\n<p>Tamanho 45 x 45 cm.</p>\n<p>Material: Poliester</p>	54.90	0.450	0.450	\N	0.000	t	6304.91.00	5	1	2	f	DECORACAO
107	KT0001	Conjunto Viva la Vida - Completo	\N	<p>Kit Frida Kahlo composto por</p>\n<p>1 Gargantilha Elo Portugês Pequeno tam 45 C00241-45&nbsp;</p>\n<p>2 Berloque Frida Kahlo Boneca P05926</p>\n<p>1 Berloque Frida Kahlo Melancia P05931</p>\n<p>1 Berloque Passador Frida Kahlo Coração P05902</p>\n<p>1 Berloque Frida Kahlo Onde Não Puderes Amar</p>\n<p>1 Pulseira Frida Kahlo Flor tamanho 18</p>	854.90	\N	\N	\N	0.000	t	7113.11.00	4	1	1	f	\N
209	P05936	Berloque Frida Kahlo Caveira Preta	\N	<p>Berloque&nbsp; em Prata 925 com banho de ródio branco. Detalhes da caveira pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
149	4064	Bolsa Termica FK Frutas Grande	\N	<p>Especificações:<br />\n- Bolsa Térmica Média Frida Kahlo;<br />\n- Material: poliéster;<br />\n- Forro plástico;<br />\n- Espuma térmica;<br />\n- Bolso Externo com zíper (ideal para levar temperos, guardanapos etc);<br />\n- Alça de mão fixa e alça lateral removível.</p>\n<p>24cmx20cmx13cm</p>	119.90	0.200	0.240	0.130	0.000	t	4202.22.20	5	1	2	f	ACESSORIOS
142	4079	Bolsa Sacola FK Floral Azul	\N	<p>Bolsa em poliester reforçada. Excelente para compras.</p>\n<p>Tamanho: 35cmX39cmX10cm</p>	139.90	0.390	0.350	0.100	0.000	t	4202.22.20	5	1	3	f	ACESSORIOS
136	4056	Niqueleira FK Melancia Coral	\N	<p>Niqueleira com aro para chaveiro.</p>\n<p>Tamanho: 12cmX7cm</p>	34.90	0.070	0.120	\N	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
73	43127	Set C/6 Pcs Porta Copos Cortiça FK Skull Flowers	\N	<p>Conjunto com 6 porta copos.</p>\n<p>Material: cortiça</p>\n<p>Formato 10 x 10 cm</p>	34.90	0.100	0.100	\N	0.000	t	4503.90.00	5	1	2	f	DECORACAO
102	62450-77B	Moleskine Pavão Frida Kahlo - Pequena 80 folhas	\N	<p>Caderneta de anotações pequena.</p>\n<p>Papel especial 70g.</p>\n<p>Capa com recurso especial.</p>\n<p>Elástico.</p>\n<p>Miolo sem pauta.</p>\n<p>Formato 95mm x 140mm</p>	34.90	\N	\N	\N	0.000	t	4820.20.00	5	1	1	f	ACESSORIOS
77	43095	Cachepot Cerâmica Red Flowers - Fundo Preto	\N	<p>Lindo cachepot em cerâmica.</p>\n<p>Peça indispensavel na decoração da sua casa.</p>\n<p>Tamanho: 14 x 14 x 12 cms</p>	59.90	\N	\N	\N	0.000	t	6913.90.00	5	1	2	f	DECORACAO
130	4053	Carteira FK Grande Frutas Coral e Preto	\N	<p>Carteira com alça em poliester.</p>\n<p>Tamanho: 20cmX12cm</p>	59.90	0.120	0.200	\N	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
121	4093	Bolsinha Necessaire FK Fridinha Preta	\N	<p>Bolsinha prática. Pode ser uysada como bolsa de mão, necessaire, estojo…</p>\n<p>Tamanho:37cmX19cmX5cm</p>	69.90	0.190	0.270	0.050	0.000	t	4202.39.00	5	1	1	f	ACESSORIOS
122	4092	Estojo FK Fridinha	\N	<p>Estojo com divisórias interna. Organizador de lápis.</p>\n<p>Tamanho: 12cmX21cmX7cm</p>	84.90	0.210	0.120	0.070	0.000	t	4202.39.00	5	1	3	f	ACESSORIOS
81	41775	Capacho Fibra de Coco	\N	<p>Capacho feito em fibra de coco.</p>\n<p>Tamanho: 60 x 40 cms</p>	84.90	0.400	0.600	\N	0.000	t	4601.29.00	5	1	1	f	DECORACAO
144	4073	Niqueleira FK Floral Preta	\N	<p>Niqueleira com aro para chaveiro.</p>\n<p>Tamanho: 12cmX7cm</p>	34.90	0.070	0.120	\N	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
88	EB122019	Embalagem Presente	\N		6.00	0.110	0.185	0.145	0.000	t	4819.10.00	1	0	0	t	\N
12	EDB2398	Porta Joias Coração	\N		9.90	\N	\N	\N	0.000	t	4819.10.00	2	2	0	f	DECORACAO
167	3127346	Bracelete FK Oval Fino	\N	<p>Pulseira&nbsp; com trava de segurança em prata 925</p>\n<p>Compatível com os berloques da coleção Frida Kahlo</p>\n<p>Dimensões: 6,5 x 5,2 cms</p>	89.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	PULSEIRAS
2	43270	Placa Madeira Red Birds and Flowers	\N		0.00	\N	\N	\N	0.000	t	4420.10.00	2	1	0	f	DECORACAO
5	MK-5708	Máscara Frida Kahlo Cinza	\N	<p>A máscara Frida Kahlo faz parte de uma edição especial e exclusiva da Loja Oficial Frida Kahlo.</p>\n<p>Essa máscara é feita de tecido duplo e o seu material é de algodão.</p>	39.90	\N	\N	\N	0.000	t	6307.90.10	2	1	0	f	ACESSORIOS
202	P06491	Berloque Frida Kahlo Passador Murano Verde	\N	<p>Berloque separador Prata 925 feito de Vidro Murano Italiano lapidado à mão.</p>\n<p>Acabamento e polimento manual.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	99.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BERLOQUES
8	P06510	Pingente Frida Kahlo Coração Murano Vermelho Pequeno	\N		89.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BERLOQUES
6	PU4292	Pulseira FK Trançada Couro Caramelo	\N	<p>Pulseira em couro trançada com fecho em prata 925.</p>	149.90	\N	\N	\N	0.000	t		2	2	0	f	PULSEIRAS
4	40555	Porta Canetas Porcelana	\N		0.00	0.078	0.095	0.070	0.000	t	6911.10.90	2	1	0	f	DECORACAO
1	40280	Tela Frida Face Flowers Branco	\N	<p>Tela em lona.</p>\n<p>30x1,5x40cm</p>	44.90	0.400	0.300	\N	0.000	t	4911.91.00	2	1	0	f	DECORACAO
3	43126	Set C/6 Pcs Porta Copos Cortiça Vermelho Branco	\N	<p>Conjunto com 6 porta copos.</p>\n<p>Material: cortiça</p>\n<p>Formato 10 x 10 cm</p>	34.90	0.100	0.100	\N	0.000	t	4503.90.00	2	1	0	f	DECORACAO
7	B05032-T	Brinco FK Anzol Turmalina	\N	<p>Brinco em prata 925 com Cristal colorido</p>	59.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BRINCOS
82	40641	Set C/6 Pcs Porta Copos Cortiça Flowers	\N	<p>Conjunto com 6 porta copos.</p>\n<p>Material: cortiça</p>\n<p>Formato 10 x 10 cm</p>	34.90	0.100	0.100	\N	0.000	t	4503.90.00	5	1	1	f	DECORACAO
151	4069	Chaveiro Ecobag Estampado - com bolsa amarela	\N	<p>Chaveiro em poliseter, com ziper.</p>\n<p>Dentro do chaveiro vem uma ecobag amarela.</p>\n<p>Tamanho do Chaveiro: 8cmx10cm</p>	39.90	0.100	0.080	\N	0.000	t	6304.99.00	6	1	2	f	ACESSORIOS
105	KT0002	Conjunto Viva la Vida - Pulseira	\N	<p>Kit Frida Kahlo composto por</p>\n<p>1 Berloque Frida Kahlo Boneca P05926</p>\n<p>1 Berloque Frida Kahlo Melancia P05931</p>\n<p>1 Berloque Passador Frida Kahlo Coração P05902</p>\n<p>1 Berloque Frida Kahlo Onde Não Puderes Amar</p>\n<p>1 Pulseira Frida Kahlo Flor tamanho 18</p>	674.90	\N	\N	\N	0.000	t		4	1	1	f	\N
78	43001	Placa Metal Face and Flowers	\N	<p>Placa decorativa em metal.</p>\n<p>Tamanho: 26 x 20 cms</p>	34.90	0.260	0.200	\N	0.000	t	8306.29.00	5	1	1	f	DECORACAO
221	B05905	Brinco Frida Kahlo Flor Vermelha	\N		119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	2	f	BRINCOS
129	4060	Bolsa Transversal FK Melancia Preta	\N	<p>Bolsa em poliester com alça longa e ajustável.</p>\n<p>tamanho: 15cmX20cmX5cm</p>	79.90	0.200	0.150	0.050	0.000	t	4202.22.20	5	1	2	f	ACESSORIOS
134	4055	Niqueleira FK Melancia Preta	\N	<p>Niqueleira com aro para chaveiro.</p>\n<p>Tamanho: 12cmX7cm</p>	39.90	0.070	0.120	\N	0.000	t	4202.39.00	5	1	2	f	ACESSORIOS
227	P05901	Berloque Frida Kahlo Passador Caveira	\N	<p>Berloque em Prata 925 com banho de ródio branco. Detalhes caveira pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	95.00	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
118	4097	Bolsa Térmica FK Fridinha  Pequena	\N	<p>Especificações:<br />\n- Bolsa Térmica Pequena Frida Kahlo;<br />\n- Material externo: 86% plástico PVC e 14% algodão;<br />\n- Material interno: térmico em plástico PVC;<br />\n- Fechamento em zíper;<br />\n- Alça fixa.</p>\n<p>Tamanho: 14x18x12</p>	79.90	0.140	0.180	0.120	0.000	t	6304.99.00	5	1	3	f	ACESSORIOS
219	P05910	Berloque Frida Kahlo Medalha Coração em Chamas	\N	<p>Berloque em Prata 925 com banho de ródio branco. Detalhes no coração&nbsp; pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	129.90	\N	\N	\N	0.000	t	7113.11.00	2	1	0	f	BERLOQUES
211	P05925	Berloque Frida Kahlo  Coração Baby Azul	\N	<p>Berloque Baby Azull em Prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	2	f	BERLOQUES
139	4078	Bolsa Transversal  FK Floral Azul	\N	<p>Bolsa em poliester com alça longa e ajustável.</p>\n<p>tamanho: 15cmX20cmX5cm</p>	79.90	0.200	0.150	0.050	0.000	t	4202.22.20	5	1	2	f	ACESSORIOS
177	BD8255	Camiseta Frida Calavera	\N	<p>SOBRE O PRODUTO</p>\n<p>As camisetas Chico Rei são produzidas artesanalmente com 100% de fibra natural de algodão, refinada e penteada.</p>\n<p>A estampa é pintada com tinta a base de água e com padrão de cores exclusiva. Tudo feito à mão.</p>\n<p>Atenção: o tom da malha pode apresentar pequenas variações entre os lotes.</p>	69.90	\N	\N	\N	0.000	t		5	6	3	f	CAMISETAS
226	P05902	Berloque Frida Kahlo Passador Coração	\N	<p>Berloque em Prata 925 com banho de ródio branco. Detalhes do coração pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	94.90	\N	\N	\N	0.000	t	7113.11.00	5	1	3	f	BERLOQUES
186	A05912	Anel Frida Kahlo Flor  Vermelha Fino		<p>Anel em Prata 925, com banho de ródio branco, e detalhes das flores pintados à mão.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	159.90	\N	\N	\N	0.000	t	7113.11.00	6	9	3	f	ANEIS
229	LFK-00002	Anel Frida Kahlo Flor	\N	\N	49.90	\N	\N	\N	\N	t	0001.02.03	5	2	0	f	\N
172	BEGE716	Camiseta El Venado Herido	\N	<p>SOBRE O PRODUTO</p>\n<p>As camisetas Chico Rei são produzidas artesanalmente com 100% de fibra natural de algodão, refinada e penteada.</p>\n<p>A estampa é pintada com tinta a base de água e com padrão de cores exclusiva. Tudo feito à mão.</p>\n<p>Atenção: o tom da malha pode apresentar pequenas variações entre os lotes.</p>	69.90	\N	\N	\N	0.000	t		5	4	3	f	CAMISETAS
208	P05932	Berloque Frida Kahlo Passador Retrato	\N	<p>Passador em Prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
217	P05913	Berloque Frida Kahlo Coração Para que preciso pés	\N		119.90	\N	\N	\N	0.000	t	7113.11.00	5	1	1	f	BERLOQUES
222	B05927-36	Brinco Frida Kahlo Coração em Chamas	\N		129.90	\N	\N	\N	0.000	t	7113.11.00	5	1	3	f	BRINCOS
225	P05903	Berloque Frida Kahlo Caveira Friducha	\N	<p>Berloque Friducha Caveira em Prata 925 com banho de ródio branco. Detalhes pintados a mão.</p>\n<p>Compatível com todas as marcas de pulseiras.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	79.90	\N	\N	\N	0.000	t	7113.11.00	5	1	3	f	BERLOQUES
191	PU5909	Pulseira Berloqueira Frida Kahlo Fecho Flor	\N	<p>Pulseira maleavel&nbsp; para berloques em Prata 925, com banho de ródio branco.</p>\n<p>Fecho com detalhe da rosa pintado a mão.&nbsp;Detalhe escrito Frida Khalo no fecho.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	289.90	\N	\N	\N	0.000	t	7113.11.00	6	6	1	f	PULSEIRAS
180	C00234	Gargantilha Rabo Rato Mini	\N	<p>Gargantilha em Prata 925 estilo rabo de gato.</p>	49.90	\N	\N	\N	0.000	t	7113.11.00	2	2	0	f	COLARES
187	C00241	Gargantilha Elo Português Pequeno	\N	<p>Gargantilha em Prata 925 estilo elo português.</p>	59.90	\N	\N	\N	0.000	t	7113.11.00	2	3	0	f	COLARES
182	A05911	Anel Frida Kahlo Flor Vermelha Largo	\N	<p>Anel em Prata 925, com banho de ródio branco, e detalhes das flores pintados à mão.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	249.90	\N	\N	\N	0.000	t	7113.11.00	5	8	3	f	ANEIS
153	A05910	Anel Frida Kahlo Coração em Chamas	\N	<p>Anel em Prata 925, com banho de ródio branco, e detalhes das flores pintados à mão.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	189.90	\N	\N	\N	0.000	t	7113.11.00	5	8	1	f	ANEIS
175	AB716	Camiseta Árbol	\N	<p>SOBRE O PRODUTO</p>\n<p>As camisetas Chico Rei são produzidas artesanalmente com 100% de fibra natural de algodão, refinada e penteada.</p>\n<p>A estampa é pintada com tinta a base de água e com padrão de cores exclusiva. Tudo feito à mão.</p>\n<p>Atenção: o tom da malha pode apresentar pequenas variações entre os lotes.</p>	69.90	\N	\N	\N	0.000	t		5	4	3	f	CAMISETAS
170	BR6001	Camiseta Viva La Vida	\N	<p>SOBRE O PRODUTO</p>\n<p>As camisetas Chico Rei são produzidas artesanalmente com 100% de fibra natural de algodão, refinada e penteada.</p>\n<p>A estampa é pintada com tinta a base de água e com padrão de cores exclusiva. Tudo feito à mão.</p>\n<p>Atenção: o tom da malha pode apresentar pequenas variações entre os lotes.</p>	69.90	\N	\N	\N	0.000	t		5	4	3	f	CAMISETAS
184	A05938	Anel Frida Kahlo Cactus!		<p>Anel em Prata 925, com banho de ródio branco, e detalhes do cactus pintados à mão.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	99.90	\N	\N	\N	\N	t	7113.11.00	17	9	1	f	ANEIS
185	PU5943	Pulseira Grossa Frida Kahlo	\N	<p>Pulseira maleavel&nbsp; para berloques em Prata 925, com banho de ródio branco.</p>\n<p>Fecho com detalhe da rosa pintado a mão.&nbsp;Detalhe escrito Frida Khalo no fecho.</p>\n<p>Possuem garantia permanente quanto à sua composição.</p>	270.00	\N	\N	\N	0.000	t	7113.11.00	5	2	1	f	PULSEIRAS
61	A07022	Anel Frida Kahlo Flor Azul	\N	<p>Anel em Prata 925 com banho de ródio branco.</p>	249.90	\N	\N	\N	0.000	t	7113.11.00	5	2	1	f	ANEIS
176	AZ9316	Camiseta No Te Demores	\N	<p>SOBRE O PRODUTO</p>\n<p>As camisetas Chico Rei são produzidas artesanalmente com 100% de fibra natural de algodão, refinada e penteada.</p>\n<p>A estampa é pintada com tinta a base de água e com padrão de cores exclusiva. Tudo feito à mão.</p>\n<p>Atenção: o tom da malha pode apresentar pequenas variações entre os lotes.</p>	69.90	\N	\N	\N	0.000	t		5	4	3	f	CAMISETAS
\.


--
-- Data for Name: product_composition; Type: TABLE DATA; Schema: public; Owner: digituz-dashboard
--

COPY public.product_composition (id, product_id, product_variation_id, version) FROM stdin;
\.


--
-- Data for Name: product_image; Type: TABLE DATA; Schema: public; Owner: digituz-dashboard
--

COPY public.product_image (image_id, product_id, image_order, id) FROM stdin;
291	209	1	2688
428	196	1	2705
771	196	2	2706
350	142	1	2717
347	142	2	2718
711	142	3	2719
540	160	1	2737
550	160	2	2738
431	198	1	2753
332	123	1	2771
344	123	2	2772
646	72	1	2790
765	72	2	2791
385	133	1	2810
384	133	2	2811
388	133	3	2812
603	99	1	2831
292	204	1	2843
299	203	1	2863
266	223	1	2875
274	166	1	2897
666	51	1	2911
663	51	2	2912
257	173	1	2924
436	169	1	2939
438	169	2	2940
460	169	3	2941
668	44	1	2950
316	116	1	2978
319	116	2	2979
717	116	3	2980
719	116	4	2981
601	101	1	2689
346	137	1	2708
340	137	2	2709
342	137	4	2710
399	131	1	2723
400	131	2	2724
634	64	1	2740
348	125	1	2761
260	182	1	2773
755	182	2	2774
759	182	3	2775
600	107	1	2797
611	94	1	2818
333	127	1	2834
684	38	1	2847
682	38	2	2848
679	38	3	2849
681	38	4	2850
680	38	5	2851
678	38	6	2852
648	62	1	2868
343	126	1	2883
336	126	2	2884
395	130	1	2898
397	130	2	2899
641	79	1	2914
337	124	1	2925
635	70	1	2943
537	159	1	2951
394	138	1	2969
392	138	2	2970
273	218	1	2690
466	218	2	2691
495	218	3	2692
650	82	1	2707
362	146	1	2720
365	146	2	2721
352	139	1	2741
354	139	2	2744
647	83	1	2760
728	83	2	2762
643	78	1	2778
691	40	1	2792
692	40	3	2793
697	40	4	2794
695	40	5	2795
255	165	1	2814
609	97	1	2832
553	179	1	2846
294	201	1	2867
639	69	1	2880
736	69	2	2881
741	69	3	2882
296	205	1	2900
304	147	1	2916
303	147	2	2917
271	224	1	2932
633	84	1	2948
295	155	1	2962
323	119	1	2693
370	149	1	2711
373	149	2	2712
761	34	1	2729
762	34	2	2730
772	34	3	2731
676	46	1	2745
598	109	1	2758
583	109	2	2759
640	71	1	2776
725	71	2	2777
335	128	1	2796
417	152	1	2813
256	184	1	2830
328	117	1	2841
322	117	2	2842
280	197	1	2862
396	134	1	2872
391	134	2	2873
353	141	1	2893
357	141	2	2894
321	121	1	2905
623	81	1	2919
644	86	1	2937
724	86	2	2938
380	132	1	2964
377	132	2	2966
710	132	3	2967
749	132	4	2968
285	214	1	2694
776	214	2	2695
785	214	3	2696
612	98	1	2715
393	136	1	2732
390	136	2	2733
360	143	1	2746
363	143	2	2747
267	226	1	2763
751	226	2	2764
757	226	3	2765
307	108	1	2781
305	108	2	2782
654	56	1	2802
705	56	2	2803
441	170	1	2824
439	170	2	2825
462	170	3	2826
585	110	1	2839
581	110	4	2840
308	114	1	2858
306	114	2	2859
309	114	3	2860
732	114	4	2861
677	45	1	2874
607	103	1	2896
707	42	1	2909
708	42	2	2910
293	200	1	2929
653	58	1	2945
742	75	2	2960
734	75	3	2961
284	211	1	2697
767	211	2	2698
277	213	1	2716
604	104	1	2735
451	177	1	2750
454	177	2	2751
456	177	3	2752
610	96	1	2769
601	100	1	2784
536	164	1	2807
512	164	2	2808
564	164	3	2809
638	68	1	2829
298	185	1	2844
627	90	1	2865
622	90	2	2866
338	148	1	2878
339	148	2	2879
279	212	1	2901
779	212	2	2902
262	227	1	2915
366	144	1	2930
364	144	2	2931
740	35	1	2944
300	199	1	2959
314	118	1	2982
317	118	2	2983
313	118	3	2984
289	168	1	2699
297	191	1	2713
398	135	1	2725
389	135	2	2726
301	163	1	2739
432	189	1	2757
603	102	1	2770
403	221	1	2788
483	221	2	2789
637	65	1	2806
664	52	1	2822
665	52	2	2823
387	129	1	2837
383	129	2	2838
281	162	1	2857
287	206	1	2869
674	171	1	2885
791	9	3	2903
272	220	1	2918
606	105	1	2936
401	222	1	2952
500	222	2	2953
501	222	3	2954
657	59	1	2974
330	120	1	2700
331	120	2	2701
636	66	1	2714
611	93	1	2734
358	145	1	2748
359	145	2	2749
275	215	1	2766
259	153	1	2783
286	158	1	2798
754	158	2	2799
747	158	4	2800
448	172	1	2815
447	172	2	2816
457	172	3	2817
642	80	1	2833
467	157	1	2853
468	157	2	2854
440	157	3	2855
658	54	1	2871
703	41	1	2887
696	41	2	2888
689	41	3	2889
690	41	4	2890
688	41	5	2891
683	41	6	2892
651	60	1	2913
290	154	1	2923
632	63	1	2942
649	61	1	2955
269	225	1	2971
753	225	2	2972
752	225	3	2973
655	53	1	2985
685	39	1	2702
694	39	2	2703
652	57	1	2722
675	47	1	2736
367	140	1	2754
355	140	2	2755
361	140	3	2756
743	77	2	2779
739	77	3	2780
630	91	1	2801
624	91	2	2804
446	175	1	2819
445	175	2	2820
444	175	3	2821
268	216	1	2835
491	216	2	2836
620	92	1	2856
283	207	1	2870
625	74	1	2886
659	49	1	2904
310	115	1	2920
312	115	2	2921
315	115	3	2922
459	174	1	2933
449	174	2	2934
450	174	3	2935
270	217	1	2949
737	36	1	2963
729	36	2	2965
613	106	1	2704
369	151	1	2727
371	151	2	2728
619	89	1	2742
617	89	2	2743
618	73	1	2767
721	73	2	2768
258	186	1	2785
758	186	2	2786
760	186	3	2787
645	85	1	2805
731	37	1	2827
730	37	2	2828
615	95	1	2845
735	76	2	2864
706	43	1	2876
709	43	2	2877
288	208	1	2895
325	122	1	2906
324	122	2	2907
329	122	3	2908
282	210	1	2926
745	210	2	2927
746	210	3	2928
376	150	1	2946
374	150	2	2947
458	176	1	2956
455	176	2	2957
453	176	3	2958
549	161	1	2975
509	161	2	2976
560	161	3	2977
\.


--
-- Data for Name: product_variation; Type: TABLE DATA; Schema: public; Owner: digituz-dashboard
--

COPY public.product_variation (id, sku, product_id, description, selling_price, version, no_variation, current_position) FROM stdin;
339	43413	35	Tamanho Único	34.90	2	t	37
1	PU4292-23	6	Tamanho:23	149.90	1	f	0
98	A05912-14	186	Tamanho:14	159.90	5	f	10
427	43096	76	Tamanho Único	59.90	2	t	0
2	PU4292-21	6	Tamanho:21	149.90	1	f	2
3	EDB2398-G	12	Tamanho:G	12.90	1	f	14
4	EDB2398-P	12	Tamanho:P	9.90	1	f	13
5	PU3793-22	15	Tamanho:22	149.90	1	f	2
6	PU3793-20	15	Tamanho:20	149.90	1	f	3
7	C00267-50	19	Tamanho:50	59.90	1	f	0
8	C00267-40	19	Tamanho:40	59.90	1	f	35
9	G07516-2024	54	Safira & Aqua Marine	189.90	1	f	0
10	G07516-2422	54	Aqua Marine & Esmeralda	189.90	1	f	1
11	G07516-2228	54	Black & Esmeralda	189.90	1	f	1
12	A07022-22	61	Tamanho:22	249.90	1	f	1
13	A07022-20	61	Tamanho:20	249.90	1	f	0
14	A07021-21	62	Tamanho:21	329.90	1	f	0
15	A07021-20	62	Tamanho:20	329.90	1	f	1
16	A07023-36-24	93	Tamanho:24	289.90	1	f	0
17	A07023-3-16	94	Tamanho:16	259.90	1	f	1
18	A07023-3-17	94	Tamanho:17	259.90	1	f	1
19	C00240-50	95	Tamanho:50	59.90	1	f	19
20	A05910-25	153	Tamanho:25	189.90	1	f	2
21	A05910-23	153	Tamanho:23	189.90	1	f	2
22	A05910-18	153	Tamanho:18	189.90	1	f	0
23	A05910-21	153	Tamanho:21	189.90	1	f	4
24	A05910-24	153	Tamanho:24	189.90	1	f	1
25	A05910-22	153	Tamanho:22	189.90	1	f	3
26	A05910-19	153	Tamanho:19	189.90	1	f	2
27	A05910-16	153	Tamanho:16	189.90	1	f	0
28	11006PL006-G	157	Feminino:G	79.90	1	f	0
29	11006PL006-M	157	Feminino:M	79.90	1	f	10
30	11006PL006-P	157	Feminino:P	79.90	1	f	0
31	RX919-MGG	169	Masculino:2GG	69.90	1	f	0
32	RX919-FM	169	Feminino:M	69.90	1	f	0
33	RX919-FGG	169	Feminino:GG	69.90	1	f	0
34	BR6001-FG	170	Feminino:G	69.90	1	f	0
35	BR6001-FM	170	Feminino:M	69.90	1	f	0
36	BR6001-FP	170	Feminino:P	69.90	1	f	0
37	BR6001-MP	170	Masculino:P	69.90	1	f	0
38	MR837-FP	171	Feminino:P	69.90	1	f	0
39	MR837-FGG	171	Feminino:GG	69.90	1	f	0
40	BEGE716-3GG	172	Feminino:3GG	69.90	1	f	0
41	BEGE716-MGG	172	Masculino:GG	69.90	1	f	0
42	BEGE716-MG	172	Masculino:G	69.90	1	f	0
43	BEGE716-FG	172	Feminino:G	69.90	1	f	0
44	LA837-MG	174	Masculino:G	69.90	1	f	0
45	LA837-MM	174	Masculino:M	69.90	1	f	0
46	LA837-FG	174	Feminino:G	69.90	1	f	0
47	LA837-FM	174	Feminino:M	69.90	1	f	0
48	LA837-FP	174	Feminino:P	69.90	1	f	0
49	AB716-FG	175	Feminino:G	69.90	1	f	0
50	AB716-FM	175	Feminino:M	69.90	1	f	0
51	AB716-MP	175	Masculino:P	69.90	1	f	2
52	AB716-FGG	175	Feminino:GG	69.90	1	f	0
53	BD8255-MP	177	Masculino:P	69.90	1	f	0
54	BD8255-MM	177	Masculino:M	69.90	1	f	0
55	BD8255-MG	177	Masculino:G	69.90	1	f	0
56	BD8255-FP	177	Feminino:P	69.90	1	f	0
57	BD8255-F2GG	177	Feminino:2GG	69.90	1	f	0
58	BD8255-FM	177	Feminino:M	69.90	1	f	0
59	AZ9316-MM	176	Masculino:M	69.90	1	f	0
60	AZ9316-FP	176	Feminino:P	69.90	1	f	0
61	AZ9316-FGG	176	Feminino:GG	69.90	1	f	0
62	AZ9316-FM	176	Feminino:M	69.90	1	f	0
63	C00234-45	180	Tamanho:45	49.90	1	f	0
64	C00234-40	180	Tamanho:40	49.90	1	f	0
65	C00246-45	181	Tamanho:45	59.90	1	f	5
66	C00239-60	178	Tamanho:60	49.90	1	f	0
67	C00239-45	178	Tamanho:45	44.90	1	f	0
68	C00239-40	178	Tamanho:40	44.90	1	f	0
70	A05911-25	182	Tamanho:25	249.90	1	f	1
71	A05911-22	182	Tamanho:22	249.90	1	f	1
72	A05911-15	182	Tamanho:15	249.90	1	f	3
73	A05911-24	182	Tamanho:24	249.90	1	f	4
74	A05911-20	182	Tamanho:20	249.90	1	f	5
76	A05911-16	182	Tamanho:16	249.90	1	f	5
77	A05938-25	184	Tamanho:25	99.90	1	f	3
78	A05938-21	184	Tamanho:21	99.90	1	f	0
79	A05938-30	184	Tamanho:30	99.90	1	f	1
80	A05938-20	184	Tamanho:20	99.90	1	f	4
81	A05938-23	184	Tamanho:23	99.90	1	f	5
82	A05938-12	184	Tamanho:12	99.90	1	f	0
83	A05938-18	184	Tamanho:18	99.90	1	f	5
84	A05938-16	184	Tamanho:16	99.90	1	f	2
85	A05938-15	184	Tamanho:15	99.90	1	f	3
87	PU5943-19	185	Tamanho:19	270.00	1	f	0
88	PU5943-18	185	Tamanho:18	270.00	1	f	0
89	A05912-23	186	Tamanho:23	159.90	1	f	5
90	A05912-24	186	Tamanho:24	159.90	1	f	7
91	A05912-25	186	Tamanho:25	159.90	1	f	9
93	A05912-21	186	Tamanho:21	159.90	1	f	10
94	A05912-19	186	Tamanho:19	159.90	1	f	3
95	A05912-18	186	Tamanho:18	159.90	1	f	0
96	A05912-17	186	Tamanho:17	159.90	1	f	19
316	P05924	9	Tamanho Único	119.90	1	t	0
317	B05032-AR	10	Tamanho Único	59.90	1	t	3
318	P04062	11	Tamanho Único	99.90	1	t	2
319	P04061	13	Tamanho Único	99.90	1	t	1
320	P04060	14	Tamanho Único	99.90	1	t	3
321	P06511	16	Tamanho Único	89.90	1	t	3
322	P04057	17	Tamanho Único	99.90	1	t	2
323	P04056	18	Tamanho Único	99.90	1	t	4
324	B07683-C	20	Tamanho Único	59.90	1	t	0
325	B07683-B	21	Tamanho Único	59.90	1	t	0
326	B07683-A	22	Tamanho Único	59.90	1	t	0
327	B06657-VV	23	Tamanho Único	99.90	1	t	2
328	43368	24	Tamanho Único	49.90	1	t	8
329	43367	25	Tamanho Único	49.90	1	t	0
330	43331	26	Tamanho Único	39.90	1	t	7
331	43254	27	Tamanho Único	54.90	1	t	9
332	43253	28	Tamanho Único	54.90	1	t	10
333	43239	29	Tamanho Único	44.90	1	t	0
334	43098	30	Tamanho Único	34.90	1	t	8
335	40624	31	Tamanho Único	34.90	1	t	8
336	40279	32	Tamanho Único	44.90	1	t	3
337	40127	33	Tamanho Único	37.40	1	t	0
338	MFK-5707	34	Tamanho Único	39.90	1	t	0
340	43426	36	Tamanho Único	34.90	1	t	26
92	A05912-12	186	Tamanho:12	159.90	2	f	6
69	A05911-19	182	Tamanho:19	249.90	3	f	1
75	A05911-18	182	Tamanho:18	249.90	5	f	6
341	40546	37	Tamanho Único	34.90	1	t	5
342	4081	38	Tamanho Único	84.90	1	t	0
343	4059	39	Tamanho Único	69.90	1	t	3
344	4066	40	Tamanho Único	89.90	1	t	3
345	4065	41	Tamanho Único	89.90	1	t	3
346	4052	42	Tamanho Único	79.90	1	t	10
347	4051	43	Tamanho Único	69.90	1	t	9
348	43205	44	Tamanho Único	39.90	1	t	8
349	G07516-SA	45	Tamanho Único	189.90	1	t	0
350	G07516-BE	46	Tamanho Único	189.90	1	t	1
351	B06657-ML	47	Tamanho Único	99.90	1	t	3
352	P06505	53	Tamanho Único	99.90	1	t	0
353	P05919	213	Tamanho Único	119.90	1	t	0
354	B05032-AM	49	Tamanho Único	59.90	1	t	0
355	P05908	224	Tamanho Único	119.90	1	t	37
356	B06657-ES	48	Tamanho Único	99.90	1	t	2
357	43281	64	Tamanho Único	34.90	1	t	13
358	40623	83	Tamanho Único	54.90	1	t	15
359	62450-77V	101	Tamanho Único	34.90	1	t	2
360	KT0004	106	Tamanho Único	589.90	1	t	1
361	B06365	113	Tamanho Único	159.90	1	t	5
362	4094	119	Tamanho Único	69.90	1	t	2
363	4057	135	Tamanho Único	34.90	1	t	2
364	4048	183	Tamanho Único	119.90	1	t	0
365	CP15041	188	Tamanho Único	54.90	1	t	0
366	3776791	192	Tamanho Único	69.90	1	t	0
367	P06472	198	Tamanho Único	99.90	1	t	1
368	P05933	205	Tamanho Único	119.90	1	t	31
369	LFK-00001	228	Tamanho Único	\N	1	t	0
370	B05076	58	Tamanho Único	167.90	1	t	0
371	43269	70	Tamanho Único	59.90	1	t	3
372	40642	84	Tamanho Único	34.90	1	t	8
373	3320243	91	Tamanho Único	79.90	1	t	0
374	PB6366	112	Tamanho Único	329.90	1	t	0
375	4084	148	Tamanho Único	39.90	1	t	8
376	4002	159	Tamanho Único	49.90	1	t	1
377	P05931	168	Tamanho Único	89.90	1	t	27
378	P05938	201	Tamanho Único	84.90	1	t	41
379	P05941	199	Tamanho Único	119.90	1	t	5
380	P05930	206	Tamanho Único	119.90	1	t	1
381	P05928	207	Tamanho Único	119.90	1	t	0
382	P05916	214	Tamanho Único	129.90	1	t	29
383	P05918	215	Tamanho Único	119.90	1	t	3
384	4071	146	Tamanho Único	59.90	1	t	3
385	4006	161	Tamanho Único	59.90	1	t	0
386	B05938	173	Tamanho Único	89.90	1	t	3
387	4047	179	Tamanho Único	79.90	1	t	0
388	PP15904	190	Tamanho Único	22.90	1	t	1
389	P06501	196	Tamanho Único	99.90	1	t	23
390	B05032-VV	50	Tamanho Único	59.90	1	t	1
391	B04454-36	59	Tamanho Único	99.90	1	t	0
392	43336	66	Tamanho Único	44.90	1	t	0
393	40622	85	Tamanho Único	54.90	1	t	15
394	1894	97	Tamanho Único	54.90	1	t	2
99	C00241-55	187	Tamanho:55	59.90	1	f	8
100	C00241-45	187	Tamanho:45	59.90	1	f	0
101	C00241-40	187	Tamanho:40	59.90	1	f	0
395	PB6367	111	Tamanho Único	449.90	1	t	0
396	4095	117	Tamanho Único	79.90	1	t	6
397	4088	124	Tamanho Único	34.90	1	t	2
398	4085	127	Tamanho Único	59.90	1	t	9
399	4058	133	Tamanho Único	59.90	1	t	0
400	4054	138	Tamanho Único	59.90	1	t	6
401	4072	145	Tamanho Único	59.90	1	t	10
402	B06913	152	Tamanho Único	119.90	1	t	-2
403	P05917	166	Tamanho Único	119.90	1	t	2
404	P05900	193	Tamanho Único	119.90	1	t	7
405	B05032-BK	52	Tamanho Único	59.90	1	t	2
406	P05940	203	Tamanho Único	119.90	1	t	2
407	P05926	210	Tamanho Único	129.90	1	t	24
408	LFK-00003	230	Tamanho Único	\N	1	t	0
409	LFK-00004	231	Tamanho Único	\N	1	t	0
410	P05914	216	Tamanho Único	119.90	1	t	0
411	B05032-SF	51	Tamanho Único	59.90	1	t	0
412	G06187	55	Tamanho Único	59.90	1	t	0
413	3127435	90	Tamanho Único	59.90	1	t	0
414	1899	96	Tamanho Único	54.90	1	t	0
415	4087	125	Tamanho Único	34.90	1	t	3
416	4075	140	Tamanho Único	59.90	1	t	4
417	4104	147	Tamanho Único	39.90	1	t	6
418	P05929	158	Tamanho Único	129.90	1	t	6
419	P05923	162	Tamanho Único	119.90	1	t	0
420	P05921	197	Tamanho Único	119.90	1	t	0
421	P05922	212	Tamanho Único	119.90	1	t	13
422	P05915	218	Tamanho Único	119.90	1	t	0
423	P05904	223	Tamanho Único	79.90	1	t	0
424	P05935	154	Tamanho Único	119.90	1	t	0
425	B05097	56	Tamanho Único	79.90	1	t	2
426	43282	63	Tamanho Único	34.90	1	t	13
428	1892	98	Tamanho Único	54.90	1	t	1
429	62449-77V	100	Tamanho Único	54.90	1	t	0
430	4076	109	Tamanho Único	69.90	1	t	10
431	4099	114	Tamanho Único	69.90	1	t	14
432	4090	126	Tamanho Único	44.90	1	t	14
433	4061	131	Tamanho Único	79.90	1	t	0
434	4077	141	Tamanho Único	79.90	1	t	10
435	P05942	155	Tamanho Único	99.90	1	t	3
436	4050	160	Tamanho Único	79.90	1	t	0
437	4031	164	Tamanho Único	154.90	1	t	0
438	3282228	195	Tamanho Único	39.90	1	t	0
439	43338	65	Tamanho Único	44.90	1	t	8
440	42999	80	Tamanho Único	34.90	1	t	9
441	SP2019	87	Tamanho Único	2.00	1	t	20
442	129783	89	Tamanho Único	59.90	1	t	15
443	B05077	57	Tamanho Único	179.90	1	t	1
444	62499-77B	99	Tamanho Único	54.90	1	t	1
445	KT0005	104	Tamanho Único	399.90	1	t	2
446	4103	108	Tamanho Único	29.90	1	t	1
447	4096	116	Tamanho Único	139.90	1	t	12
448	4089	123	Tamanho Único	64.90	1	t	7
449	4062	132	Tamanho Único	139.90	1	t	10
450	4074	143	Tamanho Único	34.90	1	t	6
451	4063	150	Tamanho Único	119.90	1	t	7
452	P05934	163	Tamanho Único	119.90	1	t	5
453	P05937	204	Tamanho Único	119.90	1	t	4
454	43550	67	Tamanho Único	49.90	1	t	31
455	43164	71	Tamanho Único	59.90	1	t	13
456	43097	75	Tamanho Único	59.90	1	t	14
457	4070	110	Tamanho Único	69.90	1	t	10
458	4098	115	Tamanho Único	119.90	1	t	13
459	4091	120	Tamanho Único	59.90	1	t	14
460	4086	128	Tamanho Único	49.90	1	t	14
461	4080	137	Tamanho Único	119.90	1	t	1
462	C00241-3	156	Tamanho Único	18.39	1	t	0
463	H0012	165	Tamanho Único	134.90	1	t	0
464	P03651	189	Tamanho Único	34.90	1	t	1
465	P05907	194	Tamanho Único	129.90	1	t	2
466	P05939	200	Tamanho Único	119.90	1	t	5
467	P05906	220	Tamanho Único	119.90	1	t	0
468	B04454-3	60	Tamanho Único	99.90	1	t	0
469	43235	69	Tamanho Único	19.90	1	t	16
470	43106	74	Tamanho Único	34.90	1	t	1
471	43000	79	Tamanho Único	34.90	1	t	5
472	40621	86	Tamanho Único	54.90	1	t	18
102	PU5909-23	191	Tamanho:23	289.90	1	f	0
103	PU5909-21	191	Tamanho:21	289.90	1	f	0
104	PU5909-19	191	Tamanho:19	289.90	1	f	8
105	PU0959-18	191	Tamanho:18	289.90	1	f	0
106	PU5909-17	191	Tamanho:17	289.90	1	f	0
107	PU5909-20	191	Tamanho:20	289.90	1	f	0
473	3250350	92	Tamanho Único	119.90	1	t	4
474	KT0006	103	Tamanho Único	189.90	1	t	2
475	43337	68	Tamanho Único	44.90	1	t	1
476	43163	72	Tamanho Único	59.90	1	t	10
477	KT0001	107	Tamanho Único	854.90	1	t	0
478	4092	122	Tamanho Único	84.90	1	t	4
479	4056	136	Tamanho Único	34.90	1	t	1
480	4079	142	Tamanho Único	139.90	1	t	10
481	4064	149	Tamanho Único	119.90	1	t	10
482	P05936	209	Tamanho Único	119.90	1	t	1
483	43095	77	Tamanho Único	59.90	1	t	12
484	41775	81	Tamanho Único	84.90	1	t	0
485	62450-77B	102	Tamanho Único	34.90	1	t	2
486	4093	121	Tamanho Único	69.90	1	t	9
487	4053	130	Tamanho Único	59.90	1	t	10
488	4073	144	Tamanho Único	34.90	1	t	4
489	43127	73	Tamanho Único	34.90	1	t	8
490	4069	151	Tamanho Único	39.90	1	t	11
491	3127346	167	Tamanho Único	89.90	1	t	20
492	P06491	202	Tamanho Único	99.90	1	t	0
493	B05905	221	Tamanho Único	119.90	1	t	3
494	P05901	227	Tamanho Único	95.00	1	t	4
495	43001	78	Tamanho Único	34.90	1	t	5
496	40641	82	Tamanho Único	34.90	1	t	8
497	EB122019	88	Tamanho Único	6.00	1	t	10
498	KT0002	105	Tamanho Único	674.90	1	t	0
499	4097	118	Tamanho Único	79.90	1	t	2
500	4060	129	Tamanho Único	79.90	1	t	9
501	4055	134	Tamanho Único	39.90	1	t	3
502	40280	1	Tamanho Único	44.90	1	t	8
503	43270	2	Tamanho Único	0.00	1	t	6
504	43126	3	Tamanho Único	34.90	1	t	10
505	40555	4	Tamanho Único	0.00	1	t	8
506	MK-5708	5	Tamanho Único	39.90	1	t	12
507	B05032-T	7	Tamanho Único	59.90	1	t	5
508	P06510	8	Tamanho Único	89.90	1	t	2
509	P05910	219	Tamanho Único	129.90	1	t	4
510	P05903	225	Tamanho Único	79.90	1	t	2
511	P05932	208	Tamanho Único	119.90	1	t	2
512	P05902	226	Tamanho Único	94.90	1	t	34
513	P05925	211	Tamanho Único	119.90	1	t	0
514	P05913	217	Tamanho Único	119.90	1	t	1
515	B05927-36	222	Tamanho Único	129.90	1	t	8
112	LFK-00002-19	229	Tamanho:19	49.90	15	f	0
113	LFK-00002-21	229	Tamanho:21	59.90	2	f	0
516	4078	139	Tamanho Único	79.90	1	t	0
\.


--
-- Data for Name: sale_order; Type: TABLE DATA; Schema: public; Owner: digituz-dashboard
--

COPY public.sale_order (id, version, reference_code, customer_id, discount, total, payment_type, payment_status, installments, shipping_type, customer_name, shipping_street_address, shipping_street_number, shipping_street_number_2, shipping_neighborhood, shipping_city, shipping_state, shipping_zip_address, shipping_price, creation_date, approval_date, cancellation_date, bling_status) FROM stdin;
49	8	10004	1	0.00	469.70	CREDIT_CARD	APPROVED	4	PAC	Pingo	Rua Sacadura Cabral	242	702	Petrópolis	Porto Alegre	RS	90690420	20.00	2020-08-20 21:19:04.839	\N	2020-08-20 21:25:40.855	EM_ABERTO
2	1	9592063490	1	0.00	329.72	BANK_SLIP	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-24 06:58:14.487415	\N	\N	\N
3	1	9711364571	1	0.00	329.72	BANK_SLIP	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-25 10:45:36.412412	\N	\N	\N
4	1	5981352998	1	0.00	329.72	BANK_SLIP	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-15 05:01:14.333748	\N	\N	\N
5	1	7769447716	1	0.00	329.72	BANK_SLIP	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-23 14:16:26.776159	\N	\N	\N
6	1	2308927476	1	0.00	329.72	BANK_SLIP	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-22 06:32:10.044775	\N	\N	\N
7	1	0485635899	1	0.00	329.72	BANK_SLIP	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-10 12:34:29.421603	\N	\N	\N
8	1	8411392788	1	0.00	329.72	BANK_SLIP	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-24 07:59:25.483602	\N	\N	\N
9	1	6859464029	1	0.00	329.72	BANK_SLIP	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-08 03:10:29.300928	\N	\N	\N
10	1	9261137795	1	0.00	329.72	BANK_SLIP	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-28 11:27:19.382665	\N	\N	\N
11	1	0518350421	1	0.00	329.72	BANK_SLIP	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-03 17:46:18.39319	\N	\N	\N
36	1	1234	2	0.00	0.00	BANK_SLIP	APPROVED	1	SEDEX	Joana	Rua São Simão	123		Bom Jesus	Porto Alegre	RS	91420560	0.00	2020-08-12 11:58:47.784	\N	\N	\N
37	1	12345	2	0.00	0.00	BANK_SLIP	IN_PROCESS	1	SEDEX	Joana	Rua São Simão	123		Bom Jesus	Porto Alegre	RS	91420560	0.00	2020-08-12 13:58:24.963	\N	\N	\N
38	1	1	2	0.00	0.00	BANK_SLIP	IN_PROCESS	1	SEDEX	Pingo	Rua São Simão	123		Bom Jesus	Porto Alegre	RS	91420560	0.00	2020-08-12 14:00:45.569	\N	\N	\N
39	1	2	1	0.00	10.00	CREDIT_CARD	IN_PROCESS	1	PAC	Pingo	Rua São Simão	99		Bom Jesus	Porto Alegre	RS	91420560	10.00	2020-08-12 14:17:49.426	\N	\N	\N
40	1	3	2	0.00	10.00	BANK_SLIP	IN_PROCESS	1	PAC	Joana	Rua Augusta	99		Consolação	São Paulo	SP	01305000	10.00	2020-08-12 14:29:08.597	\N	\N	\N
41	1	4	2	0.00	119.70	BANK_SLIP	IN_PROCESS	1	PAC	Joana	Rua São Simão	11		Bom Jesus	Porto Alegre	RS	91420560	0.00	2020-08-12 14:37:42.909	\N	\N	\N
12	1	7723817376	1	0.00	104.81	BANK_SLIP	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-08 16:13:43.746232	\N	\N	\N
13	2	6367925669	1	0.00	104.81	BANK_SLIP	APPROVED	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-25 06:30:26.300159	\N	\N	\N
14	2	6368260910	1	0.00	208.13	BANK_SLIP	CANCELLED	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-08-01 07:42:08.702419	\N	\N	\N
15	2	6369627029	1	0.00	208.13	BANK_SLIP	CANCELLED	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-08-03 07:25:00.538112	\N	\N	\N
16	1	6461491051	1	0.00	208.13	CREDIT_CARD	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-26 03:27:16.800941	\N	\N	\N
17	1	6481362026	1	0.00	229.60	CREDIT_CARD	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-28 10:24:08.357201	\N	\N	\N
18	1	6483249440	1	0.00	229.60	CREDIT_CARD	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-25 18:16:06.018929	\N	\N	\N
20	1	6484374070	1	30.00	199.60	CREDIT_CARD	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-08-01 23:56:38.167215	\N	\N	\N
19	2	6484053247	1	30.00	199.60	CREDIT_CARD	APPROVED	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-17 05:21:45.047291	\N	\N	\N
21	2	6484408128	1	30.00	199.60	CREDIT_CARD	APPROVED	3	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-25 22:09:42.610768	\N	\N	\N
22	2	6484456825	1	30.00	199.60	BANK_SLIP	APPROVED	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-07-28 09:38:45.783196	\N	\N	\N
23	1	6489408661	1	0.00	360.86	CREDIT_CARD	IN_PROCESS	3	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	14.90	2020-08-01 05:09:19.396419	\N	\N	\N
24	1	6489537265	1	0.00	288.30	BANK_SLIP	IN_PROCESS	1	PAC	Pingo Krebs	Rua Augusta	123	\N	Consolação	São Paulo	SP	01305000	0.00	2020-07-22 17:09:19.154673	\N	\N	\N
25	1	6620427079	2	0.00	376.19	CREDIT_CARD	IN_PROCESS	4	SEDEX	Joana da Silva	Rua Almirante Guilhem	44	\N	Leblon	Rio de Janeiro	RJ	22440000	41.39	2020-08-05 06:40:30.738	\N	\N	\N
26	1	123	1	0.00	11.00	CREDIT_CARD	APPROVED	1	SAME_DAY	Pingo Krebs	Rua Augusta	123		Consolação	São Paulo	SP	01305000	11.00	2020-08-11 17:11:21.513	\N	\N	\N
42	4	6	1	10.00	290.70	CREDIT_CARD	IN_PROCESS	5	SEDEX	Pingo V K	Rua Augusta	123	456	Consolação	São Paulo	SP	01305000	21.00	2020-08-12 22:14:55.417	\N	\N	\N
46	2	10001	2	0.00	99.70	BANK_SLIP	APPROVED	1	PAC	Joana	Rua São Simão	99		Bom Jesus	Porto Alegre	RS	91420560	10.00	2020-08-20 18:47:23.168	\N	\N	EM_ABERTO
45	3	222333444	1	0.00	269.80	CREDIT_CARD	APPROVED	5	SEDEX	Pingo	Avenida Ijuí	56		Petrópolis	Porto Alegre	RS	90460200	50.00	2020-08-14 10:57:14.006	\N	\N	EM_ABERTO
44	6	111222333	1	10.00	59.80	CREDIT_CARD	APPROVED	3	SEDEX	Pingo Krebs	Rua São Simão	99	401	Bom Jesus	Porto Alegre	RS	91420560	10.00	2020-08-14 10:44:26.079	\N	\N	EM_ABERTO
47	2	10002	2	10.00	299.80	BANK_SLIP	APPROVED	1	PAC	Joana	Rua São Simão	99		Bom Jesus	Porto Alegre	RS	91420560	10.00	2020-08-20 19:43:13.225	\N	\N	EM_ABERTO
48	4	10003	1	10.00	519.80	CREDIT_CARD	CANCELLED	3	SEDEX	Pingo	Rua Sacadura Cabral	242	702	Petrópolis	Porto Alegre	RS	90690420	30.00	2020-08-20 20:02:27.797	\N	2020-08-20 20:58:59.53	EM_ABERTO
\.


--
-- Data for Name: sale_order_item; Type: TABLE DATA; Schema: public; Owner: digituz-dashboard
--

COPY public.sale_order_item (id, version, sale_order_id, price, discount, amount, product_variation_id) FROM stdin;
14	1	8	249.90	24.99	1.00	73
15	1	8	99.90	9.99	1.00	389
16	1	9	249.90	24.99	1.00	73
17	1	9	99.90	9.99	1.00	389
18	1	10	249.90	24.99	1.00	73
19	1	10	99.90	9.99	1.00	389
20	1	11	249.90	24.99	1.00	73
21	1	11	99.90	9.99	1.00	389
22	1	12	99.90	9.99	1.00	389
23	1	13	99.90	9.99	1.00	389
24	1	14	79.90	7.99	1.00	29
25	1	14	99.90	9.99	1.00	389
26	1	14	34.90	3.49	1.00	397
27	1	15	79.90	7.99	1.00	29
28	1	15	99.90	9.99	1.00	389
29	1	15	34.90	3.49	1.00	397
30	1	16	79.90	7.99	1.00	29
31	1	16	99.90	9.99	1.00	389
32	1	16	34.90	3.49	1.00	397
33	1	17	79.90	0.00	1.00	29
34	1	17	99.90	0.00	1.00	389
35	1	17	34.90	0.00	1.00	397
36	1	18	79.90	0.00	1.00	29
37	1	18	99.90	0.00	1.00	389
38	1	18	34.90	0.00	1.00	397
39	1	19	79.90	0.00	1.00	29
40	1	19	99.90	0.00	1.00	389
41	1	19	34.90	0.00	1.00	397
42	1	20	79.90	0.00	1.00	29
43	1	20	99.90	0.00	1.00	389
44	1	20	34.90	0.00	1.00	397
45	1	21	79.90	0.00	1.00	29
46	1	21	99.90	0.00	1.00	389
47	1	21	34.90	0.00	1.00	397
48	1	22	79.90	0.00	1.00	29
49	1	22	99.90	0.00	1.00	389
50	1	22	34.90	0.00	1.00	397
51	1	23	79.90	7.99	1.00	29
52	1	23	99.90	9.99	2.00	389
53	1	23	34.90	3.49	3.00	397
54	1	24	79.90	19.97	1.00	29
55	1	24	99.90	24.97	2.00	389
56	1	24	34.90	8.73	3.00	397
57	1	25	44.90	0.00	1.00	432
58	1	25	289.90	0.00	1.00	104
59	1	41	39.90	0.00	3.00	330
64	1	42	249.90	30.00	1.00	72
65	1	42	39.90	10.00	2.00	330
66	1	44	39.90	10.00	2.00	330
67	1	45	119.90	10.00	2.00	402
68	1	46	34.90	5.00	3.00	339
69	1	47	159.90	10.00	2.00	92
71	1	48	249.90	0.00	2.00	69
78	1	49	159.90	10.00	1.00	98
79	1	49	249.90	10.00	1.00	75
80	1	49	59.90	0.00	1.00	427
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: digituz-dashboard
--

COPY public.tag (id, label, description, version) FROM stdin;
1	40280	Tela Frida Face Flowers Branco	1
2	43270	Placa Madeira Red Birds and Flowers	1
3	43126	Set C/6 Pcs Porta Copos Cortiça Vermelho Branco	1
4	40555	Porta Canetas Porcelana	1
5	MK-5708	Máscara Frida Kahlo Cinza	1
6	B05032-T	Brinco FK Anzol Turmalina	1
7	PU4292	Pulseira FK Trançada Couro Caramelo	1
8	P06510	Pingente Frida Kahlo Coração Murano Vermelho Pequeno	1
9	P05924	Berloque Frida Kahlo Medalha Arara Preta	1
10	B05032-AR	Brinco FK Anzol Azul e Rosa	1
11	P04062	Pingente Frida Kahlo Estrela	1
12	P04061	Pingente Frida Kahlo Jade Rubi Facetada	1
13	P04060	Pingente Frida Kahlo Malaquita Russa	1
14	EDB2398	Porta Joias Coração	1
15	P06511	Pingente Frida Kahlo Coração Murano Amarelo Pequeno	1
16	PU3793	Pulseira FK Trançada Couro Preta	1
17	P04057	Pingente Frida Kahlo Turquesa Howlita	1
18	P04056	Pingente Frida Kahlo Olho de Tigre	1
19	C00267	Corrente Bolinhas	1
20	B07683-C	Brinco Cristal Oval C	1
21	B07683-B	Brinco Cristal Oval B	1
22	B07683-A	Brinco Cristal Oval A	1
23	B06657-VV	Brinco FK Anzol Duas Pedras Vermelha e Verde	1
24	43368	Copo Termico Plástico Red Flowers	1
25	43367	Copo Termico Plástico Red Birds and Flowers	1
26	43331	Caneca com Alça Vidro Mágica	1
27	43254	Necessaire Flowers Fundo Preto	1
28	43253	Necessaire Red Birds and Flowers	1
29	43239	Cj 4 Copos de Shot	1
30	43098	Suporte de Panela em Vidro	1
31	40624	Lixeira para Carro em Neoprene - Pixel	1
32	40279	Tela Heavened Heart	1
33	40127	Lata Metal Skulls and Flowers	1
34	MFK-5707	Máscara Frida Kahlo	1
35	43413	Mini Caneca Porcelana FK Geometric Flowers	1
36	43426	Mini Caneca Porcelana FK Head and Flowers	1
37	40546	Mini Caneca Ceramica FK Face Amarelo	1
38	4081	Estojo FK Floral Azul	1
39	4059	Bolsa Necessaire FK Frutas Verde Alça Corda	1
40	4066	Estojo FK Melancia Coral	1
41	4052	Carteira FK Melancia Coral Alça Corda	1
42	4065	Estojo FK  Melancia Preto	1
43	4051	Carteira FK Melancia Preta Alça Corda	1
44	43205	Moleskine Frida Kahlo Flowers	1
45	G07516-SA	Escapulário dois Cristais - Safira e Aqua Marine	1
46	G07516-BE	Escapulário dois Cristais - Black e Esmeralda	1
47	B06657-ML	Brinco  FK Anzol Duas Pedras Azul e Rosa	1
48	B06657-ES	Brinco FK Anzol Duas Pedras Esmeralda	1
49	B05032-AM	Brinco FK Anzol  Aqua Marine	1
50	B05032-VV	Brinco FK Anzol Vermelha e Verde	1
51	B05032-SF	Brinco FK Safira Anzol	1
52	B05032-BK	Brinco FK Anzol Black	1
53	P06505	Pingente Frida Kahlo Coração Murano Vermelho Grande	1
54	G07516	Escapulário Dois Cristais - Coleção Cores	1
55	G06187	Gargantilha Olho Grego e pontos de Luz	1
56	B05097	Brinco FK Gota Melancia Azul e Roxa	1
57	B05077	Brinco FK Gota Esmeralda	1
58	B05076	Brinco FK Gota Turmalina	1
59	B04454-36	Brinco FK Contorno Gota Azul	1
60	B04454-3	Brinco FK Contorno Gota Verde	1
61	A07022	Anel Frida Kahlo Flor Azul	1
62	43282	Carteira Almoço FK Face and Red Roses	1
63	A07021	Anel Frida Kahlo Flor Preta	1
64	43338	Tela Birds and Flowers FD Vermelho	1
65	43281	Carteira Almoço  FK Red Birds and Flowers	1
66	43336	Tela Blue Birds and Flowers Colorido	1
67	43550	Sacola Market Frida Kahlo Red	1
68	43337	Tela Face Flowers Frame Colorido	1
69	43235	Lugar Americano - Red Flowers Conjunto com 2 Lugares	1
70	43164	Capa Almofada Poliester FK Face and Red Roses	1
71	43163	Capa Almofada Poliester FK Red Flowers FD Preto	1
72	43127	Set C/6 Pcs Porta Copos Cortiça FK Skull Flowers	1
73	43106	Lixeira para Carro FK em Neoprene Flowers	1
74	43269	Placa Madeira - Face and Red Roses	1
75	43097	Cachepot Cerâmica Red Birds and Flowers	1
76	43095	Cachepot Cerâmica Red Flowers - Fundo Preto	1
77	43096	Cachepot Cerâmica Yellow Flowers - Fundo Vermelho	1
78	43001	Placa Metal Face and Flowers	1
79	43000	Placa Metal Esperanza	1
80	42999	Placa Metal Pies	1
81	41775	Capacho Fibra de Coco	1
82	40641	Set C/6 Pcs Porta Copos Cortiça Flowers	1
83	40622	Capa Almofada Poliester FK Esperanza	1
84	40623	Capa Almofada Poliester FK Face and Flowers	1
85	40621	Capa Almofada Poliester FK Pixel	1
86	SP2019	Sacola Papel	1
87	40642	Set C/6 Pcs Porta Copos Cortiça FK Pixels	1
88	EB122019	Embalagem Presente	1
89	129783	Brinco FK Argola Coração	1
90	3127435	Brinco FK Argola Ondulada Pequena	1
91	3320243	Brinco FK Argola Ondulada Grande	1
92	3250350	Bracelete FK Oval Largo	1
93	A07023-36	Anel Frida Kahlo Flor Verde Com Ródio	1
94	1899	Peso de Porta Cactus em Feltro	1
95	1894	Peso de Porta Cactus	1
96	A07023-3	Anel Frida Kahlo Flor Verde	1
97	C00240	Corrente Grume Pequena	1
98	1892	Peso de Porta  Cactus com Flor	1
99	62499-77B	Moleskine Frida Kahlo Pavão Grande	1
100	62449-77V	Moleskine Frida Kahlo Caveira Vermelha Grande	1
101	KT0006	Gargantilha com Pingente Coração com Pincel	1
102	62450-77V	Moleskine Frida Kahlo Caveira Vermelha Pequena	1
108	4103	Chaveiro Fridinha Pom Pom	1
122	4097	Bolsa Térmica FK Fridinha  Pequena	1
135	4056	Niqueleira FK Melancia Coral	1
147	4104	Chaveiro Ecobag Fridinha - com bolsa preta	1
159	4002	Carteira FK Pequena Viva la Vida	1
168	P05931	Berloque Frida Kahlo Melancia	1
181	AZ9316	Camiseta No Te Demores	1
200	3282228	Gargantilha Prata 40cm	1
216	P05916	Berloque Frida Kahlo Onde Não Puderes Amar	1
103	KT0005	Conjunto Corações Pulseira	1
115	PB6366	Bracelete Fino Frida Kahlo Rosas Vermelhas	1
123	4087	Niqueleira FK Fridinha Preta	1
130	4062	Bolsa Sacola  FK Melancia	1
139	4080	Bolsa Termica FK Floral Azul Grande	1
148	4064	Bolsa Termica FK Frutas Grande	1
156	C00241-3	Gargantilha Elo Português Pequeno Tamanho:45	1
164	P05917	Berloque Frida Kahlo Risada	1
174	LA837	Camiseta La Artista	1
180	C00246	Gargantilha Elo Português Médio	1
190	3776791	Gargantilha Prata 70 cm	1
198	P05941	Berloque Frida Kahlo Face Flor Rosa	1
206	P05930	Berloque Frida Kahlo Medalha Flores Vermelhas	1
214	P05918	Berloque Frida Kahlo Baby Balloon	1
223	P05904	Berloque Frida Kahlo Shadow	1
104	KT0002	Conjunto Viva la Vida - Pulseira	1
114	4098	Bolsa Térmica FK Fridinha Grande	1
121	4091	Necessaire FK Fridinha Rosa Bebê	1
134	4086	Carteira FK Fridinha Rosa Bebê	1
150	4063	Bolsa Térmica FK Melancia Grande	1
166	4031	Shopper  Frida Kahlo Viva la Vida	1
184	A05938	Anel Frida Kahlo Cactus	1
199	P05939	Berloque Frida Kahlo Passador Coração  com Pincel	1
209	P05926	Berloque Frida Kahlo Boneca	1
218	P05915	Berloque Frida Kahlo Coração Baby Rosa	1
225	P05903	Berloque Frida Kahlo Caveira Friducha	1
105	62450-77B	Moleskine Pavão Frida Kahlo - Pequena 80 folhas	1
117	4095	Bolsa Transversal FK Fridinha Preta	1
129	4085	Carteira FK Grande Fridinha Preta	1
138	4078	Bolsa Transversal  FK Floral Azul	1
146	4071	Carteira FK Grande Floral Preta	1
154	P05942	Berloque Frida Kahlo Passador Mão	1
163	P05934	Berloque Frida Kahlo Face White	1
172	MR837	Camiseta Mágoas	1
179	4048	Shopper Frida Kahlo Geometrica	1
189	PP15904	Flor Madreperola	1
195	P05921	Berloque Frida Kahlo 3 Flores	1
205	P06491	Berloque Frida Kahlo Passador Murano Verde	1
212	P05932	Berloque Frida Kahlo Passador Retrato	1
222	B05927-36	Brinco Frida Kahlo Coração em Chamas	1
106	KT0001	Conjunto Viva la Vida - Completo	1
109	4076	Bolsa Necessaire FK Floral Azul Alça Corda	1
116	4096	Bolsa Sacola FK Fridinha	1
126	4090	Estojo FK Fridinha Rosa Bebê	1
132	4058	Necessaire FK Frutas Verde Água	1
141	4079	Bolsa Sacola FK Floral Azul	1
149	B06913	Brinco Frida Kahlo Cactus Anzol	1
158	4050	Bolsa Transversal FK Viva la Vida	1
165	3127346	Bracelete FK Oval Fino	1
175	4047	Bolsa Transversal FK Geometrica	1
182	PU5943	Pulseira Grossa Frida Kahlo	1
191	P05900	Berloque Frida Kahlo Passador Flor Vermelha	1
201	P05938	Berloque Frida Kahlo Cactus	1
208	P05936	Berloque Frida Kahlo Caveira Preta	1
217	P05913	Berloque Frida Kahlo Coração Para que preciso pés	1
224	P05908	Berloque Frida Kahlo Murano Flor	1
107	KT0004	Conjunto Corações Completo	1
111	PB6367	Bracelete Largo Frida Kahlo Rosas Vermelhas	1
118	4094	Bolsinha Necessaire FK Fridinha Rosa Bebê	1
127	4060	Bolsa Transversal FK Melancia Preta	1
136	4054	Carteira FK Grande Pitaya	1
144	4073	Niqueleira FK Floral Preta	1
152	4084	Chaveiro Ecobag Estampado - com bolsa pink	1
161	4006	Carteira FK Grande Viva la Vida	1
170	B05938	Brinco Frida Kahlo Cactus	1
177	AB716	Camiseta Árbol	1
187	P03651	Trava de Segurança (par)	1
193	PU5909	Pulseira Berloqueira Frida Kahlo Fecho Flor	1
203	P05937	Berloque Frida Kahlo Medalha Pequena	1
210	P05922	Berloque Frida Kahlo Apaixonada	1
220	P05906	Stopper Frida Kahlo Rosas	1
110	4070	Carteira FK Grande Floral Preta Alça Corda	1
124	4093	Bolsinha Necessaire FK Fridinha Preta	1
133	4055	Niqueleira FK Melancia Preta	1
143	4074	Niqueleira FK Floral Azul	1
155	A05910	Anel Frida Kahlo Coração em Chamas	1
169	H0012	Bracelete com Fecho Coração	1
183	A05912	Anel Frida Kahlo Flor  Vermelha Fino	1
197	C00241	Gargantilha Elo Português Pequeno	1
213	P05925	Berloque Frida Kahlo  Coração Baby Azul	1
112	B06365	Brinco Frida Kahlo Coração Partido	1
119	4092	Estojo FK Fridinha	1
128	4061	Bolsa Transversal FK Melancia Coral	1
137	4057	Niqueleira FK Pitaya Preta	1
145	4072	Carteira FK Grande Floral Azul	1
153	P05935	Berloque Frida Kahlo Caveira Colorida	1
162	P05923	BerloqueFrida Kahlo Arara Vermelha	1
171	BR6001	Camiseta Viva La Vida	1
178	C00234	Gargantilha Rabo Rato Mini	1
188	A05911	Anel Frida Kahlo Flor Vermelha Largo	1
194	P06501	Berloque Frida Kahlo Passador Murano Coração	1
204	P05933	Berloque Frida Kahlo Face Color	1
211	P05919	Berloque Frida Kahlo e Caveira	1
221	B05905	Brinco Frida Kahlo Flor Vermelha	1
113	4099	Mochila SacoFrida Kahlo Fridinha	1
120	4089	Necessaire Fridinha  Grande Preta	1
131	4053	Carteira FK Grande Frutas Coral e Preto	1
142	4077	Bolsa Transversal FK Floral Preta	1
151	4069	Chaveiro Ecobag Estampado - com bolsa amarela	1
160	11006PL006	Camiseta Oficial Frida Kahlo	1
167	RX919	Camiseta Miragem	1
176	BD8255	Camiseta Frida Calavera	1
185	CP15041	Corrente Casal de Passarinhos	1
192	P05907	Berloque Frida Kahlo Coração com Pincel	1
202	P05940	Berloque Frida Kahlo Flor Vermelha	1
215	P05914	Berloque Frida Kahlo Baby Coração	1
226	P05902	Berloque Frida Kahlo Passador Coração	1
125	4088	Niqueleira FK Fridinha Rosa Bebê	1
140	4075	Necessaire FK Floral Azul	1
157	P05929	Berloque Frida Kahlo Passador Flores Vazado	1
173	BEGE716	Camiseta El Venado Herido	1
186	C00239	Gargantilha Veneziana	1
196	P06472	Berloque Frida Kahlo Passador Murano Preto	1
207	P05928	Berloque Frida Kahlo Coração em Chamas	1
219	P05910	Berloque Frida Kahlo Medalha Coração em Chamas	1
227	P05901	Berloque Frida Kahlo Passador Caveira	1
246	LFK-00001	Máscara XYZ	1
258	LFK-00002	Anel Frida Kahlo Flor	1
294	LFK-00004	Máscara Cinza	1
\.


--
-- Name: app_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digituz-dashboard
--

SELECT pg_catalog.setval('public.app_user_id_seq', 5, true);


--
-- Name: customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digituz-dashboard
--

SELECT pg_catalog.setval('public.customer_id_seq', 7, true);


--
-- Name: database_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digituz-dashboard
--

SELECT pg_catalog.setval('public.database_migrations_id_seq', 48, true);


--
-- Name: image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digituz-dashboard
--

SELECT pg_catalog.setval('public.image_id_seq', 793, true);


--
-- Name: inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digituz-dashboard
--

SELECT pg_catalog.setval('public.inventory_id_seq', 2164, true);


--
-- Name: inventory_movement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digituz-dashboard
--

SELECT pg_catalog.setval('public.inventory_movement_id_seq', 1219, true);


--
-- Name: product_composition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digituz-dashboard
--

SELECT pg_catalog.setval('public.product_composition_id_seq', 1, false);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digituz-dashboard
--

SELECT pg_catalog.setval('public.product_id_seq', 231, true);


--
-- Name: product_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digituz-dashboard
--

SELECT pg_catalog.setval('public.product_image_id_seq', 2985, true);


--
-- Name: product_variation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digituz-dashboard
--

SELECT pg_catalog.setval('public.product_variation_id_seq', 516, true);


--
-- Name: sale_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digituz-dashboard
--

SELECT pg_catalog.setval('public.sale_order_id_seq', 49, true);


--
-- Name: sale_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digituz-dashboard
--

SELECT pg_catalog.setval('public.sale_order_item_id_seq', 80, true);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: digituz-dashboard
--

SELECT pg_catalog.setval('public.tag_id_seq', 2559, true);


--
-- Name: database_migrations PK_541706ccec0da007ddb910d07de; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.database_migrations
    ADD CONSTRAINT "PK_541706ccec0da007ddb910d07de" PRIMARY KEY (id);


--
-- Name: app_user app_user_pkey; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);


--
-- Name: customer customer_cpf_key; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_cpf_key UNIQUE (cpf);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- Name: image image_main_filename_key; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_main_filename_key UNIQUE (main_filename);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: inventory_movement inventory_movement_pkey; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.inventory_movement
    ADD CONSTRAINT inventory_movement_pkey PRIMARY KEY (id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (id);


--
-- Name: product_composition product_composition_pkey; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product_composition
    ADD CONSTRAINT product_composition_pkey PRIMARY KEY (id);


--
-- Name: product_image product_image_pkey; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT product_image_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: product product_sku_key; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_sku_key UNIQUE (sku);


--
-- Name: product_variation product_variation_pkey; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product_variation
    ADD CONSTRAINT product_variation_pkey PRIMARY KEY (id);


--
-- Name: product_variation product_variation_sku_key; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product_variation
    ADD CONSTRAINT product_variation_sku_key UNIQUE (sku);


--
-- Name: sale_order_item sale_order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.sale_order_item
    ADD CONSTRAINT sale_order_item_pkey PRIMARY KEY (id);


--
-- Name: sale_order sale_order_pkey; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.sale_order
    ADD CONSTRAINT sale_order_pkey PRIMARY KEY (id);


--
-- Name: tag tag_label_key; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_label_key UNIQUE (label);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: idx_product_composition_product; Type: INDEX; Schema: public; Owner: digituz-dashboard
--

CREATE INDEX idx_product_composition_product ON public.product_composition USING btree (product_id);


--
-- Name: idx_product_product_variation; Type: INDEX; Schema: public; Owner: digituz-dashboard
--

CREATE INDEX idx_product_product_variation ON public.product_variation USING btree (product_id);


--
-- Name: uidx_image_extra_large_file_url; Type: INDEX; Schema: public; Owner: digituz-dashboard
--

CREATE UNIQUE INDEX uidx_image_extra_large_file_url ON public.image USING btree (extra_large_file_url);


--
-- Name: uidx_image_large_file_url; Type: INDEX; Schema: public; Owner: digituz-dashboard
--

CREATE UNIQUE INDEX uidx_image_large_file_url ON public.image USING btree (large_file_url);


--
-- Name: uidx_image_medium_file_url; Type: INDEX; Schema: public; Owner: digituz-dashboard
--

CREATE UNIQUE INDEX uidx_image_medium_file_url ON public.image USING btree (medium_file_url);


--
-- Name: uidx_image_original_file_url; Type: INDEX; Schema: public; Owner: digituz-dashboard
--

CREATE UNIQUE INDEX uidx_image_original_file_url ON public.image USING btree (original_file_url);


--
-- Name: uidx_image_small_file_url; Type: INDEX; Schema: public; Owner: digituz-dashboard
--

CREATE UNIQUE INDEX uidx_image_small_file_url ON public.image USING btree (small_file_url);


--
-- Name: uidx_image_thumbnail_file_url; Type: INDEX; Schema: public; Owner: digituz-dashboard
--

CREATE UNIQUE INDEX uidx_image_thumbnail_file_url ON public.image USING btree (thumbnail_file_url);


--
-- Name: uidx_product_image; Type: INDEX; Schema: public; Owner: digituz-dashboard
--

CREATE UNIQUE INDEX uidx_product_image ON public.product_image USING btree (image_id, product_id);


--
-- Name: uidx_sale_order_reference_code; Type: INDEX; Schema: public; Owner: digituz-dashboard
--

CREATE UNIQUE INDEX uidx_sale_order_reference_code ON public.sale_order USING btree (reference_code);


--
-- Name: image_tag fk_image_tag_image; Type: FK CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.image_tag
    ADD CONSTRAINT fk_image_tag_image FOREIGN KEY (image_id) REFERENCES public.image(id);


--
-- Name: image_tag fk_image_tag_tag; Type: FK CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.image_tag
    ADD CONSTRAINT fk_image_tag_tag FOREIGN KEY (tag_id) REFERENCES public.tag(id);


--
-- Name: inventory_movement fk_inventory_movement_inventory; Type: FK CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.inventory_movement
    ADD CONSTRAINT fk_inventory_movement_inventory FOREIGN KEY (inventory_id) REFERENCES public.inventory(id);


--
-- Name: product_composition fk_product_composition_product; Type: FK CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product_composition
    ADD CONSTRAINT fk_product_composition_product FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: product_composition fk_product_composition_product_variation; Type: FK CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product_composition
    ADD CONSTRAINT fk_product_composition_product_variation FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: product_image fk_product_image_image; Type: FK CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT fk_product_image_image FOREIGN KEY (image_id) REFERENCES public.image(id);


--
-- Name: product_image fk_product_image_product; Type: FK CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product_image
    ADD CONSTRAINT fk_product_image_product FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: product_variation fk_product_product_variation; Type: FK CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.product_variation
    ADD CONSTRAINT fk_product_product_variation FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: inventory_movement inventory_movement_sale_order_fk; Type: FK CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.inventory_movement
    ADD CONSTRAINT inventory_movement_sale_order_fk FOREIGN KEY (sale_order_id) REFERENCES public.sale_order(id);


--
-- Name: inventory inventory_product_variation_fk; Type: FK CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_product_variation_fk FOREIGN KEY (product_variation_id) REFERENCES public.product_variation(id);


--
-- Name: sale_order sale_order_customer; Type: FK CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.sale_order
    ADD CONSTRAINT sale_order_customer FOREIGN KEY (customer_id) REFERENCES public.customer(id);


--
-- Name: sale_order_item sale_order_item_product_variation_fk; Type: FK CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.sale_order_item
    ADD CONSTRAINT sale_order_item_product_variation_fk FOREIGN KEY (product_variation_id) REFERENCES public.product_variation(id);


--
-- Name: sale_order_item sale_order_item_sale_order; Type: FK CONSTRAINT; Schema: public; Owner: digituz-dashboard
--

ALTER TABLE ONLY public.sale_order_item
    ADD CONSTRAINT sale_order_item_sale_order FOREIGN KEY (sale_order_id) REFERENCES public.sale_order(id);


--
-- PostgreSQL database dump complete
--

