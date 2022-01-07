namespace masterData;

using {cuid, managed, temporal, Country} from '@sap/cds/common';
using { common.db.UOMCommonTypes as Ctypes } from './Common';
using {common.db.Commments as commentType} from './Common';
using {common.db.CommonEntities as commonEntities } from './Common';

@cds.odata.valuelist
entity NetworkObjects : cuid, managed {
networkObjectID : String(30);
networkObjectType : Association to one commonEntities.NetworkObjectTypes;
networkObjectDescription : localized String(60);
productionNetwork : String(30);
country : Country; 

/*Add fields here specific to Well, Meter etc and try how on UI those can be controlled, based on the network Object Type
Field Control Group check how it wil lwork here 
*/

}

/*Define a view for Production Networks */

define view ProductionNetworks as 
select from NetworkObjects as NetObj {
    networkObjectID,
    networkObjectDescription,
    country,
}
where networkObjectType.networkObjectType = 'PN';

////////////////////////////////////////////////////////////////////////////////


annotate  NetworkObjects with {
networkObjectID  @(
title : '{i18n>networkObject}',
Common.Label : '{i18n>networkObject}'
);
networkObjectType  @(
title : '{i18n>networkObjectType}',
Common.Label : '{i18n>networkObjectType}'
);

networkObjectDescription  @(
title : '{i18n>networkObject}',
Common.Label : '{i18n>networkObject}'
);

productionNetwork  @(
title : '{i18n>productionNetwork}',
Common.Label : '{i18n>productionNetwork}'
);


}