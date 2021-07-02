CREATE TABLE IF NOT EXISTS users (
    user_id serial,
    username character varying(64)  NOT NULL,
    password character varying(64)  NOT NULL,
    email text  NOT NULL,
    bio text ,
    image text ,
    CONSTRAINT users_pkey PRIMARY KEY (user_id),
    CONSTRAINT users_email_key UNIQUE (email),
    CONSTRAINT users_username_key UNIQUE (username)
);

CREATE TABLE IF NOT EXISTS articles (
    article_id serial,
    user_id integer NOT NULL,
    slug text ,
    title text ,
    description text ,
    body text ,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT articles_pkey PRIMARY KEY (article_id),
    CONSTRAINT articles_slug_key UNIQUE (slug),
    CONSTRAINT articles_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES users (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS article_favorites (
    id serial,
    article_id integer NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT article_favorites_pkey PRIMARY KEY (id),
    CONSTRAINT article_favorites_article_id_fkey FOREIGN KEY (article_id)
        REFERENCES articles (article_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT article_favorites_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES users (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS user_follows (
    id serial,
    user_id integer NOT NULL,
    fan_id integer NOT NULL,
    CONSTRAINT user_follows_pkey PRIMARY KEY (id),
    CONSTRAINT user_follows_fan_id_fkey FOREIGN KEY (fan_id)
        REFERENCES users (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_follows_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES users (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

CREATE TABLE IF NOT EXISTS tags (
    tag_id serial,
    name text,
    CONSTRAINT tags_pkey PRIMARY KEY (tag_id)
);

CREATE TABLE IF NOT EXISTS article_tags (
    id serial,
    article_id integer NOT NULL,
    tag_id integer NOT NULL,
    CONSTRAINT article_tags_pkey PRIMARY KEY (id),
    CONSTRAINT article_tags_article_id_fkey FOREIGN KEY (article_id)
        REFERENCES articles (article_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT article_tags_tag_id_fkey FOREIGN KEY (tag_id)
        REFERENCES tags (tag_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS comments (
    comment_id serial,
    body text,
    article_id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT comments_pkey PRIMARY KEY (comment_id),
    CONSTRAINT comments_article_id_fkey FOREIGN KEY (article_id)
        REFERENCES articles (article_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES users (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);