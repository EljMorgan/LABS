use ppub;

create or replace view v_author_sales as (
select 
	a.au_id, 
    sum(s.qty) as sales_qty, -- lets also bring through sales_qty
    sum(t.price * s.qty * (t.royalty / 100) * (ta.royaltyper / 100)) 
		as author_sale_amount -- title price * sales quantity * royalty per author * royalty per author : summed to create gain through sales
from authors a
left join titleauthor ta on a.au_id = ta.au_id
left join titles t on ta.title_id = t.title_id
left join sales s on s.title_id = t.title_id
group by 1);

create or replace view v_author_advance as (
select 
	a.au_id, 
    concat(a.au_fname, " ", a.au_lname) as au_name, 
    sum((ta.royaltyper / 100) * t.advance) as author_advance_amount  -- royaltyper(author) is a percentage in integer format so we divide by 100 and multiply by the advance to get that authors share of the advance, we sum to total these advances
from authors a
left join titleauthor ta on a.au_id = ta.au_id
left join titles t on ta.title_id = t.title_id
group by 1, 2);