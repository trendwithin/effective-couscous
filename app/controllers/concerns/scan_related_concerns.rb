module ScanRelatedConcerns
  extend ActiveSupport::Concern

  def split_records records, period
    records.each_slice(period).to_a
  end

  def most_recent_record_max_high? records, field
    dupe = records.dup
    first_value = records.first["#{field}"]
    last_value = records.last["#{field}"]
    last_bool = dupe.max_by{ |k| k["#{field}"] }["#{field}"] == dupe.last["#{field}"]
    dupe.pop
    first_bool = dupe.max_by { |k| k["#{field}"]}["#{field}"] == dupe.first["#{field}"]
    last_bool && first_bool
  end
end
