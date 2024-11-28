using {LogaliGroup as projection} from '../service';

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
    },
    UI.LineItem: [
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
    }
);
