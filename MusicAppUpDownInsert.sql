--questions, datatype for dates and datatype for album art????,identitys were taken off because of error adding
--tables
--status_lookup,subscibers,billings,users,app_ratings,user_plays,user_types,
--audio,lyrics,artists,songs,advertisments,albums,song_genre_id,genre
--down-------------------------------------------down------------------------------------------down-----------------------down

--drop 5
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_song_genre_lookup_song_genre_genre_id')
        alter table song_genre_lookup drop constraint fk_song_genre_lookup_song_genre_genre_id 
go    
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_song_genre_lookup_song_genre_id')
        alter table song_genre_lookup drop constraint fk_song_genre_lookup_song_genre_id 
go    
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_albums_album_artist_id_id')
        alter table albums drop constraint fk_albums_album_artist_id_id 
go    
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_albums_album_song_id_id')
        alter table albums drop constraint fk_albums_album_song_id_id 
go    
drop table if exists genres
GO
drop table if exists song_genre_lookup
GO
drop table if exists albums
--drop4
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_advertisement_advertisement_song_id_id')
        alter table advertisements drop constraint fk_advertisement_advertisement_song_id_id 
go      
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_artists_artist_song_id')
        alter table artists drop constraint fk_artists_artist_song_id 
go      
drop table if exists advertisements
go
drop table if exists artists
go
--down--2
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_inputs_input_song_id')
        alter table inputs drop constraint fk_inputs_input_song_id
go
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_inputs_input_user_id')
        alter table inputs drop constraint fk_inputs_input_user_id
go
drop table if exists songs
go
drop table if exists inputs
go
drop table if exists app_ratings

go

--down--1
if exists(select*from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        where CONSTRAINT_NAME='fk_subscriptions_subscriber_user_id')
        alter table subscriptions drop constraint fk_subscriptions_subscriber_user_id
drop table if exists users
go
drop table if exists subscriptions
GO

--up----------------------------------------------up--------------------------------------up------------------------------------------
--up--1


create table subscriptions(
    subscription_id int not null,
    subscription_title varchar(50) not NULL,
    subscriber_status varchar(30) not NULL,
    subscriber_user_id int not NULL,
    constraint pk_subscriptions_suscription_id PRIMARY KEY (subscription_id),
)

--up--2

create table users(
    user_id int not NULL,
    user_username varchar(50) not NULL,
    user_email_address VARCHAR(50) not null,
    user_first_name VARCHAR(50) not NULL,
    user_lastname VARCHAR(50) not null,
    user_phone_number int not null,
    user_street varchar(50) not null,
    user_city varchar(50) not null,
    user_state varchar(50) not null,
    user_zip_code int not null,
    user_credit_card_no varchar(50) not null,
    constraint pk_users_user_id PRIMARY KEY (user_id),
    CONSTRAINT u_users_username unique(user_username),
    CONSTRAINT u_users_user_email_address unique(user_email_address),
)
GO
alter table subscriptions
    add CONSTRAINT fk_subscriptions_subscriber_user_id FOREIGN KEY (subscriber_user_id)
        REFERENCES users(user_id)
go
create table app_ratings(
    app_rating_rating_id int not null,
    app_rating_rating int not NULL,
    app_rating_user_id int not null,
    constraint pk_app_ratings_rating_id PRIMARY KEY (app_rating_rating_id),

)
alter table app_ratings
    add CONSTRAINT fk_app_ratings_app_rating_user_id FOREIGN KEY (app_rating_user_id)
        REFERENCES users(user_id)
go

--up--3
create table inputs(
    input_id int not null,
    input_lyrics varchar(50) not null,
    input_audio varchar(50) not null,
    input_date date not NULL,
    input_user_id int not null,
    input_song_id int null,
    constraint pk_user_plays_compsite_id PRIMARY KEY (input_id),
)
go
create table songs(
    song_id int not null,
    song_song_name varchar(50) not NULL,
    song_lyrics varchar(50) not null,
    song_audio varchar(50) not null,
    song_artist_id varchar(50) not null,
    constraint pk_songs_song_id PRIMARY KEY (song_id),
    constraint u_songs_composite_id unique (song_song_name,song_artist_id)
)


go
alter table inputs
    add CONSTRAINT fk_inputs_input_user_id FOREIGN KEY (input_user_id)
        REFERENCES users(user_id)
go
alter table inputs
    add CONSTRAINT fk_inputs_input_song_id FOREIGN KEY (input_song_id)
        REFERENCES songs(song_id)
go
--up--4
create table artists(
    artist_id int not NULL,
    artist_name varchar(50) not NULL,
    arist_birthdate varchar(30) null,
    artist_birth_city varchar(30) null,
    artist_song_id int not null,
    constraint pk_artists_artist_id PRIMARY KEY (artist_id),
    CONSTRAINT u_artist_artist_name unique (artist_name)
)
go
create table advertisements(
    advertisement_id int not null,
    advertisement_brand_name varchar(50) not null,
    advertisement_status varchar(30) not null,
    advertisement_art varchar(30) null,
    advertisement_song_id int not null,
    constraint pk_advertisements_advertisement_id PRIMARY KEY (advertisement_id),

)
go
alter table artists
    add CONSTRAINT fk_artists_artist_song_id FOREIGN KEY (artist_song_id)
        REFERENCES songs(song_id)
go
alter table advertisements
    add CONSTRAINT fk_advertisement_advertisement_song_id_id FOREIGN KEY (advertisement_song_id)
        REFERENCES songs(song_id)
go
--up--5 -last one babey
create table albums(
    album_id int not null,
    album_title varchar(50) not null,
    album_release_year varchar(30) not null,
    album_art varchar(50) null,
    album_song_id int not null,
    album_artist_id int not null,
    CONSTRAINT pk_albums_album_id primary key(album_id),
    CONSTRAINT u_albums_composite_id unique(album_title,album_artist_id)
)
go
create table song_genre_lookup(
    song_genre_id int not NULL,
    song_genre_genre_id int not null,
    CONSTRAINT pk_song_genre_lookup_composite_id primary key(song_genre_id,song_genre_genre_id),
)
go
create table genres(
    genre_id int not null,
    genre_title varchar(50) not NULL
    CONSTRAINT pk_genres_genre_id primary key(genre_id),
    CONSTRAINT u_genres_genre_title unique (genre_title),
)
go
alter table albums
    add CONSTRAINT fk_albums_album_song_id_id FOREIGN KEY (album_song_id)
        REFERENCES songs(song_id)
go
alter table albums
    add CONSTRAINT fk_albums_album_artist_id_id FOREIGN KEY (album_artist_id)
        REFERENCES artists(artist_id)
go
alter table song_genre_lookup
    add CONSTRAINT fk_song_genre_lookup_song_genre_id FOREIGN KEY (song_genre_id)
        REFERENCES songs(song_id)
go
alter table song_genre_lookup
    add constraint fk_song_genre_lookup_song_genre_genre_id FOREIGN KEY (song_genre_genre_id)
        references genres(genre_id)
go