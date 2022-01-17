using from '../../srv/service';


annotate MasterDataService.NetworkObjects with @(
UI : {
    HeaderInfo  : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Network Object',
        TypeNamePlural : 'Network Objects',
          Description: { Value: networkObjectDescription }
    },

SelectionFields  : [ networkObjectType_networkObjectType, productionNetwork  ],
LineItem  : [

    {Value: networkObjectID },
    {Value: networkObjectType_networkObjectType},
    {Value: networkObjectDescription},
    {Value: productionNetwork}
    
]   

}

 );