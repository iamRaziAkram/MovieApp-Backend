-- Copyright 2018-2019, https://beingtechie.io

-- Script: db-setup-boards.sql
-- Description: Create movies specific tables and grant privileges
-- Version: 1.0
-- Author: Thribhuvan Krishnamurthy

-- # Step 1 - GENRES table

DROP TABLE IF EXISTS movieapp.GENRES CASCADE;
CREATE TABLE IF NOT EXISTS movieapp.GENRES (
	ID SERIAL PRIMARY KEY,
    UUID VARCHAR(36) NOT NULL,
    GENRE VARCHAR(100) NOT NULL,
    DESCRIPTION VARCHAR(1000),
    CREATED_BY VARCHAR(100) NOT NULL ,
    CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON TABLE movieapp.GENRES IS 'Table to capture GENRES';
COMMENT ON COLUMN movieapp.GENRES.ID IS 'Auto generated PK identifier';
COMMENT ON COLUMN movieapp.GENRES.UUID IS 'Unique identifier used as reference by external systems';
COMMENT ON COLUMN movieapp.GENRES.GENRE IS 'Title of the genre';
COMMENT ON COLUMN movieapp.GENRES.DESCRIPTION IS 'Description of the genre';
COMMENT ON COLUMN movieapp.GENRES.CREATED_BY IS 'User who inserted this record';
COMMENT ON COLUMN movieapp.GENRES.CREATED_AT IS 'Point in time when this record was inserted';

ALTER TABLE movieapp.GENRES OWNER TO postgres;

-- # Step 2 - MOVIES table

DROP TABLE IF EXISTS movieapp.MOVIES CASCADE;
CREATE TABLE IF NOT EXISTS movieapp.MOVIES (
	ID SERIAL PRIMARY KEY,
    UUID VARCHAR(36) NOT NULL,
    VERSION SERIAL NOT NULL,
    TITLE VARCHAR(100) NOT NULL,
    DURATION SMALLINT NOT NULL,
    STORYLINE VARCHAR(2000) NOT NULL,
    POSTER_URL VARCHAR(2000) NOT NULL,
    TRAILER_URL VARCHAR(2000) NOT NULL,
    OFFICIAL_WEBSITE_URL VARCHAR(2000),
    WIKI_URL VARCHAR(2000),
    RELEASE_AT TIMESTAMP NOT NULL,
    CENSOR_BOARD_RATING VARCHAR(3) NOT NULL,
    CRITICS_RATING NUMERIC(2,1) DEFAULT 0,
    USERS_RATING NUMERIC(2,1) DEFAULT 0,
    STATUS VARCHAR(30) NOT NULL,
    CREATED_BY VARCHAR(100) NOT NULL ,
    CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    MODIFIED_BY VARCHAR(100) NULL,
    MODIFIED_AT TIMESTAMP NULL
);
COMMENT ON TABLE movieapp.MOVIES IS 'Table to capture MOVIES';
COMMENT ON COLUMN movieapp.MOVIES.ID IS 'Auto generated PK identifier';
COMMENT ON COLUMN movieapp.MOVIES.UUID IS 'Unique identifier used as reference by external systems';
COMMENT ON COLUMN movieapp.MOVIES.VERSION IS 'Versioning for optimistic locking';
COMMENT ON COLUMN movieapp.MOVIES.TITLE IS 'Title of the movie';
COMMENT ON COLUMN movieapp.MOVIES.DURATION IS 'Duration (in minutes) of the movie';
COMMENT ON COLUMN movieapp.MOVIES.STORYLINE IS 'Storyline of the movie';
COMMENT ON COLUMN movieapp.MOVIES.POSTER_URL IS 'Poster url of the movie';
COMMENT ON COLUMN movieapp.MOVIES.TRAILER_URL IS 'Poster url of the movie';
COMMENT ON COLUMN movieapp.MOVIES.OFFICIAL_WEBSITE_URL IS 'Official website url of the movie';
COMMENT ON COLUMN movieapp.MOVIES.WIKI_URL IS 'Wiki url of the movie';
COMMENT ON COLUMN movieapp.MOVIES.RELEASE_AT IS 'Point in time when this movie will be release';
COMMENT ON COLUMN movieapp.MOVIES.CENSOR_BOARD_RATING IS 'Rating of the movie issued by Censor Board - U, A, UA';
COMMENT ON COLUMN movieapp.MOVIES.CRITICS_RATING IS 'Average rating provided by the film critics for the movie';
COMMENT ON COLUMN movieapp.MOVIES.USERS_RATING IS 'Average rating provided by the users for the movie';
COMMENT ON COLUMN movieapp.MOVIES.STATUS IS 'Status of the movie - PUBLISHED, RELEASED, CLOSED, DELETED';
COMMENT ON COLUMN movieapp.MOVIES.CREATED_BY IS 'User who inserted this record';
COMMENT ON COLUMN movieapp.MOVIES.CREATED_AT IS 'Point in time when this record was inserted';
COMMENT ON COLUMN movieapp.MOVIES.MODIFIED_BY IS 'User who modified this record';
COMMENT ON COLUMN movieapp.MOVIES.MODIFIED_AT IS 'Point in time when this record was modified';

ALTER TABLE movieapp.MOVIES OWNER TO postgres;

-- # Step 3 - MOVIE_GENRES table
DROP TABLE IF EXISTS movieapp.MOVIE_GENRES CASCADE;
CREATE TABLE IF NOT EXISTS movieapp.MOVIE_GENRES (
   ID SERIAL PRIMARY KEY,
   MOVIE_ID INTEGER NOT NULL,
   GENRE_ID INTEGER NOT NULL,
   CREATED_BY VARCHAR(100) NOT NULL,
   CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON TABLE movieapp.MOVIE_GENRES IS 'Table to map movie with genres';
COMMENT ON COLUMN movieapp.MOVIE_GENRES.ID IS 'Auto generated PK identifier';
COMMENT ON COLUMN movieapp.MOVIE_GENRES.MOVIE_ID IS 'Movie that has these artists';
COMMENT ON COLUMN movieapp.MOVIE_GENRES.GENRE_ID IS 'Genre that the movie belongs to';
COMMENT ON COLUMN movieapp.MOVIE_GENRES.CREATED_BY IS 'User who inserted this record';
COMMENT ON COLUMN movieapp.MOVIE_GENRES.CREATED_AT IS 'Point in time when this record was inserted';

ALTER TABLE movieapp.MOVIE_GENRES OWNER TO postgres;
ALTER TABLE movieapp.MOVIE_GENRES ADD CONSTRAINT FK_MOVIE_GENRES_MOVIE_ID FOREIGN KEY(MOVIE_ID) REFERENCES movieapp.MOVIES(ID);
ALTER TABLE movieapp.MOVIE_GENRES ADD CONSTRAINT FK_MOVIE_GENRES_GENRE_ID FOREIGN KEY(GENRE_ID) REFERENCES movieapp.GENRES(ID);

-- # Step 4 - ARTISTS table
DROP TABLE IF EXISTS movieapp.ARTISTS CASCADE;
CREATE TABLE movieapp.ARTISTS(
	ID SERIAL PRIMARY KEY,
	UUID VARCHAR(36) NOT NULL,
	VERSION SERIAL NOT NULL,
    FIRST_NAME VARCHAR(50) NOT NULL,
    LAST_NAME VARCHAR(50) NOT NULL,
    TYPE VARCHAR(50) NOT NULL,
    PROFILE_DESCRIPTION VARCHAR(2000),
    PROFILE_PICTURE_URL VARCHAR(2000) NOT NULL,
    WIKI_URL VARCHAR(2000),
    ACTIVE BOOLEAN NOT NULL DEFAULT TRUE,
	CREATED_BY VARCHAR(100) NOT NULL,
	CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	MODIFIED_BY VARCHAR(100),
	MODIFIED_AT TIMESTAMP
);
COMMENT ON TABLE movieapp.ARTISTS IS 'Table to capture Artists';
COMMENT ON COLUMN movieapp.ARTISTS.ID IS 'Auto generated PK identifier';
COMMENT ON COLUMN movieapp.ARTISTS.UUID IS 'Unique identifier used as reference by external systems';
COMMENT ON COLUMN movieapp.ARTISTS.VERSION IS 'Versioning for optimistic locking';
COMMENT ON COLUMN movieapp.ARTISTS.FIRST_NAME IS 'First name of an artist';
COMMENT ON COLUMN movieapp.ARTISTS.LAST_NAME IS 'Last name of an artist';
COMMENT ON COLUMN movieapp.ARTISTS.TYPE IS 'Type of an artist - DIRECTOR, PRODUCER, ACTOR, CINEMATOGRAPHER, MUSICIAN, STUNTMAN';
COMMENT ON COLUMN movieapp.ARTISTS.PROFILE_DESCRIPTION IS 'Profile description of an artist';
COMMENT ON COLUMN movieapp.ARTISTS.PROFILE_PICTURE_URL IS 'Profile picture url of an artist';
COMMENT ON COLUMN movieapp.ARTISTS.WIKI_URL IS 'Wiki url of an artist';
COMMENT ON COLUMN movieapp.ARTISTS.ACTIVE IS 'Active status of an artist - INACTIVE(0), ACTIVE(1)';
COMMENT ON COLUMN movieapp.ARTISTS.CREATED_BY IS 'User who inserted this record';
COMMENT ON COLUMN movieapp.ARTISTS.CREATED_AT IS 'Point in time when this record was inserted';
COMMENT ON COLUMN movieapp.ARTISTS.MODIFIED_BY IS 'User who modified this record';
COMMENT ON COLUMN movieapp.ARTISTS.MODIFIED_AT IS 'Point in time when this record was modified';

ALTER TABLE movieapp.ARTISTS OWNER TO postgres;

-- # Step 5 - MOVIE_ARTISTS table
DROP TABLE IF EXISTS movieapp.MOVIE_ARTISTS CASCADE;
CREATE TABLE IF NOT EXISTS movieapp.MOVIE_ARTISTS (
   ID SERIAL PRIMARY KEY,
   MOVIE_ID INTEGER NOT NULL,
   ARTIST_ID INTEGER NOT NULL,
   CREATED_BY VARCHAR(100) NOT NULL,
   CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON TABLE movieapp.MOVIE_ARTISTS IS 'Table to map movie with artists';
COMMENT ON COLUMN movieapp.MOVIE_ARTISTS.ID IS 'Auto generated PK identifier';
COMMENT ON COLUMN movieapp.MOVIE_ARTISTS.MOVIE_ID IS 'Movie that has these artists';
COMMENT ON COLUMN movieapp.MOVIE_ARTISTS.ARTIST_ID IS 'Artists who will be mapped to the Movie';
COMMENT ON COLUMN movieapp.MOVIE_ARTISTS.CREATED_BY IS 'User who inserted this record';
COMMENT ON COLUMN movieapp.MOVIE_ARTISTS.CREATED_AT IS 'Point in time when this record was inserted';

ALTER TABLE movieapp.MOVIE_ARTISTS OWNER TO postgres;
ALTER TABLE movieapp.MOVIE_ARTISTS ADD CONSTRAINT FK_MOVIE_ARTISTS_MOVIE_ID FOREIGN KEY(MOVIE_ID) REFERENCES movieapp.MOVIES(ID);
ALTER TABLE movieapp.MOVIE_ARTISTS ADD CONSTRAINT FK_MOVIE_ARTISTS_ARTIST_ID FOREIGN KEY(ARTIST_ID) REFERENCES movieapp.ARTISTS(ID);

-- # Step 6 - THEATRES table
DROP TABLE IF EXISTS movieapp.THEATRES CASCADE;
CREATE TABLE movieapp.THEATRES(
	ID SERIAL PRIMARY KEY,
	UUID VARCHAR(36) NOT NULL,
	VERSION SERIAL NOT NULL,
    NAME VARCHAR(50) NOT NULL,
    POSTAL_ADDRESS VARCHAR(2000),
    CITY VARCHAR(3) NOT NULL,
	CREATED_BY VARCHAR(100) NOT NULL,
	CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	MODIFIED_BY VARCHAR(100),
	MODIFIED_AT TIMESTAMP
);
COMMENT ON TABLE movieapp.THEATRES IS 'Table to capture Theatres';
COMMENT ON COLUMN movieapp.THEATRES.ID IS 'Auto generated PK identifier';
COMMENT ON COLUMN movieapp.THEATRES.UUID IS 'Unique identifier used as reference by external systems';
COMMENT ON COLUMN movieapp.THEATRES.VERSION IS 'Versioning for optimistic locking';
COMMENT ON COLUMN movieapp.THEATRES.NAME IS 'name of the theatre';
COMMENT ON COLUMN movieapp.THEATRES.POSTAL_ADDRESS IS 'Postal address of the theatre';
COMMENT ON COLUMN movieapp.THEATRES.CITY IS 'City to which the theatre belongs to';
COMMENT ON COLUMN movieapp.THEATRES.CREATED_BY IS 'User who inserted this record';
COMMENT ON COLUMN movieapp.THEATRES.CREATED_AT IS 'Point in time when this record was inserted';
COMMENT ON COLUMN movieapp.THEATRES.MODIFIED_BY IS 'User who modified this record';
COMMENT ON COLUMN movieapp.THEATRES.MODIFIED_AT IS 'Point in time when this record was modified';

ALTER TABLE movieapp.THEATRES OWNER TO postgres;
ALTER TABLE movieapp.THEATRES ADD CONSTRAINT UK_THEATRES_NAME UNIQUE(NAME);

-- # Step 7 - MOVIE_SHOWS table
DROP TABLE IF EXISTS movieapp.MOVIE_SHOWS CASCADE;
CREATE TABLE movieapp.MOVIE_SHOWS(
	ID SERIAL PRIMARY KEY,
	UUID VARCHAR(36) NOT NULL,
	VERSION SERIAL NOT NULL,
	MOVIE_ID INTEGER NOT NULL,
    THEATRE_ID INTEGER NOT NULL,
    SHOW_TIMING TIMESTAMP NOT NULL,
    LANG VARCHAR(50) NOT NULL,
    PRICE NUMERIC(4,2) NOT NULL,
    AVAILABLE_SEATS SMALLINT NOT NULL,
	CREATED_BY VARCHAR(100) NOT NULL,
	CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	MODIFIED_BY VARCHAR(100),
	MODIFIED_AT TIMESTAMP
);
COMMENT ON TABLE movieapp.MOVIE_SHOWS IS 'Table to capture Movie Shows';
COMMENT ON COLUMN movieapp.MOVIE_SHOWS.ID IS 'Auto generated PK identifier';
COMMENT ON COLUMN movieapp.MOVIE_SHOWS.UUID IS 'Unique identifier used as reference by external systems';
COMMENT ON COLUMN movieapp.MOVIE_SHOWS.VERSION IS 'Versioning for optimistic locking';
COMMENT ON COLUMN movieapp.MOVIE_SHOWS.MOVIE_ID IS 'Movie that is part of this show';
COMMENT ON COLUMN movieapp.MOVIE_SHOWS.THEATRE_ID IS 'Theatre where movie is shown';
COMMENT ON COLUMN movieapp.MOVIE_SHOWS.SHOW_TIMING IS 'Show timing of the movie';
COMMENT ON COLUMN movieapp.MOVIE_SHOWS.LANG IS 'Language of the movie for this show';
COMMENT ON COLUMN movieapp.MOVIE_SHOWS.PRICE IS 'Price of the movie for this show';
COMMENT ON COLUMN movieapp.MOVIE_SHOWS.AVAILABLE_SEATS IS 'Available seats for the show';
COMMENT ON COLUMN movieapp.MOVIE_SHOWS.CREATED_BY IS 'User who inserted this record';
COMMENT ON COLUMN movieapp.MOVIE_SHOWS.CREATED_AT IS 'Point in time when this record was inserted';
COMMENT ON COLUMN movieapp.MOVIE_SHOWS.MODIFIED_BY IS 'User who modified this record';
COMMENT ON COLUMN movieapp.MOVIE_SHOWS.MODIFIED_AT IS 'Point in time when this record was modified';

ALTER TABLE movieapp.MOVIE_SHOWS OWNER TO postgres;
ALTER TABLE movieapp.MOVIE_SHOWS ADD CONSTRAINT FK_MOVIE_SHOWS_MOVIE_ID FOREIGN KEY(MOVIE_ID) REFERENCES movieapp.MOVIES(ID);
ALTER TABLE movieapp.MOVIE_SHOWS ADD CONSTRAINT FK_MOVIE_SHOWS_THEATRE_ID FOREIGN KEY(THEATRE_ID) REFERENCES movieapp.THEATRES(ID);


-- # Step 8 - SHOW_BOOKINGS table
DROP TABLE IF EXISTS movieapp.SHOW_BOOKINGS CASCADE;
CREATE TABLE movieapp.SHOW_BOOKINGS(
	ID SERIAL PRIMARY KEY,
	UUID VARCHAR(36) NOT NULL,
	VERSION SERIAL NOT NULL,
	CUSTOMER_ID INTEGER NOT NULL,
    MOVIE_SHOW_ID INTEGER NOT NULL,
    TOTAL_TICKETS SMALLINT NOT NULL,
    TOTAL_PRICE SMALLINT NOT NULL,
    STATUS VARCHAR(30) NOT NULL,
    BOOKING_AT TIMESTAMP NOT NULL,
    CANCELLED_AT TIMESTAMP,
	CREATED_BY VARCHAR(100) NOT NULL,
	CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	MODIFIED_BY VARCHAR(100),
	MODIFIED_AT TIMESTAMP
);
COMMENT ON TABLE movieapp.SHOW_BOOKINGS IS 'Table to capture Movie Show Bookings';
COMMENT ON COLUMN movieapp.SHOW_BOOKINGS.ID IS 'Auto generated PK identifier';
COMMENT ON COLUMN movieapp.SHOW_BOOKINGS.UUID IS 'Unique identifier used as reference by external systems';
COMMENT ON COLUMN movieapp.SHOW_BOOKINGS.VERSION IS 'Versioning for optimistic locking';
COMMENT ON COLUMN movieapp.SHOW_BOOKINGS.CUSTOMER_ID IS 'Customer who has booked a seat';
COMMENT ON COLUMN movieapp.SHOW_BOOKINGS.MOVIE_SHOW_ID IS 'Movie show that has been booked for';
COMMENT ON COLUMN movieapp.SHOW_BOOKINGS.TOTAL_TICKETS IS 'Total number of tickets booked';
COMMENT ON COLUMN movieapp.SHOW_BOOKINGS.TOTAL_PRICE IS 'Total price for the tickets that were booked';
COMMENT ON COLUMN movieapp.SHOW_BOOKINGS.STATUS IS 'Status of the Booking - CONFIRMED,CANCELLED';
COMMENT ON COLUMN movieapp.SHOW_BOOKINGS.BOOKING_AT IS 'Point in time when this booking was confirmed';
COMMENT ON COLUMN movieapp.SHOW_BOOKINGS.CANCELLED_AT IS 'Point in time when this booking was cancelled';
COMMENT ON COLUMN movieapp.SHOW_BOOKINGS.CREATED_BY IS 'User who inserted this record';
COMMENT ON COLUMN movieapp.SHOW_BOOKINGS.CREATED_AT IS 'Point in time when this record was inserted';
COMMENT ON COLUMN movieapp.SHOW_BOOKINGS.MODIFIED_BY IS 'User who modified this record';
COMMENT ON COLUMN movieapp.SHOW_BOOKINGS.MODIFIED_AT IS 'Point in time when this record was modified';

ALTER TABLE movieapp.SHOW_BOOKINGS OWNER TO postgres;
ALTER TABLE movieapp.SHOW_BOOKINGS ADD CONSTRAINT FK_SHOW_BOOKINGS_MOVIE_SHOW_ID FOREIGN KEY(MOVIE_SHOW_ID) REFERENCES movieapp.MOVIE_SHOWS(ID);
ALTER TABLE movieapp.SHOW_BOOKINGS ADD CONSTRAINT FK_SHOW_BOOKINGS_CUSTOMER_ID FOREIGN KEY(CUSTOMER_ID) REFERENCES movieapp.USERS(ID);

-- # Step 9 - BOOKING_TICKETS table
DROP TABLE IF EXISTS movieapp.BOOKING_TICKETS CASCADE;
CREATE TABLE IF NOT EXISTS movieapp.BOOKING_TICKETS (
   ID SERIAL PRIMARY KEY,
   SHOW_BOOKING_ID INTEGER NOT NULL,
   TICKET_NUMBER INTEGER NOT NULL,
   CREATED_BY VARCHAR(100) NOT NULL,
   CREATED_AT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON TABLE movieapp.BOOKING_TICKETS IS 'Table to map movie with Booking Tickets';
COMMENT ON COLUMN movieapp.BOOKING_TICKETS.ID IS 'Auto generated PK identifier';
COMMENT ON COLUMN movieapp.BOOKING_TICKETS.SHOW_BOOKING_ID IS 'Booking that this ticket belongs to';
COMMENT ON COLUMN movieapp.BOOKING_TICKETS.TICKET_NUMBER IS 'Ticket Number';
COMMENT ON COLUMN movieapp.BOOKING_TICKETS.CREATED_BY IS 'User who inserted this record';
COMMENT ON COLUMN movieapp.BOOKING_TICKETS.CREATED_AT IS 'Point in time when this record was inserted';

ALTER TABLE movieapp.BOOKING_TICKETS OWNER TO postgres;
ALTER TABLE movieapp.BOOKING_TICKETS ADD CONSTRAINT UK_BOOKING_TICKETS_TICKET_NUMBER UNIQUE(TICKET_NUMBER);
ALTER TABLE movieapp.BOOKING_TICKETS ADD CONSTRAINT FK_BOOKING_TICKETS_SHOW_BOOKING_ID FOREIGN KEY(SHOW_BOOKING_ID) REFERENCES movieapp.SHOW_BOOKINGS(ID);

-- # Step 10 - Commit Transaction
COMMIT;

-- ********** End of setup **********