n = 10
until n.to_s == n.to_s.reverse && n.to_s(2) == n.to_s(2).reverse && n.to_s(8) == n.to_s(8).reverse; n += 1; end
puts n, n.to_s(2), n.to_s(8)
