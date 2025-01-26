# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :ip_checks do
      primary_key :id
      foreign_key :ip_id, :ips, on_delete: :cascade, null: false
      column :rtt, Float, null: true
      column :checked_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end
