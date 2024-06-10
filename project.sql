create database project;
use project;

select * from finance_1;
select * from finance_2;

/* 1. Year wise loan amount Stats*/
select year(issue_d) as year_d,sum(loan_amnt) as total_loan_amount
from finance_1
group by year_d
order by year_d;

/* 2. Grade and sub grade wise revol_bal*/
select grade, sub_grade,sum(revol_bal) as total_revol_bal
from finance_1 f1 inner join finance_2 f2 
on(f1.id = f2.id) 
group by grade,sub_grade
order by grade;

/* 3. Total Payment for Verified Status Vs Total Payment for Non Verified Status*/
select verification_status, 
round(sum(total_pymnt),2) as total_payment
from finance_1 f1 inner join finance_2 f2
on(f1.id = f2.id) 
where verification_status in('Verified', 'Not Verified')
group by verification_status;

/* 4. State wise and month wise loan status*/
select addr_state,DATE_FORMAT(issue_d,'%M')as months,
loan_status,COUNT(loan_status) as Totalcount from finance_1
group by addr_state,months,loan_status 
order by MONTHNAME(months);

/* 5. Home ownership Vs last payment date stats*/
select finance_1.home_ownership, max(finance_2.last_pymnt_d) as f1_last_pymnt_d,
count(finance_2.last_pymnt_d) as f2_last_pymnt_d
from finance_2
inner join finance_1 on finance_1.id = finance_2.id
group by finance_1.home_ownership;
