class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :guests, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  # 泊数
  def nights
    return 0 unless check_in && check_out
    (check_out - check_in).to_i
  end

  # 合計金額
  def total_amount
    nights * guests * room.price
  end

  private

  def check_in_must_be_today_or_later
    return if check_in.blank?
    if check_in < Date.current
      errors.add(:check_in, "は今日以降の日付を指定してください")
    end
  end

  def check_out_must_be_after_check_in
    return if check_in.blank? || check_out.blank?
    if check_out <= check_in
      errors.add(:check_out, "はチェックイン日より後の日付を指定してください")
    end
  end

end