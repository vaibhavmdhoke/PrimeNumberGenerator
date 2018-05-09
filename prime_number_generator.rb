class PrimeNumberGenerator
  attr_accessor :max_limit, :prime_numbers, :prime_numbers_sum

  def initialize(max_limit = 2000_000)
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
  def generate_prime_numbers()
    ## Find n from size
    # size = 2n +2
    n = (max_limit() -2)/2

    array_of_size_n = (1..n).to_a

    temp_array = []
    n.times do |i|
      next if i == 0
      break if i == (n/2)
      n.times do |j|
        next if j == 0
        temp_value =  i + j + (2*i*j)
        if temp_value <= n
          temp_array << temp_value
        else
          break
        end
      end
    end ## end of i
    array_of_size_n -= temp_array

    array_of_size_n.each do |prime_number|
      _prime = ((2 * prime_number) + 1)
      prime_numbers << _prime
      @summation += _prime
      @prime_numbers_sum << @summation if @summation < @max_limit
    end


  end ## End of generate_prime_numbers

  def print_solution_one
    generate_prime_numbers()
    puts '=============================================================================================='
    puts 'Q1:  Find the sum of all the primes below 2 million ?'
    puts "Sol: Summation of all prime numbers below  #{@max_limit} is #{@summation}"
    puts "==============================================================================================\n\n\n"
  end

  # Which prime, below one million, can be written as the sum of the most consecutive primes?
  def consecutive_prime_below_one_million
    @max_limit = 1000_000
    generate_prime_numbers()
    # number_of_primes = 0
    result = 0

    count_prime_sum =  @prime_numbers_sum.length
    number_of_primes = 1
    # i_index = 0
    count_prime_sum.times do |i_index|
      for j in (count_prime_sum - 1).downto(i_index + number_of_primes ) do
        difference = @prime_numbers_sum[j] - @prime_numbers_sum[i_index]
        if  (j - i_index > number_of_primes) && difference < @max_limit &&  ( @prime_numbers.include? difference) #
          number_of_primes, result = j - i_index, difference
          break
        end
      end ## end of j
    end ## end of i

    puts '=============================================================================================='
    puts 'Q2:  Which prime, below one million, can be written as the sum of the most consecutive primes?'
    puts "Sol: Result For Finding consecutive prime below #{@max_limit} : #{result}, and \n     Number of primes in those are #{number_of_primes}"
    puts '=============================================================================================='

  end

end

prime_generator_q1 = PrimeNumberGenerator.new
prime_generator_q1.print_solution_one

prime_generator_q2  = PrimeNumberGenerator.new
prime_generator_q2.consecutive_prime_below_one_million
