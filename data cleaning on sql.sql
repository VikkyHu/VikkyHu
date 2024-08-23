
SELECT * from `layoffs (1)`;

create table layoff_stand
like `layoffs (1)`;

SELECT * from layoff_stand;

insert layoff_stand
select *
 from `layoffs (1)`;
 
 select *,
 row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions)as row_num
 from layoff_stand;
 
 with duplicate_cte as
 (
 select *,
 row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions)as row_num
 from layoff_stand
 )
delete 
from  duplicate_cte
where row_num > 1;

CREATE TABLE `layoff_standing` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoff_standing
where row_num > 1;

insert into layoff_standing
select *,
 row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions)as row_num
 from layoff_stand;

 
 
 delete 
 from layoff_standing
 where row_num > 1;
 

select * from layoff_standing;

select company, trim(company)
from layoff_standing;

update layoff_standing
set company = trim(company);

select distinct industry
from layoff_standing;


select distinct country
from layoff_standing;


select distinct country, trim(trailing '.' from country)
from layoff_standing;

update layoff_standing
set country = trim(trailing '.' from country)
where country like 'United States%' ;

 select*from layoff_standing
 where total_laid_off is null
 and percentage_laid_off is null;
 
select * from layoff_standing
where industry is null
or industry = '';

update layoff_standing
set industry = null
where industry ='';

select * from layoff_standing
where company like 'Airbnb';

 
 select t1.industry,t2.industry 
 from layoff_standing t1
 join layoff_standing t2
 on t1.company=t2.company
 where (t1.industry is null or t1.industry='')
 and t2.industry is not null;
 

 update layoff_standing t1
 join layoff_standing t2
 on t1.company=t2.company
 set t1.industry=t2.industry
 where t1.industry is null 
 and t2.industry is not null;
 
 select * from layoff_standing;

 select*from layoff_standing
 where total_laid_off is null
 and percentage_laid_off is null;
 
 delete
 from layoff_standing
 where total_laid_off is null
 and percentage_laid_off is null;
 
 delete
  from layoff_standing
  where  date;
  
  alter table layoff_standing
  drop  column  date;
  
  