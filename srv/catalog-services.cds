using {com.logali as logali} from '../db/schema';

service CatalogService {

    entity Products       as projection on logali.Products;
    entity Suppliers      as projection on logali.Suppliers;
    entity UnitOfMeasures as projection on logali.UnitOfMeasures;
    entity Currencies as projection on logali.Currencies;
    entity DimensionUnits as projection on logali.DimensionUnits;
    entity Categories as projection on logali.Categories;
    entity Months as projection on logali.Months;

//entity Car       as projection on logali.Car;
}
