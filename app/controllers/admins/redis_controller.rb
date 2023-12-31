# app/controllers/redis_controller.rb

require 'redis'

class Admins::RedisController < ApplicationController
  layout 'admins'

  def show
    @page = params[:page].to_i || 0
    @keys = paginate_redis_keys(@page)
    @values = @keys.map { |key| fetch_value_for_key(key) }
  end

  private

  def paginate_redis_keys(page, per_page = 100)
    start = page * per_page
    cursor = start == 0 ? "0" : start.to_s
    result = $redis.scan(cursor, count: per_page)

    # Fetch keys in the range
    result[1]
  end

  def fetch_value_for_key(key)
    case $redis.type(key)
    when "string"
      $redis.get(key)
    when "list"
      $redis.lrange(key, 0, -1)
    when "set"
      $redis.smembers(key)
    when "hash"
      $redis.hgetall(key)
    when "zset"
      $redis.zrange(key, 0, -1)
    else
      "Unsupported key type"
    end
  end

end
