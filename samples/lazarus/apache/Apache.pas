Library Apache;

{$MODE DELPHI}{$H+}

Uses
{$ifdef unix}
  cthreads,
{$endif}
  Horse, httpd;

const
  ModuleName = 'apache_horse_module';

var
  ApacheModuleData : module; {$ifdef unix} public name ModuleName;{$endif unix}

exports ApacheModuleData name ModuleName;

procedure GetPing(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
begin
  Res.Send('pong');
end;

begin

  THorse.DefaultModule := ApacheModuleData;
  THorse.HandlerName := 'apache_horse_module-handle';
  THorse.ModuleName := ModuleName;

  THorse.Get('/ping', GetPing);

  THorse.Listen;

end.

