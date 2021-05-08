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

  ISWHouseOperator = interface(IBaseUserWithPermissions)
    procedure SetSWHouseID(val: Integer);
    function GetSWHouseID(): Integer;
    property SWHouseID: Integer read GetSWHouseID write SetSWHouseID;
  end;

  ISWHouseSession = interface(IBaseSession<ISWHouse, ISWHouseOperator>)
  end;

  ISWLicenseModel = interface(IBaseNamedEntity)
    procedure SetExpirationDaysWarning(val: Integer);
    function GetExpirationDaysWarning(): Integer;
    property ExpirationDaysWarning: Integer read GetExpirationDaysWarning write SetExpirationDaysWarning;
    procedure SetProductID(val: Integer);
    function GetProductID(): Integer;
    property ProductID: Integer read GetProductID write SetProductID;
    procedure SetMaxAppUserCount(val: Integer);
    function GetMaxAppUserCount(): Integer;
    property MaxAppUserCount: Integer read GetMaxAppUserCount write SetMaxAppUserCount;
    procedure SetMaxHWCount(val: Integer);
    function GetMaxHWCount(): Integer;
    property MaxHWCount: Integer read GetMaxHWCount write SetMaxHWCount;
    procedure SetOverbookingMaxCycles(val: Integer);
    function GetOverbookingMaxCycles(): Integer;
    property OverbookingMaxCycles: Integer read GetOverbookingMaxCycles write SetOverbookingMaxCycles;
    procedure SetSessionPollingINtervalMinutes(val: Integer);
    function GetSessionPollingINtervalMinutes(): Integer;
    property SessionPollingIntervalMinutes: Integer read GetSessionPollingINtervalMinutes write SetSessionPollingINtervalMinutes;
    procedure SetSessionServerPollingIntervalMinutes(val: Integer);
    function GetSessionServerPollingIntervalMinutes(): Integer;
    /// <semantics>Sempre minore della validità del token (anche di parecchio)</semantics>
    property SessionServerPollingIntervalMinutes: Integer read GetSessionServerPollingIntervalMinutes write SetSessionServerPollingIntervalMinutes;
    procedure SetMaxSessionCount(val: Integer);
    function GetMaxSessionCount(): Integer;
    property MaxSessionCount: Integer read GetMaxSessionCount write SetMaxSessionCount;
    procedure SetUserAuthentication(val: Boolean);
    function GetUserAuthentication(): Boolean;
    property UserAuthentication: Boolean read GetUserAuthentication write SetUserAuthentication;
    procedure SetExpirationDaysTolerance(val: Integer);
    function GetExpirationDaysTolerance(): Integer;
    property ExpirationDaysTolerance: Integer read GetExpirationDaysTolerance write SetExpirationDaysTolerance;
    procedure SetSessionServer(val: Boolean);
    function GetSessionServer(): Boolean;
    /// <semantics>Se True significa che 'è un LocalSessionServer dal cliente finale altrimenti no</semantics>
    property SessionServer: Boolean read GetSessionServer write SetSessionServer;
    procedure SetSessionExpirationMinutes(val: Integer);
    function GetSessionExpirationMinutes(): Integer;
    /// <semantics>Minuti di validità del SessionToken espresso in minuti, deve sempre essere minore del "LicenseTokenExpirationMInutes"</semantics>
    property SessionExpirationMinutes: Integer read GetSessionExpirationMinutes write SetSessionExpirationMinutes;
    procedure SetSessionServerExpirationMinutes(val: Integer);
    function GetSessionServerExpirationMinutes(): Integer;
    property SessionServerExpirationMinutes: Integer read GetSessionServerExpirationMinutes write SetSessionServerExpirationMinutes;
    procedure SetPayload(val: String);
    function GetPayload(): String;
    /// <semantics>Contenitore a disposizioine della SWHouse dovre poter memorizzare, ad es., impostazioni, autorizzazioni o altro</semantics>
    property Payload: String read GetPayload write SetPayload;
    procedure SetExpirationDays(val: Integer);
    function GetExpirationDays(): Integer;
    /// <semantics>Giorni di validità della licenza</semantics>
    property ExpirationDays: Integer read GetExpirationDays write SetExpirationDays;
  end;

  ISWProduct = interface(IBaseNamedEntity)
    procedure SetSWHouseID(val: Integer);
    function GetSWHouseID(): Integer;
    property SWHouseID: Integer read GetSWHouseID write SetSWHouseID;
    procedure SetLicenseModels(val: TList<ISWLicenseModel>);
    function GetLicenseModels(): TList<ISWLicenseModel>;
    property LicenseModels: TList<ISWLicenseModel> read GetLicenseModels write SetLicenseModels;
  end;

implementation

end.
