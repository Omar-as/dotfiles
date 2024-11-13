{
  ...
}: {

  # Low Power Enable
  services.upower = {
    enable = true;
    usePercentageForPolicy = true;
    percentageLow = 10;
    percentageCritical = 5;
    percentageAction = 5;
    criticalPowerAction = "Hibernate";
  };

}
