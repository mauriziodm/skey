unit Model.Licenses.LicenseInterfaces;

interface

uses
  Model.Base.BaseInterfaces, iORM.CommonTypes, System.Generics.Collections;

type
  TSWLicenseState = (lsInactive, lsExpired, lsActive);

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
    function GetLicenseModels(): TList<ISWLicenseModel>;
    property LicenseModels: TList<ISWLicenseModel> read GetLicenseModels;
  end;

  ISWLicenseUser = interface(IBaseUser)
    procedure SetPayload(val: String);
    function GetPayload(): String;
    property Payload: String read GetPayload write SetPayload;
  end;

  /// <stereotype>riceve nel costruttore un riferimento alla LicenseModel e al SWProduct</stereotype>
  ISWLicense = interface(ISWLicenseModel)
    procedure SetCreatedOn(val: TDateTime);
    function GetCreatedOn(): TDateTime;
    property CreatedOn: TDateTime read GetCreatedOn write SetCreatedOn;
    procedure SetObjStatus(val: TioObjectStatus);
    function GetObjStatus(): TioObjectStatus;
    property ObjStatus: TioObjectStatus read GetObjStatus write SetObjStatus;
    procedure SetSessionServerExpiration(val: TDateTime);
    function GetSessionServerExpiration(): TDateTime;
    property SessionServerExpiration: TDateTime read GetSessionServerExpiration write SetSessionServerExpiration;
    procedure SetUsers(val: TList<ISWLicenseUser>);
    function GetUsers(): TList<ISWLicenseUser>;
    /// <semantics>[ioHasMany]</semantics>
    property Users: TList<ISWLicenseUser> read GetUsers write SetUsers;
    function GetCounterSessions(): Integer;
    /// <semantics>[ioSkip]</semantics>
    property CounterSessions: Integer read GetCounterSessions;
    function GetCounterAppUsers(): Integer;
    /// <semantics>[ioSkip]</semantics>
    property CounterAppUsers: Integer read GetCounterAppUsers;
    function GetCounterHW(): Integer;
    /// <semantics>[ioSkip]</semantics>
    property CounterHW: Integer read GetCounterHW;
    function GetIsExpired(): Boolean;
    /// <semantics>[ioSkip]</semantics>
    property IsExpired: Boolean read GetIsExpired;
    procedure SetHash(val: String);
    function GetHash(): String;
    property Hash: String read GetHash write SetHash;
    procedure SetNote(val: String);
    function GetNote(): String;
    property Note: String read GetNote write SetNote;
    function GetState(): TSWLicenseState;
    /// <semantics>[ioSkip]</semantics>
    property State: TSWLicenseState read GetState;
    function GetSessions(): IioList<ISWSession>;
    /// <semantics>[ioLoadOnly][ioHasMany] LazyLoad?</semantics>
    property Sessions: IioList<ISWSession> read GetSessions;
    function GetLicenseModel(): ISWLicenseModel;
    /// <semantics>[ioBelongsTo]</semantics>
    property LicenseModel: ISWLicenseModel read GetLicenseModel;
    procedure RevertToModel;
    procedure SetActive(val: Boolean);
    function GetActive(): Boolean;
    property Active: Boolean read GetActive write SetActive;
    function GetExpiration(): TDate;
    property Expiration: TDate read GetExpiration;
    procedure SetActiveSince(val: TDate);
    function GetActiveSince(): TDate;
    property ActiveSince: TDate read GetActiveSince write SetActiveSince;
  end;

  ISWSessionManager = interface(IBaseEntity)
    function GetSessionServerPollingIsExpired(): Boolean;
    /// <semantics>[ioSkip]</semantics>
    property SessionServerPollingIsExpired: Boolean read GetSessionServerPollingIsExpired;
    procedure SetSessionServerPollingLast(val: TDateTime);
    function GetSessionServerPollingLast(): TDateTime;
    property SessionServerPollingLast: TDateTime read GetSessionServerPollingLast write SetSessionServerPollingLast;
    function NewSession(const AlicenseID: Integer; const AActivationKey, AHWSign: string; const AUserName: string = ''; const APassword: string = ''): string;
    function PollSession(const ASessionID, AlicenseID: Integer; const AActivationKey, AHWSign: string; const AUserName: string = '';
      const APassword: string = ''): string;
    procedure DisposeSession(const ASessionID, AlicenseID: Integer);
  end;

implementation

end.
