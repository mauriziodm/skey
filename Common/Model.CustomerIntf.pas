unit Model.CustomerIntf;

interface

uses
  Model.BaseIntf, Model.SWHouseIntf;

type
  /// <stereotype>riceve nel costruttore un riferimento alla LicenseModel e al SWProduct</stereotype>
  ISWLicense = interface(ISWLicenseModel)
    procedure SetHowManyUsers(val: Integer);
    function GetHowManyUsers(): Integer;
    /// <semantics>Numero di utenti/postazioni permessi</semantics>
    property HowManyUsers: Integer read GetHowManyUsers write SetHowManyUsers;
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
  IHWHistoryItem = interface(IBaseEntity)
    procedure SetDoNotConsiderAsPreviousUse(val: Boolean);
    function GetDoNotConsiderAsPreviousUse(): Boolean;
    property DoNotConsiderAsPreviousUse: Boolean read GetDoNotConsiderAsPreviousUse write SetDoNotConsiderAsPreviousUse;
    function GetActiveTo(): TDate;
    property ActiveTo: TDate read GetActiveTo;
    function GetActiveFrom(): TDate;
    property ActiveFrom: TDate read GetActiveFrom;
    function GetActive(): Boolean;
    property Active: Boolean read GetActive;
    function GetInfo(): String;
    property Info: String read GetInfo;
    function GetSign(): String;
    property Sign: String read GetSign;
  end;

implementation

end.
