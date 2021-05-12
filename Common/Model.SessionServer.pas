unit Model.SessionServer;

interface

type
  ISessionServer = interface
    procedure SessionDispose(const AlicenseID, ASessionID: Integer);
    function SessionPoll(const AlicenseID, ASessionID: Integer; const AActivationKey, AHWSign: string; const AUserName: string = '';
      const APassword: string = ''): string;
    function SessionNew(const AlicenseID: Integer; const AActivationKey, AHWSign: string; const AUserName: string = ''; const APassword: string = ''): string;
  end;

implementation

end.
