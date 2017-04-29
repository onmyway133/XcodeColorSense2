import Foundation

struct HSL: Equatable {
  let h: Float
  let s: Float
  let l: Float
}

func == (lhs: HSL, rhs: HSL) -> Bool {
  return lhs.h == rhs.h
    && lhs.s == rhs.s
    && lhs.l == rhs.l
}
