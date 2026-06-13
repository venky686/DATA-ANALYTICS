use ds;
select*from water_consumption ;
select*from water_consumption where year >2013;
delimiter &&
create procedure top_BCM()
begin 
select country,year,Rainfall_Impact_MM from  water_consumption where Total_Water_Consumption_BCM < 500 ;
END&& 
delimiter ;
call top_BCM();

select  country,year,Total_Water_Consumption_BCM from water_consumption order by Rainfall_Impact_MM desc limit 4;
delimiter &&
create procedure top_values(in ven int)
begin 
select  country,year,Total_Water_Consumption_BCM from water_consumption order by Rainfall_Impact_MM desc limit ven;
end&&
delimiter ;
call top_values(4);
set sql_safe_updates=0;
delimiter &&
create procedure update_top_values( in num int,in nu varchar(34) )
begin 
update  water_consumption set Country=nu where year=num  ;
end&&
delimiter ;
call update_top_values(2012,"India");
delimiter &&
create procedure count_top_value(in va varchar(20),out total_year int)
begin 
select  count(*) from water_consumption where Country=va  into total_year;
end&&
delimiter ;
call count_top_value('India',@total_year);
select @total_year  ;


select a.Country,a.*,sum(Total_Water_Consumption_BCM)
over (partition by a.Country) as 
hgfbjyti from water_consumption  a;
select a.Country,a.*,sum(Per_Capita_Water_Use_LPD)
over (partition by a.Country) as
mana from  water_consumption  a;
select a.Year ,a.*,avg(Industrial_Water_Use_Percent)
over (partition by a.Year) as 
momo from water_consumption  a;

select row_number() over (order by Country)
as row_num,Country from 
water_consumption order by country;
select row_number() over (order by Year)
as reo_num,Year from water_consumption  
order by Year;  
select row_number() over (order by Water_Scarcity_Level)
as row_num,Water_Scarcity_Level from
water_consumption  order by Water_Scarcity_Level;

select Total_Water_Consumption_BCM,rank() over (order by Total_Water_Consumption_BCM)
as levels from water_consumption ;

select *,first_value(Country) over
(order by Total_Water_Consumption_BCM desc) as high 
from water_consumption;