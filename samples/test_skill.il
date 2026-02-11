procedure(myAdd a b
  return(a + b)
)

let((x y)
  x = 10
  y = 32
  when(x < y
    printf("x=%d y=%d\n" x y)
  )
)

setq(items list(1 2 3 4))
foreach(item items
  printf("item=%d\n" item)
)
