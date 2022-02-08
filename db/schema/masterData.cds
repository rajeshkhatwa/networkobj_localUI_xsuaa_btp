namespace masterData;

using {
    cuid,
    managed,
    temporal,
    sap,
    Country
} from '@sap/cds/common';
using {common.db.UOMCommonTypes as Ctypes} from './Common';
using {common.db.Commments as commentType} from './Common';
using {common.db.CommonEntities as commonEntities} from './Common';

@cds.odata.valuelist
entity NetworkObjects : managed {
    key networkObjectID          : String(30);
        networkObjectType        : Association to one commonEntities.NetworkObjectTypes;
        networkObjectDescription : localized String(60);
        productionNetwork        : String(30);
        country                  : Association to one sap.common.Countries;

/*Add fields here specific to Well, Meter etc and try how on UI those can be controlled, based on the network Object Type
Field Control Group check how it wil lwork here
*/

}



/*Define a view for Production Networks */

define view ProductionNetworks as
    select from NetworkObjects as NetObj {
        networkObjectID,
        networkObjectType.networkObjectType as networkObjectType,
        networkObjectType.description as networkObjectTypeDescription,
        networkObjectDescription,
        country
    }
    where
        'PN' = networkObjectType.networkObjectType ;


define view ProductionNetworksVH as
    select from ProductionNetworks {
        key networkObjectID,
     };
        

////////////////////////////////////////////////////////////////////////////////


annotate NetworkObjects with {
    networkObjectID          @(
        title        : '{i18n>networkObject}',
        Common.Label : '{i18n>networkObject}'
    );
    networkObjectType        @(
        title        : '{i18n>networkObjectType}',
        Common.Label : '{i18n>networkObjectType}'
    );

    networkObjectDescription @(
        title        : '{i18n>networkObject}',
        Common.Label : '{i18n>networkObject}'
    );
    country_code  @( 
        title : 'Country',
        Common.Label : 'Country'
        );

    productionNetwork        @(
        title            : '{i18n>productionNetwork}',
        Common.Label     : '{i18n>productionNetwork}',
    /*Common ValueList : CollectionPath must match with the entity name ,,,here the collection path as well as the 
     Data properties refer to the fields in metadata which means in the service 
    In the Service MasterDataService , view ProductionNetworks as select from MD.ProductionNetworks;
    means the name of the entity in metadata muct be same as that mentioned in the CollectionPath */
    Common.ValueList : {
            CollectionPath : 'ProductionNetworks',
            Parameters     : [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : 'productionNetwork',
                    ValueListProperty : 'networkObjectID'
                },
                
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'networkObjectDescription'
                }  

            ]

        }
    //  Let's try to add ValueHelp in a different way
   //Common.ValueList : { CollectionPath : 'ProductionNetworksVH'}   

    );
};
