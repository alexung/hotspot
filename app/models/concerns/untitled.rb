vals = [
  [2,0], # adds, dels
  [1,0],
  [0,0],
  [0,1],
  [5,0],
  [0,0],
  [2,6],
  [1,0],
  [15,0],
  [0,3]
]

def render_seg(lines, adds, dels)
  [
    [lines - dels, "L"],
    [adds, "A"],
    [dels, "D"],
    ].
    map { |count, char| render_seg_part(char, count) }.
    join('')
  end

  def render_seg_part(char, count)
    count.times.map{char}.join('')
  end

# vals.reduce([0, []]) { |(lines,segs),(adds,dels)| adds.times.map{'$'}.join('') + dels.times.map{'%'}.join('') ; [lines, segs] }[1]


lines = 0
max_lines = 0
rendered_segments = []

vals.each do |adds, dels|
  rendered_segments << render_seg(lines, adds, dels)
  lines = (lines + adds) - dels
  max_lines = lines if lines > max_lines
end


puts([render_seg(lines, 0,0)]  + rendered_segments.reverse)

puts "max lines", max_lines