unit Model.BaseIntf;

interface

type
  IBaseUser = interface;

  /// Base interfaces for all entities
  IBaseEntity = interface
    function GetID(): Integer;
    property ID: Integer read GetID;
  end;

  /// Base interface for all named entities
  IBaseNamedEntity = interface(IBaseEntity)
    procedure SetName(const val: String);
    function GetName(): String;
    property Name: String read GetName write SetName;
  end;

  IContactableEntity = interface(IBaseNamedEntity)
    procedure SetEMail(val: String);
    function GetEMail(): String;
    property EMail: String read GetEMail write SetEMail;
    procedure SetPhone(val: String);
    function GetPhone(): String;
    property Phone: String read GetPhone write SetPhone;
  end;

  IBaseCompany = interface(IContactableEntity)
    procedure SetAddress(val: string);
    function GetAddress(): string;
    property Address: string read GetAddress write SetAddress;
    procedure SetCity(val: string);
    function GetCity(): string;
    property City: string read GetCity write SetCity;
    procedure SetPostalCode(val: string);
    function GetPostalCode(): string;
    property PostalCode: string read GetPostalCode write SetPostalCode;
    procedure SetNation(val: string);
    function GetNation(): string;
    property Nation: string read GetNation write SetNation;
    procedure SetProvince(val: string);
    function GetProvince(): string;
    property Province: string read GetProvince write SetProvince;
  end;

  IBaseSession = interface
    function GetCompany(): IBaseCompany;
    property Company: IBaseCompany read GetCompany;
    function GetToken(): String;
    property Token: String read GetToken;
    /// <semantics>Questo metodo della sessione opera il Logout usando l'oggetto IBaseLogin embeddato al suo interno durante la sua creazione</semantics>
    procedure Logout;
    function GetUser(): IBaseUser;
    property User: IBaseUser read GetUser;
  end;

  TUserPermission = (urReadOnly, urReadWrite, urSuperUser);

  IBaseUser = interface(IContactableEntity)
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

  IBaseLogin<T: IBaseSession> = interface
    procedure Logout;
    function GetState(): TLoginState;
    property State: TLoginState read GetState;
    /// <semantics>Effettua il login e restituisce l'oggetto sessione di tipo T</semantics>
    function Login: T;
    procedure SetPassword(const val: String);
    function GetPassword(): String;
    property Password: String read GetPassword write SetPassword;
    procedure SetUserName(const val: String);
    function GetUserName(): String;
    property UserName: String read GetUserName write SetUserName;
  end;

implementation

end.
