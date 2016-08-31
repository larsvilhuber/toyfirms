/* basic parameters */
%let indcnt=100;
%let maxestabcnt=10000;
%let minestabcnt=100;
%let seed1=123456;

%let maxemp=42000;
%let minemp=1;
%let seed2=1234567;

/* draw estab count distribution across industries*/
/* use log normal */
data industries;
  do industry = 1 to &indcnt.;
  estabs= exp(ranuni(&seed1.)*(log(&maxestabcnt.)-log(&minestabcnt.)) + log(&minestabcnt.));
  output;
  end;
  run;

  proc univariate data=industries;
  var estabs;
  run;

/* now draw employment for each estab in each industry */

data fakelbd;
  set industries;
  by industry;
  drop i;
  do i=1 to estabs;
    emp= exp(ranuni(&seed2.)*(log(&maxemp.)-log(&minemp.)) + log(&minemp.));
    output;
  end;
run;

proc univariate data=fakelbd;
var emp;
run;
