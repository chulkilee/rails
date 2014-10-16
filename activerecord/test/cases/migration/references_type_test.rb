require 'cases/helper'

module ActiveRecord
  class Migration
    class ReferencesTypeTest < ActiveRecord::TestCase
      attr_reader :connection, :table_name

      def setup
        super
        @connection = ActiveRecord::Base.connection
        @table_name = :testings
      end

      def teardown
        super
        connection.drop_table :testings rescue nil
      end

      def test_default_type
        connection.create_table table_name do |t|
          t.references :foo
        end

        assert connection.column_exists?(table_name, :foo_id, :integer)
      end

      def test_custom_type
        connection.create_table table_name do |t|
          t.references :foo, type: :string
        end

        assert connection.column_exists?(table_name, :foo_id, :string)
      end
    end
  end
end
