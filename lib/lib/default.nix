{ self, resolver, std, nixpkgs }: {
  supportedSystems = let
    inherit (nixpkgs.lib.systems) doubles supported;
    tier1 = supported.tier1;
    tier2 = tier1 ++ supported.tier2;
    tier3 = tier2 ++ supported.tier3;
    # TODO: inline to avoid nixpkgs dependency
  in doubles // {
    supported = supported.hydra;
    inherit tier1 tier2 tier3;
  };

  callFlake = import ./callflake.nix { inherit self resolver std; };
}