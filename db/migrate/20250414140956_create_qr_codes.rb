class CreateQrCodes < ActiveRecord::Migration[8.0]
  def change
    create_table :qr_codes do |t|
      t.timestamps
    end
  end
end
