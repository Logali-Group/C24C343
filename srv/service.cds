using {com.logaligroup as entities} from '../db/schema';

service LogaliGroup {
    entity ProductsSet      as projection on entities.Products;
    entity DetailsSet       as projection on entities.Details;
    entity SuppliersSet     as projection on entities.Suppliers;
    entity ContactsSet      as projection on entities.Contacts;
    entity ReviewsSet       as projection on entities.Reviews;
    entity StockSet         as projection on entities.Stock;
    entity VH_Categories    as projection on entities.Categories;
    entity VH_SubCategories as projection on entities.SubCategories;
    entity VH_Availability  as projection on entities.Availability;
};
