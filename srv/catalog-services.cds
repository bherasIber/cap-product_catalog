using {com.logali as logali} from '../db/schema';
using {com.training as training} from '../db/training';

// service CatalogService {

//     entity Products       as projection on logali.materials.Products;
//     entity Suppliers      as projection on logali.sales.Suppliers;
//     entity UnitOfMeasures as projection on logali.materials.UnitOfMeasures;
//     entity Currencies     as projection on logali.materials.Currencies;
//     entity DimensionUnits as projection on logali.materials.DimensionUnits;
//     entity Categories     as projection on logali.materials.Categories;
//     entity Months         as projection on logali.sales.Months;
//     entity SalesData      as projection on logali.sales.SalesData;
//     entity ProductReview  as projection on logali.materials.ProductReview;
//     entity Order          as projection on logali.sales.Orders;
//     entity OrderItem      as projection on logali.sales.OrderItems;

// //entity Car       as projection on logali.Car;
// }

define service CatalogService {

    entity Products as
        select from logali.materials.Products {
            ID,
            Name          as ProductName,
            Description,
            ImageURL,
            ReleaseDate,
            DiscontinuedDate,
            Price,
            Height,
            Width,
            Depth,
            Quantity,
            UnitOfMeasure as ToUnitOfMeasure,
            Currency      as ToCurrency,
            Category      as ToCategory,
            Category.Name as Category,
            DimensionUnit as ToDimensionUnit,
            SalesData,
            Supplier,
            Reviews
        };
}
