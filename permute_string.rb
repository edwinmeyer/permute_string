# Given an input alphabetic string of arbitrary length generate an array containing all possible 
# string permutations produced by swapping the case of the individual alpha characters.

# Two solutions are provided and tested using Ruby 2.2. One generates permutations using recursion; the other by iteration.
# Note: This program may not run using earlier Ruby versions.

def permute_string_recurse(input)
  
  return [] unless input && input.length > 0 # empty input base case
  return [input.downcase, input.upcase] if input.length==1 # single char case

  # input.len > 1 case
  output = []
  [input[0].downcase, input[0].upcase].each do |s0| 
    output << permute_string_recurse(input[1..input.length-1]).map { |ps| s0+ps}
  end  
  
  output.flatten!
end

def permute_string_iterate(input)
  
  output = [input]
  (0...input.length).each do |idx|    
    output_swap = output.map {|s| s_dup = s.dup; s_dup[idx] = s_dup[idx].swapcase; s_dup}
    output = output + output_swap 
  end
  output
end

# Test Mini-Framework
# Two methods -- permute_string_recurse & permute_string_iterate -- are tested.
# The sole argument to each is the string which is to be permuted

input = "aBcDe"
ps_msg = {}; ps_output = {}

[:permute_string_recurse, :permute_string_iterate].each do |ps_method|
  output = ps_output[ps_method] = send(ps_method, input)
  puts %Q{\n#{ps_method}("#{input}") = \n #{output}}

  input_len = input.length
  expected_output_len = 2**input_len
  expected_elems = output.length==expected_output_len
  output_uniq_length = output.uniq.length
  unique_elems = output_uniq_length==expected_output_len
  ps_msg[ps_method] = "\n#{ps_method} - #{expected_elems && unique_elems ? 'SUCCESS' : 'FAILURE'}:\n" + 
    "Expected #{expected_output_len} elements for #{input_len} character input string. Actual = #{output.length}\n" +
     "Expected #{expected_output_len} unique elements for #{input_len} character input string; Actual = #{output_uniq_length}"
end

[:permute_string_recurse, :permute_string_iterate].each do |ps_method|
  puts ps_msg[ps_method]
end  

psr_psi_match = ps_output[:permute_string_recurse].sort == ps_output[:permute_string_iterate].sort

puts "\n#{psr_psi_match ? 'SUCCESS' : 'FAILURE'}: Permuted outputs by recursive and iterative methods " +
  "#{psr_psi_match ? '' : 'DO NOT '}match when sorted"

