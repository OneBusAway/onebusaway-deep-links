# frozen_string_literal: true

class FlashComponent < ViewComponent::Base
  def initialize(flash)
    super()
    @flash = flash
  end

  def render?
    @flash.present?
  end

  def class_for(flash_type)
    {
      success: "oba-flash-alert--success",
      error: "oba-flash-alert--danger",
      alert: "oba-flash-alert--warning",
      notice: "oba-flash-alert--info"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end
end
