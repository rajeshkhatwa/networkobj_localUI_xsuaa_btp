using from '../../srv/service';


/*If adding any new Annotation file, then add it to the index.cds in app folder */

annotate MasterDataService.NetworkObjects with @(UI : {
    HeaderInfo        : {
        $Type          : 'UI.HeaderInfoType',
        TypeName       : '{i18n>networkObject}',
        TypeNamePlural : '{i18n>networkObjects}',
        Title          : {Value : networkObjectID},
        Description    : {Value : networkObjectDescription}
    },

    SelectionFields   : [
        networkObjectID,
        networkObjectType_networkObjectType,
        productionNetwork,
    // country_code
    ],
    LineItem          : [

        {Value : networkObjectID},
        {Value : networkObjectDescription},
        {Value : networkObjectType_networkObjectType},

        /*       Trying to fetch from the association  .. When associated field is to be fetched..then ensure that it's the navigation and then property
                 in the metadata for the entity NetworkObjects, it;s networkObjectType---> Navigation
                also in Manifest.json  file set autoExpandSelect": true, */

        {
            $Type : 'UI.DataField',
            Value : networkObjectType.description
        },

        {
            Value : country_code,
            Label : 'Country'
        },
        {Value : country.name},
        {Value : productionNetwork}

    ],
    Facets            : [ // if I had used HeaderFacets, then this info would have been displayed in the header Section itself
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>details}',
            Target : '@UI.FieldGroup#Main'
        },
        {
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>Admin}',
            Target : '@UI.FieldGroup#Admin'
        }

    ],

    FieldGroup #Main  : {Data : [
        {Value : networkObjectID},
        {Value : networkObjectDescription},
        {Value : networkObjectType_networkObjectType},
        {Value : networkObjectType.description},
        {Value : productionNetwork}
    ]},
    FieldGroup #Admin : {Data : [
        {Value : createdAt},
        {Value : createdBy},
        {Value : modifiedAt},
        {Value : modifiedBy}        

    ]}
}

);
