require 'gtfs-realtime.pb.rb'

class GtfsMapper  
  GTFS_REALTIME_VERSION = "1.0".freeze

  def self.pb_english_translated_string(string)
    translation = TransitRealtime::TranslatedString::Translation.new({
      text: string,
      language: 'en'
    })
    
    ts = TransitRealtime::TranslatedString.new
    ts.translation = [translation]
    
    return ts
  end
  
  def self.alert_feed_item_to_pb_alert(alert)
    pb_alert = TransitRealtime::Alert.new

    pb_alert.informed_entity = [TransitRealtime::EntitySelector.new(agency_id: alert.alert_feed.agency_id)]
    
    pb_alert.url = pb_english_translated_string(alert.url)
    pb_alert.header_text = pb_english_translated_string(alert.title)
    pb_alert.description_text = pb_english_translated_string(alert.summary)
    
    return pb_alert

    # Currently unsupported on the obaco side:
    # repeated ::TransitRealtime::TimeRange, :active_period, 1
    # optional ::TransitRealtime::Alert::Cause, :cause, 6, :default => ::TransitRealtime::Alert::Cause::UNKNOWN_CAUSE
    # optional ::TransitRealtime::Alert::Effect, :effect, 7, :default => ::TransitRealtime::Alert::Effect::UNKNOWN_EFFECT
  end
  
  def self.alerts_to_pb_message(alerts, timestamp)
    feed_message = TransitRealtime::FeedMessage.new
    
    feed_message.header = TransitRealtime::FeedHeader.new(gtfs_realtime_version: GTFS_REALTIME_VERSION, timestamp: timestamp)
    
    feed_message.entity = alerts.map do |a|
      TransitRealtime::FeedEntity.new({
        id: "#{a.class.to_s}_#{a.id}",
        alert: alert_feed_item_to_pb_alert(a)
      })
    end
    
    return feed_message
  end
end

class ProtocolBuffers::Message

  def to_json(*args)
    hash = {'json_class' => self.class.name}

    # simpler version, includes all fields in the output, using the default
    # values if unset. also includes empty repeated fields as empty arrays.
    # fields.each do |tag, field|
    #   hash[field.name] = value_for_tag(field.tag)
    # end

    # prettier output, only includes non-empty repeated fields and set fields
    fields.each do |tag, field|
      if field.repeated?
        value = value_for_tag(field.tag)
        hash[field.name] = value unless value.empty?
      else
        hash[field.name] = value_for_tag(field.tag) if value_for_tag?(field.tag)
      end
    end
    hash.to_json(*args)
  end

  def self.json_create(hash)
    hash.delete('json_class')

    # initialize takes a hash of { attribute_name => value } so you can just
    # pass the hash into the constructor. but we're supposed to be showing off
    # reflection, here. plus, that raises an exception if there is an unknown
    # key in the hash.
    # new(hash)

    message = new
    fields.each do |tag, field|
      if value = hash[field.name.to_s]
        message.set_value_for_tag(field.tag, value)
      end
    end
    message
  end
end