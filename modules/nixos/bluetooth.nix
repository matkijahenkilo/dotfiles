{ ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      experimental = true;
      JustWorksRepairing = "always";
      FastConnectable = true;
    };
  };

  # unfuck rumble for xbox controllers
  hardware.xpadneo.enable = true;
  environment.variables = {
    SDL_JOYSTICK_HIDAPI = 0;
  };
}
