--
-- Matchmakers Tables
-- This file contains all tables from the matchmakers schema
--

CREATE TABLE matchmakers.matchmakers (
    short_description character varying,
    population jsonb,
    experience smallint,
    location jsonb,
    attributes jsonb,
    status smallint DEFAULT 1 NOT NULL,
    created timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    busy_until timestamp with time zone,
    user_id bigint NOT NULL,
    id bigint NOT NULL,
    brand_id smallint
);

CREATE TABLE matchmakers.mm_logs (
    id bigint NOT NULL,
    introduction_id bigint NOT NULL,
    mm_id bigint NOT NULL,
    type character varying,
    created timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    content jsonb
);

CREATE TABLE matchmakers.single_types (
    id smallint NOT NULL,
    title character varying NOT NULL,
    type smallint NOT NULL,
    gender boolean
);

COMMENT ON COLUMN matchmakers.single_types.type IS '1 - Age range
2 - Single plan
3 - Single type
4 - Experience'; 