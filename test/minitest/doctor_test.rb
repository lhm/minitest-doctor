require "test_helper"

class TestCheckup < Minitest::Doctor::Checkup
  def check_warning
    "This is a warning"
  end

  def check_ok
    return nil if true
    "This is ok"
  end
end

class Minitest::DoctorTest < Minitest::Test
  def setup
    @output = StringIO.new
    @reporter = Minitest::Doctor::Reporter.new(@output)
    TestCheckup.run(@reporter)
    @reporter.report
  end

  def test_run_reports_warning_message
    assert_match "This is a warning", @output.string
  end

  def test_run_reports_nothing_when_ok
    refute_match "This is ok", @output.string
  end
end
