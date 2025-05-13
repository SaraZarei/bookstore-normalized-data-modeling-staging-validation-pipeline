-- 1. Load author
INSERT INTO "Production"."Author" ("AuthID", "First_Name", "Last_Name", "Birthday","Country_of_Residence", "Hrs_Writing_per_Day")
SELECT *
FROM "staging"."Author" a 
--It prevents duplicates 
ON CONFLICT ("AuthID") DO NOTHING;

-- 2. Load book
INSERT INTO "Production"."Book" ("BookID", "AuthID")
SELECT b."BookID", b."AuthID" 
FROM "staging"."Book" b
JOIN "staging"."Author" a 
ON a."AuthID" = b."AuthID"
ON CONFLICT ("BookID") DO NOTHING;

-- See "AuthorID" in staging that don't exist in Book table
SELECT * 
FROM "staging"."Book" b
--This part in Production."Author" table ignores
--rows  that "AuthID" for them is the same with "AuthID" of book table 
WHERE NOT EXISTS (
    SELECT 1
	FROM "Production"."Book" a 
	WHERE a."AuthID" = b."AuthID"
);

-- 3. Load Rating
INSERT INTO "Production"."Ratings"  ("BookID","Rating","ReviewerID","ReviewID")
SELECT r."BookID", r."Rating", r."ReviewerID", r."ReviewID"
FROM "staging"."Ratings" r
JOIN "staging"."Book" b
ON r."BookID" = b."BookID"
ON CONFLICT DO NOTHING;

-- See BookIDs in staging that don't exist in Book table and 
-- have been not allowed to insert to "Rating" table because of "BookID" FK
SELECT * 
FROM "staging"."Ratings" b
WHERE NOT EXISTS (
    SELECT 1
	FROM "Production"."Ratings" a 
	WHERE a."BookID" = b."BookID");

-- 4. Load publisher
INSERT INTO "Production"."Publisher" (
    "PubID", "Publishing_House", "City", 
    "State_Name", "Country", "Year_Established", "Marketing_Spend"
)
SELECT *
FROM "staging"."Publisher" p
ON CONFLICT ("PubID") DO NOTHING;


--5. Load Edition
INSERT INTO "Production"."Edition" ("ISBN","BookID","Format","PubID","Publication_Date","Pages","Print_Run_Size","Price")

select e."ISBN",e."BookID",e."Format",e."PubID",e."Publication_Date",e."Pages",e."Print_Run_Size",e."Price"
from "staging"."Edition" e
join "staging"."Book" b
on e."BookID"=b."BookID"
join "staging"."Publisher" p
on e."PubID"= p."PubID"
ON CONFLICT ("ISBN") DO NOTHING;
-- See which rows in staging have not been inserted into production
SELECT * 
FROM "staging"."Edition" s
WHERE NOT EXISTS (
    SELECT 1
	FROM "Production"."Edition" p 
	WHERE s."BookID" = p."BookID" AND  s."PubID" = p."PubID"

)
-- 6. Load sale_Q1 tables
INSERT INTO "Production"."Sales_Q1" ("ISBN", "Sale_Date", "Discount", "ItemID", "OrderID")
SELECT s."ISBN", s."Sale_Date", s."Discount", s."ItemID", s."OrderID"
FROM "staging"."Sales_Q1" s
ON CONFLICT DO NOTHING;
-- See which rows in staging have not been inserted into production
SELECT * 
FROM "staging"."Sales_Q1" s
WHERE NOT EXISTS (
    SELECT 1
	FROM "Production"."Sales_Q1" p 
	WHERE s."ISBN" = p."ISBN" 

)
-- 7. Load sale_Q2 tables
INSERT INTO "Production"."Sales_Q1" ("ISBN", "Sale_Date", "Discount", "ItemID", "OrderID")
SELECT s."ISBN", s."Sale_Date", s."Discount", s."ItemID", s."OrderID"
FROM "staging"."Sales_Q2" s
ON CONFLICT DO NOTHING;
-- See which rows in staging have not been inserted into production
SELECT * 
FROM "staging"."Sales_Q2" s
WHERE NOT EXISTS (
    SELECT 1
	FROM "Production"."Sales_Q2" p 
	WHERE s."ISBN" = p."ISBN" 

)
-- 8. Load sale_Q3 tables
INSERT INTO "Production"."Sales_Q1" ("ISBN", "Sale_Date", "Discount", "ItemID", "OrderID")
SELECT s."ISBN", s."Sale_Date", s."Discount", s."ItemID", s."OrderID"
FROM "staging"."Sales_Q3" s
ON CONFLICT DO NOTHING;
-- See which rows in staging have not been inserted into production
SELECT * 
FROM "staging"."Sales_Q3" s
WHERE NOT EXISTS (
    SELECT 1
	FROM "Production"."Sales_Q3" p 
	WHERE s."ISBN" = p."ISBN" 

)
-- 9. Load sale_Q4 tables
INSERT INTO "Production"."Sales_Q1" ("ISBN", "Sale_Date", "Discount", "ItemID", "OrderID")
SELECT s."ISBN", s."Sale_Date", s."Discount", s."ItemID", s."OrderID"
FROM "staging"."Sales_Q4" s
ON CONFLICT DO NOTHING;
-- See which rows in staging have not been inserted into production
SELECT * 
FROM "staging"."Sales_Q4" s
WHERE NOT EXISTS (
    SELECT 1
	FROM "Production"."Sales_Q4" p 
	WHERE s."ISBN" = p."ISBN" 

)

