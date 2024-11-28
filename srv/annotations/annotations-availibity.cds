using {LogaliGroup as projection} from '../service';

annotate projection.VH_Availability with {
    code @title : 'Code' @Common : { 
        Text : name,
        TextArrangement : #TextOnly
     }
};
