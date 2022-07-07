/*---------------------------------------------------------
     Generated SAS Scoring Code
     Date: 01Jul2022:17:20:04
     -------------------------------------------------------*/

   /*---------------------------------------------------------
   Defining temporary arrays and variables   
     -------------------------------------------------------*/
   drop _badval_ _linp_ _temp_ _i_ _j_;
   _badval_ = 0;
   _linp_   = 0;
   _temp_   = 0;
   _i_      = 0;
   _j_      = 0;

   array _xrow_1904_0_{11} _temporary_;
   array _beta_1904_0_{11} _temporary_ (    100.577277127946
           0.11409442150588
           0.24068682417066
           0.17533651188208
          -0.06550883178726
          -1.98002782580081
          -0.22418431464894
           0.36376564298163
           0.03150089211168
           0.63970029268342
           0.37036079045938);

   /*------------------------------------------*/
   /*Missing values in model variables result  */
   /*in missing values for the prediction.     */
   if missing('Coating Viscosity'n) 
      or missing('Blend Speed'n) 
      or missing('Blend Time'n) 
      or missing(Force) 
      or missing('Exhaust Temp'n) 
      or missing('Screen Size'n) 
      or missing('Spray Rate'n) 
      or missing('Inlet Temp'n) 
      or missing('Atom. Pressure'n) 
      or missing('Mill Time'n) 
      then do;
         _badval_ = 1;
         goto skip_1904_0;
   end;
   /*------------------------------------------*/

   do _i_=1 to 11; _xrow_1904_0_{_i_} = 0; end;

   _xrow_1904_0_[1] = 1;

   _xrow_1904_0_[2] = 'Mill Time'n;

   _xrow_1904_0_[3] = 'Blend Speed'n;

   _xrow_1904_0_[4] = 'Coating Viscosity'n;

   _xrow_1904_0_[5] = 'Inlet Temp'n;

   _xrow_1904_0_[6] = 'Screen Size'n;

   _xrow_1904_0_[7] = 'Spray Rate'n;

   _xrow_1904_0_[8] = Force;

   _xrow_1904_0_[9] = 'Exhaust Temp'n;

   _xrow_1904_0_[10] = 'Blend Time'n;

   _xrow_1904_0_[11] = 'Atom. Pressure'n;

   do _i_=1 to 11;
      _linp_ + _xrow_1904_0_{_i_} * _beta_1904_0_{_i_};
   end;

   skip_1904_0:
   label P_Dissolution = 'Predicted: Dissolution';
   if (_badval_ eq 0) and not missing(_linp_) then do;
      P_Dissolution = _linp_;
   end; else do;
      _linp_ = .;
      P_Dissolution = .;
   end;




   *------------------------------------------------------------*;
   * Accounting for missing predicted variable;
   *------------------------------------------------------------*;
   label "P_Dissolution"n ='Predicted: Dissolution';
   if "P_Dissolution"n = . then "P_Dissolution"n =72.860555556;

