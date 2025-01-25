# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :ips do
      primary_key :id
      column :ip, :inet, null: false, unique: true
      column :enabled, TrueClass, default: false, null: false
      column :created_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
      column :updated_at, DateTime, null: false, default: Sequel::CURRENT_TIMESTAMP
    end

    run <<~SQL
      CREATE INDEX ips_ip_index ON ips USING gist (ip inet_ops);
    SQL
  end
end
