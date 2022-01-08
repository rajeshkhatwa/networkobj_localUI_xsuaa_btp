namespace FDC;

using {
    cuid,
    managed,
    temporal
} from '@sap/cds/common';
// using { log } from './Common';
using {common.db.UOMCommonTypes as Ctypes} from './Common';
using {common.db.Commments as commentType} from './Common';
using {masterData as MD} from './masterData';
using {common.db.CommonEntities as commonEntities} from './Common';


entity WellCompletionTests : cuid, managed, temporal {
    //networkObjectID1 : Association to one MD.ProductionNetworks;  // ProductionNetworks is a view and it cannot work on it in the association like this
    networkObjectID  : Association to one MD.ProductionNetworks; // Here it is Production Network
    wellCompletionID : Association to one MD.NetworkObjects;
    wellID           : Association to one MD.NetworkObjects;
    effectiveFrom    : Timestamp;
    effectiveTo      : Timestamp;
    medium           : Association to one commonEntities.Medium;
    dimension        : Association to one commonEntities.Dimension;
    @cascade : {all}
    items            : Composition of many WCTestsItems
                           on items.parent = $self;
    status           : Ctypes.StatusT default 'N';
    comments         : commentType.comment1

}




entity WCTestsItems : cuid, Ctypes.Quantity {
    parent              : Association to WellCompletionTests;
    measurementProperty : Association to one commonEntities.Measurement;

}


define view WCTestWorklist as
    select from WellCompletionTests {
        key ID                                    as WellCompletionTestsID,
            networkObjectID,
            //networkObjectID.country as PNCountry, // you can either define a new view to select using $user.country or define at the service level
            wellID,
            wellCompletionID,
            effectiveFrom,
            effectiveTo,
            medium,
            medium.description                    as MediumDescription,
            dimension,
            dimension.description                 as DimensionDescription,
        key items.ID                              as WCTestsValuesID,
            items.measurementProperty             as measurementProperty,
            items.measurementProperty.description as measurementPropertyDescription,
            items.quantity,
            items.quantityUnit,
            status,
            comments
    };

/* In the above view country can be made as mandatory in the xs-security.json and then user can be assigned list of countries as well as ['UNRESTRICTED']*/


/* Define the view so that only user created netwrokobjects can be seen */
define view myNetworkObjects as
    select from MD.NetworkObjects {
        networkObjectID,
        networkObjectDescription

    }
    where
        createdBy = $user.id;


annotate WCTestsValues with {
    measurement @(
        title        : '{i18n>measurement}',
        Common.Label : '{i18n>measurement}'
    );
}


annotate WellCompletionTests with {
    networkObjectID  @(
        title        : '{i18n>productionNetwork}',
        Common.Label : '{i18n>productionNetwork}'
    );

    wellCompletionID @(
        title        : '{i18n>wellCompletionID}',
        Common.Label : '{i18n>wellCompletionID}'
    );

    wellID           @(
        title        : '{i18n>wellID}',
        Common.Label : '{i18n>wellID}'
    );

    effectiveFrom    @(
        title        : '{i18n>effectiveFrom}',
        Common.Label : '{i18n>effectiveFrom}'
    );

    effectiveTo      @(
        title        : '{i18n>effectiveTo}',
        Common.Label : '{i18n>effectiveTo}'
    );

    medium           @(
        title        : '{i18n>medium}',
        Common.Label : '{i18n>medium}'
    );

    dimension        @(
        title        : '{i18n>dimension}',
        Common.Label : '{i18n>dimension}'
    );

    status           @(
        title               : '{i18n>status}',
        Common.Label        : '{i18n>status}',
        Common.FieldControl : #ReadOnly
    );


    comments         @(
        title        : '{i18n>comments}',
        Common.Label : '{i18n>comments}'
    );

};
