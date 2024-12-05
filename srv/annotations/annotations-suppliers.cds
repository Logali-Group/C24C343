using {LogaliGroup as projection} from '../service';
using from './annotations-contacts';

// {} --> Anotaciones para los campos de la entidad
// @() --> Anotaciones para la entidad

annotate projection.SuppliersSet with {
    ID           @title: 'Suppliers'  @Common: {
        Text           : supplierName,
        TextArrangement: #TextOnly
    };
    supplier     @title: 'Supplier';
    supplierName @title: 'Supplier Name';
    webAddress   @title: 'Web Address';
};

annotate projection.SuppliersSet with @(
    UI.FieldGroup #Supplier : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : supplier
            },
            {
                $Type : 'UI.DataField',
                Value : supplierName
            },
            {
                $Type : 'UI.DataField',
                Value : webAddress
            }
        ]
    }
);

