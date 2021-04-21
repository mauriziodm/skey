unit Model.SWHouseIntf;

interface

uses Model.baseintf, System.Generics.Collections;

type
  ISWHouseOperator = interface;
  ISWProduct = interface;

  ISWHouse = interface(IBaseCompany)
    function GetUsers(): TList<ISWHouseOperator>;
    property Users: TList<ISWHouseOperator> read GetUsers;
    function GetProducts: TList<ISWProduct>;
    property Products: TList<ISWProduct> read GetProducts;
  end;

  ISWProduct = interface(IBaseNamedEntity)
  end;

  ISWHouseOperator = interface(IBaseUser)
  end;

  ISWLicenseModel = interface(IBaseNamedEntity)
    procedure SetSessionTokenExpirationMinutes(val: Integer);
    function GetSessionTokenExpirationMinutes(): Integer;
    property SessionTokenExpirationMinutes: Integer read GetSessionTokenExpirationMinutes write SetSessionTokenExpirationMinutes;
    procedure SetLicenseTokenExpirationDays(val: Integer);
    function GetLicenseTokenExpirationDays(): Integer;
    property LicenseTokenExpirationDays: Integer read GetLicenseTokenExpirationDays write SetLicenseTokenExpirationDays;
    procedure SetHowManyUsers(val: Integer);
    function GetHowManyUsers(): Integer;
    property HowManyUsers: Integer read GetHowManyUsers write SetHowManyUsers;
    procedure SetPayload(val: String);
    function GetPayload(): String;
    property Payload: String read GetPayload write SetPayload;
    procedure SetExpirationDays(val: Integer);
    function GetExpirationDays(): Integer;
    property ExpirationDays: Integer read GetExpirationDays write SetExpirationDays;
  end;

  ISWHouseSession = interface(IBaseSession<ISWHouse, ISWHouseOperator>)
  end;

implementation

end.
