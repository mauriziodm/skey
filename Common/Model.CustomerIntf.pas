unit Model.CustomerIntf;

interface

uses
  Model.BaseIntf, Model.SWHouseIntf;

type
  /// <stereotype>riceve nel costruttore un riferimento alla LicenseModel e al SWProduct</stereotype>
  ISWLicense = interface(ISWLicenseModel)
    procedure SetHowManySessionPermitted(val: Integer);
    function GetHowManySessionPermitted(): Integer;
    /// <semantics>Numero di utenti/postazioni permessi</semantics>
    property HowManySessionPermitted: Integer read GetHowManySessionPermitted write SetHowManySessionPermitted;
    function GetSWLIcenseModel(): ISWLicenseModel;
    property SWLicenseModel: ISWLicenseModel read GetSWLIcenseModel;
    function GetSWProduct(): ISWProduct;
    property SWProduct: ISWProduct read GetSWProduct;
    procedure RevertToModel;
    procedure SetActive(val: Boolean);
    function GetActive(): Boolean;
    property Active: Boolean read GetActive write SetActive;
    function GetExpirationDays(): Integer;
    property ExpirationDays: Integer read GetExpirationDays;
    function GetExpirationDate(): Date;
    property ExpirationDate: Date read GetExpirationDate;
    procedure SetStartDate(val: TDate);
    function GetStartDate(): TDate;
    property StartDate: TDate read GetStartDate write SetStartDate;
  end;

  ICustomer = interface(IBaseCompany)
    function GetLicenses: TList<ISWLicense>;
    property Licenses: TList<ISWLicense> read GetLicenses;
  end;

  /// <stereotype>riceve la firma hardware (Sign) nel costruttore</stereotype>
  ISWSession = interface(IBaseEntity)
    procedure SetOverbookingCycles(val: Integer);
    function GetOverbookingCycles(): Integer;
    /// <preconditions>Normalmente rimane a zero ma se questo HW è stato creto in una situazione di overbooking allora assume valore 1 e il numero aumenta per ogni ciclo/richiesta di token permanendo in situazione di overbooking. Se la situazione di overbooking si risolve viene rimessa a zero, se invece il valore di questa proprietà supera la soglia massima consentita senza che sia risolto l'overbooking allora vienenegato il token e viene disattiva l'HW</preconditions>
    property OverbookingCycles: Integer read GetOverbookingCycles write SetOverbookingCycles;
    function GetActiveUntil(): TDateTime;
    /// <semantics>Indica la data fino alla quale questo HW è autorizzato a essere attivo</semantics>
    property ActiveUntil: TDateTime read GetActiveUntil;
    function GetActiveSince(): TDateTime;
    /// <semantics>Indica la data a partire dalla quale questo HW risulta attivato</semantics>
    property ActiveSince: TDateTime read GetActiveSince;
    function GetActive(): Boolean;
    /// <semantics>Quando di disattiva una sessione viene creato e persistito una istanza di ISWSessionHistory per mantenere uno storico</semantics>
    procedure SetActive;
    property Active: Boolean read GetActive write SetActive;
    function GetInfo(): String;
    /// <semantics>Eventuali informazioni in chiaro sull'HW per renderlo identificabile da noi essere umani</semantics>
    property Info: String read GetInfo;
    function GetSign(): String;
    /// <preconditions>Firma HW che identifica questo HW eventualmente integrata dello username del sistema operativo in caso di server RDP</preconditions>
    property Sign: String read GetSign;
  end;

  IHWHistory = interface
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

implementation

end.
