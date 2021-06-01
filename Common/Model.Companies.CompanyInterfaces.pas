unit Model.Companies.CompanyInterfaces;

interface

uses
  Model.Base.BaseInterfaces;

type
  ISWHouseOperator = interface(IBaseUserWithPermissions)
    procedure SetSWHouseID(val: Integer);
    function GetSWHouseID(): Integer;
    property SWHouseID: Integer read GetSWHouseID write SetSWHouseID;
  end;

  ISWHouseCompany = interface(IBaseCompany)
  end;

  ISWHouseFrontEndSession = interface(IBaseFrontEndSession<Model.Companies.CompanyInterfaces.ISWHouseCompany,
    Model.Companies.CompanyInterfaces.ISWHouseOperator>)
  end;

  IMasterCompany = interface(IBaseCompany)
  end;

  IMasterCompanyOperator = interface(IBaseUserWithPermissions)
    procedure SetMasterCompanyID(val: Integer);
    function GetMasterCompanyID(): Integer;
    property MasterCompanyID: Integer read GetMasterCompanyID write SetMasterCompanyID;
  end;

  IMasterCompanyFrontEndSession = interface(IBaseFrontEndSession<Model.Companies.CompanyInterfaces.IMasterCompany,
    Model.Companies.CompanyInterfaces.IMasterCompanyOperator>)
  end;

  IEndCustomerCompany = interface(IBaseCompany)
  end;

implementation

end.
