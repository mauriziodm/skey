unit Model.BaseIntf;

interface

type
  IBaseCompany = interface;
  IBaseUser = interface;
  /// Base interfaces for all entities
  IBaseEntity = interface
    function GetID(): Integer;
    property ID: Integer read GetID;
  end;

  IBaseNamedEntity = interface(IBaseEntity)
    procedure SetName(val: String);
    function GetName(): String;
    property Name: String read GetName write SetName;
  end;

  IBaseContactableEntity = interface(IBaseNamedEntity)
    procedure SetEMail(val: String);
    function GetEMail(): String;
    property EMail: String read GetEMail write SetEMail;
    procedure SetPhone(val: String);
    function GetPhone(): String;
    property Phone: String read GetPhone write SetPhone;
  end;

  IBaseCompany = interface(IBaseContactableEntity)
    procedure SetCountry(val: String);
    function GetCountry(): String;
    property Country: String read GetCountry write SetCountry;
    procedure SetZipCode(val: String);
    function GetZipCode(): String;
    property ZipCode: String read GetZipCode write SetZipCode;
    procedure SetProvince(val: String);
    function GetProvince(): String;
    property Province: String read GetProvince write SetProvince;
    procedure SetCity(val: String);
    function GetCity(): String;
    property City: String read GetCity write SetCity;
    procedure SetAddress(val: String);
    function GetAddress(): String;
    property Address: String read GetAddress write SetAddress;
  end;

  TUserPermission = (upReadOnly, upReadWrite, upSuperUser);

  IBaseUser = interface(IBaseContactableEntity)
    procedure SetLoginPassword(val: String);
    function GetLoginPassword(): String;
    property LoginPassword: String read GetLoginPassword write SetLoginPassword;
    function ResetPassword: String;
    function CheckPassword(const APassword: String): Boolean;
    procedure SetPermission(const val: TUserPermission);
    function GetPermission(): TUserPermission;
    property Permission: TUserPermission read GetPermission write SetPermission;
    procedure SetNote(const val: String);
    function GetNote(): String;
    property Note: String read GetNote write SetNote;
    procedure SetLoginUserName(const val: String);
    function GetLoginUserName(): String;
    property LoginUserName: String read GetLoginUserName write SetLoginUserName;
  end;

  TLoginState = (lsLoggedOut, lsLoginFailed, lsAuthenticating, lsLoggedOn);

  IBaseSession<T_Company: IBaseCompany; T_User: IBaseUser> = interface
    function GetState(): TLoginState;
    property State: TLoginState read GetState;
    function Login: Boolean;
    procedure SetLoginPassword(const val: string);
    function GetLoginPassword(): string;
    property LoginPassword: string read GetLoginPassword write SetLoginPassword;
    procedure SetLoginUserName(const val: string);
    function GetLoginUserName(): string;
    property LoginUserName: string read GetLoginUserName write SetLoginUserName;
    function GetCompany(): IBaseCompany;
    /// <supplierCardinality>1</supplierCardinality>
    /// <clientCardinality>1</clientCardinality>
    property Company: IBaseCompany read GetCompany;
    function GetToken(): String;
    property Token: String read GetToken;
    procedure Logout;
    function GetUser(): IBaseUser;
    /// <clientCardinality>1</clientCardinality>
    /// <supplierCardinality>1</supplierCardinality>
    property User: IBaseUser read GetUser;
  end;

implementation

end.
