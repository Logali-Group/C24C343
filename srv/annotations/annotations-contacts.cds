using {LogaliGroup as projection} from '../service';

annotate projection.ContactsSet with {
    fullName    @title: 'Full Name';
    email       @title: 'Email';
    phoneNumber @title: 'Phone Number';
};


annotate projection.ContactsSet with @(
    UI.FieldGroup #Contact : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : fullName
            },
            {
                $Type : 'UI.DataField',
                Value : email
            },
            {
                $Type : 'UI.DataField',
                Value : phoneNumber
            }
        ]
    }
);
