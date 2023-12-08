data po;
input id time status;
datalines;
1 1 1
2 1 1
3 2 1
4 2 1
5 3 1
6 4 1
7 4 1
8 5 1
9 5 1
10 8 1
11 8 1
12 8 1
13 8 1
14 11 1 
15 11 1
16 12 1
17 12 1 
18 17 1 
19 22 1
20 23 1
;
run;

proc print data= p;
run;


proc lifetest data=po method=km plots=lls;
time time*status(0);
run;


proc lifereg data=po;
model time*status(0) =  /distribution=weibull;
output out=a p=median std=se;
run;

proc print data=a;
run;

data a;
set a ;
ltime=log(median);
se=se/median;
upper=exp(ltime+1.96*se);
lower=exp(ltime-1.96*se);
run;
proc print data=a;
run;


proc means data=po sum;
var time;
run;


data leu;
input group  time status;
datalines;
1 1 1
1 1 1
1 2 1
1 2 1
1 3 1
1 4 1
1 4 1
1 5 1
1 5 1
1 8 1
1 8 1
1 8 1
1 8 1
1 11 1 
1 11 1
1 12 1
1 12 1 
1 17 1 
1 22 1
1 23 1
2 6 1
2 6 1 
2 6 1
2 7 1
2 10 1 
2 13 1
2 16 1
2 22 1
2 23 1
2 6 0
2 9 0 
2 10 0
2 11 0
2 17 0 
2 19 0 
2 20 0 
2 25 0 
2 32 0 
2 32 0 
2 34 0 
2 35 0
;
run;

proc print data = leu;
run;



proc lifereg data=leu;
class group;
model time*status (0) = group/d=weibull;
run;


proc lifereg data=leu;
class group;
model time*status(0) =  group/distribution=weibull;
output out=b  p=median std=se;
run;

proc print data = b;
run;

proc lifereg data=leu;
class group;
model time*status(0) =  group/distribution=weibull;
output out=c q=0.8 p=est80 std=se;
run;

proc print data=c;
run;

proc lifetest data=leu method=km plots=lls;
time time*status (0);
strata group;
run;

proc lifereg data= leu;
model time*status(0);
probplot;
run;




proc means data=leu sum;
var time;
run;



proc lifereg data=leu;
model time*status (0) = n/d=expontial;
run;




proc lifereg data=leu;
class group;
model time*status (0) = group/d=exponetial;
run;
