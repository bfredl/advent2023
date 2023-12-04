let data = open input.txt | lines
let rawitems = $data | parse 'Card {num}: {drawn} | {ours}'
let items = $rawitems | each { |it| {drawn: ($it.drawn | str trim | split row -r '\s+' | into int) ours: ($it.ours | str trim | split row -r '\s+' | into int) } }
let counts = $items | each { |it|  $it.ours | each { |x| $it.drawn | find $x | length } | math sum}
echo $counts | each { |x| if ($x > 0) { 2 ** ($x - 1) } else { 0 } } | math sum
