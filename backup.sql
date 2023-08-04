--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Ubuntu 15.3-1.pgdg23.04+1)
-- Dumped by pg_dump version 15.3 (Ubuntu 15.3-1.pgdg23.04+1)

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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: account_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_type (
    id integer NOT NULL,
    name character varying,
    description character varying
);


ALTER TABLE public.account_type OWNER TO postgres;

--
-- Name: account_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_type_id_seq OWNER TO postgres;

--
-- Name: account_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_type_id_seq OWNED BY public.account_type.id;


--
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id integer NOT NULL,
    type_id integer,
    balance double precision DEFAULT 0 NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    account_number text
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.accounts_id_seq OWNER TO postgres;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    id integer NOT NULL,
    username character varying,
    password character varying,
    email text,
    cpf character varying(11),
    address character varying,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp(3) without time zone
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- Name: customer_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_account (
    customer_id integer NOT NULL,
    account_id integer NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.customer_account OWNER TO postgres;

--
-- Name: customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_id_seq OWNER TO postgres;

--
-- Name: customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_id_seq OWNED BY public.customer.id;


--
-- Name: transaction_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_status (
    id integer NOT NULL,
    name character varying,
    description character varying
);


ALTER TABLE public.transaction_status OWNER TO postgres;

--
-- Name: transaction_status_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaction_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_status_id_seq OWNER TO postgres;

--
-- Name: transaction_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaction_status_id_seq OWNED BY public.transaction_status.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    status_id integer DEFAULT 1,
    account_id integer,
    customer_id integer,
    value double precision,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    transaction_type_id integer
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: transactions_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions_type (
    id integer NOT NULL,
    name character varying,
    description character varying
);


ALTER TABLE public.transactions_type OWNER TO postgres;

--
-- Name: transactions_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_type_id_seq OWNER TO postgres;

--
-- Name: transactions_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_type_id_seq OWNED BY public.transactions_type.id;


--
-- Name: account_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_type ALTER COLUMN id SET DEFAULT nextval('public.account_type_id_seq'::regclass);


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: customer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer ALTER COLUMN id SET DEFAULT nextval('public.customer_id_seq'::regclass);


--
-- Name: transaction_status id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_status ALTER COLUMN id SET DEFAULT nextval('public.transaction_status_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: transactions_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions_type ALTER COLUMN id SET DEFAULT nextval('public.transactions_type_id_seq'::regclass);


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
961f30e4-b6d2-4103-999d-1d7196eb1821	4f947f2e8e5e263a3440b02004b07aa4ffb292b469c7b0804bb0d99952ff4343	2023-08-04 15:45:08.474816-03	0_init	\N	\N	2023-08-04 15:45:08.4521-03	1
97aac9e8-b09b-4d46-a85c-c1c8551ac0f9	b771cf42ef9754ef721d1085214cf8dfa048269dfef6e025c9e3b941e36268ef	2023-08-04 15:45:08.486814-03	20230803225345_update_timestamp	\N	\N	2023-08-04 15:45:08.475964-03	1
f4fa7f8d-7aaa-496c-80ce-001d2ad8acb7	4d5b08288efff6e77b7379c547413ff92f805b6ac0426a7bd34f1d2a60609d8a	2023-08-04 15:45:08.49071-03	20230803231211_colocando_unique	\N	\N	2023-08-04 15:45:08.487816-03	1
6e9e2f00-53c7-4b07-b2cf-8ce829e10359	5805940e4a77ce5fe73b4f0f6512690650f674b4bd746744cf0e4d6bd5c5a425	2023-08-04 15:45:08.494437-03	20230804023206_ajust_balance	\N	\N	2023-08-04 15:45:08.491213-03	1
815deb51-a671-404f-ab82-8a0dfc600dc1	6c3e0eb83c6da3cb35dd18ecb2f1aacd600cf4edfb5fb15a22fee7bcac76bf54	2023-08-04 15:45:08.497835-03	20230804023245_ajust_min_balance	\N	\N	2023-08-04 15:45:08.495162-03	1
bbc75deb-6778-47bd-968c-9ce4b3ef34f4	9f64101d677aa8836ec36f4736d355ee19972ea1f9613a45b72320563bef7c50	2023-08-04 15:45:08.50245-03	20230804024821_changing_the_type_id_to_transaction_type_id	\N	\N	2023-08-04 15:45:08.498656-03	1
80a8d94a-a40a-4508-964e-d70065bebe41	92213296d90da31c14d081eb3bb141dad398bc55c4abc9292eae18da41b0205b	2023-08-04 15:45:08.506712-03	20230804030611_create_account_number_column	\N	\N	2023-08-04 15:45:08.503065-03	1
9dd608ec-7dd2-4596-8e6e-54f1a749486f	49fc83956c16baf7b87d5a91ed4755e303f0c81a98e303eb6912ae4ebee0ced3	2023-08-04 15:45:08.512054-03	20230804184343_update_cpf_digits	\N	\N	2023-08-04 15:45:08.507063-03	1
\.


--
-- Data for Name: account_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_type (id, name, description) FROM stdin;
1	Poupança	A conta poupança é a caderneta. Ela é regulada pelo Banco Central, que define quanto o consumidor receberá pelo dinheiro que guardado na poupança, por exemplo.
2	Corrente	\nA conta corrente é uma conta de depósito, mantida em uma instituição financeira (banco tradicional ou digital), que pode ser individual ou conjunta, gratuita ou com mensalidades, para pessoa física ou pessoa jurídica (empresas).
\.


--
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, type_id, balance, created_at, account_number) FROM stdin;
2	2	500	2023-08-04 19:07:22.657	917371
3	2	200	2023-08-04 19:10:09.134	191379
4	1	200	2023-08-04 20:13:54.48	117826
1	1	3299.96	2023-08-04 18:53:16.11	305867
\.


--
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (id, username, password, email, cpf, address, created_at, updated_at) FROM stdin;
1	Matheus Francisco	123456	matheus@francisco.com	12672631646	Rua prof Nieta Veloso	2023-08-04 18:45:39.644	2023-08-04 18:45:39.644
3	Pedro Soares	12672631646	pedro@gmail.com	12345678910	Rua prof Nieta Veloso	2023-08-04 19:03:52.073	2023-08-04 19:03:52.073
\.


--
-- Data for Name: customer_account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_account (customer_id, account_id, created_at) FROM stdin;
1	1	2023-08-04 18:53:16.122
1	2	2023-08-04 19:07:22.66
3	3	2023-08-04 19:10:09.137
3	4	2023-08-04 20:13:54.485
\.


--
-- Data for Name: transaction_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction_status (id, name, description) FROM stdin;
1	Sucesso	A transação ocorreu com sucesso
2	Falha	Houve Falha na transação
3	Em Processamento	Transação em processamento
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, status_id, account_id, customer_id, value, created_at, transaction_type_id) FROM stdin;
1	3	1	1	699.99	2023-08-04 18:59:35.173	2
2	3	1	1	699.99	2023-08-04 18:59:36.395	2
3	3	4	3	200	2023-08-04 20:13:54.487	2
4	3	1	1	699.99	2023-08-04 21:24:01.74	2
5	3	1	1	699.99	2023-08-04 21:24:04.266	2
\.


