class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.length - @text.count("\r\n") - @text.count(" ")

    @word_count = @text.split.size

    @occurrences = @text.downcase.scan(@special_word.downcase).length

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = @principal * ((@apr/1200)/(1 - (1+@apr/1200)** -(@years*12)))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = (@ending - @starting).to_i
    @minutes = ((@ending - @starting)/60).to_f
    @hours = ((@ending - @starting)/3600).to_f
    @days = ((@ending - @starting)/(3600*24)).to_f
    @weeks = ((@ending - @starting)/(3600*168)).to_f
    @years = ((@ending - @starting)/(3600*24*365)).to_f

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    @median =  (@sorted_numbers[(@count - 1) / 2] + @sorted_numbers [@count / 2]) / 2.0

    @sum = @numbers.sum

    @mean = @sum/ @count

    @variance = (@numbers.inject(0.0) {|s,x| s + (x - @mean)**2})/(@count).to_f

    @standard_deviation = @variance.to_f ** (0.5)

    @mode = @numbers.uniq.max_by{ |i| @numbers.count( i ) }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
