/*---------------------------------------------------------
  The options statement below should be placed
  before the data step when submitting this code.
---------------------------------------------------------*/
options VALIDMEMNAME=EXTEND VALIDVARNAME=ANY;
   /*------------------------------------------
   Generated SAS Scoring Code
     Date             : 06Jul2022:22:17:27
     Locale           : en_US
     Model Type       : Linear Regression
     Interval variable: Yield
     Interval variable: M_(M%)
     Interval variable: MFI
     Interval variable: viscosity
     Interval variable: Xf
     Response variable: Yield
     ------------------------------------------*/
   /*---------------------------------------------------------
     Generated SAS Scoring Code
     Date: 06Jul2022:22:17:27
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

   array _xrow_3354_0_{5} _temporary_;
   array _beta_3354_0_{5} _temporary_ (    870.531396563145
           3.99375635623797
          -3.77769317836049
          -0.16714943846304
          -1.96186167487693);

   /*------------------------------------------*/
   /*Missing values in model variables result  */
   /*in missing values for the prediction.     */
   if missing(MFI) 
      or missing(viscosity) 
      or missing(Xf) 
      or missing(M_) 
      then do;
         _badval_ = 1;
         goto skip_3354_0;
   end;
   /*------------------------------------------*/

   do _i_=1 to 5; _xrow_3354_0_{_i_} = 0; end;

   _xrow_3354_0_[1] = 1;

   _xrow_3354_0_[2] = M_;

   _xrow_3354_0_[3] = MFI;

   _xrow_3354_0_[4] = viscosity;

   _xrow_3354_0_[5] = Xf;

   do _i_=1 to 5;
      _linp_ + _xrow_3354_0_{_i_} * _beta_3354_0_{_i_};
   end;

   skip_3354_0:
   label P_Yield = 'Predicted: Yield';
   if (_badval_ eq 0) and not missing(_linp_) then do;
      P_Yield = _linp_;
   end; else do;
      _linp_ = .;
      P_Yield = .;
   end;
   /*------------------------------------------*/
   /*_VA_DROP*/ drop 'P_Yield'n;
      'P_Yield_3354'n='P_Yield'n;
   /*------------------------------------------*/