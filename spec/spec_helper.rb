require 'open3'
require 'rspec/expectations'

  # return true if the environment variable DEBUG indicates that debugging output is desired.   (Any value for DEBUG,
  # other than a case-insensitive 'false' or 'no' is considered a request for debug information.)
  def debug_mode?
    @debug_mode ||= ENV.key?('DEBUG') && (ENV['DEBUG'].casecmp('false') != 0) && (ENV['DEBUG'].casecmp('no') != 0)
  end

  def c4_exec
    @c4_exec ||= ENV.key?('C4_EXEC') ? ENV['C4_EXEC'] : './runC4'
  end

RSpec::Matchers.define :declare_win_for do |expected|
  match do |actual|
    actual[:winner].to_i == expected.to_i
  end
  failure_message do |actual|
      if (actual[:quit])
        "Expected player #{expected} to win, but game was abandoned. Last line was \"#{actual[:last_line]}\""
      else
        "Expected player #{expected} to win, but player #{actual[:winner]} won. Last line was \"#{actual[:last_line]}\""
      end
  end
end

RSpec::Matchers.define :be_abandoned do |expected|
  match do |actual|
    (!actual.has_key?(:winner) || actual[:winner].to_i == -1) && actual[:quit]
  end
  failure_message do |actual|
    if actual.has_key?(:winner) && actual[:winner].to_i != -1
      "Game appears to have been won by #{actual[:winner]}"
    elsif !actual[:quit]
      "Game was not abandoned. (Perhaps it crashed?)"
    else
      "I'm not sure what's going on here #{actual.inspect}"
    end
  end
end


# Run the specified command, pass it the given input, then return the output, standard out, and exit values
def run(command_line, input)
    Open3.popen3(command_line) do |i, o, e, t|
        i.puts input
        i.close 
      out_reader = Thread.new { o.read }
      err_reader = Thread.new { e.read }

      out_reader.join
      err_reader.join

      # if wait_thread is nil, then we are running a ruby version of 1.8 or older.
      if t.nil?
        abort("This function requires Ruby 1.9 or above.  (popen3 doesn't work as expected in Ruby 1.8 or lower.)")
      end

      { out: out_reader.value, err: err_reader.value, exit: t.value.exitstatus }
    end # popen3 block
  end # run

def test_c4(input, num_rows=6, num_columns=7, win_length=4)
  if (num_rows.nil?)
    command = "#{c4_exec}"
  elsif (win_length.nil?)
    command = "#{c4_exec} #{num_rows}x#{num_columns}"
  else
    command = "#{c4_exec} #{num_rows}x#{num_columns} #{win_length}"
  end
  
    input_with_newlines = input.chars.join("\n")
    
    puts "Running =>#{command}<= with =>#{input}<=" if debug_mode?
    results = run(command, input_with_newlines)
    puts "Observed out: #{results[:out]}" if debug_mode?
    puts "Observed error: #{results[:err]}" if debug_mode?

    # grab the last line
    last_line = results[:out].split("\n").last
    if last_line =~ /Congratulations,\s+Player\s+(\d+).\s+You Win.$/i
      return {winner: $1.to_i, quit: false, last_line: last_line}
    end

    if last_line =~ /Goodbye/
      return {quit: true, last_line: last_line}
    end  

    {winner: -999, quit: false, last_line: last_line}
   end