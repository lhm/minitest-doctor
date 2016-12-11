$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "minitest/doctor"

class SimpleCheck < Minitest::Doctor::Checkup
  def check_doctor_version
    return if Gem::Version.new(Minitest::Doctor::VERSION) > Gem::Version.new("1.0.0")
    "Doctor gem version is < 1.0.0 - it's still in early development. "
  end

  def check_if_on_master_branch
    branch = `git symbolic-ref --short HEAD`.chomp
    return if branch == "master"
    %(You're not on the master branch, current branch is "#{branch}".)
  end

  def check_rubocop_offenses
    files = `rubocop -ffi -n`
    return nil if $?.success?
    <<~EOS
      Seems there are some rubocop warnings in these files:
      #{indent(files)}
    EOS
  end

  def indent(str, count = 2)
    (" " * count) + str.gsub(/(\n+)/) { $1 + (" " * count) }
  end
end

reporter = Minitest::Doctor::CheckupReporter.new
SimpleCheck.run(reporter)
reporter.report
