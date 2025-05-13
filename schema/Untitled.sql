CREATE TABLE "Book" (
  "BookID" varchar PRIMARY KEY,
  "Title" varchar,
  "AuthID" varchar
);

CREATE TABLE "Ratings" (
  "BookID" varchar PRIMARY KEY,
  "Rating" integer,
  "ReviewerID" integer,
  "ReviewID" integer
);

CREATE TABLE "series" (
  "SeriesID" varchar PRIMARY KEY,
  "Series_name" varchar,
  "Planned_Volumes" integer,
  "Book_Tour_Events" integer
);

CREATE TABLE "Author" (
  "AuthID" varchar PRIMARY KEY,
  "First_Name" varchar,
  "Last_Name" varchar,
  "Birthday" date,
  "Country_of_Residence" varchar,
  "Hrs_Writing_per_Day" decimal
);

CREATE TABLE "SalesQ1" (
  "ISBN" varchar PRIMARY KEY,
  "Sale_Date" date,
  "Discount" decimal,
  "ItemID" date,
  "OrderIDe" varchar
);

CREATE TABLE "SalesQ2" (
  "ISBN" varchar PRIMARY KEY,
  "Sale_Date" date,
  "Discount" decimal,
  "ItemID" date,
  "OrderIDe" varchar
);

CREATE TABLE "SalesQ3" (
  "ISBN" varchar PRIMARY KEY,
  "Sale_Date" date,
  "Discount" decimal,
  "ItemID" date,
  "OrderIDe" varchar
);

CREATE TABLE "SalesQ4" (
  "ISBN" varchar PRIMARY KEY,
  "Sale_Date" date,
  "Discount" decimal,
  "ItemID" date,
  "OrderIDe" varchar
);

CREATE TABLE "Info" (
  "BookID1" char(2) PRIMARY KEY,
  "BookID2" integer,
  "virtual_bookid" varchar,
  "Genre" varchar,
  "SeriesID" varchar,
  "Volume_Number" ineteger,
  "Staff_Comment" text
);

CREATE TABLE "Award" (
  "Title" text PRIMARY KEY,
  "Award_Name" varchar,
  "Year_Won" integer
);

CREATE TABLE "Checkouts" (
  "BookID" varchar PRIMARY KEY,
  "CheckoutMonthe" integer,
  "Number_of_Checkouts" integer
);

CREATE TABLE "Edition" (
  "ISBN" varchar(20) PRIMARY KEY,
  "BookID" varchar(10),
  "Format" varchar(50),
  "PubID" varchar(10),
  "Publication_Date" date,
  "Pages" integer,
  "Print_Run_Size" integer,
  "Price" decimal
);

CREATE TABLE "Publisher" (
  "PubID" varchar(10) PRIMARY KEY,
  "Publishing_House" varchar(50),
  "City" varchar(50),
  "State" varchar(50),
  "Country" varchar(50),
  "Year_Established" integer,
  "Marketing_Spend" decimal
);

COMMENT ON COLUMN "Info"."virtual_bookid" IS 'Simulated for diagram join: bookid1 + bookid2';

ALTER TABLE "Book" ADD FOREIGN KEY ("AuthID") REFERENCES "Author" ("AuthID");

ALTER TABLE "Ratings" ADD FOREIGN KEY ("BookID") REFERENCES "Book" ("BookID");

ALTER TABLE "Checkouts" ADD FOREIGN KEY ("BookID") REFERENCES "Book" ("BookID");

ALTER TABLE "Info" ADD FOREIGN KEY ("SeriesID") REFERENCES "series" ("SeriesID");

ALTER TABLE "Edition" ADD FOREIGN KEY ("BookID") REFERENCES "Book" ("BookID");

ALTER TABLE "SalesQ3" ADD FOREIGN KEY ("ISBN") REFERENCES "Edition" ("ISBN");

ALTER TABLE "SalesQ4" ADD FOREIGN KEY ("ISBN") REFERENCES "Edition" ("ISBN");

ALTER TABLE "SalesQ2" ADD FOREIGN KEY ("ISBN") REFERENCES "Edition" ("ISBN");

ALTER TABLE "SalesQ1" ADD FOREIGN KEY ("ISBN") REFERENCES "Edition" ("ISBN");

ALTER TABLE "Edition" ADD FOREIGN KEY ("PubID") REFERENCES "Publisher" ("PubID");

ALTER TABLE "Book" ADD FOREIGN KEY ("BookID") REFERENCES "Info" ("virtual_bookid");

ALTER TABLE "Award" ADD FOREIGN KEY ("Title") REFERENCES "Book" ("BookID");
