--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

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
-- Name: aerich; Type: TABLE; Schema: public; Owner: blog_user
--

CREATE TABLE public.aerich (
    id integer NOT NULL,
    version character varying(255) NOT NULL,
    app character varying(100) NOT NULL,
    content jsonb NOT NULL
);


ALTER TABLE public.aerich OWNER TO blog_user;

--
-- Name: aerich_id_seq; Type: SEQUENCE; Schema: public; Owner: blog_user
--

CREATE SEQUENCE public.aerich_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.aerich_id_seq OWNER TO blog_user;

--
-- Name: aerich_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: blog_user
--

ALTER SEQUENCE public.aerich_id_seq OWNED BY public.aerich.id;


--
-- Name: rs_article_tag; Type: TABLE; Schema: public; Owner: blog_user
--

CREATE TABLE public.rs_article_tag (
    tb_article_id uuid NOT NULL,
    tag_id uuid NOT NULL
);


ALTER TABLE public.rs_article_tag OWNER TO blog_user;

--
-- Name: rs_user_tag; Type: TABLE; Schema: public; Owner: blog_user
--

CREATE TABLE public.rs_user_tag (
    tb_user_id uuid NOT NULL,
    tag_id uuid NOT NULL
);


ALTER TABLE public.rs_user_tag OWNER TO blog_user;

--
-- Name: tb_article; Type: TABLE; Schema: public; Owner: blog_user
--

CREATE TABLE public.tb_article (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    title character varying(1024) NOT NULL,
    content text NOT NULL,
    author_id uuid
);


ALTER TABLE public.tb_article OWNER TO blog_user;

--
-- Name: tb_comment; Type: TABLE; Schema: public; Owner: blog_user
--

CREATE TABLE public.tb_comment (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    context text NOT NULL,
    article_id uuid NOT NULL,
    user_id uuid
);


ALTER TABLE public.tb_comment OWNER TO blog_user;

--
-- Name: tb_tag; Type: TABLE; Schema: public; Owner: blog_user
--

CREATE TABLE public.tb_tag (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    name character varying(128) NOT NULL,
    user_id uuid
);


ALTER TABLE public.tb_tag OWNER TO blog_user;

--
-- Name: TABLE tb_tag; Type: COMMENT; Schema: public; Owner: blog_user
--

COMMENT ON TABLE public.tb_tag IS 'The Tag model';


--
-- Name: tb_user; Type: TABLE; Schema: public; Owner: blog_user
--