--10. Load Checkouts
INSERT INTO "Production"."Checkouts" ("BookID","CheckoutMonth","Number_of_Checkouts")

select c."BookID",c."CheckoutMonth",c."Number_of_Checkouts"
from "staging"."Checkouts" c
join "staging"."Book" b
on c."BookID"=b."BookID"
ON CONFLICT ("BookID","CheckoutMonth") DO NOTHING;
-- See which rows in staging have not been inserted into production
SELECT * 
FROM "staging"."Checkouts" s
WHERE NOT EXISTS (
   SELECT 1
	FROM "Production"."Checkouts" p 
	WHERE s."BookID" = p."BookID" 

)
-- 11. Load Series tables
INSERT INTO "Production"."Series" ("SeriesID", "Series_Name", "Planned_Volumes", "Book_Tour_Events")
SELECT s."SeriesID", s."Series_Name", s."Planned_Volumes", s."Book_Tour_Events"
FROM "staging"."Series" s
ON CONFLICT DO NOTHING;
-- See which rows in staging have not been inserted into production
SELECT * 
FROM "staging"."Series" s
WHERE NOT EXISTS (
   SELECT 1
	FROM "Production"."Series" p 
	WHERE s."SeriesID" = p."SeriesID" 

)
--12. Load Info
INSERT INTO "Production"."Info" ("BookID1","BookID2","BookID","Genre","SeriesID","Volume_Number","Staff_Comment")

select  
	i."BookID1",i."BookID2",
	i."BookID1" || i."BookID2",
	i."Genre",i."SeriesID",i."Volume_Number",i."Staff_Comment"
from "staging"."Info" i
WHERE EXISTS (
    SELECT 1 
    FROM "staging"."Book" b 
    WHERE b."BookID" = i."BookID1" || i."BookID2"
)
AND EXISTS (
    SELECT 1 
    FROM "staging"."Series" s 
    WHERE s."SeriesID" = i."SeriesID"
)
ON CONFLICT ("BookID") DO NOTHING;

-- See which rows in staging have not been inserted into production
SELECT * 
FROM "staging"."Info" i
WHERE NOT EXISTS (
   SELECT 1
	FROM "Production"."Series" p 
	WHERE i."SeriesID" = p."SeriesID" 

)

--13. Load Award
INSERT INTO "Production"."Award" ("BookID","Title","Award_Name","Year_Won")

select  
	b."BookID",
	a."Title",a."Award_Name",a."Year_Won"
from "staging"."Award" a
JOIN "Production"."Book" b 
ON a."Title"= b."Title"
ON CONFLICT ("BookID") DO NOTHING;
-- See which rows in staging have not been inserted into production
SELECT *
FROM "staging"."Award" s
WHERE NOT EXISTS(
	SELECT 1
	FROM "Production"."Award" p
	WHERE s."Title" = p."Title"
)
-------------------------------------------------
CREATE TABLE Item (
  ItemID PRIMARY KEY,
  ISBN TEXT REFERENCES Edition(ISBN)
);

INSERT INTO Item (ItemID, ISBN)
SELECT DISTINCT ItemID, ISBN
FROM Sales;

ALTER TABLE Sales DROP COLUMN ISBN;
