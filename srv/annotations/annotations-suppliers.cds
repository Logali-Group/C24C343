using {LogaliGroup as projection} from '../service';

annotate projection.SuppliersSet with {
    ID @title : 'Suppliers' @Common : { 
        Text : supplierName,
        TextArrangement : #TextOnly
     };
     supplier @title : 'Supplier';
};
