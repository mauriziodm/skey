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
    procedure SetLicenseModels(val: TList<ISWLicenseModel>);
    function GetLicenseModels(): TList<ISWLicenseModel>;
    property LicenseModels: TList<ISWLicenseModel> read GetLicenseModels write SetLicenseModels;
  end;

  ISWHouseOperator = interface(IBaseUser)
  end;

  ISWHouseSession = interface(IBaseSession<ISWHouse, ISWHouseOperator>)
        end;

        ISWLicenseModel = interface(IBaseNamedEntity)
          procedure SetLocalSessionServer(val: Boolean);
          function GetLocalSessionServer(): Boolean;
          property LocalSessionServer: Boolean read GetLocalSessionServer write SetLocalSessionServer;
          procedure SetSessionTokenExpirationMinutes(val: Integer);
          function GetSessionTokenExpirationMinutes(): Integer;
          /// <semantics>Minuti di validità del SessionToken espresso in minuti, deve sempre essere minore del "LicenseTokenExpirationMInutes"</semantics>
          property SessionTokenExpirationMinutes: Integer read GetSessionTokenExpirationMinutes write SetSessionTokenExpirationMinutes;
          procedure SetLicenseTokenExpirationMinutes(val: Integer);
          function GetLicenseTokenExpirationMinutes(): Integer;
          /// <semantics>Minuti di validità del LicenseToken espresso in minuti, deve sempre essere maggiore della proprietà "SessionTokenExmirationMinutes"</semantics>
          property LicenseTokenExpirationMinutes: Integer read GetLicenseTokenExpirationMinutes write SetLicenseTokenExpirationMinutes;
          procedure SetHowManyUsers(val: Integer);
          function GetHowManyUsers(): Integer;
          /// <semantics>Numero di utenti/postazioni permessi</semantics>
          property HowManyUsers: Integer read GetHowManyUsers write SetHowManyUsers;
          procedure SetPayload(val: String);
          function GetPayload(): String;
          /// <semantics>Contenitore a disposizioine della SWHouse dovre poter memorizzare, ad es., impostazioni, autorizzazioni o altro</semantics>
          property Payload: String read GetPayload write SetPayload;
          procedure SetLicenseExpirationDays(val: Integer);
          function GetLicenseExpirationDays(): Integer;
          /// <semantics>Giorni di validità della licenza</semantics>
          property LicenseExpirationDays: Integer read GetLicenseExpirationDays write SetLicenseExpirationDays;
        end;

      implementation

end.
