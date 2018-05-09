class PrimeNumberGenerator
  attr_accessor :max_limit, :prime_numbers, :prime_numbers_sum

  def initialize(max_limit = 2000_000)
    ##
    @max_limit = max_limit
    @prime_numbers = [2]
    @summation = 2
    @prime_numbers_sum = [0, 2]
  end
  # https://www.hackerrank.com/HACKMEIFUCAN?hr_r=1 My Hacker Rank Profile
  # Sieve of Sundaram (https://en.wikipedia.org/wiki/Sieve_of_Sundaram)
  # If we start with integers from 1 to n, the final list contains only odd integers from 3 to {\displaystyle 2n+1} 2n+1.
  # From this final list, some odd integers have been excluded; we must show these are precisely the composite odd
  # integers less than {\displaystyle 2n+2} 2n + 2.

  # def find_sum_of_prime_numbers
  #   _generate_prime_numbers
  #   summation_of_prime_numbers
  # end
  #
  #
  # private

  def generate_prime_numbers()
    ## Find n from size
    # size = 2n +2
    n = (max_limit() -2)/2
    # start_time = Time.now

    array_of_size_n = (1..n).to_a
    # puts "Time Taken For Array Generation:  #{(Time.now - start_time) * 1000} ms  Sum is #{@summation}"

    # start_time = Time.now
    temp_array = []
    n.times do |i|
      next if i == 0
      break if i == (n/2)
      n.times do |j|
        next if j == 0
        temp_value =  i + j + (2*i*j)
        # generate_array_for_calculating_prime_number <<  temp_value if temp_value <= n
        if temp_value <= n
          temp_array << temp_value
        else
          break
        end
        # puts temp_value
      end
    end ## end of i
    array_of_size_n -= temp_array
    # puts "Time Taken For Sieving:  #{(Time.now - start_time) * 1000} ms Sum is #{@summation}"

    # start_time = Time.now
    array_of_size_n.each do |prime_number|
      prim = ((2 * prime_number) + 1)
      prime_numbers << prim
      @summation += prim
      @prime_numbers_sum << @summation if @summation < @max_limit
    end
    puts "Summation of all prime numbers below  #{@max_limit} is #{@summation}"
  end ## End of generate_prime_numbers

  # Which prime, below one million, can be written as the sum of the most consecutive primes?
  def find_consecutive_prime_below_one_million
    @max_limit = 1000_000
    generate_prime_numbers()
    # number_of_primes = 0
    result = 0

    count_prime_sum =  @prime_numbers_sum.length
    number_of_primes = 1
    i_index = 0
    for i in  @prime_numbers_sum do

      j_index = 0
      for j in (count_prime_sum - 1).downto(i_index + number_of_primes ) do

        difference = @prime_numbers_sum[j] - @prime_numbers_sum[i_index]

        if  (j - i_index > number_of_primes) && difference < @max_limit &&  ( @prime_numbers.include? difference) #
          number_of_primes, result = j - i_index, difference
          break
        end
        j_index += 1
      end ## end of j
      i_index += 1
    end ## end of i

    puts "Result For Finding consecutive prime below #{@max_limit} : #{result}, and \nNumber of primes in those are #{number_of_primes}"
  end

end

# pr = PrimeNumberGenerator.new
# pr.generate_prime_numbers
#
pr = PrimeNumberGenerator.new
pr.find_consecutive_prime_below_one_million
#
# [2,3,7,11,13,17]
# array = []
# Prime.each(1000_000) do |prime|
#   array << prime  #=> 2, 3, 5, 7, 11, ...., 97
# end
# array.inject(:+)
#
#
# array.count
# => 148933
#
# array.inject(:+)
# => 142913828922


