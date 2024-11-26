namespace com.logaligroup;

using {
    cuid,
    managed
} from '@sap/cds/common';

type MyDecimal : Decimal(5, 3);

entity Products : cuid, managed {
    key product      : String(8);
        productName  : String(40);
        description  : LargeString;
        category     : Association to Categories; // category_ID      category/category
        subCategory  : Association to SubCategories; // subCategory_ID   subCategory/description
        supplier     : Association to Suppliers;
        availability : String;
        rating       : Decimal(3, 2);
        price        : Decimal(6, 2);
        currency     : String(3);
        details      : Association to Details; //details_ID
};

entity Details : cuid {
    baseUnit   : String(2);
    width      : MyDecimal;
    height     : MyDecimal;
    depth      : MyDecimal;
    weight     : MyDecimal;
    unitVolume : String(2);
    unitWeight : String(2);
};

entity Suppliers : cuid {
    key supplier     : String(9);
        supplierName : String(40);
        webAddress   : String;
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
};

entity Stock : cuid {
    stockNumber : String(9);
    department  : String;
    min         : MyDecimal;
    max         : MyDecimal;
    target      : MyDecimal;
    lotSize     : Decimal(6, 3);
    quantity    : Decimal(6, 3);
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
