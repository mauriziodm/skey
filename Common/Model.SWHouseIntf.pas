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
          procedure SetSessionSign_IncludeAppUser(val: Integer);
          function GetSessionSign_IncludeAppUser(): Integer;
          property SessionSign_IncludeAppUser: Integer read GetSessionSign_IncludeAppUser write SetSessionSign_IncludeAppUser;
          procedure SetSessionSign_IncludeOSUser(val: Boolean);
          function GetSessionSign_IncludeOSUser(): Boolean;
          property SessionSign_IncludeOSUser: Boolean read GetSessionSign_IncludeOSUser write SetSessionSign_IncludeOSUser;
          procedure SetSessionSign_IncludeHWSign(val: Boolean);
          function GetSessionSign_IncludeHWSign(): Boolean;
          property SessionSign_IncludeHWSign: Boolean read GetSessionSign_IncludeHWSign write SetSessionSign_IncludeHWSign;
          procedure SetSessionToken_RefreshIntervalMinutes(val: Integer);
          function GetSessionToken_RefreshIntervalMinutes(): Integer;
          property SessionToken_RefreshIntervalMinutes: Integer read GetSessionToken_RefreshIntervalMinutes write SetSessionToken_RefreshIntervalMinutes;
          procedure SetLicenseToken_RefreshIntervalMinutes(val: Integer);
          function GetLicenseToken_RefreshIntervalMinutes(): Integer;
          /// <semantics>Sempre minore della validità del token (anche di parecchio)</semantics>
          property LicenseToken_RefreshIntervalMinutes: Integer read GetLicenseToken_RefreshIntervalMinutes write SetLicenseToken_RefreshIntervalMinutes;
          procedure SetMaxNumberOfSessions(val: Integer);
          function GetMaxNumberOfSessions(): Integer;
          property MaxNumberOfSessions: Integer read GetMaxNumberOfSessions write SetMaxNumberOfSessions;
          procedure SetMinNumberOfSessions(val: Integer);
          function GetMinNumberOfSessions(): Integer;
          property MinNumberOfSessions: Integer read GetMinNumberOfSessions write SetMinNumberOfSessions;
          procedure SetUserAuthentication(val: Boolean);
          function GetUserAuthentication(): Boolean;
          property UserAuthentication: Boolean read GetUserAuthentication write SetUserAuthentication;
          procedure SetLicenseExpirationDaysTolerance(val: Integer);
          function GetLicenseExpirationDaysTolerance(): Integer;
          property LicenseExpirationDaysTolerance: Integer read GetLicenseExpirationDaysTolerance write SetLicenseExpirationDaysTolerance;
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
          procedure SetLicenseExpirationDays(val: Integer);
          function GetLicenseExpirationDays(): Integer;
          /// <semantics>Giorni di validità della licenza</semantics>
          property LicenseExpirationDays: Integer read GetLicenseExpirationDays write SetLicenseExpirationDays;
        end;

      implementation

end.iorni di validità della licenza</semantics>
          property LicenseExpirationDays: Integer read GetLicenseExpirationDays write SetLicenseExpirationDays;
        end;

      implementation

end.
