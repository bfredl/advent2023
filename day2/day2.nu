let data = open input.txt | lines | parse 'Game {id}: {draws}'
let rawdraws = $data | get draws | each { split row ";" }
let draws = $rawdraws | each {each { str trim | split row ", "} | each { parse "{num} {name}" | select name num | transpose -rd | default "0" green | default "0" red | default "0" blue } | update cells {into int} }
let overflows = $draws | each { filter { |row| $row.red > 12 or $row.green > 13 or $row.blue > 14 }  | length }
let $result = $overflows | wrap num | merge ( $data | get id | into int | wrap id ) | filter { |g| $g.num == 0} | get id | math sum

echo $result

let $part2 = $draws | each { math max | transpose -i | get column0 | math product } | math sum;
echo $part2
