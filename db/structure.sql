SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: daily_high_lows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.daily_high_lows (
    id bigint NOT NULL,
    one_month_high integer NOT NULL,
    one_month_low integer NOT NULL,
    three_month_high integer NOT NULL,
    three_month_low integer NOT NULL,
    six_month_high integer NOT NULL,
    six_month_low integer NOT NULL,
    fifty_two_week_high integer NOT NULL,
    fifty_two_week_low integer NOT NULL,
    all_time_high integer NOT NULL,
    all_time_low integer NOT NULL,
    year_to_date_high integer NOT NULL,
    year_to_date_low integer NOT NULL,
    market_close_date date NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: daily_high_lows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.daily_high_lows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: daily_high_lows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.daily_high_lows_id_seq OWNED BY public.daily_high_lows.id;


--
-- Name: market_monitors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.market_monitors (
    id bigint NOT NULL,
    market_close_date date NOT NULL,
    up_four_pct_daily integer NOT NULL,
    down_four_pct_daily integer NOT NULL,
    up_twenty_five_pct_quarter integer NOT NULL,
    down_twenty_five_pct_quarter integer NOT NULL,
    up_twenty_five_pct_month integer NOT NULL,
    down_twenty_five_pct_month integer NOT NULL,
    up_thirteen_pct_quarter integer NOT NULL,
    down_thirteen_pct_quarter integer NOT NULL,
    up_fifty_pct_month integer NOT NULL,
    down_fifty_pct_month integer NOT NULL,
    total_stocks integer NOT NULL,
    notes text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: market_monitors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.market_monitors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: market_monitors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.market_monitors_id_seq OWNED BY public.market_monitors.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: stock_price_histories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stock_price_histories (
    id bigint NOT NULL,
    market_close_date date NOT NULL,
    ticker character varying NOT NULL,
    company_name character varying,
    open numeric(16,4) NOT NULL,
    high numeric(16,4) NOT NULL,
    low numeric(16,4) NOT NULL,
    close numeric(16,4) NOT NULL,
    last_price numeric(16,4) NOT NULL,
    percent_change numeric(16,4) NOT NULL,
    net_change numeric(16,4) NOT NULL,
    volume integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: stock_price_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stock_price_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_price_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stock_price_histories_id_seq OWNED BY public.stock_price_histories.id;


--
-- Name: stock_symbols; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stock_symbols (
    id bigint NOT NULL,
    ticker character varying NOT NULL,
    company_name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: stock_symbols_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stock_symbols_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_symbols_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stock_symbols_id_seq OWNED BY public.stock_symbols.id;


--
-- Name: daily_high_lows id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_high_lows ALTER COLUMN id SET DEFAULT nextval('public.daily_high_lows_id_seq'::regclass);


--
-- Name: market_monitors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.market_monitors ALTER COLUMN id SET DEFAULT nextval('public.market_monitors_id_seq'::regclass);


--
-- Name: stock_price_histories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_price_histories ALTER COLUMN id SET DEFAULT nextval('public.stock_price_histories_id_seq'::regclass);


--
-- Name: stock_symbols id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_symbols ALTER COLUMN id SET DEFAULT nextval('public.stock_symbols_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: daily_high_lows daily_high_lows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daily_high_lows
    ADD CONSTRAINT daily_high_lows_pkey PRIMARY KEY (id);


--
-- Name: market_monitors market_monitors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.market_monitors
    ADD CONSTRAINT market_monitors_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: stock_price_histories stock_price_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_price_histories
    ADD CONSTRAINT stock_price_histories_pkey PRIMARY KEY (id);


--
-- Name: stock_symbols stock_symbols_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock_symbols
    ADD CONSTRAINT stock_symbols_pkey PRIMARY KEY (id);


--
-- Name: index_daily_high_lows_on_market_close_date; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_daily_high_lows_on_market_close_date ON public.daily_high_lows USING btree (market_close_date);


--
-- Name: index_market_monitors_on_market_close_date; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_market_monitors_on_market_close_date ON public.market_monitors USING btree (market_close_date);


--
-- Name: index_stock_price_histories_on_market_close_date_and_ticker; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_stock_price_histories_on_market_close_date_and_ticker ON public.stock_price_histories USING btree (market_close_date, ticker);


--
-- Name: index_stock_symbols_on_ticker; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_stock_symbols_on_ticker ON public.stock_symbols USING btree (ticker);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20180405213314'),
('20180408235540'),
('20180409232316'),
('20180501212325');


