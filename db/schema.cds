namespace com.logaligroup;

using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

type MyDecimal : Decimal(5, 3);

entity Products : cuid, managed {
    key product      : String(8);
        productName  : String(40);
        description  : LargeString;
        mediaContent : LargeBinary  @UI.IsImage @Core.MediaType: mimeType  @Core.ContentDisposition.Filename: fileName;
        mimeType     : String       @Core.IsMediaType;
        fileName     : String;
        category     : Association to Categories; // category_ID      category/category
        subCategory  : Association to SubCategories; // subCategory_ID   subCategory/description
        supplier     : Association to Suppliers; // supplier_ID
        availability : Association to Availability; // availability_code
        criticality  : Integer;
        rating       : Decimal(3, 2);
        price        : Decimal(6, 2);
        currency     : String(3) default 'USD';
        details      : Composition of Details; //details_ID
        toReviews    : Composition of many Reviews
                           on toReviews.product = $self;
        toStock      : Composition of many Stock
                           on toStock.product = $self;
};

entity Details : cuid {
    baseUnit   : String(2) default 'EA';
    width      : MyDecimal;
    height     : MyDecimal;
    depth      : MyDecimal;
    weight     : MyDecimal;
    unitVolume : String(2) default 'CM';
    unitWeight : String(2) default 'KG';
};

entity Suppliers : cuid {
    key supplier     : String(9);
        supplierName : String(40);
        webAddress   : String;
        contact      : Association to Contacts; //contact_ID
};

entity Contacts : cuid {
    fullName    : String(40);
    email       : String(80);
    phoneNumber : String(14);
};

entity Reviews : cuid {
    rating       : Decimal(3, 2);
    creationDate : Date;
    user         : String(40);
    reviewText   : LargeString;
    product      : Association to Products; //product_ID and product_product
};

entity Stock : cuid {
    stockNumber : String(9);
    department  : String;
    min         : MyDecimal;
    max         : MyDecimal;
    target      : MyDecimal;
    lotSize     : Decimal(6, 3);
    quantity    : Decimal(6, 3);
    unit        : String(2) default 'EA';
    product     : Association to Products; //product_ID and product_product
};

entity Categories : cuid {
    category        : String(40);
    description     : LargeString;
    toSubCategories : Association to many SubCategories
                          on toSubCategories.category = $self; //category_ID === ID
};

entity SubCategories : cuid {
    subCategory : String(40);
    description : LargeString;
    category    : Association to Categories; //category_ID
};

entity Availability : CodeList {
    key code : String enum {
            InStock         = 'In Stock'; //Disponible - Verde = 3
            NotInStock      = 'Not In Stock'; //No Disponible - Rojo = 1
            LowAvailability = 'Low Availability'; //Poca Disponibilidad - Naranja = 2
        };
}
