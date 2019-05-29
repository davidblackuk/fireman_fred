# TODOS

+ JUMP NOT TESTING ABOVE FOR BLOCKERS
+ jump still very 45 degrees
+ implement ladder climb
+ special case / restore ladder attributes at end of render to prevent conflicts?
+ optimization - we calculate Fred's pixel and char y serveral times per loop, should this be done once and stored.

## Done

+ Remove attributes from Fred and use environmental colors
  + added flag `sprite_no_attrs` to the sprite definition and engine. This flag omits the rendering of attribute. It still saves and restores them to keep the timing as close as possible for all sprites.
  + It also makes the game way better as Fred's colors don't bleed al over the game
+ JUMP gets caught on the middle of blocks!
  + implemented modulo 32 test on the row y for Fred
