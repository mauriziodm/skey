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

        THWLockType = (hwFree, hwLocked, hwLockedButNew);

        ISWLicenseModel = interface(IBaseNamedEntity)
          procedure SetMaximumNumersOfUsers(val: Integer);
          function GetMaximumNumersOfUsers(): Integer;
          property MaximumNumersOfUsers: Integer read GetMaximumNumersOfUsers write SetMaximumNumersOfUsers;
          procedure SetMinimumNumberOfUsers(val: Integer);
          function GetMinimumNumberOfUsers(): Integer;
          property MinimumNumberOfUsers: Integer read GetMinimumNumberOfUsers write SetMinimumNumberOfUsers;
          procedure SetUserAuthentication(val: Boolean);
          function GetUserAuthentication(): Boolean;
          property UserAuthentication: Boolean read GetUserAuthentication write SetUserAuthentication;
          procedure SetValidityDaysTolerance(val: Integer);
          function GetValidityDaysTolerance(): Integer;
          property ValidityDaysTolerance: Integer read GetValidityDaysTolerance write SetValidityDaysTolerance;
          procedure SetUserMultiSessionAllowed(val: Boolean);
          function GetUserMultiSessionAllowed(): Boolean;
          /// <semantics>Se True un singolo client user potrà aprire più sessioni contemporaneamente su una stesso macchina e stesso login (verrà conteggiato come una sola sessione/utente)</semantics>
          property UserMultiSessionAllowed: Boolean read GetUserMultiSessionAllowed write SetUserMultiSessionAllowed;
          procedure SetClientHWLock(val: THWLockType);
          function GetClientHWLock(): THWLockType;
          /// <semantics>Indica se, sul client, l'esecuzione deve essere legata ad un HW specifico e in che modo</semantics>
          property ClientHWLock: THWLockType read GetClientHWLock write SetClientHWLock;
          procedure SetLocalSessionServer(val: Boolean);
          function GetLocalSessionServer(): Boolean;
          /// <semantics>Se True significa che 'è un LocalSessionServer dal cliente finale altrimenti no</semantics>
          property LocalSessionServer: Boolean read GetLocalSessionServer write SetLocalSessionServer;
          procedure SetSessionTokenValidityMinutes(val: Integer);
          function GetSessionTokenValidityMinutes(): Integer;
          /// <semantics>Minuti di validità del SessionToken espresso in minuti, deve sempre essere minore del "LicenseTokenExpirationMInutes"</semantics>
          property SessionTokenValidityMinutes: Integer read GetSessionTokenValidityMinutes write SetSessionTokenValidityMinutes;
          procedure SetLicenseTokenValidityMinutes(val: Integer);
          function GetLicenseTokenValidityMinutes(): Integer;
          /// <semantics>Minuti di validità del LicenseToken espresso in minuti, deve sempre essere maggiore della proprietà "SessionTokenExmirationMinutes"</semantics>
          property LicenseTokenValidityMinutes: Integer read GetLicenseTokenValidityMinutes write SetLicenseTokenValidityMinutes;
          procedure SetPayload(val: String);
          function GetPayload(): String;
          /// <semantics>Contenitore a disposizioine della SWHouse dovre poter memorizzare, ad es., impostazioni, autorizzazioni o altro</semantics>
          property Payload: String read GetPayload write SetPayload;
          procedure SetValidityDays(val: Integer);
          function GetValidityDays(): Integer;
          /// <semantics>Giorni di validità della licenza</semantics>
          property ValidityDays: Integer read GetValidityDays write SetValidityDays;
        end;

      implementation

end.
