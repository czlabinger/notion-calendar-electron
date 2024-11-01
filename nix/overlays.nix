{ self }: {
  # Export a single overlay instead of a list
  overlay = final: prev: {
    notion-calendar-electron = self.packages.${prev.system}.default;
  };
}
