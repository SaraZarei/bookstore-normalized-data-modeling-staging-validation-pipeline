CREATE SCHEMA IF NOT EXISTS staging;
CREATE TABLE staging.Book (
	BookID text,
	Title text,
	AuthID text	
);
CREATE TABLE staging.Author (
	AuthID text,
	First_Name VARCHAR,
	Last_Name VARCHAR,
	Birthday date,
	Country_of_aresidence VARCHAR,
	Hrs_Writing_per_Day numeric		
);
CREATE TABLE staging.Info (
	BookID1 char,
	BookID2 integer,
	Genre VARCHAR,
	SeriesID VARCHAR,
	Volume_Number integer,
	Staff_Comment text		
);
CREATE TABLE staging.Award (
	Award_Name text,
	Title text,
	Year_Won bigint	
);
CREATE TABLE staging.Checkouts (
	BookID text,
	CheckoutMonth integer,
	Number_of_Checkouts integer	
);
CREATE TABLE staging.Edition (
	BookID text,
	ISBN VARCHAR,
	Format VARCHAR,
	PubID VARCHAR,
	Publication_Date date,
	Pages integer,
	Print_Run_Size integer,
	Price numeric
);
CREATE TABLE staging.Publisher (
	PubID VARCHAR,
	Publishing_House VARCHAR,
	City VARCHAR,
	State_Name VARCHAR,
	Country VARCHAR,
	Year_Established integer,
	Marketing_Spend numeric
);
CREATE TABLE staging.Ratings (
	BookID text,
	Rating integer,
	ReviewerID integer,
	ReviewID integer	
);
CREATE TABLE staging.Series (
	SeriesID VARCHAR,
	Series_Name text,
	Planned_Volumes bigint,
	Book_Tour_Events bigint
);
CREATE TABLE staging.Sales_Q1 (
	Sale_Date date,
	ISBN VARCHAR,
	Discount numeric,
	ItemID VARCHAR,
	OrderID VARCHAR
);
CREATE TABLE staging.Sales_Q2 (
	Sale_Date date,
	ISBN VARCHAR,
	Discount numeric,
	ItemID VARCHAR,
	OrderID VARCHAR
);
CREATE TABLE staging.Sales_Q3 (
	Sale_Date date,
	ISBN VARCHAR,
	Discount numeric,
	ItemID VARCHAR,
	OrderID VARCHAR
);
CREATE TABLE staging.Sales_Q4 (
	Sale_Date date,
	ISBN VARCHAR,
	Discount numeric,
	ItemID VARCHAR,
	OrderID VARCHAR
);