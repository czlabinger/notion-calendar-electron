{ self }:
[
  (final: prev: {
    notion-calendar-electron = self.packages.${prev.system}.default;
  })
]
