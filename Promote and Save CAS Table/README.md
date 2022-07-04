![Global Enablement & Learning](https://gelgitlab.race.sas.com/GEL/utilities/writing-content-in-markdown/-/raw/master/img/gel_banner_logo_tech-partners.jpg)

# Promote and/or Save CAS Table

* [Description](#description)
* [SAS Viya Version Support](#sas-viya-version-support)
* [User Interface](#user-interface)
* [Requirements](#requirements)
* [Usage](#usage)
* [Download Step File](#download-step-file)
* [Prompt UI](#prompt-ui)
* [Program](#program)
## Description

The "**Promote and Save CAS Table**" Custom Step enables SAS Studio Flow users to promote and/or save the specified input CAS table and library to the specified output CAS table and library.  Note:  Saved table is automatically replaced if exists and table promote drops current in-memory table if it exists and then promotes table.

## SAS Viya Version Support
2021.1.1 or later
## User Interface

![Promote and Save CAS Table Prompt UI](img/Promote%20and%20Save%20CAS%20Table.png)


## Requirements

* CAS session established
* CAS library for output table is part of the session.  Note: You can use [this custom step](../Create%20CAS%20Session%20and%20Assign%20CAS%20Library/README.md)
* Table node connected to input port that specifies CAS library and table name for temporary session table that will be promoted and/or saved
* Table node connected to output port that specifies CAS library and table name to promote and/or save


## Usage

![Using the Promote and Save CAS Table Custom Step](img/PromoteAndSaveCASTable.gif)


## Download Step File

[Promote and Save CAS Table Custom Step](./Promote%20and%20Save%20CAS%20Table.step)


## Prompt UI
```json
{
   "syntaxversion": "1.0.0",
   "pages": [
   {
	"id": "CASPromoteSaveTable",
	"type": "page",
	"label": "Promote and/or Save CAS Table",
	"children": [
		{
			"id": "inTable",
			"type": "inputtable",
			"label": "Select an input table:",
			"required": true
		},	
		{
			"id": "promote_save_text",
			"type": "text",
			"text": "Make selections to promote and/or save the input table to the output table."
		},
		{
			"id": "promote_table",
			"type": "checkbox",
			"label": "Promote table"
		},
		{
			"id": "save_table",
			"type": "checkbox",
			"label": "Save table"
		},
		{
			"id": "outTable",
			"type": "outputtable",
			"label": "Specify the output table:",
			"required": true
		}
	]
   }
   ],
	"values": 
		{"promote_table": true}
}
```


## Program
```sas
/* Save CAS Table */
%if &save_table=1 %then %do;
proc casutil;
    save casdata="&inTable_name" incaslib="&inTable_lib" outcaslib="&outTable_lib"
	     casout="&outTable_name" replace;
run;
quit;
%end;


/* Promote CAS Table */
%if &promote_table=1 %then %do;
proc casutil;
   droptable casdata="&outTable_name" incaslib="&outTable_lib" quiet;
   promote casdata="&inTable_name" incaslib="&inTable_lib" casout="&outTable_name" outcaslib="&outTable_lib";
run;
quit;
%end;

```
