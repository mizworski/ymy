instance Eq Type where
  Tany == _ = True
  _ == Tany = True
  Tunit == Tunit = True
  Tint == Tint = True
  Tbool == Tbool = True
  Tstring == Tstring = True
  Tinvalid == Tinvalid = True
  (Tarray t1) == (Tarray t2) = t1 == t2
  (Tfun f1 f2) == (Tfun g1 g2) = (f1 == g1) && (f2 == g2)
  (Tfunarg f1 f2) == (Tfunarg g1 g2) = (f1 == g1) && (f2 == g2)
  _ == _ = False