CREATE TABLE public.tb_user (
    id uuid NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    username character varying(32),
    phone character varying(13),
    password character varying(256) NOT NULL,
    introduction character varying(512),
    avatar character varying(50),
    email character varying(128),
    last_login timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    disabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.tb_user OWNER TO blog_user;

--
-- Name: TABLE tb_user; Type: COMMENT; Schema: public; Owner: blog_user
--

COMMENT ON TABLE public.tb_user IS 'The User model';


--
-- Name: aerich id; Type: DEFAULT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.aerich ALTER COLUMN id SET DEFAULT nextval('public.aerich_id_seq'::regclass);


--
-- Data for Name: aerich; Type: TABLE DATA; Schema: public; Owner: blog_user
--

COPY public.aerich (id, version, app, content) FROM stdin;
1	0_20230803164039_init.py	models	{"models.Tag": {"app": "models", "name": "models.Tag", "table": "tb_tag", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": "<function uuid.uuid4>", "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}, "docstring": "The Tag model", "fk_fields": [], "m2m_fields": [{"name": "users", "unique": false, "default": null, "indexed": false, "through": "rs_user_tag", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": true, "field_type": "ManyToManyFieldInstance", "model_name": "models.User", "constraints": {}, "description": null, "forward_key": "tb_user_id", "python_type": "models.User", "backward_key": "tag_id", "related_name": "tags", "db_constraint": true}, {"name": "tag_articles", "unique": false, "default": null, "indexed": false, "through": "rs_article_tag", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": true, "field_type": "ManyToManyFieldInstance", "model_name": "models.BlogArticle", "constraints": {}, "description": null, "forward_key": "tb_article_id", "python_type": "models.BlogArticle", "backward_key": "tag_id", "related_name": "tags", "db_constraint": true}], "o2o_fields": [], "data_fields": [{"name": "created_at", "unique": false, "default": null, "indexed": false, "auto_now": false, "nullable": false, "db_column": "created_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "updated_at", "unique": false, "default": null, "indexed": false, "auto_now": true, "nullable": false, "db_column": "updated_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "name", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "name", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 128}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(128)"}}], "description": "The Tag model", "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "models.User": {"app": "models", "name": "models.User", "table": "tb_user", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": "<function uuid.uuid4>", "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}, "docstring": "The User model", "fk_fields": [], "m2m_fields": [{"name": "tags", "unique": false, "default": null, "indexed": false, "through": "rs_user_tag", "nullable": true, "docstring": null, "generated": false, "on_delete": "SET NULL", "_generated": false, "field_type": "ManyToManyFieldInstance", "model_name": "models.Tag", "constraints": {}, "description": null, "forward_key": "tag_id", "python_type": "models.Tag", "backward_key": "tb_user_id", "related_name": "users", "db_constraint": true}], "o2o_fields": [], "data_fields": [{"name": "created_at", "unique": false, "default": null, "indexed": false, "auto_now": false, "nullable": false, "db_column": "created_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "updated_at", "unique": false, "default": null, "indexed": false, "auto_now": true, "nullable": false, "db_column": "updated_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "username", "unique": true, "default": null, "indexed": true, "nullable": true, "db_column": "username", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 32}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(32)"}}, {"name": "phone", "unique": false, "default": null, "indexed": true, "nullable": true, "db_column": "phone", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 13}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(13)"}}, {"name": "password", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "password", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 256}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(256)"}}, {"name": "introduction", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "introduction", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 512}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(512)"}}, {"name": "avatar", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "avatar", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 50}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(50)"}}, {"name": "email", "unique": true, "default": null, "indexed": true, "nullable": true, "db_column": "email", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 128}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(128)"}}, {"name": "last_login", "unique": false, "default": null, "indexed": false, "auto_now": true, "nullable": true, "db_column": "last_login", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "disabled", "unique": false, "default": false, "indexed": true, "nullable": false, "db_column": "disabled", "docstring": null, "generated": false, "field_type": "BooleanField", "constraints": {}, "description": null, "python_type": "bool", "db_field_types": {"": "BOOL", "mssql": "BIT", "oracle": "NUMBER(1)", "sqlite": "INT"}}], "description": "The User model", "unique_together": [], "backward_fk_fields": [{"name": "author_articles", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "models.BlogArticle", "db_constraint": true}, {"name": "comments", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "models.Comment", "db_constraint": true}], "backward_o2o_fields": []}, "models.Aerich": {"app": "models", "name": "models.Aerich", "table": "aerich", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "version", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "version", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 255}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(255)"}}, {"name": "app", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "app", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}, {"name": "content", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "content", "docstring": null, "generated": false, "field_type": "JSONField", "constraints": {}, "description": null, "python_type": "Union[dict, list]", "db_field_types": {"": "JSON", "mssql": "NVARCHAR(MAX)", "oracle": "NCLOB", "postgres": "JSONB"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "models.Comment": {"app": "models", "name": "models.Comment", "table": "tb_comment", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": "<function uuid.uuid4>", "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}, "docstring": null, "fk_fields": [{"name": "article", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "raw_field": "article_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "models.BlogArticle", "db_constraint": true}, {"name": "user", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "on_delete": "SET NULL", "raw_field": "user_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "models.User", "db_constraint": true}], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "created_at", "unique": false, "default": null, "indexed": false, "auto_now": false, "nullable": false, "db_column": "created_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "updated_at", "unique": false, "default": null, "indexed": false, "auto_now": true, "nullable": false, "db_column": "updated_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "context", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "context", "docstring": null, "generated": false, "field_type": "TextField", "constraints": {}, "description": null, "python_type": "str", "db_field_types": {"": "TEXT", "mssql": "NVARCHAR(MAX)", "mysql": "LONGTEXT", "oracle": "NCLOB"}}, {"name": "article_id", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "article_id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}, {"name": "user_id", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "user_id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "models.BlogArticle": {"app": "models", "name": "models.BlogArticle", "table": "tb_article", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": "<function uuid.uuid4>", "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}, "docstring": null, "fk_fields": [{"name": "author", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "on_delete": "SET NULL", "raw_field": "author_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "models.User", "db_constraint": true}], "m2m_fields": [{"name": "tags", "unique": false, "default": null, "indexed": false, "through": "rs_article_tag", "nullable": true, "docstring": null, "generated": false, "on_delete": "SET NULL", "_generated": false, "field_type": "ManyToManyFieldInstance", "model_name": "models.Tag", "constraints": {}, "description": null, "forward_key": "tag_id", "python_type": "models.Tag", "backward_key": "tb_article_id", "related_name": "tag_articles", "db_constraint": true}], "o2o_fields": [], "data_fields": [{"name": "created_at", "unique": false, "default": null, "indexed": false, "auto_now": false, "nullable": false, "db_column": "created_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "updated_at", "unique": false, "default": null, "indexed": false, "auto_now": true, "nullable": false, "db_column": "updated_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "title", "unique": false, "default": null, "indexed": true, "nullable": false, "db_column": "title", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 1024}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(1024)"}}, {"name": "content", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "content", "docstring": null, "generated": false, "field_type": "TextField", "constraints": {}, "description": null, "python_type": "str", "db_field_types": {"": "TEXT", "mssql": "NVARCHAR(MAX)", "mysql": "LONGTEXT", "oracle": "NCLOB"}}, {"name": "author_id", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "author_id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}], "description": null, "unique_together": [], "backward_fk_fields": [{"name": "comments", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "models.Comment", "db_constraint": true}], "backward_o2o_fields": []}}
2	1_20231031160256_update.py	models	{"models.Tag": {"app": "models", "name": "models.Tag", "table": "tb_tag", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": "<function uuid.uuid4>", "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}, "docstring": "The Tag model", "fk_fields": [{"name": "user", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "on_delete": "SET NULL", "raw_field": "user_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "models.User", "db_constraint": true}], "m2m_fields": [{"name": "users", "unique": false, "default": null, "indexed": false, "through": "rs_user_tag", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": true, "field_type": "ManyToManyFieldInstance", "model_name": "models.User", "constraints": {}, "description": null, "forward_key": "tb_user_id", "python_type": "models.User", "backward_key": "tag_id", "related_name": "tags", "db_constraint": true}, {"name": "tag_articles", "unique": false, "default": null, "indexed": false, "through": "rs_article_tag", "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "_generated": true, "field_type": "ManyToManyFieldInstance", "model_name": "models.BlogArticle", "constraints": {}, "description": null, "forward_key": "tb_article_id", "python_type": "models.BlogArticle", "backward_key": "tag_id", "related_name": "tags", "db_constraint": true}], "o2o_fields": [], "data_fields": [{"name": "created_at", "unique": false, "default": null, "indexed": false, "auto_now": false, "nullable": false, "db_column": "created_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "updated_at", "unique": false, "default": null, "indexed": false, "auto_now": true, "nullable": false, "db_column": "updated_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "name", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "name", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 128}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(128)"}}, {"name": "user_id", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "user_id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}], "description": "The Tag model", "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "models.User": {"app": "models", "name": "models.User", "table": "tb_user", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": "<function uuid.uuid4>", "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}, "docstring": "The User model", "fk_fields": [], "m2m_fields": [{"name": "tags", "unique": false, "default": null, "indexed": false, "through": "rs_user_tag", "nullable": true, "docstring": null, "generated": false, "on_delete": "SET NULL", "_generated": false, "field_type": "ManyToManyFieldInstance", "model_name": "models.Tag", "constraints": {}, "description": null, "forward_key": "tag_id", "python_type": "models.Tag", "backward_key": "tb_user_id", "related_name": "users", "db_constraint": true}], "o2o_fields": [], "data_fields": [{"name": "created_at", "unique": false, "default": null, "indexed": false, "auto_now": false, "nullable": false, "db_column": "created_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "updated_at", "unique": false, "default": null, "indexed": false, "auto_now": true, "nullable": false, "db_column": "updated_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "username", "unique": true, "default": null, "indexed": true, "nullable": true, "db_column": "username", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 32}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(32)"}}, {"name": "phone", "unique": false, "default": null, "indexed": true, "nullable": true, "db_column": "phone", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 13}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(13)"}}, {"name": "password", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "password", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 256}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(256)"}}, {"name": "introduction", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "introduction", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 512}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(512)"}}, {"name": "avatar", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "avatar", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 50}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(50)"}}, {"name": "email", "unique": true, "default": null, "indexed": true, "nullable": true, "db_column": "email", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 128}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(128)"}}, {"name": "last_login", "unique": false, "default": null, "indexed": false, "auto_now": true, "nullable": true, "db_column": "last_login", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "disabled", "unique": false, "default": false, "indexed": true, "nullable": false, "db_column": "disabled", "docstring": null, "generated": false, "field_type": "BooleanField", "constraints": {}, "description": null, "python_type": "bool", "db_field_types": {"": "BOOL", "mssql": "BIT", "oracle": "NUMBER(1)", "sqlite": "INT"}}], "description": "The User model", "unique_together": [], "backward_fk_fields": [{"name": "created_tags", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "models.Tag", "db_constraint": true}, {"name": "author_articles", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "models.BlogArticle", "db_constraint": true}, {"name": "comments", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "models.Comment", "db_constraint": true}], "backward_o2o_fields": []}, "models.Aerich": {"app": "models", "name": "models.Aerich", "table": "aerich", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": null, "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": true, "field_type": "IntField", "constraints": {"ge": 1, "le": 2147483647}, "description": null, "python_type": "int", "db_field_types": {"": "INT"}}, "docstring": null, "fk_fields": [], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "version", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "version", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 255}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(255)"}}, {"name": "app", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "app", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 100}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(100)"}}, {"name": "content", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "content", "docstring": null, "generated": false, "field_type": "JSONField", "constraints": {}, "description": null, "python_type": "Union[dict, list]", "db_field_types": {"": "JSON", "mssql": "NVARCHAR(MAX)", "oracle": "NCLOB", "postgres": "JSONB"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "models.Comment": {"app": "models", "name": "models.Comment", "table": "tb_comment", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": "<function uuid.uuid4>", "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}, "docstring": null, "fk_fields": [{"name": "article", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "on_delete": "CASCADE", "raw_field": "article_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "models.BlogArticle", "db_constraint": true}, {"name": "user", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "on_delete": "SET NULL", "raw_field": "user_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "models.User", "db_constraint": true}], "m2m_fields": [], "o2o_fields": [], "data_fields": [{"name": "created_at", "unique": false, "default": null, "indexed": false, "auto_now": false, "nullable": false, "db_column": "created_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "updated_at", "unique": false, "default": null, "indexed": false, "auto_now": true, "nullable": false, "db_column": "updated_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "context", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "context", "docstring": null, "generated": false, "field_type": "TextField", "constraints": {}, "description": null, "python_type": "str", "db_field_types": {"": "TEXT", "mssql": "NVARCHAR(MAX)", "mysql": "LONGTEXT", "oracle": "NCLOB"}}, {"name": "article_id", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "article_id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}, {"name": "user_id", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "user_id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}], "description": null, "unique_together": [], "backward_fk_fields": [], "backward_o2o_fields": []}, "models.BlogArticle": {"app": "models", "name": "models.BlogArticle", "table": "tb_article", "indexes": [], "abstract": false, "pk_field": {"name": "id", "unique": true, "default": "<function uuid.uuid4>", "indexed": true, "nullable": false, "db_column": "id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}, "docstring": null, "fk_fields": [{"name": "author", "unique": false, "default": null, "indexed": false, "nullable": true, "docstring": null, "generated": false, "on_delete": "SET NULL", "raw_field": "author_id", "field_type": "ForeignKeyFieldInstance", "constraints": {}, "description": null, "python_type": "models.User", "db_constraint": true}], "m2m_fields": [{"name": "tags", "unique": false, "default": null, "indexed": false, "through": "rs_article_tag", "nullable": true, "docstring": null, "generated": false, "on_delete": "SET NULL", "_generated": false, "field_type": "ManyToManyFieldInstance", "model_name": "models.Tag", "constraints": {}, "description": null, "forward_key": "tag_id", "python_type": "models.Tag", "backward_key": "tb_article_id", "related_name": "tag_articles", "db_constraint": true}], "o2o_fields": [], "data_fields": [{"name": "created_at", "unique": false, "default": null, "indexed": false, "auto_now": false, "nullable": false, "db_column": "created_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "updated_at", "unique": false, "default": null, "indexed": false, "auto_now": true, "nullable": false, "db_column": "updated_at", "docstring": null, "generated": false, "field_type": "DatetimeField", "constraints": {"readOnly": true}, "description": null, "python_type": "datetime.datetime", "auto_now_add": true, "db_field_types": {"": "TIMESTAMP", "mssql": "DATETIME2", "mysql": "DATETIME(6)", "oracle": "TIMESTAMP WITH TIME ZONE", "postgres": "TIMESTAMPTZ"}}, {"name": "title", "unique": false, "default": null, "indexed": true, "nullable": false, "db_column": "title", "docstring": null, "generated": false, "field_type": "CharField", "constraints": {"max_length": 1024}, "description": null, "python_type": "str", "db_field_types": {"": "VARCHAR(1024)"}}, {"name": "content", "unique": false, "default": null, "indexed": false, "nullable": false, "db_column": "content", "docstring": null, "generated": false, "field_type": "TextField", "constraints": {}, "description": null, "python_type": "str", "db_field_types": {"": "TEXT", "mssql": "NVARCHAR(MAX)", "mysql": "LONGTEXT", "oracle": "NCLOB"}}, {"name": "author_id", "unique": false, "default": null, "indexed": false, "nullable": true, "db_column": "author_id", "docstring": null, "generated": false, "field_type": "UUIDField", "constraints": {}, "description": null, "python_type": "uuid.UUID", "db_field_types": {"": "CHAR(36)", "postgres": "UUID"}}], "description": null, "unique_together": [], "backward_fk_fields": [{"name": "comments", "unique": false, "default": null, "indexed": false, "nullable": false, "docstring": null, "generated": false, "field_type": "BackwardFKRelation", "constraints": {}, "description": null, "python_type": "models.Comment", "db_constraint": true}], "backward_o2o_fields": []}}
\.


--
-- Data for Name: rs_article_tag; Type: TABLE DATA; Schema: public; Owner: blog_user
--

COPY public.rs_article_tag (tb_article_id, tag_id) FROM stdin;
45e7cc5e-077e-4eed-b35c-69a9d3bb0543	22efc936-5e6b-4aca-8a30-eea2f32d98ae
45e7cc5e-077e-4eed-b35c-69a9d3bb0543	40302849-0c97-4745-8184-31603d334b7b
9529e7fb-eeeb-4a27-a62e-3b6f87f8f882	5633a4eb-fad8-454f-b9a5-fac0248b83ef
9529e7fb-eeeb-4a27-a62e-3b6f87f8f882	22efc936-5e6b-4aca-8a30-eea2f32d98ae
9529e7fb-eeeb-4a27-a62e-3b6f87f8f882	fcc790dc-af11-4fa7-9082-7910a46108a1
\.


--
-- Data for Name: rs_user_tag; Type: TABLE DATA; Schema: public; Owner: blog_user
--

COPY public.rs_user_tag (tb_user_id, tag_id) FROM stdin;
\.


--
-- Data for Name: tb_article; Type: TABLE DATA; Schema: public; Owner: blog_user
--

COPY public.tb_article (id, created_at, updated_at, title, content, author_id) FROM stdin;
af6d4551-648d-413f-8a2d-8c7edd493b7e	2023-08-05 17:20:21.730185+08	2023-08-05 17:20:21.730197+08	test1	string	fe380025-b30a-4d90-b7f1-42e27697a1e3
b753de85-debd-48e3-9848-146b20ae43bd	2023-10-26 16:09:13.241653+08	2023-10-26 16:09:13.241674+08	test article title string	test article content string	fe380025-b30a-4d90-b7f1-42e27697a1e3
09772340-e942-410b-b587-b64988e4ae2b	2023-10-26 16:22:29.22341+08	2023-10-26 16:22:29.223433+08	test article title string	test article content string	fe380025-b30a-4d90-b7f1-42e27697a1e3
d6a61a03-b239-41e7-b98a-dbc073e8584e	2023-10-26 16:22:30.773262+08	2023-10-26 16:22:30.77328+08	test article title string	test article content string	fe380025-b30a-4d90-b7f1-42e27697a1e3
36bd14fa-080b-4d81-8989-6fe7fc1afd01	2023-10-26 16:22:48.202114+08	2023-10-26 16:22:48.20213+08	test article title string	test article content string	fe380025-b30a-4d90-b7f1-42e27697a1e3
45e7cc5e-077e-4eed-b35c-69a9d3bb0543	2023-10-26 16:28:02.611332+08	2023-10-26 16:28:02.61135+08	test article title string	test article content string	fe380025-b30a-4d90-b7f1-42e27697a1e3
0e37cf7f-f29c-4c5b-8438-8144475fa395	2023-10-31 16:36:49.062798+08	2023-10-31 16:36:49.062814+08	test	test article with tag	fe380025-b30a-4d90-b7f1-42e27697a1e3
9529e7fb-eeeb-4a27-a62e-3b6f87f8f882	2023-10-31 16:53:34.819433+08	2023-10-31 16:53:34.819457+08	好吃的面	今天吃了一碗面, 真的好好吃, 下次还来	fe380025-b30a-4d90-b7f1-42e27697a1e3
\.


--
-- Data for Name: tb_comment; Type: TABLE DATA; Schema: public; Owner: blog_user
--

COPY public.tb_comment (id, created_at, updated_at, context, article_id, user_id) FROM stdin;
dd0a1a58-3ac0-4939-a5a5-2edba9806006	2023-10-31 17:04:12.451711+08	2023-10-31 17:04:12.451734+08	哪一家面啊, 求地址	9529e7fb-eeeb-4a27-a62e-3b6f87f8f882	fe380025-b30a-4d90-b7f1-42e27697a1e3
89525890-97f3-4e50-b4f8-3f31c34440f9	2023-10-31 17:04:29.140219+08	2023-10-31 17:04:29.140239+08	真的吗, 我也想吃	9529e7fb-eeeb-4a27-a62e-3b6f87f8f882	fe380025-b30a-4d90-b7f1-42e27697a1e3
\.


--
-- Data for Name: tb_tag; Type: TABLE DATA; Schema: public; Owner: blog_user
--

COPY public.tb_tag (id, created_at, updated_at, name, user_id) FROM stdin;
40302849-0c97-4745-8184-31603d334b7b	2023-10-31 15:58:33.134835+08	2023-10-31 15:58:33.13488+08	test	fe380025-b30a-4d90-b7f1-42e27697a1e3
22efc936-5e6b-4aca-8a30-eea2f32d98ae	2023-10-31 16:06:04.944454+08	2023-10-31 16:06:04.944475+08	Python	fe380025-b30a-4d90-b7f1-42e27697a1e3
5633a4eb-fad8-454f-b9a5-fac0248b83ef	2023-10-31 16:13:18.085261+08	2023-10-31 16:13:18.085284+08	Golang	fe380025-b30a-4d90-b7f1-42e27697a1e3
61f9ba9b-a7d2-4562-bac3-83aa76552557	2023-10-31 16:13:33.898528+08	2023-10-31 16:13:33.898553+08	生活	fe380025-b30a-4d90-b7f1-42e27697a1e3
f4b8a371-be7e-4176-9d42-bbb6a6105258	2023-10-31 16:13:37.510524+08	2023-10-31 16:13:37.510543+08	日常	fe380025-b30a-4d90-b7f1-42e27697a1e3
fcc790dc-af11-4fa7-9082-7910a46108a1	2023-10-31 16:13:42.770263+08	2023-10-31 16:13:42.770336+08	美食	fe380025-b30a-4d90-b7f1-42e27697a1e3
a21d0219-70a1-4101-a832-2009ef593f3d	2023-10-31 16:13:49.353519+08	2023-10-31 16:13:49.353541+08	考研	fe380025-b30a-4d90-b7f1-42e27697a1e3
adf8c676-9148-4729-a675-6ff7a1f40dcb	2023-10-31 16:13:56.79159+08	2023-10-31 16:13:56.791608+08	爱情	fe380025-b30a-4d90-b7f1-42e27697a1e3
aef9f89c-d87a-4390-914e-f5d3ef5f2aca	2023-10-31 16:14:00.821117+08	2023-10-31 16:14:00.821137+08	闲聊	fe380025-b30a-4d90-b7f1-42e27697a1e3
5630ac39-75f5-4711-ab20-5eee1ce16115	2023-10-31 16:14:10.94858+08	2023-10-31 16:14:10.948599+08	二手	fe380025-b30a-4d90-b7f1-42e27697a1e3
\.


--
-- Data for Name: tb_user; Type: TABLE DATA; Schema: public; Owner: blog_user
--

COPY public.tb_user (id, created_at, updated_at, username, phone, password, introduction, avatar, email, last_login, disabled) FROM stdin;
33c05ea6-aaff-4a93-8f12-7c61ea54877c	2023-08-03 16:51:12.196451+08	2023-08-03 16:51:12.19647+08	test1	\N	$2b$12$KJK/nobxfoKOuwgUMGMxeuso/EwAwc4be3tUuv35m0ltqJSG4Fz0q	\N	\N	\N	2023-08-03 16:51:12.196488+08	f
a8ef305e-56d5-4b82-be8f-4988e45d8990	2023-08-03 16:51:22.586889+08	2023-08-03 16:51:22.586931+08	test2	\N	$2b$12$jWGHUm2rlfLLYh7pKLqPouWmzbdzbblU2BOCy9Hg0hM956zzfgd0q	\N	\N	\N	2023-08-03 16:51:22.586949+08	f
eb285374-c2db-400c-8655-bed54bfec5db	2023-08-05 09:52:14.939395+08	2023-08-05 09:52:14.939412+08	test3	\N	$2b$12$clULW9fLRviVeUFdFvgA0eLb16Ysi2vs0yRj.coYGzb4CD3qGlIlu	\N	\N	\N	2023-08-05 09:52:14.939431+08	f
ca8839de-9552-4dde-b8fd-e64b8cffa2ce	2023-08-05 09:52:45.550391+08	2023-08-05 09:52:45.550408+08	test4	\N	$2b$12$XwQMb4pzK/RcUjoWp/vM1e9uAolyj6cRFzVoc./REBWM0ga6J0mCe	\N	\N	\N	2023-08-05 09:52:45.550425+08	f
706355cb-8f08-4d9f-9200-cea8e1bc5ea5	2023-08-05 09:58:05.809232+08	2023-08-05 09:58:05.80925+08	test5	\N	$2b$12$nT/iQI/7Q7D9ZACobfv3.OXoyygC.FOwhisp02jf0Vb0E7qYKOgr2	\N	\N	\N	2023-08-05 09:58:05.809268+08	f
6965f586-7664-4ec3-8382-6cc1f84870de	2023-08-05 09:59:44.128176+08	2023-08-05 09:59:44.128195+08	test6	\N	$2b$12$8Uu5Gz2hVDYrb2Tdg4Ia9u5vTKLBVMlrcIILKCVALKLP8hk/Uh9ye	\N	\N	\N	2023-08-05 09:59:44.128214+08	f
9309dc0b-3541-4bce-8ebd-8421823dce51	2023-08-05 10:00:23.767478+08	2023-08-05 10:00:23.767494+08	test7	\N	$2b$12$dLUnS04f6MNkQkYVLNZaGeEb1cAwaG79K9o1s21U2VMlrwOg4UKHS	\N	\N	\N	2023-08-05 10:00:23.76751+08	f
8a4298f1-8564-4e9a-adce-f0cb4b591a65	2023-08-03 16:43:47.07386+08	2023-10-26 15:35:06.683561+08	admin	\N	$2b$12$QRBlsHlnk8ZbkK1buH1VHOMsMm.lrSAj8cKl2lZlEJbN8Fvnm7tW2	\N	\N	\N	2023-10-26 15:35:06.683608+08	f
fe380025-b30a-4d90-b7f1-42e27697a1e3	2023-08-05 17:18:02.949687+08	2023-10-26 15:35:28.055904+08	test8	\N	$2b$12$sdeXf262AZJCANcrhsGC7O06j/kiUjnZQovNap0P9HNIGcOomzf22	\N	/static/avatar/default.jpg	\N	2023-10-26 15:35:28.055953+08	f
\.


--
-- Name: aerich_id_seq; Type: SEQUENCE SET; Schema: public; Owner: blog_user
--

SELECT pg_catalog.setval('public.aerich_id_seq', 2, true);


--
-- Name: aerich aerich_pkey; Type: CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.aerich
    ADD CONSTRAINT aerich_pkey PRIMARY KEY (id);


--
-- Name: tb_article tb_article_pkey; Type: CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.tb_article
    ADD CONSTRAINT tb_article_pkey PRIMARY KEY (id);


--
-- Name: tb_comment tb_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.tb_comment
    ADD CONSTRAINT tb_comment_pkey PRIMARY KEY (id);


--
-- Name: tb_tag tb_tag_name_key; Type: CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.tb_tag
    ADD CONSTRAINT tb_tag_name_key UNIQUE (name);


--
-- Name: tb_tag tb_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.tb_tag
    ADD CONSTRAINT tb_tag_pkey PRIMARY KEY (id);


--
-- Name: tb_user tb_user_email_key; Type: CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.tb_user
    ADD CONSTRAINT tb_user_email_key UNIQUE (email);


--
-- Name: tb_user tb_user_pkey; Type: CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.tb_user
    ADD CONSTRAINT tb_user_pkey PRIMARY KEY (id);


--
-- Name: tb_user tb_user_username_key; Type: CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.tb_user
    ADD CONSTRAINT tb_user_username_key UNIQUE (username);


--
-- Name: idx_tb_article_title_408060; Type: INDEX; Schema: public; Owner: blog_user
--

CREATE INDEX idx_tb_article_title_408060 ON public.tb_article USING btree (title);


--
-- Name: idx_tb_tag_name_d5ca4a; Type: INDEX; Schema: public; Owner: blog_user
--

CREATE INDEX idx_tb_tag_name_d5ca4a ON public.tb_tag USING btree (name);


--
-- Name: idx_tb_user_disable_48f3a4; Type: INDEX; Schema: public; Owner: blog_user
--

CREATE INDEX idx_tb_user_disable_48f3a4 ON public.tb_user USING btree (disabled);


--
-- Name: idx_tb_user_email_0311aa; Type: INDEX; Schema: public; Owner: blog_user
--

CREATE INDEX idx_tb_user_email_0311aa ON public.tb_user USING btree (email);


--
-- Name: idx_tb_user_phone_43d442; Type: INDEX; Schema: public; Owner: blog_user
--

CREATE INDEX idx_tb_user_phone_43d442 ON public.tb_user USING btree (phone);


--
-- Name: idx_tb_user_usernam_c58054; Type: INDEX; Schema: public; Owner: blog_user
--

CREATE INDEX idx_tb_user_usernam_c58054 ON public.tb_user USING btree (username);


--
-- Name: tb_tag fk_tb_tag_tb_user_34e7a09b; Type: FK CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.tb_tag
    ADD CONSTRAINT fk_tb_tag_tb_user_34e7a09b FOREIGN KEY (user_id) REFERENCES public.tb_user(id) ON DELETE SET NULL;


--
-- Name: rs_article_tag rs_article_tag_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.rs_article_tag
    ADD CONSTRAINT rs_article_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tb_tag(id) ON DELETE SET NULL;


--
-- Name: rs_article_tag rs_article_tag_tb_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.rs_article_tag
    ADD CONSTRAINT rs_article_tag_tb_article_id_fkey FOREIGN KEY (tb_article_id) REFERENCES public.tb_article(id) ON DELETE SET NULL;


--
-- Name: rs_user_tag rs_user_tag_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.rs_user_tag
    ADD CONSTRAINT rs_user_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tb_tag(id) ON DELETE SET NULL;


--
-- Name: rs_user_tag rs_user_tag_tb_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.rs_user_tag
    ADD CONSTRAINT rs_user_tag_tb_user_id_fkey FOREIGN KEY (tb_user_id) REFERENCES public.tb_user(id) ON DELETE SET NULL;


--
-- Name: tb_article tb_article_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.tb_article
    ADD CONSTRAINT tb_article_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.tb_user(id) ON DELETE SET NULL;


--
-- Name: tb_comment tb_comment_article_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.tb_comment
    ADD CONSTRAINT tb_comment_article_id_fkey FOREIGN KEY (article_id) REFERENCES public.tb_article(id) ON DELETE CASCADE;


--
-- Name: tb_comment tb_comment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: blog_user
--

ALTER TABLE ONLY public.tb_comment
    ADD CONSTRAINT tb_comment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.tb_user(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

