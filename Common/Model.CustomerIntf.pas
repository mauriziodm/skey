unit Model.CustomerIntf;

interface

uses
  Model.BaseIntf, Model.SWHouseIntf, System.Generics.Collections, iORM.Containers.Interfaces;

type
  TSWSessionState = (ssExpired, ssExpiredOverbooked, ssDisposed, ssOverbooked, ssActive);
  ISWLicense = interface;
  ISWSession = interface;
  ISWSessionToken = interface;

  ICustomer = interface(IBaseCompany)
    function GetLicenses: TList<ISWLicense>;
    property Licenses: TList<ISWLicense> read GetLicenses;
  end;

  ISWSessionManager = interface
    function NewSession(const AlicenseID: Integer; const AActivationKey, AHWSign: String; const AUserName: String = ''; const APassword: String = ''): String;
    function PollSession(const ASessionID, AlicenseID: Integer; const AActivationKey, AHWSign: String; const AUserName: String = ''; const APassword: String = ''): String;
    procedure DisposeSession(const ASessionID, AlicenseID: Integer);
  end;
  /// <stereotype>riceve la firma hardware (Sign) nel costruttore</stereotype>
  ISWSession = interface(IBaseEntity)
    function GetPollingIntervalExpired(): Boolean;
    property PollingIntervalExpired: Boolean read GetPollingIntervalExpired;
    procedure SetPollingLast(val: TDateTime);
    function GetPollingLast(): TDateTime;
    property PollingLast: TDateTime read GetPollingLast write SetPollingLast;
    procedure SetPollingIntervalMinutes(val: Integer);
    function GetPollingIntervalMinutes(): Integer;
    property PollingIntervalMinutes: Integer read GetPollingIntervalMinutes write SetPollingIntervalMinutes;
    procedure SetOverbookedMax(val: Integer);
    function GetOverbookedMax(): Integer;
    property OverbookedMax: Integer read GetOverbookedMax write SetOverbookedMax;
    function GetIsDisposed(): Boolean;
    property IsDisposed: Boolean read GetIsDisposed;
    function GetIsExpired(): Boolean;
    property IsExpired: Boolean read GetIsExpired;
    function GetIsOverbooked(): Boolean;
    property IsOverbooked: Boolean read GetIsOverbooked;
    procedure SetSignAppUser(val: String);
    function GetSignAppUser(): String;
    property SignAppUser: String read GetSignAppUser write SetSignAppUser;
    function GetIsActive(): Boolean;
    property IsActive: Boolean read GetIsActive;
    procedure SetPayload(val: String);
    function GetPayload(): String;
    property Payload: String read GetPayload write SetPayload;
    procedure SetHash(val: String);
    function GetHash(): String;
    property Hash: String read GetHash write SetHash;
    procedure SetLicenseID(val: Integer);
    function GetLicenseID(): Integer;
    property LicenseID: Integer read GetLicenseID write SetLicenseID;
    procedure SetState(val: TSWSessionState);
    function GetState(): TSWSessionState;
    property State: TSWSessionState read GetState write SetState;
    procedure SetOverbookedCount(val: Integer);
    function GetOverbookedCount(): Integer;
    /// <preconditions>Normalmente rimane a zero ma se questo HW è stato creto in una situazione di overbooking allora assume valore 1 e il numero aumenta per ogni ciclo/richiesta di token permanendo in situazione di overbooking. Se la situazione di overbooking si risolve viene rimessa a zero, se invece il valore di questa proprietà supera la soglia massima consentita senza che sia risolto l'overbooking allora vienenegato il token e viene disattiva l'HW</preconditions>
    property OverbookedCount: Integer read GetOverbookedCount write SetOverbookedCount;
    function GetExpiration(): TDateTime;
    /// <semantics>Indica la data fino alla quale questo HW è autorizzato a essere attivo</semantics>
    property Expiration: TDateTime read GetExpiration;
    function GetActiveSince(): TDateTime;
    /// <semantics>Indica la data a partire dalla quale questo HW risulta attivato</semantics>
    property ActiveSince: TDateTime read GetActiveSince;
    function GetSignHW(): String;
    /// <preconditions>Firma HW che identifica questo HW eventualmente integrata dello username del sistema operativo in caso di server RDP</preconditions>
    /// <semantics>HW sign + OSUser</semantics>
    property SignHW: String read GetSignHW;
  end;

  TSKeyClientComponent = class
  private
    FLicenseID: Integer;
    FActivationKey: String;
    FUserName: String;
    FPassword: String;
    FSignIncludeAppUser: Boolean;
    FSignIncludeHW: Boolean;
    FSignIncludeOSUser: Boolean;
    FSignIncludeGUID: Boolean;
    FSession: ISWSessionToken;
    procedure SetLicenseID(val: Integer);
    procedure SetActivationKey(val: String);
    procedure SetUserName(val: String);
    procedure SetPassword(val: String);
    procedure SetSignIncludeAppUser(val: Boolean);
    procedure SetSignIncludeHW(val: Boolean);
    procedure SetSignIncludeOSUser(val: Boolean);
    procedure SetSignIncludeGUID(val: Boolean);
  public
    property LicenseID: Integer read FLicenseID write SetLicenseID;
    property ActivationKey: String read FActivationKey write SetActivationKey;
    property UserName: String read FUserName write SetUserName;
    property Password: String read FPassword write SetPassword;
    property SignIncludeAppUser: Boolean read FSignIncludeAppUser write SetSignIncludeAppUser;
    property SignIncludeHW: Boolean read FSignIncludeHW write SetSignIncludeHW;
    property SignIncludeOSUser: Boolean read FSignIncludeOSUser write SetSignIncludeOSUser;
    property SignIncludeGUID: Boolean read FSignIncludeGUID write SetSignIncludeGUID;
    property Session: ISWSessionToken read FSession;
    function OpenSession: Boolean;
    procedure CloseSession;
  end;

  TSWSessionTokenState = (stsUnauthorized, stsExpired, stsOverbooking, stsOK);

  ISWSessionToken = interface(IBaseEntity)
    procedure SetState(val: TSWSessionTokenState);
    function GetState(): TSWSessionTokenState;
    property State: TSWSessionTokenState read GetState write SetState;
    procedure SetHash(val: String);
    function GetHash(): String;
    property Hash: String read GetHash write SetHash;
    procedure SetRefreshIintervalMinutes(const val: Integer);
    function GetRefreshIintervalMinutes(): Integer;
    property RefreshIintervalMinutes: Integer read GetRefreshIintervalMinutes write SetRefreshIintervalMinutes;
    procedure SetSign(const val: String);
    function GetSign(): String;
    property Sign: String read GetSign write SetSign;
    procedure SetPayload(const val: String);
    function GetPayload(): String;
    property Payload: String read GetPayload write SetPayload;
    procedure SetLicenseID(const val: Integer);
    function GetLicenseID(): Integer;
    property LicenseID: Integer read GetLicenseID write SetLicenseID;
    procedure SetExpiration(const val: TDateTime);
    function GetExpiration(): TDateTime;
    property Expiration: TDateTime read GetExpiration write SetExpiration;
    procedure SetActiveSince(const val: TDateTime);
    function GetActiveSince(): TDateTime;
    property ActiveSince: TDateTime read GetActiveSince write SetActiveSince;
  end;

  TSWLicenseState = (lsSuspended, lsExpired, lsActive);

  /// <stereotype>riceve nel costruttore un riferimento alla LicenseModel e al SWProduct</stereotype>
  ISWLicense = interface(ISWLicenseModel)
    function GetCounterSessions(): Integer;
    property CounterSessions: Integer read GetCounterSessions;
    function GetCounterAppUsers(): Integer;
    property CounterAppUsers: Integer read GetCounterAppUsers;
    function GetCounterHW(): Integer;
    property CounterHW: Integer read GetCounterHW;
    function GetIsExpired(): Boolean;
    property IsExpired: Boolean read GetIsExpired;
    function GetIsSuspended(): Boolean;
    property IsSuspended: Boolean read GetIsSuspended;
    procedure SetHash(val: String);
    function GetHash(): String;
    property Hash: String read GetHash write SetHash;
    procedure SetNote(val: String);
    function GetNote(): String;
    property Note: String read GetNote write SetNote;
    procedure SetState(val: TSWLicenseState);
    function GetState(): TSWLicenseState;
    property State: TSWLicenseState read GetState write SetState;
    function GetSessions(): IioList<ISWSession>;
    /// <semantics>LazyLoad?</semantics>
    property Sessions: IioList<ISWSession> read GetSessions;
    function GetLicenseModel(): ISWLicenseModel;
    property LicenseModel: ISWLicenseModel read GetLicenseModel;
    procedure RevertToModel;
    function GetIsActive(): Boolean;
    property IsActive: Boolean read GetIsActive;
    function GetExpiration(): TDate;
    property Expiration: TDate read GetExpiration;
    procedure SetActiveSince(val: TDate);
    function GetActiveSince(): TDate;
    property ActiveSince: TDate read GetActiveSince write SetActiveSince;
  end;

  ISWLicenseUser = interface
  end;

implementation

procedure TSKeyClientComponent.SetLicenseID(val: Integer);
begin
end;

procedure TSKeyClientComponent.SetActivationKey(val: String);
begin
end;

procedure TSKeyClientComponent.SetUserName(val: String);
begin
end;

procedure TSKeyClientComponent.SetPassword(val: String);
begin
end;

procedure TSKeyClientComponent.SetSignIncludeAppUser(val: Boolean);
begin
end;

procedure TSKeyClientComponent.SetSignIncludeHW(val: Boolean);
begin
end;

procedure TSKeyClientComponent.SetSignIncludeOSUser(val: Boolean);
begin
end;

procedure TSKeyClientComponent.SetSignIncludeGUID(val: Boolean);
begin
end;

function TSKeyClientComponent.OpenSession: Boolean;
begin
end;

procedure TSKeyClientComponent.CloseSession;
begin
end;

end.
