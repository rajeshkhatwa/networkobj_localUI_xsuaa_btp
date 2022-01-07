
namespace common.db;  // you may want to not add .db in the namespace

using { temporal,Currency } from '@sap/cds/common';

aspect logHandle
{
   logHandle : String (30); 
}
// temporal doesn't have the text in the aspect
annotate temporal with {
validFrom @(title : '{i18n>validFrom}');
validTo @(title : '{i18n>validTo}');
}

context Commments {
// Type Definitions ---> to -reuse make part of the the context
//you must define the types just like data elements, so that type change at one place rflect everywhere
type comment1 : String(30);
type comment2 : String(30);
type comment3 : String(30);        

aspect CommentsAll{
    comment1 : comment1;
    comment2 : comment2;
    comment3 : comment3;
}
}

/* 
Defining common types 
*/

context UOMCommonTypes {
  type BusinessKey : String(10);
  type SDate : DateTime;

  type AmountT : Decimal(15, 2)@(
    Semantics.amount.currencyCode : 'CURRENCY_code',
    sap.unit                      : 'CURRENCY_code'
  );

  type QuantityT : Decimal(13, 3)@(
    title         : '{i18n>quantity}'
  );

  type UnitT : String(3)@title : '{i18n>quantityUnit}';

  type StatusT : String(1) enum {
    New        = 'N';
    Incomplete = 'I';
    Approved   = 'A';
    Rejected   = 'R';
    Confirmed  = 'C';
    Saved      = 'S';
    Cancelled  = 'X';
  }

 annotate StatusT with @(
   title : '{i18n>status}',
   assert.enum    // On save, these values would be checked 

 );
 



  aspect Amount { 
    currency    : Currency;
    grossAmount : AmountT;
    netAmount   : AmountT;
    taxAmount   : AmountT;
  }

  annotate Amount with {
    grossAmount @(title : '{i18n>grossAmount}');
    netAmount   @(title : '{i18n>netAmount}');
    taxAmount   @(title : '{i18n>taxAmount}');
  }

  aspect Quantity {
    @Semantics.quantity.unitOfMeaure: 'quantityUnit'
    quantity     : QuantityT;
    @Semantics.unitOfMeaure
    quantityUnit : UnitT;
  }



};


context CommonEntities{

// Common Customizing
// entity name is Plural
@cds.odata.valuelist
entity Medium
{
    key medium : String(6);
    description : localized String(60);
}
@cds.odata.valuelist
entity Dimension
{
    key dimension  : String(15);
    description : localized String(60);
}
@cds.odata.valuelist
entity Measurement
{
    key measurement  : String(30);
    description : localized String(60);
}
@cds.odata.valuelist
entity NetworkObjectTypes
{
 key networkObjectType : String(15);
    description : localized String(60);
}


// UI annotations

annotate Medium with {
medium  @(
title : '{i18n>medium}',
Common.Label : '{i18n>medium}'
);
description  @(
title : '{i18n>mediumDescription}',
Common.Label : '{i18n>mediumDescription}'
);
};

annotate Dimension with {
dimension  @(
title : '{i18n>dimension}',
Common.Label : '{i18n>dimension}'
);
description  @(
title : '{i18n>dimensionDescription}',
Common.Label : '{i18n>dimensionDescription}'
);
};

annotate Measurement with {
measurement  @(
title : '{i18n>measurement}',
Common.Label : '{i18n>measurement}'
);
description  @(
title : '{i18n>measurementDescription}',
Common.Label : '{i18n>measurementDescription}'
);
};


annotate NetworkObjectTypes with {
networkObjectType  @(
title : '{i18n>networkObjectType}',
Common.Label : '{i18n>networkObjectType}'
);
description  @(
title : '{i18n>networkObjectType}',
Common.Label : '{i18n>networkObjectType}'
);
};
}