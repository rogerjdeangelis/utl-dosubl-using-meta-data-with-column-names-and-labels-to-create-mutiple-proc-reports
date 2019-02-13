Using meta data with column names and labels to create mutiple proc reports

SAS Forum
http://tinyurl.com/y2cxd7dz
https://communities.sas.com/t5/ODS-and-Base-Reporting/using-loop-in-the-define-step-of-proc-report/m-p/535099?nobounce

INPUT
=====
Up to 40 obs WORK.COLUMNS total obs=2

Obs    NAME    LABEL

 1     Age     AgeYrs
 2     sex     Gender

and SASHELP.CLASS

EXAMPLE OUTPUT
--------------

REPORT A

  NAME         AgeYrs
  Alfred           14
  Alice            13
  Barbara          13
  Carol            14
  Henry            14

REPORT B

  NAME    Gender
  Alfred    M
  Alice     F
  Barbara   F
  Carol     F
  Henry     M


Up to 40 obs from LOG total obs=2

Obs    NAME    LABEL     RC        STATUS

 1     Age     AgeYrs     0    Report created
 2     sex     Gender     0    Report created

SOLUTION
========

data log;

 set columns;

 call symputx('name',name);
 call symputx('label',label);

 rc=dosubl('
   proc report data=sashelp.class;
      cols name &name;
      define &name / "&label";
   run;quit;
   %let cc=&syserr;
 ');

 if symgetn('cc')=0 then status="Report created";
 else status="Report failed";

status="Report created";
run;quit;


