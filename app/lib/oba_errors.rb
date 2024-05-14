class OBAErrors < StandardError
  class EmptyServerResponse < StandardError ; end
  class PastDueAlarmTriggeredError < StandardError ; end
end