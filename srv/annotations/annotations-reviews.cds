using {LogaliGroup as projection} from '../service';

annotate projection.ReviewsSet with {
    creationDate @title: 'Creation Date' @Common: {
        Text : user,
    };
    product      @title: 'Product';
    rating       @title: 'Rating';
    reviewText   @title: 'Review Text';
    user         @title : 'User';
};

annotate projection.ReviewsSet with @(
    UI.HeaderInfo  : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Review',
        TypeNamePlural : 'Reviews',
        Title : {
            $Type : 'UI.DataField',
            Value : product.productName,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : product.product
        },
    },
    UI.LineItem  : [
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint',
            ![@HTML5.CssDefaults] : {
                $Type : 'HTML5.CssDefaultsType',
                width : '10rem'
            },
        },
        {
            $Type : 'UI.DataField',
            Value : creationDate
        },
        {
            $Type : 'UI.DataField',
            Value : reviewText,
            ![@HTML5.CssDefaults] : {
                $Type : 'HTML5.CssDefaultsType',
                width : '30rem'
            }
        }
    ],
    UI.DataPoint  : {
        $Type : 'UI.DataPointType',
        Value : rating,
        Visualization : #Rating
    },
    UI.FieldGroup  : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : creationDate
            },
            {
                $Type : 'UI.DataField',
                Value : user
            },
            {
                $Type : 'UI.DataField',
                Value : rating
            },
            {
                $Type : 'UI.DataField',
                Value : reviewText
            }
        ]
    },
    UI.Facets  : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup',
            Label : 'Reviews'
        }
    ],
);

