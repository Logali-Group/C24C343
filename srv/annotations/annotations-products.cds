using {LogaliGroup as projection} from '../service';

using from './annotations-suppliers';
using from './annotations-details';
using from './annotations-reviews';
using from './annotations-stock';

annotate projection.ProductsSet with @odata.draft.enabled;

annotate projection.ProductsSet with {
    product      @title: 'Product';
    productName  @title: 'Product Name';
    description  @title: 'Description';
    supplier     @title: 'Supplier';
    category     @title: 'Category';
    subCategory  @title: 'Sub-Category';
    availability @title: 'Availability';
    rating       @title: 'Average Rating';
    price        @title: 'Price per Unit' @Measures.Unit: currency;
    currency     @title: 'Currency' @Common.IsUnit;
    mediaContent @title : 'Attachment';
};

annotate projection.ProductsSet with {
    product @Common : { 
        Text : productName
    };
    availability @Common: {
        Text : availability.name,
        TextArrangement : #TextOnly
    };
    subCategory @Common: {
        Text : subCategory.subCategory,
        TextArrangement : #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'VH_SubCategories',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterIn',
                    LocalDataProperty : category_ID,            //Products
                    ValueListProperty : 'category_ID'           //SubCategories
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : subCategory_ID,
                    ValueListProperty : 'ID'
                }
            ]
        }
    };
    category @Common: {
        Text : category.category,
        TextArrangement : #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'VH_Categories',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : category_ID,            // Este campo pertenece a la entidad Products
                    ValueListProperty : 'ID'                   // Este campo pertenece a la entidad Categories
                }
            ]
        }
    };
    supplier @Common: {
        Text : supplier.supplierName,
        TextArrangement : #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'SuppliersSet',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : supplier_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'supplier'
                }
            ]
        }
    };
};

annotate projection.ProductsSet with @(
    Capabilities.FilterRestrictions : {
        $Type : 'Capabilities.FilterRestrictionsType',
        FilterExpressionRestrictions : [
            {
                $Type : 'Capabilities.FilterExpressionRestrictionType',
                AllowedExpressions : 'SingleRange',
                Property :  supplier_ID
            }
        ]
    },
    UI.SelectionFields  : [
        supplier_ID,
        category_ID,
        subCategory_ID,
        availability_code
    ],
    UI.HeaderInfo  : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Product',
        TypeNamePlural : 'Products',
        Title : {
            $Type : 'UI.DataField',
            Value : productName
        },
        Description : {
            $Type : 'UI.DataField',
            Value : product
        }
    },
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : mediaContent,
        },
        {
            $Type: 'UI.DataField',
            Value: product
        },
        {
            $Type: 'UI.DataField',
            Value: supplier_ID
        },
        {
            $Type: 'UI.DataField',
            Value: category_ID
        },
        {
            $Type: 'UI.DataField',
            Value: subCategory_ID
        },
        {
            $Type: 'UI.DataField',
            Value: availability_code,
            Criticality : criticality,
            ![@HTML5.CssDefaults] : {
                $Type : 'HTML5.CssDefaultsType',
                width : '10rem'
            }
        },
        {
            $Type: 'UI.DataFieldForAnnotation',
            Target: '@UI.DataPoint#RatingIndicator',
            ![@HTML5.CssDefaults] : {
                $Type : 'HTML5.CssDefaultsType',
                width : '10rem'
            },
        },
        {
            $Type: 'UI.DataField',
            Value: price
        }
    ], 
    UI.DataPoint #RatingIndicator: {
        $Type : 'UI.DataPointType',
        Value : rating,
        Visualization : #Rating
    },
    UI.FieldGroup #MediaContent : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : mediaContent,
                Label : ''
            }
        ]
    },
    UI.FieldGroup #Category : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : category_ID
            },
            {
                $Type : 'UI.DataField',
                Value : subCategory_ID
            },
            {
                $Type : 'UI.DataField',
                Value : supplier_ID
            }
        ]
    },
    UI.FieldGroup #Description : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : description,
                Label : ''
            }
        ]
    },
    UI.FieldGroup #Availability : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : availability_code,
                Label : '',
                Criticality : criticality
            }
        ]
    },
    UI.FieldGroup #Price : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : price,
                Label : ''
            }
        ]
    },
    UI.HeaderFacets  : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#MediaContent',
            Label : '',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Category'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Description',
            Label : 'Product Description'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Availability',
            Label : 'Availability'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Price',
            Label : 'Price'
        }
    ],
    UI.Facets  : [
        {
            $Type : 'UI.CollectionFacet',
            Facets : [
                    {
                        $Type : 'UI.ReferenceFacet',
                        Target : 'supplier/@UI.FieldGroup#Supplier',
                        Label : 'Information'
                    },
                    {
                        $Type : 'UI.ReferenceFacet',
                        Target : 'supplier/contact/@UI.FieldGroup#Contact',
                        Label : 'Contact Person'
                    }
            ],
            Label : 'Supplier Information'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'details/@UI.FieldGroup#Details',
            Label : 'Product Information'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'toReviews/@UI.LineItem',
            Label : 'Reviews'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'toStock/@UI.LineItem',
            Label : 'Stock Data'
        }
    ]
);
