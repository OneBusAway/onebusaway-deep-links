module CsvHelper
  # Checks if the specified column in the given CSV string has a value
  # in the last row of data.
  #
  # @param csv [String] The CSV formatted string containing multiple rows of data.
  # @param column_name [String] The name of the column to check for values.
  # @return [Boolean] Returns true if the value in the specified column of the last
  # row is present (not nil or empty); returns false if the column does not exist
  # or if the value is absent.
  def check_column_value_exists?(csv, column_name)
    csv_lines = csv.split("\n")
    header = csv_lines.first.split(',')

    column_index = header.index(column_name)
    return false unless column_index

    value = csv_lines.last.split(',')[column_index]
    !value.nil? && !value.empty?
  end
end
