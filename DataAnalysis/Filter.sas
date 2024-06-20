libname data '/home/u63543850/Research/Datasets';

proc import 
    datafile='/home/u63543850/Research/Datasets/combined_data.tsv'
    out=work.Analysis
    dbms=dlm
    replace;
    delimiter = '09'x;
    getnames=yes;
run;

data data.Analysis;
    set analysis;
    
    /* Define an array for the variables */
    array srr{*} SRR3085918_tpm--SRR3086005_tpm;
    
    /* Initialize min, max, sum, and count */
    min = srr{1};
    max = srr{1};
    sum = 0;
    count = 0;
    
    /* Loop through the array to find min, max values and calculate the sum and count non-zero values */
    do i = 1 to dim(srr);
        if srr{i} < min then min = srr{i};
        if srr{i} > max then max = srr{i};
        
        if srr{i} ne 0 and not missing(srr{i}) then do;
            sum + srr{i};
            count + 1;
        end;
    end;
    
    /* Calculate the mean */
    if count > 0 then mean = sum / count;
    else mean = 0;
    
    /* Drop the intermediate variables used for calculation */
    drop sum count i;
run;

data data.cl_ana;
	set data.Analysis;
	where mean ne 0;
run;




	
	

