using {LogaliGroup as projection} from '../service';

annotate projection.StockSet with {
    stockNumber @title: 'Stock Bin Number';
    department  @title: 'Department';
    lotSize     @title: 'Lot Size'          @Measures.Unit: unit;
    quantity    @title: 'Ordered Quantity'  @Measures.Unit: unit;
    unit        @Common.IsUnit;
};

annotate projection.StockSet with @(
    UI.LineItem  : [
        {
            $Type : 'UI.DataField',
            Value : stockNumber
        },
        {
            $Type : 'UI.DataField',
            Value : department
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.Chart#ChartBullet',
            Label : ''
        },
        {
            $Type : 'UI.DataField',
            Value : lotSize
        },
        {
            $Type : 'UI.DataField',
            Value : quantity
        }
    ],
        UI.DataPoint #DataPointBullet : {
        $Type : 'UI.DataPointType',
        Value : target ,
        MaximumValue : max,
        MinimumValue: min,
        CriticalityCalculation : {
            $Type : 'UI.CriticalityCalculationType',
            ImprovementDirection : #Maximize,
            ToleranceRangeLowValue : 100,
            DeviationRangeLowValue : 20
        }
    },
    UI.Chart #ChartBullet : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Bullet,
        Measures : [
            target
        ],
        MeasureAttributes : [
            {
                $Type : 'UI.ChartMeasureAttributeType',
                DataPoint : '@UI.DataPoint#DataPointBullet',
                Measure : target
            }
        ]
    },
);

