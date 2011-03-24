# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  
  #Triangles require that the sum of two sides is less than the remaining side
  if a+b <= c || a+c <= b || c+b <= a
    raise TriangleError, "Tryangle again."
  end
  
  # Why didn't OR statement work here? Why can't we ask, if A or B or C == 0 raise -- how to say this?
  if a == 0 && b == 0 && c == 0
    raise TriangleError, "Tryangle again."
  end
  
  if a == b && a == c && b == c
    return :equilateral
  end
  
  if a == b && a != c || c == b && c != a || a == c && a != b
    return :isosceles
  end
  
  if a != b && a != c && b != c
    return :scalene
  end
end

class TriangleError < StandardError
end
