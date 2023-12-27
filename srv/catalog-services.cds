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

    entity Products          as
        select from logali.reports.Products {
            ID,
            Name          as ProductName     @mandatory,
            Description                      @mandatory,
            ImageURL,
            ReleaseDate,
            DiscontinuedDate,
            Price                            @mandatory,
            Height,
            Width,
            Depth,
            Quantity                         @(
                mandatory,
                assert.range: [
                    0.00,
                    20.00
                ]
            ),
            UnitOfMeasure as ToUnitOfMeasure @mandatory,
            Currency      as ToCurrency      @mandatory,
            Currency.ID   as CurrencyId,
            Category      as ToCategory      @mandatory,
            Category.ID   as CategoryId,
            Category.Name as Category        @readonly,
            DimensionUnit as ToDimensionUnit @mandatory,
            SalesData,
            Supplier,
            Reviews,
            Rating,
            StockAvailability,
            ToStockAvailability
        };

    entity Supplier          as
        select from logali.sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as ToProduct
        };

    @readonly
    entity Reviews           as
        select from logali.materials.ProductReview {
            ID,
            Name,
            Rating,
            Comment,
            createdAt,
            Product
        };

    @readonly
    entity SalesData         as
        select from logali.sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            Currency.ID               as CurrencyKey,
            DeliveryMonth.ID          as DeliveryMonthId,
            DeliveryMonth.Description as DeliveryMonth,
            Product                   as ToProduct
        };

    @readonly
    entity StockAvailability as
        select from logali.materials.StockAvailability {
            ID,
            Description,
            Product as ToProduct
        };

    @readonly
    entity VH_Categories     as
        select from logali.materials.Categories {
            ID   as Code,
            Name as Text
        };

    @readonly
    entity VH_Currencies     as
        select from logali.materials.Currencies {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_UnitOfMeasure  as
        select from logali.materials.UnitOfMeasures {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_DimensionUnits as
        select
            ID          as Code,
            Description as Text
        from logali.materials.DimensionUnits;

}

define service MyService {

    entity SuppliersProduct  as
        select from logali.materials.Products[Name = 'Bread']{
            *,
            Name,
            Description,
            Supplier.Address
        }
        where
            Supplier.Address.PostalCode = 98074;

    entity SupplierToSales   as
        select
            Supplier.Email,
            Category.Name,
            SalesData.Currency.ID,
            SalesData.Currency.Description
        from logali.materials.Products;

    entity EntityInfix       as
        select Supplier[Name = 'Exotic Liquids'].Phone from logali.materials.Products
        where
            Products.Name = 'Bread';

    entity EntityJoin        as
        select Phone from logali.materials.Products
        left join logali.sales.Suppliers as supp
            on(
                supp.ID = Products.Supplier.ID
            )
            and supp.Name = 'Exotic Liquids'
        where
            Products.Name = 'Bread';

}

define service Reports {

    entity AverageRating     as projection on logali.reports.AverageRating;

    entity EntityCasting     as
        select
            cast(
                Price as      Integer
            )     as Price,
            Price as Price2 : Integer
        from logali.materials.Products;

    entity EntityExists      as
        select from logali.materials.Products {
            Name
        }
        where
            exists Supplier[Name = 'Exotic Liquids'];

}
