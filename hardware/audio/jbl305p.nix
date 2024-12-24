{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  services.pipewire.enable = true;
  services.pipewire.extraConfig.pipewire = {
    "10-equalizer" = {
      "context.modules" = [
        {
          name = "libpipewire-module-filter-chain";
          args = {
            "node.description" = "JBL 305p Equalizer Sink";
            "media.name" = "JBL 305p Equalizer Sink";
            "filter.graph" = {
              nodes = [
                {
                  type  = "builtin";
                  name  = "eq_band_1";
                  label = "bq_peaking";
                  control = { 
                    Freq = 51.6;
                    Q = 7.370; 
                    Gain = -6.20;
                  };
                }
                {
                  type = "builtin";
                  name = "eq_band_2";
                  label = "bq_peaking";
                  control = { Freq = 62.0; Q = 7.355; Gain = -8.40; };
                }
                {
                  type = "builtin";
                  name = "eq_band_3";
                  label = "bq_peaking";
                  control = { Freq = 72.5; Q = 7.325; Gain = 5.90; };
                }
                {
                  type = "builtin";
                  name = "eq_band_4";
                  label = "bq_peaking";
                  control = { Freq = 76.4; Q = 13.606; Gain = -8.40; };
                }
                {
                  type = "builtin";
                  name = "eq_band_5";
                  label = "bq_peaking";
                  control = { Freq = 114.0; Q = 5.372; Gain = -21.40; };
                }
                {
                  type = "builtin";
                  name = "eq_band_6";
                  label = "bq_peaking";
                  control = { Freq = 165.5; Q = 9.426; Gain = -15.10; };
                }
                {
                  type = "builtin";
                  name = "eq_band_7";
                  label = "bq_peaking";
                  control = { Freq = 185.0; Q = 2.286; Gain = 10.00; };
                }
                {
                  type = "builtin";
                  name = "eq_band_8";
                  label = "bq_peaking";
                  control = { Freq = 198.5; Q = 14.771; Gain = -17.20; };
                }
                {
                  type = "builtin";
                  name = "eq_band_9";
                  label = "bq_peaking";
                  control = { Freq = 236.0; Q = 4.954; Gain = -7.40; };
                }
                {
                  type = "builtin";
                  name = "eq_band_10";
                  label = "bq_peaking";
                  control = { Freq = 279.0; Q = 4.936; Gain = -5.80; };
                }
              ];
              links = [
                { output = "eq_band_1:Out"; input = "eq_band_2:In"; }
                { output = "eq_band_2:Out"; input = "eq_band_3:In"; }
                { output = "eq_band_3:Out"; input = "eq_band_4:In"; }
                { output = "eq_band_4:Out"; input = "eq_band_5:In"; }
                { output = "eq_band_5:Out"; input = "eq_band_6:In"; }
                { output = "eq_band_6:Out"; input = "eq_band_7:In"; }
                { output = "eq_band_7:Out"; input = "eq_band_8:In"; }
                { output = "eq_band_8:Out"; input = "eq_band_9:In"; }
                { output = "eq_band_9:Out"; input = "eq_band_10:In"; }
              ];
            };
            "audio.channels" = 2;
            "audio.position" = [ "FL" "FR" ];
            "capture.props" = {
              "node.name" = "effect_input.eq10";
              "media.class" = "Audio/Sink";
            };
            "playback.props" = {
              "node.name" = "effect_output.eq10";
              "node.passive" = true;
            };
          };
        }
      ];
    };
  };
}