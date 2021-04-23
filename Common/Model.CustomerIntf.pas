unit Model.CustomerIntf;

interface

uses
  Model.BaseIntf, Model.SWHouseIntf;

type
  ISWLicense = interface(ISWLicenseModel)
    function GetModel(): ISWLicenseModel;
    property Model: ISWLicenseModel read GetModel write SetProperty1;
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

implementation

end.
