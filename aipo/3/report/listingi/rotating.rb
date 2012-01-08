def rotating(i, j, kat)
  [
    ( Math.cos(kat)*i-Math.sin(kat)*j ).to_i,
    ( Math.sin(kat)*i+Math.cos(kat)*j ).to_i,
  ]
end
