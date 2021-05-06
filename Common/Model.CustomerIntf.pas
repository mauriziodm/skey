unit Model.CustomerIntf;

interface

uses
  Model.BaseIntf, Model.SWHouseIntf, System.Generics.Collections;

type
  /// <stereotype>riceve nel costruttore un riferimento alla LicenseModel e al SWProduct</stereotype>
  ISWLicense = interface(ISWLicenseModel)
    procedure SetSessionsPermitted(val: Integer);
    function GetSessionsPermitted(): Integer;
    /// <semantics>Numero di utenti/postazioni permessi</semantics>
    property SessionsPermitted: Integer read GetSessionsPermitted write SetSessionsPermitted;
    function GetLicenseModel(): ISWLicenseModel;
    property LicenseModel: ISWLicenseModel read GetLicenseModel;
    function GetProduct(): ISWProduct;
    property Product: ISWProduct read GetProduct;
    procedure RevertToModel;
    procedure SetActive(val: Boolean);
    function GetActive(): Boolean;
    property Active: Boolean read GetActive write SetActive;
    function GetExpirationDays(): Integer;
    property ExpirationDays: Integer read GetExpirationDays;
    function GetExpiration(): TDate;
    property Expiration: TDate read GetExpiration;
    procedure SetActiveSince(val: TDate);
    function GetActiveSince(): TDate;
    property ActiveSince: TDate read GetActiveSince write SetActiveSince;
  end;

  ICustomer = interface(IBaseCompany)
    function GetLicenses: TList<ISWLicense>;
    property Licenses: TList<ISWLicense> read GetLicenses;
  end;

  ISWSessionManager = interface
    function GetOverallSessionCount(): Integer;
    property OverallSessionCount: Integer read GetOverallSessionCount;
    function GetOverbookingSessionCount(): Integer;
    property OverbookingSessionCount: Integer read GetOverbookingSessionCount;
    function GetActiveSessionCount(): Integer;
    property ActiveSessionCount: Integer read GetActiveSessionCount;
    function GetSessionToken(const AlicenseID: Integer; const AActivationKey, ASign: String; const AUserName: String = '';
      const APassword: String = ''): String;
  end;

  /// <stereotype>riceve ActiveFrom e ActiveTo oltre all'ID del padre come parametri del costruttore</stereotype>
  ISWSessionHistory = interface(IBaseEntity)
    function GetSWSession(): Integer;
    property SWSession: Integer read GetSWSession;
    function GetActiveUntil(): TDateTime;
    property ActiveUntil: TDateTime read GetActiveUntil;
    function GetActiveSince(): TDateTime;
    property ActiveSince: TDateTime read GetActiveSince;
  end;

  ISWSessionToken = interface;
  TSWSessionState = (ssInactive, ssOverbooking, ssActive);
  /// <stereotype>riceve la firma hardware (Sign) nel costruttore</stereotype>
  ISWSession = interface(IBaseEntity)
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
    procedure SetOverbookingCycles(val: Integer);
    function GetOverbookingCycles(): Integer;
    /// <preconditions>Normalmente rimane a zero ma se questo HW è stato creto in una situazione di overbooking allora assume valore 1 e il numero aumenta per ogni ciclo/richiesta di token permanendo in situazione di overbooking. Se la situazione di overbooking si risolve viene rimessa a zero, se invece il valore di questa proprietà supera la soglia massima consentita senza che sia risolto l'overbooking allora vienenegato il token e viene disattiva l'HW</preconditions>
    property OverbookingCycles: Integer read GetOverbookingCycles write SetOverbookingCycles;
    function GetExpiration(): TDateTime;
    /// <semantics>Indica la data fino alla quale questo HW è autorizzato a essere attivo</semantics>
    property Expiration: TDateTime read GetExpiration;
    function GetActiveSince(): TDateTime;
    /// <semantics>Indica la data a partire dalla quale questo HW risulta attivato</semantics>
    property ActiveSince: TDateTime read GetActiveSince;
    function GetSign(): String;
    /// <preconditions>Firma HW che identifica questo HW eventualmente integrata dello username del sistema operativo in caso di server RDP</preconditions>
    property Sign: String read GetSign;
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
