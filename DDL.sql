-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION postgres;

-- DROP SEQUENCE public.account_type_id_seq;

CREATE SEQUENCE public.account_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.account_type_id_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.account_type_id_seq TO postgres;

-- DROP SEQUENCE public.accounts_id_seq;

CREATE SEQUENCE public.accounts_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.accounts_id_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.accounts_id_seq TO postgres;

-- DROP SEQUENCE public.customer_id_seq;

CREATE SEQUENCE public.customer_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.customer_id_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.customer_id_seq TO postgres;

-- DROP SEQUENCE public.transaction_status_id_seq;

CREATE SEQUENCE public.transaction_status_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.transaction_status_id_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.transaction_status_id_seq TO postgres;

-- DROP SEQUENCE public.transactions_id_seq;

CREATE SEQUENCE public.transactions_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.transactions_id_seq TO postgres;

-- DROP SEQUENCE public.transactions_type_id_seq;

CREATE SEQUENCE public.transactions_type_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;

-- Permissions

ALTER SEQUENCE public.transactions_type_id_seq OWNER TO postgres;
GRANT ALL ON SEQUENCE public.transactions_type_id_seq TO postgres;
-- public."_prisma_migrations" definition

-- Drop table

-- DROP TABLE public."_prisma_migrations";

CREATE TABLE public."_prisma_migrations" (

);

-- Permissions

ALTER TABLE public."_prisma_migrations" OWNER TO postgres;
GRANT ALL ON TABLE public."_prisma_migrations" TO postgres;


-- public.account_type definition

-- Drop table

-- DROP TABLE public.account_type;

CREATE TABLE public.account_type (
	id serial4 NOT NULL,
	"name" varchar NULL,
	description varchar NULL,
	CONSTRAINT account_type_pkey null
);

-- Permissions

ALTER TABLE public.account_type OWNER TO postgres;
GRANT ALL ON TABLE public.account_type TO postgres;


-- public.customer definition

-- Drop table

-- DROP TABLE public.customer;

CREATE TABLE public.customer (
	id serial4 NOT NULL,
	username varchar NULL,
	"password" varchar NULL,
	email text NULL,
	cpf text NULL,
	address varchar NULL,
	created_at timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp(3) NULL,
	CONSTRAINT customer_pkey null
);

-- Permissions

ALTER TABLE public.customer OWNER TO postgres;
GRANT ALL ON TABLE public.customer TO postgres;


-- public.customer_account definition

-- Drop table

-- DROP TABLE public.customer_account;

CREATE TABLE public.customer_account (

);

-- Permissions

ALTER TABLE public.customer_account OWNER TO postgres;
GRANT ALL ON TABLE public.customer_account TO postgres;


-- public.transaction_status definition

-- Drop table

-- DROP TABLE public.transaction_status;

CREATE TABLE public.transaction_status (
	id serial4 NOT NULL,
	"name" varchar NULL,
	description varchar NULL,
	CONSTRAINT transaction_status_pkey null
);

-- Permissions

ALTER TABLE public.transaction_status OWNER TO postgres;
GRANT ALL ON TABLE public.transaction_status TO postgres;


-- public.transactions_type definition

-- Drop table

-- DROP TABLE public.transactions_type;

CREATE TABLE public.transactions_type (
	id serial4 NOT NULL,
	"name" varchar NULL,
	description varchar NULL,
	CONSTRAINT transactions_type_pkey null
);

-- Permissions

ALTER TABLE public.transactions_type OWNER TO postgres;
GRANT ALL ON TABLE public.transactions_type TO postgres;


-- public.accounts definition

-- Drop table

-- DROP TABLE public.accounts;

CREATE TABLE public.accounts (
	id serial4 NOT NULL,
	type_id int4 NULL,
	balance float8 NOT NULL DEFAULT 0,
	created_at timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP,
	account_number text NULL,
	CONSTRAINT accounts_pkey null,
	CONSTRAINT accounts_type_id_fkey FOREIGN KEY (type_id) REFERENCES public.account_type(id)
);
CREATE UNIQUE INDEX accounts_account_number_key ON public.accounts (account_number text_ops);

-- Permissions

ALTER TABLE public.accounts OWNER TO postgres;
GRANT ALL ON TABLE public.accounts TO postgres;


-- public.transactions definition

-- Drop table

-- DROP TABLE public.transactions;

CREATE TABLE public.transactions (
	id serial4 NOT NULL,
	status_id int4 NULL DEFAULT 1,
	account_id int4 NULL,
	customer_id int4 NULL,
	value float8 NULL,
	created_at timestamp(3) NULL DEFAULT CURRENT_TIMESTAMP,
	transaction_type_id int4 NULL,
	CONSTRAINT transactions_pkey null,
	CONSTRAINT transactions_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(id),
	CONSTRAINT transactions_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(id),
	CONSTRAINT transactions_status_id_fkey FOREIGN KEY (status_id) REFERENCES public.transaction_status(id),
	CONSTRAINT transactions_transaction_type_id_fkey FOREIGN KEY (transaction_type_id) REFERENCES public.transactions_type(id)
);

-- Permissions

ALTER TABLE public.transactions OWNER TO postgres;
GRANT ALL ON TABLE public.transactions TO postgres;




-- Permissions

GRANT ALL ON SCHEMA public TO postgres;
