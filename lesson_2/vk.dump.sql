--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2 (Debian 15.2-1.pgdg110+1)

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
-- Name: friendship_statuses_enum; Type: TYPE; Schema: public; Owner: vk_user
--

CREATE TYPE public.friendship_statuses_enum AS ENUM (
    'requested',
    'confirmed',
    'rejected'
);


ALTER TYPE public.friendship_statuses_enum OWNER TO vk_user;

--
-- Name: subscriptions_target_enum; Type: TYPE; Schema: public; Owner: vk_user
--

CREATE TYPE public.subscriptions_target_enum AS ENUM (
    'user',
    'community'
);


ALTER TYPE public.subscriptions_target_enum OWNER TO vk_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: communities; Type: TABLE; Schema: public; Owner: vk_user
--

CREATE TABLE public.communities (
    id integer NOT NULL,
    name character varying(120),
    creator_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.communities OWNER TO vk_user;

--
-- Name: communities_id_seq; Type: SEQUENCE; Schema: public; Owner: vk_user
--

CREATE SEQUENCE public.communities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.communities_id_seq OWNER TO vk_user;

--
-- Name: communities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vk_user
--

ALTER SEQUENCE public.communities_id_seq OWNED BY public.communities.id;


--
-- Name: communities_users; Type: TABLE; Schema: public; Owner: vk_user
--

CREATE TABLE public.communities_users (
    community_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.communities_users OWNER TO vk_user;

--
-- Name: friendship; Type: TABLE; Schema: public; Owner: vk_user
--

CREATE TABLE public.friendship (
    id integer NOT NULL,
    requested_by_user_id integer NOT NULL,
    requested_to_user_id integer NOT NULL,
    status public.friendship_statuses_enum DEFAULT 'requested'::public.friendship_statuses_enum NOT NULL,
    requested_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    confirmed_at timestamp without time zone
);


ALTER TABLE public.friendship OWNER TO vk_user;

--
-- Name: friendship_id_seq; Type: SEQUENCE; Schema: public; Owner: vk_user
--

CREATE SEQUENCE public.friendship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendship_id_seq OWNER TO vk_user;

--
-- Name: friendship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vk_user
--

ALTER SEQUENCE public.friendship_id_seq OWNED BY public.friendship.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: vk_user
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL,
    body text,
    is_important boolean,
    is_delivered boolean,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.messages OWNER TO vk_user;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: vk_user
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO vk_user;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vk_user
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: photo; Type: TABLE; Schema: public; Owner: vk_user
--

CREATE TABLE public.photo (
    id integer NOT NULL,
    url character varying(250) NOT NULL,
    owner_id integer NOT NULL,
    description character varying(250) NOT NULL,
    uploaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    size integer NOT NULL
);


ALTER TABLE public.photo OWNER TO vk_user;

--
-- Name: photo_id_seq; Type: SEQUENCE; Schema: public; Owner: vk_user
--

CREATE SEQUENCE public.photo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photo_id_seq OWNER TO vk_user;

--
-- Name: photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vk_user
--

ALTER SEQUENCE public.photo_id_seq OWNED BY public.photo.id;


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: vk_user
--

CREATE TABLE public.subscriptions (
    id integer NOT NULL,
    subscriber_id integer NOT NULL,
    subscribed_to_id integer NOT NULL,
    subscription_target public.subscriptions_target_enum NOT NULL
);


ALTER TABLE public.subscriptions OWNER TO vk_user;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: vk_user
--

CREATE SEQUENCE public.subscriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscriptions_id_seq OWNER TO vk_user;

--
-- Name: subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vk_user
--

ALTER SEQUENCE public.subscriptions_id_seq OWNED BY public.subscriptions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: vk_user
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(120) NOT NULL,
    phone character varying(15),
    main_photo_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.users OWNER TO vk_user;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: vk_user
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO vk_user;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vk_user
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: video; Type: TABLE; Schema: public; Owner: vk_user
--

CREATE TABLE public.video (
    id integer NOT NULL,
    url character varying(250) NOT NULL,
    owner_id integer NOT NULL,
    description character varying(250) NOT NULL,
    uploaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    size integer NOT NULL
);


ALTER TABLE public.video OWNER TO vk_user;

--
-- Name: video_id_seq; Type: SEQUENCE; Schema: public; Owner: vk_user
--

CREATE SEQUENCE public.video_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.video_id_seq OWNER TO vk_user;

--
-- Name: video_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vk_user
--

ALTER SEQUENCE public.video_id_seq OWNED BY public.video.id;


--
-- Name: communities id; Type: DEFAULT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.communities ALTER COLUMN id SET DEFAULT nextval('public.communities_id_seq'::regclass);


--
-- Name: friendship id; Type: DEFAULT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.friendship ALTER COLUMN id SET DEFAULT nextval('public.friendship_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: photo id; Type: DEFAULT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.photo ALTER COLUMN id SET DEFAULT nextval('public.photo_id_seq'::regclass);


--
-- Name: subscriptions id; Type: DEFAULT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.subscriptions ALTER COLUMN id SET DEFAULT nextval('public.subscriptions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: video id; Type: DEFAULT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.video ALTER COLUMN id SET DEFAULT nextval('public.video_id_seq'::regclass);


--
-- Data for Name: communities; Type: TABLE DATA; Schema: public; Owner: vk_user
--

COPY public.communities (id, name, creator_id, created_at) FROM stdin;
1	risus. Nulla eget metus	99	2020-01-08 20:35:37
2	velit. Pellentesque ultricies	38	2020-06-27 13:15:47
3	Proin vel nisl. Quisque	32	2019-05-13 03:07:20
4	nonummy. Fusce	37	2022-07-13 18:16:35
5	enim,  sit amet ornare lectus	25	2022-03-19 16:21:16
6	erat. Vivamus nisi. Mauris	28	2021-02-10 22:23:18
7	purus,  in molestie	20	2017-07-15 00:27:15
8	sit	12	2019-08-08 20:02:41
9	dolor vitae	85	2023-01-25 12:27:28
10	metus. Vivamus	84	2018-09-02 15:36:41
11	viverra. Maecenas iaculis aliquet diam.	18	2018-07-02 09:51:51
12	sit enim	86	2019-09-03 13:53:29
13	In scelerisque scelerisque	64	2021-01-16 04:01:34
14	sagittis augue,  eu tempor erat	71	2018-11-16 21:03:49
15	ipsum. Curabitur consequat, 	96	2020-08-06 00:01:33
16	arcu imperdiet ullamcorper.	67	2020-06-26 11:54:21
17	libero. Integer	60	2018-11-13 01:40:52
18	Morbi vehicula.	68	2020-08-13 13:30:14
19	egestas hendrerit	99	2023-01-25 14:27:37
20	Aliquam	15	2019-06-03 17:14:50
21	vestibulum nec, 	100	2020-07-24 07:09:32
22	Duis at	81	2023-02-10 21:01:25
23	tellus sem mollis	94	2022-04-05 08:48:10
24	diam lorem, 	4	2020-11-28 17:19:43
25	erat semper	22	2017-07-10 14:18:30
26	sem. Nulla interdum.	48	2023-01-10 17:00:48
27	arcu. Sed eu	28	2020-02-21 22:29:20
28	aliquet magna a	79	2018-03-27 11:00:15
29	nec tellus. Nunc lectus pede, 	41	2018-05-20 19:21:09
30	vulputate dui,  nec	24	2022-03-17 14:10:34
31	eget metus	91	2022-10-17 13:04:20
32	ipsum. Donec sollicitudin adipiscing	97	2020-08-13 13:26:45
33	in molestie tortor nibh	36	2020-11-06 09:29:39
34	magna,  malesuada vel, 	68	2021-07-04 23:15:26
35	elit, 	21	2017-06-27 08:28:43
36	ornare placerat,  orci	79	2022-07-31 13:10:04
37	Praesent interdum ligula	97	2020-11-27 00:17:12
38	ultricies sem magna nec	90	2019-12-13 13:25:47
39	volutpat nunc sit	59	2020-12-20 12:33:47
40	facilisis. Suspendisse commodo tincidunt nibh.	27	2017-06-17 19:45:50
41	ipsum non arcu. Vivamus sit	89	2020-02-26 20:24:37
42	magnis dis parturient montes, 	52	2022-03-23 00:29:00
43	Pellentesque ultricies dignissim	94	2022-02-09 18:51:47
44	lacus. Quisque purus sapien, 	60	2017-08-03 04:22:32
45	lacus. Cras	61	2018-05-23 13:14:36
46	Donec	80	2017-06-21 02:46:55
47	magna a	64	2017-10-29 12:57:17
48	Lorem ipsum dolor sit	89	2017-08-07 16:56:44
49	cursus	65	2019-09-20 14:44:02
50	elit sed consequat auctor,  nunc	28	2021-01-12 09:46:03
51	cubilia Curae Donec tincidunt.	21	2023-03-16 12:29:53
52	sapien. Nunc	30	2021-04-15 04:28:54
53	quis urna. Nunc	55	2017-12-09 07:53:13
54	ut odio	61	2021-05-23 23:04:08
55	Nunc sollicitudin commodo	6	2022-10-08 06:40:38
56	dui quis accumsan	74	2019-08-11 06:27:56
57	adipiscing	25	2020-01-30 05:56:08
58	nisi nibh	98	2021-03-03 02:40:00
59	In condimentum. Donec	84	2019-05-31 01:42:25
60	nascetur ridiculus mus. Proin	36	2021-07-05 23:27:23
61	enim,  gravida sit	30	2019-01-07 19:13:28
62	aliquam adipiscing	88	2020-10-21 02:21:46
63	ac turpis egestas.	26	2022-03-13 00:18:28
64	est arcu ac	13	2023-03-11 20:50:12
65	velit. Aliquam	35	2022-03-27 05:11:46
66	eros. Proin ultrices. Duis	47	2017-04-27 08:08:07
67	Vivamus	78	2021-01-13 10:56:14
68	vitae,  erat. Vivamus	74	2017-07-24 12:00:44
69	ante dictum mi,  ac	8	2021-08-22 02:33:13
70	eu enim.	34	2018-09-19 20:19:56
71	tincidunt,  nunc ac mattis	12	2017-07-31 13:07:57
72	Pellentesque habitant morbi tristique	28	2021-10-15 09:44:38
73	senectus et netus et malesuada	15	2022-08-11 14:34:34
74	Duis sit amet diam	82	2021-07-03 02:58:03
75	id risus	84	2020-04-13 00:11:11
76	pede,  nonummy ut, 	20	2021-05-11 00:08:27
77	quis massa. Mauris	6	2020-01-23 02:01:29
78	eu metus.	20	2022-05-11 23:58:13
79	adipiscing elit. Etiam laoreet, 	77	2022-03-22 17:58:29
80	non,  sollicitudin	20	2019-10-16 23:45:49
81	netus et	69	2022-03-24 17:22:39
82	gravida sagittis. Duis	67	2022-04-30 08:43:12
83	lorem,  auctor quis,  tristique ac, 	13	2021-05-26 09:49:55
84	dolor. Fusce	39	2017-12-13 20:55:21
85	nisi a odio semper	36	2019-03-04 21:52:49
86	ut dolor dapibus gravida.	94	2021-07-21 09:44:23
87	pede,  nonummy	5	2022-09-07 00:51:18
88	vestibulum lorem, 	23	2021-09-08 08:51:55
89	accumsan laoreet	58	2018-03-08 02:49:29
90	felis orci, 	89	2017-09-03 17:05:16
91	metus vitae velit	56	2021-08-23 11:59:46
92	molestie orci tincidunt	17	2018-07-26 04:37:44
93	purus,  accumsan	38	2017-06-07 17:28:41
94	sem egestas blandit.	72	2020-01-27 03:43:57
95	ornare sagittis felis. Donec tempor, 	46	2019-01-01 07:41:37
96	Mauris magna. Duis dignissim	48	2019-11-30 00:59:33
97	Nunc pulvinar	52	2018-02-15 05:37:04
98	velit egestas lacinia. Sed congue, 	52	2020-09-16 09:02:33
99	nibh	83	2022-03-24 17:56:18
100	fames ac turpis egestas.	94	2018-11-08 08:39:40
\.


--
-- Data for Name: communities_users; Type: TABLE DATA; Schema: public; Owner: vk_user
--

COPY public.communities_users (community_id, user_id, created_at) FROM stdin;
49	41	2018-08-03 02:52:16
86	27	2023-02-11 13:13:32
54	89	2020-11-01 18:59:28
51	23	2017-06-27 02:36:25
73	88	2021-12-08 21:23:39
82	73	2021-05-10 17:14:10
4	27	2022-09-02 05:13:21
25	84	2022-05-10 03:01:24
72	42	2020-04-14 07:03:33
10	41	2019-08-29 10:19:02
67	2	2022-05-13 06:24:42
14	27	2022-11-04 13:14:22
2	53	2022-07-05 15:09:50
20	18	2020-09-20 04:01:22
44	1	2020-12-25 12:41:38
15	59	2019-12-23 15:56:11
57	90	2022-10-02 08:54:09
96	38	2020-11-20 17:26:13
28	71	2023-01-08 14:43:49
42	5	2017-06-09 00:00:02
31	41	2019-01-30 18:40:17
30	14	2020-06-12 11:07:22
96	16	2022-03-30 19:41:10
43	90	2022-07-27 03:18:14
85	48	2018-04-22 07:25:20
44	89	2019-01-08 11:33:48
26	37	2020-08-10 00:41:23
29	39	2018-11-21 02:07:05
94	79	2019-06-15 23:38:38
62	98	2022-04-15 15:23:59
89	94	2023-04-14 00:20:46
24	36	2018-04-13 15:23:51
10	43	2022-04-28 02:02:24
54	85	2019-12-06 00:50:53
15	39	2020-07-30 06:34:18
23	54	2018-09-05 11:56:25
6	61	2018-11-17 21:28:09
68	65	2019-07-31 13:12:24
12	32	2020-02-21 10:06:53
72	29	2023-03-11 01:37:32
5	58	2017-08-28 21:11:04
59	84	2021-04-02 16:09:31
5	86	2020-11-08 23:27:18
38	22	2022-04-25 21:40:04
89	80	2021-10-13 17:29:19
55	15	2019-05-29 15:44:59
74	11	2018-09-11 17:16:06
39	56	2020-08-08 18:54:11
82	14	2021-02-09 11:10:38
89	30	2017-08-09 00:46:09
4	21	2020-01-05 05:52:30
42	81	2022-11-14 09:03:11
71	78	2021-04-29 02:46:40
13	52	2018-02-18 08:41:47
9	62	2023-04-14 17:29:52
62	83	2017-11-07 15:07:59
57	55	2022-04-28 15:29:17
13	5	2023-01-22 02:33:29
77	79	2022-05-26 08:19:02
24	69	2018-05-07 02:36:14
3	99	2022-08-20 23:17:51
49	38	2021-06-20 19:23:22
18	82	2019-10-07 00:08:39
27	12	2019-11-17 16:21:44
91	8	2019-11-08 16:34:24
23	71	2021-07-11 19:46:27
58	50	2019-04-05 07:35:40
62	84	2018-05-18 18:56:21
97	20	2022-09-28 12:54:14
39	54	2020-08-04 03:52:38
92	49	2017-12-22 14:13:31
90	46	2019-11-18 09:08:43
80	59	2020-01-06 10:24:26
51	78	2020-09-28 17:13:05
32	93	2020-11-12 22:21:07
35	50	2018-11-20 14:15:58
5	92	2019-08-03 20:58:33
87	52	2020-11-19 01:17:47
79	55	2021-04-12 00:32:15
7	83	2017-05-07 13:14:24
97	97	2021-04-09 21:07:18
64	90	2022-12-03 10:44:13
30	41	2022-02-10 02:08:43
65	92	2020-12-29 23:46:34
75	23	2021-05-20 07:58:20
49	91	2023-01-19 03:51:12
32	56	2017-09-14 15:10:24
40	25	2022-11-28 14:37:49
61	14	2020-02-09 08:29:19
76	44	2017-06-10 11:46:03
16	17	2020-04-15 21:13:41
70	4	2019-07-16 05:38:54
55	56	2018-12-03 13:16:40
49	12	2020-04-03 16:46:42
56	91	2021-05-17 21:55:18
76	78	2021-06-28 04:38:53
34	45	2020-06-06 06:11:31
36	33	2022-12-18 16:05:39
78	83	2018-12-08 15:14:40
52	6	2020-04-11 07:36:19
\.


--
-- Data for Name: friendship; Type: TABLE DATA; Schema: public; Owner: vk_user
--

COPY public.friendship (id, requested_by_user_id, requested_to_user_id, status, requested_at, confirmed_at) FROM stdin;
1	37	55	confirmed	2018-09-18 22:15:16	2020-09-11 20:41:26
2	23	83	requested	2018-08-28 15:15:45	2019-02-22 06:26:27
3	77	31	rejected	2020-03-09 20:19:10	2019-07-14 07:34:54
4	39	59	requested	2019-10-13 15:16:20	2021-03-07 16:56:22
5	59	36	rejected	2022-07-10 22:02:59	2017-10-06 17:52:37
6	53	48	confirmed	2022-07-03 00:23:46	2018-06-23 07:16:56
7	38	87	requested	2022-02-17 19:18:29	2017-09-02 02:56:45
8	39	3	confirmed	2021-11-09 03:21:17	2020-03-19 00:17:55
9	82	90	confirmed	2022-05-12 13:56:03	2022-03-03 11:21:55
10	43	13	confirmed	2021-02-16 19:52:07	2020-10-13 00:50:56
11	7	67	confirmed	2022-06-15 18:57:05	2018-01-14 18:04:10
12	34	2	requested	2017-07-04 19:36:51	2019-01-13 08:03:24
13	59	97	confirmed	2017-07-25 06:28:24	2022-11-21 05:54:46
14	3	86	rejected	2019-08-11 23:13:01	2017-07-25 00:50:41
15	25	92	requested	2023-04-04 21:58:40	2019-06-09 19:30:11
16	64	87	confirmed	2020-12-25 21:19:48	2019-06-17 10:26:06
17	45	22	rejected	2022-05-16 07:19:05	2019-09-24 12:30:27
18	3	90	confirmed	2018-02-23 22:55:07	2020-05-21 16:25:53
19	88	5	requested	2019-12-05 14:28:41	2023-01-12 21:28:25
20	66	65	confirmed	2023-01-21 16:19:26	2022-02-12 18:01:03
21	60	36	confirmed	2019-11-03 18:02:05	2019-03-16 11:21:39
22	62	82	confirmed	2019-06-13 16:50:52	2021-05-01 01:56:27
23	37	55	requested	2019-02-06 04:26:51	2017-05-04 01:22:27
24	44	32	rejected	2020-06-05 14:34:03	2023-01-25 06:01:32
25	42	90	confirmed	2020-12-20 10:34:25	2017-11-24 01:50:24
26	81	99	rejected	2017-11-07 23:37:55	2020-12-23 06:33:48
27	55	53	confirmed	2018-10-17 14:40:03	2018-08-22 00:26:35
28	20	24	rejected	2020-08-28 18:42:48	2021-07-11 02:09:40
29	52	64	requested	2017-06-02 07:38:01	2020-06-26 23:38:24
30	39	90	confirmed	2018-05-04 06:52:57	2020-07-28 14:25:45
31	6	12	requested	2021-11-28 13:33:52	2018-07-28 05:26:20
32	4	74	requested	2018-03-06 03:27:49	2018-12-09 06:57:50
33	5	79	confirmed	2017-07-01 03:43:52	2020-08-09 16:16:09
34	96	91	rejected	2020-07-26 02:59:37	2020-06-27 22:36:21
35	31	86	confirmed	2021-02-09 17:56:39	2022-05-23 06:45:21
36	5	50	rejected	2021-05-10 06:25:14	2018-06-27 05:10:06
37	45	30	requested	2020-06-25 07:12:35	2020-07-22 03:06:27
38	33	54	rejected	2021-02-14 21:24:29	2017-11-12 07:54:50
39	8	69	confirmed	2022-10-11 13:36:43	2022-12-15 23:04:56
40	46	96	confirmed	2017-10-30 05:24:29	2017-12-13 18:55:38
41	26	23	confirmed	2023-01-25 19:37:21	2017-10-28 18:09:05
42	58	15	requested	2021-03-26 15:08:59	2022-01-17 12:32:48
43	79	51	confirmed	2021-06-07 17:13:43	2018-02-10 19:32:30
44	54	79	requested	2018-11-26 02:26:25	2021-04-20 00:46:03
45	89	98	requested	2019-07-27 16:59:21	2020-10-13 02:28:08
46	20	17	confirmed	2020-07-24 23:46:54	2021-01-19 18:57:16
47	85	67	rejected	2020-04-18 08:43:07	2019-06-01 08:34:57
48	22	12	confirmed	2020-09-25 04:52:03	2022-11-19 12:22:19
49	90	70	confirmed	2019-06-26 01:34:30	2021-06-23 11:14:56
50	68	93	confirmed	2021-12-28 16:55:35	2020-06-13 07:18:28
51	98	89	confirmed	2018-06-22 00:56:34	2021-06-01 09:28:04
52	69	21	requested	2022-09-30 20:17:09	2019-12-11 06:59:48
53	94	78	confirmed	2018-05-31 09:02:19	2022-01-11 02:08:02
54	83	56	confirmed	2021-09-10 02:03:41	2022-08-02 16:20:36
55	50	19	confirmed	2021-05-31 05:44:19	2022-08-24 04:22:30
56	49	97	requested	2023-03-25 23:12:59	2021-01-13 19:02:52
57	23	15	rejected	2018-06-29 19:51:59	2018-09-07 02:15:36
58	74	13	requested	2017-07-17 21:11:37	2021-10-19 16:13:48
59	13	62	confirmed	2018-10-08 19:24:41	2018-03-17 21:01:22
60	45	83	rejected	2020-03-17 23:01:33	2018-10-01 08:08:17
61	76	27	confirmed	2020-07-06 09:13:29	2021-04-25 22:14:40
62	28	68	rejected	2021-11-08 00:13:08	2019-11-13 07:57:33
63	31	79	requested	2017-11-01 02:08:23	2022-05-22 17:48:00
64	72	48	rejected	2021-04-30 09:57:34	2020-05-25 11:27:37
65	55	80	requested	2023-04-05 08:29:25	2021-08-29 04:18:53
66	75	84	confirmed	2019-09-06 12:17:57	2021-06-25 21:30:41
67	28	85	requested	2018-12-08 13:14:59	2020-12-18 07:39:19
68	22	2	confirmed	2020-11-17 12:45:38	2021-07-23 17:29:53
69	82	24	rejected	2020-10-04 23:57:22	2019-03-25 16:36:26
70	32	25	confirmed	2022-06-30 13:09:19	2021-07-27 07:08:21
71	6	98	requested	2021-05-09 09:23:03	2022-03-24 23:37:03
72	58	19	rejected	2018-12-18 08:27:40	2021-06-18 06:30:59
73	81	51	confirmed	2019-11-15 08:51:08	2020-04-15 12:11:32
74	100	30	requested	2019-05-07 02:56:28	2021-06-09 22:23:42
75	89	21	requested	2020-05-28 22:26:43	2019-12-14 16:54:38
76	11	38	confirmed	2017-07-16 22:30:59	2023-03-11 08:51:06
77	40	38	confirmed	2018-01-19 00:42:32	2022-08-07 18:34:45
78	93	20	confirmed	2018-11-08 00:41:04	2021-07-16 16:44:07
79	29	52	confirmed	2019-07-02 10:28:46	2018-12-30 21:21:27
80	23	77	requested	2017-10-16 20:27:01	2018-11-27 09:16:15
81	64	73	confirmed	2021-05-31 02:22:00	2018-08-28 05:24:55
82	99	57	rejected	2019-02-06 17:01:10	2023-02-09 09:11:18
83	82	60	confirmed	2023-01-13 01:02:30	2023-03-08 03:40:52
84	52	7	rejected	2019-12-02 07:05:14	2017-04-17 23:31:32
85	4	74	confirmed	2017-09-18 04:19:31	2017-11-04 00:51:08
86	91	94	confirmed	2020-06-17 07:58:49	2018-02-12 07:26:11
87	71	98	confirmed	2020-04-28 02:18:35	2020-12-09 14:35:27
88	36	61	confirmed	2017-11-20 02:31:55	2019-04-27 05:22:32
89	86	88	confirmed	2022-07-06 10:41:51	2017-08-06 00:53:00
90	49	40	requested	2021-03-21 16:13:00	2019-04-06 00:26:28
91	78	55	requested	2020-05-01 18:03:18	2022-05-13 00:37:23
92	77	37	rejected	2018-01-12 09:40:19	2018-06-19 01:16:51
93	56	28	rejected	2019-04-17 01:54:13	2021-11-10 05:09:05
94	31	41	confirmed	2019-12-03 05:42:31	2020-08-08 22:43:48
95	93	82	requested	2019-06-16 13:11:37	2018-10-20 04:07:20
96	96	66	rejected	2022-07-09 17:06:25	2018-08-28 05:32:56
97	33	77	confirmed	2019-12-01 05:17:18	2019-01-29 19:45:04
98	43	46	rejected	2021-10-13 04:18:24	2021-11-07 19:11:44
99	100	33	requested	2022-01-19 10:45:11	2020-12-18 09:17:29
100	72	34	confirmed	2020-12-15 22:30:33	2020-09-02 21:58:37
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: vk_user
--

COPY public.messages (id, from_user_id, to_user_id, body, is_important, is_delivered, created_at) FROM stdin;
1	35	17	eget,  dictum placerat,  augue.	f	t	2023-03-30 08:39:20
2	81	70	massa non ante bibendum ullamcorper. Duis cursus,  diam at pretium aliquet,  metus urna convallis erat,  eget tincidunt dui augue	t	f	2021-12-31 08:14:55
3	92	5	Duis gravida. Praesent eu nulla at sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero est,  congue a, 	t	t	2019-11-27 05:24:10
4	21	55	consectetuer rhoncus. Nullam velit dui,  semper et,  lacinia vitae,  sodales at,  velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi metus.	t	f	2019-02-05 18:40:24
5	17	11	cubilia Curae Donec tincidunt. Donec vitae erat vel pede blandit congue. In scelerisque	t	f	2019-03-16 07:03:30
6	54	12	justo. Proin non massa non ante bibendum ullamcorper. Duis cursus,  diam at pretium aliquet,  metus urna convallis erat,  eget tincidunt dui augue eu tellus. Phasellus elit pede,  malesuada vel,  venenatis vel,  faucibus id,  libero. Donec consectetuer mauris id sapien. Cras dolor dolor,  tempus non, 	t	t	2023-03-08 00:51:05
7	29	93	felis orci,  adipiscing non,  luctus sit amet,  faucibus ut,  nulla. Cras eu tellus eu augue porttitor interdum. Sed auctor odio a purus. Duis elementum,  dui quis accumsan convallis,  ante lectus convallis est,  vitae sodales nisi magna sed dui. Fusce aliquam,  enim nec tempus	f	f	2021-04-28 08:31:36
8	37	68	sapien molestie orci tincidunt adipiscing. Mauris molestie pharetra nibh. Aliquam ornare,  libero at auctor ullamcorper,  nisl arcu iaculis enim,  sit amet ornare lectus justo eu arcu. Morbi sit amet massa. Quisque porttitor	t	t	2021-06-27 19:54:25
9	73	42	Etiam bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec tempus,  lorem fringilla ornare placerat,  orci lacus vestibulum lorem,  sit amet ultricies sem	f	t	2017-08-28 23:11:35
10	38	86	cursus et,  magna. Praesent interdum ligula eu enim. Etiam imperdiet dictum magna. Ut tincidunt orci quis lectus. Nullam suscipit,  est	t	t	2022-10-15 14:07:23
11	2	100	lectus pede et risus. Quisque libero lacus,  varius et,  euismod et,  commodo at,  libero. Morbi accumsan laoreet ipsum. Curabitur consequat,  lectus sit amet luctus vulputate,  nisi sem semper erat,  in consectetuer ipsum nunc id enim. Curabitur	f	f	2019-11-03 01:29:54
12	91	12	accumsan neque et nunc. Quisque ornare tortor at risus. Nunc ac sem ut dolor dapibus gravida. Aliquam tincidunt, 	f	t	2021-12-04 23:50:10
13	87	91	blandit. Nam nulla magna,  malesuada vel,  convallis in,  cursus et,  eros. Proin ultrices. Duis volutpat nunc sit amet metus. Aliquam erat volutpat. Nulla facilisis. Suspendisse commodo tincidunt nibh. Phasellus nulla. Integer vulputate,  risus	t	t	2018-09-23 11:07:22
14	74	46	ut lacus. Nulla tincidunt,  neque vitae semper egestas,  urna justo faucibus lectus,  a sollicitudin orci sem eget massa. Suspendisse eleifend. Cras sed leo. Cras vehicula aliquet libero. Integer in magna. Phasellus dolor elit,  pellentesque a,  facilisis non,  bibendum sed,  est. Nunc laoreet	f	t	2020-11-18 21:27:39
15	88	54	tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien,  gravida non,  sollicitudin a,  malesuada id,  erat. Etiam vestibulum massa rutrum	f	t	2021-02-28 06:49:21
16	62	88	arcu et pede. Nunc sed orci lobortis augue scelerisque mollis. Phasellus libero mauris,  aliquam eu,  accumsan sed,  facilisis vitae,  orci. Phasellus dapibus quam quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam	f	f	2019-09-06 12:34:07
17	48	95	dui,  in sodales elit erat vitae risus. Duis a mi fringilla mi lacinia mattis. Integer eu	f	f	2022-02-15 02:52:22
18	84	65	augue,  eu tempor erat neque non quam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam fringilla cursus purus. Nullam scelerisque neque sed sem egestas blandit. Nam nulla magna,  malesuada vel,  convallis in,  cursus et,  eros. Proin ultrices. Duis volutpat nunc sit amet metus.	f	f	2019-03-27 17:51:31
19	23	22	ultricies ligula. Nullam enim. Sed nulla ante,  iaculis nec,  eleifend non,  dapibus rutrum, 	f	f	2022-02-07 23:55:11
20	45	58	varius. Nam porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris eu turpis. Nulla aliquet. Proin velit. Sed	t	t	2022-02-14 16:13:14
21	78	6	neque sed dictum eleifend,  nunc risus varius orci,  in consequat enim diam vel arcu. Curabitur ut odio vel est tempor bibendum. Donec felis orci,  adipiscing non,  luctus sit amet,  faucibus ut,  nulla.	t	f	2020-04-12 05:25:37
22	92	78	tristique senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a	f	t	2021-10-03 08:51:00
23	36	0	Phasellus fermentum convallis ligula. Donec luctus aliquet odio. Etiam ligula tortor,  dictum eu,  placerat eget,  venenatis a,  magna. Lorem ipsum dolor sit amet,  consectetuer adipiscing elit. Etiam laoreet,  libero	t	f	2018-03-25 18:51:08
24	78	42	neque. Sed eget lacus. Mauris non dui nec urna suscipit nonummy. Fusce fermentum fermentum arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae Phasellus ornare. Fusce mollis. Duis sit amet diam eu	t	t	2018-11-01 05:28:13
25	27	31	elit elit fermentum risus,  at fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi eleifend egestas. Sed pharetra,  felis eget varius ultrices,  mauris ipsum porta elit, 	t	f	2019-09-08 14:53:31
26	31	26	arcu	f	f	2020-10-22 01:49:16
27	20	84	ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi metus. Vivamus euismod urna. Nullam lobortis quam a felis ullamcorper viverra. Maecenas iaculis aliquet diam. Sed	f	f	2018-02-25 05:16:00
28	18	43	tristique neque venenatis lacus. Etiam bibendum fermentum metus. Aenean sed pede nec ante blandit viverra. Donec tempus,  lorem fringilla ornare placerat,  orci lacus vestibulum lorem,  sit amet ultricies sem magna nec quam. Curabitur vel lectus. Cum sociis natoque	f	f	2020-06-26 18:25:57
29	42	38	accumsan laoreet ipsum. Curabitur consequat,  lectus sit amet luctus vulputate,  nisi sem semper erat,  in consectetuer ipsum nunc id enim. Curabitur massa. Vestibulum accumsan neque et nunc. Quisque ornare tortor at risus.	t	t	2018-03-07 06:43:04
30	13	16	Duis volutpat nunc sit amet metus. Aliquam erat volutpat. Nulla facilisis. Suspendisse commodo tincidunt nibh. Phasellus nulla. Integer vulputate,  risus a ultricies adipiscing,  enim	f	f	2023-04-14 05:46:56
31	31	28	molestie tortor nibh sit amet orci. Ut sagittis lobortis mauris. Suspendisse aliquet molestie tellus. Aenean egestas hendrerit neque. In ornare sagittis felis.	t	f	2019-12-17 07:19:19
32	40	44	magna,  malesuada vel,  convallis in,  cursus et,  eros. Proin ultrices. Duis volutpat nunc sit amet metus. Aliquam erat volutpat. Nulla	t	f	2018-10-13 21:09:20
33	2	44	netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis. Integer tincidunt aliquam arcu. Aliquam ultrices iaculis odio. Nam interdum	f	f	2022-05-01 11:34:53
34	86	8	Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae Donec tincidunt. Donec vitae	t	f	2020-12-31 04:37:57
35	6	96	mauris blandit mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit,  pretium et,  rutrum non,  hendrerit id,  ante.	f	f	2020-05-13 20:45:49
36	16	46	sapien,  cursus in,  hendrerit consectetuer,  cursus et,  magna. Praesent interdum ligula eu enim. Etiam imperdiet dictum magna.	t	f	2021-08-06 17:46:47
37	16	91	nec ante. Maecenas mi felis,  adipiscing fringilla,  porttitor vulputate,  posuere vulputate,  lacus. Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non leo. Vivamus nibh dolor,  nonummy ac,  feugiat non,  lobortis quis,  pede. Suspendisse dui. Fusce diam nunc,  ullamcorper eu,  euismod ac, 	t	f	2017-10-19 21:52:18
38	92	3	augue porttitor interdum. Sed auctor odio a	f	f	2020-12-22 03:53:28
39	21	70	sed,  facilisis vitae,  orci. Phasellus dapibus quam quis diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce aliquet magna a neque. Nullam ut nisi a odio semper cursus. Integer mollis.	t	f	2023-03-09 12:33:53
40	17	16	eu eros. Nam consequat dolor vitae dolor. Donec fringilla. Donec feugiat metus sit amet ante. Vivamus non lorem vitae odio sagittis semper. Nam tempor diam dictum	f	t	2020-03-03 23:17:40
41	25	78	dui,  in sodales elit erat vitae risus. Duis a mi fringilla mi lacinia mattis. Integer eu lacus. Quisque imperdiet,  erat nonummy ultricies ornare,  elit elit fermentum risus,  at fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut ipsum	t	t	2018-05-10 22:19:56
42	17	3	fermentum risus,  at fringilla purus mauris a nunc. In at pede. Cras vulputate velit eu sem. Pellentesque ut ipsum ac mi	t	f	2017-05-02 09:58:21
43	43	41	fermentum metus. Aenean sed pede nec ante blandit viverra. Donec tempus,  lorem fringilla ornare placerat,  orci lacus vestibulum lorem,  sit amet ultricies sem magna nec quam. Curabitur	t	f	2022-02-07 14:48:36
44	73	30	id enim. Curabitur massa. Vestibulum accumsan neque	t	t	2020-06-20 10:33:42
45	13	95	feugiat. Sed nec metus facilisis lorem tristique aliquet. Phasellus fermentum convallis ligula. Donec luctus aliquet odio. Etiam ligula tortor,  dictum eu,  placerat eget,  venenatis a,  magna. Lorem	f	f	2020-02-17 10:29:13
46	45	36	enim,  sit amet ornare lectus justo eu arcu. Morbi sit amet massa. Quisque porttitor eros nec tellus. Nunc lectus pede,  ultrices a, 	f	f	2018-08-08 05:52:49
47	52	16	in consectetuer ipsum nunc id enim. Curabitur massa. Vestibulum accumsan neque et nunc. Quisque ornare tortor at risus. Nunc ac sem ut dolor dapibus gravida. Aliquam tincidunt,  nunc ac mattis ornare,  lectus ante dictum mi,  ac mattis velit justo nec ante. Maecenas mi	f	f	2023-01-11 12:52:07
48	20	71	Cras lorem	f	f	2018-10-11 07:35:17
49	42	44	mauris elit,  dictum eu,  eleifend nec,  malesuada ut,  sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla tempor augue ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In	f	t	2017-05-15 20:10:07
50	81	19	Fusce mi lorem,  vehicula et,  rutrum	f	f	2018-05-07 07:39:35
51	48	20	gravida non,  sollicitudin a,  malesuada id,  erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam,  elementum	t	f	2018-06-23 19:49:23
52	7	65	commodo tincidunt nibh. Phasellus nulla. Integer vulputate,  risus a ultricies adipiscing,  enim mi tempor lorem,  eget mollis lectus pede et risus. Quisque	f	f	2021-03-31 22:53:52
53	41	59	Sed molestie. Sed id risus quis diam luctus lobortis. Class aptent taciti sociosqu ad litora torquent per conubia nostra,  per	f	f	2019-09-26 06:59:38
54	64	37	Curabitur egestas nunc sed libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit, 	t	t	2020-09-09 07:47:34
55	32	13	porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris eu turpis. Nulla aliquet. Proin velit. Sed malesuada augue ut lacus. Nulla tincidunt,  neque vitae semper egestas,  urna justo faucibus lectus,  a sollicitudin	f	t	2018-03-26 03:45:15
56	91	16	eros non enim commodo hendrerit. Donec porttitor tellus non magna. Nam ligula elit,  pretium et,  rutrum non,  hendrerit id,  ante. Nunc mauris sapien, 	t	f	2020-09-13 06:52:25
57	92	6	facilisis,  magna tellus faucibus leo,  in lobortis tellus justo sit amet nulla. Donec non justo. Proin non massa	t	f	2020-12-23 16:09:54
58	35	59	aliquet diam. Sed diam lorem,  auctor quis,  tristique ac,  eleifend vitae,  erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas ornare egestas ligula. Nullam	t	t	2017-07-14 11:15:39
59	50	97	vitae nibh. Donec est mauris,  rhoncus id,  mollis nec,  cursus a,  enim. Suspendisse aliquet,  sem ut cursus luctus, 	t	t	2021-12-02 17:57:51
60	3	95	in molestie tortor nibh sit amet orci. Ut sagittis lobortis mauris. Suspendisse aliquet molestie tellus. Aenean egestas hendrerit neque. In ornare sagittis felis. Donec tempor,  est ac mattis semper,  dui lectus rutrum urna,  nec luctus felis purus ac tellus. Suspendisse sed dolor. Fusce mi lorem,  vehicula et,  rutrum eu, 	f	t	2021-09-24 08:55:47
61	49	62	arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec enim.	f	t	2018-03-27 16:37:15
62	33	51	dignissim pharetra. Nam ac nulla. In tincidunt congue turpis. In condimentum. Donec at arcu. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae Donec tincidunt. Donec vitae	t	t	2020-03-17 22:45:29
63	25	83	Donec tempus,  lorem fringilla ornare placerat,  orci	t	f	2021-08-31 07:46:15
64	68	88	neque pellentesque massa	t	t	2021-07-01 15:49:03
65	31	8	ac ipsum. Phasellus vitae mauris sit amet lorem semper auctor. Mauris vel turpis. Aliquam adipiscing lobortis risus. In mi	t	t	2018-04-25 18:07:14
66	13	37	cursus luctus,  ipsum leo elementum sem,  vitae aliquam eros turpis non enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie	t	t	2021-08-11 10:48:32
67	64	96	dis parturient montes,  nascetur ridiculus mus. Donec dignissim magna a tortor. Nunc commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper,  velit in aliquet lobortis,  nisi nibh lacinia orci,  consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi	f	t	2022-12-24 22:35:43
68	78	65	aliquam eros turpis non enim. Mauris quis turpis vitae purus gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero est,  congue a,  aliquet vel,  vulputate eu,  odio. Phasellus	f	t	2018-10-05 12:59:54
69	3	61	neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper,  velit in	t	t	2022-04-05 20:42:54
70	4	81	rutrum,  justo. Praesent luctus. Curabitur egestas nunc sed libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi	t	f	2019-12-28 04:44:01
71	85	63	eleifend non,  dapibus rutrum,  justo. Praesent luctus. Curabitur egestas nunc sed libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi dictum augue malesuada malesuada.	f	t	2022-08-12 21:54:31
72	27	54	natoque penatibus et magnis dis parturient montes,  nascetur ridiculus mus. Proin vel nisl. Quisque fringilla euismod enim. Etiam gravida molestie arcu. Sed eu nibh vulputate mauris sagittis placerat. Cras dictum ultricies ligula. Nullam enim. Sed	f	f	2022-06-12 06:04:24
73	30	53	laoreet ipsum. Curabitur consequat,  lectus sit amet luctus vulputate,  nisi sem semper erat,  in consectetuer ipsum nunc id enim. Curabitur massa. Vestibulum accumsan neque et nunc. Quisque ornare	t	f	2020-11-02 16:53:15
74	53	95	tristique ac,  eleifend vitae,  erat. Vivamus nisi. Mauris nulla. Integer urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat. Nulla dignissim. Maecenas ornare egestas ligula. Nullam feugiat placerat velit. Quisque varius. Nam porttitor	f	f	2017-09-08 11:26:30
75	31	53	enim. Etiam imperdiet dictum magna. Ut tincidunt orci quis lectus. Nullam suscipit,  est ac facilisis facilisis,  magna tellus faucibus leo,  in lobortis tellus justo sit amet nulla. Donec non justo. Proin non massa non ante bibendum ullamcorper. Duis cursus, 	f	t	2021-12-22 22:10:13
76	18	45	id risus quis diam luctus lobortis. Class aptent taciti sociosqu ad	t	t	2021-11-18 20:34:22
77	90	26	lacus. Quisque imperdiet,  erat nonummy ultricies ornare,  elit elit fermentum risus, 	f	t	2017-10-24 00:53:59
78	52	69	Duis gravida. Praesent eu nulla at sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero est,  congue a,  aliquet vel,  vulputate eu,  odio. Phasellus at augue id ante dictum cursus. Nunc mauris elit,  dictum eu,  eleifend nec,  malesuada ut,  sem. Nulla interdum. Curabitur dictum. Phasellus in felis. Nulla	f	f	2022-11-25 12:51:18
79	9	45	imperdiet non,  vestibulum nec,  euismod in,  dolor. Fusce feugiat. Lorem ipsum	t	f	2022-06-13 05:43:44
80	97	39	felis purus ac tellus. Suspendisse sed dolor. Fusce mi lorem,  vehicula et,  rutrum eu,  ultrices sit amet,  risus. Donec nibh enim,  gravida sit amet, 	f	f	2018-09-06 03:39:33
81	83	56	malesuada vel,  convallis in,  cursus et,  eros.	f	f	2022-11-28 00:27:32
82	9	84	commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper,  velit in aliquet lobortis,  nisi nibh lacinia orci,  consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc	f	f	2018-04-13 09:28:50
83	8	61	Duis a mi fringilla mi lacinia mattis. Integer eu lacus. Quisque imperdiet,  erat nonummy ultricies ornare,  elit	f	t	2023-03-12 07:23:09
84	18	28	et magnis dis parturient montes,  nascetur ridiculus mus. Aenean eget	f	t	2022-09-17 11:51:06
85	42	46	velit dui,  semper et,  lacinia	t	t	2022-05-06 21:00:17
86	83	13	arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra.	f	f	2020-11-26 08:31:17
87	22	82	diam. Duis mi	t	t	2022-07-25 02:13:16
88	78	78	vestibulum. Mauris magna. Duis dignissim tempor arcu. Vestibulum ut eros non enim commodo hendrerit.	f	f	2017-11-20 12:52:13
89	66	7	eu tellus. Phasellus elit pede,  malesuada vel,  venenatis vel,  faucibus id,  libero. Donec consectetuer mauris	t	f	2018-04-30 21:51:36
90	20	50	mauris sagittis placerat. Cras dictum ultricies ligula. Nullam enim. Sed nulla ante,  iaculis nec,  eleifend non,  dapibus rutrum,  justo. Praesent luctus. Curabitur egestas nunc sed libero. Proin sed turpis nec mauris blandit mattis. Cras eget nisi dictum augue malesuada malesuada. Integer id magna et ipsum cursus	t	t	2018-06-17 22:54:53
91	67	9	dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus. Nulla eget metus eu erat semper rutrum. Fusce dolor quam,  elementum at,  egestas a,  scelerisque sed,  sapien. Nunc pulvinar arcu et pede.	f	f	2018-01-28 20:43:14
92	56	80	commodo auctor velit. Aliquam nisl. Nulla eu neque pellentesque massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc ullamcorper,  velit in aliquet lobortis,  nisi nibh lacinia orci,  consectetuer euismod est arcu ac orci. Ut semper pretium neque. Morbi quis urna. Nunc quis arcu vel quam dignissim pharetra. Nam	f	f	2018-04-27 16:28:42
93	16	50	Cum sociis natoque penatibus et magnis dis parturient montes,  nascetur ridiculus mus. Proin vel arcu eu odio tristique pharetra. Quisque ac libero nec ligula consectetuer rhoncus. Nullam velit dui,  semper et,  lacinia vitae,  sodales at,  velit. Pellentesque ultricies dignissim lacus. Aliquam rutrum lorem ac risus. Morbi metus.	f	t	2022-05-21 15:08:29
94	11	0	erat. Etiam vestibulum massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede ac urna. Ut tincidunt vehicula risus.	f	f	2018-04-20 00:40:21
95	68	8	quis turpis vitae purus gravida sagittis. Duis gravida. Praesent eu nulla at sem molestie sodales. Mauris blandit enim consequat purus. Maecenas libero	t	f	2017-11-28 15:41:07
96	86	43	mauris erat eget ipsum. Suspendisse sagittis. Nullam vitae diam. Proin dolor. Nulla semper tellus id nunc interdum feugiat. Sed nec metus facilisis lorem tristique aliquet. Phasellus fermentum convallis ligula. Donec luctus aliquet odio. Etiam ligula tortor,  dictum eu,  placerat eget,  venenatis a,  magna. Lorem ipsum dolor	f	t	2020-07-31 07:43:23
97	71	27	Nam interdum enim non nisi. Aenean eget metus. In nec orci. Donec nibh. Quisque nonummy ipsum non arcu. Vivamus	t	f	2020-08-30 19:28:09
98	1	21	lobortis augue scelerisque mollis. Phasellus libero mauris,  aliquam eu,  accumsan sed,  facilisis vitae,  orci. Phasellus dapibus quam quis diam. Pellentesque	t	f	2021-12-24 07:53:45
99	73	7	nunc risus varius orci,  in consequat enim diam vel arcu. Curabitur ut odio vel est tempor bibendum. Donec felis orci,  adipiscing non,  luctus sit amet,  faucibus ut,  nulla. Cras eu tellus eu augue porttitor interdum. Sed auctor odio a purus. Duis elementum,  dui quis accumsan convallis,  ante lectus convallis	f	t	2017-12-19 04:32:12
100	75	8	eget massa. Suspendisse eleifend. Cras sed leo. Cras vehicula aliquet libero. Integer	f	f	2022-02-23 22:20:24
\.


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: vk_user
--

COPY public.photo (id, url, owner_id, description, uploaded_at, size) FROM stdin;
1	http://yahoo.com/site1	8	ac,  fermentum vel,  mauris. Integer sem elit,  pharetra	2018-11-20 10:28:40	556175
2	https://guardian.co.uk/user/1102	82	placerat eget,  venenatis a,  magna. Lorem ipsum	2018-11-25 04:04:31	493239
3	https://instagram.com/group/93	22	eu tempor erat neque non quam. Pellentesque habitant morbi	2019-04-02 11:40:40	261132
4	https://whatsapp.com/settings4	9	nulla. Donec non justo. Proin non	2019-01-17 22:05:58	170676
5	https://yahoo.com/sub5	15	non	2018-09-21 06:24:34	352771
6	https://instagram.com/one6	80	Proin sed turpis nec	2021-10-20 11:26:12	56102
7	https://nytimes.com/group/97	71	nisi magna sed dui. Fusce aliquam,  enim nec	2022-03-22 14:02:53	979311
8	https://cnn.com/settings8	82	Sed nulla ante,  iaculis nec,  eleifend non,  dapibus	2021-09-23 07:20:04	874874
9	https://google.com/user/1109	43	felis purus ac	2018-12-25 19:26:27	382426
10	https://nytimes.com/fr0	33	magna. Phasellus dolor elit,  pellentesque a,  facilisis	2021-08-11 02:43:43	468500
11	http://twitter.com/en-ca10	9	interdum. Nunc sollicitudin commodo	2020-09-18 13:37:32	219898
12	http://twitter.com/en-ca11	88	tellus eu augue porttitor interdum. Sed auctor odio a	2022-06-12 01:12:18	564184
13	http://wikipedia.org/one12	47	parturient montes,  nascetur ridiculus mus. Proin vel nisl. Quisque	2021-02-21 12:48:58	124002
14	https://google.com/settings13	86	et,  magna. Praesent	2022-06-12 08:05:46	429389
15	http://naver.com/en-us14	23	sit amet	2017-06-27 14:28:51	874457
16	http://facebook.com/group/915	12	scelerisque,  lorem	2021-08-04 17:21:00	641282
17	https://ebay.com/en-us16	52	in molestie tortor nibh sit	2019-11-17 15:10:31	413832
18	http://walmart.com/fr17	70	faucibus leo,  in lobortis	2020-11-27 04:27:55	258424
19	http://instagram.com/en-ca18	94	Donec sollicitudin adipiscing ligula.	2021-02-19 02:01:27	472936
20	http://guardian.co.uk/one19	37	tempor,  est	2020-01-09 15:34:38	13791
21	https://bbc.co.uk/sub20	68	tincidunt congue turpis. In	2018-02-12 18:19:06	439379
22	https://facebook.com/sub21	92	Pellentesque habitant morbi tristique senectus	2020-06-22 17:05:52	32417
23	https://zoom.us/one22	92	sagittis. Nullam vitae diam.	2021-09-10 07:59:46	591978
24	http://naver.com/en-ca23	95	Fusce mollis. Duis sit amet diam eu dolor egestas	2023-01-13 00:12:21	879999
25	http://nytimes.com/en-ca24	50	quam. Curabitur vel lectus. Cum sociis	2017-05-03 19:39:44	476573
26	http://cnn.com/site25	23	lobortis risus.	2017-11-04 11:23:50	748034
27	http://wikipedia.org/settings26	31	euismod enim. Etiam gravida	2022-01-18 07:25:37	516508
28	https://wikipedia.org/site27	14	sit amet	2021-05-06 15:37:45	814928
29	https://twitter.com/settings28	1	euismod enim. Etiam gravida molestie arcu. Sed	2017-05-21 05:03:17	232854
30	https://bbc.co.uk/settings29	24	netus et	2023-01-22 22:23:50	206803
31	https://twitter.com/sub30	77	nibh enim,  gravida sit	2017-09-11 02:39:27	225869
32	http://nytimes.com/one31	92	et libero.	2018-12-25 00:25:40	186581
33	https://reddit.com/site32	67	posuere cubilia	2022-07-17 12:12:00	674841
34	http://zoom.us/sub33	30	Aliquam	2022-06-06 08:12:51	720005
35	http://guardian.co.uk/group/934	67	Phasellus at augue id ante dictum cursus. Nunc mauris	2020-04-02 17:17:29	796278
36	https://google.com/group/935	64	scelerisque mollis. Phasellus libero mauris, 	2018-12-16 19:51:29	278444
37	https://cnn.com/en-ca36	67	nulla. In tincidunt congue turpis. In condimentum.	2020-12-02 16:37:51	744725
38	https://facebook.com/user/11037	49	Nunc ullamcorper,  velit in aliquet lobortis,  nisi	2018-11-03 00:35:42	862675
39	https://cnn.com/fr38	91	dictum ultricies ligula.	2022-01-14 15:58:22	927521
40	https://facebook.com/fr39	74	Cras interdum. Nunc sollicitudin commodo ipsum. Suspendisse non	2022-01-15 19:41:02	312113
41	https://reddit.com/fr40	21	nibh. Quisque nonummy ipsum	2021-11-03 22:32:52	622377
42	https://yahoo.com/user/11041	76	enim. Suspendisse aliquet,  sem ut cursus luctus,  ipsum leo	2020-04-23 15:04:39	127512
43	https://instagram.com/settings42	18	ac libero nec ligula consectetuer rhoncus. Nullam velit	2017-09-08 00:07:14	333672
44	http://baidu.com/one43	98	lectus ante dictum mi,  ac mattis	2017-12-07 11:53:35	358788
45	https://naver.com/sub/cars44	52	lorem eu metus. In lorem. Donec	2017-12-18 20:08:18	595732
46	http://bbc.co.uk/sub45	56	non,  egestas a, 	2017-10-30 06:05:10	581441
47	https://netflix.com/site46	91	euismod enim. Etiam gravida molestie	2018-08-26 09:00:37	797647
48	http://instagram.com/sub47	54	nascetur ridiculus mus. Proin vel nisl. Quisque fringilla	2022-03-07 16:43:51	298401
49	http://ebay.com/site48	65	Curabitur	2019-03-13 12:34:05	59675
50	https://bbc.co.uk/group/949	58	elit. Etiam laoreet,  libero et tristique pellentesque, 	2021-01-10 18:08:47	852116
51	http://nytimes.com/sub/cars50	14	Aenean euismod	2019-07-12 00:56:39	826650
52	https://pinterest.com/en-ca51	36	id risus quis diam luctus	2022-07-13 13:57:12	447521
53	https://wikipedia.org/en-ca52	58	mauris. Morbi non sapien molestie	2018-11-04 11:32:31	376210
54	https://whatsapp.com/sub53	86	aliquet odio. Etiam ligula tortor,  dictum	2022-05-27 11:13:26	817494
55	https://whatsapp.com/site54	97	Pellentesque tincidunt tempus risus. Donec egestas. Duis ac arcu. Nunc	2022-08-14 05:42:43	483460
56	https://baidu.com/fr55	72	bibendum sed, 	2023-02-27 19:58:27	759079
57	https://instagram.com/settings56	40	pellentesque a,  facilisis non, 	2018-11-10 06:59:53	432661
58	https://walmart.com/one57	97	sodales	2018-03-09 09:30:18	377990
59	https://wikipedia.org/sub58	10	lacinia at,  iaculis quis,  pede. Praesent eu	2020-03-22 09:19:10	277200
60	http://walmart.com/en-ca59	91	libero	2021-09-30 08:33:01	599823
61	https://bbc.co.uk/group/960	58	Etiam gravida molestie arcu.	2021-04-29 04:00:46	377881
62	https://youtube.com/sub/cars61	43	dui,  nec tempus	2017-04-24 15:32:48	558305
63	http://bbc.co.uk/en-us62	40	malesuada vel,  venenatis vel,  faucibus id, 	2021-11-15 21:05:59	734944
64	http://facebook.com/en-ca63	24	nibh enim,  gravida sit amet, 	2018-03-08 16:43:48	545140
65	https://naver.com/sub/cars64	86	mollis non,  cursus non,  egestas a,  dui. Cras	2018-06-01 15:46:32	939005
66	http://yahoo.com/group/965	37	diam. Duis mi enim,  condimentum eget,  volutpat ornare,  facilisis eget, 	2019-12-22 06:34:21	380870
67	https://instagram.com/group/9266	42	Sed auctor	2020-03-10 10:57:54	982582
68	http://baidu.com/fr67	24	augue eu tellus. Phasellus elit pede,  malesuada	2018-11-18 02:14:06	165228
69	https://instagram.com/user/11068	88	arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec	2022-05-23 09:33:41	768338
70	https://yahoo.com/user/11069	64	laoreet ipsum. Curabitur consequat,  lectus sit amet luctus vulputate,  nisi	2019-07-04 13:38:19	958603
71	https://reddit.com/one70	20	placerat eget, 	2019-03-23 23:12:01	428400
72	https://walmart.com/site71	9	urna. Vivamus molestie	2022-11-21 06:49:28	242868
73	http://yahoo.com/en-ca72	92	tincidunt orci quis lectus. Nullam suscipit,  est ac	2022-06-21 20:08:02	462846
74	http://bbc.co.uk/group/973	34	mollis nec,  cursus a, 	2020-11-10 11:23:41	486662
75	http://naver.com/site74	57	Quisque	2022-04-02 17:27:21	546262
76	https://youtube.com/settings75	96	et,  euismod et,  commodo at,  libero. Morbi accumsan laoreet	2022-12-23 12:33:52	44778
77	http://zoom.us/en-us76	72	et netus et malesuada fames ac turpis egestas.	2022-12-18 22:42:23	467837
78	http://zoom.us/site77	14	nibh. Donec	2020-07-28 05:50:44	785733
79	https://instagram.com/fr78	81	facilisis vitae,  orci. Phasellus dapibus quam quis	2020-07-24 13:02:47	676169
80	https://walmart.com/sub/cars79	52	leo. Cras vehicula aliquet libero. Integer in magna.	2019-10-06 06:17:27	311728
81	https://pinterest.com/group/980	55	in lobortis tellus justo sit amet nulla. Donec	2018-01-13 18:34:37	517932
82	https://walmart.com/site81	40	fermentum arcu. Vestibulum ante ipsum primis in faucibus orci luctus	2018-09-29 08:20:30	531764
83	https://twitter.com/sub/cars82	60	nunc sit amet metus. Aliquam	2018-03-24 09:00:28	655999
84	http://twitter.com/group/983	20	ipsum cursus vestibulum. Mauris magna. Duis dignissim	2018-02-24 08:35:14	500625
85	http://netflix.com/settings84	60	dictum. Phasellus in felis. Nulla tempor augue ac	2017-10-20 22:34:41	616699
86	https://pinterest.com/one85	7	placerat, 	2022-01-13 16:04:49	480730
87	http://whatsapp.com/sub/cars86	71	nascetur	2019-02-01 20:31:52	382094
88	http://youtube.com/user/11087	3	Pellentesque ut ipsum	2021-12-21 04:08:09	465824
89	http://facebook.com/fr88	7	rhoncus. Proin nisl sem,  consequat nec,  mollis	2019-02-26 12:30:23	353649
90	http://zoom.us/group/989	18	Aliquam gravida mauris ut mi.	2022-12-04 04:46:30	909219
91	http://zoom.us/en-us90	4	sit amet,  consectetuer adipiscing elit. Curabitur sed	2020-12-05 19:13:26	913656
92	https://whatsapp.com/one91	75	placerat,  augue. Sed molestie. Sed id risus quis diam	2017-10-11 00:50:27	14492
93	https://twitter.com/sub/cars92	21	ligula eu enim. Etiam	2021-10-07 02:32:08	626501
94	https://bbc.co.uk/fr93	78	nulla. Cras eu tellus eu augue porttitor interdum.	2021-06-10 02:02:23	282377
95	http://reddit.com/one94	68	magna nec	2018-07-31 22:49:26	239847
96	https://baidu.com/sub95	41	sagittis semper. Nam tempor diam dictum sapien. Aenean	2017-11-05 16:23:29	497862
97	https://cnn.com/one96	23	et,  rutrum non,  hendrerit id,  ante.	2017-05-18 08:41:54	951138
98	http://yahoo.com/fr97	49	felis. Donec tempor,  est ac mattis semper,  dui	2020-10-08 16:54:04	872622
99	http://yahoo.com/one98	23	adipiscing non,  luctus sit amet,  faucibus	2018-12-10 10:09:13	37877
100	https://nytimes.com/group/9599	79	non,  lacinia	2019-04-17 14:56:41	28385
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: vk_user
--

COPY public.subscriptions (id, subscriber_id, subscribed_to_id, subscription_target) FROM stdin;
1	15	18	community
2	35	79	user
3	63	16	community
4	92	94	user
5	92	57	community
6	55	2	community
7	95	25	user
8	54	48	user
9	30	30	user
10	47	12	community
11	30	45	user
12	18	18	user
13	75	61	community
14	76	75	user
15	77	95	user
16	2	85	community
17	48	91	user
18	68	53	user
19	16	88	community
20	88	82	user
21	55	25	user
22	63	43	user
23	30	80	user
24	49	71	community
25	48	4	community
26	3	88	user
27	84	3	user
28	99	51	user
29	73	59	community
30	63	40	user
31	74	84	user
32	73	70	user
33	8	39	community
34	54	32	user
35	9	66	user
36	97	96	community
37	65	37	user
38	16	47	community
39	39	37	community
40	29	31	community
41	29	46	community
42	11	18	user
43	7	78	user
44	25	80	community
45	89	78	community
46	66	74	community
47	78	74	user
48	90	60	community
49	83	10	user
50	98	84	community
51	72	52	user
52	39	4	community
53	80	31	community
54	87	58	user
55	47	80	user
56	22	52	user
57	85	92	community
58	87	84	community
59	37	47	community
60	32	45	user
61	75	39	user
62	75	43	user
63	9	89	user
64	50	47	community
65	79	40	user
66	53	86	user
67	61	74	user
68	4	51	user
69	85	61	user
70	97	21	community
71	25	79	community
72	40	39	community
73	57	21	user
74	92	65	community
75	79	55	user
76	47	26	user
77	73	3	user
78	32	89	community
79	94	32	community
80	55	4	community
81	7	82	user
82	81	12	community
83	71	27	community
84	25	70	user
85	37	97	user
86	51	53	user
87	11	89	user
88	15	64	user
89	33	66	user
90	91	52	community
91	26	39	user
92	54	24	user
93	70	67	community
94	94	98	community
95	88	17	community
96	5	96	user
97	76	57	user
98	65	99	user
99	19	25	community
100	72	21	user
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: vk_user
--

COPY public.users (id, first_name, last_name, email, phone, main_photo_id, created_at) FROM stdin;
1	Brent	Lawson	odio.auctor@icloud.com	(912) 667-2602	71	2018-03-16 12:48:04
2	Jonah	Skinner	egestas.duis.ac@aol.net	1-746-727-6517	82	2017-05-08 13:04:23
3	Marsden	Wilkinson	in@outlook.com	1-302-358-9721	99	2023-02-23 14:53:56
4	Laura	Vega	non.egestas@hotmail.org	1-475-145-4236	33	2022-03-06 23:57:08
5	Deacon	Horne	nascetur.ridiculus@google.edu	1-272-532-8715	57	2018-03-05 03:45:14
6	Herrod	Bryant	ipsum@google.net	1-461-432-6018	75	2020-06-13 22:41:18
7	Echo	Cummings	dolor.nonummy@google.net	1-665-861-4856	91	2018-01-12 06:04:43
8	Camden	Walton	in.dolor.fusce@protonmail.edu	1-232-856-7267	52	2018-11-09 12:16:26
9	Quynn	Craig	magna.praesent@yahoo.net	(499) 258-3125	24	2021-01-27 00:45:48
10	Ivana	Harvey	porttitor.interdum.sed@aol.org	(262) 737-8527	62	2021-11-21 07:06:00
11	Thaddeus	Gordon	et.ipsum@icloud.ca	(830) 823-3324	15	2018-10-30 03:07:03
12	Halee	Mays	eu.turpis@icloud.edu	(625) 518-0382	40	2021-04-02 15:00:34
13	Roth	Wolfe	proin.non@outlook.ca	(582) 155-5689	27	2019-10-12 18:40:04
14	Ian	Nielsen	donec.porttitor@hotmail.ca	1-615-484-9425	3	2022-06-28 14:45:58
15	Devin	Silva	luctus.aliquet@outlook.net	(142) 617-0541	63	2018-10-24 00:30:31
16	Harding	Fulton	quam.elementum@protonmail.org	1-485-723-5124	51	2021-06-08 18:26:52
17	Macaulay	Ball	feugiat@icloud.org	(406) 621-7122	64	2018-09-28 21:46:58
18	Vielka	Lyons	nascetur@outlook.org	1-814-546-4575	94	2020-08-17 13:08:05
19	Shelly	Black	turpis.nec.mauris@hotmail.couk	1-237-594-1677	47	2022-08-20 04:48:23
20	Quon	Rice	vivamus.molestie.dapibus@google.com	(173) 187-8792	49	2019-01-04 23:21:37
21	Bryar	Wolfe	sed.et@yahoo.edu	1-447-481-3382	33	2018-06-19 15:20:42
22	Colleen	Morrow	primis.in@outlook.couk	(364) 875-3253	6	2018-12-01 14:21:16
23	Danielle	Snow	sed.tortor@outlook.org	1-529-873-4466	69	2017-07-04 21:42:42
24	Wylie	Williamson	non.feugiat.nec@google.net	(550) 275-5987	91	2021-10-13 03:40:54
25	Lois	Cote	donec.est@yahoo.com	1-286-534-7891	99	2018-12-13 10:58:10
26	Caesar	Strong	blandit.enim.consequat@protonmail.edu	1-554-454-3817	98	2020-05-31 01:57:26
27	Nita	Jackson	donec.consectetuer@hotmail.net	(482) 217-3872	36	2018-06-10 11:46:12
28	Hanna	Parsons	turpis.egestas.aliquam@protonmail.couk	1-382-284-8146	36	2019-09-04 02:57:08
29	Amery	Meadows	ac.tellus@google.couk	1-614-715-2654	2	2020-01-20 23:46:18
30	Carolyn	Mccoy	dictum.mi@yahoo.com	(609) 555-4643	28	2018-04-15 16:59:36
31	Xantha	Trevino	proin.velit@protonmail.ca	(550) 347-1154	64	2021-01-28 13:12:45
32	Randall	Lee	tempus.lorem@outlook.com	1-261-881-7854	40	2019-02-24 14:48:06
33	Maxwell	Hernandez	nascetur@yahoo.org	1-606-390-0118	1	2017-07-22 03:15:22
34	Samson	Mccormick	faucibus.id@outlook.com	1-814-339-3368	10	2022-01-09 17:40:38
35	Meredith	Sweeney	erat@protonmail.org	1-698-411-3122	66	2017-07-04 05:35:22
36	Kato	Singleton	ipsum.dolor.sit@icloud.ca	(471) 685-2421	52	2022-08-28 06:23:36
37	Renee	Clemons	pede.nunc.sed@hotmail.com	1-295-861-3282	65	2019-05-15 17:57:06
38	Zenaida	Bishop	consectetuer.euismod@icloud.net	(484) 665-0225	57	2017-06-02 08:52:07
39	Burke	Campbell	cum.sociis@hotmail.org	1-644-513-3412	89	2019-12-17 14:26:46
40	Irene	Marquez	duis.sit@outlook.net	1-282-212-9252	97	2023-03-17 07:38:27
41	Zephr	Lancaster	erat.neque@aol.couk	1-703-249-3234	83	2017-05-03 23:18:34
42	Samson	Weaver	cum.sociis.natoque@icloud.couk	1-725-539-0231	78	2022-12-25 02:44:33
43	Hannah	Hines	neque.nullam@protonmail.ca	1-856-992-0155	74	2017-07-07 14:02:21
44	Haley	Lambert	sed@icloud.edu	(425) 463-2692	75	2017-06-27 22:00:57
45	Calvin	Willis	nibh@yahoo.org	(711) 594-3678	28	2020-11-03 07:53:27
46	Solomon	Ward	a.tortor@yahoo.com	1-805-760-8525	35	2019-04-05 07:47:04
47	Cora	Mcmahon	dictum.placerat@google.couk	(471) 113-8134	40	2017-04-15 11:03:59
48	Merritt	Yates	consectetuer.euismod.est@protonmail.org	(764) 577-8189	63	2020-06-12 08:09:50
49	Yoshio	Harding	et.malesuada@outlook.org	1-176-431-8531	70	2019-10-06 10:09:38
50	Len	Avila	aliquet.phasellus.fermentum@icloud.com	1-370-943-4107	77	2017-05-31 09:21:49
51	Rashad	Avila	malesuada.vel@protonmail.org	(213) 886-3588	67	2021-09-13 16:38:06
52	Kennan	Armstrong	accumsan.interdum@yahoo.edu	(799) 412-3098	98	2021-12-28 13:43:09
53	Cyrus	Barr	vel.mauris@outlook.org	(400) 470-6880	70	2020-06-09 01:01:18
54	Zenia	Bond	feugiat@aol.net	1-263-874-2157	15	2021-10-11 16:46:17
55	Drake	Wright	id.enim@aol.org	(532) 573-0451	18	2021-09-24 21:23:46
56	Roth	Parker	duis@protonmail.edu	(210) 324-4473	38	2021-04-03 20:32:20
57	Adam	Dalton	morbi.non@yahoo.net	(785) 785-0586	68	2017-08-17 04:12:19
58	Abbot	Ayers	ipsum.curabitur@google.ca	1-788-918-8915	54	2017-08-03 17:52:52
59	Hu	Workman	condimentum@google.net	(325) 211-4747	43	2017-10-28 18:05:28
60	Steel	Graham	libero.nec@hotmail.net	1-335-165-1085	76	2019-08-11 20:07:49
61	Shannon	Tillman	eu.sem@aol.net	(829) 168-1254	46	2022-06-12 08:17:57
62	Yetta	Barry	tincidunt.tempus@aol.ca	1-587-350-5412	97	2020-04-25 17:26:44
63	Wayne	Callahan	etiam.laoreet@outlook.edu	(662) 470-8845	92	2021-09-07 04:19:31
64	Elaine	O'connor	commodo@aol.edu	(721) 777-7722	32	2019-03-01 21:10:58
65	Frances	Walls	dui.cum.sociis@aol.ca	(497) 513-7355	14	2020-06-01 07:45:40
66	Fletcher	Beard	dis.parturient@yahoo.org	(234) 385-9419	91	2018-05-30 13:10:26
67	Iliana	Noble	nec@yahoo.edu	1-182-214-1531	33	2020-03-09 22:56:05
68	Karleigh	Sandoval	blandit.enim@protonmail.com	1-885-595-1736	44	2021-03-12 23:43:04
69	Cathleen	Gonzales	mauris.quis@protonmail.couk	(264) 286-9286	78	2018-08-09 20:04:22
70	Henry	Warner	donec.est@hotmail.net	(467) 500-9326	3	2017-09-04 05:40:17
71	Julian	Mays	blandit@outlook.net	(247) 316-6774	84	2020-05-29 10:18:16
72	Jolie	Bowman	id.nunc@google.net	(783) 968-6168	17	2020-07-26 13:10:53
73	Linus	Wheeler	felis.nulla@yahoo.com	1-564-377-4373	9	2017-09-01 19:18:33
74	Dominic	Chen	integer.in@protonmail.net	1-316-204-4348	42	2018-03-17 17:36:42
75	Herman	Cabrera	ligula.tortor@hotmail.org	1-797-778-8395	13	2020-05-24 20:42:55
76	Paki	Hensley	ac.mattis.ornare@outlook.com	1-856-532-2343	61	2019-09-04 04:27:12
77	Berk	Sharp	blandit.nam@google.org	1-691-978-3545	4	2019-08-16 00:40:18
78	Erasmus	Owens	egestas.a@yahoo.couk	1-218-301-9067	29	2023-04-09 02:36:44
79	Lionel	Schwartz	fusce.aliquet.magna@aol.ca	1-271-784-2812	97	2020-06-14 11:53:50
80	Quin	Boyle	quis@aol.ca	1-131-250-2836	36	2018-12-17 01:37:55
81	Noble	Gallagher	lacus.ut@aol.org	(835) 985-1105	4	2020-03-08 18:06:00
82	Kenyon	Lucas	lectus.pede.ultrices@outlook.net	1-481-872-3470	88	2018-07-03 04:07:34
83	Madaline	Marquez	ullamcorper.duis@protonmail.net	(347) 571-5804	27	2021-07-14 05:04:19
84	Farrah	Atkins	arcu.eu@aol.ca	(137) 867-5668	9	2019-06-06 22:23:56
85	Armand	Emerson	nunc.sed.pede@outlook.org	1-128-937-3446	32	2022-12-16 01:12:49
86	Ashton	Suarez	convallis.ante@aol.com	1-878-480-8188	59	2020-01-02 21:51:03
87	Harrison	Alexander	lectus.pede@aol.net	1-849-498-9978	31	2021-04-09 04:42:41
88	Chester	Marsh	semper.tellus.id@yahoo.com	1-153-574-1557	81	2017-09-11 21:21:55
89	Zephr	Leach	viverra.maecenas@aol.edu	1-613-641-6342	67	2017-09-19 19:12:30
90	Jamal	Best	elit.erat.vitae@hotmail.edu	1-882-882-3810	64	2018-05-01 00:02:14
91	Avye	Gonzalez	mollis.vitae@aol.org	1-466-884-3713	95	2022-11-29 02:39:18
92	Kay	Paul	enim.consequat@outlook.couk	1-784-464-0142	53	2017-06-30 15:55:10
93	Cameron	Patton	ullamcorper.duis@icloud.org	(362) 706-3621	37	2019-08-19 16:00:13
94	Marsden	Dawson	adipiscing@google.edu	(579) 388-4148	82	2020-12-01 08:19:27
95	Naida	Boyle	adipiscing.fringilla.porttitor@yahoo.net	(251) 782-6576	59	2018-02-23 10:45:31
96	Lyle	Michael	faucibus.orci@yahoo.net	1-764-168-8283	4	2020-03-10 03:15:41
97	Mark	Mcneil	tortor.at@hotmail.com	(246) 383-5568	12	2019-03-10 23:45:54
98	Baker	Walsh	ut@google.com	(389) 262-1565	57	2022-11-29 09:50:02
99	Wendy	Holmes	massa.rutrum@outlook.ca	(696) 256-7723	44	2020-03-17 06:04:05
100	Fredericka	Leblanc	ipsum.primis.in@hotmail.edu	(804) 265-5357	70	2020-11-03 19:22:10
\.


--
-- Data for Name: video; Type: TABLE DATA; Schema: public; Owner: vk_user
--

COPY public.video (id, url, owner_id, description, uploaded_at, size) FROM stdin;
1	http://twitter.com/site1	40	tincidunt.	2021-07-23 01:52:24	492564
2	http://reddit.com/sub/cars2	43	sapien. Aenean massa. Integer vitae nibh. Donec est	2019-07-26 07:54:50	570644
3	https://wikipedia.org/settings3	83	neque. Sed eget lacus. Mauris non dui nec urna suscipit	2020-05-05 13:08:34	201939
4	https://ebay.com/en-ca4	77	Quisque porttitor eros nec tellus. Nunc	2021-06-07 12:49:20	70887
5	https://naver.com/en-ca5	53	Nullam scelerisque	2023-02-26 03:39:43	40004
6	https://yahoo.com/group/96	95	ridiculus mus. Proin vel arcu eu	2019-08-22 22:38:17	718295
7	https://netflix.com/fr7	39	Cras sed leo. Cras vehicula aliquet libero.	2022-07-18 11:38:38	213903
8	https://netflix.com/settings8	72	elit,  pharetra ut,  pharetra sed,  hendrerit a,  arcu. Sed	2018-03-20 01:42:35	234037
9	http://netflix.com/sub9	5	vel lectus. Cum sociis natoque penatibus et magnis dis	2020-10-29 01:09:51	423690
10	http://zoom.us/one10	17	porttitor scelerisque neque. Nullam nisl.	2020-11-28 10:15:15	385881
11	http://instagram.com/en-us11	30	cursus	2022-03-17 02:07:54	200112
12	https://yahoo.com/en-us12	24	Praesent eu nulla at sem	2018-10-19 12:00:13	407819
13	http://nytimes.com/user/11013	78	auctor non,  feugiat nec,  diam. Duis mi enim,  condimentum	2019-10-31 17:48:55	605523
14	https://yahoo.com/en-ca14	55	Aliquam nisl. Nulla	2019-11-23 10:36:00	570997
15	http://bbc.co.uk/settings15	28	ornare sagittis felis. Donec	2021-10-10 00:50:28	775849
16	http://yahoo.com/en-ca16	50	orci tincidunt adipiscing. Mauris molestie	2021-08-21 00:42:47	746552
17	https://naver.com/user/11017	45	neque vitae semper egestas,  urna justo faucibus lectus, 	2019-04-17 05:35:18	309637
18	https://naver.com/fr18	13	consequat purus. Maecenas libero est,  congue a,  aliquet vel, 	2017-05-10 18:40:45	940293
19	http://twitter.com/settings19	87	elit,  a feugiat tellus lorem eu	2022-07-18 20:32:58	490209
20	https://whatsapp.com/site20	92	magna. Lorem ipsum dolor	2017-09-12 07:04:37	577194
21	https://facebook.com/en-us21	45	facilisis. Suspendisse commodo	2022-06-09 16:29:44	480207
22	https://youtube.com/fr22	96	sem elit,  pharetra ut,  pharetra sed,  hendrerit a,  arcu.	2019-05-20 08:55:25	560472
23	https://netflix.com/user/11023	46	orci. Ut semper pretium neque. Morbi quis urna.	2017-08-10 01:45:39	256497
24	https://whatsapp.com/settings24	3	eu erat semper	2022-04-27 02:29:10	234476
25	http://netflix.com/one25	91	sit	2022-09-25 17:55:14	470052
26	https://yahoo.com/user/11026	84	Donec fringilla. Donec feugiat metus sit amet ante.	2017-12-20 13:35:30	897426
27	https://whatsapp.com/one27	98	sociosqu ad litora torquent	2023-01-27 16:46:56	597445
28	http://facebook.com/sub28	58	Ut	2018-04-10 13:41:18	401072
29	http://naver.com/sub/cars29	98	scelerisque,  lorem ipsum	2023-04-02 04:48:15	301089
30	https://wikipedia.org/sub/cars30	41	ligula. Nullam enim. Sed	2021-04-29 12:52:56	90952
31	https://instagram.com/en-us31	40	Donec nibh enim,  gravida sit	2019-12-02 02:37:39	180909
32	https://cnn.com/group/932	49	tortor. Nunc commodo auctor velit.	2018-10-08 00:48:50	512414
33	http://yahoo.com/one33	45	ac turpis egestas. Aliquam fringilla cursus purus.	2018-09-11 03:28:56	49949
34	http://netflix.com/fr34	73	vel est	2018-02-11 15:50:43	230806
35	https://naver.com/sub/cars35	18	Sed neque. Sed eget lacus. Mauris non	2019-03-16 12:16:51	198618
36	https://reddit.com/group/936	33	sit amet ultricies sem magna nec quam.	2021-11-20 06:16:27	52409
37	https://bbc.co.uk/fr37	90	enim,  gravida sit amet,  dapibus id,  blandit at,  nisi.	2021-12-03 22:11:06	308869
38	http://nytimes.com/fr38	71	sit amet, 	2017-10-23 11:45:19	979992
39	http://guardian.co.uk/fr39	64	nascetur ridiculus mus. Proin	2021-01-11 19:52:20	259739
40	https://nytimes.com/sub/cars40	45	Proin nisl sem,  consequat nec,  mollis vitae, 	2020-01-04 14:19:01	371817
41	https://walmart.com/en-ca41	81	eget metus eu erat	2018-08-07 18:04:56	368547
42	https://facebook.com/user/11042	17	Duis sit amet diam eu dolor egestas rhoncus. Proin nisl	2022-11-27 02:10:10	19900
43	https://wikipedia.org/group/943	41	Aenean euismod mauris eu elit. Nulla	2017-06-01 10:18:10	851770
44	http://cnn.com/one44	40	dui. Fusce diam nunc,  ullamcorper eu,  euismod ac, 	2017-08-15 16:19:27	977442
45	http://walmart.com/group/945	16	eros turpis non enim. Mauris	2020-02-23 23:38:31	958892
46	http://walmart.com/fr46	75	gravida sagittis. Duis	2020-04-20 19:15:50	842245
47	http://nytimes.com/one47	36	Nullam	2018-12-13 09:28:11	275170
48	http://ebay.com/en-us48	97	ultrices. Vivamus rhoncus. Donec	2019-07-07 03:31:45	627403
49	http://google.com/user/11049	6	In mi pede,  nonummy ut,  molestie	2021-03-31 15:05:06	435479
50	https://youtube.com/sub/cars50	43	faucibus orci luctus et ultrices posuere cubilia	2021-01-05 20:27:21	876549
51	http://pinterest.com/en-us51	61	ornare lectus justo eu arcu. Morbi sit	2020-08-20 14:17:11	909354
52	http://baidu.com/one52	2	Curabitur consequat,  lectus sit	2018-04-13 21:39:01	416501
53	https://youtube.com/sub/cars53	48	vulputate mauris	2018-04-22 08:14:57	244145
54	https://cnn.com/group/954	78	massa lobortis ultrices. Vivamus rhoncus. Donec est. Nunc	2018-04-17 13:50:19	407782
55	https://nytimes.com/one55	7	tempor diam dictum sapien. Aenean massa.	2022-06-21 12:53:56	287998
56	http://google.com/settings56	26	et,  euismod et,  commodo at,  libero. Morbi	2020-02-19 04:32:21	496768
57	http://zoom.us/group/957	69	dictum magna. Ut tincidunt orci quis lectus.	2017-04-16 09:56:24	863198
58	http://cnn.com/en-ca58	71	dictum	2022-07-08 14:38:35	654788
59	http://guardian.co.uk/one59	74	sollicitudin orci	2021-09-16 01:38:41	488342
60	http://facebook.com/en-ca60	36	vitae sodales nisi magna sed dui. Fusce aliquam,  enim	2017-11-23 15:42:37	692598
61	https://naver.com/sub/cars61	12	nulla magna,  malesuada vel,  convallis in, 	2020-01-01 13:37:46	287524
62	http://netflix.com/settings62	51	orci luctus et ultrices posuere cubilia	2021-11-22 19:09:27	998246
63	http://google.com/sub/cars63	83	nec,  diam. Duis mi enim,  condimentum eget, 	2018-08-16 17:46:18	743015
64	https://facebook.com/user/11064	37	ipsum. Phasellus vitae mauris sit	2023-01-24 13:07:35	935309
65	https://zoom.us/en-ca65	22	augue id ante dictum cursus. Nunc mauris elit, 	2017-07-10 19:08:41	612205
66	https://nytimes.com/sub66	51	in,  hendrerit consectetuer,  cursus et,  magna. Praesent	2021-03-08 15:11:58	458352
67	https://bbc.co.uk/en-us67	40	orci lobortis	2020-10-06 20:59:06	795653
68	https://twitter.com/sub68	20	Phasellus dolor elit,  pellentesque	2019-07-04 11:17:56	844187
69	https://facebook.com/sub/cars69	15	purus,  in molestie	2019-02-25 02:54:37	67279
70	http://twitter.com/sub70	53	eleifend vitae,  erat. Vivamus	2018-06-23 11:38:15	260206
71	https://facebook.com/site71	84	ante. Vivamus non lorem vitae	2018-06-07 17:12:53	66287
72	http://nytimes.com/en-us72	22	eu enim. Etiam imperdiet	2018-10-24 05:05:59	585010
73	http://google.com/sub73	23	auctor. Mauris vel turpis.	2018-12-12 02:34:47	36193
74	http://netflix.com/settings74	24	metus. Aliquam erat volutpat. Nulla	2018-12-06 21:45:46	454625
75	http://nytimes.com/en-us76	46	arcu. Vestibulum ante ipsum primis in faucibus orci	2018-03-11 00:15:11	245259
76	https://reddit.com/one76	58	scelerisque mollis.	2020-04-04 23:15:16	348497
77	http://naver.com/user/11077	59	libero et tristique pellentesque,  tellus sem mollis dui,  in	2020-06-02 19:32:34	404538
78	https://whatsapp.com/user/11078	31	Donec est. Nunc ullamcorper,  velit in	2021-05-07 08:22:14	43163
79	http://wikipedia.org/sub79	34	sit amet risus.	2021-05-02 11:55:11	988338
80	https://cnn.com/fr80	39	mattis. Cras eget nisi dictum augue malesuada malesuada.	2017-09-06 21:06:54	978810
81	http://bbc.co.uk/site81	80	sit amet ante. Vivamus non	2020-02-29 09:14:11	654774
82	http://cnn.com/user/11082	85	tortor. Nunc commodo auctor velit. Aliquam nisl.	2020-08-17 06:17:47	9731
83	https://ebay.com/sub83	49	non leo. Vivamus nibh dolor,  nonummy ac,  feugiat non, 	2018-06-17 15:03:33	695543
84	https://wikipedia.org/site84	97	a,  arcu. Sed et libero.	2020-09-28 19:51:41	147314
85	https://guardian.co.uk/site85	98	sagittis felis. Donec tempor,  est ac mattis	2020-07-04 22:15:13	668117
86	https://bbc.co.uk/group/986	80	nascetur ridiculus mus. Aenean	2017-04-28 04:35:01	927617
87	http://google.com/sub/cars87	35	Integer urna. Vivamus molestie dapibus ligula. Aliquam erat volutpat.	2018-09-20 22:15:35	693842
88	http://guardian.co.uk/fr88	4	tellus id nunc interdum feugiat. Sed	2022-06-12 18:15:32	382673
89	https://youtube.com/user/11089	12	ac metus vitae velit egestas lacinia. Sed congue,  elit	2020-08-23 02:57:48	52020
90	https://youtube.com/en-us90	10	Nulla tempor	2022-11-01 10:30:52	484340
91	https://google.com/en-ca91	33	Donec fringilla. Donec feugiat metus	2017-06-09 12:00:47	474529
92	https://naver.com/one92	77	risus. Donec egestas. Duis ac arcu. Nunc mauris. Morbi	2017-07-23 04:57:08	795541
93	http://yahoo.com/group/993	24	dui,  in sodales elit erat	2020-12-21 09:13:48	850484
94	https://whatsapp.com/one94	20	ut	2023-01-30 17:24:06	781224
95	https://bbc.co.uk/one95	73	porttitor scelerisque neque. Nullam nisl. Maecenas malesuada fringilla est. Mauris	2019-09-13 14:42:41	932747
96	http://instagram.com/one96	69	id,  mollis nec,  cursus a,  enim. Suspendisse	2022-04-21 19:55:04	645171
97	https://baidu.com/user/11097	69	justo. Praesent luctus. Curabitur	2022-02-24 13:51:01	893774
98	https://wikipedia.org/sub/cars98	73	ultrices posuere cubilia Curae	2018-10-11 23:30:29	696690
99	https://reddit.com/fr99	55	eu nibh vulputate mauris sagittis placerat. Cras	2022-11-29 12:40:41	556950
100	http://guardian.co.uk/settings111	27	fringilla euismod enim. Etiam gravida molestie	2022-04-12 09:17:42	209682
\.


--
-- Name: communities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vk_user
--

SELECT pg_catalog.setval('public.communities_id_seq', 100, true);


--
-- Name: friendship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vk_user
--

SELECT pg_catalog.setval('public.friendship_id_seq', 100, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vk_user
--

SELECT pg_catalog.setval('public.messages_id_seq', 100, true);


--
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vk_user
--

SELECT pg_catalog.setval('public.photo_id_seq', 100, true);


--
-- Name: subscriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vk_user
--

SELECT pg_catalog.setval('public.subscriptions_id_seq', 100, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vk_user
--

SELECT pg_catalog.setval('public.users_id_seq', 100, true);


--
-- Name: video_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vk_user
--

SELECT pg_catalog.setval('public.video_id_seq', 100, true);


--
-- Name: communities communities_name_key; Type: CONSTRAINT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.communities
    ADD CONSTRAINT communities_name_key UNIQUE (name);


--
-- Name: communities communities_pkey; Type: CONSTRAINT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.communities
    ADD CONSTRAINT communities_pkey PRIMARY KEY (id);


--
-- Name: communities_users communities_users_pkey; Type: CONSTRAINT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.communities_users
    ADD CONSTRAINT communities_users_pkey PRIMARY KEY (community_id, user_id);


--
-- Name: friendship friendship_pkey; Type: CONSTRAINT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.friendship
    ADD CONSTRAINT friendship_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: photo photo_pkey; Type: CONSTRAINT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- Name: photo photo_url_key; Type: CONSTRAINT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_url_key UNIQUE (url);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: video video_pkey; Type: CONSTRAINT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_pkey PRIMARY KEY (id);


--
-- Name: video video_url_key; Type: CONSTRAINT; Schema: public; Owner: vk_user
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_url_key UNIQUE (url);


--
-- PostgreSQL database dump complete
--

