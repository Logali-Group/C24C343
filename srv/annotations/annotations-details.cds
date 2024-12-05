using {LogaliGroup as projection} from '../service';

annotate projection.DetailsSet with {
    baseUnit    @title: 'Base Unit';
    width       @title: 'Width'           @Measures.Unit: unitVolume;
    height      @title: 'Height'          @Measures.Unit: unitVolume;
    depth       @title: 'Depth'           @Measures.Unit: unitVolume;
    weight      @title: 'Weight'          @Measures.Unit: unitWeight;
    unitVolume  @title: 'Unit Of Volume'  @Common.IsUnit;
    unitWeight  @title: 'Unit Of Weight'  @Common.IsUnit;
};

annotate projection.DetailsSet with @(UI.FieldGroup #Details: {
    $Type: 'UI.FieldGroupType',
    Data : [
        {
            $Type: 'UI.DataField',
            Value: baseUnit
        },
        {
            $Type: 'UI.DataField',
            Value: width
        },
        {
            $Type: 'UI.DataField',
            Value: height
        },
        {
            $Type : 'UI.DataField',
            Value : depth
        },
        {
            $Type: 'UI.DataField',
            Value: weight
        }
    ],
    Label: 'Technical Data'
});
