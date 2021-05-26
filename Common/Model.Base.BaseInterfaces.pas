unit Model.Base.BaseInterfaces;

interface

type
  TUserPermission = (upReadOnly, upReadWrite, upSuperUser);
  TLoginState = (lsLoggedOut, lsLoginFailed, lsAuthenticating, lsLoggedOn);

  /// Base interfaces for all entities
  IBaseEntity = interface
    procedure SetID(val: Integer);
    function GetID(): Integer;
    property ID: Integer read GetID write SetID;
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

  IBaseUser = interface(IBaseContactableEntity)
    function ResetPassword: string;
    function CheckPassword(const APassword: string): boolean;
    procedure SetLoginUserName(const val: string);
    function GetLoginUserName(): string;
    property LoginUserName: string read GetLoginUserName write SetLoginUserName;
    procedure SetNote(const val: string);
    function GetNote(): string;
    property Note: string read GetNote write SetNote;
    procedure SetLoginPassword(val: string);
    function GetLoginPassword(): string;
    property LoginPassword: string read GetLoginPassword write SetLoginPassword;
  end;

  IBaseUserWithPermissions = interface(IBaseUser)
    procedure SetPermission(const val: TUserPermission);
    function GetPermission(): TUserPermission;
    property Permission: TUserPermission read GetPermission write SetPermission;
  end;

  IBaseSession<T_Company: IBaseCompany; T_User: IBaseUserWithPermissions> = interface
    procedure SetState(val: TLoginState);
    function GetState(): TLoginState;
    property State: TLoginState read GetState write SetState;
    procedure SetUser(val: T_User);
    function GetUser(): T_User;
    property User: T_User read GetUser write SetUser;
    procedure SetToken(val: string);
    function GetToken(): string;
    property Token: string read GetToken write SetToken;
    procedure SetCompany(val: T_Company);
    function GetCompany(): T_Company;
    property Company: T_Company read GetCompany write SetCompany;
    function Login: boolean;
    procedure SetLoginPassword(const val: string);
    function GetLoginPassword(): string;
    property LoginPassword: string read GetLoginPassword write SetLoginPassword;
    procedure SetLoginUserName(const val: string);
    function GetLoginUserName(): string;
    property LoginUserName: string read GetLoginUserName write SetLoginUserName;
    procedure Logout;
  end;

implementation

end.
