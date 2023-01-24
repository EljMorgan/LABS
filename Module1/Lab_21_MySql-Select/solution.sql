-- Challenge 1 - Who Have Published What At Where?

select authors.au_lname, titles.title 
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id=titles.title_id
left join publishers
on titles.title_id = publishers.pub_id
order by authors.au_lname asc;

-- Challenge 2 - Who Have Published How Many At Where?
select authors.au_lname, publishers.pub_name, count(titles.title )
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
left join publishers
on titles.pub_id = publishers.pub_id
group by  authors.au_lname, publishers.pub_name 
order by count(titles.title) desc;

-- Challenge 3 - Best Selling Authors
select authors.au_id, authors.au_lname, authors.au_fname, sum(titles.ytd_sales)
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
group by authors.au_id, authors.au_lname, authors.au_fname
order by sum(titles.ytd_sales) desc limit 3 ;

-- Challenge 4 - Best Selling Authors Ranking
select authors.au_id, authors.au_lname, authors.au_fname, IFNULL(sum(titles.ytd_sales), 0)
from authors
left join titleauthor
on authors.au_id = titleauthor.au_id
left join titles
on titleauthor.title_id = titles.title_id
group by authors.au_id, authors.au_lname, authors.au_fname
order by sum(titles.ytd_sales) desc
 ;






