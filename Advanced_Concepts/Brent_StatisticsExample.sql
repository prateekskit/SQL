--- UPDATE STATS
/* SQL Server Statistics Explained with Playing Cards

v0.1 - 2020-08-14
https://BrentOzar.com/go/learnstats
 
This first RAISERROR is just to make sure you don't accidentally hit F5 and
run the entire script. You don't need to run this:
*/
RAISERROR(N'Oops! No, don''t just hit F5. Run these demos one at a time.', 20, 1) WITH LOG;
GO


DROP TABLE IF EXISTS dbo.PlayingCards;
GO
CREATE TABLE dbo.PlayingCards
	(Denomination INT, Suit NVARCHAR(10));

-- Outstanding way to fill up the sample data.

INSERT INTO dbo.PlayingCards(Denomination, Suit)
	SELECT Denominations.Denomination, Suits.Suit
	FROM (VALUES (2), (3), (4), (5), (6), (7), (8), (9), (10)) AS Denominations(Denomination)
	CROSS JOIN (VALUES (N'♥'), (N'♣'), (N'♦'), (N'♠')) AS Suits(Suit)  
	ORDER BY Denominations.Denomination;
GO

SELECT * FROM dbo.PlayingCards ORDER BY Denomination, Suit;

/* Create indexes, which also create stats: */
CREATE INDEX Denomination ON dbo.PlayingCards(Denomination);
CREATE INDEX Suit ON dbo.PlayingCards(Suit);

/* See the stats contents: */
DBCC SHOW_STATISTICS('dbo.PlayingCards', 'Denomination');
DBCC SHOW_STATISTICS('dbo.PlayingCards', 'Suit');


/* Look at estimated rows in the plan: */
SELECT * FROM dbo.PlayingCards
WHERE Denomination = 2 
OPTION (RECOMPILE); /* To prevent auto-param */

SELECT * FROM dbo.PlayingCards
WHERE Denomination = 2
  AND Suit = N'♥' 
  OPTION (RECOMPILE);

/* Why? Because the stats are only on one column: */
DBCC SHOW_STATISTICS('dbo.PlayingCards', 'Denomination');
DBCC SHOW_STATISTICS('dbo.PlayingCards', 'Suit');


/* Try two-column indexes: */
CREATE INDEX Denomination_Suit ON dbo.PlayingCards(Denomination, Suit);
CREATE INDEX Suit_Denomination ON dbo.PlayingCards(Suit, Denomination);

DBCC SHOW_STATISTICS('dbo.PlayingCards', 'Denomination_Suit');
DBCC SHOW_STATISTICS('dbo.PlayingCards', 'Suit_Denomination');

SELECT * FROM dbo.PlayingCards
WHERE Denomination = 2
  AND Suit = N'♥'
  OPTION (RECOMPILE);


/* What if we load more data? */
INSERT INTO dbo.PlayingCards(Denomination, Suit)
	VALUES (2, N'♥');
GO


/* Are the estimates still right? */
SELECT * FROM dbo.PlayingCards
WHERE Denomination = 2
  AND Suit = N'♥'
  OPTION (RECOMPILE);

/* What the stats say? */
DBCC SHOW_STATISTICS('dbo.PlayingCards', 'Denomination_Suit');
DBCC SHOW_STATISTICS('dbo.PlayingCards', 'Suit_Denomination');

UPDATE STATISTICS dbo.PlayingCards WITH FULLSCAN;


/* What the stats say? */
DBCC SHOW_STATISTICS('dbo.PlayingCards', 'Denomination_Suit');
DBCC SHOW_STATISTICS('dbo.PlayingCards', 'Suit_Denomination');


/* How are the estimates now? */
SELECT * FROM dbo.PlayingCards
WHERE Denomination = 2
  AND Suit = N'♥'
  OPTION (RECOMPILE);

/* Hover over the seek to see the full decimal places,
then compare it to this: */
SELECT * FROM dbo.PlayingCards
WHERE Denomination = 3
  AND Suit = N'♥'
  OPTION (RECOMPILE);


/* What the stats say? */
DBCC SHOW_STATISTICS('dbo.PlayingCards', 'Denomination_Suit');


/* Let's update all of the 2s to be hearts: */
UPDATE dbo.PlayingCards
SET Suit = N'♥'
WHERE Denomination = 2;

SELECT * FROM dbo.PlayingCards
WHERE Denomination = 2
  AND Suit = N'♥'
  OPTION (RECOMPILE);


/* And update stats: */
UPDATE STATISTICS dbo.PlayingCards WITH FULLSCAN;

/* What the stats say? */
DBCC SHOW_STATISTICS('dbo.PlayingCards', 'Denomination_Suit');

SELECT * FROM dbo.PlayingCards
WHERE Denomination = 2
  AND Suit = N'♥'
  OPTION (RECOMPILE);

/* Takeaways:

* Stats aren't indexes: they only contain limited metadata
* As your data changes, your stats don't keep up in real time
* Even if you update stats constantly, outliers cause issues

Learn more: https://BrentOzar.com/go/learnstats


Copyright 2020 Brent Ozar Unlimited

Permission is hereby granted, free of charge, to any person 
obtaining a copy of this software and associated documentation 
files (the "Software"), to deal in the Software without 
restriction, including without limitation the rights to use, 
copy, modify, merge, publish, distribute, sublicense, and/or 
sell copies of the Software, and to permit persons to whom the 
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be 
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


*/