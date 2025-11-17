{ ... }:
{
  corto-overlay = final: prev: {
    corto = prev.corto.overrideAttrs (oldAttrs: {
      cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [ "-DCMAKE_POLICY_VERSION_MINIMUM=3.5" ];
    });
  };

  meshlab-overlay = final: prev: {
    meshlab = prev.meshlab.overrideAttrs (oldAttrs: {
      cmakeFlags = (oldAttrs.cmakeFlags or []) ++ [ "-DCMAKE_POLICY_VERSION_MINIMUM=3.5" ];
    });
  };
}