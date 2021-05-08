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
  end;

  ISWHouseSession = interface(IBaseSession<ISWHouse, ISWHouseOperator>)
  end;

  ISWLicenseModel = interface(IBaseNamedEntity)
    procedure SetProduct(val: ISWProduct);
    function GetProduct(): ISWProduct;
    property Product: ISWProduct read GetProduct write SetProduct;
    procedure SetMaxAppUserCount(val: Integer);
    function GetMaxAppUserCount(): Integer;
    property MaxAppUserCount: Integer read GetMaxAppUserCount write SetMaxAppUserCount;
    procedure SetMaxHWCount(val: Integer);
    function GetMaxHWCount(): Integer;
    property MaxHWCount: Integer read GetMaxHWCount write SetMaxHWCount;
    procedure SetSessionOverbooking_PermittedCycles(val: Integer);
    function GetSessionOverbooking_PermittedCycles(): Integer;
    property SessionOverbooking_PermittedCycles: Integer read GetSessionOverbooking_PermittedCycles write SetSessionOverbooking_PermittedCycles;
    procedure SetSessionToken_RefreshIntervalMinutes(val: Integer);
    function GetSessionToken_RefreshIntervalMinutes(): Integer;
    property SessionToken_RefreshIntervalMinutes: Integer read GetSessionToken_RefreshIntervalMinutes write SetSessionToken_RefreshIntervalMinutes;
    procedure SetLicenseToken_RefreshIntervalMinutes(val: Integer);
    function GetLicenseToken_RefreshIntervalMinutes(): Integer;
    /// <semantics>Sempre minore della validità del token (anche di parecchio)</semantics>
    property LicenseToken_RefreshIntervalMinutes: Integer read GetLicenseToken_RefreshIntervalMinutes write SetLicenseToken_RefreshIntervalMinutes;
    procedure SetMaxSessionCount(val: Integer);
    function GetMaxSessionCount(): Integer;
    property MaxSessionCount: Integer read GetMaxSessionCount write SetMaxSessionCount;
    procedure SetUserAuthentication(val: Boolean);
    function GetUserAuthentication(): Boolean;
    property UserAuthentication: Boolean read GetUserAuthentication write SetUserAuthentication;
    procedure SetExpirationDaysTolerance(val: Integer);
    function GetExpirationDaysTolerance(): Integer;
    property ExpirationDaysTolerance: Integer read GetExpirationDaysTolerance write SetExpirationDaysTolerance;
    procedure SetLocalSessionServer(val: Boolean);
    function GetLocalSessionServer(): Boolean;
    /// <semantics>Se True significa che 'è un LocalSessionServer dal cliente finale altrimenti no</semantics>
    property LocalSessionServer: Boolean read GetLocalSessionServer write SetLocalSessionServer;
    procedure SetSessionToken_ExpirationMinutes(val: Integer);
    function GetSessionToken_ExpirationMinutes(): Integer;
    /// <semantics>Minuti di validità del SessionToken espresso in minuti, deve sempre essere minore del "LicenseTokenExpirationMInutes"</semantics>
    property SessionToken_ExpirationMinutes: Integer read GetSessionToken_ExpirationMinutes write SetSessionToken_ExpirationMinutes;
    procedure SetLicenseToken_ExpirationMinutes(val: Integer);
    function GetLicenseToken_ExpirationMinutes(): Integer;
    property LicenseToken_ExpirationMinutes: Integer read GetLicenseToken_ExpirationMinutes write SetLicenseToken_ExpirationMinutes;
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
    procedure SetLicenseModels(val: TList<ISWLicenseModel>);
    function GetLicenseModels(): TList<ISWLicenseModel>;
    property LicenseModels: TList<ISWLicenseModel> read GetLicenseModels write SetLicenseModels;
  end;

implementation

end.
