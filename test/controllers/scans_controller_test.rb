require 'test_helper'

class ScansControllerTest < ActionDispatch::IntegrationTest
  include ScanRelatedConcerns

  test "should get demo" do
    get scans_demo_url
    assert_response :success
  end


  # ScanRelatedConcerns Test
  test 'pg result to array mock data check' do
    expected = 750
    result_array = pg_result_obj
    assert_equal expected, result_array.count
  end

  test 'slice records match expected count' do
    records = pg_result_obj
    count = records.to_a.count
    slice_data = split_records records, 250
    assert_equal 750, count
    assert_equal 3, slice_data.count
  end

  test 'most recent data point represents max value over 250 periods' do
    years_data = year_of_data
    years_data.first["volume"] = 10_000
    years_data.last["volume"]= 10_0001
    result = most_recent_record_max_high? years_data, 'volume'
    assert_equal true, result
  end

  test 'most recent data point does not represent max value over 250 periods' do
    years_data = year_of_data
    years_data.first['volume'] = 10_000
    result = most_recent_record_max_high? years_data, 'volume'
    assert_equal false, result
  end

  test 'midpoint represents highest data point over 250 periods' do
    years_data = year_of_data
    years_data[125]['volume'] = 10_000
    result = most_recent_record_max_high? years_data, 'volume'
    assert_equal false, result
  end
end
