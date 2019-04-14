module OBAErrors
  class EmptyServerResponse < StandardError ; end
  class PastDueAlarmTriggeredError < StandardError ; end
end