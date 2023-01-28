use ppub;

-- Challenge 1 - Most Profiting Authors
-- Step 1: Calculate the royalty of each sale for each author and 
-- the advance for each author and publication

SELECT titles.title_id as title, 
		authors.au_id as authors,
		round(titles.advance * titleauthor.royaltyper / 100, 2) as advance,
		round(titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100, 2) as sales_royalty
from authors
right join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
left join sales
on titles.title_id = sales.title_id
ORDER BY authors.au_id;

-- Step 2: Aggregate the total royalties for each title and author
SELECT summary.au_id, summary.title_id, SUM(summary.advance + summary.royalties) AS sum_royalties, advance
FROM (
	SELECT authors.au_id,
		titles.title_id,
		round(titles.advance*titleauthor.royaltyper/100, 2) AS advance, 
		round(titles.price*sales.qty*titles.royalty/100*titleauthor.royaltyper/100, 2) AS royalties
	FROM titles 
	INNER JOIN titleauthor 
	ON titles.title_id=titleauthor.title_id
	RIGHT JOIN authors 
	ON authors.au_id=titleauthor.au_id
	LEFT JOIN sales 
	ON sales.title_id=titles.title_id
) AS summary
GROUP BY au_id, summary.title_id;

-- Step 3: Calculate the total profits of each author-----------
SELECT summary2.au_id, sum(summary2.advance + summary2.royalties) as profits
FROM (
		SELECT summary.au_id, summary.title_id, sum(royalties) as sum_royalties, advance
        FROM (
				SELECT authors.au_id,
						titles.title_id,
                        round(titles.advance * titleauthor.royaltyper/100, 2) as advance,
                        round(titles.price * sales.qty * titles.royalty/100*titleauthor.royaltyper/100, 2) as royalties
				FROM titles
                LEFT JOIN titleauthor
                ON titles.title_id = titleauthor.title_id
                LEFT JOIN authors
                ON authors.au_id = titleauthor.au_id
                LEFT JOIN sales
                ON sales.title_id = titles.title_id) as summary
			) as summary2
GROUP BY summary2.au_id
ORDER BY profits limit 3;
        