--
-- Data for Name: transactions_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions_type (id, name, description) FROM stdin;
1	Saque	Retirou dinheiro da conta
2	Deposito	Depositou dinheiro na conta
\.


--
-- Name: account_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_type_id_seq', 1, false);


--
-- Name: accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_id_seq', 4, true);


--
-- Name: customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_id_seq', 3, true);


--
-- Name: transaction_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaction_status_id_seq', 1, false);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 5, true);


--
-- Name: transactions_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_type_id_seq', 1, false);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: account_type account_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_type
    ADD CONSTRAINT account_type_pkey PRIMARY KEY (id);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: customer_account customer_account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_account
    ADD CONSTRAINT customer_account_pkey PRIMARY KEY (customer_id, account_id);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id);


--
-- Name: transaction_status transaction_status_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_status
    ADD CONSTRAINT transaction_status_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: transactions_type transactions_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions_type
    ADD CONSTRAINT transactions_type_pkey PRIMARY KEY (id);


--
-- Name: accounts_account_number_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX accounts_account_number_key ON public.accounts USING btree (account_number);


--
-- Name: customer_cpf_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX customer_cpf_email_key ON public.customer USING btree (cpf, email);


--
-- Name: customer_cpf_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX customer_cpf_key ON public.customer USING btree (cpf);


--
-- Name: customer_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX customer_email_key ON public.customer USING btree (email);


--
-- Name: accounts accounts_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.account_type(id);


--
-- Name: customer_account customer_account_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_account
    ADD CONSTRAINT customer_account_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: customer_account customer_account_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_account
    ADD CONSTRAINT customer_account_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(id);


--
-- Name: transactions transactions_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: transactions transactions_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(id);


--
-- Name: transactions transactions_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.transaction_status(id);


--
-- Name: transactions transactions_transaction_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_transaction_type_id_fkey FOREIGN KEY (transaction_type_id) REFERENCES public.transactions_type(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

