{ pkgs, ... }:
{
  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    moonlight-qt
    pavucontrol
  ];

  # with default configs, I could hear my own voice in another person's transmission
  # and vice versa.
  # so route the main stuff to "Stream_Audio" in pavucontrol and leave discord alone.
  # in sunshine's web UI https://localhost:47990, set:
  #   audio_sink = stream_audio.monitor
  services.pipewire.extraConfig.pipewire."99-stream-sink"."context.modules" = [
    {
      name = "libpipewire-module-loopback";
      args = {
        "node.description" = "Stream_Audio";
        "capture.props" = {
          "media.class" = "Audio/Sink";
          "node.name" = "stream_audio";
        };
      };
    }
  ];
}
