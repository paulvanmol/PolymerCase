/*filename to folder with scorecode
*/
cas flow_session; 
libname casuser cas; 

*filename myfldr filesrvc folderPath='/Courses/polymercase';
filename myfldr "/home/lynn/PolymerCase"; 
proc datasets library=WORK memtype=data kill nolist;
    run;
quit;

proc datasets library=CASUSER nolist;
    delete BEK_OPT;
    run;
quit;


/*1. data set: decision variables & bounds*/
/*the variables that we need to optimize*/
data variable_limits;
    length _id_ $ 32;
    input _id_ $ _lb_ _ub_;
    datalines;
M_ 0 4
Xf 13 19
SA 50 80
MFI 0 198
CI  80 800
;

run;
    options NOmprint;

    /*2. data set: constraints*/
    /* -->constraints :  inside macro loop*/
    /*3. PROC FCMP: function*/
    /*-->function arguments : inside macro loop*/
    /*4. data set: objective function*/
data objdata;
    length _function_ $ 15 _id_ $ 40;
    input _id_ $ _function_ $ _sense_ $;
    datalines;
P_Yield   scgr     max
;
run;

/*clean up resulttables before re-running*/
/*
proc sql;
drop table solution;
drop table solutions;
drop table solution_T;
drop table predictions;
drop table backtest2;
drop table backtest;
drop table work.inputds;
quit;
*/
/*take subset of  ABT to test*/
data inputds;
    set CASUSER.POLYMERDATA_FINAL /*(obs=2)*/;
run;

%macro loop_observations;
    %let id=%sysfunc(open(inputds));
    %let NObs=%sysfunc(attrn(&id, NOBS));
    %syscall set(id);

    %do i=1 %to &NObs.;
        %put Processing record &=i;
        %put &_INDEX_.;
        %let rc=%sysfunc(fetchobs(&id, &i));

        %macro fixsettings;

            /*disturbance factors*/
            SA=&SA.;
        %mend;

        /***** Constraints on concentration so they sum up to 1 ****/
        data fixsettings;
            %fixsettings ;
        run;

        

        /*(2.) constraints*/

/*
        data concentration_constraint;
            _id_='a1';
            _lb_=&concentrationleft.;
            _ub_=&concentrationleft.;
            I_Inlet_C2F4=1;
            I_Inlet_Z=1;
        run;

*/

        /*(3.)**** Define score function ****/
        options cmplib=work.myfuncs;

        proc fcmp outlib=work.myfuncs.mypkg;
            function scgr(Xf,SA, M_,CI,MFI);
            %fixsettings %include myfldr ('score_code_yield_lr.sas') / source2;
            return (P_Yield);

            /*instead of saying: return(5*inputvar1-inputvar**2) we return the predicted value from miner*/
            endsub;
        run;

        /***** Optimize ****/
        proc optlso primalout=solution variables=variable_limits objective=objdata 
                 loglevel=1 seed=100;
        run;

        proc sort data=solution;
            by _id_;
        run;

        proc transpose data=solution(drop=_sol_) out=solution_T prefix=OPT_;
            id _id_;
            var _value_;
        run;

        proc append base=work.solutions data=work.solution_T;
        run;

        quit;
    %end;
    %let id=%sysfunc(close(&id));
%mend;

%loop_observations data inputds_score;
set work.inputds;
%include myfldr ('score_code_yield_lr.sas') / source2;
run;

data backtest_end (replace=yes);
    merge solutions inputds_score;

run;


data casuser.bek_opt (promote=yes);
    set backtest_end;
run;

proc datasets library=WORK memtype=data kill;
    run;
quit;