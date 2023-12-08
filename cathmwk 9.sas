data two;
set 'C:\Users\iyink\Downloads\child_ill.sas7bdat';
y=num_ill;
if num_ill = 1 then y = 1;
if num_ill = 2 then y = 1;
if num_ill >= 3 then y =2;
run;


proc freq data= two;
table y*gender;
run;


proc logistic data=two desc;
class gender/param=ref;
model y = gender
/ link = clogit;
run;



DATA two_;
set two; 
stage=1; event = (y EQ 0); OUTPUT; IF y EQ 0 then DELETE;
stage=2; event = (y EQ 1); OUTPUT;
run;

proc print data = two_;
run;


PROC LOGISTIC DATA=two_ order=internal descending;
CLASS stage gender /PARAM = ref;
MODEL event = stage gender/  aggregate scale=none expb;
RUN;

PROC LOGISTIC DATA=two_ order=internal descending;
CLASS stage gender  /param = ref ;
MODEL event = stage | gender /  aggregate scale=none expb;
RUN;



*question 2c*;
proc logistic data= two_ desc;
class gender / param = ref;
model event  = gender;
run;



*question 3;
PROC LOGISTIC DATA= two_ DESCENDING;
CLASS gender / PARAM=ref;
MODEL y = gender / LINK = aLOGIT ;
run;

PROC LOGISTIC DATA= two_ DESCENDING;
CLASS gender / PARAM=ref;
MODEL y = gender / LINK = aLOGIT unequalslopes = gender;
run;

