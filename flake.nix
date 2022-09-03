{
  inputs = {
    haedosa.url = "github:haedosa/flakes";
    nixpkgs.follows = "haedosa/nixpkgs";
    dream2nix.url = "github:nix-community/dream2nix";
    src.url = "https://registry.npmjs.org/speedscope/-/speedscope-1.14.0.tgz";
    src.flake = false;
  };

  outputs = {
    self,
    dream2nix,
    src,
    ...
  } @ inp:
    (dream2nix.lib.makeFlakeOutputs {
      systems = ["x86_64-linux"];
      config.projectRoot = ./.;
      source = src;
      settings = [
        {
          subsystemInfo.noDev = true;
          subsystemInfo.nodejs = 18;
        }
      ];
    })
    // {
      checks = self.packages;
    };
}
