unit Model.SessionServer;

interface

type
  ISWSessionManager = interface
    function SessionNew(const AActivationKey, AHWSign: string; const AUserName: string = ''; const APassword: string = ''): string;
    function SessionPoll(const ASessionID: Integer; const AActivationKey, AHWSign: string; const AUserName: string = ''; const APassword: string = ''): string;
    procedure SessionDispose(const ASessionID: Integer);
  end;

  ISWSessionServer = interface
    procedure SessionDispose(const AlicenseID, ASessionID: Integer);
    function SessionPoll(const AlicenseID, ASessionID: Integer; const AActivationKey, AHWSign: string; const AUserName: string = '';
      const APassword: string = ''): string;
    function SessionNew(const AlicenseID: Integer; const AActivationKey, AHWSign: string; const AUserName: string = ''; const APassword: string = ''): string;
    function GetLicenses(): TList<ISWLicense>;
    property Licenses: TList<ISWLicense> read GetLicenses;
  end;

implementation

end.
