{ ... }:
{
  config = {
    services.matrix-synapse = {
      enable = true;
      configureRedisLocally = true;
    };
  };
}
